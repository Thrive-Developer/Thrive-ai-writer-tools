from app import create_app
from app.services.logging_service import LoggerService

# Inisialisasi logger
logger_service = LoggerService()
logger = logger_service.get_logger()

logger.info("Logger initialized")  # Mengganti print dengan logger.info

app = create_app()
logger.info("App created")  # Mengganti print dengan logger.info

if __name__ == '__main__':
    logger.info("Starting Flask application...")  # Mengganti print dengan logger.info
    try:
        app.run(debug=True)
    except Exception as e:
        logger.error(f"An error occurred: {e}")  # Menggunakan logger.error untuk error handling
