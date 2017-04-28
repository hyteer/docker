#!/bin/bash
echo "开始部署......"
BASE="/data"
WEB_PATH="${BASE}/www"
PHP_PATH="/data/php"
THRIFT_PATH="/data/thrift"
REDIS="10.20.60.3"


function deploy_gateway_qrcode() {
    echo "==部署二维码网关=="
    cd ${WEB_PATH}/gateway-qrcode
    ${PHP_PATH}/bin/php init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
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
    # 启动服务
    #echo "启动服务..."
    #${PHP_PATH}/bin/php start.php start -d
    #${PHP_PATH}/bin/php start.php status
} 


deploy_gateway_qrcode


echo "部署完成..."

