from flask import Flask
import os

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
