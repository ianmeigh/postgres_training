
#!/usr/bin/env bash

psql -U $POSTGRES_USER -f pgex_backup.pgsql.pgsql -d postgres -x -q

# Set the SEARCH_PATH for the database so you don't have to specify the schema in queries
# psql -U $POSTGRES_USER -d dbname -c 'ALTER DATABASE exercises SET SEARCH_PATH TO cd;'
