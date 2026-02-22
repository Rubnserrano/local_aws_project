# SQS module variables
variable "queue_name" {
  description = "Nombre de la cola SQS"
  type        = string
}

variable "tags" {
  description = "Tags a aplicar a la cola SQS"
  type        = map(string)
  default     = {}
}

variable "fifo_queue_bool" {
  description = "Indica si la cola es FIFO (true) o estándar (false)"
  type        = bool
  default     = false
}