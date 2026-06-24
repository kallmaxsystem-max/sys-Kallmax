from flask import render_template, redirect, url_for, session, flash
from . import settings_bp
from functools import wraps

def login_required(f):
    """Decorador para proteger rutas que requieren autenticación"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_email' not in session:
            flash('Debes iniciar sesión para acceder a esta página', 'warning')
            return redirect(url_for('auth.login'))
        return f(*args, **kwargs)
    return decorated_function

@settings_bp.route('/settings')
@login_required
def settings_page():
    return render_template('settings.html')
