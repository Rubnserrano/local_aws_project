# Terraform - Infrastructure as Code para LocalStack

## ¿Qué es Terraform?

Herramienta de **Infrastructure as Code (IaC)** que define infraestructura en código y la ejecuta de forma reproducible.

**Ciclo básico:**
```
terraform init   → Descargar plugins
terraform plan   → Ver cambios (sin ejecutar)
terraform apply  → Ejecutar cambios
```

## Estructura

```
terraform/
├── modules/           # Módulos reutilizables (S3, Glue, Lambda, IAM)
├── main.tf           # Configuración principal
├── provider.tf       # Define AWS/LocalStack
├── variables.tf      # Variables globales
├── outputs.tf        # Outputs/resultados
├── terraform.tfvars  # Valores de variables (DEV)
└── README.md         # Este archivo
```

## Uso rápido

```bash
cd terraform
terraform init
terraform plan      # Siempre verifica antes
terraform apply     # Crear infraestructura
terraform output    # Ver resultados
terraform destroy   # Eliminar todo
```

## Agregar recursos

### 1️⃣ Agregar bucket S3 nuevo (servicio existente)

**En `variables.tf`:**
```hcl
variable "temp_bucket_name" {
  type    = string
  default = "temp-bucket"
}
```

**En `terraform.tfvars`:**
```hcl
temp_bucket_name = "temp-bucket-dev"
```

**En `main.tf`:**
```hcl
module "s3_temp" {
  source      = "./modules/s3"
  bucket_name = var.temp_bucket_name
  tags        = var.tags
  
  providers = { aws = aws.localstack }
}
```

**En `outputs.tf`:**
```hcl
output "temp_bucket_name" {
  value = module.s3_temp.bucket_id
}
```

**Ejecutar:**
```bash
terraform plan
terraform apply
```

---

### 2️⃣ Agregar servicio nuevo (ejemplo: DynamoDB)

**Crear módulo:**
```bash
mkdir -p modules/dynamodb
```

**`modules/dynamodb/main.tf`:**
```hcl
resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = var.tags
}
```

**`modules/dynamodb/variables.tf`:**
```hcl
variable "table_name" { type = string }
variable "tags" { type = map(string) default = {} }
```

**`modules/dynamodb/outputs.tf`:**
```hcl
output "table_id" { value = aws_dynamodb_table.this.id }
```

**En `variables.tf`:**
```hcl
variable "dynamodb_table_name" {
  type    = string
  default = "metadata-table"
}
```

**En `main.tf`:**
```hcl
module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = var.dynamodb_table_name
  tags       = var.tags
  
  providers = { aws = aws.localstack }
}
```

**En `terraform.tfvars`:**
```hcl
dynamodb_table_name = "metadata-table-dev"
```

**Ejecutar:**
```bash
terraform init
terraform plan
terraform apply
```

---

## Ver estado

```bash
terraform state list          # Listar recursos
terraform state show module.s3_bronze.aws_s3_bucket.this
terraform output              # Ver outputs
```

## Troubleshooting

| Error | Solución |
|-------|----------|
| "A managed resource has not been declared" | `terraform state rm 'resource.name'` |
| "Provider configuration not present" | Verifica `provider.tf` tiene `alias = "localstack"` |
| Terraform se cuelga en init | `rm .terraform.lock.hcl && terraform init` |
| LocalStack no responde | `curl http://localstack:4566/_localstack/health` |

## Recursos

- [Documentación Terraform](https://www.terraform.io/docs)
- [LocalStack Docs](https://docs.localstack.cloud)
