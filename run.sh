set -e

sh build.sh
qemu-system-x86_64 -drive format=raw,file=.build/image.bin