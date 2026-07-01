#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Funciones para la gestión de Permisos y Roles
- Crear menús
- Gestionar permisos por rol
- Listar menús
"""

from flask import request
import mysql.connector
from mysql.connector import Error
from app.funciones.funGeneral import get_db_connection


def crear_menu_api():
    """API para crear un nuevo menú en TblMenu usando Stored Procedure"""
    try:
        from flask import jsonify
        
        data = request.get_json() or {}
        
        # Obtener datos (de JSON o form)
        nombre_menu = data.get('nombre_menu', request.form.get('nombre_menu', '')).strip()
        descripcion = data.get('descripcion', request.form.get('descripcion', '')).strip()
        ruta = data.get('ruta', request.form.get('ruta', '')).strip()
        estado = data.get('estado', request.form.get('estado', '')).strip()
        
        # Validar campos requeridos
        if not all([nombre_menu, ruta, estado]):
            return jsonify({'success': False, 'message': 'Faltan campos requeridos (nombre_menu, ruta, estado)'}), 400
        
        connection = get_db_connection()
        if not connection:
            return jsonify({'success': False, 'message': 'Error de conexión'}), 500
        
        cursor = connection.cursor(dictionary=True)
        
        # Usar SP para crear el menú (versión con ruta)
        query = """
            CALL sp_CrearMenu(%s, %s, %s, %s)
        """
        
        cursor.execute(query, (
            nombre_menu,
            descripcion,
            ruta,
            estado
        ))
        
        connection.commit()
        cursor.close()
        connection.close()
        
        return jsonify({
            'success': True,
            'message': 'Menú creado exitosamente',
            'data': {
                'nombre_menu': nombre_menu,
                'ruta': ruta,
                'estado': estado
            }
        }), 201
        
    except Error as e:
        print(f"Error en crear_menu_api: {e}")
        return jsonify({'success': False, 'message': f'Error de BD: {str(e)}'}), 500
    except Exception as e:
        print(f"Error general en crear_menu_api: {e}")
        return jsonify({'success': False, 'message': f'Error del servidor: {str(e)}'}), 500


def listar_menus_api():
    """API para obtener lista de menús"""
    try:
        from flask import jsonify
        
        connection = get_db_connection()
        if not connection:
            return jsonify({'success': False, 'message': 'Error de conexión'}), 500
        
        cursor = connection.cursor(dictionary=True)
        
        # Usar SP para obtener menús
        cursor.execute("CALL sp_ListarMenus()")
        menus = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return jsonify({
            'success': True,
            'data': menus,
            'total': len(menus)
        }), 200
        
    except Error as e:
        print(f"Error en listar_menus_api: {e}")
        return jsonify({'success': False, 'message': f'Error de BD: {str(e)}'}), 500
    except Exception as e:
        print(f"Error general en listar_menus_api: {e}")
        return jsonify({'success': False, 'message': f'Error del servidor: {str(e)}'}), 500


def obtener_menu_por_id_api(id_menu):
    """API para obtener datos de un menú específico"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        # Usar SP para obtener menú
        cursor.execute("CALL sp_ObtenerMenu(%s)", (id_menu,))
        menu = cursor.fetchone()
        
        cursor.close()
        connection.close()
        
        if not menu:
            return {'success': False, 'message': 'Menú no encontrado'}, 404
        
        return {
            'success': True,
            'data': menu
        }, 200
        
    except Error as e:
        print(f"Error en obtener_menu_por_id_api: {e}")
        return {'success': False, 'message': f'Error: {str(e)}'}, 500
    except Exception as e:
        print(f"Error general en obtener_menu_por_id_api: {e}")
        return {'success': False, 'message': f'Error del servidor: {str(e)}'}, 500


def actualizar_menu_api(id_menu):
    """API para actualizar un menú existente"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        # Obtener datos del formulario
        nombre_menu = request.form.get('nombre_menu')
        descripcion = request.form.get('descripcion', '')
        icono = request.form.get('icono')
        url = request.form.get('url')
        orden = request.form.get('orden')
        estado = request.form.get('estado')
        
        # Validar campos requeridos
        if not all([nombre_menu, icono, url, orden, estado]):
            cursor.close()
            connection.close()
            return {'success': False, 'message': 'Faltan campos requeridos'}, 400
        
        # Usar SP para actualizar el menú
        query = """
            CALL sp_ActualizarMenu(%s, %s, %s, %s, %s, %s, %s)
        """
        
        cursor.execute(query, (
            id_menu,
            nombre_menu,
            descripcion,
            icono,
            url,
            int(orden),
            estado
        ))
        
        connection.commit()
        cursor.close()
        connection.close()
        
        return {
            'success': True,
            'message': 'Menú actualizado exitosamente'
        }, 200
        
    except Error as e:
        print(f"Error en actualizar_menu_api: {e}")
        return {'success': False, 'message': f'Error: {str(e)}'}, 500
    except Exception as e:
        print(f"Error general en actualizar_menu_api: {e}")
        return {'success': False, 'message': f'Error del servidor: {str(e)}'}, 500


def eliminar_menu_api(id_menu):
    """API para eliminar un menú"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        # Usar SP para eliminar el menú
        cursor.execute("CALL sp_EliminarMenu(%s)", (id_menu,))
        
        connection.commit()
        cursor.close()
        connection.close()
        
        return {
            'success': True,
            'message': 'Menú eliminado exitosamente'
        }, 200
        
    except Error as e:
        print(f"Error en eliminar_menu_api: {e}")
        return {'success': False, 'message': f'Error: {str(e)}'}, 500
    except Exception as e:
        print(f"Error general en eliminar_menu_api: {e}")
        return {'success': False, 'message': f'Error del servidor: {str(e)}'}, 500


