from flask import Flask

def create_app():
    app = Flask(__name__, template_folder='templates', static_folder='static')
    
    # Configure session
    app.secret_key = 'your-secret-key-change-in-production'
    
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
