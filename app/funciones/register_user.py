#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Funciones relacionadas con la gestión de usuarios y asesores
Endpoint principal: /register-user
"""

from flask import request, jsonify
import mysql.connector
from mysql.connector import Error
import hashlib


def get_db_connection():
    """Crear conexión a la base de datos"""
    try:
        connection = mysql.connector.connect(
            host='209.74.89.191',
            port=3306,
            user='root',
            password='#21592159xD',
            database='KallMax_BD'
        )
        return connection
    except Error as e:
        print(f"Error de conexión: {e}")
        return None


def hash_password(password):
    """Encriptar contraseña usando SHA-256"""
    return hashlib.sha256(password.encode()).hexdigest()


def get_departamentos():
    """Obtener lista de departamentos - SOLO SP (sin respaldo)"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print("DEBUG: Ejecutando SP sp_ObtenerDepartamentos...")
        cursor.execute("CALL sp_ObtenerDepartamentos()")
        departamentos = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        print(f"DEBUG: ✅ Departamentos obtenidos con SP: {len(departamentos)}")
        return {
            'success': True,
            'data': departamentos
        }, 200
        
    except Error as e:
        print(f"❌ ERROR: El SP sp_ObtenerDepartamentos tiene errores: {e}")
        print(f"❌ SOLUCIÓN: Ejecuta actualizar_sps_ubicacion.sql")
        return {'success': False, 'message': f'Error SP: {str(e)}'}, 500


def get_provincias(id_departamento):
    """Obtener lista de provincias - SOLO SP (sin respaldo)"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print(f"DEBUG: Ejecutando SP sp_ObtenerProvincias({id_departamento})...")
        cursor.execute("CALL sp_ObtenerProvincias(%s)", (id_departamento,))
        provincias = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        print(f"DEBUG: ✅ Provincias obtenidas con SP: {len(provincias)}")
        return {
            'success': True,
            'data': provincias
        }, 200
        
    except Error as e:
        print(f"❌ ERROR: El SP sp_ObtenerProvincias tiene errores: {e}")
        print(f"❌ SOLUCIÓN: Ejecuta actualizar_sps_ubicacion.sql")
        return {'success': False, 'message': f'Error SP: {str(e)}'}, 500


def get_distritos(id_provincia):
    """Obtener lista de distritos - SOLO SP (sin respaldo)"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print(f"DEBUG: Ejecutando SP sp_ObtenerDistritos({id_provincia})...")
        cursor.execute("CALL sp_ObtenerDistritos(%s)", (id_provincia,))
        distritos = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        print(f"DEBUG: ✅ Distritos obtenidos con SP: {len(distritos)}")
        return {
            'success': True,
            'data': distritos
        }, 200
        
    except Error as e:
        print(f"❌ ERROR: El SP sp_ObtenerDistritos tiene errores: {e}")
        print(f"❌ SOLUCIÓN: Ejecuta actualizar_sps_ubicacion.sql")
        return {'success': False, 'message': f'Error SP: {str(e)}'}, 500


def get_roles():
    """Obtener listado de roles disponibles"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        query = """
            SELECT id_rol, nombre, descripcion, estado
            FROM TblRol
            WHERE estado = 'Activo'
            ORDER BY id_rol
        """
        
        cursor.execute(query)
        roles = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return {
            'success': True,
            'data': roles,
            'total': len(roles)
        }, 200
        
    except Error as e:
        print(f"Error: {e}")
        return {'success': False, 'message': 'Error al obtener roles'}, 500


def get_areas():
    """Obtener listado de áreas disponibles"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        query = """
            SELECT id_area, nombre, nombre_resumen, descripcion, estado
            FROM TblAreas
            WHERE estado = 'Activo'
            ORDER BY nombre
        """
        
        cursor.execute(query)
        areas = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return {
            'success': True,
            'data': areas,
            'total': len(areas)
        }, 200
        
    except Error as e:
        print(f"Error: {e}")
        return {'success': False, 'message': 'Error al obtener áreas'}, 500


def get_cargos(id_area=None):
    """Obtener listado de cargos disponibles, opcionalmente filtrados por área"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        if id_area:
            query = """
                SELECT c.id_cargo, c.nombre, c.id_area, c.descripcion, a.nombre as area_nombre
                FROM TblCargos c
                INNER JOIN TblAreas a ON c.id_area = a.id_area
                WHERE c.estado = 'Activo' AND c.id_area = %s
                ORDER BY c.nombre
            """
            cursor.execute(query, (id_area,))
        else:
            query = """
                SELECT c.id_cargo, c.nombre, c.id_area, c.descripcion, a.nombre as area_nombre
                FROM TblCargos c
                INNER JOIN TblAreas a ON c.id_area = a.id_area
                WHERE c.estado = 'Activo'
                ORDER BY a.nombre, c.nombre
            """
            cursor.execute(query)
        
        cargos = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return {
            'success': True,
            'data': cargos,
            'total': len(cargos)
        }, 200
        
    except Error as e:
        print(f"Error: {e}")
        return {'success': False, 'message': 'Error al obtener cargos'}, 500


