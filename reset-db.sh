#!/bin/bash

echo "SET DB USERNAME"
echo "SET DATABASE_NAME"

USERNAME=postgres

DATABASE_NAME=pam_db

echo "Resetting PSQL DB"

psql -U $USERNAME -c "DROP DATABASE $DATABASE_NAME"
psql -U $USERNAME -c "CREATE DATABASE $DATABASE_NAME"
psql $DATABASE_NAME < ./ddl-scripts/postgresql/postgresql-jbpm-schema.sql
psql $DATABASE_NAME < ./ddl-scripts/postgresql/postgresql-jbpm-lo-trigger-clob.sql
psql $DATABASE_NAME < ./ddl-scripts/postgresql/quartz_tables_postgres.sql