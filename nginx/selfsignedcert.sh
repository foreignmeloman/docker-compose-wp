#!/bin/bash
cur_dir=$(cd $(dirname "${BASH_SOURCE[0]}") &> /dev/null && pwd)

fname=${cur_dir}/ssl/${1:-site}
mkdir -p ${cur_dir}/ssl

openssl genpkey -out ${fname}.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048
openssl req -new -key ${fname}.key -out ${fname}.csr -batch
openssl x509 -req -days 365 -in ${fname}.csr -signkey ${fname}.key -out ${fname}.crt

rm ${fname}.csr
