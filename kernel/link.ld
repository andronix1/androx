OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)

SECTIONS {
    . = 0x8000;
    .text : {
        *(.text.entry)
        *(.text)
    }
    .data : { *(.data) }
    .rodata : { *(.rodata) }
    .bss : { *(.bss) }
}