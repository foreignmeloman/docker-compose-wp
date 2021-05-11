FROM nginx:1.19 as base


FROM base as auth_gen
ARG HTUSER=user
ARG HTPASS=pass
RUN apt update && \
    apt install -y apache2-utils && \
    htpasswd -b -c /usr/share/nginx/.htpasswd ${HTUSER} ${HTPASS}


FROM base
COPY --from=auth_gen /usr/share/nginx/.htpasswd /usr/share/nginx/
COPY ./conf.d/site.conf /etc/nginx/conf.d
RUN openssl genpkey -out /etc/ssl/private/site.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048 && \
    openssl req -new -key /etc/ssl/private/site.key -out /tmp/site.csr -batch && \
    openssl x509 -req -days 365 -in /tmp/site.csr -signkey /etc/ssl/private/site.key -out /etc/ssl/certs/site.crt
