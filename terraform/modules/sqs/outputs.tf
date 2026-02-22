# SQS module outputs
output "queue_arn" {
  description = "ARN of the SQS queue"
  value       = aws_sqs_queue.this.arn
}

output "queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.this.id
}

output "dlq_arn" {
  description = "ARN of the dead-letter SQS queue"
  value       = aws_sqs_queue.dlq.arn
}

output "dlq_url" {
  description = "URL of the dead-letter SQS queue"
  value       = aws_sqs_queue.dlq.id
}

# no del todo necesario, es para otros modulos que necesiten saber el nombre de la cosa.
output "queue_name" {
  description = "Name of the SQS queue"
  value       = aws_sqs_queue.this.name
}