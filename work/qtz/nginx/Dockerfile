FROM qtz/base 
#RUN echo "10.100.100.31	downloads.vikduo.com" >> /etc/hosts
# 安装pcre、pcre-devel库
RUN yum install pcre pcre-devel -y
# 下载、解压Nginx
RUN echo "10.100.100.31        downloads.vikduo.com">>/etc/hosts;wget -P /mydata/soft http://downloads.vikduo.com/nginx-1.7.9.tar.gz
WORKDIR /mydata/soft
RUN tar -xzvf nginx-1.7.9.tar.gz
# 添加组与用户
RUN groupadd nginx
RUN useradd -g nginx nginx -s /sbin/nologinmake
# 配置、编译、安装
WORKDIR nginx-1.7.9
RUN ./configure --prefix=/mydata/nginx --with-cc-opt=-O3 --user=nginx --group=nginx --with-cpu-opt=intel --with-http_stub_status_module --with-http_ssl_module --with-http_realip_module
RUN make
RUN make install
# 下载并替换nginx配置文件
WORKDIR /mydata/nginx/conf
RUN echo "10.100.100.31        downloads.vikduo.com">>/etc/hosts;wget -O nginx.conf http://downloads.vikduo.com/NginxConf/nginx.conf
# 配置vhost
RUN mkdir /mydata/nginx/conf/vhost
RUN echo "10.100.100.31        downloads.vikduo.com">>/etc/hosts;wget -P /mydata/nginx/conf/vhost http://downloads.vikduo.com/NginxConf/default.conf
RUN echo "10.100.100.31        downloads.vikduo.com">>/etc/hosts;wget -P /mydata/nginx/conf/vhost http://downloads.vikduo.com/NginxConf/demo.vikduo.com.conf
# 设置环境变量
RUN echo "export PATH=\$PATH:/mydata/nginx/sbin" > /etc/profile.d/nginx.sh
RUN . /etc/profile.d/nginx.sh
RUN /mydata/nginx/sbin/nginx;netstat -ntlp | grep nginx
CMD ["/mydata/nginx/sbin/nginx","-g","daemon off;"]
