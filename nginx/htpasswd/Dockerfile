FROM alpine:latest

RUN apk --no-cache add apache2-utils && mkdir /tmp/htpasswd
ENV HTUSER=user
ENV HTPASS=password

CMD htpasswd -bc /tmp/htpasswd/.htpasswd ${HTUSER} ${HTPASS}
