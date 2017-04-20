FROM qtz/php
RUN mkdir /start && \
    mkdir /data/www && \
    chmod +x /start/* && \
    chown nginx:nginx /data/www
#
COPY opt-test.json /etc/consul.d/opt-test.json
ADD _code_ /data/www
# Start
ADD start /start
CMD /start/start.sh


