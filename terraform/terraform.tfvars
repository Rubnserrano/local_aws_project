# Variables para ambiente de desarrollo local con LocalStack

aws_region         = "eu-west-1"
environment         = "dev"
localstack_endpoint = "http://localstack:4566"

bronze_bucket_name = "bronze-bucket"
silver_bucket_name = "silver-bucket"
gold_bucket_name   = "gold-bucket"

tags = {
  Project     = "localstack-etl"
  Environment = "dev"
  ManagedBy   = "terraform"
  CreatedBy   = "your-name"
}
