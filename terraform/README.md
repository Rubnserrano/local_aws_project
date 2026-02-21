# Terraform - Infrastructure as Code para LocalStack

Gestión de recursos AWS (simulados con LocalStack) usando Terraform.

## 📁 Estructura

```
terraform/
├── provider.tf          # Configuración del proveedor AWS (apunta a LocalStack)
├── variables.tf         # Variables configurables
├── s3.tf               # Recursos de S3 (buckets bronze, silver, gold)
├── outputs.tf          # Salidas de Terraform
├── terraform.tfvars    # Valores de variables para dev
└── README.md           # Este archivo
```

## 🚀 Cómo usar

### 1. Inicializar Terraform

```bash
cd terraform/
terraform init
```

Esto descarga el proveedor AWS y prepara el ambiente.

### 2. Ver cambios que se aplicarán

```bash
terraform plan
```

Muestra qué recursos se crearán/modificarán/eliminarán.

### 3. Aplicar la configuración

```bash
terraform apply
```

Crea los buckets S3 en LocalStack. Presiona `yes` para confirmar.

### 4. Verificar recursos creados

```bash
terraform show
```

O desde el contenedor ETL:
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
