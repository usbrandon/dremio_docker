# Dremio docker-compose

Inspired from [Datafuel Respository](https://github.com/datafuel/dremio_docker)

## About
Local setup for Dremio on docker-compose
A named volume will be created by Docker Compose. It is typically named dremio_docker_dremio.
The first part of the name dremio_docker is from the folder name of your docker compose file, the second part comes from the container name within the compose file.
Please make adjustment to the commands for your environment.

## Dependency
It would be a good idea to visit https://github.com/usbrandon/minio_docker and get MinIO up and going so you can use it with this repository.

## Quickstart
1. Clone repo `git clone https://github.com/datafuel/dremio_docker.git`
2. Run `cd dremio_docker`
3. Rename **.env.example** to **.env** and replace dummy values with yours
4. Create a docker network for Dremio and MinIO to communicate with.
   **docker network create data-network**
5. Make sure minio is up and going
6. Run `docker-compose up` then access the services

## Tutorials

###Upgrading and maintaining Dremio.

When upgrading, you should do two thing.
1. Back up the volume that stores all the runtime data and configuration of Dremio at the current version you were running, i.e. 24.0
   I recommend Bret Fishers vackup command on Linux, see https://github.com/BretFisher/docker-vackup
   If you are using Docker Desktop, then use their new Volume Backup & Share functionality.
2. Then you can run a docker container against a newer image, overriding the entrypoint, and pass in commands to upgrade the KVStore.
   Example:
   ** docker run --entrypoint /opt/dremio/bin/dremio-admin --mount source=dremio_docker_dremio,target=/opt/dremio/data dremio/dremio-oss:24.0 upgrade**

### Maintaining jobs, compaction, orphan cleanup etc.

To maintain the databases Dremio uses stored on the Docker Volume, you can run commands overriding the entrypoint configured for the default dremio/dremio-oss:23.0 image
or 'docker exec -it' your way inside the container to run /opt/dremio/bin/dremio-admin commands.  Examples of running externally are shown in dremio-admin-clean.sh

Example:
**docker run --entrypoint /opt/dremio/bin/dremio-admin --mount source=dremio_docker_dremio,target=/opt/dremio/data dremio/dremio-oss:23.0 clean --reindex-data**

### Configuring S3 for Minio (source : [Dremio Docs](https://docs.dremio.com/data-sources/s3.html#configuring-s3-for-minio))

To configure your **S3 source** for **Minio** in the Dremio UI:

1. Under *Advanced Options*, check **Enable compatibility mode (experimental)**.
2. Under *Advanced Options > Connection Properties*, add **fs.s3a.path.style.access** and set the value to **true**.
3. Under *Advanced Options > Connection Properties*, add the **fs.s3a.endpoint** property and its corresponding server endpoint value (*minio:9000* in the ecosystem).
