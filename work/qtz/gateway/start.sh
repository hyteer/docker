#!/bin/bash
## start php
echo "启动php-fpm..."
/etc/init.d/php-fpm start
# start consul
echo "启动consul..."
nohup consul agent -server -bootstrap-expect 3 -data-dir /tmp/consul   -config-dir /etc/consul.d &
## start nginx
echo "启动nginx..."
/data/nginx/sbin/nginx #-g "daemon off;"
# start gateway
echo "启动服务..."
cd /data/www/gateway-qrcode
/data/php/bin/php start.php start -d
/usr/local/sbin/consul monitor

