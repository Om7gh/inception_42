FROM debian:11

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    php-fpm \
    ca-certificates  \
    php-mysql \
    php-curl \
    php-json \
    php-mbstring \
    php-xml \
    php-zip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

RUN curl -o /tmp/wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm -rf /tmp/wordpress.tar.gz

COPY ./conf/script.sh /script.sh

RUN chmod +x /script.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/script.sh"]
