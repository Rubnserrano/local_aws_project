# SQS module outputs
output "queue_arn" {
  description = "ARN of the SQS queue"
  value       = module.sqs.queue_arn
}

output "queue_url" {
  description = "URL of the SQS queue"
  value       = module.sqs.queue_url
}

output "queue_name" {
  description = "Name of the SQS queue"
  value       = module.sqs.queue_name
}