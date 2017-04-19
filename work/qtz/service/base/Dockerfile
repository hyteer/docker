FROM qtz/php
RUN mkdir /start
COPY opt-test.json /etc/consul.d/opt-test.json
ADD start /start
RUN chmod +x /start/*
CMD /start/start.sh


