
FROM postgres:16

# Install wget - we'll use it to download the data
RUN apt update && apt install -y wget

# Download the data dump
RUN wget -O pgex.tar.gz "https://www.w3resource.com/postgresql-exercises/pgex.tar.gz"

# Decompress the tar.gz file
RUN tar -xzf pgex.tar.gz

# Remove the downloaded file 
RUN rm pgex.tar.gz

# Scripts in this directory will be run to setup the database
COPY ./docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

CMD ["postgres"]


