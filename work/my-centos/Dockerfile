FROM centos:6.8
MAINTAINER by huyt (40577190@qq.com)
RUN mkdir /mydata
WORKDIR /mydata
ADD run.sh /usr/local/sbin/run.sh
RUN chmod 755 /usr/local/sbin/run.sh
RUN echo "root:123456"|chpasswd
CMD ["/usr/local/sbin/run.sh"]

