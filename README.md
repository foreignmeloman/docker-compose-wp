## Requirements
* Docker
* Docker Compose

## How to use
* Run `init.sh` to create necessary directory structure.
* Place your wordpress files into the `website` directory.
* If available, place your certificate bundle and key pair inside `nginx/ssl` as `site.crt` and `site.key` respectively (overwrite existing empty files).
* Create a `.env` file and define the following environment variables:

```
HTUSER
HTPASS
MYSQL_DATABASE
MYSQL_ROOT_PASSWORD
MYSQL_USER
MYSQL_PASSWORD
```
