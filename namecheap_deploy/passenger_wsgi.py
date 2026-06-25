#!/usr/bin/env python3
import sys
import os

# Configuración del intérprete para Namecheap
INTERP = os.path.join(os.environ.get('HOME', '/home/kallgwkn'), 'virtualenv', 'kallmax_app', '3.9', 'bin', 'python3')

# Cambiar al intérprete del entorno virtual si es necesario
if sys.executable != INTERP:
    os.execl(INTERP, INTERP, *sys.argv)

# Agregar la carpeta de la aplicación al path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# Importar la aplicación Flask
from main import app as application

# Configuración para producción
application.config['DEBUG'] = False
