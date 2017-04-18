FROM qtz/base
ENV BASE_DIR="/data" \
    HOSTIP="10.100.100.31" \
    HOSTNAME="downloads.vikduo.com" \
    PHP_VERSION="php-5.6.3"
ENV SOFT_PATH="${BASE_DIR}/soft" \
    PHP_PACKAGE="${PHP_VERSION}.tar.gz" \
    PHP_PATH="${BASE_DIR}/php" \
    LIBEVENT_PATH="${BASE_DIR}/libevent" \
    MEMCACHED_PATH="${BASE_DIR}/memcached" \
    LIBMCRYPT_PATH="${BASE_DIR}/libmcrypt"
RUN mkdir ${BASE_DIR} && \
    groupadd nginx && \
    useradd -g nginx nginx -s /sbin/nologin

# Install PHP
WORKDIR ${SOFT_PATH}
RUN yum install libxml2-devel bzip2-devel libcurl-devel libjpeg-devel libpng-devel freetype-devel -y && \
    yum clean all
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts; \
    wget -P ${SOFT_PATH} http://${HOSTNAME}/${PHP_PACKAGE} && \
    wget -P ${SOFT_PATH} http://${HOSTNAME}/libmcrypt-2.5.8.tar.gz && \
    tar -xzvf libmcrypt-2.5.8.tar.gz && \
    cd libmcrypt-2.5.8 && \
    ./configure  --prefix=${BASE_DIR}/libmcrypt && \
    make && make install && \
    cd .. && \
    tar -xzvf ${PHP_PACKAGE} && \
    cd ${PHP_VERSION} && \
    ./configure \
    --prefix=${BASE_DIR}/php \
    --with-mysql=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-openssl \
    --enable-mbstring \
    --with-freetype-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib \
    --with-libxml-dir=/usr \
    --enable-xml \
    --enable-sockets \
    --enable-fpm \
    --with-mcrypt=${BASE_DIR}/libmcrypt \
    --with-config-file-path=/etc \
    --with-config-file-scan-dir=/etc/php.d \
    --with-bz2 \
    --with-gd \
    --with-curl \
    --enable-zip \
    --enable-soap && \
    make && make install && \
    cp ${SOFT_PATH}/${PHP_VERSION}/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm && \
    chmod 755 /etc/init.d/php-fpm && \
    rm -rf ${SOFT_PATH}/*

RUN echo $HOSTIP $HOSTNAME>>/etc/hosts; \
    wget -P /etc http://${HOSTNAME}/PhpConf/php.ini && \
    wget -P /etc http://${HOSTNAME}/PhpConf/php-fpm.conf && \
    ln -s /etc/php-fpm.conf ${BASE_DIR}/php/etc/php-fpm.conf && \
    mkdir ${BASE_DIR}/php/log && \
    chown nginx:nginx ${BASE_DIR}/php/log && \
    /etc/init.d/php-fpm start && \
    netstat -ntlp | grep php-fpm && \
    echo "export PATH=\$PATH:${BASE_DIR}/php/bin" > /etc/profile.d/php.sh;. /etc/profile.d/php.sh

## 安装PHP扩展
ADD http://${HOSTNAME}/${PHP_PACKAGE} ${SOFT_PATH}
COPY extensions/no-debug-non-zts-20131226 ${BASE_DIR}/php/lib/php/extensions/no-debug-non-zts-20131226
RUN echo "extension=memcache.so" >> /etc/php.ini && \
    echo "extension=mongodb.so" >> /etc/php.ini && \
    echo "extension=pcntl.so" >> /etc/php.ini && \
    echo "extension=rdkafka.so" >> /etc/php.ini && \
    echo "extension=redis.so" >> /etc/php.ini && \
    echo "extension=swoole.so" >> /etc/php.ini && \
    echo "extension=sysvmsg.so" >> /etc/php.ini && \
    echo "extension=sysvsem.so" >> /etc/php.ini && \
    echo "extension=sysvshm.so" >> /etc/php.ini && \
    echo "extension=libevent.so" >> /etc/php.ini && \
    echo "extension=bcmath.so" >> /etc/php.ini && \
    curl -Ss http://www.workerman.net/check.php | ${BASE_DIR}/php/bin/php

# 安装libevent
WORKDIR ${SOFT_PATH}
RUN echo ${HOSTIP} ${HOSTNAME}>>/etc/hosts && \
    wget http://${HOSTNAME}/libevent-2.0.21-stable.tar.gz && \
    wait && \
    tar xzf libevent-2.0.21-stable.tar.gz && \
    ./configure --prefix=${LIBEVENT_PATH} && \
    make && make install

# 安装memcached
WORKDIR ${SOFT_PATH}
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts && \
    wget -P ${SOFT_PATH} http://${HOSTNAME}/memcached-1.4.33.tar.gz && \
    wait && \
    tar xzf memcached-1.4.33.tar.gz && \
    cd memcached-1.4.33 && \
    ${BASE_DIR}/php/bin/phpize && \
    ./configure --prefix=${MEMCACHED_PATH} --with-libevent=${LIBEVENT_PATH} && \
    make && make install && \
    sed -i '865i\extension=memcache.so' /etc/php.ini && \
    ${MEMCACHED_PATH}/bin/memcached -d -m 1024 -u root -p 11211 -c 256 -P /tmp/memcached.pid && \
    echo "${MEMCACHED_PATH}/bin/memcached -d -m 1024 -u root -p 11211 -c 2048 -P /tmp/memcached.pid" >> /etc/rc.local

# 安装 libevent

# END
