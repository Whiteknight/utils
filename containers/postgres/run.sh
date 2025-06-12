#!/bin/bash

pg_name=postgres
pgadmin_name=pgadmin

if [ ! -d "/c/projects/utils/containers/postgres/data" ]; then
    mkdir -p "/c/projects/utils/containers/postgres/data"
fi

if [[ ! $(docker ps -a --filter="name=$pg_name" | grep -w "$pg_name") ]]; then
    echo "Creating container $pg_name";
    docker run -d \
        --name $pg_name \
        -e POSTGRES_PASSWORD=strongPassword123! \
        -p 5432:5432 \
        -v 'C:\\projects\\utils\\containers\\postgres\\data:/var/lib/postgresql/data' \
        postgres;
else
    echo "Container $pg_name already exists";
fi

db_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $pg_name)

if [[ ! $(docker ps -a --filter="name=$pgadmin_name" | grep -w "$pgadmin_name") ]]; then
    echo "Creating container $pgadmin_name";
    docker run -d \
        --name $pgadmin_name \
        -e PGADMIN_DEFAULT_PASSWORD=strongPassword123! \
        -e PGADMIN_DEFAULT_EMAIL=awhitworth@hc1.com \
        -e PGADMIN_CONFIG_UPGRADE_CHECK_ENABLED=False \
        -p5050:80 \
        dpage/pgadmin4;
else
    echo "Container $pg_name already exists";
fi

if ! command -v psql 2>&1 >/dev/null; then 
    echo "psql command-line tool does not appear to be installed. Get it from:";
    echo "    https://www.postgresql.org/download/"
    echo "or install it with choco:"
    echo "    choco install psql"
fi

echo "Postgres DB available at $db_ip:5432"
echo "    psql -h localhost -U postgres"
echo "pgAdmin4 accessible at http://localhost:5050"
echo "(containers may need to be started)"