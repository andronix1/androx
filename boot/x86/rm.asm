%define NEW_LINE 10, 13

print_msg:
    pusha
    mov ah, 0x0e
    mov bh, 0
    mov bl, 0x04
    .loop_start:
        lodsb
        or al, al
        jz .loop_end
        int 0x10
        jmp .loop_start
    .loop_end:
    popa
    ret