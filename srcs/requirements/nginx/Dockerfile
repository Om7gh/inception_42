FROM debian:11

RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    openssl apache2-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -days 90 -nodes -newkey rsa:4096 \
    -keyout /etc/nginx/ssl/selfsigned_certificate.com.key \
    -out /etc/nginx/ssl/selfsigned_certificate.com.crt \
    -subj "/C=MO/ST=SALE/L=SALE/O=SALE/OU=1337/CN=localhost"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN htpasswd -bc /etc/nginx/.htpasswd "prometheus" "123qwerty"

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
