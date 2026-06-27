#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Funciones generales compartidas
- Conexion a BD
- Hash de passwords
- Ubicaciones (departamentos, provincias, distritos)
- Catalogos (roles, areas, cargos)
- Datos de clientes (fuentes, proyectos, estados, tipos)
"""

import mysql.connector
from mysql.connector import Error
import hashlib
from app.config import DatabaseConfig


def get_db_connection():
    """Crear conexion a la base de datos usando configuracion desde .env"""
    try:
        connection = mysql.connector.connect(**DatabaseConfig.get_connection_params())
        return connection
    except Error as e:
        print(f"Error de conexion: {e}")
        return None


def hash_password(password):
    """Encriptar contrasena usando SHA-256"""
    return hashlib.sha256(password.encode()).hexdigest()


def get_departamentos():
    """Obtener lista de departamentos"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'error': 'Error de conexion'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print("DEBUG: Consultando TblDepartamentos...")
        cursor.execute("""
            SELECT id_departamento, nombre
            FROM TblDepartamentos
            ORDER BY nombre
        """)
        departamentos = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        print(f"DEBUG: Departamentos obtenidos: {len(departamentos)}")
        return departamentos
        
    except Error as e:
        print(f"ERROR: {e}")
        return {'error': f'Error: {str(e)}'}, 500



def get_provincias(id_departamento):
    """Obtener lista de provincias por departamento"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'error': 'Error de conexion'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print(f"DEBUG: Consultando TblProvincias para id_departamento={id_departamento}...")
        cursor.execute("""
            SELECT id_provincia, nombre, id_departamento
            FROM TblProvincias
            WHERE id_departamento = %s
            ORDER BY nombre
        """, (id_departamento,))
        provincias = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        print(f"DEBUG: Provincias obtenidas: {len(provincias)}")
        return provincias
        
    except Error as e:
        print(f"ERROR: {e}")
        return {'error': f'Error: {str(e)}'}, 500


def get_distritos(id_provincia):
    """Obtener lista de distritos por provincia"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'error': 'Error de conexion'}, 500
        
        cursor = connection.cursor(dictionary=True)
        
        print(f"DEBUG: Consultando TblDistritos para id_provincia={id_provincia}...")
        cursor.execute("""
            SELECT id_distrito, nombre, id_provincia
            FROM TblDistritos
            WHERE id_provincia = %s
            ORDER BY nombre
        """, (id_provincia,))
        distritos = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        print(f"DEBUG: Distritos obtenidos: {len(distritos)}")
        return distritos
        
    except Error as e:
        print(f"ERROR: {e}")
        return {'error': f'Error: {str(e)}'}, 500


def get_roles():
    """Obtener listado de roles disponibles"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
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
    """Obtener listado de areas disponibles"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
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
        return {'success': False, 'message': 'Error al obtener areas'}, 500


def get_cargos(id_area=None):
    """Obtener listado de cargos disponibles, opcionalmente filtrados por area"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
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



def get_fuentes_contacto_api():
    """API para obtener lista de fuentes de contacto"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
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
            return {'success': False, 'message': 'Error de conexion'}, 500
        
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
    """API para obtener lista de estados de prospeccion"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
        cursor = connection.cursor(dictionary=True)
        cursor.execute("CALL sp_ListarEstadosProspeccion()")
        estados = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return estados, 200
        
    except Error as e:
        print(f"Error: {e}")
        return {'success': False, 'message': 'Error al obtener estados de prospeccion'}, 500


def get_tipos_compra_api():
    """API para obtener lista de tipos de compra"""
    try:
        connection = get_db_connection()
        if not connection:
            return {'success': False, 'message': 'Error de conexion'}, 500
        
        cursor = connection.cursor(dictionary=True)
        cursor.execute("CALL sp_ListarTiposCompra()")
        tipos = cursor.fetchall()
        
        cursor.close()
        connection.close()
        
        return tipos, 200
        
    except Error as e:
        print(f"Error: {e}")
        return {'success': False, 'message': 'Error al obtener tipos de compra'}, 500
