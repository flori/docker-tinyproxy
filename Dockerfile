FROM alpine:3.23

RUN apk add --no-cache --update tzdata; \
  cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime; \
  echo "Europe/Berlin" >/etc/timezone; \
  apk del tzdata

RUN apk add --no-cache tinyproxy ca-certificates

EXPOSE 80

COPY files/tinyproxy.conf /etc/tinyproxy/tinyproxy.conf
COPY files/entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh" ]
