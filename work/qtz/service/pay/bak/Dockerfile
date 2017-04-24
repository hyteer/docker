FROM qtz/php
RUN mkdir /scripts
COPY opt-test.json /etc/consul.d/opt-test.json
ADD scripts /scripts
RUN chmod +x /scripts/* && /scripts/deploy.sh
CMD /scripts/start.sh


