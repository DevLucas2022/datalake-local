!/bin/bash

docker compose --env-file .env -f trino-hive-postgres-docker-compose.yaml down
docker compose --env-file .env -f trino-hive-postgres-docker-compose.yaml up -d

