# src/bronze/glue_jobs/bronze_job.py
import requests
import boto3
import json
from datetime import datetime

# Configuración de LocalStack
s3 = boto3.client(
    "s3",
    endpoint_url="http://localstack:4566",  # LocalStack endpoint
    aws_access_key_id="test",
    aws_secret_access_key="test",
    region_name="us-east-1"
)

# API pública de ejemplo
url = "https://jsonplaceholder.typicode.com/posts"
response = requests.get(url)
data = response.json()

# Convertir a line-delimited JSON
json_data = "\n".join([json.dumps(record) for record in data])

# Nombre de archivo con timestamp
filename = f"bronze_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"

# Guardar en S3
s3.put_object(
    Bucket="bronze-bucket",
    Key=filename,
    Body=json_data.encode("utf-8")
)

print(f"Datos guardados en s3://bronze-bucket/{filename}")