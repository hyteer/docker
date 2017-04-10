FROM centos:6.8
RUN yum install zlib zlib-devel wget gcc gcc-c++ make autoconf gcc gcc-c++ openssl openssl-devel ncurses ncurses-devel -y
RUN echo "root:123456"|chpasswd
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
