# Lambda module variables

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Runtime for Lambda (e.g., python3.9)"
  type        = string
  default    = "python3.9"
}

variable "handler" {
  description = "Handler for Lambda (e.g., index.handler)"
  type        = string
  default    = "index.handler"
}

variable "source_file" {
  description = "Path to the lambda source file"
  type        = string
}

variable "description" {
  description = "Description of the Lambda function"
  type        = string
  default     = "Lambda function created via Terraform"
}

variable "timeout" {
  description = "Timeout in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Memory size in MB"
  type        = number
  default     = 128
}

variable "tags" {
  description = "Tags to apply to the Lambda function"
  type        = map(string)
  default    = {}
}