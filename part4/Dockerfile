FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
  curl \
  gcc \
  libfcgi-dev \
  spawn-fcgi \
  nginx \
  && rm -rf /var/lib/apt/lists/*

COPY server /app

RUN gcc /app/hello_world.c -o /app/hello_world -lfcgi

COPY ./nginx/nginx.conf /etc/nginx/conf.d/nginx.conf

CMD spawn-fcgi -p 8080 /app/hello_world && nginx -g "daemon off;"

