# S3 Buckets for medallion architecture
module "s3_bronze" {
  source = "./modules/s3"
  
  bucket_name    = var.bronze_bucket_name
  provider_alias = aws.localstack
  tags           = var.tags
}

module "s3_silver" {
  source = "./modules/s3"
  
  bucket_name    = var.silver_bucket_name
  provider_alias = aws.localstack
  tags           = var.tags
}

module "s3_gold" {
  source = "./modules/s3"
  
  bucket_name    = var.gold_bucket_name
  provider_alias = aws.localstack
  tags           = var.tags
}