from flask import Blueprint, render_template, redirect
from app.services.logging_service import LoggerService

logger_service = LoggerService()
logger = logger_service.get_logger()

# Buat blueprint untuk Web routes
web_bp = Blueprint('web', __name__)

# Route Home
@web_bp.route('/')
def home():
    logger.info('Redirecting to /chatbot/')
    return redirect('/chatbot/')

# Route Financial Reports Index
@web_bp.route('/chatbot/')
def index():
    logger.info('Rendering index.html for financial reports')
    return render_template('index.html')

# Route daftarCompanies
@web_bp.route('/chatbot/daftarCompanies')
def daftarCompanies():
    logger.info('Rendering daftarCompanies.html for financial reports')
    return render_template('daftarCompanies.html')
