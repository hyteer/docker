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
    LIBMCRYPT_PATH="${BASE_DIR}/libmcrypt" \
    # Thrift
    AUTOCONF_VERSION="autoconf-2.69.tar.gz" \
    AUTOMAKE_VERSION="automake-1.14.tar.gz" \
    BISON_VERSION="bison-2.5.1.tar.gz" \
    THRIFT_VERSION="thrift-0.9.3.tar.gz" \
    THRIFT_PATH="${BASE_DIR}/thrift"

RUN mkdir ${BASE_DIR} && \
    groupadd nginx && \
    useradd -g nginx nginx -s /sbin/nologin

# Install PHP
WORKDIR ${SOFT_PATH}
RUN yum install libxml2-devel bzip2-devel libcurl-devel libjpeg-devel libpng-devel freetype-devel unzip -y && \
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
    cd libevent-2.0.21-stable && \
    ./configure --prefix=${LIBEVENT_PATH} && \
    make && make install

# 安装memcached
WORKDIR ${SOFT_PATH}
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts && \
    wget -P ${SOFT_PATH} http://${HOSTNAME}/memcached-1.4.33.tar.gz && \
    wait && \
    tar xzf memcached-1.4.33.tar.gz && \
    cd memcached-1.4.33 && \
    pwd && ls && \
#    ${BASE_DIR}/php/bin/phpize ./ && \
    ./configure --prefix=${MEMCACHED_PATH} --with-libevent=${LIBEVENT_PATH} && \
    make && make install && \
    sed -i '865i\extension=memcache.so' /etc/php.ini && \
    ${MEMCACHED_PATH}/bin/memcached -d -m 1024 -u root -p 11211 -c 256 -P /tmp/memcached.pid && \
    echo "${MEMCACHED_PATH}/bin/memcached -d -m 1024 -u root -p 11211 -c 2048 -P /tmp/memcached.pid" >> /etc/rc.local && \
    rm -rf ${SOFT_PATH}/*

# 安装memcache 
WORKDIR ${SOFT_PATH}
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts && \
    wget -P ${SOFT_PATH} http://${HOSTNAME}/memcache-2.2.7.tgz && \
    wait && \
    tar xzf memcache-2.2.7.tgz && \
    cd memcache-2.2.7 && \
    ${PHP_PATH}/bin/phpize && \
    ./configure --enable-memcache --with-php-config=${PHP_PATH}/bin/php-config --with-zlib-dir && \
    make && make install && \
    sed -i '865i\extension=memcache.so' /etc/php.ini && \
    rm -rf ${SOFT_PATH}/*

# 安装librdkafka
WORKDIR ${SOFT_PATH}
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts && \
    wget -P ${SOFT_PATH} http://${HOSTNAME}/librdkafka-master.zip && \
    wait && \
    unzip librdkafka-master.zip && \
    cd librdkafka-master && \
    ./configure --prefix=/data/librdkafka-master && \
    make && make install && \
    rm -rf ${SOFT_PATH}/*

# 安装consul
WORKDIR ${SOFT_PATH}
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts && \
    wget -P ${SOFT_PATH} http://${HOSTNAME}/consul_0.7.2_linux_amd64.zip && \
    wait && \
    unzip consul_0.7.2_linux_amd64.zip && \
    mv consul /usr/local/sbin && \
    chmod 755 /usr/local/sbin/consul && \
    cd /etc && mkdir consul.d && \
    rm -rf ${SOFT_PATH}/*

# 安装Thrift
WORKDIR ${SOFT_PATH}
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts && \
    # autoconf
    wget -P ${SOFT_PATH} http://${HOSTNAME}/thrift/${AUTOCONF_VERSION} && \
    tar xzf ${AUTOCONF_VERSION} && \
    source_dir=`echo ${AUTOCONF_VERSION} | sed -e 's/.tar.gz//g'` && \    
    cd ${source_dir} && \
    ./configure --prefix=/usr && \
    make && make install && cd .. && \
    # automake
    wget -P ${SOFT_PATH} http://${HOSTNAME}/thrift/${AUTOMAKE_VERSION} && \
    tar xzf ${AUTOMAKE_VERSION} && \
    source_dir=`echo ${AUTOMAKE_VERSION} | sed -e 's/.tar.gz//g'` && \
    cd ${source_dir} && \
    ./configure --prefix=/usr && \
    make && make install && cd .. && \
    # bison
    wget -P ${SOFT_PATH} http://${HOSTNAME}/thrift/${BISON_VERSION} && \
    tar xzf ${BISON_VERSION} && \
    source_dir=`echo ${BISON_VERSION} | sed -e 's/.tar.gz//g'` && \
    cd ${source_dir} && \
    ./configure --prefix=/usr && \
    make && make install && cd .. && \
    # thrift
    source /etc/profile.d/php.sh && \
    wget -P ${SOFT_PATH} http://${HOSTNAME}/thrift/${THRIFT_VERSION} && \
    tar xzf ${THRIFT_VERSION} && \
    source_dir=`echo ${THRIFT_VERSION} | sed -e 's/.tar.gz//g'` && \
    cd ${source_dir} && \
    ./configure --prefix=${THRIFT_PATH} --with-php=yes --with-cpp=no --with-lua=no && \
    make && make install && cd .. && \
    echo "export PATH=${thriftInstallPath}/bin:\$PATH" >> /etc/profile.d/thrift.sh && \
    source /etc/profile.d/thrift.sh && \
    rm -rf ${SOFT_PATH}/*

# 其它配置
RUN mkdir -p ${BASE_DIR}/www && \
    chown nginx:nginx ${BASE_DIR}/www
# consul集群配置
# COPY conf/opt-test.json.base /etc/consul.d/opt-test.json    
# END
