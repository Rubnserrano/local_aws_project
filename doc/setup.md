/home/rserrano/project/local_aws/
├── docker/
│   ├── docker-compose.yml          # Orquestación de contenedores
│   └── docker_etl/                 # Dockerfile para servicio ETL
├── src/                            # Código fuente de la aplicación
├── config/                         # Archivos de configuración
├── data/                           # Datos persistentes
└── doc/
    └── setup.txt                   # Documentación


# Estructura del Proyecto Local AWS

## Directorios principales

- **docker/** - Configuración de contenedores Docker
  - `docker-compose.yml` - Orquestación de servicios (LocalStack + ETL)
  - `docker_etl/` - Dockerfile para el contenedor ETL con Python

- **src/** - Código fuente de la aplicación ETL

- **config/** - Archivos de configuración (variables, credenciales, etc.)

- **data/** - Volumen de datos persistente compartido entre contenedores

- **doc/** - Documentación del proyecto

## Cómo ejecutar

```bash
cd docker
docker-compose up
```

LocalStack estará disponible en `http://localhost:4566`