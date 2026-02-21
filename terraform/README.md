# Terraform Configuration for LocalStack ETL

## Estructura de carpetas

```
terraform/
├── modules/              # Módulos reutilizables
│   ├── s3/              # Módulo para buckets S3
│   ├── glue/            # Módulo para AWS Glue
│   ├── lambda/          # Módulo para AWS Lambda
│   └── iam/             # Módulo para IAM
├── main.tf              # Configuración principal
├── provider.tf          # Proveedores AWS
├── variables.tf         # Variables
├── outputs.tf           # Outputs
├── locals.tf            # Configuración local
├── terraform.tfvars     # Variables dev (default)
├── terraform.tfvars.staging  # Variables staging
└── terraform.tfvars.prod     # Variables prod
```

## Cómo usar

### Desarrollo local (dev)
```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

### Staging
```bash
cd terraform
terraform init
terraform plan -var-file=terraform.tfvars.staging
terraform apply -var-file=terraform.tfvars.staging -auto-approve
```

### Producción (prod)
```bash
cd terraform
terraform init
terraform plan -var-file=terraform.tfvars.prod
terraform apply -var-file=terraform.tfvars.prod -auto-approve
```

## Comprobar estado

```bash
terraform state list
terraform state show aws_s3_bucket.bronze
terraform output
```

## Destruir recursos

```bash
# Dev
terraform destroy -auto-approve

# Staging
terraform destroy -var-file=terraform.tfvars.staging -auto-approve

# Prod
terraform destroy -var-file=terraform.tfvars.prod -auto-approve
```

## Variables disponibles

- `aws_region`: Región de AWS/LocalStack (default: eu-west-1)
- `environment`: Nombre del ambiente (dev, staging, prod)
- `localstack_endpoint`: URL del endpoint de LocalStack
- `bronze_bucket_name`: Nombre del bucket de bronze
- `silver_bucket_name`: Nombre del bucket de silver
- `gold_bucket_name`: Nombre del bucket de gold
- `tags`: Tags comunes para todos los recursos

## Módulos

### S3 Module
Crea buckets S3 con versionamiento y encriptación.

**Variables:**
- `bucket_name`: Nombre del bucket
- `provider_alias`: Alias del provider (default: aws.localstack)
- `enable_versioning`: Habilitar versionamiento (default: true)
- `encryption_algorithm`: Algoritmo de encriptación (default: AES256)
- `tags`: Tags del bucket

**Outputs:**
- `bucket_id`: ID del bucket
- `bucket_arn`: ARN del bucket
- `bucket_name`: Nombre del bucket

```bash
aws s3 ls --endpoint-url=http://localstack:4566
```

### 5. Destruir recursos (limpiar)

```bash
terraform destroy
```

Elimina todos los recursos. Presiona `yes` para confirmar.

## 📝 Archivos explicados

### provider.tf
- Configura el proveedor AWS
- Apunta a LocalStack en `http://localstack:4566`
- Usa credenciales de prueba (`test`/`test`)

### variables.tf
- Define variables parametrizables
- Permite cambiar nombres, región, etc.

### s3.tf
- Crea 3 buckets: bronze, silver, gold
- Habilita versioning (histórico de cambios)
- Habilita encriptación AES256

### terraform.tfvars
- Valores específicos para el ambiente dev
- Personaliza aquí los nombres de buckets

## 🔄 Workflow típico

```bash
# Día 1: Crear infraestructura
cd terraform/
terraform init
terraform plan
terraform apply

# Días posteriores: Solo verificar
terraform plan    # Ver cambios pendientes
terraform apply   # Aplicar cambios si es necesario

# Al terminar el proyecto
terraform destroy
```

## 💡 Conceptos aprendidos

✅ **Infrastructure as Code (IaC)**: Definir infraestructura en código
✅ **Declarativo vs Imperativo**: Describir QUÉ quieres, no CÓMO hacerlo
✅ **Estado de Terraform**: `.tfstate` guarda el estado actual
✅ **Plan y Apply**: Siempre revisa antes de aplicar
✅ **Variables y Outputs**: Parametrizar y reutilizar configuraciones
✅ **Tags**: Etiquetar recursos para mejor organización

## 📚 Próximos pasos

1. Agregar **AWS Lambda** en `lambda.tf`
2. Agregar **DynamoDB** en `dynamodb.tf`
3. Crear múltiples ambientes (dev, staging, prod)
4. Usar `terraform.auto.tfvars` para secretos

## 🔗 Recursos

- [Documentación Terraform AWS](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [LocalStack + Terraform](https://docs.localstack.cloud/user-guide/integrations/terraform/)
