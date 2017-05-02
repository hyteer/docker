#!/bin/bash
BASE="/data"
WEB_PATH="/data/www"
PHP_PATH="${PHP_PATH}"
PHP="${PHP_PATH}/bin/php"
CONSUL="/usr/local/sbin/consul"
WAIT="/scripts/wait-for-it.sh"
#MANAGER="gate_go"
#IP_PREFIX="192.11.0."
SRV_NAME="user"

echo "IP prefix: $IP_PREFIX"
export IP=$(ifconfig |grep ${IP_PREFIX}|cut -d ":" -f2|cut -d " " -f1)
echo "IP: ${IP}"

## start php
echo "启动php-fpm..."
/etc/init.d/php-fpm start
# start consul
echo "启动consul..."
nohup consul agent -bind ${IP} -server -bootstrap-expect 3 -data-dir /tmp/consul -config-dir /etc/consul.d &

echo "启动服务..."
function start_service () {
	echo "启动service-${SRV_NAME}..."
	cd ${WEB_PATH}/service-${SRV_NAME}
	${PHP} start.php start -d
	${PHP} start.php status

}

start_service
${WAIT} ${MANAGER}:8301 -t 30 -- echo "wait manager..."
${CONSUL} join ${MANAGER}
${CONSUL} members
${CONSUL} monitor


