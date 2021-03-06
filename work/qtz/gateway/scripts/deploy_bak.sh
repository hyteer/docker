#!/bin/bash
echo "部署网关......"
BASE="/data"
WEB_PATH="${BASE}/www"
PHP_PATH="/data/php"
THRIFT_PATH="/data/thrift"
REDIS="10.20.60.3"

cd ${WEB_PATH}
ln -s gateway-app-salesman appdt.testopt.snsshop.net
ln -s gateway-app-merchant appmc.testopt.snsshop.net
ln -s gateway-boss boss.testopt.snsshop.net
ln -s gateway-h5-rest-shop merc.testmopt.snsshop.net
ln -s gateway-h5-pay pay.testmopt.snsshop.net
ln -s gateway-qrcode qr.testmopt.snsshop.net
ln -s frontend-h5-rest-shop \*.testmopt.snsshop.net
ln -s gateway-h5-ucenter user.testmopt.snsshop.net
# init
echo "init gateway-qrcode..."

#### gateway-qrcode 
echo "==部署二维码网关=="
cd gateway-qrcode
${PHP_PATH}/bin/php init --env=Test --overwrite=All
sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
mkdir ./runtime/debug && mkdir ./runtime/logs
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
echo "启动服务..."
${PHP_PATH}/bin/php start.php start -d
${PHP_PATH}/bin/php start.php status

#### gateway-app-salesman 
echo "==部署app-salesman网关=="
cd ${WEB_PATH}/gateway-app-salesman
${PHP_PATH}/bin/php init --env=Test --overwrite=All
sed -i "s/'hostname' => '10.100.100.70'/'hostname' => '${REDIS}'/g" config/main-local.php
mkdir ./runtime/debug && mkdir ./runtime/logs
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

#### gateway-app-merchant
echo "==部署boss关=="
cd ${WEB_PATH}/gateway-boss
${PHP_PATH}/bin/php init --env=Test --overwrite=All
mkdir ./runtime/debug && mkdir ./runtime/logs
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


#### go_gateway
echo "==部署Go网关=="
cd ${BASE}/go_gateway
chmod +x go_gateway *.sh
#${BASE}/go_gateway/go_gateway -config_file gateway.json &
#nohup /data/go_gateway/go_gateway -config_file gateway.json &
#ls /scripts
#/scripts/wait-for-it.sh -t 5 localhost:8080
#cat nohup.out
cd /data

echo "finished..."

