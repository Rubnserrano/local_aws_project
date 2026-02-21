variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
}

variable "provider_alias" {
  description = "Alias del provider AWS a usar"
  type        = any
}

variable "enable_versioning" {
  description = "Habilitar control de versiones"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "Algoritmo de encriptación a usar"
  type        = string
  default     = "AES256"
}

variable "tags" {
  description = "Tags a aplicar al bucket"
  type        = map(string)
  default     = {}
}
