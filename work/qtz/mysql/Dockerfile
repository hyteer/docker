FROM qtz/base
# Set Envs
ENV BASE_PATH="/data" \
    MYSQL_VERSION="mysql-5.6.21"
ENV SOFT_PATH="${BASE_PATH}/soft" \
    MYSQL_PACKAGE="${MYSQL_VERSION}.tar.gz" \
    MYSQL_PATH="${BASE_PATH}/mysql" \
    MYSQL_SOCK="/tmp/mysql.sock" \
    MYSQL_DATA="${BASE_PATH}/mysql/data" \
    HOST_IP="10.100.100.31" \
    HOST_NAME="downloads.vikduo.com"
# 下载解压
RUN yum install cmake -y && \
    yum clean all
WORKDIR ${SOFT_PATH}
RUN echo "${HOST_IP} ${HOST_NAME}" >> /etc/hosts && \
    echo "Current path: " && pwd && \
    wget -P ${SOFT_PATH} http://${HOST_NAME}/${MYSQL_PACKAGE} && \
    groupadd -r mysql && \
    useradd -g mysql -r -s /sbin/nologin mysql && \
    mkdir -p ${MYSQL_PATH} && \
    chown -R mysql:mysql ${MYSQL_PATH} && \
    tar xzf ${MYSQL_PACKAGE} && \
    cd ${MYSQL_VERSION} && \
    cmake . -DCMAKE_INSTALL_PREFIX=${MYSQL_PATH} \
    -DMYSQL_DATADIR=${MYSQL_PATH} \
    -DSYSCONFDIR=/etc \
    -DWITH_INNOBASE_STORAGE_ENGINE=1 \
    -DWITH_ARCHIVE_STORAGE_ENGINE=1 \
    -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
    -DWITH_READLINE=1 \
    -DWITH_SSL=bundled \
    -DWITH_ZLIB=bundled \
    -DWITH_LIBWRAP=0 \
    -DMYSQL_UNIX_ADDR=${MYSQL_SOCK} \
    -DDEFAULT_CHARSET=utf8 \
    -DDEFAULT_COLLATION=utf8_general_ci && \
    make && make install && \
    cd ${SOFT_PATH}/${MYSQL_VERSION} && \
    cp support-files/mysql.server /etc/init.d/mysqld && \
    chmod +x /etc/init.d/mysqld && \
    chkconfig --add mysqld && \
    chkconfig mysqld on && \
    echo 'MANPATH /data/mysql/man' >> /etc/man.config && \
    echo '/data/mysql/lib/' > /etc/ld.so.conf.d/mysql.conf && \
    ldconfig && \
    ln -sv ${MYSQL_PATH}/include/ /usr/include/mysql && \
    ${MYSQL_PATH}/scripts/mysql_install_db --basedir=${mysql_path} --datadir=${MYSQL_DATA} --user=mysql && \
    rm -f ${MYSQL_PATH}/my.cnf && \
    mkdir ${MYSQL_PATH}/log && \
    chown mysql:mysql ${MYSQL_PATH}/log && \
    ls ${MYSQL_PATH} && \
    service mysqld start && \
    test "$(netstat -ntlp | grep mysql)" == "" && echo "Start Mysql failed" || echo "Start Mysql OK" && \
    echo "export PATH=\$PATH:${MYSQL_PATH}/bin" > /etc/profile.d/mysql.sh && \
    rm -rf ${SOFT_PATH}/*





