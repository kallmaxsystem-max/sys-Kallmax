from flask import render_template, request, redirect, url_for, session, flash
from . import auth_bp
import mysql.connector
from mysql.connector import Error
import hashlib
from datetime import datetime
from app.config import DatabaseConfig

def get_db_connection():
    """Crear conexión a la base de datos usando configuración desde .env"""
    try:
        connection = mysql.connector.connect(**DatabaseConfig.get_connection_params())
        return connection
    except Error as e:
        print(f"Error de conexión: {e}")
        return None

def hash_password(password):
    """Encriptar contraseña usando SHA-256"""
    return hashlib.sha256(password.encode()).hexdigest()

def validate_user(usuario, password):
    """Validar credenciales de usuario usando Stored Procedure sp_AutenticarUsuario"""
    connection = get_db_connection()
    if not connection:
        return None
    
    try:
        cursor = connection.cursor(dictionary=True)
        
        # Encriptar la contraseña
        password_hash = hash_password(password)
        
        # Llamar al SP sp_AutenticarUsuario que maneja todo en la BD:
        # - Obtiene información del usuario
        # - Valida contraseña
        # - Registra el login (exitoso o fallido)
        # - Bloquea si hay 5+ intentos fallidos
        # - Retorna todos los datos necesarios
        
        query = """
            CALL sp_AutenticarUsuario(
                %s,  -- p_usuario
                %s,  -- p_password_hash
                @p_autenticado,
                @p_num_documento,
                @p_rol,
                @p_estado,
                @p_nombres,
                @p_apellido_paterno,
                @p_apellido_materno,
                @p_email,
                @p_area,
                @p_cargo,
                @p_mensaje
            );
            
            SELECT 
                @p_autenticado as autenticado,
                @p_num_documento as num_documento,
                @p_rol as rol,
                @p_estado as estado,
                @p_nombres as nombres,
                @p_apellido_paterno as apellido_paterno,
                @p_apellido_materno as apellido_materno,
                @p_email as email,
                @p_area as area,
                @p_cargo as cargo,
                @p_mensaje as mensaje
        """
        
        cursor.execute(query, (usuario, password_hash))
        
        # Mover al siguiente resultado (SELECT)
        cursor.nextset()
        
        user_result = cursor.fetchone()
        
        if not user_result:
            return None
        
        autenticado = user_result.get('autenticado')
        
        if autenticado == 1:
            # Autenticación exitosa
            return {
                'num_documento': user_result['num_documento'],
                'usuario': usuario,
                'rol': user_result['rol'],
                'nombres': user_result['nombres'],
                'apellido_paterno': user_result['apellido_paterno'],
                'apellido_materno': user_result['apellido_materno'],
                'email': user_result['email'],
                'area': user_result['area'],
                'cargo': user_result['cargo']
            }
        else:
            # Autenticación fallida - retornar mensaje de error
            return {'error': user_result.get('mensaje', 'Error de autenticación')}
        
    except Error as e:
        print(f"Error en validación: {e}")
        return None
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

@auth_bp.route('/welcome')
def welcome():
    """Página de bienvenida"""
    return render_template('welcome.html')

@auth_bp.route('/proyectos')
def proyectos():
    """Página de proyectos"""
    return render_template('proyectos.html')

@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    """Página de login"""
    if request.method == 'POST':
        usuario = request.form.get('email')  # El campo se llama 'email' en el formulario pero es usuario
        password = request.form.get('password')
        remember = request.form.get('remember')
        
        if not usuario or not password:
            flash('Por favor completa todos los campos', 'error')
            return render_template('login.html')
        
        # Validar credenciales
        result = validate_user(usuario, password)
        
        if result is None:
            flash('Error de conexión con la base de datos', 'error')
            return render_template('login.html')
        
        if 'error' in result:
            flash(result['error'], 'error')
            return render_template('login.html')
        
        # Login exitoso - guardar datos en sesión
        session['user_documento'] = result['num_documento']
        session['user_name'] = f"{result['nombres']} {result['apellido_paterno']}"
        session['user_email'] = result['email']
        session['user_role'] = result['rol']
        session['user_area'] = result['area']
        session['user_cargo'] = result['cargo']
        
        if remember:
            session.permanent = True
        
        flash(f'¡Bienvenido {result["nombres"]}!', 'success')
        return redirect(url_for('main.dashboard'))
    
    return render_template('login.html')

@auth_bp.route('/logout')
def logout():
    """Cerrar sesión"""
    session.clear()
    flash('Sesión cerrada', 'info')
    return redirect(url_for('auth.welcome'))
