STAGE2_LOAD_ADDR=0x7e00

FLAGS=-fbin -DSTAGE2_SECTORS_SIZE=${STAGE2_SECTORS_SIZE} -DSTAGE2_LOAD_ADDR=$(STAGE2_LOAD_ADDR)

all: .build/boot.bin

.build/boot.bin: .build/mbr.bin .build/2st.bin
	cat .build/mbr.bin .build/2st.bin > .build/boot.bin

.build/mbr.bin: .build stage1.asm
	nasm $(FLAGS) -DKERNEL_SECTORS_SIZE=${KERNEL_SECTORS_SIZE}  stage1.asm -o .build/mbr.bin

.build/2st.bin: .build stage2.asm
	nasm $(FLAGS) stage2.asm -o .build/2st.bin

clean:
	rm -Rf .build

.build:
	mkdir .build