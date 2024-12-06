from functools import wraps
from flask import request, jsonify
import jwt
from app.config import Config
from app.services.logging_service import LoggerService

# Logger initialization
logger_service = LoggerService()
logger = logger_service.get_logger()

class TokenService:
    def __init__(self):
        self.public_key = Config.JWT_PUBLIC_KEY  # Loaded from .env file
        self.algorithm = Config.JWT_ALGORITHM  # Loaded from .env file
        self.company_id = None

    def verify_token(self, token):
        try:
            decoded_token = jwt.decode(token, self.public_key, algorithms=[self.algorithm], leeway=300)
            logger.info(f"Token valid. Decoded: {decoded_token}")
            self.company_id = decoded_token['company']['company_id']
            return decoded_token, None
        except jwt.ExpiredSignatureError:
            logger.error("Token telah kadaluarsa")
            return None, "Token telah kadaluarsa"
        except jwt.InvalidTokenError as e:
            logger.error(f"Token tidak valid: {e}")
            return None, "Token tidak valid"

    def token_required(self, f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            # Retrieve the token from the Authorization header
            token = request.headers.get('Authorization')
            if not token or not token.startswith('Bearer '):
                logger.error("Token tidak ditemukan atau tidak valid")
                return jsonify({'error': 'Token tidak ditemukan atau tidak valid'}), 403

            # Extract the actual token after 'Bearer '
            token = token.split(' ')[1]  # Extract token after 'Bearer'
            decoded_token, error_message = self.verify_token(token)

            if not decoded_token:
                # Return error response if token is invalid or expired
                return jsonify({'error': error_message}), 403

            # Proceed to the next route function if the token is valid
            return f(*args, **kwargs)

        return decorated_function
