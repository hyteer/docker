FROM opt/nginx-base
#
ENV BASE="/data" 
ENV WEB_PATH="${BASE}/www"

COPY opt-test.json /etc/consul.d/opt-test.json
ADD _code_ ${WEB_PATH}
ADD conf/nginx ${BASE}/nginx/conf/vhost

# deploy
ADD scripts /scripts
RUN cd ${BASE} && /scripts/deploy.sh
# start
CMD /scripts/start.sh



