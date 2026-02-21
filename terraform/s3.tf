// Bucket Bronze (datos crudos)
resource "aws_s3_bucket" "bronze" {
  bucket = "${var.bronze_bucket_name}-${var.environment}"

  tags = merge(
    var.tags,
    {
      Name = "Bronze Bucket"
      Tier = "bronze"
    }
  )
}

// Bucket Silver (datos limpios)
resource "aws_s3_bucket" "silver" {
  bucket = "${var.silver_bucket_name}-${var.environment}"

  tags = merge(
    var.tags,
    {
      Name = "Silver Bucket"
      Tier = "silver"
    }
  )
}

// Bucket Gold (datos analíticos)
resource "aws_s3_bucket" "gold" {
  bucket = "${var.gold_bucket_name}-${var.environment}"

  tags = merge(
    var.tags,
    {
      Name = "Gold Bucket"
      Tier = "gold"
    }
  )
}

// Versioning para buckets (buena práctica)
resource "aws_s3_bucket_versioning" "bronze" {
  bucket = aws_s3_bucket.bronze.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "silver" {
  bucket = aws_s3_bucket.silver.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "gold" {
  bucket = aws_s3_bucket.gold.id

  versioning_configuration {
    status = "Enabled"
  }
}

// Server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "bronze" {
  bucket = aws_s3_bucket.bronze.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "silver" {
  bucket = aws_s3_bucket.silver.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "gold" {
  bucket = aws_s3_bucket.gold.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
