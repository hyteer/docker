#!/bin/bash
BASE="/data"
WEB_PATH="/data/www"
PHP_PATH="${PHP_PATH}"
PHP="${PHP_PATH}/bin/php"
CONSUL="/usr/local/sbin/consul"
GATEWAY="gateway"

## start php
echo "启动php-fpm..."
/etc/init.d/php-fpm start
# start consul
echo "启动consul..."
nohup consul agent -server -bootstrap-expect 3 -data-dir /tmp/consul   -config-dir /etc/consul.d &

echo "启动服务..."
function start_services () {
	# service-base
	echo "启动service-base..."
	cd ${WEB_PATH}/service-base
	${PHP} start.php start -d
	# service-merchant
	echo "启动service-merchant..."
	cd ${WEB_PATH}/service-merchant
	${PHP} start.php start -d
	# service_message
	echo "启动service_message..."
	cd ${WEB_PATH}/service-message
	${PHP} start.php start -d
	# service_order
	echo "启动service_order..."
	cd ${WEB_PATH}/service-order
	${PHP} start.php start -d
	# service_pay
	echo "启动service_pay..."
	cd ${WEB_PATH}/service-pay
	${PHP} start.php start -d
	# service_product
	echo "启动service_product..."
	cd ${WEB_PATH}/service-product
	${PHP} start.php start -d
	# service_qrcode
	echo "启动service_qrcode..."
	cd ${WEB_PATH}/service-qrcode
	${PHP} start.php start -d
	# service_shop
	echo "启动service_shop..."
	cd ${WEB_PATH}/service-shop
	${PHP} start.php start -d

}


start_services
${CONSUL} join ${GATEWAY}
${CONSUL} members
${CONSUL} monitor

#/usr/local/sbin/consul monitor


