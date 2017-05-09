#!/bin/bash
date
ls
cd pay
echo "生成pay服务thrift code..."
    for file in ./thriftFiles/*.thrift
    do
        if test -f ${file}
        then
        	file2=`echo ${file}|cut -c 3-`
            docker run -v "$PWD:/data" thrift thrift -o /data --gen php:server /data/${file2}
        else
            echo "${file} is not a file..."
        fi
    done
cp -rf gen-php/thriftServices/* thriftServices/
ls thriftServices
####
cd ../order
echo "生成order服务thrift code..."
    for file in ./thriftFiles/*.thrift
    do
        if test -f ${file}
        then
        	file2=`echo ${file}|cut -c 3-`
            docker run -v "$PWD:/data" thrift thrift -o /data --gen php:server /data/${file2}
        else
            echo "${file} is not a file..."
        fi
    done
cp -rf gen-php/thriftServices/* thriftServices/
ls thriftServices
