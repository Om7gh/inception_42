FROM debian:11

RUN apt-get update && apt-get install -y wget ca-certificates && \
    wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.15.1/mysqld_exporter-0.15.1.linux-amd64.tar.gz && \
    tar -xzf mysqld_exporter-*.tar.gz && \
    mv mysqld_exporter-*/mysqld_exporter /usr/local/bin/ && \
    rm -rf mysqld_exporter-* && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY --chown=nobody:nogroup .my.cnf /home/nobody/.my.cnf
RUN chmod 600 /home/nobody/.my.cnf && \
    mkdir -p /home/nobody && \
    chown nobody:nogroup /home/nobody/.my.cnf

USER nobody
EXPOSE 9104
ENTRYPOINT ["mysqld_exporter", "--config.my-cnf=/home/nobody/.my.cnf"]
