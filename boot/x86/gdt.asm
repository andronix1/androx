%define A_PRESENT (1 << 7)
%define A_DPL_KERNEL (0b00 << 5)
%define A_DPL_DRIVER_HIGH (0b01 << 5)
%define A_DPL_DRIVER_LOW (0b10 << 5)
%define A_DPL_USER (0b11 << 5)
%define A_TSS (0b00 << 3)
%define A_DATA (0b10 << 3)
%define A_CODE (0b11 << 3)
%define A_DATA_WRITE (1 << 1)
%define A_CODE_READ (1 << 1)
%define A_ACCESSED 1

%define F_PAGES 0b1000
%define F_32_BIT 0b0100
%define F_64_BIT 0b0010

init_pm:
    cli
    lgdt [gdtr]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    ret

gdt:
    .null: dq 0
    .code:
        dw 0xFFFF ; limit low
        dw 0x0000 ; base high
        db 0x00   ;
        db A_PRESENT | A_DPL_KERNEL | A_CODE | A_CODE_READ | A_ACCESSED
        db (F_PAGES | F_32_BIT) << 4 | 0xF ; flags << 4 | limit low
        db 0x00   ; base low
    .data:
        dw 0xFFFF ; limit low
        dw 0x0000 ; base high
        db 0x00   ;
        db A_PRESENT | A_DPL_KERNEL | A_DATA | A_DATA_WRITE | A_ACCESSED
        db (F_PAGES | F_32_BIT) << 4 | 0xF
        db 0x00   ; base low
gdtr:
    dw gdtr - gdt - 1 ; size
    dd gdt            ; offset