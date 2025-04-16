FROM debian:11 as builder

RUN apt-get update && apt-get install -y \
    curl wget && \
    wget https://github.com/google/cadvisor/releases/download/v0.52.1/cadvisor-v0.52.1-linux-amd64 -O /cadvisor \
    && apt-get clean && rm -rf /var/apt/lib/lists/* \
    && chmod +x /cadvisor

FROM debian:11

COPY --from=builder /cadvisor /usr/bin/cadvisor

EXPOSE 8080

ENTRYPOINT ["/usr/bin/cadvisor"]
