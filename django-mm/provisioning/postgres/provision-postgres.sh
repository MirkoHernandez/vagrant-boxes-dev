#!/usr/bin/env bash

PG_VERSION=$1

DB_USER=$2
DB_PASSWORD=$3
DB_NAME=$4

# Postgres configuration
echo "Modifying  pg_hba.conf"

PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"
echo "host    all             all             all                     md5" >> "$PG_HBA"

service postgresql restart

# Create role and database
cat << EOF | su - postgres -c psql
-- Create the database role:
CREATE ROLE $DB_USER LOGIN PASSWORD '$DB_PASSWORD';

-- Create the database:
CREATE DATABASE $DB_NAME WITH OWNER=$DB_USER
                                  LC_COLLATE='en_US.utf8'
                                  LC_CTYPE='en_US.utf8'
                                  ENCODING='UTF8'
                                  TEMPLATE=template0;
-- Assign permissions to create database
ALTER ROLE $DB_USER  CREATEDB;
EOF
