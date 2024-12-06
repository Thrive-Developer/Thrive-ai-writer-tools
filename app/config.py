from dotenv import load_dotenv
import os

load_dotenv()

class Config:
    DATABASE_CLIENT = {
        'host': os.getenv('DATABASE_HOST'),
        'port': int(os.getenv('DATABASE_PORT')),
        'dbname': os.getenv('DATABASE_NAME'),
        'user': os.getenv('DATABASE_USERNAME'),
        'password': os.getenv('DATABASE_PASSWORD')
    }
    DATABASE_COMPETITOR = {
        'host': os.getenv('DATABASE_HOST'),
        'port': int(os.getenv('DATABASE_PORT')),
        'dbname': os.getenv('DATABASE_NAME_SECOND'),
        'user': os.getenv('DATABASE_USERNAME'),
        'password': os.getenv('DATABASE_PASSWORD')
    }
    token = os.getenv("token")
    JWT_PRIVATE_KEY = os.getenv("JWT_PRIVATE_KEY").replace('\\n', '\n')
    JWT_PUBLIC_KEY = os.getenv("JWT_PUBLIC_KEY").replace('\\n', '\n')
    JWT_ALGORITHM = os.getenv("JWT_ALGORITHM")
    HUGGING_FACE_API_TOKEN = os.getenv("HUGGING_FACE_API_TOKEN")
    RAPID_API_KEY = os.getenv("RAPID_API_KEY")
    URL_RAPID_API = os.getenv("URL_RAPID_API")
    DIF_RAPID_API_KEY = os.getenv("DIF_RAPID_API_KEY")
    GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
