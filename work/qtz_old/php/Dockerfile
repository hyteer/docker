FROM qtz/base 
#RUN echo "10.100.100.31	downloads.vikduo.com" >> /etc/hosts
ENV HOSTIP 10.100.100.31
ENV HOSTNAME downloads.vikduo.com
ENV PHPVERSION php-5.6.3
# 安装依赖库
RUN yum install libxml2-devel bzip2-devel libcurl-devel libjpeg-devel libpng-devel freetype-devel -y 
# 下载、解压php与libmcrypt
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts;wget -P /mydata/soft http://downloads.vikduo.com/$PHPVERSION.tar.gz
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts;wget -P /mydata/soft http://downloads.vikduo.com/libmcrypt-2.5.8.tar.gz
WORKDIR /mydata/soft
RUN pwd;ls
RUN tar -xzvf libmcrypt-2.5.8.tar.gz
WORKDIR libmcrypt-2.5.8
RUN ./configure  --prefix=/mydata/libmcrypt
RUN make && make install
WORKDIR /mydata/soft
RUN tar -xzvf $PHPVERSION.tar.gz
WORKDIR $PHPVERSION
RUN ./configure \
--prefix=/mydata/php \
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
--with-mcrypt=/mydata/libmcrypt \
--with-config-file-path=/etc \
--with-config-file-scan-dir=/etc/php.d \
--with-bz2 \
--with-gd \
--with-curl \
--enable-zip \
--enable-soap
RUN make && make install
# 添加组与用户
RUN groupadd nginx
RUN useradd -g nginx nginx -s /sbin/nologinmake
# 下载、替换php.ini与php-fpm.conf配置文件
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts;wget -P /etc http://downloads.vikduo.com/PhpConf/php.ini
RUN echo $HOSTIP $HOSTNAME>>/etc/hosts;wget -P /etc http://downloads.vikduo.com/PhpConf/php-fpm.conf
RUN ln -s /etc/php-fpm.conf /mydata/php/etc/php-fpm.conf
RUN sed -i 's/daemonize = yes/daemonize = no/g' /etc/php-fpm.conf
# 创建php log文件目录并制定文件的拥有者
RUN mkdir /mydata/php/log
RUN chown nginx:nginx /mydata/php/log
# 拷贝php-fpm启动文件，并启动php-fpm服务
RUN cp /mydata/soft/$PHPVERSION/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
RUN chmod 755 /etc/init.d/php-fpm
RUN /etc/init.d/php-fpm start;netstat -ntlp | grep php-fpm
# 设置php环境变量
RUN echo "export PATH=\$PATH:/mydata/php/bin" > /etc/profile.d/php.sh;. /etc/profile.d/php.sh
CMD ["/etc/init.d/php-fpm","start"]
