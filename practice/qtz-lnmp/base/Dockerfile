FROM centos:6.8
RUN yum install zlib zlib-devel wget gcc gcc-c++ make autoconf openssl openssl-devel ncurses ncurses-devel telnet.x86_64 -y && \
    yum clean all && \
    echo "root:123456"|chpasswd
# EXPOSE 22
# CMD ["/usr/sbin/sshd","-D"]
