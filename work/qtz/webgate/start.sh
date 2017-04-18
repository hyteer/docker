#!/bin/bash
## start php
/etc/init.d/php-fpm start
# start consul
nohup consul agent -server -bootstrap-expect 3 -data-dir /tmp/consul   -config-dir /etc/consul.d &
## start nginx
/data/apps/nginx/sbin/nginx -g "daemon off;"


