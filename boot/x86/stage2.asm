[bits 16]
[org STAGE2_LOAD_ADDR]

start:
enable_a20:
    mov si, enabling_a20
    call print_msg
    call enable_fast_a20

set_gdt:
    mov si, setting_gdt
    call print_msg
    call init_pm

jump_to_kernel:
    jmp (gdt.code - gdt):pm_main

exit:
    hlt

%include "gdt.asm"
%include "a20.asm"
%include "rm.asm"
%include "pm.asm"

enabling_a20: db "Enabling a20 line...", NEW_LINE, 0
setting_gdt: db "Setting up GDT...", NEW_LINE, 0

times STAGE2_SECTORS_SIZE * 512 - ($-$$) nop
