#!/bin/bash


cd /var/www/html
chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

for ((i = 1; i <= 10; i++)); do
    if mariadb -h mariadb -P 3306 \
        -u "${MARIADB_USER}" \
        -p"${MARIADB_PASS}" -e "SELECT 1" > /dev/null 2>&1; then
        break
    else
        sleep 2
    fi
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
    --admin_user=${WORDPRESS_NAME} \
    --admin_password=${WORDPRESS_PASS} \
    --admin_email=${WORDPRESS_EMAIL} --allow-root

wp user create ${WORDPRESS_USER_NAME} ${WORDPRESS_USER_EMAIL} \
    --user_pass=${WORDPRESS_USER_PASS} \
    --role=${WORDPRESS_USER_ROOL} --allow-root

wp theme install twentysixteen --activate

wp plugin install redis-cache --activate --allow-root
wp config set WP_REDIS_HOST redis --raw --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp redis enable --allow-root

sed -i '36 s/\/run\/php\/php7.4-fpm.sock/9000/' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F
