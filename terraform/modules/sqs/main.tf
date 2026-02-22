# SQS module
# TODO: Add SQS configuration

resource "aws_sqs_queue" "this" {
  name = var.queue_name
  fifo_queue = var.fifo_queue_bool
  tags = var.tags
}