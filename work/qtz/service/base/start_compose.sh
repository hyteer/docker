#!/bin/bash
nohup /usr/local/sbin/consul agent -server -bootstrap-expect 3 -data-dir /tmp/consul   -config-dir /etc/consul.d &
/usr/local/sbin/consul join 172.17.0.3
/usr/local/sbin/consul monitor

