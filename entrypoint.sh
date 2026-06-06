#!/bin/bash


docker-entrypoint.sh postgres &

echo "Waiting for PostgreSQL to start..."
until pg_isready -h localhost -p 5432 -U "${POSTGRES_USER}"
do    
    sleep 1
done

psql -h localhost -p 5432 -U "${POSTGRES_USER}" -d postgres \
     -v db_password="${DB_PASSWORD}" \
     -f /docker-entrypoint-initdb.d/releases/bootstrap/createdb.sql

sleep 3

cd /docker-entrypoint-initdb.d || exit 1

./lib/liquibase/liquibase --changeLogFile=changelog.xml \
          --url="jdbc:postgresql://localhost:5432/${DB_NAME}" \
          --username="${POSTGRES_USER}" \
          --password="${POSTGRES_PASSWORD}" \
          update

# 5. Keep the container running
tail -f /dev/null
