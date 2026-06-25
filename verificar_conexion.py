#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para verificar conexión a la base de datos
"""
import sys
import os

# Agregar el directorio actual al path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

def verificar_conexion():
    """Verificar conexión a la base de datos"""
    try:
        print("=" * 80)
        print("🔍 VERIFICANDO CONEXIÓN A BASE DE DATOS")
        print("=" * 80)
        
        # Cargar configuración
        from app.config import DatabaseConfig
        import mysql.connector
        
        print("\n📋 Configuración actual:")
        print(f"   Host: {DatabaseConfig.HOST}")
        print(f"   Port: {DatabaseConfig.PORT}")
        print(f"   User: {DatabaseConfig.USER}")
        print(f"   Database: {DatabaseConfig.DATABASE}")
        print(f"   Password: {'*' * len(DatabaseConfig.PASSWORD) if DatabaseConfig.PASSWORD else '[NO CONFIGURADO]'}")
        
        print("\n🔌 Intentando conectar...")
        
        connection = mysql.connector.connect(**DatabaseConfig.get_connection_params())
        
        if connection.is_connected():
            db_info = connection.get_server_info()
            cursor = connection.cursor()
            cursor.execute("SELECT DATABASE();")
            record = cursor.fetchone()
            
            print("\n✅ ¡CONEXIÓN EXITOSA!")
            print(f"   Versión MySQL: {db_info}")
            print(f"   Base de datos activa: {record[0]}")
            
            # Verificar algunas tablas
            print("\n📊 Verificando tablas...")
            cursor.execute("SHOW TABLES;")
            tables = cursor.fetchall()
            
            if tables:
                print(f"   Total de tablas: {len(tables)}")
                print(f"   Primeras 5 tablas:")
                for i, table in enumerate(tables[:5], 1):
                    print(f"      {i}. {table[0]}")
            else:
                print("   ⚠️  No se encontraron tablas")
            
            cursor.close()
            connection.close()
            
            print("\n" + "=" * 80)
            print("✅ VERIFICACIÓN COMPLETADA - TODO OK")
            print("=" * 80)
            return True
            
    except Exception as e:
        print("\n❌ ERROR DE CONEXIÓN")
        print(f"   Tipo: {type(e).__name__}")
        print(f"   Mensaje: {str(e)}")
        
        print("\n💡 POSIBLES SOLUCIONES:")
        print("   1. Verificar que el archivo .env existe y tiene las credenciales correctas")
        print("   2. Verificar DB_PASSWORD en el archivo .env")
        print("   3. Si es en Namecheap, verificar que DB_HOST=localhost")
        print("   4. Verificar que la base de datos kallgwkn_kallmax_bd existe")
        
        print("\n" + "=" * 80)
        print("❌ VERIFICACIÓN FALLIDA")
        print("=" * 80)
        return False

if __name__ == '__main__':
    verificar_conexion()
