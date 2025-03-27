FROM debian:11

RUN apt-get update && apt install -y redis-server

COPY ./tools/redis.sh /

RUN chmod +x /redis.sh \
    && /redis.sh

CMD [ "redis-server", "--protected-mode", "no" ]
