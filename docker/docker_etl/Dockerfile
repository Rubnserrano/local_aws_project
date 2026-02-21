# Dockerfile
FROM python:3.12-slim

# Instalar dependencias básicas
RUN apt-get update && apt-get install -y \
    curl wget git build-essential unzip \
    && rm -rf /var/lib/apt/lists/*

# Instalar Terraform (descargar binario de HashiCorp)
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.7.4/terraform_1.7.4_linux_amd64.zip -o /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin/ && \
    rm /tmp/terraform.zip && \
    chmod +x /usr/local/bin/terraform

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