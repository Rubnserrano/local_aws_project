# Lambda module

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = var.source_file
  output_path = "/tmp/${var.function_name}.zip"
}

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name  = var.function_name
  role           = aws_iam_role.lambda_exec.arn
  handler        = var.handler
  runtime        = var.runtime
  description    = var.description
  timeout        = var.timeout
  memory_size    = var.memory_size
  tags           = var.tags
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}