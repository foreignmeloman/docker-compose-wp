#!/bin/sh

# Create .htaccess file
htpasswd -bc /tmp/htpasswd/.htpasswd ${HTUSER} ${HTPASS} || exit 1

# Create certificate if none found
key_file=/tmp/ssl/site.key
csr_file=/tmp/ssl/site.csr
crt_file=/tmp/ssl/site.crt

if [[ ! -s ${key_file} ]] && [[ ! -s ${crt_file} ]]; then
  openssl genpkey -out ${key_file} -algorithm RSA -pkeyopt rsa_keygen_bits:2048 || exit 1
  openssl req -new -key ${key_file} -out ${csr_file} -batch || exit 1
  openssl x509 -req -days 365 -in ${csr_file} -signkey ${key_file} -out ${crt_file} || exit 1
  echo "Certificates succesfully generated"
fi

# Create WordPress configuration
sed -e "s/database_name_here/${MYSQL_DATABASE}/g" \
    -e "s/username_here/${MYSQL_USER}/g" \
    -e "s/password_here/${MYSQL_PASSWORD}/g" \
    -e 's/localhost/percona-service/g' \
    /tmp/website/wp-config-sample.php > /tmp/website/wp-config.php || exit 1
echo "WordPress configuration succesfully generated"

exec "$@"
