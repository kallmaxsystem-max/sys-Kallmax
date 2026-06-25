from flask import Blueprint

# Create blueprints
main_bp = Blueprint('main', __name__)
tasks_bp = Blueprint('tasks', __name__)
calendar_bp = Blueprint('calendar', __name__)
analytics_bp = Blueprint('analytics', __name__)
team_bp = Blueprint('team', __name__)
settings_bp = Blueprint('settings', __name__)
help_bp = Blueprint('help', __name__)
auth_bp = Blueprint('auth', __name__)

# Import routes after blueprints are created
from . import main, tasks, calendar, analytics, team, settings, help, auth
