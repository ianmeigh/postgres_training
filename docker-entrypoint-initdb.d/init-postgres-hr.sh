
#!/bin/bash
set -e

# Create a new database
psql -U $POSTGRES_USER -d postgres -c "CREATE DATABASE pghr;"

# Import data into the new database
#psql -U $POSTGRES_USER -d pghr -f /docker-entrypoint-initdb.d/data.sql

psql -U $POSTGRES_USER -f pgex/pgex_backup.pgsql -d pghr -x -q

# Grant all privileges to your user
psql -U $POSTGRES_USER -d pghr -c "GRANT ALL PRIVILEGES ON DATABASE pghr TO $POSTGRES_USER;"
psql -U $POSTGRES_USER -d pghr -c "ALTER SCHEMA public OWNER TO $POSTGRES_USER;"

exec "$@"
#!/usr/bin/env bash

#psql -U $POSTGRES_USER -f pgex/pgex_backup.pgsql -d postgres -x -q

# Set the SEARCH_PATH for the database so you don't have to specify the schema in queries
# psql -U $POSTGRES_USER -d dbname -c 'ALTER DATABASE exercises SET SEARCH_PATH TO cd;'
