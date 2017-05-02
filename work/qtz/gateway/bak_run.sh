#!/bin/bash
MANAGER="gate-go"
IP_RANGE="192.11.0.0/16"
IP_PREFIX="192.11.0."
NET_NAME="testnet"


echo "start..."


function up () {
	echo "创建网络..."
	docker network create -d overlay --subnet=${IP_RANGE} ${NET_NAME}
	echo "启动gate-go服务..." 

	docker service create -e MANAGER=${MANAGER} -e IP_PREFIX=${IP_PREFIX} --network ${NET_NAME} --name gate-go -p 8080:8080 opt/gate-go

	echo "启动nginx服务..." 
	sleep 3

	docker service create -e MANAGER=${MANAGER} -e IP_PREFIX=${IP_PREFIX} --network ${NET_NAME} --name nginx -p 80:80 opt/nginx

	echo "启动完成..."

}

function down () {
	echo "删除服务..."
	docker service rm nginx
	docker service rm gate-go
	echo "删除网络..."
	docker network rm ${NET_NAME}
	echo "已删除..."
}

function ps () {
	echo "todo..."
	docker --help
}

# Entryppint
function main() {
    Command=$1
    shift
    case "${Command}" in
        up)         up ;;
        down)       down ;;
        ps)         ps ;;
        #nodes)      list_nodes ;;
        *)          echo "Usage: $0 <up|down|ps"; exit 1 ;;
    esac
}

main "$@"
