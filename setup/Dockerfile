FROM alpine:latest

VOLUME ["/tmp/htpasswd", "/tmp/ssl", "/tmp/website"]
RUN apk --no-cache add apache2-utils openssl
COPY entrypoint.sh /
ENV HTUSER=user \
    HTPASS=password \
    MYSQL_DATABASE=wordpress \
    MYSQL_ROOT_PASSWORD=sqlrootpassword \
    MYSQL_USER=user \
    MYSQL_PASSWORD=password

ENTRYPOINT ["/entrypoint.sh"]
