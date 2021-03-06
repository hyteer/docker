#!/bin/bash
echo "开始部署服务......"
BASE="/data"
WEB_PATH="${BASE}/www"
PHP_PATH="/data/php"
PHP="${PHP_PATH}/bin/php"
THRIFT_PATH="/data/thrift"
REDIS="10.20.60.3"


function deploy_service_base() {
    echo "==部署service-base=="
    cd ${WEB_PATH}/service-base
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    sed -i "s/'username' => 'prime_base',/'username' => 'root',/g" config/main-local.php
    sed -i "s/'password' => '231DH9i7iUIUtgTR',/'password' => '111',/g" config/main-local.php
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


function deploy_service_merchant() {
    echo "==部署service-merchant=="
    cd ${WEB_PATH}/service-merchant
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    sed -i "s/'username' => 'prime_merchant',/'username' => 'root',/g" config/main-local.php
    sed -i "s/'password' => '1mtWlg26BbA2bxZ3',/'password' => '111',/g" config/main-local.php
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
}

function deploy_service_message () {
    echo "==部署service-message=="
    cd ${WEB_PATH}/service-message
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    sed -i "s/'username' => 'prime_message',/'username' => 'root',/g" config/main-local.php
    sed -i "s/'password' => 'ZykhmakrBex0ZCYn',/'password' => '111',/g" config/main-local.php
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
}

function deploy_service_order () {
    echo "==部署boss关=="
    cd ${WEB_PATH}/service-order
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    sed -i "s/'username' => 'prime_order',/'username' => 'root',/g" config/main-local.php
    sed -i "s/'password' => 'lfhjNb3yXBUzK8uj',/'password' => '111',/g" config/main-local.php
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
}

function deploy_service_pay () {
    echo "==部署service-pay=="
    cd ${WEB_PATH}/service-pay
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
}

function deploy_service_product () {
    echo "==部署service-product=="
    cd ${WEB_PATH}/service-product
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    sed -i "s/'username' => 'prime_product',/'username' => 'root',/g" config/main-local.php
    sed -i "s/'password' => 'dpGRlwjcTcAOv1BC',/'password' => '111',/g" config/main-local.php
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
}

function deploy_service_qrcode () {
    echo "==部署service-qrcode=="
    cd ${WEB_PATH}/service-qrcode
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    sed -i "s/'username' => 'prime_qrcode',/'username' => 'root',/g" config/main-local.php
    sed -i "s/'password' => 'EJrPtZXXhmYsxcGB',/'password' => '111',/g" config/main-local.php
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
}

function deploy_service_shop () {
    echo "==部署service-shop=="
    cd ${WEB_PATH}/service-shop
    ${PHP} init --env=Test --overwrite=All
    sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
    sed -i 's/mysql:host=10.100.100.71;/mysql:host=10.20.60.3;/g' config/main-local.php
    sed -i "s/'username' => 'prime_shop',/'username' => 'root',/g" config/main-local.php
    sed -i "s/'password' => 'rpgR1wjcTcbKj1Bv',/'password' => '111',/g" config/main-local.php
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
}


deploy_service_base
deploy_service_merchant
deploy_service_message
deploy_service_order
deploy_service_pay
deploy_service_product
deploy_service_qrcode
deploy_service_shop


echo "部署完成..."

