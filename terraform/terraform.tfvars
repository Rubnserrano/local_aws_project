# Variables para ambiente de desarrollo local con LocalStack

aws_region         = "eu-west-1"
environment         = "dev"
localstack_endpoint = "http://localstack:4566"

bronze_bucket_name = "bronze-bucket-dev"
silver_bucket_name = "silver-bucket-dev"
gold_bucket_name   = "gold-bucket-dev"

tags = {
  Project     = "localstack-etl"
  Environment = "dev"
  ManagedBy   = "terraform"
  CreatedBy   = "your-name"
}
