FROM debian:11

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    php \
    php7.4-fpm \
    ca-certificates \
    php-mysql \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

COPY ./conf/script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 9000

CMD ["/script.sh"]
