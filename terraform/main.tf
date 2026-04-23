# S3 Buckets for medallion architecture
module "s3_bronze" {
  source = "./modules/s3"
  
  bucket_name   = var.bronze_bucket_name
  tags         = var.tags
  sqs_queue_arn = module.sqs_bronze.queue_arn
}

module "s3_silver" {
  source = "./modules/s3"
  
  bucket_name = var.silver_bucket_name
  tags        = var.tags
}

module "s3_gold" {
  source = "./modules/s3"
  
  bucket_name = var.gold_bucket_name
  tags        = var.tags
}

module "sqs_bronze" {
  source = "./modules/sqs"
  
  queue_name = "bronze-ingestion-queue"
  fifo_queue_bool = false
  tags = var.tags
}

# Commented out - IAM not supported in LocalStack
# module "lambda_bronze_processor" {
#   source = "./modules/lambda"
#   
#   function_name = "bronze-processor"
#   runtime     = "python3.9"
#   handler     = "index.handler"
#   source_file = "../src/lambda/index.py"
#   description = "Process incoming files from bronze queue"
#   timeout     = 60
#   memory_size = 256
#   tags        = var.tags
# }

# resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
#   event_source_arn = module.sqs_bronze.queue_arn
#   function_name    = module.lambda_bronze_processor.function_name
#   enabled         = true
#   batch_size      = 1
# }