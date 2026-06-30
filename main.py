import os
from app import create_app

# Crear la aplicación Flask
app = create_app()

# Configuración según el entorno
# En Namecheap con Passenger, siempre usar modo producción
if os.environ.get('RAILWAY_ENVIRONMENT') or os.environ.get('PASSENGER_APP_ENV'):
    app.config['DEBUG'] = False
else:
    # En desarrollo local, usar debug
    app.config['DEBUG'] = True

# Forzar modo producción si no es desarrollo local
if not os.environ.get('FLASK_ENV') == 'development':
    app.config['DEBUG'] = False

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(debug=app.config['DEBUG'], host='0.0.0.0', port=port)
