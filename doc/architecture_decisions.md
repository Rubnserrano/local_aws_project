### Centralized architecture decisions md where reasons of new architecture changes or features are explained

###### 0.- Landing and landing failed s3 buckets instead of only one bronze s3 bucket
For a simple project like this, i think its better to mantain all the incoming processing files, failed files and processed files in just one bucket. We will divide this three types of result in folders inside the bronze layer.
In a real world project, with a large number of sources and the need for auditing, it may be better to keep the landing and landing faield layers abstracted from the bronze layer.

Bronze bucket/
├── incoming/        (new files, pending processing)
├── processed/       (successfully processed files)
└── failed/          (failed files)

###### 1.- Why S3 event -> SQS -> Lambda instead of S3 event -> EventBridge -> Lambda???
TBD

######  2. S3 → SQS → Lambda para Ingestion

### Decisiones:
- Cola SQS: `bronze-ingestion-queue-dev`
- TTL: 86400 segundos (24 horas)
- Max retries: 3
- Dead Letter Queue: `bronze-ingestion-dlq-dev`

### Flujo:
1. Usuario/cron sube archivo a S3 Bronze
2. S3 dispara evento → SQS recibe mensaje
3. Lambda consume SQS (cada 60 segundos, batch de 10 mensajes)
4. Lambda lee archivo de S3 → procesa con Pandas → guarda en Silver
5. Si falla → reintentos automáticos → DLQ

### IAM Permisos:
- Lambda necesita: s3:GetObject (Bronze), s3:PutObject (Silver), sqs:ReceiveMessage

Alternativa: s3 bronze -> SQS -> Lambda trigger (invokes glue) -> Glue job (data processing) -> S3 Silver