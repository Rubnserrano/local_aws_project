variable "aws_region" {
  description = "Región de AWS (simulada por LocalStack)"
  type        = string
  default     = "eu-west-1"
}

variable "aws_access_key" {
  description = "AWS Access Key (LocalStack test)"
  type        = string
  default     = "test"
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key (LocalStack test)"
  type        = string
  default     = "test"
  sensitive   = true
}

variable "localstack_endpoint" {
  description = "LocalStack endpoint URL"
  type        = string
  default     = "http://localstack:4566"
}

variable "environment" {
  description = "Nombre del ambiente (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "bronze_bucket_name" {
  description = "Nombre del bucket de bronze"
  type        = string
  default     = "bronze-bucket"
}

variable "silver_bucket_name" {
  description = "Nombre del bucket de silver"
  type        = string
  default     = "silver-bucket"
}

variable "gold_bucket_name" {
  description = "Nombre del bucket de gold"
  type        = string
  default     = "gold-bucket"
}

variable "landing_bucket_name" {
  description = "Nombre del bucket de landing"
  type        = string
  default     = "landing-bucket"
}

variable "landing_failed_bucket_name" {
  description = "Nombre del bucket de landing para datos fallidos"
  type        = string
  default     = "landing-failed-bucket"
}

variable "tags" {
  description = "Tags comunes para todos los recursos"
  type        = map(string)
  default = {
    Project     = "localstack-etl"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
