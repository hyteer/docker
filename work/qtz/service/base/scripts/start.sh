#!/bin/bash
BASE="/data"
WEB_PATH="/data/www"
PHP_PATH="${PHP_PATH}"
PHP="${PHP_PATH}/bin/php"
CONSUL="/usr/local/sbin/consul"
GATEWAY="nginx"
HOST="srv-base"

## start php
echo "启动php-fpm..."
/etc/init.d/php-fpm start
# start consul
echo "启动consul..."
nohup consul agent -bind ${HOST} -server -bootstrap-expect 3 -data-dir /tmp/consul   -config-dir /etc/consul.d &

echo "启动服务..."
function start_services () {
	# service-base
	echo "启动service-base..."
	cd ${WEB_PATH}/service-base
	${PHP} start.php start -d
	${PHP} start.php status

}


start_services
${CONSUL} join ${GATEWAY}
${CONSUL} members
${CONSUL} monitor

#/usr/local/sbin/consul monitor


