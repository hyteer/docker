FROM qtz/base
ENV BASE_DIR="/data" \
    REDIS_VERSION="redis-3.2.4"
ENV SOFT_DIR="${BASE_DIR}/soft" \
    REDIS_PACKAGE="${REDIS_VERSION}.tar.gz"
WORKDIR ${SOFT_DIR}
RUN wget http://download.redis.io/releases/${REDIS_PACKAGE} && \
    tar -xzvf ${REDIS_PACKAGE} && \
    cd ${REDIS_VERSION} && \
    make && \
    cd src && \
    make install PREFIX=/usr/local/redis && \
    mkdir /usr/local/redis/etc && \
    cd ${REDIS_VERSION} && \
    cp ./redis.conf /usr/local/redis/etc && \
    echo "bind 0.0.0.0" >> /usr/local/redis/etc/redis.conf && \
    echo "export PATH=\$PATH:/usr/local/redis/bin" > /etc/profile.d/redis.sh && \
    . /etc/profile.d/redis.sh && \
    rm -rf ${SOFT_DIR}/*
CMD ["/usr/local/redis/bin/redis-server","/usr/local/redis/etc/redis.conf"]


