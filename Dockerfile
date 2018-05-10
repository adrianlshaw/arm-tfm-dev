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

WORKDIR /tmp/
RUN git clone https://git.trustedfirmware.org/trusted-firmware-m.git --depth=1
RUN git clone https://github.com/ARMmbed/mbedtls.git -b mbedtls-2.5.1 --depth=1
RUN git clone https://github.com/ARM-software/CMSIS_5.git -b 5.2.0 --depth=1

RUN mkdir /tmp/trusted-firmware-m/build  

WORKDIR /tmp/
RUN wget https://download.qemu.org/qemu-2.12.0.tar.xz
RUN tar xf qemu-2.12.0.tar.xz
RUN cd qemu-2.12.0 && ./configure --target-list=arm-softmmu && make -j4 && make install

WORKDIR /opt/

CMD [ "/bin/bash" ]