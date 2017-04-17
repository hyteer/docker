#!/bin/bash
## start php
/etc/init.d/php-fpm start

## start nginx
/data/apps/nginx/sbin/nginx -g "daemon off;"


#

