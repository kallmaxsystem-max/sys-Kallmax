from flask import render_template, redirect, url_for, session, request, flash
from . import main_bp
import mysql.connector
from mysql.connector import Error
import hashlib
from functools import wraps

# Importar funciones generales
from app.funciones.funGeneral import (
    get_db_connection,
    hash_password,
    get_departamentos as get_departamentos_func,
    get_provincias as get_provincias_func,
    get_distritos as get_distritos_func,
    get_roles as get_roles_func,
    get_areas as get_areas_func,
    get_cargos as get_cargos_func,
    get_fuentes_contacto_api as get_fuentes_contacto_api_func,
    get_proyectos_api as get_proyectos_api_func,
    get_estados_prospeccion_api as get_estados_prospeccion_api_func,
    get_tipos_compra_api as get_tipos_compra_api_func
)

# Importar funciones de usuarios/asesores
from app.funciones.register_user import (
    register_asesor_api as register_asesor_api_func,
    get_usuarios_asesores as get_usuarios_asesores_func,
    get_asesor_by_documento as get_asesor_by_documento_func,
    update_asesor_api as update_asesor_api_func,
    delete_asesor_api as delete_asesor_api_func,
    cambiar_contrasena_api as cambiar_contrasena_api_func,
    buscar_usuario_por_documento as buscar_usuario_por_documento_func
)

# Importar funciones de clientes
from app.funciones.clientes import (
    insertar_cliente_api,
    listar_clientes_api,
    listar_todos_clientes_api,
    eliminar_cliente_api,
    obtener_cliente_por_documento_api,
    actualizar_cliente_api,
    registrar_seguimiento_api,
    listar_seguimientos_cliente_api,
    listar_tipos_seguimiento_api,
    listar_historial_seguimientos_api,
    listar_ultimos_3_seguimientos_api
)

