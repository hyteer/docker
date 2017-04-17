FROM qtz/base 
#RUN echo "10.100.100.31	downloads.vikduo.com" >> /etc/hosts
ENV SOFT_PATH="/mydata/soft" \
    RES_IP="10.100.100.31" \
    RES_DOMAIN="downloads.vikduo.com" \
    NGINX_VERSION="nginx-1.7.9"
ENV RES_HOSTMAP="${RES_IP} ${RES_DOMAIN}" \
    NGINX_PACKAGE="${NGINX_VERSION}.tar.gz"

# 安装pcre、pcre-devel库 & 下载、解压Nginx
RUN yum install pcre pcre-devel -y && \
    echo ${RES_HOSTMAP}>>/etc/hosts && \
    wget -P ${SOFT_PATH} http://${RES_DOMAIN}/${NGINX_PACKAGE} && \
    cd ${SOFT_PATH} && \
    tar -xzvf nginx-1.7.9.tar.gz && \
    groupadd nginx && \
    useradd -g nginx nginx -s /sbin/nologinmake
# 配置、编译、安装
WORKDIR ${SOFT_PATH}/${NGINX_VERSION}
RUN ./configure \
    --prefix=/mydata/nginx \
    --with-cc-opt=-O3 \
    --user=nginx \
    --group=nginx \
    --with-cpu-opt=intel \
    --with-http_stub_status_module \
    --with-http_ssl_module \
    --with-http_realip_module; \
    make && make install
# 下载并替换nginx配置文件
WORKDIR /mydata/nginx/conf
RUN echo ${RES_HOSTMAP}>>/etc/hosts && \
    wget -O nginx.conf http://${RES_DOMAIN}/NginxConf/nginx.conf && \
    mkdir /mydata/nginx/conf/vhost && \
    echo ${RES_HOSTMAP}>>/etc/hosts && \
    wget -P /mydata/nginx/conf/vhost http://${RES_DOMAIN}/NginxConf/default.conf && \
    wget -P /mydata/nginx/conf/vhost http://${RES_DOMAIN}/NginxConf/demo.vikduo.com.conf && \
    echo "export PATH=\$PATH:/mydata/nginx/sbin" > /etc/profile.d/nginx.sh && \
    . /etc/profile.d/nginx.sh && \
    /mydata/nginx/sbin/nginx;netstat -ntlp | grep nginx
CMD ["/mydata/nginx/sbin/nginx","-g","daemon off;"]
