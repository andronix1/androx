set -e
sh build.sh
qemu-system-i386 -S -s -drive format=raw,file=.build/image.bin &
gdb \
    -ex "target remote localhost:1234" \
    -ex "file kernel/.build/kernel.elf" \
    -ex "b put_char" \
    -ex "b kmain" \
    -ex "layout asm" \
    -ex "layout regs" \
    -ex "c"