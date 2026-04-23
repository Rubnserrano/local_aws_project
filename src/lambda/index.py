import json
import boto3
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

s3 = boto3.client(
    "s3",
    endpoint_url="http://localstack:4566",
    aws_access_key_id="test",
    aws_secret_access_key="test",
    region_name="eu-west-1"
)

def handler(event, context):
    logger.info(f"Received event: {event}")
    
    for record in event.get("Records", []):
        body = json.loads(record["body"])
        
        bucket = body["s3_bucket"]
        key = body["s3_key"]
        
        logger.info(f"Processing file: s3://{bucket}/{key}")
        
        response = s3.get_object(Bucket=bucket, Key=key)
        data = response["Body"].read().decode("utf-8")
        
        lines = data.strip().split("\n")
        logger.info(f"Processed {len(lines)} records from {key}")
    
    return {"statusCode": 200, "body": "OK"}