set -ex

if [ -z $(git config --list | grep email) ]; then
	git config --global user.email "you@example.com"
	git config --global user.name "Your Name"
fi

cd trusted-firmware-m/
cmake -S . -B cmake_build -DTFM_PLATFORM=mps2/an521 -DTFM_TOOLCHAIN_FILE=toolchain_GNUARM.cmake -DCMAKE_BUILD_TYPE=Debug -DTFM_PROFILE=profile_small -DTEST_PSA_API=CRYPTO
HERE=$PWD
cd trusted-firmware-m/cmake_build/lib/ext/mbedcrypto-src && git apply ../../../../lib/ext/mbedcrypto/*.patch
cd $HERE
cmake -S . -B cmake_build -DTFM_PLATFORM=mps2/an521 -DTFM_TOOLCHAIN_FILE=toolchain_GNUARM.cmake -DCMAKE_BUILD_TYPE=Debug -DTFM_PROFILE=profile_small -DTEST_PSA_API=CRYPTO
cmake --build cmake_build -- install
timeout --foreground 10 qemu-system-arm -M mps2-an521 -kernel cmake_build/bin/bl2.axf  -device loader,file=cmake_build/bin/tfm_s_ns_signed.bin,addr=0x10080000 -serial stdio -display none || true
