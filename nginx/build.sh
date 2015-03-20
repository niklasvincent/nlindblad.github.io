#!/bin/bash

set -e

NGINX_VERSION="1.6.2"
NGINX_TARBALL="nginx-${NGINX_VERSION}.tar.gz"
PCRE_VERSION="8.36"
PCRE_TARBALL="pcre-${PCRE_VERSION}.tar.gz"
OPENSSL_VERSION="1.0.1l"
OPENSSL_TARBALL="openssl-${OPENSSL_VERSION}.tar.gz"
ZLIB_VERSION="1.2.8"
ZLIB_TARBALL="zlib-${ZLIB_VERSION}.tar.gz"

if [[ "${1}" == "clean" ]]; then
  rm -rf nginx*
  rm -rf pcre-*
  rm -rf openssl-*
  exit 0
fi

if [[ -d "nginx" ]]; then
  rm -rf nginx
fi

CWD=$(pwd)

if [[ ! -d "${NGINX_TARBALL%.tar.gz}" ]]; then
  wget "http://nginx.org/download/${NGINX_TARBALL}"
  tar xvzf "${NGINX_TARBALL}" && rm -f "${NGINX_TARBALL}"
fi

if [[ ! -d "${PCRE_TARBALL%.tar.gz}" ]]; then
  wget "https://ftp.csx.cam.ac.uk/pub/software/programming/pcre/${PCRE_TARBALL}"
  tar xvzf "${PCRE_TARBALL}" && rm -f "${PCRE_TARBALL}"
fi

if [[ ! -d "${OPENSSL_TARBALL%.tar.gz}" ]]; then
  wget "http://www.openssl.org/source/${OPENSSL_TARBALL}"
  tar xvzf "${OPENSSL_TARBALL}" && rm -f "${OPENSSL_TARBALL}"
fi

if [[ ! -d "${ZLIB_TARBALL%.tar.gz}" ]]; then
  wget "http://zlib.net/${ZLIB_TARBALL}"
  tar xvzf "${ZLIB_TARBALL}" && rm -rf "${ZLIB_TARBALL}"
fi

cd "nginx-${NGINX_VERSION}"
mkdir ../nginx
./configure \
  --with-cpu-opt=generic \
  --prefix=../nginx \
  --with-pcre=../pcre-${PCRE_VERSION} \
  --sbin-path=. \
  --pid-path=./nginx.pid \
  --conf-path=./nginx.conf \
  --with-openssl-opt=no-krb5 \
  --with-ld-opt="-static" \
  --with-openssl=../openssl-${OPENSSL_VERSION} \
  --with-http_ssl_module \
  --with-http_spdy_module \
  --with-http_stub_status_module \
  --with-http_gzip_static_module \
  --with-file-aio \
  --with-zlib=../zlib-${ZLIB_VERSION} \
  --with-pcre \
  --with-cc-opt="-O2 -static -static-libgcc" \
  --without-http_charset_module \
  --without-http_ssi_module \
  --without-http_userid_module \
  --without-http_access_module \
  --without-http_auth_basic_module \
  --without-http_geo_module \
  --without-http_map_module \
  --without-http_split_clients_module \
  --without-http_referer_module \
  --without-http_proxy_module \
  --without-http_fastcgi_module \
  --without-http_uwsgi_module \
  --without-http_scgi_module \
  --without-http_memcached_module \
  --without-http_empty_gif_module \
  --without-http_browser_module \
  --without-http_upstream_ip_hash_module \
  --without-http_upstream_least_conn_module \
  --without-http_upstream_keepalive_module \
  --without-mail_pop3_module \
  --without-mail_imap_module \
  --without-mail_smtp_module

sed -i "/CFLAGS/s/ \-O //g" objs/Makefile

make && make install
