# w3resiource postgres exercises in docker
This project is a docker container containing postgres with a database preloaded with the data from [w3resource](https://www.w3resource.com/postgresql-exercises/join/)'s postgres exercises.

## Running the container

```sh
docker-compose up --build --detach db
```

On subsequent runs you don't need the `--build` flag.

## Connecting to the database

Here are two ways you can connect to the database and run queries (pick one). Running `psql` in the container is likely the easiest as it has no additional dependencies. You can also run queries directly from SQL files from inside or outside the container, discussed [here](#running-queries-from-sql-files).

If you have another tool you like to use, you can connect to postgres on port `5432`, database name `pghr`.


### With `psql` in the container

```sh
docker-compose exec --user postgres db psql pghr 
```

### With `psql` on the host

Requires `psql` to be installed and configured on your machine.

```sh
psql --user postgres --host localhost --port 5432 pghr
```

## Running queries from SQL files

### Directly from your terminal 

The quickest way to get started running custom sql files is to run the following command once the container is running:

```sh
docker-compose exec --user postgres db psql -d pghr -f ./queries/hello-world.sql
```

This will run the sql query file `hello-world.sql` file located in the `/queries` folder. Modify this file or add you own - just replace "hello-world.sql" in the above command with the name of your sql file. Any other folders you create inside the queries folder will also be accessible, so you can organise your SQL files as you wish within this folder.

### From inside the docker

First launch the container with a bash shell -

```sh 
docker-compose exec --user postgres db bash 
```

With the container running, navigate to the `queries` folder.  Queries can then be run using the psql command, specifying the filename and database - for example, to run the example "test.sql" file: 

```sh
psql -f hello-world.sql -d pghr
```

Add new SQL files to the `queries` directory to make them available in the container at `/queries`.
