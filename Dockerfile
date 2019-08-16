FROM ubuntu:18.04

RUN apt-get update -qq && apt-get install make git build-essential wget python3-pip python3 -y \
python libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev

# Get the specific supported GCC 
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/6_1-2017q1/gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2
RUN tar xvjf gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2
RUN cp /gcc-arm-none-eabi-6-2017-q1-update/ /usr/local/gcc-arm-none-eabi/ -r
ENV PATH $PATH:/usr/local/gcc-arm-none-eabi/bin/

# Get Cmake 3.7 (not available in any major distro)
RUN wget https://cmake.org/files/v3.11/cmake-3.11.1-Linux-x86_64.sh && bash cmake-3.11.1-Linux-x86_64.sh --skip-license --include-subdir 
ENV PATH $PATH:/cmake-3.11.1-Linux-x86_64/bin

RUN pip3 install pycrypto pyasn1

# Get latest upstream QEMU for M33 board
WORKDIR /tmp/
RUN wget https://download.qemu.org/qemu-4.1.0.tar.xz
RUN tar xf qemu-4.1.0.tar.xz
RUN cd qemu-4.1.0 && ./configure --target-list=arm-softmmu && make -j4 && make install

WORKDIR /opt/

CMD [ "/bin/bash" ]
