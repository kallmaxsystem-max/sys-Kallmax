from flask import Flask
import os
import logging
from logging.handlers import RotatingFileHandler

# Intentar cargar .env si existe (para Namecheap)
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass  # dotenv no instalado, continuar sin él

def create_app():
    app = Flask(__name__, template_folder='templates', static_folder='static')
    
    # Configure session - usar variable de entorno en producción
    app.secret_key = os.environ.get('SECRET_KEY', 'your-secret-key-change-in-production')
    
    # Configurar logging
    if not app.debug:
        # Crear directorio de logs si no existe
        log_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'logs')
        if not os.path.exists(log_dir):
            os.makedirs(log_dir)
        
        # Archivo de log con rotación (10MB máximo, mantener 5 backups)
        log_file = os.path.join(log_dir, 'kallmax_app.log')
        file_handler = RotatingFileHandler(log_file, maxBytes=10240000, backupCount=5)
        file_handler.setFormatter(logging.Formatter(
            '[%(asctime)s] %(levelname)s in %(module)s: %(message)s'
        ))
        file_handler.setLevel(logging.INFO)
        app.logger.addHandler(file_handler)
        
        app.logger.setLevel(logging.INFO)
        app.logger.info('KallMax Application startup')
    
    # Register blueprints
    from app.routes import main_bp, tasks_bp, calendar_bp, analytics_bp, team_bp, settings_bp, help_bp, auth_bp
    
    app.register_blueprint(main_bp)
    app.register_blueprint(tasks_bp)
    app.register_blueprint(calendar_bp)
    app.register_blueprint(analytics_bp)
    app.register_blueprint(team_bp)
    app.register_blueprint(settings_bp)
    app.register_blueprint(help_bp)
    app.register_blueprint(auth_bp)
    
    return app
