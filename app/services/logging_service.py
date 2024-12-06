import logging
import os

class LoggerService:
    def __init__(self, log_file='cron_job.log'):
        current_dir = os.path.dirname(os.path.abspath(__file__))
        log_dir = os.path.join(current_dir, '..', 'logs')
        if not os.path.exists(log_dir):
            os.makedirs(log_dir)

        log_file_path = os.path.join(log_dir, log_file)

        # Konfigurasi logging
        logging.basicConfig(
            filename=log_file_path,
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        self.logger = logging.getLogger()

    def get_logger(self):
        return self.logger
