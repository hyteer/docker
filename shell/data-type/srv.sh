#!/bin/bash
services=$(cat services.json)
echo "SRV: $services"
echo "SRV_BASE: `echo ${services} | jq '.[0]'`"
#echo "$services |jq '.[0]'"


