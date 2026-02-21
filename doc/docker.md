# Configuración Docker del Proyecto

## Estructura

```
docker/
├── docker-compose.yml    # Orquestación de servicios
└── docker_etl/
    ├── Dockerfile        # Imagen del contenedor ETL
    └── .dockerignore     # Archivos a ignorar en la build
```

## docker-compose.yml

Define dos servicios:
- **localstack**: Simula servicios AWS (S3, DynamoDB, Lambda, etc.)
- **etl**: Contenedor con el código ETL que procesa datos

**Red interna**: Los servicios se comunican entre sí
- ETL accede a LocalStack en `http://localstack:4566`

## Dockerfile

Pasos:
1. **Base**: Python 3.12 slim (ligero)
2. **Dependencias del SO**: Instala herramientas necesarias (git, curl, etc.)
3. **Virtual Environment**: Crea venv para aislamiento de paquetes
4. **Dependencias Python**: Instala boto3, requests, pandas, etc.
5. **Código**: Copia el proyecto en `/app/localstack_etl`
6. **Punto de entrada**: Shell interactivo para trabajar dentro del contenedor

## .dockerignore

Excluye del contexto de build:
- `.git`, `.venv`, `__pycache__`
- Archivos grandes innecesarios

## Flujo de uso

```bash
docker compose up -d      # Levanta localstack + etl
docker compose exec etl bash   # Accede al contenedor ETL
python src/bronze/gluejob/extractor.py  # Ejecuta el código
```

## Por qué está montado así

✅ **LocalStack**: Simula AWS localmente sin gastar dinero
✅ **Contenedor ETL aislado**: Evita conflictos de dependencias en tu máquina
✅ **Red compartida**: Los servicios se comunican fácilmente
✅ **Venv en Docker**: Python limpio y reproducible