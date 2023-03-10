#!/bin/bash
docker run --entrypoint /opt/dremio/bin/dremio-admin --mount source=dremio_docker_dremio,target=/opt/dremio/data dremio/dremio-oss:24.0 clean --delete-orphans
docker run --entrypoint /opt/dremio/bin/dremio-admin --mount source=dremio_docker_dremio,target=/opt/dremio/data dremio/dremio-oss:24.0 clean --delete-orphan-profiles
docker run --entrypoint /opt/dremio/bin/dremio-admin --mount source=dremio_docker_dremio,target=/opt/dremio/data dremio/dremio-oss:24.0 clean --reindex-data
docker run --entrypoint /opt/dremio/bin/dremio-admin --mount source=dremio_docker_dremio,target=/opt/dremio/data dremio/dremio-oss:24.0 clean --compact
