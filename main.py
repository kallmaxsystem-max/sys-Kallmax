import os
from app import create_app

# Crear la aplicación Flask
app = create_app()

# Configuración según el entorno
if os.environ.get('RAILWAY_ENVIRONMENT'):
    app.config['DEBUG'] = False
else:
    app.config['DEBUG'] = True

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=app.config['DEBUG'], host='0.0.0.0', port=port)
