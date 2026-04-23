import json
import boto3
import logging
from datetime import datetime

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class SilverTransformer:
    def __init__(self):
        logger.info("Initializing S3 Client...")
        self.s3 = boto3.client(
            "s3",
            endpoint_url="http://localstack:4566",
            aws_access_key_id="test",
            aws_secret_access_key="test",
            region_name="eu-west-1"
        )
        self.bronze_bucket = "bronze-bucket"
        self.silver_bucket = "silver-bucket"
        self._ensure_bucket()

    def _ensure_bucket(self):
        try:
            self.s3.head_bucket(Bucket=self.silver_bucket)
            logger.info(f"Bucket '{self.silver_bucket}' already exists")
        except:
            logger.info(f"Creating bucket '{self.silver_bucket}'...")
            self.s3.create_bucket(
                Bucket=self.silver_bucket,
                CreateBucketConfiguration={"LocationConstraint": "eu-west-1"}
            )

    def list_bronze_files(self):
        logger.info("Listing files in bronze bucket...")
        try:
            response = self.s3.list_objects_v2(Bucket=self.bronze_bucket)
            files = [obj["Key"] for obj in response.get("Contents", [])]
            logger.info(f"Found {len(files)} files in bronze bucket")
            return files
        except Exception as e:
            logger.error(f"Error listing files: {e}")
            return []

    def transform_country(self, record):
        transformed = {
            "name": record.get("name", {}).get("common", "Unknown"),
            "official_name": record.get("name", {}).get("official", ""),
            "capital": record.get("capital", [""])[0] if record.get("capital") else "",
            "region": record.get("region", ""),
            "subregion": record.get("subregion", ""),
            "population": record.get("population", 0),
            "area": record.get("area", 0),
            "flags": record.get("flags", {}).get("png", ""),
            "languages": list(record.get("languages", {}).values()) if record.get("languages") else [],
            "currencies": list(record.get("currencies", {}).keys()) if record.get("currencies") else [],
        }
        return transformed

    def transform(self, data):
        logger.info(f"Transforming {len(data)} records...")
        transformed_data = []
        for record in data:
            try:
                transformed = self.transform_country(record)
                transformed_data.append(transformed)
            except Exception as e:
                logger.warning(f"Error transforming record: {e}")
        logger.info(f"Transformed {len(transformed_data)} records")
        return transformed_data

    def save(self, data):
        json_data = "\n".join([json.dumps(record) for record in data])
        filename = f"silver_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        logger.info(f"Saving data to s3://{self.silver_bucket}/{filename}...")

        try:
            self.s3.put_object(
                Bucket=self.silver_bucket,
                Key=filename,
                Body=json_data.encode("utf-8")
            )
            logger.info(f"Data saved successfully to s3://{self.silver_bucket}/{filename}")
            return filename
        except Exception as e:
            logger.error(f"Error saving data to S3: {e}")
            raise

    def run(self):
        logger.info("=" * 50)
        logger.info("Starting Silver Transformer")
        logger.info("=" * 50)
        
        files = self.list_bronze_files()
        if not files:
            logger.warning("No files to process")
            return
        
        latest_file = max(files, key=lambda f: self.s3.head_object(Bucket=self.bronze_bucket, Key=f)["LastModified"])
        logger.info(f"Processing latest file: {latest_file}")
        
        response = self.s3.get_object(Bucket=self.bronze_bucket, Key=latest_file)
        data = response["Body"].read().decode("utf-8")
        
        records = [json.loads(line) for line in data.strip().split("\n") if line]
        transformed = self.transform(records)
        filename = self.save(transformed)
        
        logger.info("=" * 50)
        logger.info(f"Process completed: {filename}")
        logger.info("=" * 50)


if __name__ == "__main__":
    transformer = SilverTransformer()
    transformer.run()