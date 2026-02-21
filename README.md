# local_aws — instrucciones rápidas

1) Inicializar repo local y subir a un remote (ejemplo con GitHub):

```bash
# desde /home/rserrano/project/local_aws
git init
git add .
git commit -m "Initial commit"
# crear repo remoto en GitHub/Gitlab y luego:
git remote add origin git@github.com:ORG/REPO.git
git push -u origin main
```

2) Clonar el repo en otra máquina/CI y levantar el entorno de desarrollo:

```bash
git clone git@github.com:ORG/REPO.git
cd REPO
docker compose -f docker-compose.dev.yml up --build
```

El `docker-compose.dev.yml` construye la imagen usando `docker/docker_etl/Dockerfile` y monta el código del repo dentro del contenedor en `/usr/src/app`.

3) CI / producción:
- En CI, el job debe hacer `docker build` usando el código del repo (no montar volúmenes).
- Ejecutar tests dentro del pipeline y, si pasan, publicar la imagen a un registry.
