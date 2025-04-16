FROM debian:11 as builder

RUN apt-get update && \
    apt-get install -y vsftpd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m ftpuser && \
    echo "ftpuser:ftppass" | chpasswd && \
    mkdir -p /var/ftp/pub && \
    chown nobody:nogroup /var/ftp/pub && \
    chmod a-w /var/ftp/pub && \
    mkdir -p /var/www/html && \
    chown ftpuser:ftpuser /var/www/html && \
    chmod 755 /var/www/html && \
    mkdir -p /var/ftp && \
    chown ftpuser:ftpuser /var/ftp && \
    chmod 755 /var/ftp

COPY ./tools/vsftpd.conf /etc/vsftpd.conf
COPY ./tools/run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

EXPOSE 20 21 21000-21010

ENTRYPOINT ["/usr/local/bin/run.sh"]
