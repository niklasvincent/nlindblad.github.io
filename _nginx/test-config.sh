#!/bin/bash -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NGINX_CONFIG="${DIR}/output/nginx.conf"
NGINX_CONFIG_LOG="/tmp/nginx-config-check.log"
NGINX_CACHE_DIR="${DIR}/../nginx-cache"
NGINX_BINARY="${NGINX_CACHE_DIR}/nginx"
NGINX_DEB_URL="https://s3-eu-west-1.amazonaws.com/deploy-niklaslindblad-se/nginx/nginx_1.10.0-1-trusty_amd64.deb"

# Download nginx binary, if necessary
mkdir -p ${NGINX_CACHE_DIR}
if [[ ! -f "${NGINX_BINARY}" ]]; then
  DEB_TMP_PATH="/tmp/nginx.deb.$$"
  DEB_TMP_UNPACKED="/tmp/nginx-deb/"
  wget "${NGINX_DEB_URL}" -O "${DEB_TMP_PATH}"
  pushd /tmp
  mkdir -p "${DEB_TMP_UNPACKED}"
  dpkg-deb -R "${DEB_TMP_PATH}" $(basename "${DEB_TMP_UNPACKED}")
  cp "${DEB_TMP_UNPACKED}/usr/sbin/nginx" "${NGINX_BINARY}"
  popd
fi

chmod +x ${NGINX_CACHE_DIR}/nginx
${NGINX_CACHE_DIR}/nginx -t -c "${NGINX_CONFIG}" 2>${NGINX_CONFIG_LOG}

if [[ $(cat $NGINX_CONFIG_LOG | egrep "syntax is ok" | wc -l) -eq 1 ]]; then
  echo "Nginx configuration OK!"
  exit 0
else
  echo -e "Nginx configuration invalid:\n"
  cat ${NGINX_CONFIG_LOG}
  exit 1
fi
