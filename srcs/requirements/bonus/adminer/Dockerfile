FROM debian:11

RUN apt-get update && apt-get install -y \
    adminer \
    php7.4 \
    php7.4-mysql \
    php7.4-json \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html/adminer

RUN ln -s /usr/share/adminer/adminer /var/www/html/adminer

EXPOSE 9999

CMD ["php", "-S", "0.0.0.0:9999", "-t", "/var/www/html/adminer"]
