#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Funciones de gestion de clientes
- insertar_cliente_api()
- listar_clientes_api()
- listar_todos_clientes_api()
- eliminar_cliente_api()
"""

from flask import request
from mysql.connector import Error
from .funGeneral import get_db_connection


def insertar_cliente_api():
    """API para insertar un nuevo cliente"""
    try:
        from flask import session, current_app
        
        data = request.get_json()
        
        current_app.logger.info("=== INSERTAR NUEVO CLIENTE ===")
        # Convertir datos a string de forma segura para el log
        try:
            current_app.logger.info(f"Datos recibidos (total campos): {len(data)}")
        except:
            current_app.logger.info("Datos recibidos del formulario")
        
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
        
        # Obtener el documento del asesor logueado
        num_documento_asesor = session.get('user_documento', '')
        current_app.logger.info(f"Asesor logueado: {num_documento_asesor}")
        
        # Datos comerciales
        id_fuente_contacto = data.get('id_fuente_contacto')
        id_proyecto = data.get('id_proyecto')
        id_estado_prospeccion = data.get('id_estado_prospeccion')
        id_tipo_compra = data.get('id_tipo_compra')
        # Campo 'estado' eliminado - se usa estado_prospeccion
        # Campo 'fecha_proximo_seguimiento' eliminado - se maneja en TblClientesSeguimientos
        prioridad = data.get('prioridad', 'Media')
        observaciones = data.get('observaciones', '')
        
        # Validar campos requeridos
        if not all([num_documento, nombres, apellido_paterno, email, celular, direccion, id_distrito]):
            current_app.logger.warning(f"Campos requeridos faltantes al insertar cliente {num_documento}")
            return {'success': False, 'error': 'Por favor completa todos los campos requeridos'}, 400
        
        # Log seguro sin caracteres especiales que puedan causar problemas
        current_app.logger.info(f"Cliente a insertar - Doc: {num_documento}, Email: {email}")
        
        # Convertir valores vacios a None
        id_fuente_contacto = int(id_fuente_contacto) if id_fuente_contacto else None
        id_proyecto = int(id_proyecto) if id_proyecto else None
        id_estado_prospeccion = int(id_estado_prospeccion) if id_estado_prospeccion else None
        id_tipo_compra = int(id_tipo_compra) if id_tipo_compra else None
        id_distrito = int(id_distrito) if id_distrito else None
        
        connection = get_db_connection()
        if not connection:
            current_app.logger.error("Error de conexion a BD al insertar cliente")
            return {'success': False, 'error': 'Error de conexion'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            current_app.logger.info(f"Ejecutando SP sp_InsertarCliente para documento {num_documento}")
            
            # Llamar al SP (19 parámetros - SIN estado, SIN fecha_proximo_seguimiento)
            cursor.execute("""
                CALL sp_InsertarCliente(
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                )
            """, (
                num_documento, tipo_documento, nombres, apellido_paterno, apellido_materno,
                fecha_nacimiento, genero, estado_civil,
                email, celular,
                direccion, id_distrito,
                num_documento_asesor,
                id_fuente_contacto, id_proyecto, id_estado_prospeccion, id_tipo_compra,
                prioridad, observaciones
            ))
            
            # El SP retorna SELECT con 'mensaje' y 'exito'
            result = cursor.fetchone()
            
            cursor.close()
            connection.close()
            
            if result and result.get('exito') == 1:
                current_app.logger.info(f"Cliente registrado exitosamente: {num_documento}")
                return {
                    'success': True,
                    'message': result.get('mensaje', 'Cliente registrado exitosamente')
                }, 201
            else:
                mensaje = result.get('mensaje', 'Error desconocido') if result else 'Error desconocido'
                current_app.logger.warning(f"No se pudo insertar cliente {num_documento}: {mensaje}")
                return {'success': False, 'error': mensaje}, 400
                
        except Error as e:
            current_app.logger.error(f"Error SQL al insertar cliente {num_documento}: {str(e)}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        from flask import current_app
        current_app.logger.error(f"Error general al insertar cliente", exc_info=True)
        return {'success': False, 'error': f'Error del servidor: {str(e)}'}, 500


def listar_clientes_api():
    """API para listar clientes del asesor logueado (o todos si es ADMINISTRADOR)"""
    try:
        from flask import session, current_app
        from datetime import datetime
        
        # Obtener el documento y rol del asesor logueado
        num_documento_asesor = session.get('user_documento', '')
        rol_usuario = session.get('user_role', '').upper()  # Convertir a mayusculas
        
        # Log de inicio
        current_app.logger.info(f"=== LISTAR CLIENTES ===")
        current_app.logger.info(f"Usuario: {num_documento_asesor}")
        current_app.logger.info(f"Rol original: {session.get('user_role', '')}")
        current_app.logger.info(f"Rol convertido: {rol_usuario}")
        
        if not num_documento_asesor:
            current_app.logger.warning("Usuario no autenticado intentando listar clientes")
            return {'success': False, 'error': 'Usuario no autenticado'}, 401
        
        connection = get_db_connection()
        if not connection:
            current_app.logger.error("Error al conectar a la base de datos")
            return {'success': False, 'error': 'Error de conexion'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Si es ADMINISTRADOR, mostrar TODOS los clientes
            if rol_usuario == 'ADMINISTRADOR':
                current_app.logger.info("  Usuario ADMINISTRADOR - Ejecutando sp_ListarTodosLosClientes()")
                print(f"DEBUG: Usuario ADMINISTRADOR - Listando TODOS los clientes")
                cursor.execute("CALL sp_ListarTodosLosClientes()")
            else:
                # Si es asesor normal, solo mostrar sus clientes
                current_app.logger.info(f"Usuario {rol_usuario} - Ejecutando sp_ListarClientes({num_documento_asesor})")
                print(f"DEBUG: Usuario {rol_usuario} - Listando clientes del asesor: {num_documento_asesor}")
                cursor.execute("CALL sp_ListarClientes(%s)", (num_documento_asesor,))
            
            clientes = cursor.fetchall()
            
            # Convertir datetime a string para JSON
            for cliente in clientes:
                if cliente.get('fecha_proximo_seguimiento') and isinstance(cliente['fecha_proximo_seguimiento'], datetime):
                    cliente['fecha_proximo_seguimiento'] = cliente['fecha_proximo_seguimiento'].isoformat()
                if cliente.get('fecha_nacimiento') and isinstance(cliente['fecha_nacimiento'], datetime):
                    cliente['fecha_nacimiento'] = cliente['fecha_nacimiento'].isoformat()
                if cliente.get('fecha_creacion') and isinstance(cliente['fecha_creacion'], datetime):
                    cliente['fecha_creacion'] = cliente['fecha_creacion'].isoformat()
                if cliente.get('fecha_actualizacion') and isinstance(cliente['fecha_actualizacion'], datetime):
                    cliente['fecha_actualizacion'] = cliente['fecha_actualizacion'].isoformat()
            
            current_app.logger.info(f"  Se obtuvieron {len(clientes)} clientes")
            
            cursor.close()
            connection.close()
            
            return {
                'success': True,
                'data': clientes,
                'total': len(clientes),
                'es_admin': rol_usuario == 'ADMINISTRADOR'
            }, 200
            
        except Error as e:
            current_app.logger.error(f"  Error SQL: {e}")
            print(f"  Error SQL: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        current_app.logger.error(f"  Error general: {e}", exc_info=True)
        print(f"  Error general: {e}")
        import traceback
        traceback.print_exc()
        return {'success': False, 'error': f'Error del servidor: {str(e)}'}, 500


def listar_todos_clientes_api():
    """API para listar TODOS los clientes (para administradores)"""
    try:
        from flask import current_app
        
        current_app.logger.info("=== LISTAR TODOS LOS CLIENTES (ADMIN) ===")
        
        connection = get_db_connection()
        if not connection:
            current_app.logger.error("Error de conexion al listar todos los clientes")
            return {'success': False, 'error': 'Error de conexion'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Llamar al SP para listar todos los clientes
            current_app.logger.info("Ejecutando SP sp_ListarTodosLosClientes()")
            cursor.execute("CALL sp_ListarTodosLosClientes()")
            clientes = cursor.fetchall()
            
            cursor.close()
            connection.close()
            
            current_app.logger.info(f"✓ Se obtuvieron {len(clientes)} clientes")
            
            return {
                'success': True,
                'data': clientes,
                'total': len(clientes)
            }, 200
            
        except Error as e:
            current_app.logger.error(f"Error SQL al listar todos los clientes: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        from flask import current_app
        current_app.logger.error(f"Error general al listar todos los clientes: {e}", exc_info=True)
        return {'success': False, 'error': f'Error del servidor: {str(e)}'}, 500


def eliminar_cliente_api(num_documento):
    """API para eliminar un cliente por numero de documento"""
    try:
        from flask import session, current_app
        
        # Verificar que el usuario este autenticado
        if not session.get('user_documento'):
            current_app.logger.warning(f"Intento de eliminar cliente sin autenticacion")
            return {'success': False, 'error': 'Usuario no autenticado'}, 401
        
        connection = get_db_connection()
        if not connection:
            current_app.logger.error("Error de conexion al eliminar cliente")
            return {'success': False, 'error': 'Error de conexion'}, 500
        
        try:
            cursor = connection.cursor()
            
            # Variables para los parametros OUT
            cursor.execute("SET @p_eliminado = 0")
            cursor.execute("SET @p_mensaje = ''")
            
            # Llamar al SP para eliminar cliente
            current_app.logger.info(f"Intentando eliminar cliente con documento: {num_documento}")
            cursor.execute("CALL sp_EliminarCliente(%s, @p_eliminado, @p_mensaje)", (num_documento,))
            
            # Obtener los valores de salida
            cursor.execute("SELECT @p_eliminado AS eliminado, @p_mensaje AS mensaje")
            result = cursor.fetchone()
            
            cursor.close()
            connection.close()
            
            if result[0] == 1:  # p_eliminado == 1
                current_app.logger.info(f"Cliente eliminado exitosamente: {num_documento}")
                return {
                    'success': True,
                    'message': result[1]  # p_mensaje
                }, 200
            else:
                current_app.logger.warning(f"No se pudo eliminar cliente {num_documento}: {result[1]}")
                return {
                    'success': False,
                    'error': result[1]
                }, 400
            
        except Error as e:
            current_app.logger.error(f"Error SQL al eliminar cliente {num_documento}: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        from flask import current_app
        current_app.logger.error(f"Error general al eliminar cliente: {e}", exc_info=True)
        return {'success': False, 'error': f'Error del servidor: {str(e)}'}, 500


def obtener_cliente_por_documento_api(num_documento):
    """API para obtener los datos completos de un cliente por su número de documento"""
    try:
        from flask import current_app
        
        current_app.logger.info(f"=== OBTENER CLIENTE POR DOCUMENTO ===")
        current_app.logger.info(f"Documento: {num_documento}")
        
        connection = get_db_connection()
        if not connection:
            current_app.logger.error("Error de conexión al obtener cliente")
            return {'success': False, 'error': 'Error de conexión'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Llamar al SP para obtener los datos del cliente
            current_app.logger.info(f"Ejecutando SP sp_ObtenerClientePorDocumento({num_documento})")
            cursor.execute("CALL sp_ObtenerClientePorDocumento(%s)", (num_documento,))
            
            cliente = cursor.fetchone()
            
            cursor.close()
            connection.close()
            
            if cliente:
                current_app.logger.info(f"✓ Cliente encontrado: {num_documento}")
                return {
                    'success': True,
                    'data': cliente
                }, 200
            else:
                current_app.logger.warning(f"Cliente no encontrado: {num_documento}")
                return {
                    'success': False,
                    'error': 'Cliente no encontrado'
                }, 404
            
        except Error as e:
            current_app.logger.error(f"Error SQL al obtener cliente {num_documento}: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        from flask import current_app
        current_app.logger.error(f"Error general al obtener cliente: {e}", exc_info=True)
        return {'success': False, 'error': f'Error del servidor: {str(e)}'}, 500


def actualizar_cliente_api(num_documento):
    """API para actualizar los datos de un cliente existente"""
    try:
        from flask import session, current_app
        
        data = request.get_json()
        
        current_app.logger.info("=== ACTUALIZAR CLIENTE ===")
        current_app.logger.info(f"Documento a actualizar: {num_documento}")
        
        # Obtener datos del formulario
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
        
        # Obtener el documento del asesor logueado (quien modifica)
        num_documento_modificador = session.get('user_documento', '')
        current_app.logger.info(f"Usuario que modifica: {num_documento_modificador}")
        
        # Datos comerciales
        id_fuente_contacto = data.get('id_fuente_contacto')
        id_proyecto = data.get('id_proyecto')
        id_estado_prospeccion = data.get('id_estado_prospeccion')
        id_tipo_compra = data.get('id_tipo_compra')
        # Campo 'estado' eliminado - se usa estado_prospeccion
        # Campo 'fecha_proximo_seguimiento' eliminado - se maneja en TblClientesSeguimientos
        prioridad = data.get('prioridad', 'Media')
        observaciones = data.get('observaciones', '')
        
        # Validar campos requeridos
        if not all([num_documento, nombres, apellido_paterno, email, celular, direccion, id_distrito]):
            current_app.logger.warning(f"Campos requeridos faltantes al actualizar cliente {num_documento}")
            return {'success': False, 'error': 'Por favor completa todos los campos requeridos'}, 400
        
        current_app.logger.info(f"Cliente a actualizar - Doc: {num_documento}, Email: {email}")
        
        # Convertir valores vacíos a None
        id_fuente_contacto = int(id_fuente_contacto) if id_fuente_contacto else None
        id_proyecto = int(id_proyecto) if id_proyecto else None
        id_estado_prospeccion = int(id_estado_prospeccion) if id_estado_prospeccion else None
        id_tipo_compra = int(id_tipo_compra) if id_tipo_compra else None
        id_distrito = int(id_distrito) if id_distrito else None
        
        connection = get_db_connection()
        if not connection:
            current_app.logger.error("Error de conexión a BD al actualizar cliente")
            return {'success': False, 'error': 'Error de conexión'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            current_app.logger.info(f"Ejecutando SP sp_ActualizarCliente para documento {num_documento}")
            
            # Llamar al SP (18 parámetros - SIN estado, SIN fecha_proximo_seguimiento)
            cursor.execute("""
                CALL sp_ActualizarCliente(
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                )
            """, (
                num_documento, tipo_documento, nombres, apellido_paterno, apellido_materno,
                fecha_nacimiento, genero, estado_civil,
                email, celular,
                direccion, id_distrito,
                id_fuente_contacto, id_proyecto, id_estado_prospeccion, id_tipo_compra,
                prioridad, observaciones
            ))
            
            # El SP retorna SELECT con 'mensaje' y 'exito'
            result = cursor.fetchone()
            
            cursor.close()
            connection.close()
            
            if result and result.get('exito') == 1:
                current_app.logger.info(f"Cliente actualizado exitosamente: {num_documento}")
                return {
                    'success': True,
                    'message': result.get('mensaje', 'Cliente actualizado exitosamente')
                }, 200
            else:
                mensaje = result.get('mensaje', 'Error desconocido') if result else 'Error desconocido'
                current_app.logger.warning(f"No se pudo actualizar cliente {num_documento}: {mensaje}")
                return {'success': False, 'error': mensaje}, 400
                
        except Error as e:
            current_app.logger.error(f"Error SQL al actualizar cliente {num_documento}: {str(e)}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        from flask import current_app
        current_app.logger.error(f"Error general al actualizar cliente", exc_info=True)
        return {'success': False, 'error': f'Error del servidor: {str(e)}'}, 500


# =====================================================
# FUNCIONES DE SEGUIMIENTO DE CLIENTES
# =====================================================

def listar_seguimientos_cliente_api(num_documento):
    """API para listar seguimientos de un cliente"""
    try:
        from flask import current_app
        
        current_app.logger.info(f"=== LISTAR SEGUIMIENTOS cliente: {num_documento} ===")
        
        connection = get_db_connection()
        if not connection:
            current_app.logger.error("Error de conexión")
            return {'success': False, 'error': 'Error de conexión'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Llamar al SP
            cursor.execute("CALL sp_ListarSeguimientosCliente(%s)", (num_documento,))
            seguimientos = cursor.fetchall()
            
            cursor.close()
            connection.close()
            
            current_app.logger.info(f"Se obtuvieron {len(seguimientos)} seguimientos")
            
            return {
                'success': True,
                'data': seguimientos,
                'total': len(seguimientos)
            }, 200
            
        except Error as e:
            current_app.logger.error(f"Error SQL: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        from flask import current_app
        current_app.logger.error(f"Error general: {e}", exc_info=True)
        return {'success': False, 'error': 'Error del servidor'}, 500


def listar_tipos_seguimiento_api():
    """API para listar tipos de seguimiento disponibles"""
    try:
        from flask import current_app
        
        current_app.logger.info("=== LISTAR TIPOS DE SEGUIMIENTO ===")
        
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'error': 'Error de conexión'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Llamar al SP
            cursor.execute("CALL sp_ListarTiposSeguimiento()")
            tipos = cursor.fetchall()
            
            cursor.close()
            connection.close()
            
            current_app.logger.info(f"Se obtuvieron {len(tipos)} tipos de seguimiento")
            
            return {
                'success': True,
                'data': tipos,
                'total': len(tipos)
            }, 200
            
        except Error as e:
            current_app.logger.error(f"Error SQL: {e}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        from flask import current_app
        current_app.logger.error(f"Error general: {e}", exc_info=True)
        return {'success': False, 'error': 'Error del servidor'}, 500


def listar_historial_seguimientos_api(num_documento):
    """API para listar el historial completo de seguimientos de un cliente"""
    try:
        from flask import current_app
        from datetime import datetime
        
        current_app.logger.info(f"=== LISTAR HISTORIAL SEGUIMIENTOS ===")
        current_app.logger.info(f"Cliente: {num_documento}")
        
        connection = get_db_connection()
        if not connection:
            current_app.logger.error("Error de conexión a BD")
            return {'success': True, 'data': [], 'total': 0}, 200
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Llamar al SP directamente
            current_app.logger.info(f"Ejecutando SP sp_ListarHistorialSeguimientos({num_documento})")
            cursor.execute("CALL sp_ListarHistorialSeguimientos(%s)", (num_documento,))
            
            historial = cursor.fetchall()
            
            current_app.logger.info(f"Se obtuvieron {len(historial)} seguimientos")
            
            # Convertir datetime a string para JSON
            for seg in historial:
                if seg.get('fecha_seguimiento') and isinstance(seg['fecha_seguimiento'], datetime):
                    seg['fecha_seguimiento'] = seg['fecha_seguimiento'].isoformat()
                if seg.get('fecha_creacion') and isinstance(seg['fecha_creacion'], datetime):
                    seg['fecha_creacion'] = seg['fecha_creacion'].isoformat()
            
            cursor.close()
            connection.close()
            
            current_app.logger.info(f"✓ Historial cargado correctamente")
            
            return {
                'success': True,
                'data': historial,
                'total': len(historial)
            }, 200
            
        except Exception as e:
            current_app.logger.error(f"Error SQL al obtener historial: {str(e)}", exc_info=True)
            if connection.is_connected():
                connection.close()
            return {'success': True, 'data': [], 'total': 0}, 200
    
    except Exception as e:
        from flask import current_app
        current_app.logger.error(f"Error general al obtener historial: {str(e)}", exc_info=True)
        return {'success': True, 'data': [], 'total': 0}, 200


# =====================================================
# FUNCIÓN PARA LISTAR ÚLTIMOS 3 SEGUIMIENTOS
# =====================================================

def listar_ultimos_3_seguimientos_api(num_documento):
    """API para listar los últimos 3 seguimientos de un cliente"""
    try:
        from flask import current_app
        from datetime import datetime
        
        current_app.logger.info(f"=== LISTAR ÚLTIMOS 3 SEGUIMIENTOS ===")
        current_app.logger.info(f"Cliente: {num_documento}")
        
        connection = get_db_connection()
        if not connection:
            current_app.logger.error("Error de conexión a BD")
            return {'success': True, 'data': [], 'total': 0}, 200
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            # Llamar al SP directamente
            current_app.logger.info(f"Ejecutando SP sp_Ultimos3Seguimientos({num_documento})")
            cursor.execute("CALL sp_Ultimos3Seguimientos(%s)", (num_documento,))
            
            ultimos3 = cursor.fetchall()
            
            current_app.logger.info(f"Se obtuvieron {len(ultimos3)} últimos seguimientos")
            
            # Convertir datetime a string para JSON
            for seg in ultimos3:
                if seg.get('fecha_seguimiento') and isinstance(seg['fecha_seguimiento'], datetime):
                    seg['fecha_seguimiento'] = seg['fecha_seguimiento'].isoformat()
                if seg.get('fecha_registro') and isinstance(seg['fecha_registro'], datetime):
                    seg['fecha_registro'] = seg['fecha_registro'].isoformat()
            
            cursor.close()
            connection.close()
            
            current_app.logger.info(f"✓ Últimos 3 seguimientos cargados correctamente")
            
            return {
                'success': True,
                'data': ultimos3,
                'total': len(ultimos3)
            }, 200
            
        except Exception as e:
            current_app.logger.error(f"Error SQL al obtener últimos 3 seguimientos: {str(e)}", exc_info=True)
            if connection.is_connected():
                connection.close()
            return {'success': True, 'data': [], 'total': 0}, 200
    
    except Exception as e:
        from flask import current_app
        current_app.logger.error(f"Error general al obtener últimos 3 seguimientos: {str(e)}", exc_info=True)
        return {'success': True, 'data': [], 'total': 0}, 200


# =====================================================
# FUNCIÓN PARA REGISTRAR SEGUIMIENTO
# =====================================================

def registrar_seguimiento_api():
    """API para registrar un nuevo seguimiento de cliente según sp_RegistrarSeguimiento"""
    try:
        from flask import session, current_app
        
        data = request.get_json()
        
        current_app.logger.info("=== REGISTRAR SEGUIMIENTO ===")
        
        # Obtener datos del formulario
        num_documento_cliente = data.get('num_documento', '').strip()
        id_tipo_seguimiento = data.get('id_tipo_seguimiento')
        fecha_seguimiento = data.get('fecha_seguimiento', '')
        observacion = data.get('observacion', '').strip()
        
        # Obtener el documento del asesor logueado
        realizado_por = session.get('user_documento', '')
        
        current_app.logger.info(f"Cliente: {num_documento_cliente}, Tipo: {id_tipo_seguimiento}, Asesor: {realizado_por}")
        
        # Validar campos requeridos
        if not all([num_documento_cliente, id_tipo_seguimiento, fecha_seguimiento, observacion, realizado_por]):
            current_app.logger.warning("Campos requeridos faltantes al registrar seguimiento")
            return {'success': False, 'error': 'Por favor completa todos los campos'}, 400
        
        # Convertir id_tipo_seguimiento a int
        try:
            id_tipo_seguimiento = int(id_tipo_seguimiento)
        except (ValueError, TypeError):
            current_app.logger.error(f"id_tipo_seguimiento inválido: {id_tipo_seguimiento}")
            return {'success': False, 'error': 'Tipo de seguimiento inválido'}, 400
        
        connection = get_db_connection()
        if not connection:
            current_app.logger.error("Error de conexión a BD al registrar seguimiento")
            return {'success': False, 'error': 'Error de conexión'}, 500
        
        try:
            cursor = connection.cursor(dictionary=True)
            
            current_app.logger.info(f"Ejecutando SP sp_RegistrarSeguimiento")
            
            # El SP espera parámetros IN y OUT
            # Inicializar variables OUT
            cursor.execute("SET @p_id_seguimiento = 0")
            cursor.execute("SET @p_mensaje = ''")
            
            # Llamar al SP con los parámetros correctos
            cursor.execute("""
                CALL sp_RegistrarSeguimiento(
                    %s, %s, %s, %s, %s, @p_id_seguimiento, @p_mensaje
                )
            """, (
                num_documento_cliente,
                id_tipo_seguimiento,
                fecha_seguimiento,
                observacion,
                realizado_por
            ))
            
            # Obtener los valores de salida
            cursor.execute("SELECT @p_id_seguimiento AS id_seguimiento, @p_mensaje AS mensaje")
            result = cursor.fetchone()
            
            cursor.close()
            connection.close()
            
            if result:
                id_seguimiento = result.get('id_seguimiento')
                mensaje = result.get('mensaje', 'Error desconocido')
                
                # El SP retorna un id > 0 si fue exitoso
                if id_seguimiento and id_seguimiento > 0:
                    current_app.logger.info(f"Seguimiento registrado exitosamente: ID {id_seguimiento}")
                    return {
                        'success': True,
                        'message': 'Seguimiento registrado exitosamente',
                        'id_seguimiento': id_seguimiento
                    }, 201
                else:
                    current_app.logger.warning(f"Error al registrar seguimiento: {mensaje}")
                    return {'success': False, 'error': mensaje}, 400
            else:
                current_app.logger.error("No se recibieron datos de salida del SP")
                return {'success': False, 'error': 'Error al registrar el seguimiento'}, 500
                
        except Error as e:
            current_app.logger.error(f"Error SQL al registrar seguimiento: {str(e)}")
            if connection.is_connected():
                connection.close()
            return {'success': False, 'error': f'Error en la base de datos: {str(e)}'}, 500
    
    except Exception as e:
        from flask import current_app
        current_app.logger.error(f"Error general al registrar seguimiento", exc_info=True)
        return {'success': False, 'error': f'Error del servidor: {str(e)}'}, 500
