FROM debian:11

RUN apt-get update && apt-get install -y \
    nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/nginx.conf /etc/nginx/nginx.conf

COPY ./tools/omnifood /etc/nginx/omnifood

EXPOSE 3333

CMD ["nginx", "-g", "daemon off;"]
