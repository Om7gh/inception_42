FROM debian:11

RUN apt-get update && apt-get install -y lsb-release curl gnupg2 ca-certificates && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/php.gpg && \
    apt-get update && apt-get install -y \
    php8.2 php8.2-fpm php8.2-mysql \
    mariadb-client curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /var/www/html

COPY ./conf/script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 9000

CMD ["/script.sh"]
