# Dockerfile
FROM python:3.12-slim

# Instalar dependencias básicas
RUN apt update && apt install -y curl wget git build-essential

# Crear carpeta de trabajo
WORKDIR /app/localstack_etl

# Crear un virtual environment
RUN python3 -m venv /opt/venv

# Activar el venv por defecto
ENV PATH="/opt/venv/bin:$PATH"

# Instalar paquetes comunes de ETL
RUN pip install --upgrade pip
RUN pip install boto3 requests pandas awscli

# Copiar el código del repo dentro de la imagen (útil para build/producción)
COPY . /app/localstack_etl

# Si existe requirements.txt instalar dependencias del proyecto
RUN /bin/sh -c 'if [ -f /app/localstack_etl/requirements.txt ]; then pip install -r /app/localstack_etl/requirements.txt; fi'

# para que no se cierre el contenedor y podamos entrar a la terminal
CMD ["tail", "-f", "/dev/null"]