set -e

cd trusted-firmware-m/
rm -rf build
mkdir build
cd build/
cmake ../ -G"Unix Makefiles" -DPROJ_CONFIG=`readlink -f ../configs/ConfigRegressionIPC.cmake` -DTARGET_PLATFORM=AN521 -DCMAKE_BUILD_TYPE=Debug -DCOMPILER=GNUARM -DBL2=True && make
timeout --foreground 10 qemu-system-arm -M mps2-an521 -kernel bl2/ext/mcuboot/mcuboot.axf  -device loader,file=tfm_sign.bin,addr=0x10080000 -serial stdio -display none || true
