FROM yt/lnmp-base
ENV BASE_DIR="/data" \
    NGINX_VERSION="nginx-1.7.9"
ENV SOFT_PATH="${BASE_DIR}/soft" \
    APP_PATH="${BASE_DIR}/apps" \
    WEB_PATH="${BASE_DIR}/www" \
    NGINX_PACKAGE="${NGINX_VERSION}.tar.gz"
RUN mkdir ${BASE_DIR} && \
    mkdir -p ${APP_PATH}/nginx && \
    cd ${BASE_DIR} && \
    groupadd nginx && \
    useradd -g nginx nginx -s /sbin/nologinmake
RUN yum install pcre pcre-devel -y && \
    yum clean all

# Install Nginx
WORKDIR ${SOFT_PATH}
RUN wget http://nginx.org/download/${NGINX_PACKAGE} && \
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
#RUN yum install libxml2-devel bzip2-devel libcurl-devel libjpeg-devel libpng-devel freetype-devel -y

CMD ["${APP_PATH}/nginx/sbin/nginx","-g","daemon off;"]
