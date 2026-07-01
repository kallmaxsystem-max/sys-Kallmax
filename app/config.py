"""
Configuración de base de datos para KallMax
Lee las credenciales desde variables de entorno
"""
import os
from dotenv import load_dotenv

# Cargar variables de entorno desde .env
load_dotenv()

class DatabaseConfig:
    """Configuración de base de datos"""
    HOST = os.getenv('DB_HOST', 'localhost')
    PORT = int(os.getenv('DB_PORT', 3306))
    USER = os.getenv('DB_USER', 'root')
    PASSWORD = os.getenv('DB_PASSWORD', '')
    DATABASE = os.getenv('DB_NAME', 'kallgwkn_kallmax_bd')
    USE_SSL = os.getenv('DB_USE_SSL', 'false').lower() == 'true'
    
    @classmethod
    def get_connection_params(cls):
        """Retorna diccionario con parámetros de conexión"""
        params = {
            'host': cls.HOST,
            'port': cls.PORT,
            'user': cls.USER,
            'password': cls.PASSWORD,
            'database': cls.DATABASE,
            'autocommit': False,
            'use_pure': True,
        }
        
        # Configurar SSL solo si está habilitado
        if cls.USE_SSL:
            params['ssl_disabled'] = False
        else:
            # Deshabilitar SSL si hay problemas de conexión
            params['ssl_disabled'] = True
        
        return params
