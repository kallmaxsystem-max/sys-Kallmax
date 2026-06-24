#!/usr/bin/env python3
import sys
import os

# Detectar si estamos en producción (Namecheap) o local
IS_PRODUCTION = os.path.exists('/home/kallgwkn')

if IS_PRODUCTION:
    # Configuración del entorno virtual para producción (Namecheap)
    INTERP = os.path.join(os.environ.get('HOME', '/home/kallgwkn'), 'virtualenv', 'kallmax_app_prod', '3.9', 'bin', 'python3')
    
    # Cambiar al intérprete del entorno virtual si es necesario
    if sys.executable != INTERP:
        os.execl(INTERP, INTERP, *sys.argv)

# Agregar la carpeta de la aplicación al path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# Importar la aplicación Flask desde main.py
from main import app as application

# Configuración según el entorno
if IS_PRODUCTION:
    application.config['DEBUG'] = False
else:
    application.config['DEBUG'] = True

# Para ejecutar en local directamente
if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    application.run(debug=not IS_PRODUCTION, host='0.0.0.0', port=port)
