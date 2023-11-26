#!/bin/bash
set -e

# Create new databases
psql -U $POSTGRES_USER -d postgres -c "CREATE DATABASE pghr;" &> /dev/null

# Import the data into the databases
psql -U $POSTGRES_USER -f pgex/pgex_backup.pgsql -d pghr -x -q -o /dev/null  &> /dev/null
psql -U $POSTGRES_USER -f clubdata.sql -d postgres -x -q &> /dev/null

# Grant all privileges to your user
psql -U $POSTGRES_USER -d pghr -c "GRANT ALL PRIVILEGES ON DATABASE pghr TO $POSTGRES_USER;" &> /dev/null
psql -U $POSTGRES_USER -d pghr -c "ALTER SCHEMA public OWNER TO $POSTGRES_USER;" &> /dev/null

# Set the SEARCH_PATH for the databases so you don't have to specify the schema in queries
psql -U $POSTGRES_USER -d exercises -c 'ALTER DATABASE exercises SET SEARCH_PATH TO cd;' &> /dev/null

# Check to see if udemy DB in SQL folder and run setup steps
FILE=backups/advanced_sql_course-general_hospital_setup.sql

if [ -f "$FILE" ];
then
    echo "Running advanced_sql DB setup"
    psql -U $POSTGRES_USER -d postgres -c "CREATE DATABASE advanced_sql;"
    pg_restore -U $POSTGRES_USER -d advanced_sql backups/advanced_sql_course-general_hospital_setup.sql
    psql -U $POSTGRES_USER -d advanced_sql -c "GRANT ALL PRIVILEGES ON DATABASE advanced_sql TO $POSTGRES_USER;"
    psql -U $POSTGRES_USER -d advanced_sql -c "ALTER SCHEMA general_hospital OWNER TO $POSTGRES_USER;"
    psql -U $POSTGRES_USER -d advanced_sql -c 'ALTER DATABASE advanced_sql SET search_path TO general_hospital, "$user", public;'
else
    echo "Skipped advanced_sql DB setup (missing sql file?)"
fi