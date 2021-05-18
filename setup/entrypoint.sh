#!/bin/sh
this_script=${0}
function log() { echo "${this_script}: ${1}"; }

# Create .htaccess file
htpasswd -bc /tmp/htpasswd/.htpasswd ${HTUSER} ${HTPASS} || exit 1

# Create site certificate if none found
key_file=site.key
csr_file=site.csr
crt_file=site.crt
cd /tmp/ssl

if [[ ! -s ${key_file} ]] && [[ ! -s ${crt_file} ]]; then
  openssl genpkey -out ${key_file} -algorithm RSA -pkeyopt rsa_keygen_bits:2048 || exit 1
  openssl req -new -key ${key_file} -out ${csr_file} -batch || exit 1
  openssl x509 -req -days 365 -in ${csr_file} -signkey ${key_file} -out ${crt_file} || exit 1
  log "Web certificates succesfully generated"
fi

# Create XtraDB CA and certificates if none found
# Reference: https://dev.mysql.com/doc/refman/8.0/en/creating-ssl-files-using-openssl.html
ca_file=ca.pem
ca_key_file=ca-key.pem
cd /tmp/xtradb/cert

if [[ ! -s ${ca_file} ]] && [[ ! -s ${ca_key_file} ]]; then
  openssl genrsa 2048 > ${ca_key_file} || exit 1
  openssl req -new -x509 -nodes -days 3600 -key ${ca_key_file} -out ${ca_file} -batch || exit 1
  log "XtraDB CA succesfully generated"
fi

for item in "server" "client"; do
  if [[ ! -s ${item}-cert.pem ]] && [[ ! -s ${item}-key.pem ]]; then
    openssl req -newkey rsa:2048 -days 3600 -nodes -keyout ${item}-key.pem -out ${item}-req.pem -batch || exit 1
    openssl rsa -in ${item}-key.pem -out ${item}-key.pem || exit 1
    openssl x509 -req -in ${item}-req.pem -days 3600 -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out ${item}-cert.pem || exit 1
    rm -f ${item}-req.pem
    log "XtraDB certificates succesfully generated"
  fi
done

# Create WordPress configuration
sed -e "s/database_name_here/${MYSQL_DATABASE}/g" \
    -e "s/username_here/${MYSQL_USER}/g" \
    -e "s/password_here/${MYSQL_PASSWORD}/g" \
    -e 's/localhost/percona-service/g' \
    /tmp/website/wp-config-sample.php > /tmp/website/wp-config.php || exit 1
log "WordPress configuration succesfully generated"

exec "$@"
