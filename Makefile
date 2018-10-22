CUR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

fetch_modules:
	git submodule init
	git submodule update

docker_build: fetch_modules
	docker build -t tfmtest .

cmake_dir:
	mkdir -p trusted-firmware-m/build/

all: docker_build cmake_dir
	docker run -ti --rm -v $(CUR):/opt tfmtest /bin/bash -c \
	       	"cd trusted-firmware-m/build && cmake ../ -G\"Unix Makefiles\" -DPROJ_CONFIG=\`readlink -f ../ConfigRegression.cmake\` -DTARGET_PLATFORM=AN521 -DCMAKE_BUILD_TYPE=Debug -DCOMPILER=GNUARM && make"

qemu: all
	docker run -ti --rm -v $(CUR):/opt tfmtest /bin/bash -c \
	       	"cd trusted-firmware-m/build && qemu-system-arm -M mps2-an505 -kernel bl2/ext/mcuboot/mcuboot.axf  -device loader,file=tfm_sign.bin,addr=0x10080000 -serial stdio -display none"
