set -e

apt update -qq
apt install -y build-essential python3-dev python3-pip gcc g++ make \
	git build-essential wget python3-pip python3 git-lfs python libglib2.0-dev \
	libfdt-dev libpixman-1-dev zlib1g-dev cmake

apt install gcc-arm-none-eabi -y

#wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/6_1-2017q1/gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2
#tar xvjf gcc-arm-none-eabi-6-2017-q1-update-linux.tar.bz2
#cp gcc-arm-none-eabi-6-2017-q1-update/ /usr/local/gcc-arm-none-eabi/ -r
#export PATH=/usr/local/gcc-arm-none-eabi/bin/:$PATH

#wget https://cmake.org/files/v3.11/cmake-3.11.1-Linux-x86_64.sh && bash cmake-3.11.1-Linux-x86_64.sh --skip-license --include-subdir
#export PATH=$PATH:$PWD/cmake-3.11.1-Linux-x86_64/bin
#cp -r $PWD/cmake-3.11.1-Linux-x86_64/bin/* /usr/local/bin/


pip3 install cryptography pycrypto pyasn1 cbor

wget https://download.qemu.org/qemu-4.1.0.tar.xz
tar xf qemu-4.1.0.tar.xz
cd qemu-4.1.0 && ./configure --target-list=arm-softmmu && make -j4 && make install
