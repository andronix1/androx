[bits 16]
[org 0x7c00]

start:
    mov si, loading
    call print_msg

read_drive:
    mov ah, 0x02
    mov al, STAGE2_SECTORS_SIZE + KERNEL_SECTORS_SIZE
    mov ch, 0
    mov cl, 2
    mov dh, 0
    xor bx, bx
    mov bx, es
    mov bx, STAGE2_LOAD_ADDR
    int 0x13
    jnc STAGE2_LOAD_ADDR

    mov si, failed_rd
    call print_msg   
    
	hlt


%include "rm.asm"

loading: db "Loading 2-stage bootloader...", NEW_LINE, 0
failed_rd: db "FAILED(stage1::read_drive)!", NEW_LINE, 0

times 0x200 - 2 - ($-$$) nop
dw 0xaa55