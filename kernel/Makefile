.build/kernel.bin: .build
	gcc -c -O3 -m32 -g -nostdlib -fno-pic -ffreestanding -fno-stack-protector kmain.c -o .build/kernel.o
	ld -Tlink.ld .build/kernel.o -o .build/kernel.elf
	objcopy -O binary .build/kernel.elf .build/kernel.bin

.build:
	mkdir .build

clean:
	rm -Rf .build