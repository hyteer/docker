FROM qtz/php
#
ENV BASE="/data" 
ENV WEB_PATH="${BASE}/www"

COPY opt-test.json /etc/consul.d/opt-test.json
ADD _code_/www ${WEB_PATH}

# deploy
RUN mkdir /scripts
ADD scripts /scripts
RUN cd ${BASE} && /scripts/deploy.sh
# start
CMD /scripts/start.sh



