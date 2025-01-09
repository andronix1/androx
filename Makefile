STAGE2_SECTORS_SIZE=1

.build/image.bin: .build boot/x86/.build/boot.bin kernel/.build/kernel.bin
	cat boot/x86/.build/boot.bin kernel/.build/kernel.bin > .build/image.bin

kernel/.build/kernel.bin:
	STAGE2_SECTORS_SIZE=$(STAGE2_SECTORS_SIZE) make -C kernel

boot/x86/.build/boot.bin: kernel/.build/kernel.bin
	STAGE2_SECTORS_SIZE=$(STAGE2_SECTORS_SIZE) KERNEL_SECTORS_SIZE=$(shell echo "($(shell stat -c%s "kernel/.build/kernel.bin") + 511) / 512" | bc) make -C boot/x86

.build:
	mkdir .build

clean:
	make clean -C boot/x86
	make clean -C kernel