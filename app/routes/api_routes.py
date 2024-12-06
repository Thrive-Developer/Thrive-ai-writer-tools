from flask import Blueprint, send_from_directory
from app.services.logging_service import LoggerService
from app.middleware.token_verify import TokenService
from app.logic.api_routes_logic import RouteLogic

logger_service = LoggerService()
logger = logger_service.get_logger()

# Instantiate the service classes
logic_route = RouteLogic()
token_service = TokenService()


# Buat blueprint untuk API routes
api_bp = Blueprint('api', __name__)


@api_bp.route("/keloola-chat-content", methods=["POST"])
def chatbot_file_content():
    return logic_route.chatbot_content()

@api_bp.route("/keloola-chat-content-dis", methods=["POST"])
def chatbot_file_content_dis():
    return logic_route.chatbot_content_dis()