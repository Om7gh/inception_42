#!/bin/bash

service mariadb start
mariadb -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_NAME}"
mariadb -e "CREATE USER IF NOT EXISTS '${WORDPRESS_USER}'@'%' IDENTIFIED BY '${WORDPRESS_PASS}'"
mariadb -e "GRANT ALL ON ${WORDPRESS_NAME}.* TO '${WORDPRESS_USER}'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mysqladmin shutdown -u root
mysqld --bind-address=0.0.0.0 --port=3306 --user=root
