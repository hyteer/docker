#!/bin/bash
echo "开始部署......"
BASE="/data"
WEB_PATH="${BASE}/www"
PHP_PATH="/data/php"
PHP="${PHP_PATH}/bin/php"
THRIFT_PATH="/data/thrift"
REDIS="10.20.60.3"

#cp /scripts/ping /bin/

cd ${WEB_PATH}
ln -s gateway-app-merchant appmc.testmopt.snsshop.net

function deploy_gateway () {
    echo "==部署gateway-app-merchant=="
    cd ${WEB_PATH}/gateway-app-merchant
    ${PHP_PATH}/bin/php init --env=Test --overwrite=All
    mkdir -p ./runtime/debug && mkdir ./runtime/logs
    chown -R nginx:nginx ./runtime
    # 生成thrift code
    echo "生成thrift code..."
    for file in ./thriftFiles/*.thrift
    do
        if test -f ${file}
        then
            ${THRIFT_PATH}/bin/thrift -out . --gen php:server ${file}
        else
            echo "${file} is not a file..."
        fi
    done
}


deploy_gateway

echo "部署完成..."

