#!/bin/bash
echo "开始部署Nginx......"
BASE="/data"
WEB_PATH="${BASE}/www"
PHP_PATH="/data/php"
THRIFT_PATH="/data/thrift"
REDIS="10.20.60.3"

cp /scripts/ping /bin/

echo "部署完成..."

