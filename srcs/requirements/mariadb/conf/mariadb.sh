#!/bin/bash

# Start MariaDB temporarily to set up users
mysqld_safe --skip-networking --socket=/var/run/mysqld/mysqld.sock &

# Wait for MariaDB to be ready
for i in {1..30}; do
    mysqladmin ping --socket=/var/run/mysqld/mysqld.sock >/dev/null 2>&1 && break
    sleep 1
done

# Create database and user with proper permissions
mysql --socket=/var/run/mysqld/mysqld.sock <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MARIADB_NAME}\`;
    CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASS}';
    GRANT ALL ON \`${MARIADB_NAME}\`.* TO '${MARIADB_USER}'@'%';
    GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO '${MARIADB_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Shutdown temporary instance
mysqladmin shutdown --socket=/var/run/mysqld/mysqld.sock

# Start final instance
exec mysqld_safe --bind-address=0.0.0.0 --port=3306 --user=root
