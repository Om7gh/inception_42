#!/bin/bash

cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html
mv wp-cli.phar /usr/local/bin/wp

until mysqladmin ping -h mariadb -u"${MARIADB_USER}" -p"${MARIADB_PASSWORD}" --silent; do
  sleep 2
done

wp core download --allow-root
wp config create \
    --dbname=${MARIADB_NAME} \
    --dbuser=${MARIADB_USER} \
    --dbpass=${MARIADB_PASS} \
    --dbhost=${MARIADB_HOST} --allow-root

wp core install \
    --url=${MARIADB_DOMAINE} \
    --title=${WORDPRESS_TITLE} \
    --admin_user=${WORDPRESS_USER} \
    --admin_password=${WORDPRESS_PASS} \
    --admin_email=${WORDPRESS_EMAIL} --allow-root

wp user create ${WORDPRESS_USER_NAME} ${WORDPRESS_USER_EMAIL} \
    --user_pass=${WORDPRESS_USER_PASS} \
    --role=${WORDPRESS_USER_ROOL} --allow-root

wp theme install twentysixteen --activate --allow-root
wp plugin install redis-cache --activate --allow-root
wp config set WP_REDIS_HOST 'redis' --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root
wp redis enable --allow-root

mkdir -p /run/php

sed -i 's/\/run\/php\/php8.2-fpm.sock/9000/' /etc/php/8.2/fpm/pool.d/www.conf

exec /usr/sbin/php-fpm8.2 -F
