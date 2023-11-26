FROM postgres:16

# Copy the sql file for the udemy advanced sql course (not available via link)
COPY ./backups /backups

# Install wget - we'll use it to download the data
RUN apt update && apt install -y wget

# Download the data dumps
RUN wget https://pgexercises.com/dbfiles/clubdata.sql
RUN wget -O pgex.tar.gz "https://www.w3resource.com/postgresql-exercises/pgex.tar.gz"

# Decompress the tar.gz file
RUN tar -xzf pgex.tar.gz

# Remove the downloaded file 
RUN rm pgex.tar.gz

# Scripts in this directory will be run to setup the database
COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

CMD ["postgres"]
