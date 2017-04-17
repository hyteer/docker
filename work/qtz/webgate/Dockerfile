FROM yt/lnmp-base
ENV BASE_DIR="/data" \
    HOSTIP="10.100.100.31" \
    HOSTNAME="downloads.vikduo.com" \
    NGINX_VERSION="nginx-1.7.9" \
    PHP_VERSION="php-5.6.3"
ENV SOFT_PATH="${BASE_DIR}/soft" \
    APP_PATH="${BASE_DIR}/apps" \
    WEB_PATH="${BASE_DIR}/www" \
    NGINX_PACKAGE="${NGINX_VERSION}.tar.gz" \
    PHP_PACKAGE="${PHP_VERSION}.tar.gz"
RUN mkdir ${BASE_DIR} && \
    mkdir -p ${APP_PATH}/nginx && \
    cd ${BASE_DIR} && \
    groupadd nginx && \
    useradd -g nginx nginx -s /sbin/nologinmake
RUN yum install pcre pcre-devel -y && \
    yum clean all

# Install Nginx
WORKDIR ${SOFT_PATH}
# RUN wget http://nginx.org/download/${NGINX_PACKAGE} && \
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts; \
    wget http://${HOSTNAME}/${NGINX_PACKAGE} && \
    tar zxvf ${NGINX_PACKAGE} && \
    cd ${NGINX_VERSION} && \ 
    ./configure \
    --prefix=${APP_PATH}/nginx \
    --with-cc-opt=-O3 \
    --user=nginx \
    --group=nginx \
    --with-cpu-opt=intel \
    --with-http_stub_status_module \
    --with-http_ssl_module \
    --with-http_realip_module && \
    make && make install
RUN mv ${APP_PATH}/nginx/conf/nginx.conf ${APP_PATH}/nginx/conf/nginx.conf.default && \
    mkdir -p ${WEB_PATH} && \
    chown -R nginx:nginx ${WEB_PATH}
COPY nginx.conf ${APP_PATH}/nginx/conf/
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
    make && make install
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts; \
    wget -P /etc http://${HOSTNAME}/PhpConf/php.ini && \
    wget -P /etc http://${HOSTNAME}/PhpConf/php-fpm.conf && \
    ln -s /etc/php-fpm.conf ${BASE_DIR}/php/etc/php-fpm.conf && \
    mkdir ${BASE_DIR}/php/log && \
    chown nginx:nginx ${BASE_DIR}/php/log && \
    cp ${SOFT_PATH}/${PHP_VERSION}/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm && \
    chmod 755 /etc/init.d/php-fpm && \
    /etc/init.d/php-fpm start && \
    netstat -ntlp | grep php-fpm && \
    echo "export PATH=\$PATH:${BASE_DIR}/php/bin" > /etc/profile.d/php.sh;. /etc/profile.d/php.sh
COPY start.sh ${BASE_DIR}
ADD www ${BASE_DIR}/www
RUN chown nginx:nginx ${BASE_DIR}/www && \
    chmod +x ${BASE_DIR}/start.sh
# END
CMD ${BASE_DIR}/start.sh
