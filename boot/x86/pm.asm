[bits 32]

pm_main:
    mov ax, (gdt.data - gdt)
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov bp, 0x7c00
    mov bp, sp
    jmp STAGE2_LOAD_ADDR + 512 * STAGE2_SECTORS_SIZE
    jmp $

[bits 16]
