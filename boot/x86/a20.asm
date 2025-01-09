enable_fast_a20:
    push ax
    in al, 0x92
    or al, 0x10
    out 0x92, al
    pop ax
    ret