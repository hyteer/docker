#!/bin/bash
BASE="/data"
WEB_PATH="/data/www"
PHP_PATH="${PHP_PATH}"
PHP="${PHP_PATH}/bin/php"
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
    
    # qrcode
    echo "启动gateway-qrcode..."
    cd ${WEB_PATH}/gateway-qrcode
    ${PHP} start.php start -d
    ${PHP} start.php status
    # gateway_go
    #echo "启动gateway-go..."
    #${GO_PATH}/go_gateway -config_file ${GO_PATH}/gateway.json
}



${WAIT} 172.0.0.1:8301 -t 5 -- echo  "启动服务..."
start_services

consul members
/usr/local/sbin/consul monitor


