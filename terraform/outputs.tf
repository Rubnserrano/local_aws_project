output "bronze_bucket_name" {
  description = "Nombre del bucket Bronze"
  value       = aws_s3_bucket.bronze.id
}

output "silver_bucket_name" {
  description = "Nombre del bucket Silver"
  value       = aws_s3_bucket.silver.id
}

output "gold_bucket_name" {
  description = "Nombre del bucket Gold"
  value       = aws_s3_bucket.gold.id
}

output "bronze_bucket_arn" {
  description = "ARN del bucket Bronze"
  value       = aws_s3_bucket.bronze.arn
}

output "silver_bucket_arn" {
  description = "ARN del bucket Silver"
  value       = aws_s3_bucket.silver.arn
}

output "gold_bucket_arn" {
  description = "ARN del bucket Gold"
  value       = aws_s3_bucket.gold.arn
}

output "s3_buckets" {
  description = "Resumen de todos los buckets creados"
  value = {
    bronze = {
      name = aws_s3_bucket.bronze.id
      arn  = aws_s3_bucket.bronze.arn
      tier = "raw_data"
    }
    silver = {
      name = aws_s3_bucket.silver.id
      arn  = aws_s3_bucket.silver.arn
      tier = "cleaned_data"
    }
    gold = {
      name = aws_s3_bucket.gold.id
      arn  = aws_s3_bucket.gold.arn
      tier = "analytics_ready"
    }
  }
}