def register_asesor_api():
    """API para registrar un nuevo asesor desde el modal"""
    try:
        # Importar session para obtener el usuario logueado
        from flask import session
        
        data = request.get_json()
        
        print("=" * 80)
        print("DEBUG: Datos recibidos en el servidor:")
        print(data)
        print("=" * 80)
        
        # NUEVO: Obtener documento de jerarquía del formulario
        num_documento_jerarquia = data.get('num_documento_jerarquia', '').strip()
        
        # Si no se proporcionó documento de jerarquía, usar NULL (será nivel 0 - sin padre)
        num_documento_creador = num_documento_jerarquia if num_documento_jerarquia else None
        
        print(f"DEBUG: Documento jerarquía (padre): {num_documento_creador}")
        if num_documento_creador is None:
            print("DEBUG: Sin padre - será nivel 0 (nivel más alto en jerarquía)")
        else:
            print(f"DEBUG: Con padre {num_documento_creador} - será un subnivel")
        
        # Obtener datos del formulario
        num_documento = data.get('num_documento', '').strip().upper()
        tipo_documento = data.get('tipo_documento', 'DNI').upper()
        nombres = data.get('nombres', '').strip().upper()
        apellido_paterno = data.get('apellido_paterno', '').strip().upper()
        apellido_materno = data.get('apellido_materno', '').strip().upper()
        fecha_nacimiento = data.get('fecha_nacimiento', '').strip()  # NUEVO
        estado_civil = data.get('estado_civil', '').strip()  # NUEVO - NO convertir a mayúsculas (es ENUM)
        email = data.get('email', '').strip().lower()  # Email en minúsculas
        celular = data.get('celular', '').strip()
        numero_emergencia = data.get('numero_emergencia', '').strip()
        direccion = data.get('direccion', '').strip().upper()
        
        # NUEVO: Obtener NOMBRES en lugar de IDs
        distrito_nombre = data.get('distrito_nombre', '').strip().upper()
        rol_nombre = data.get('rol_nombre', '').strip().upper()
        cargo_nombre = data.get('cargo_nombre', '').strip().upper()
        
        genero = data.get('genero', '').strip()  # NO convertir a mayúsculas hasta verificar si es ENUM
        
        print(f"DEBUG: Datos procesados:")
        print(f"  num_documento: '{num_documento}'")
        print(f"  nombres: '{nombres}'")
        print(f"  apellido_paterno: '{apellido_paterno}'")
        print(f"  fecha_nacimiento: '{fecha_nacimiento}'")
        print(f"  estado_civil: '{estado_civil}'")
        print(f"  email: '{email}'")
        print(f"  genero: '{genero}'")
        print(f"  distrito_nombre: '{distrito_nombre}'")
        print(f"  rol_nombre: '{rol_nombre}'")
        print(f"  cargo_nombre: '{cargo_nombre}'")
        
        # Validar campos requeridos
        if not all([num_documento, nombres, apellido_paterno, email, rol_nombre, cargo_nombre]):
            print("❌ ERROR: Faltan campos requeridos")
            print(f"  num_documento: {bool(num_documento)}")
            print(f"  nombres: {bool(nombres)}")
            print(f"  apellido_paterno: {bool(apellido_paterno)}")
            print(f"  email: {bool(email)}")
            print(f"  rol_nombre: {bool(rol_nombre)}")
            print(f"  cargo_nombre: {bool(cargo_nombre)}")
            return {'success': False, 'message': 'Por favor completa los campos requeridos'}, 400
        
        # Validar formato de email
        import re
        email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        if not re.match(email_pattern, email):
            print(f"❌ ERROR: Email inválido: {email}")
            return {'success': False, 'message': 'Formato de email inválido'}, 400
        
        # Validar longitud de documento
        if len(num_documento) < 8:
            print(f"❌ ERROR: Documento muy corto: {num_documento}")
            return {'success': False, 'message': 'El número de documento debe tener al menos 8 caracteres'}, 400
        
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión con la base de datos'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Generar usuario automáticamente: Primera letra del nombre + Apellido Paterno + Primera letra del apellido materno
            primera_letra_nombre = nombres[0].lower() if nombres else ''
            apellido_pat_lower = apellido_paterno.lower() if apellido_paterno else ''
            
            # Obtener primera letra del apellido materno
            if apellido_materno:
                primera_letra_mat = apellido_materno[0].lower()
            else:
                primera_letra_mat = ''
            
            usuario = f"{primera_letra_nombre}{apellido_pat_lower}{primera_letra_mat}"
            
            print(f"DEBUG: Usuario generado: '{usuario}'")
            
            # La contraseña es el num_documento
            password_hash = hash_password(num_documento)
            
            print(f"DEBUG: Password hash generado")
            
            # Llamar al Stored Procedure para registrar el asesor
            # NUEVO: Pasamos NOMBRES en lugar de IDs, el SP buscará los IDs
            # NUEVO: Pasamos num_documento_creador para la jerarquía
            # NUEVO: Incluimos fecha_nacimiento y estado_civil
            query = """
                CALL sp_RegistrarAsesorPorNombre(
                    %s,  -- p_num_documento
                    %s,  -- p_tipo_documento
                    %s,  -- p_nombres
                    %s,  -- p_apellido_paterno
                    %s,  -- p_apellido_materno
                    %s,  -- p_fecha_nacimiento (NUEVO)
                    %s,  -- p_estado_civil (NUEVO)
                    %s,  -- p_email
                    %s,  -- p_celular
                    %s,  -- p_numero_emergencia
                    %s,  -- p_direccion
                    %s,  -- p_id_distrito
                    %s,  -- p_genero
                    %s,  -- p_usuario
                    %s,  -- p_password_hash
                    %s,  -- p_rol_nombre
                    %s,  -- p_cargo_nombre
                    %s,  -- p_num_documento_creador
                    @p_registrado,
                    @p_mensaje
                );
                
                SELECT 
                    @p_registrado as registrado,
                    @p_mensaje as mensaje
            """
            
            # Obtener el ID del distrito seleccionado y convertir a integer
            distrito_id = data.get('id_distrito', '')
            
            # Validar y convertir distrito_id a entero
            try:
                distrito_id = int(distrito_id) if distrito_id else None
                if distrito_id is None:
                    print("❌ ERROR: ID de distrito no válido")
                    return {'success': False, 'message': 'ID de distrito requerido'}, 400
            except ValueError:
                print(f"❌ ERROR: ID de distrito no es un número válido: {distrito_id}")
                return {'success': False, 'message': 'ID de distrito debe ser un número válido'}, 400
            
            print(f"DEBUG: Llamando al SP con parámetros:")
            print(f"  1. num_documento: {num_documento}")
            print(f"  2. tipo_documento: {tipo_documento}")
            print(f"  3. nombres: {nombres}")
            print(f"  4. apellido_paterno: {apellido_paterno}")
            print(f"  5. apellido_materno: {apellido_materno}")
            print(f"  6. email: {email}")
            print(f"  7. celular: {celular}")
            print(f"  8. numero_emergencia: {numero_emergencia}")
            print(f"  9. direccion: {direccion}")
            print(f"  10. id_distrito: {distrito_id}")  # CAMBIO: ahora es ID (integer)
            print(f"  11. genero: {genero}")
            print(f"  12. usuario: {usuario}")
            print(f"  13. password_hash: [HASH]")
            print(f"  14. rol_nombre: {rol_nombre}")
            print(f"  15. cargo_nombre: {cargo_nombre}")
            print(f"  16. num_documento_creador: {num_documento_creador}")  # NUEVO
            
            cursor.execute(query, (
                num_documento, tipo_documento, nombres, apellido_paterno, apellido_materno,
                email, celular, numero_emergencia, direccion, distrito_id, genero,
                usuario, password_hash, rol_nombre, cargo_nombre, num_documento_creador  # NUEVO
            ))
            
            # Obtener todos los resultados del stored procedure
            results = []
            try:
                # Primer resultado (si existe)
                if cursor.with_rows:
                    results.extend(cursor.fetchall())
                
                # Obtener el siguiente conjunto de resultados (las variables de salida)
                while cursor.nextset():
                    if cursor.with_rows:
                        results.extend(cursor.fetchall())
                
                print(f"DEBUG: Todos los resultados del SP: {results}")
                
                # El último resultado debería contener registrado y mensaje
                result = results[-1] if results else None
                
            except Exception as e:
                print(f"DEBUG: Error al procesar resultados del SP: {e}")
                result = None
            
            print(f"DEBUG: Respuesta del SP:")
            print(f"  registrado: {result.get('registrado') if result else 'None'}")
            print(f"  mensaje: {result.get('mensaje') if result else 'None'}")
            
            cursor.close()
            connection.close()
            
            if not result:
                print("❌ ERROR: No se obtuvo respuesta del SP")
                # Intentar obtener información del error desde MySQL
                cursor_info = connection.cursor()
                cursor_info.execute("SHOW WARNINGS")
                warnings = cursor_info.fetchall()
                cursor_info.close()
                
                error_detail = ""
                if warnings:
                    error_detail = f" Detalles: {warnings}"
                    print(f"DEBUG: Warnings de MySQL: {warnings}")
                
                return {'success': False, 'message': f'Error al registrar el asesor. No se obtuvo respuesta del stored procedure.{error_detail}'}, 500
            
            registrado = result.get('registrado')
            mensaje = result.get('mensaje')
            
            print(f"DEBUG: Procesando respuesta:")
            print(f"  registrado: {registrado} (tipo: {type(registrado)})")
            print(f"  mensaje: '{mensaje}' (tipo: {type(mensaje)})")
            
            if registrado == 1:
                print(f"✅ ÉXITO: Asesor registrado")
                return {
                    'success': True,
                    'message': f'¡Asesor {nombres} registrado exitosamente!',
                    'usuario': usuario,
                    'contraseña': num_documento  # Solo para mostrar al usuario
                }, 201
            else:
                # Manejar diferentes casos de error
                if mensaje is None or mensaje == 'None' or str(mensaje).strip() == '':
                    # Error específico basado en los datos enviados
                    error_detallado = []
                    
                    # Verificar si el distrito_id existe
                    cursor_check = connection.cursor()
                    cursor_check.execute("SELECT COUNT(*) as existe FROM TblDistritos WHERE id_distrito = %s", (distrito_id,))
                    distrito_existe = cursor_check.fetchone()[0]
                    if distrito_existe == 0:
                        error_detallado.append(f"El distrito con ID {distrito_id} no existe")
                    
                    # Verificar si el rol existe
                    cursor_check.execute("SELECT COUNT(*) as existe FROM TblRol WHERE nombre = %s AND estado = 'Activo'", (rol_nombre,))
                    rol_existe = cursor_check.fetchone()[0]
                    if rol_existe == 0:
                        error_detallado.append(f"El rol '{rol_nombre}' no existe o no está activo")
                    
                    # Verificar si el cargo existe
                    cursor_check.execute("SELECT COUNT(*) as existe FROM TblCargos WHERE nombre = %s AND estado = 'Activo'", (cargo_nombre,))
                    cargo_existe = cursor_check.fetchone()[0]
                    if cargo_existe == 0:
                        error_detallado.append(f"El cargo '{cargo_nombre}' no existe o no está activo")
                    
                    # Verificar si el documento ya existe
                    cursor_check.execute("SELECT COUNT(*) as existe FROM TblUsuarios WHERE num_documento = %s", (num_documento,))
                    doc_existe = cursor_check.fetchone()[0]
                    if doc_existe > 0:
                        error_detallado.append(f"El documento {num_documento} ya está registrado")
                    
                    # Verificar si el email ya existe
                    cursor_check.execute("SELECT COUNT(*) as existe FROM TblPersona WHERE email = %s", (email,))
                    email_existe = cursor_check.fetchone()[0]
                    if email_existe > 0:
                        error_detallado.append(f"El email {email} ya está registrado")
                    
                    cursor_check.close()
                    
                    if error_detallado:
                        mensaje_error = "Errores encontrados: " + "; ".join(error_detallado)
                    else:
                        mensaje_error = 'Error desconocido en el stored procedure. Verifica que todos los datos sean correctos.'
                else:
                    mensaje_error = str(mensaje)
                    
                print(f"❌ ERROR del SP: {mensaje_error}")
                return {'success': False, 'message': mensaje_error}, 400
            
        except Error as e:
            print(f"❌ ERROR SQL: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'message': f'Error de base de datos: {str(e)}'}, 500
    
    except Exception as e:
        print(f"❌ ERROR GENERAL: {e}")
        import traceback
        traceback.print_exc()
        return {'success': False, 'message': f'Error en el servidor: {str(e)}'}, 500


def buscar_usuario_por_documento():
    """Buscar usuario por número de documento - OPTIMIZADO CON SP"""
    try:
        # Obtener el documento del parámetro de la URL
        from flask import request
        num_documento = request.args.get('num_documento', '').strip()
        
        if not num_documento:
            return {'success': False, 'message': 'Número de documento requerido'}, 400
        
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print(f"DEBUG: Buscando usuario con documento: {num_documento} (usando SP optimizado)")
        
        try:
            # Intentar primero con el SP optimizado
            cursor.execute("CALL sp_BuscarUsuarioPorDocumento(%s)", (num_documento,))
            usuario = cursor.fetchone()
            
            cursor.close()
            connection.close()
            
            if usuario:
                print(f"DEBUG: ✅ Usuario encontrado con SP: {usuario['nombre_completo']}")
                return {
                    'success': True,
                    'found': True,
                    'data': {
                        'num_documento': usuario['num_documento'],
                        'usuario': usuario['usuario'],
                        'nombre_completo': usuario['nombre_completo'],
                        'rol': usuario['rol'],
                        'cargo': usuario['cargo'],
                        'area': usuario['area'],
                        'estado': usuario['estado'],
                        'nivel': usuario['nivel'],
                        'total_hijos': usuario['total_hijos']
                    }
                }, 200
            else:
                print(f"DEBUG: ❌ Usuario no encontrado: {num_documento}")
                return {
                    'success': True,
                    'found': False,
                    'message': f'No se encontró ningún usuario con el documento {num_documento}'
                }, 200
                
        except Error as sp_error:
            print(f"DEBUG: ⚠️ Error con SP, usando query de respaldo: {sp_error}")
            
            # Respaldo: si el SP falla, usar query directo
            connection = get_db_connection()
            cursor = connection.cursor(dictionary=True)
            
            query = """
                SELECT 
                    u.num_documento,
                    u.usuario,
                    p.nombres,
                    p.apellido_paterno,
                    p.apellido_materno,
                    CONCAT(p.nombres, ' ', p.apellido_paterno, ' ', COALESCE(p.apellido_materno, '')) as nombre_completo,
                    r.nombre as rol,
                    c.nombre as cargo,
                    a.nombre as area,
                    u.estado,
                    COALESCE(j.nivel, 0) as nivel,
                    (SELECT COUNT(*) FROM TblJerarquiaUsuarios WHERE num_documento_padre COLLATE utf8mb4_unicode_ci = u.num_documento COLLATE utf8mb4_unicode_ci) as total_hijos
                FROM TblUsuarios u
                INNER JOIN TblPersona p ON u.num_documento COLLATE utf8mb4_unicode_ci = p.num_documento COLLATE utf8mb4_unicode_ci
                LEFT JOIN TblRol r ON u.id_rol = r.id_rol
                LEFT JOIN TblCargos c ON u.id_cargo = c.id_cargo
                LEFT JOIN TblAreas a ON c.id_area = a.id_area
                LEFT JOIN TblJerarquiaUsuarios j ON u.num_documento COLLATE utf8mb4_unicode_ci = j.num_documento COLLATE utf8mb4_unicode_ci
                WHERE u.num_documento = %s
                LIMIT 1
            """
            
            cursor.execute(query, (num_documento,))
            usuario = cursor.fetchone()
            
            cursor.close()
            connection.close()
            
            if usuario:
                print(f"DEBUG: ✅ Usuario encontrado con query de respaldo: {usuario['nombre_completo']}")
                return {
                    'success': True,
                    'found': True,
                    'data': {
                        'num_documento': usuario['num_documento'],
                        'usuario': usuario['usuario'],
                        'nombre_completo': usuario['nombre_completo'],
                        'rol': usuario['rol'],
                        'cargo': usuario['cargo'],
                        'area': usuario['area'],
                        'estado': usuario['estado'],
                        'nivel': usuario['nivel'],
                        'total_hijos': usuario['total_hijos']
                    }
                }, 200
            else:
                print(f"DEBUG: ❌ Usuario no encontrado: {num_documento}")
                return {
                    'success': True,
                    'found': False,
                    'message': f'No se encontró ningún usuario con el documento {num_documento}'
                }, 200
        
    except Error as e:
        print(f"Error: {e}")
        if connection and connection.is_connected():
            connection.close()
        return {'success': False, 'message': f'Error al buscar usuario: {str(e)}'}, 500


def update_asesor_api():
    """API para actualizar un asesor existente"""
    try:
        data = request.get_json()
        
        print("=" * 80)
        print("DEBUG: Datos recibidos para actualización:")
        print(data)
        print("=" * 80)
        
        # Obtener documento original del campo oculto
        documento_original = data.get('documento_original', '').strip()
        
        if not documento_original:
            return {'success': False, 'message': 'Documento original requerido para actualización'}, 400
        
        # NUEVO: Obtener documento de jerarquía del formulario
        num_documento_jerarquia = data.get('num_documento_jerarquia', '').strip()
        num_documento_creador = num_documento_jerarquia if num_documento_jerarquia else None
        
        print(f"DEBUG: Documento original: {documento_original}")
        print(f"DEBUG: Documento jerarquía (padre): {num_documento_creador}")
        
        # Obtener datos del formulario (mismo proceso que crear)
        num_documento = data.get('num_documento', '').strip().upper()
        tipo_documento = data.get('tipo_documento', 'DNI').upper()
        nombres = data.get('nombres', '').strip().upper()
        apellido_paterno = data.get('apellido_paterno', '').strip().upper()
        apellido_materno = data.get('apellido_materno', '').strip().upper()
        fecha_nacimiento = data.get('fecha_nacimiento', '').strip()
        estado_civil = data.get('estado_civil', '').strip()  # NO convertir a mayúsculas (es ENUM)
        email = data.get('email', '').strip().lower()
        celular = data.get('celular', '').strip()
        numero_emergencia = data.get('numero_emergencia', '').strip()
        direccion = data.get('direccion', '').strip().upper()
        
        # Obtener NOMBRES en lugar de IDs
        distrito_nombre = data.get('distrito_nombre', '').strip().upper()
        rol_nombre = data.get('rol_nombre', '').strip().upper()
        cargo_nombre = data.get('cargo_nombre', '').strip().upper()
        
        genero = data.get('genero', '').strip()
        
        print(f"DEBUG: Datos procesados para actualización:")
        print(f"  num_documento: '{num_documento}'")
        print(f"  nombres: '{nombres}'")
        print(f"  apellido_paterno: '{apellido_paterno}'")
        print(f"  fecha_nacimiento: '{fecha_nacimiento}'")
        print(f"  estado_civil: '{estado_civil}'")
        print(f"  email: '{email}'")
        
        # Validar campos requeridos
        if not all([num_documento, nombres, apellido_paterno, email, rol_nombre, cargo_nombre]):
            print("❌ ERROR: Faltan campos requeridos")
            return {'success': False, 'message': 'Por favor completa los campos requeridos'}, 400
        
        # Validar formato de email
        import re
        email_pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        if not re.match(email_pattern, email):
            print(f"❌ ERROR: Email inválido: {email}")
            return {'success': False, 'message': 'Formato de email inválido'}, 400
        
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión con la base de datos'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Generar usuario automáticamente (mismo algoritmo que crear)
            primera_letra_nombre = nombres[0].lower() if nombres else ''
            apellido_pat_lower = apellido_paterno.lower() if apellido_paterno else ''
            
            if apellido_materno:
                primera_letra_mat = apellido_materno[0].lower()
            else:
                primera_letra_mat = ''
            
            usuario = f"{primera_letra_nombre}{apellido_pat_lower}{primera_letra_mat}"
            
            print(f"DEBUG: Usuario generado: '{usuario}'")
            
            # Obtener el ID del distrito seleccionado y convertir a integer
            distrito_id = data.get('id_distrito', '')
            
            try:
                distrito_id = int(distrito_id) if distrito_id else None
                if distrito_id is None:
                    print("❌ ERROR: ID de distrito no válido")
                    return {'success': False, 'message': 'ID de distrito requerido'}, 400
            except ValueError:
                print(f"❌ ERROR: ID de distrito no es un número válido: {distrito_id}")
                return {'success': False, 'message': 'ID de distrito debe ser un número válido'}, 400
            
            # Llamar al Stored Procedure para actualizar el asesor usando callproc
            print(f"DEBUG: Llamando al SP de actualización con parámetros:")
            print(f"  0. documento_original: {documento_original}")
            print(f"  1. num_documento: {num_documento}")
            print(f"  2. tipo_documento: {tipo_documento}")
            print(f"  3. nombres: {nombres}")
            print(f"  4. apellido_paterno: {apellido_paterno}")
            print(f"  5. apellido_materno: {apellido_materno}")
            print(f"  6. fecha_nacimiento: {fecha_nacimiento}")
            print(f"  7. estado_civil: {estado_civil}")
            print(f"  8. email: {email}")
            print(f"  9. celular: {celular}")
            print(f"  10. numero_emergencia: {numero_emergencia}")
            print(f"  11. direccion: {direccion}")
            print(f"  12. id_distrito: {distrito_id}")
            print(f"  13. genero: {genero}")
            print(f"  14. usuario: {usuario}")
            print(f"  15. rol_nombre: {rol_nombre}")
            print(f"  16. cargo_nombre: {cargo_nombre}")
            print(f"  17. num_documento_creador: {num_documento_creador}")
            
            # Usar callproc para parámetros OUT
            args = [
                documento_original, num_documento, tipo_documento, nombres, apellido_paterno, apellido_materno,
                fecha_nacimiento, estado_civil, email, celular, numero_emergencia, direccion, distrito_id, genero,
                usuario, rol_nombre, cargo_nombre, num_documento_creador,
                0,    # OUT p_actualizado (valor inicial)
                ''    # OUT p_mensaje (valor inicial)
            ]
            
            result_args = cursor.callproc('sp_ActualizarAsesorPorNombre', args)
            
            # callproc devuelve un dict con claves 'sp_ActualizarAsesorPorNombre_argN'
            # Los parámetros OUT están en arg19 y arg20 (0-indexed desde arg1)
            actualizado = result_args.get('sp_ActualizarAsesorPorNombre_arg19', 0)
            mensaje = result_args.get('sp_ActualizarAsesorPorNombre_arg20', None)
            
            print(f"DEBUG: Respuesta del SP usando callproc:")
            print(f"  actualizado: {actualizado} (tipo: {type(actualizado)})")
            print(f"  mensaje: '{mensaje}' (tipo: {type(mensaje)})")
            
            # Si el mensaje sigue siendo None, el SP no se ejecutó
            if mensaje is None:
                print("⚠️ ADVERTENCIA: El SP devolvió mensaje = None, significa que no se ejecutó correctamente")
            
            cursor.close()
            connection.close()
            
            if actualizado == 1:
                print(f"✅ ÉXITO: Asesor actualizado")
                return {
                    'success': True,
                    'message': f'¡Asesor {nombres} actualizado exitosamente!',
                    'usuario': usuario
                }, 200
            else:
                # Manejar errores de actualización
                if mensaje is None or mensaje == 'None' or str(mensaje).strip() == '':
                    mensaje_error = 'Error desconocido al actualizar el asesor. Verifica que todos los datos sean correctos.'
                else:
                    mensaje_error = str(mensaje)
                    
                print(f"❌ ERROR del SP: {mensaje_error}")
                return {'success': False, 'message': mensaje_error}, 400
            
        except Error as e:
            print(f"❌ ERROR SQL: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'message': f'Error de base de datos: {str(e)}'}, 500
    
    except Exception as e:
        print(f"❌ ERROR GENERAL: {e}")
        import traceback
        traceback.print_exc()
        return {'success': False, 'message': f'Error en el servidor: {str(e)}'}, 500


def cambiar_contrasena_api():
    """Cambiar contraseña del usuario actual usando SP"""
    try:
        from flask import session, request
        
        # Obtener datos del request
        data = request.get_json()
        contrasena_actual = data.get('contrasena_actual', '').strip()
        contrasena_nueva = data.get('contrasena_nueva', '').strip()
        usuario = session.get('user_usuario')  # Usuario de la sesión
        
        if not usuario:
            return {'success': False, 'message': 'Usuario no autenticado'}, 401
        
        if not contrasena_actual or not contrasena_nueva:
            return {'success': False, 'message': 'Faltan datos requeridos'}, 400
        
        # Validar longitud mínima
        if len(contrasena_nueva) < 6:
            return {'success': False, 'message': 'La nueva contraseña debe tener al menos 6 caracteres'}, 400
        
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print(f"DEBUG: Cambiando contraseña para usuario: {usuario}")
        
        # Hash de las contraseñas (asumiendo que se usa hash en la BD)
        contrasena_actual_hash = hash_password(contrasena_actual)
        contrasena_nueva_hash = hash_password(contrasena_nueva)
        
        # Usar callproc para llamar al SP
        args = [
            usuario,                    # IN p_usuario
            contrasena_actual_hash,     # IN p_contrasena_actual
            contrasena_nueva_hash,      # IN p_contrasena_nueva
            0,                          # OUT p_cambiado
            ''                          # OUT p_mensaje
        ]
        
        result_args = cursor.callproc('sp_CambiarContrasena', args)
        
        # Obtener resultados OUT
        cambiado = result_args.get('sp_CambiarContrasena_arg4', 0)
        mensaje = result_args.get('sp_CambiarContrasena_arg5', None)
        
        print(f"DEBUG: Respuesta del SP de cambio de contraseña:")
        print(f"  cambiado: {cambiado}")
        print(f"  mensaje: {mensaje}")
        
        cursor.close()
        connection.close()
        
        if cambiado == 1:
            print(f"✅ ÉXITO: Contraseña cambiada para {usuario}")
            return {
                'success': True,
                'message': mensaje or 'Contraseña actualizada exitosamente'
            }, 200
        else:
            print(f"❌ ERROR: {mensaje}")
            return {
                'success': False,
                'message': mensaje or 'No se pudo cambiar la contraseña'
            }, 400
            
    except Error as e:
        print(f"❌ ERROR SQL: {e}")
        if connection and connection.is_connected():
            connection.close()
        return {'success': False, 'message': f'Error de base de datos: {str(e)}'}, 500
    
    except Exception as e:
        print(f"❌ ERROR GENERAL: {e}")
        import traceback
        traceback.print_exc()
        return {'success': False, 'message': f'Error en el servidor: {str(e)}'}, 500


def delete_asesor_api(num_documento):
    """Eliminar un asesor de todas las tablas usando SP"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print(f"DEBUG: Eliminando asesor con documento: {num_documento}")
        
        # Usar callproc para llamar al SP
        args = [
            num_documento,  # IN p_num_documento
            0,              # OUT p_eliminado
            ''              # OUT p_mensaje
        ]
        
        result_args = cursor.callproc('sp_EliminarAsesor', args)
        
        # Obtener resultados OUT
        eliminado = result_args.get('sp_EliminarAsesor_arg2', 0)
        mensaje = result_args.get('sp_EliminarAsesor_arg3', None)
        
        print(f"DEBUG: Respuesta del SP de eliminación:")
        print(f"  eliminado: {eliminado}")
        print(f"  mensaje: {mensaje}")
        
        cursor.close()
        connection.close()
        
        if eliminado == 1:
            print(f"✅ ÉXITO: Asesor eliminado")
            return {
                'success': True,
                'message': mensaje or 'Asesor eliminado exitosamente'
            }, 200
        else:
            print(f"❌ ERROR: {mensaje}")
            return {
                'success': False,
                'message': mensaje or 'No se pudo eliminar el asesor'
            }, 400
            
    except Error as e:
        print(f"❌ ERROR SQL: {e}")
        if connection and connection.is_connected():
            connection.close()
        return {'success': False, 'message': f'Error de base de datos: {str(e)}'}, 500
    
    except Exception as e:
        print(f"❌ ERROR GENERAL: {e}")
        import traceback
        traceback.print_exc()
        return {'success': False, 'message': f'Error en el servidor: {str(e)}'}, 500


def get_usuarios_asesores():
    """Obtener listado de usuarios asesores - SOLO USA SP (sin respaldo)"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print("DEBUG: Ejecutando SP sp_ListarAsesores...")
        cursor.execute("CALL sp_ListarAsesores()")
        usuarios = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        print(f"DEBUG: ✅ Se obtuvieron {len(usuarios)} asesores con SP")
        return {
            'success': True,
            'data': usuarios,
            'total': len(usuarios)
        }, 200
        
    except Error as e:
        print(f"❌ ERROR CRÍTICO: El SP sp_ListarAsesores no existe o tiene errores")
        print(f"❌ Error: {e}")
        print(f"❌ SOLUCIÓN: Ejecuta el script ejecutar_todos_sps_optimizados.sql")
        return {'success': False, 'message': f'Error: SP no encontrado. Ejecuta ejecutar_todos_sps_optimizados.sql'}, 500


def get_asesor_by_documento(num_documento):
    """Obtener un asesor específico por número de documento - OPTIMIZADO CON SP"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print(f"DEBUG: Obteniendo asesor con documento: {num_documento} (usando SP optimizado)")
        
        try:
            # Intentar primero con el SP optimizado
            cursor.execute("CALL sp_ObtenerDatosEdicionAsesor(%s)", (num_documento,))
            asesor = cursor.fetchone()
            
            if asesor:
                print(f"DEBUG: ✅ Asesor encontrado con SP: {asesor['nombres']} {asesor['apellido_paterno']}")
                print(f"DEBUG: Ubicación - Departamento: {asesor.get('id_departamento')}, Provincia: {asesor.get('id_provincia')}, Distrito: {asesor.get('id_distrito')}")
                print(f"DEBUG: Área: {asesor.get('id_area')}, Cargo: {asesor.get('id_cargo')}")
                cursor.close()
                connection.close()
                return {
                    'success': True,
                    'data': asesor
                }, 200
            else:
                print(f"DEBUG: ❌ No se encontró asesor con documento: {num_documento}")
                cursor.close()
                connection.close()
                return {
                    'success': False,
                    'message': f'No se encontró el asesor con documento {num_documento}'
                }, 404
                
        except Error as sp_error:
            print(f"DEBUG: ⚠️ Error con SP, usando query de respaldo: {sp_error}")
            
            # Respaldo: si el SP falla, usar query directo
            cursor.close()
            connection = get_db_connection()
            cursor = connection.cursor(dictionary=True)
            
            query = """
                SELECT 
                    -- Datos de usuario
                    u.usuario,
                    u.id_rol,
                    r.nombre as rol_nombre,
                    u.id_cargo,
                    c.nombre as cargo_nombre,
                    c.id_area,
                    a.nombre as area_nombre,
                    u.estado as usuario_estado,
                    
                    -- Datos de persona
                    p.num_documento,
                    p.tipo_documento,
                    p.nombres,
                    p.apellido_paterno,
                    p.apellido_materno,
                    p.email,
                    p.celular,
                    p.numero_emergencia,
                    p.genero,
                    p.direccion,
                    p.fecha_nacimiento,
                    p.estado_civil,
                    p.id_distrito,
                    
                    -- Datos de ubicación
                    d.nombre as distrito_nombre,
                    d.id_provincia,
                    pr.nombre as provincia_nombre,
                    pr.id_departamento,
                    dp.nombre as departamento_nombre,
                    
                    -- Datos de jerarquía
                    COALESCE(j.nivel, 0) as nivel,
                    j.num_documento_padre,
                    CASE 
                        WHEN j.num_documento_padre IS NOT NULL 
                        THEN CONCAT(pp.nombres, ' ', pp.apellido_paterno, ' ', COALESCE(pp.apellido_materno, ''))
                        ELSE NULL
                    END as nombre_padre
                    
                FROM TblUsuarios u
                INNER JOIN TblPersona p ON u.num_documento COLLATE utf8mb4_unicode_ci = p.num_documento COLLATE utf8mb4_unicode_ci
                INNER JOIN TblRol r ON u.id_rol = r.id_rol
                LEFT JOIN TblCargos c ON u.id_cargo = c.id_cargo
                LEFT JOIN TblAreas a ON c.id_area = a.id_area
                LEFT JOIN TblDistritos d ON p.id_distrito = d.id_distrito
                LEFT JOIN TblProvincias pr ON d.id_provincia = pr.id_provincia
                LEFT JOIN TblDepartamentos dp ON pr.id_departamento = dp.id_departamento
                LEFT JOIN TblJerarquiaUsuarios j ON u.num_documento COLLATE utf8mb4_unicode_ci = j.num_documento COLLATE utf8mb4_unicode_ci
                LEFT JOIN TblPersona pp ON j.num_documento_padre COLLATE utf8mb4_unicode_ci = pp.num_documento COLLATE utf8mb4_unicode_ci
                WHERE u.num_documento = %s
                LIMIT 1
            """
            
            cursor.execute(query, (num_documento,))
            asesor = cursor.fetchone()
            
            cursor.close()
            connection.close()
            
            if asesor:
                print(f"DEBUG: ✅ Asesor encontrado con query de respaldo: {asesor['nombres']} {asesor['apellido_paterno']}")
                return {
                    'success': True,
                    'data': asesor
                }, 200
            else:
                print(f"DEBUG: ❌ No se encontró asesor con documento: {num_documento}")
                return {
                    'success': False,
                    'message': f'No se encontró el asesor con documento {num_documento}'
                }, 404
        
    except Error as e:
        print(f"Error: {e}")
        if connection.is_connected():
            connection.close()
        return {'success': False, 'message': f'Error al obtener asesor: {str(e)}'}, 500



# ============================================================================
# FUNCIONES PARA GESTIÓN DE CLIENTES
# ============================================================================

def get_fuentes_contacto_api():
    """API para obtener lista de fuentes de contacto"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        cursor.execute("CALL sp_ListarFuentesContacto()")
        fuentes = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return fuentes, 200
        
    except Error as e:
        print(f"Error: {e}")
        return {'success': False, 'message': 'Error al obtener fuentes de contacto'}, 500


def get_proyectos_api():
    """API para obtener lista de proyectos"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        cursor.execute("CALL sp_ListarProyectos()")
        proyectos = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return proyectos, 200
        
    except Error as e:
        print(f"Error: {e}")
        return {'success': False, 'message': 'Error al obtener proyectos'}, 500


def get_estados_prospeccion_api():
    """API para obtener lista de estados de prospección"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        cursor.execute("CALL sp_ListarEstadosProspeccion()")
        estados = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return estados, 200
        
    except Error as e:
        print(f"Error: {e}")
        return {'success': False, 'message': 'Error al obtener estados de prospección'}, 500


def get_tipos_compra_api():
    """API para obtener lista de tipos de compra"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexión'}, 500
        
        cursor = connection.cursor(dictionary=True)
        cursor.execute("CALL sp_ListarTiposCompra()")
        tipos = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return tipos, 200
        
    except Error as e:
        print(f"Error: {e}")
        return {'success': False, 'message': 'Error al obtener tipos de compra'}, 500


def insertar_cliente_api():
    """API para insertar un nuevo cliente"""
    try:
        from flask import session
        
        data = request.get_json()
        
        print("=" * 80)
        print("DEBUG: Datos del nuevo cliente:")
        print(data)
        print("=" * 80)
        
        # Obtener datos del formulario
        num_documento = data.get('num_documento', '').strip()
        tipo_documento = data.get('tipo_documento', 'DNI')
        nombres = data.get('nombres', '').strip()
        apellido_paterno = data.get('apellido_paterno', '').strip()
        apellido_materno = data.get('apellido_materno', '').strip()
        fecha_nacimiento = data.get('fecha_nacimiento', '')
        genero = data.get('genero', '')
        estado_civil = data.get('estado_civil', '')
        email = data.get('email', '').strip()
        celular = data.get('celular', '').strip()
        direccion = data.get('direccion', '').strip()
        id_distrito = data.get('id_distrito')
        
        # Obtener el documento del asesor logueado (se guarda como 'user_documento' en el login)
        num_documento_asesor = session.get('user_documento', '')
        
        # Datos comerciales
        id_fuente_contacto = data.get('id_fuente_contacto')
        id_proyecto = data.get('id_proyecto')
        id_estado_prospeccion = data.get('id_estado_prospeccion')
        id_tipo_compra = data.get('id_tipo_compra')
        estado = data.get('estado', 'Activo')
        fecha_proximo_seguimiento = data.get('fecha_proximo_seguimiento')
        prioridad = data.get('prioridad', 'Media')
        observaciones = data.get('observaciones', '')
        
        # Validar campos requeridos
        if not all([num_documento, nombres, apellido_paterno, email, celular, direccion, id_distrito]):
            return {'success': False, 'error': 'Por favor completa todos los campos requeridos'}, 400
        
        # Convertir valores vacíos a None
        id_fuente_contacto = int(id_fuente_contacto) if id_fuente_contacto else None
        id_proyecto = int(id_proyecto) if id_proyecto else None
        id_estado_prospeccion = int(id_estado_prospeccion) if id_estado_prospeccion else None
        id_tipo_compra = int(id_tipo_compra) if id_tipo_compra else None
        id_distrito = int(id_distrito) if id_distrito else None
        fecha_proximo_seguimiento = fecha_proximo_seguimiento if fecha_proximo_seguimiento else None
        
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'error': 'Error de conexión'}, 500
        
        try:
            cursor = connection.cursor()
            
            # Llamar al SP con parámetros OUT
            cursor.callproc('sp_InsertarCliente', [
                num_documento, tipo_documento, nombres, apellido_paterno, apellido_materno,
                fecha_nacimiento, genero, estado_civil,
                email, celular,
                direccion, id_distrito,
                num_documento_asesor,
                id_fuente_contacto, id_proyecto, id_estado_prospeccion, id_tipo_compra,
                estado, fecha_proximo_seguimiento, prioridad,
                observaciones, num_documento_asesor,
                0,  # p_id_cliente OUT
                ''  # p_mensaje OUT
            ])
            
            # Obtener resultados OUT
            cursor.execute("SELECT @_sp_InsertarCliente_22 AS id_cliente, @_sp_InsertarCliente_23 AS mensaje")
            result = cursor.fetchone()
            
            cursor.close()
            connection.close()
            
            id_cliente = result[0]
            mensaje = result[1]
            
            if id_cliente > 0:
                print(f"✅ Cliente registrado con ID: {id_cliente}")
                return {
                    'success': True,
                    'message': mensaje,
                    'id_cliente': id_cliente
                }, 201
            else:
                print(f"❌ Error: {mensaje}")
                return {'success': False, 'error': mensaje}, 400
                
        except Error as e:
            print(f"❌ Error SQL: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        print(f"❌ Error general: {e}")
        import traceback
        traceback.print_exc()
        return {'success': False, 'error': f'Error del servidor: {str(e)}'}, 500



def listar_clientes_api():
    """API para listar clientes del asesor logueado"""
    try:
        from flask import session
        
        # Obtener el documento del asesor logueado (se guarda como 'user_documento' en el login)
        num_documento_asesor = session.get('user_documento', '')
        
        if not num_documento_asesor:
            return {'success': False, 'error': 'Usuario no autenticado'}, 401
        
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'error': 'Error de conexión'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Llamar al SP para listar clientes
            cursor.execute("CALL sp_ListarClientes(%s)", (num_documento_asesor,))
            clientes = cursor.fetchall()
            
            cursor.close()
            connection.close()
            
            return {
                'success': True,
                'data': clientes,
                'total': len(clientes)
            }, 200
            
        except Error as e:
            print(f"❌ Error SQL: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        print(f"❌ Error general: {e}")
        import traceback
        traceback.print_exc()
        return {'success': False, 'error': f'Error del servidor: {str(e)}'}, 500


def listar_todos_clientes_api():
    """API para listar TODOS los clientes (para administradores)"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'error': 'Error de conexión'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Llamar al SP para listar todos los clientes
            cursor.execute("CALL sp_ListarTodosLosClientes()")
            clientes = cursor.fetchall()
            
            cursor.close()
            connection.close()
            
            return {
                'success': True,
                'data': clientes,
                'total': len(clientes)
            }, 200
            
        except Error as e:
            print(f"❌ Error SQL: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        print(f"❌ Error general: {e}")
        import traceback
        traceback.print_exc()
        return {'success': False, 'error': f'Error del servidor: {str(e)}'}, 500
