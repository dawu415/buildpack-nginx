#!/usr/bin/env bash

set -e

if [ -z $1 ]
then
 VERSION="0.0.0"
else
 VERSION=$1
fi

if [ ! -z $2 ]
then 
  sudo apt-get update -y
  sudo apt-get install libpcre3 libpcre3-dev -y
  sudo apt-get install gzip -y
  sudo apt-get install openssl libssl-dev libperl-dev -y
  sudo apt-get install libgd-dev -y
  sudo apt-get install build-essential -y
fi 

ROOT_PATH="$(pwd)"
STAGING_PATH="$(pwd)/staging"
OPENSSL_PATH="$(pwd)/staging/openssl"
NGINX_PATH="$(pwd)/staging/nginx"
NGX_DEV_KIT_PATH="$(pwd)/staging/ngx_devel_kit"
SET_MISC_MODULE_PATH="$(pwd)/staging/set-misc-nginx-module"
NGX_BIN_OUTPUT_PATH="$(pwd)/nginx"

# Clean up any staging artifacts previously remaining
rm -rf $STAGING_PATH

mkdir -p $NGINX_PATH
mkdir -p $OPENSSL_PATH
mkdir -p $NGX_DEV_KIT_PATH
mkdir -p $SET_MISC_MODULE_PATH
mkdir -p "$NGX_BIN_OUTPUT_PATH/bin"

tar xzf ./dependencies/openssl-1.0.2o.tar.gz -C $OPENSSL_PATH --strip 1
tar xzf ./dependencies/nginx-1.11.2.tar.gz -C $NGINX_PATH --strip 1
tar xzf ./dependencies/ngx_devel_kit-0.3.0.tar.gz -C $NGX_DEV_KIT_PATH --strip 1
tar xzf ./dependencies/set-misc-nginx-module-0.31.tar.gz -C $SET_MISC_MODULE_PATH --strip 1

# Compile NGINX
cd $NGINX_PATH

./configure --prefix=$NGX_BIN_OUTPUT_PATH  --sbin-path="$NGX_BIN_OUTPUT_PATH/bin/nginx" --with-openssl=$OPENSSL_PATH --with-debug --with-http_image_filter_module --with-http_ssl_module --add-module=$NGX_DEV_KIT_PATH --add-module=$SET_MISC_MODULE_PATH

make install

rm -rf $OPENSSL_PATH
rm -rf $NGX_DEV_KIT_PATH 
rm -rf $SET_MISC_MODULE_PATH
rm -rf $NGINX_PATH

mv $NGX_BIN_OUTPUT_PATH $STAGING_PATH
cp -rf "$ROOT_PATH/bin" $STAGING_PATH

cd $STAGING_PATH
chmod -R +x "$STAGING_PATH/bin"
chmod -R 755 "$STAGING_PATH/nginx"
zip -r $ROOT_PATH/nginx-buildpack-$VERSION.zip *
 

