FROM ubuntu:20.04
COPY install-dependencies.sh /tmp
RUN chmod +x /tmp/install-dependencies.sh
ENV DEBIAN_FRONTEND=noninteractive
RUN /tmp/install-dependencies.sh
WORKDIR /opt
ENV PATH /usr/local/gcc-arm-none-eabi/bin/:$PATH
CMD [ "/bin/bash" ]
