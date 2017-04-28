#!/bin/bash
BASE="/data"
WEB_PATH="/data/www"
PHP_PATH="${PHP_PATH}"
PHP="${PHP_PATH}/bin/php"
CONSUL="/usr/local/sbin/consul"

#export IP=$(ifconfig |grep "192.17.0."|cut -d ":" -f2|cut -d " " -f1)
#echo "IP: ${IP}"

## start php
echo "启动php-fpm..."
/etc/init.d/php-fpm start
# start consul
#echo "启动consul..."
#nohup consul agent -server -bootstrap-expect -data-dir /tmp/consul -config-dir /etc/consul.d &
echo "启动nginx..."
${BASE}/nginx/sbin/nginx -g "daemon off;"


#${CONSUL} members
#${CONSUL} monitor

