# Last status de proyecto
Estoy inicializando terraform para poder gestionar los recursos de AWS (local AWS con localstack), pero me dio error.

No estoy seguro de que el docker compose instale correctamente el terraform y el unzip necesario

La version de terraform es bastante antigua 1.7.

Me dio este error al hacer terraform apply:

aws_s3_bucket.gold: Creating...
aws_s3_bucket.bronze: Creating...
aws_s3_bucket.silver: Creating...
╷
│ Error: creating S3 Bucket (bronze-bucket-dev): operation error S3: CreateBucket, https response error StatusCode: 0, RequestID: , HostID: , request send failed, Put "http://bronze-bucket-dev.localstack:4566/": dial tcp: lookup bronze-bucket-dev.localstack on 127.0.0.11:53: no such host
│ 
│   with aws_s3_bucket.bronze,
│   on s3.tf line 2, in resource "aws_s3_bucket" "bronze":
│    2: resource "aws_s3_bucket" "bronze" {
│ 
╵
╷
│ Error: creating S3 Bucket (silver-bucket-dev): operation error S3: CreateBucket, https response error StatusCode: 0, RequestID: , HostID: , request send failed, Put "http://silver-bucket-dev.localstack:4566/": dial tcp: lookup silver-bucket-dev.localstack on 127.0.0.11:53: no such host
│ 
│   with aws_s3_bucket.silver,
│   on s3.tf line 15, in resource "aws_s3_bucket" "silver":
│   15: resource "aws_s3_bucket" "silver" {
│ 
╵
╷
│ Error: creating S3 Bucket (gold-bucket-dev): operation error S3: CreateBucket, https response error StatusCode: 0, RequestID: , HostID: , request send failed, Put "http://gold-bucket-dev.localstack:4566/": dial tcp: lookup gold-bucket-dev.localstack on 127.0.0.11:53: no such host
│ 
│   with aws_s3_bucket.gold,
│   on s3.tf line 28, in resource "aws_s3_bucket" "gold":
│   28: resource "aws_s3_bucket" "gold" {
│ 