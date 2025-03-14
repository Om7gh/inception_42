#!/bin/bash

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Download WordPress core files
wp core download --path=/var/www/html --allow-root

# Create WordPress configuration file
wp config create \
    --path=/var/www/html \
    --dbname=wordpress \
    --dbuser=omghazi \
    --dbpass=1111 \
    --dbhost=db:3306 --allow-root

# Create the database
wp db create --path=/var/www/html --allow-root

# Install WordPress
wp core install \
    --path=/var/www/html \
    --url=http://omghazi.42.fr \
    --title="inception ya dawla" \
    --admin_user=admin \
    --admin_password=admin \
    --admin_email=admin@example.com --allow-root

# Update PHP-FPM configuration
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# Set permissions
chown -R www-data:www-data /var/www/html

# Start PHP-FPM
/usr/sbin/php-fpm7.4 -F
