# Locals para centralizar configuración común
locals {
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "localstack-etl"
    }
  )
}
