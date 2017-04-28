#!/bin/bash
BASE="/data"
WEB_PATH="/data/www"
PHP_PATH="${PHP_PATH}"
PHP="${PHP_PATH}/bin/php"
CONSUL="/usr/local/sbin/consul"
GO_PATH="${BASE}/go_gateway"
HOST="nginx"
WAIT="/scripts/wait-for-it.sh"

## Dynamic Env
echo "IP prefix: $IP_PREFIX"
export IP=$(ifconfig |grep ${IP_PREFIX}|cut -d ":" -f2|cut -d " " -f1)
echo "IP: ${IP}"
## start php
echo "启动php-fpm..."
/etc/init.d/php-fpm start
# start consul
echo "启动consul..."
#nohup consul agent -server -bootstrap-expect 3 -data-dir /tmp/consul -config-dir /etc/consul.d &
nohup consul agent -bind ${IP} -server -bootstrap-expect 3 -data-dir /tmp/consul -config-dir /etc/consul.d &
## start nginx
echo "启动nginx..."
${BASE}/nginx/sbin/nginx #-g "daemon off;"

function start_gateway_go() {
    echo "==启动Go网关=="
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

#start_gateway_go
${WAIT} ${MANAGER}:8301 -t 10 -- ${CONSUL} join ${MANAGER}
${CONSUL} members
${CONSUL} monitor


