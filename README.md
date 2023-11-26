# PostgreSQL server and pgAdmin4 in docker

A docker container containing a PostgreSQL server preloaded with the data from online postgres exercises and pgAdmin4:

- [w3resource](https://www.w3resource.com/postgresql-exercises/join/)'s
- [pgexercises.com/](https://pgexercises.com/dbfiles/clubdata.sql)
- Optionally, you can add the database used in the [Advanced SQL Bootcamp](https://www.udemy.com/course/advanced-sql-bootcamp/) Udemy course and it will be imported to the PosetgreSQL server during database setup.

## Credits

- Dave Smith [@16000psi](https://github.com/16000psi/postgres_hr) and Joshua Munn for creating the docker containers for w3resource and pgexercises respectively.
- [w3resource.com](https://www.w3resource.com) and [Alisdair Owens](https://pgexercises.com) for creating great online learning resources.

## Running the container

```sh
docker-compose up -d --build 
```

On subsequent runs you don't need the `--build` flag.

## Connecting to the database

There are a few ways you can connect to the database and run queries (pick one):

- Running `psql` in the container is likely the easiest as it has no additional dependencies.
- You can also run queries directly from SQL files from inside or outside the container, discussed [here](#running-queries-from-sql-files).
- If you have another tool you like to use, you can connect to postgres on port `5432`.

### Database names

| w3resources | pgexercises | Udemy course |
| --- | --- | --- |
| pghr | exercises | advanced_sql |

### With `psql` in the container

```sh
docker-compose exec --user postgres db psql DATABASE_NAME
```

### With `psql` on the host

Requires `psql` to be installed and configured on your machine.

```sh
psql --user postgres --host localhost --port 5432 DATABASE_NAME
```

### pgAdmin

1. Open pgAdmin in a browser ([http://127.0.0.1:5050/browser/](http://127.0.0.1:5050/browser/)) and login (default credentials are in the [docker-compose](./docker-compose.yml) file).
1. Register a new server with the details below:

    | Tab | Field | Value |
    | --- | --- | --- |
    | General | Name | [Whatever you like] |
    | Connection | Host name | db |
    | Connection | Port | 5432 |
    | Connection | Maintenance DB | postgres |
    | Connection | Username: | See [docker-compose](./docker-compose.yml) |
    | Connection | Password | See [docker-compose](./docker-compose.yml) |

1. Use the query editor!

## Running queries from SQL files

### Directly from your terminal

The quickest way to get started running custom sql files is to run the following command once the container is running:

```sh
docker-compose exec --user postgres db psql -d DATABASE_NAME -f ./queries/hello-world.sql
```

This will run the sql query file `hello-world.sql` file located in the `/queries` folder. Modify this file or add you own - just replace "hello-world.sql" in the above command with the name of your sql file. Any other folders you create inside the queries folder will also be accessible, so you can organise your SQL files as you wish within this folder.

### From inside the docker

First launch the container with a bash shell -

```sh
docker-compose exec --user postgres db bash 
```

With the container running, navigate to the `queries` folder.  Queries can then be run using the psql command, specifying the filename and database - for example, to run the example "test.sql" file:

```sh
psql -f hello-world.sql -d DATABASE_NAME
```

Add new SQL files to the `queries` directory to make them available in the container at `/queries`.
