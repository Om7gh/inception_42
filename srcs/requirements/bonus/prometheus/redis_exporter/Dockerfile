FROM debian:11

RUN apt-get update && apt-get install -y wget && \
    wget https://github.com/oliver006/redis_exporter/releases/download/v1.55.0/redis_exporter-v1.55.0.linux-amd64.tar.gz && \
    tar -xzf redis_exporter-*.tar.gz && \
    mv redis_exporter-v1.55.0.linux-amd64/redis_exporter /usr/local/bin/ && \
    rm -rf redis_exporter-*

USER nobody
EXPOSE 9121
ENTRYPOINT ["redis_exporter", "--redis.addr=redis://redis:6379"]
