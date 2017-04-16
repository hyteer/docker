#!/bin/bash
# Author:YT

function deploy(){
    # mysql
    docker service create \
        --name mysql \
        -e TZ=Asia/Shanghai \
        -e MYSQL_ROOT_PASSWORD=Passw0rd \
        --mount src=mysql-data,dst=/var/lib/mysql \
        --network lnmp \
        -p 3306:3306 \
        mysql:5.7 \
        mysqld --character-set-server=utf8
    # php
    docker service create \
        --name php \
        -e MYSQL_PASSWORD=Passw0rd \
        --network lnmp yt/lnmp:php
    # nginx
    docker service create \
        --name nginx \
        --network lnmp \
        -p 80:80 \
        yt/lnmp:nginx
    # list services
    docker service ls
}

function rm(){
    docker service rm nginx
    docker service rm php
    docker service rm mysql
}

function ps() {
    # Load Swarm Manager Docker host environment
    eval "$(docker-machine env manager)"
    set -xe
    # List 'nginx' service tasks
    docker service ps -f desired-state=running nginx
    # List 'php' service tasks
    docker service ps -f desired-state=running php
    # List 'mysql' service tasks
    docker service ps -f desired-state=running mysql
}


##############################
#         Entrypoint         #
##############################

function main() {
    Command=$1
    shift
    case "${Command}" in
        deploy)     deploy ;;
        rm)         rm ;;
        create)     create ;;
        remove)     remove ;;
        up)         up ;;
        scale)      scale "$@" ;;
        env)        docker-machine env manager ;;
        down)       down ;;
        ps)         ps ;;
        nodes)      list_nodes ;;
        publish)    publish ;;
        *)          echo "Usage: $0 <create|remove|up|scale|down|ps|nodes|publish>"; exit 1 ;;
    esac
}

main "$@"


