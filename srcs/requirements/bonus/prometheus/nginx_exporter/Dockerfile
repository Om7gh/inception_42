FROM debian:11

RUN apt-get update && apt-get install -y wget && \
    wget https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.11.0/nginx-prometheus-exporter_0.11.0_linux_amd64.tar.gz && \
    tar -xzf nginx-prometheus-exporter_*.tar.gz && \
    mv nginx-prometheus-exporter /usr/local/bin/ && \
    rm -rf nginx-prometheus-exporter_*

USER nobody
EXPOSE 9113
ENTRYPOINT ["nginx-prometheus-exporter", "--nginx.scrape-uri=http://proxy:8080/stub_status"]