# Decorador para requerir autenticación
def login_required(f):
    """Decorador para proteger rutas que requieren autenticación"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_email' not in session:
            flash('Debes iniciar sesión para acceder a esta página', 'warning')
            return redirect(url_for('auth.login'))
        return f(*args, **kwargs)
    return decorated_function

@main_bp.route('/')
def index():
    """Ruta raíz - redirige a bienvenida si no está autenticado"""
    if 'user_email' in session:
        return redirect(url_for('main.dashboard'))
    return redirect(url_for('auth.welcome'))

@main_bp.route('/dashboard')
@login_required
def dashboard():
    return render_template('dashboard.html')

@main_bp.route('/properties')
@login_required
def properties():
    """Página de gestión de propiedades"""
    return render_template('properties.html')

@main_bp.route('/clients')
@login_required
def clients():
    """Página de gestión de clientes"""
    return render_template('clients.html')

@main_bp.route('/register-user', methods=['GET', 'POST'])
@login_required
def register_user():
    """Página para registrar nuevos usuarios del sistema"""
    if request.method == 'POST':
        # Obtener datos del formulario
        num_documento = request.form.get('num_documento')
        nombres = request.form.get('nombres')
        apellido_paterno = request.form.get('apellido_paterno')
        apellido_materno = request.form.get('apellido_materno')
        email = request.form.get('email')
        celular = request.form.get('celular')
        numero_emergencia = request.form.get('numero_emergencia')
        usuario = request.form.get('usuario')
        password = request.form.get('password')
        id_rol = request.form.get('id_rol')  # Cambiar a id_rol
        
        # Validar que todos los campos estén completos
        if not all([num_documento, nombres, apellido_paterno, email, usuario, password, id_rol]):
            flash('Por favor completa todos los campos requeridos', 'error')
            return render_template('register_user.html')
        
        connection = get_db_connection()
        if not connection:
            flash('Error de conexión con la base de datos', 'error')
            return render_template('register_user.html')
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Verificar si el usuario ya existe
            query_check = "SELECT usuario FROM TblUsuarios WHERE usuario = %s"
            cursor.execute(query_check, (usuario,))
            if cursor.fetchone():
                flash('El usuario ya existe en el sistema', 'error')
                cursor.close()
                connection.close()
                return render_template('register_user.html')
            
            # Verificar si el documento ya existe en TblPersona
            query_check_doc = "SELECT num_documento FROM TblPersona WHERE num_documento = %s"
            cursor.execute(query_check_doc, (num_documento,))
            if cursor.fetchone():
                flash('Este número de documento ya está registrado', 'error')
                cursor.close()
                connection.close()
                return render_template('register_user.html')
            
            # Insertar en TblPersona
            query_persona = """
                INSERT INTO TblPersona (
                    num_documento, nombres, apellido_paterno, apellido_materno,
                    email, celular, numero_emergencia, fecha_creacion, estado
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, NOW(), 'Activo')
            """
            cursor.execute(query_persona, (
                num_documento, nombres, apellido_paterno, apellido_materno,
                email, celular, numero_emergencia
            ))
            
            # Encriptar contraseña
            password_hash = hash_password(password)
            
            # Insertar en TblUsuarios con id_rol (sin campo 'rol' redundante)
            query_usuario = """
                INSERT INTO TblUsuarios (
                    num_documento, usuario, password_hash, id_rol, estado,
                    fecha_creacion, ultimo_acceso, intentos_fallidos
                ) VALUES (%s, %s, %s, %s, 'Activo', NOW(), NULL, 0)
            """
            cursor.execute(query_usuario, (
                num_documento, usuario, password_hash, id_rol
            ))
            
            connection.commit()
            flash(f'¡Usuario {usuario} registrado exitosamente!', 'success')
            cursor.close()
            connection.close()
            return redirect(url_for('main.register_user'))
            
        except Error as e:
            print(f"Error en registro: {e}")
            flash('Error al registrar el usuario', 'error')
            connection.close()
            return render_template('register_user.html')
    
    return render_template('register_user.html')


@main_bp.route('/api/departamentos', methods=['GET'])
@login_required
def get_departamentos():
    """Obtener lista de departamentos"""
    return get_departamentos_func()


@main_bp.route('/api/provincias/<int:id_departamento>', methods=['GET'])
@login_required
def get_provincias(id_departamento):
    """Obtener lista de provincias por departamento"""
    return get_provincias_func(id_departamento)


@main_bp.route('/api/distritos/<int:id_provincia>', methods=['GET'])
@login_required
def get_distritos(id_provincia):
    """Obtener lista de distritos por provincia"""
    return get_distritos_func(id_provincia)


@main_bp.route('/api/register-asesor', methods=['POST'])
@login_required
def register_asesor_api():
    """API para registrar un nuevo asesor desde el modal"""
    return register_asesor_api_func()


@main_bp.route('/api/usuarios-asesores', methods=['GET'])
@login_required
def get_usuarios_asesores():
    """Obtener listado de usuarios asesores con datos personales"""
    return get_usuarios_asesores_func()


@main_bp.route('/api/roles', methods=['GET'])
@login_required
def get_roles():
    """Obtener listado de roles disponibles"""
    return get_roles_func()


@main_bp.route('/api/areas', methods=['GET'])
@login_required
def get_areas():
    """Obtener listado de áreas disponibles"""
    return get_areas_func()


@main_bp.route('/api/cargos', methods=['GET'])
@main_bp.route('/api/cargos/<int:id_area>', methods=['GET'])
@login_required
def get_cargos(id_area=None):
    """Obtener listado de cargos disponibles, opcionalmente filtrados por área"""
    return get_cargos_func(id_area)


@main_bp.route('/api/buscar-usuario', methods=['GET'])
@login_required
def buscar_usuario_por_documento():
    """Buscar usuario por documento (para validación de jerarquía)"""
    return buscar_usuario_por_documento_func()


@main_bp.route('/api/asesor/<num_documento>', methods=['GET'])
@login_required
def get_asesor_by_documento(num_documento):
    """Obtener datos de un asesor específico para edición"""
    return get_asesor_by_documento_func(num_documento)


@main_bp.route('/api/update-asesor', methods=['POST'])
@login_required
def update_asesor_api():
    """API para actualizar un asesor existente"""
    return update_asesor_api_func()

@main_bp.route('/api/delete-asesor/<num_documento>', methods=['DELETE'])
@login_required
def delete_asesor_api(num_documento):
    """API para eliminar un asesor de todas las tablas"""
    return delete_asesor_api_func(num_documento)


@main_bp.route('/api/cambiar-contrasena', methods=['POST'])
@login_required
def cambiar_contrasena_api():
    """API para cambiar contraseña del usuario actual"""
    return cambiar_contrasena_api_func()


# ============================================================================
# RUTAS API PARA GESTIÓN DE CLIENTES
# ============================================================================

@main_bp.route('/api/fuentes-contacto', methods=['GET'])
@login_required
def get_fuentes_contacto():
    """API para obtener lista de fuentes de contacto"""
    return get_fuentes_contacto_api_func()


@main_bp.route('/api/proyectos', methods=['GET'])
@login_required
def get_proyectos():
    """API para obtener lista de proyectos"""
    return get_proyectos_api_func()


@main_bp.route('/api/estados-prospeccion', methods=['GET'])
@login_required
def get_estados_prospeccion():
    """API para obtener lista de estados de prospeccion"""
    return get_estados_prospeccion_api_func()


@main_bp.route('/api/tipos-compra', methods=['GET'])
@login_required
def get_tipos_compra():
    """API para obtener lista de tipos de compra"""
    return get_tipos_compra_api_func()


@main_bp.route('/api/clientes', methods=['POST'])
@login_required
def insertar_cliente():
    """API para insertar un nuevo cliente"""
    return insertar_cliente_api()


@main_bp.route('/api/clientes', methods=['GET'])
@login_required
def listar_clientes():
    """API para listar clientes del asesor logueado"""
    return listar_clientes_api()


@main_bp.route('/api/clientes/todos', methods=['GET'])
@login_required
def listar_todos_clientes():
    """API para listar todos los clientes (administradores)"""
    return listar_todos_clientes_api()


@main_bp.route('/api/clientes/<num_documento>', methods=['DELETE'])
@login_required
def eliminar_cliente(num_documento):
    """API para eliminar un cliente por documento"""
    return eliminar_cliente_api(num_documento)


@main_bp.route('/api/clientes/<num_documento>', methods=['GET'])
@login_required
def obtener_cliente(num_documento):
    """API para obtener un cliente por documento"""
    return obtener_cliente_por_documento_api(num_documento)


@main_bp.route('/api/clientes/<num_documento>', methods=['PUT'])
@login_required
def actualizar_cliente(num_documento):
    """API para actualizar un cliente por documento"""
    return actualizar_cliente_api(num_documento)


# ============================================================================
# RUTAS API PARA GESTIÓN DE SEGUIMIENTOS DE CLIENTES
# ============================================================================

@main_bp.route('/api/seguimientos', methods=['POST'])
@login_required
def registrar_seguimiento():
    """API para registrar un nuevo seguimiento de cliente"""
    return registrar_seguimiento_api()


@main_bp.route('/api/registrar-seguimiento', methods=['POST'])
@login_required
def registrar_seguimiento_endpoint():
    """API para registrar un nuevo seguimiento de cliente (alias)"""
    return registrar_seguimiento_api()


@main_bp.route('/api/seguimientos/<num_documento>', methods=['GET'])
@login_required
def listar_seguimientos(num_documento):
    """API para listar seguimientos de un cliente específico"""
    return listar_seguimientos_cliente_api(num_documento)


@main_bp.route('/api/tipos-seguimiento', methods=['GET'])
@login_required
def listar_tipos_seguimiento():
    """API para listar tipos de seguimiento disponibles"""
    return listar_tipos_seguimiento_api()


@main_bp.route('/api/historial-seguimientos/<num_documento>', methods=['GET'])
@login_required
def obtener_historial_seguimientos(num_documento):
    """API para obtener el historial completo de seguimientos de un cliente usando SP"""
    return listar_historial_seguimientos_api(num_documento)


@main_bp.route('/api/ultimos-3-seguimientos/<num_documento>', methods=['GET'])
@login_required
def obtener_ultimos_3_seguimientos(num_documento):
    """API para obtener los últimos 3 seguimientos de un cliente usando SP"""
    return listar_ultimos_3_seguimientos_api(num_documento)

