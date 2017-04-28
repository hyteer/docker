#!/bin/bash
echo "开始部署服务......"
BASE="/data"
WEB_PATH="${BASE}/www"
PHP_PATH="/data/php"
PHP="${PHP_PATH}/bin/php"
THRIFT_PATH="/data/thrift"
REDIS="10.20.60.3"


function deploy_service_shopping_cart() {
    echo "==部署service-shopping-cart=="
    cd ${WEB_PATH}/service-shopping-cart
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    mkdir -p ./runtime/debug ./runtime/info ./runtime/logs
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


function deploy_service_third_party() {
    echo "==部署service-third-party=="
    cd ${WEB_PATH}/service-third-party
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    #sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    #sed -i "s/'username' => 'prime_wechat',/'username' => 'root',/g" config/main-local.php
    #sed -i "s/'password' => 'IrgQQM0uda7APML4',/'password' => '111',/g" config/main-local.php
    mkdir -p ./runtime/debug ./runtime/info ./runtime/logs
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

function deploy_service_third_party_interface () {
    echo "==部署service-third-party-interface=="
    cd ${WEB_PATH}/service-third-party-interface
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    #sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    #sed -i "s/'username' => 'prime_wechat_if',/'username' => 'root',/g" config/main-local.php
    #sed -i "s/'password' => 'LHHeB62GRUXUfE3i',/'password' => '111',/g" config/main-local.php
    mkdir -p ./runtime/debug ./runtime/info ./runtime/logs
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

function service_user () {
    echo "==部署service-user=="
    cd ${WEB_PATH}/service-user
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    #sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    #sed -i "s/'username' => 'prime_user',/'username' => 'root',/g" config/main-local.php
    #sed -i "s/'password' => 'CKkd4g4dFPnmE1w5',/'password' => '111',/g" config/main-local.php
    mkdir -p ./runtime/debug ./runtime/info ./runtime/logs
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


deploy_service_shopping_cart
deploy_service_third_party
deploy_service_third_party_interface
service_user


echo "部署完成..."

