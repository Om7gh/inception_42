FROM debian:11

RUN apt-get update && apt-get install -y vsftpd

COPY ./tools/ftp.sh /

RUN chmod +x /ftp.sh

CMD ["/ftp.sh"]
 