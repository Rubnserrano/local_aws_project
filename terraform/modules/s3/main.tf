resource "aws_s3_bucket" "this" {
  bucket   = var.bucket_name
  provider = aws.localstack
  tags     = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket   = aws_s3_bucket.this.id
  provider = aws.localstack

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket   = aws_s3_bucket.this.id
  provider = aws.localstack

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.encryption_algorithm
    }
  }
}
