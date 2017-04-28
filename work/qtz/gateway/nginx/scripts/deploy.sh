#!/bin/bash
echo "开始部署Nginx......"
BASE="/data"
WEB_PATH="${BASE}/www"
PHP_PATH="/data/php"
THRIFT_PATH="/data/thrift"
REDIS="10.20.60.3"

cp /scripts/ping /bin/

function make_soft_link() {
    echo "建立域名映射软链接..."
    cd ${WEB_PATH}
    #ln -s gateway-app-salesman appdt.testopt.snsshop.net
    #ln -s gateway-app-merchant appmc.testopt.snsshop.net
    #ln -s gateway-boss boss.testopt.snsshop.net
    #ln -s gateway-h5-rest-shop merc.testmopt.snsshop.net
    #ln -s gateway-h5-pay pay.testmopt.snsshop.net
    #ln -s gateway-qrcode qr.testmopt.snsshop.net
    ln -s frontend-h5-rest-shop \*.testmopt.snsshop.net
    #ln -s gateway-h5-ucenter user.testmopt.snsshop.net
}

function deploy_gateway_go() {
    echo "==部署Go网关=="
    cd ${BASE}/go_gateway
    chmod +x go_gateway *.sh gateway.json
    #${BASE}/go_gateway/go_gateway -config_file gateway.json &
    #nohup /data/go_gateway/go_gateway -config_file gateway.json &
    #ls /scripts
    #/scripts/wait-for-it.sh -t 5 localhost:8080
    #cat nohup.out
    cd /data
}

make_soft_link
#deploy_gateway_go


echo "部署完成..."

