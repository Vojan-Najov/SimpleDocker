FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
  curl \
  gcc \
  libfcgi-dev \
  spawn-fcgi \
  nginx \
  && rm -rf /var/lib/apt/lists/*

COPY server /app
COPY ./nginx/nginx.conf /etc/nginx/conf.d/nginx.conf

RUN gcc /app/hello_world.c -o /app/hello_world -lfcgi && \
  useradd -r -ms /bin/bash ccartman && \
  chown -R ccartman:ccartman /usr/bin && \
  chown -R ccartman:ccartman /usr/sbin && \
  chown -R ccartman:ccartman /etc/nginx && \
  chown -R ccartman:ccartman /var && \
  chown -R ccartman:ccartman /run 

USER ccartman

HEALTHCHECK CMD curl --fail http://localhost:81 || exit 1  

CMD spawn-fcgi -p 8080 /app/hello_world && nginx -g "daemon off;"

