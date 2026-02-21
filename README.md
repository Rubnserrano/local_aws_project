# LocalStack ETL - Plataforma de Datos en AWS

Un proyecto de práctica para aprender a construir una **plataforma de datos moderna en AWS** utilizando **LocalStack**, sin necesidad de una cuenta de AWS real.

## 🎯 ¿Qué es este proyecto?

Este es un proyecto educativo diseñado para practicar la construcción de pipelines de datos (ETL) en AWS usando servicios como:

- **AWS Glue**: jobs de transformación de datos
- **AWS Lambda**: funciones serverless para procesamiento
- **Amazon S3**: almacenamiento de datos
- **Amazon RDS**: bases de datos relacionales
- **Amazon Athena**: consultas SQL sobre datos en S3

Todo esto con **LocalStack**, que simula los servicios de AWS localmente en contenedores Docker.

## ⚙️ ¿Qué es LocalStack?

LocalStack es una plataforma que emula los servicios de AWS en tu máquina local, permitiendo desarrollar y probar aplicaciones sin coste alguno y sin exponer credenciales reales.

**Ventajas:**
- ✅ Desarrollo sin AWS real
- ✅ Tests de integración locales
- ✅ Iteración rápida
- ✅ Cero costes de infraestructura

## 📊 Arquitectura

El proyecto implementa un **data lake** con tres capas (Bronze-Silver-Gold):

```
Bronze (Raw Data) → Silver (Cleaned Data) → Gold (Analytics Ready)
       ↓                    ↓                      ↓
    Lambda            AWS Glue              AWS Glue
    S3 Bucket         S3 Bucket             S3 Bucket
```

**Estructura de carpetas:**

```
src/
├── bronze/        → Datos crudos, ingesta inicial
│   ├── lambda/    → Funciones serverless para capturar datos
│   └── gluejob/   → Jobs de Glue para procesar
│
├── silver/        → Datos limpios y transformados
│   ├── lambda/    
│   └── gluejob/   
│
└── gold/          → Datos listos para análisis
    ├── lambda/    
    └── gluejob/   
```

## 🚀 Quick Start

### Requisitos previos

- Docker y Docker Compose
- Python 3.9+
- Git

### 1. Clonar el repositorio

```bash
git clone <tu-repo>
cd localstack_etl
```

### 2. Levantar el entorno con Docker

```bash
docker compose up --build
```

Esto inicia:
- **LocalStack**: con todos los servicios de AWS simulados
- **ETL Container**: con tus jobs de Glue y Lambdas
- **Base de datos local**: para almacenar metadatos

### 3. Verificar que todo funciona

```bash
# Comprobar que LocalStack está activo
curl http://localhost:4566/_localstack/health

# Ejecutar tests
docker compose exec etl python -m pytest tests/
```

## 📝 Flujo de trabajo

### Desarrollo local

1. Modifica el código en `src/`
2. Docker monta los archivos automáticamente
3. Ejecuta tus tests:
   ```bash
   docker compose exec etl python -m pytest tests/
   ```
4. Los logs están en `data/logs/`

### Estructura de datos

```
data/
├── cache/         → Datos cacheados (machine.json)
├── logs/          → Logs de ejecución
└── tmp/           → Archivos temporales
```

## 🛠 Tecnologías

- **AWS Services**: Glue, Lambda, S3, RDS, Athena
- **LocalStack**: Emulación local de AWS
- **Docker**: Containerización
- **Python**: Scripts de transformación
- **Pytest**: Testing

## 📚 Documentación

- [Setup detallado](doc/setup.md)
- [Configuration](config/settings.json)

## 🔄 CI / Producción

El pipeline CI debe:
1. Ejecutar tests
2. Hacer `docker build` con el código del repo
3. Si pasa, publicar la imagen a un registry (ECR, DockerHub, etc.)

```bash
docker build -t my-etl:latest .
docker push my-registry/my-etl:latest
```

## 💡 Casos de uso de aprendizaje

- ✅ Crear pipelines ETL con Glue
- ✅ Procesar datos con Lambda
- ✅ Organizar datos en buckets S3
- ✅ Consultar datos con Athena
- ✅ Testear localmente antes de AWS
- ✅ Practicar Infrastructure as Code

## 📞 Soporte

Revisa `doc/setup.md` para troubleshooting y configuraciones avanzadas.
