#!/bin/bash -x
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NGINX_CONFIG_LOG="/tmp/nginx-config-check.log"
NGINX_CACHE_DIR="${DIR}/../nginx-cache"

mkdir -p ${NGINX_CACHE_DIR}

if [[ ! -f ${NGINX_CACHE_DIR}/nginx ]]; then
  wget https://s3-eu-west-1.amazonaws.com/deploy-niklaslindblad-se/nginx/x86_64/nginx -O ${NGINX_CACHE_DIR}/nginx
fi
chmod +x ${NGINX_CACHE_DIR}/nginx
${NGINX_CACHE_DIR}/nginx -T -c ${DIR}/output/nginx.conf 2>${NGINX_CONFIG_LOG}

if [[ $(cat $NGINX_CONFIG_LOG | egrep "syntax is ok" | wc -l) -eq 1 ]]; then
  echo "Nginx configuration OK!"
  exit 0
else
  echo -e "Nginx configuration invalid:\n"
  cat ${NGINX_CONFIG_LOG} | egrep -v "directive makes sense only if the master process runs with super-user privileges" | egrep -v "could not open error log file"
  exit 1
fi
