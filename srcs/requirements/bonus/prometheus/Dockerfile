FROM debian:11

RUN apt-get update && apt-get install -y wget && \
    wget https://github.com/prometheus/prometheus/releases/download/v2.51.2/prometheus-2.51.2.linux-amd64.tar.gz && \
    tar -xzf prometheus-*.tar.gz && \
    mv prometheus-2.51.2.linux-amd64/prometheus /usr/local/bin/ && \
    rm -rf prometheus-* && \
    groupadd -r prometheus && \
    useradd -r -g prometheus -s /bin/false prometheus && \
    mkdir -p /prometheus && \
    chown -R prometheus:prometheus /prometheus

COPY ./tools/prometheus.yml /etc/prometheus/prometheus.yml

USER prometheus
WORKDIR /prometheus
EXPOSE 9090
CMD ["prometheus", \
     "--config.file=/etc/prometheus/prometheus.yml", \
     "--storage.tsdb.path=/prometheus"]
