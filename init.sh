#!/bin/bash
# By running this script we make sure that all mounted directories and generated files belong to the user.
DIR=$(cd $(dirname "${BASH_SOURCE[0]}") &> /dev/null && pwd)

mkdir -p ${DIR}/nginx/htpasswd \
         ${DIR}/nginx/ssl \
         ${DIR}/website

touch ${DIR}/nginx/htpasswd/.htpasswd \
      ${DIR}/nginx/ssl/site.crt \
      ${DIR}/nginx/ssl/site.csr \
      ${DIR}/nginx/ssl/site.key \
      ${DIR}/website/wp-config.php

echo "You may now run docker-compose up"
