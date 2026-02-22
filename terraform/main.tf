# S3 Buckets for medallion architecture
module "s3_bronze" {
  source = "./modules/s3"
  
  bucket_name = var.bronze_bucket_name
  tags        = var.tags
  
  providers = {
    aws = aws.localstack
  }
}

module "s3_silver" {
  source = "./modules/s3"
  
  bucket_name = var.silver_bucket_name
  tags        = var.tags
  
  providers = {
    aws = aws.localstack
  }
}

module "s3_gold" {
  source = "./modules/s3"
  
  bucket_name = var.gold_bucket_name
  tags        = var.tags
  
  providers = {
    aws = aws.localstack
  }
}

module "s3_landing" {
  source = "./modules/s3"
  
  bucket_name = var.landing_bucket_name
  tags        = var.tags
  
  providers = {
    aws = aws.localstack
  }
}

module "s3_landing_failed" {
  source = "./modules/s3"
  
  bucket_name = var.landing_failed_bucket_name
  tags        = var.tags
  
  providers = {
    aws = aws.localstack
  }
}