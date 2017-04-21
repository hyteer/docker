#!/bin/bash
BASE="/data"
GO_PATH="${BASE}/go_gateway"

## start php
echo "启动php-fpm..."
/etc/init.d/php-fpm start
# start consul
echo "启动consul..."
nohup consul agent -server -bootstrap-expect 3 -data-dir /tmp/consul   -config-dir /etc/consul.d &
## start nginx
echo "启动nginx..."
/data/nginx/sbin/nginx #-g "daemon off;"
## 启动Go网关
#nohup ${BASE}/go_gateway/go_gateway -config_file gateway.json &
# start gateway
echo "启动服务..."
cd /data/www/gateway-qrcode
/data/php/bin/php start.php start -d
#
${GO_PATH}/go_gateway -config_file ${GO_PATH}/gateway.json
#/usr/local/sbin/consul monitor


