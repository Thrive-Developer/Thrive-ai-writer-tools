import psycopg2
from contextlib import contextmanager
from app.config import Config

class Database:
    def __init__(self, db_config=None):
        # Gunakan konfigurasi database lokal dari Config jika tidak ada db_config yang diberikan
        self.db_config = db_config or Config.DATABASE_CLIENT

    @contextmanager
    def get_connection(self):
        # Membuat koneksi langsung ke database lokal tanpa menggunakan SSH tunneling
        conn = psycopg2.connect(
            dbname=self.db_config['dbname'],
            user=self.db_config['user'],
            password=self.db_config['password'],
            host=self.db_config['host'],
            port=self.db_config['port']
        )
        try:
            yield conn
        finally:
            conn.close()
