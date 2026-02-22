# SQS module
# TODO: Add SQS configuration

resource "aws_sqs_queue" "dlq" {
  name = "${var.queue_name}-dlq"
  tags = var.tags
}

resource "aws_sqs_queue" "this" {
  name = var.queue_name
  fifo_queue = var.fifo_queue_bool
  message_retention_seconds = 600
  visibility_timeout_seconds = 300

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })
  
  tags = var.tags
}

