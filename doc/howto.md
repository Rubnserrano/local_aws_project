# Status de local stack:
http://localhost:4566/_localstack/health

# Crear un bucket:
aws s3 mb s3://bronze-bucket --endpoint-url=http://localstack:4566

# Listar archivos del bucket
aws s3 ls s3://bronze-bucket/ --endpoint-url=http://localstack:4566

# Ver contenido de un archivo específico
aws s3 cp s3://bronze-bucket/bronze_20260221_165830.json - --endpoint-url=http://localstack:4566

# Descargar archivo a tu máquina
aws s3 cp s3://bronze-bucket/bronze_20260221_103048.json ./descargado.json --endpoint-url=http://localstack:4566