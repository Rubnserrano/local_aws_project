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
        # Configuración de LocalStack
        logger.info("Inicializando cliente S3...")
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
            logger.info(f"Bucket '{self.bucket_name}' ya existe")
        except:
            logger.info(f"Creando bucket '{self.bucket_name}'...")
            self.s3.create_bucket(
                Bucket=self.bucket_name,
                CreateBucketConfiguration={"LocationConstraint": "eu-west-1"}
            )
            logger.info("✅ Bucket creado exitosamente")

    def extract(self):
        # API pública que funciona bien (REST Countries)
        url = "https://restcountries.com/v3.1/all?fields=name,capital,currencies"
        logger.info(f"Obteniendo datos de {url}...")

        try:
            response = requests.get(url, timeout=10)
            response.raise_for_status()  # Lanzar excepción si hay error HTTP
            data = response.json()
            logger.info(f"✅ Se obtuvieron {len(data)} registros de la API")
        except requests.exceptions.RequestException as e:
            logger.error(f"Error al obtener datos de la API: {e}")
            raise

        return data

    def save(self, data):
        # Convertir a line-delimited JSON
        json_data = "\n".join([json.dumps(record) for record in data])

        # Nombre de archivo con timestamp
        filename = f"bronze_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        logger.info(f"Guardando datos en s3://{self.bucket_name}/{filename}...")

        try:
            self.s3.put_object(
                Bucket=self.bucket_name,
                Key=filename,
                Body=json_data.encode("utf-8")
            )
            logger.info(f"✅ Datos guardados exitosamente en S3")
            logger.info(f"📊 Tamaño: {len(json_data)} bytes")
            return filename
        except Exception as e:
            logger.error(f"Error al guardar en S3: {e}")
            raise

    def run(self):
        """Ejecuta el flujo completo: extrae y guarda los datos"""
        logger.info("=" * 50)
        logger.info("Iniciando BronzeExtractor")
        logger.info("=" * 50)
        
        data = self.extract()
        filename = self.save(data)
        
        logger.info("=" * 50)
        logger.info(f"✅ Proceso completado: {filename}")
        logger.info("=" * 50)


if __name__ == "__main__":
    extractor = BronzeExtractor()
    extractor.run()