def asignar_permiso_rol_api():
    """API para asignar permisos a un rol"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        # Obtener datos del formulario
        id_rol = request.form.get('id_rol')
        id_menu = request.form.get('id_menu')
        tipo_acceso = request.form.get('tipo_acceso')
        
        # Validar campos requeridos
        if not all([id_rol, id_menu, tipo_acceso]):
            cursor.close()
            connection.close()
            return {'success': False, 'message': 'Faltan campos requeridos'}, 400
        
        # Usar SP para asignar permiso
        query = """
            CALL sp_AsignarPermisoRol(%s, %s, %s)
        """
        
        cursor.execute(query, (
            int(id_rol),
            int(id_menu),
            tipo_acceso
        ))
        
        connection.commit()
        cursor.close()
        connection.close()
        
        return {
            'success': True,
            'message': 'Permiso asignado exitosamente'
        }, 200
        
    except Error as e:
        print(f"Error en asignar_permiso_rol_api: {e}")
        return {'success': False, 'message': f'Error: {str(e)}'}, 500
    except Exception as e:
        print(f"Error general en asignar_permiso_rol_api: {e}")
        return {'success': False, 'message': f'Error del servidor: {str(e)}'}, 500


def listar_permisos_rol_api(id_rol):
    """API para obtener permisos de un rol específico"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        # Usar SP para obtener permisos del rol
        cursor.execute("CALL sp_ListarPermisosRol(%s)", (id_rol,))
        permisos = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return {
            'success': True,
            'data': permisos,
            'total': len(permisos)
        }, 200
        
    except Error as e:
        print(f"Error en listar_permisos_rol_api: {e}")
        return {'success': False, 'message': f'Error: {str(e)}'}, 500
    except Exception as e:
        print(f"Error general en listar_permisos_rol_api: {e}")
        return {'success': False, 'message': f'Error del servidor: {str(e)}'}, 500



def crear_submenu_api():
    """API para crear un nuevo submenú en TblSubMenu usando Stored Procedure"""
    try:
        from flask import jsonify
        
        data = request.get_json() or {}
        
        # Obtener datos (de JSON o form)
        id_menu = data.get('id_menu', request.form.get('id_menu', ''))
        nombre_submenu = data.get('nombre_submenu', request.form.get('nombre_submenu', '')).strip()
        descripcion = data.get('descripcion', request.form.get('descripcion', '')).strip()
        estado = data.get('estado', request.form.get('estado', '')).strip()
        
        # Validar campos requeridos
        if not all([id_menu, nombre_submenu, estado]):
            return jsonify({'success': False, 'message': 'Faltan campos requeridos (id_menu, nombre_submenu, estado)'}), 400
        
        connection = get_db_connection()
        if not connection:
            return jsonify({'success': False, 'message': 'Error de conexión'}), 500
        
        cursor = connection.cursor(dictionary=True)
        
        # Usar SP para crear el submenú
        query = """
            CALL sp_CrearSubMenu(%s, %s, %s, %s)
        """
        
        cursor.execute(query, (
            int(id_menu),
            nombre_submenu,
            descripcion,
            estado
        ))
        
        connection.commit()
        cursor.close()
        connection.close()
        
        return jsonify({
            'success': True,
            'message': 'SubMenú creado exitosamente',
            'data': {
                'nombre_submenu': nombre_submenu,
                'estado': estado
            }
        }), 201
        
    except ValueError:
        return jsonify({'success': False, 'message': 'id_menu debe ser un número'}), 400
    except Error as e:
        print(f"Error en crear_submenu_api: {e}")
        return jsonify({'success': False, 'message': f'Error de BD: {str(e)}'}), 500
    except Exception as e:
        print(f"Error general en crear_submenu_api: {e}")
        return jsonify({'success': False, 'message': f'Error del servidor: {str(e)}'}), 500
