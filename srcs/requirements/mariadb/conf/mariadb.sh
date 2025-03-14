#!/bin/bash

# Start MariaDB service
service mariadb start

# Wait for MariaDB to fully start
sleep 5

# Check if the database is already initialized
if [ -d /var/lib/mysql/${WORDPRESS_NAME} ]; then
    echo "Database already initialized."
else
    echo "Initializing database..."
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_NAME};"
    mysql -u root -e "CREATE USER IF NOT EXISTS 'omghazi'@'%' IDENTIFIED BY '1111';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON ${WORDPRESS_NAME}.* TO 'omghazi'@'%';"
    mysql -u root -e "FLUSH PRIVILEGES;"
fi

# Keep the container running
tail -f /dev/null
