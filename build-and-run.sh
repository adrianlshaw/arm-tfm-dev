set -ex

cd trusted-firmware-m/
cmake -S . -B cmake_build -DTFM_PLATFORM=mps2/an521 -DCMAKE_TOOLCHAIN_FILE=toolchain_GNUARM.cmake -DCMAKE_BUILD_TYPE=Debug -DTFM_PROFILE=profile_small -DTEST_PSA_API=CRYPTO
cmake --build cmake_build -- install
#cmake ../ -G"Unix Makefiles" -DPROJ_CONFIG=`readlink -f ../configs/ConfigRegressionIPC.cmake` -DTARGET_PLATFORM=AN521 -DCMAKE_BUILD_TYPE=Debug -DCOMPILER=GNUARM -DBL2=True && make
timeout --foreground 10 qemu-system-arm -M mps2-an521 -kernel cmake_build/bin/bl2.axf  -device loader,file=cmake_build/bin/tfm_s_ns_signed.bin,addr=0x10080000 -serial stdio -display none || true
