#!/bin/bash
BASE="/data"
WEB_PATH="/data/www"
PHP_PATH="${PHP_PATH}"
PHP="${PHP_PATH}/bin/php"
CONSUL="/usr/local/sbin/consul"
GATEWAY="172.17.0.4"

## start php
echo "启动php-fpm..."
/etc/init.d/php-fpm start
# start consul
echo "启动consul..."
nohup consul agent -server -bootstrap-expect 3 -data-dir /tmp/consul -config-dir /etc/consul.d &

echo "启动服务..."
function start_services () {
	# service-shopping-cart
	echo "启动service-shopping-cart..."
	cd ${WEB_PATH}/service-shopping-cart
	${PHP} start.php start -d
	# service-third-party
	echo "启动service-third-party..."
	cd ${WEB_PATH}/service-third-party
	${PHP} start.php start -d
	# service-third-party-interface
	echo "启动service-third-party-interface..."
	cd ${WEB_PATH}/service-third-party-interface
	${PHP} start.php start -d
	# service-user
	echo "启动service-user..."
	cd ${WEB_PATH}/service-user
	${PHP} start.php start -d


}


start_services
${CONSUL} join ${GATEWAY}
${CONSUL} members
${CONSUL} monitor

#/usr/local/sbin/consul monitor


