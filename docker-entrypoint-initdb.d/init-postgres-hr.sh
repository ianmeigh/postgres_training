#!/bin/bash
set -e

# Create a new database
psql -U $POSTGRES_USER -d postgres -c "CREATE DATABASE pghr;"

# Import the data into the database
psql -U $POSTGRES_USER -f pgex/pgex_backup.pgsql -d pghr -x -q

# Grant all privileges to your user
psql -U $POSTGRES_USER -d pghr -c "GRANT ALL PRIVILEGES ON DATABASE pghr TO $POSTGRES_USER;"
psql -U $POSTGRES_USER -d pghr -c "ALTER SCHEMA public OWNER TO $POSTGRES_USER;"

