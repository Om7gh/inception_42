FROM debian:11

RUN apt-get update && apt-get install -y --no-install-recommends \
    mariadb-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/mariadb.sh /mariadb.sh

RUN chmod +x /mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/mariadb.sh"]
