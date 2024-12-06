from flask import Flask
from app.routes.web_routes import web_bp
from app.routes.api_routes import api_bp

def create_app():
    app = Flask(__name__, template_folder='templates', static_folder='resources')

    # Register blueprints
    app.register_blueprint(web_bp)
    app.register_blueprint(api_bp, url_prefix='/api/chatbot')

    return app
