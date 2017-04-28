#!/bin/bash
echo "start..."
docker service create --network opt --name gate-go -p 8080:8080 opt/gate-go
echo "启动gate-go..." && sleep 3
echo "启动nginx..."
docker service create --network opt --name nginx -p 80:80 opt/nginx
