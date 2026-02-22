output "bronze_bucket_name" {
  description = "Nombre del bucket Bronze"
  value       = module.s3_bronze.bucket_id
}

output "silver_bucket_name" {
  description = "Nombre del bucket Silver"
  value       = module.s3_silver.bucket_id
}

output "gold_bucket_name" {
  description = "Nombre del bucket Gold"
  value       = module.s3_gold.bucket_id
}

output "bronze_bucket_arn" {
  description = "ARN del bucket Bronze"
  value       = module.s3_bronze.bucket_arn
}

output "silver_bucket_arn" {
  description = "ARN del bucket Silver"
  value       = module.s3_silver.bucket_arn
}

output "gold_bucket_arn" {
  description = "ARN del bucket Gold"
  value       = module.s3_gold.bucket_arn
}

output "s3_buckets" {
  description = "Resumen de todos los buckets creados"
  value = {
    bronze = {
      name = module.s3_bronze.bucket_id
      arn  = module.s3_bronze.bucket_arn
      tier = "raw_data"
    }
    silver = {
      name = module.s3_silver.bucket_id
      arn  = module.s3_silver.bucket_arn
      tier = "cleaned_data"
    }
    gold = {
      name = module.s3_gold.bucket_id
      arn  = module.s3_gold.bucket_arn
      tier = "analytics_ready"
    }
  }
}
