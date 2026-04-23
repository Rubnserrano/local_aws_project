### Technical Debt
- Terraform version seems too old


### TimeLine

- 21/02/2026:
Creación de contenedores localstack y localstack_etl. El objetivo de esta diferenciación es mantener el servicio que simula AWS por un lado, y por otro lado el entorno de desarrollo aislado en el contenedor de docker.
Creación de pequeño script que coge datos de una API pública y lo guarda en un s3.
Inicio de configuración de terraform, errores por providers y localstack


- 22/02/2026
Tras refactorizar modulos terraform en estructuras de carpetas, copilot encontró el error y ya puedo hacer despliegues simples.
Creacion de docu terraform para añadir nuevas cosas, creacion documento de arquitectura para ir explicando decisiones y porque.
Creación de cola SQS y deadletter queue (DLQ) en la que se almacenarán los eventos que llegarán desde S3 al insertar un fichero.
Después esta cola enviara el mensaje a una lambda que procesará el archivo

Next Steps: 
conectar S3 -> SQS
crear la lambda que consuma de SQS