FROM nginx:1.19

COPY ./conf.d/site.conf /etc/nginx/conf.d
RUN openssl genpkey -out /etc/ssl/private/site.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048 && \
    openssl req -new -key /etc/ssl/private/site.key -out /tmp/site.csr -batch && \
    openssl x509 -req -days 365 -in /tmp/site.csr -signkey /etc/ssl/private/site.key -out /etc/ssl/certs/site.crt
