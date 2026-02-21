# src/bronze/glue_jobs/bronze_job.py
import requests
import boto3
import json
import logging
from datetime import datetime

# Configurar logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class BronzeExtractor:
    def __init__(self):
        logger.info("Initializing S3 Client...")
        self.s3 = boto3.client(
            "s3",
            endpoint_url="http://localstack:4566",  # LocalStack endpoint
            aws_access_key_id="test",
            aws_secret_access_key="test",
            region_name="eu-west-1"
        )
        self.bucket_name = "bronze-bucket"
        self._ensure_bucket()

    def _ensure_bucket(self):
        try:
            self.s3.head_bucket(Bucket=self.bucket_name)
            logger.info(f"Bucket '{self.bucket_name}' already exists")
        except:
            logger.info(f"Creating bucket '{self.bucket_name}'...")
            self.s3.create_bucket(
                Bucket=self.bucket_name,
                CreateBucketConfiguration={"LocationConstraint": "eu-west-1"}
            )
            logger.info("Bucket created successfully")

    def extract(self):
        url = "https://restcountries.com/v3.1/all?fields=name,capital,currencies"
        logger.info(f"Extracting data from {url}...")

        try:
            response = requests.get(url, timeout=10)
            response.raise_for_status()  # Return HTTPError for bad responses
            data = response.json()
            logger.info(f"Successfully extracted {len(data)} records from API")
        except requests.exceptions.RequestException as e:
            logger.error(f"Error extracting data from API: {e}")
            raise

        return data

    def save(self, data):
        json_data = "\n".join([json.dumps(record) for record in data])

        # Nombre de archivo con timestamp
        filename = f"bronze_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        logger.info(f"Saving data to s3://{self.bucket_name}/{filename}...")

        try:
            self.s3.put_object(
                Bucket=self.bucket_name,
                Key=filename,
                Body=json_data.encode("utf-8")
            )
            logger.info(f"Data saved successfully to s3://{self.bucket_name}/{filename}")
            return filename
        except Exception as e:
            logger.error(f"Error saving data to S3: {e}")
            raise

    def run(self):
        """Ejecuta el flujo completo: extrae y guarda los datos"""
        logger.info("=" * 50)
        logger.info("Iniciando BronzeExtractor")
        logger.info("=" * 50)
        
        data = self.extract()
        filename = self.save(data)
        
        logger.info("=" * 50)
        logger.info(f"Process completed: {filename}")
        logger.info("=" * 50)


if __name__ == "__main__":
    extractor = BronzeExtractor()
    extractor.run()