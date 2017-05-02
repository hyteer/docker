#!/bin/bash
echo "开始部署服务......"
BASE="/data"
WEB_PATH="${BASE}/www"
PHP_PATH="/data/php"
PHP="${PHP_PATH}/bin/php"
THRIFT_PATH="/data/thrift"
REDIS="10.20.60.3"
SRV_NAME="pay"

cp /scripts/ping /bin/

function deploy_service() {
    echo "==部署service-${SRV_NAME}=="
    cd ${WEB_PATH}/service-${SRV_NAME}
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    sed -i "s/'username' => 'prime_pay',/'username' => 'root',/g" config/main-local.php
    sed -i "s/'password' => 'abXkLvBuNPT6VsjG',/'password' => '111',/g" config/main-local.php
    mkdir -p ./runtime/debug ./runtime/info
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
    #${PHP} start.php start -d
    #${PHP} start.php status
} 

deploy_service

echo "部署完成..."

