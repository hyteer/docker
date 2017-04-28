#!/bin/bash
BASE="/data"
WEB_PATH="/data/www"
PHP_PATH="${PHP_PATH}"
PHP="${PHP_PATH}/bin/php"
GO_PATH="${BASE}/go_gateway"
CONSUL="/usr/local/sbin/consul"
WAIT="/scripts/wait-for-it.sh"

## start php
echo "启动php-fpm..."
/etc/init.d/php-fpm start
# start consul
echo "启动consul..."
nohup consul agent -server -bootstrap-expect 3 -data-dir /tmp/consul -config-dir /etc/consul.d &
## start nginx
echo "启动nginx..."
${BASE}/nginx/sbin/nginx #-g "daemon off;"

# start gateway

function start_services () {
    
     # gateway-app-merchant
    echo "启动gateway-app-merchant..."
    cd ${WEB_PATH}/gateway-app-merchant
    ${PHP} start.php start -d
    ${PHP} start.php status
    # salesman
    echo "启动gateway-app-salesman..."
    cd ${WEB_PATH}/gateway-app-salesman
    ${PHP} start.php start -d
    ${PHP} start.php status
    # boss
    echo "启动gateway-boss..."
    cd ${WEB_PATH}/gateway-boss
    ${PHP} start.php start -d
    ${PHP} start.php status
    # h5-pay
    echo "启动gateway-h5-pay..."
    cd ${WEB_PATH}/gateway-h5-pay
    ${PHP} start.php start -d
    ${PHP} start.php status
    # h5-rest-shop
    echo "启动gateway-h5-rest-shop..."
    cd ${WEB_PATH}/gateway-h5-rest-shop
    ${PHP} start.php start -d
    ${PHP} start.php status
    # h5-ucenter
    echo "启动gateway-h5-ucenter..."
    cd ${WEB_PATH}/gateway-h5-ucenter
    ${PHP} start.php start -d
    ${PHP} start.php status
    # qrcode
    echo "启动gateway-qrcode..."
    cd ${WEB_PATH}/gateway-qrcode
    ${PHP} start.php start -d
    ${PHP} start.php status
    # gateway_go
    #echo "启动gateway-go..."
    #${GO_PATH}/go_gateway -config_file ${GO_PATH}/gateway.json
}

function start_gateway_go() {
    echo "==部署Go网关=="
    cd ${GO_PATH}
    chmod +x go_gateway *.sh *.json
    sleep 1
    nohup ${GO_PATH}/go_gateway -config_file gateway.json &
    #nohup /data/go_gateway/go_gateway -config_file gateway.json &
    #ls /scripts
    #/scripts/wait-for-it.sh -t 5 localhost:8080
    #cat nohup.out
    cd ${BASE}
}


${WAIT} 172.0.0.1:8301 -t 5 -- echo  "启动服务..."
start_services
start_gateway_go

consul members
/usr/local/sbin/consul monitor


