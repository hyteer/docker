FROM yt/centos6-java
ADD ./data /home/test/data
WORKDIR /home/test/data
RUN touch testfile
RUN echo "hello"
CMD ["touch", "newfile"]


