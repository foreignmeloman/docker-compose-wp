#!/bin/bash
# By running this script we make sure that all mounted directories and generated files belong to the user.
DIR=$(cd $(dirname "${BASH_SOURCE[0]}") &> /dev/null && pwd)

mkdir -p ${DIR}/nginx/htpasswd \
         ${DIR}/nginx/ssl \
         ${DIR}/website \
         ${DIR}/xtradb/cert

touch ${DIR}/nginx/htpasswd/.htpasswd \
      ${DIR}/nginx/ssl/site.crt \
      ${DIR}/nginx/ssl/site.csr \
      ${DIR}/nginx/ssl/site.key \
      ${DIR}/website/wp-config.php \
      ${DIR}/xtradb/cert/ca.pem \
      ${DIR}/xtradb/cert/ca-key.pem \
      ${DIR}/xtradb/cert/server-cert.pem \
      ${DIR}/xtradb/cert/server-key.pem \
      ${DIR}/xtradb/cert/client-cert.pem \
      ${DIR}/xtradb/cert/client-key.pem

echo "You may now run docker-compose up"
