#!/bin/bash
BASE="/data"
WEB_PATH="/data/www"
PHP_PATH="${PHP_PATH}"
PHP="${PHP_PATH}/bin/php"
CONSUL="/usr/local/sbin/consul"
MANAGER="nginx"

export IP=$(ifconfig |grep "192.17.0."|cut -d ":" -f2|cut -d " " -f1)
echo "IP: ${IP}"

## start php
echo "启动php-fpm..."
/etc/init.d/php-fpm start
# start consul
echo "启动consul..."
nohup consul agent -bind ${IP} -server -bootstrap-expect 3 -data-dir /tmp/consul -config-dir /etc/consul.d &
# start gate
function start_gateway () {

    echo "启动gateway-app-salesman..."
    cd ${WEB_PATH}/gateway-app-salesman
    ${PHP} start.php start -d
    ${PHP} start.php status
}

start_gateway
${CONSUL} join ${MANAGER}
${CONSUL} members
${CONSUL} monitor

#/usr/local/sbin/consul monitor


