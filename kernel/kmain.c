#define WIDTH 80
#define HEIGHT 25

int vmem_id = 0;
volatile short *vmem = (short*)0xb8000;

#define COL_BLACK 0x0
#define COL_BLUE 0x1
#define COL_GREEN 0x2
#define COL_CYAN 0x3
#define COL_RED 0x4
#define COL_MAGENTA 0x5
#define COL_BROWN 0x6
#define COL_LIGHT_GRAY 0x7
#define COL_DARK_GRAY 0x8
#define COL_LIGHT_BLUE 0x9
#define COL_LIGHT_GREEN 0xA
#define COL_LIGHT_CYAN 0xB
#define COL_LIGHT_RED 0xC
#define COL_LIGHT_MAGENTA 0xD
#define COL_YELLOW 0xE
#define COL_WHITE 0xF

#define COLOR(fg, bg) ((bg << 4) | fg)

void put_char(char c, char color) {
    vmem[vmem_id++] = (color << 8) | c;
}

void new_line() {
    vmem_id += WIDTH - vmem_id % WIDTH;
}

void print_str(const char *str, char color) {
    for (int i = 0; str[i] != 0; i++) {
        put_char(str[i], color);
    }
}

void __attribute__((section(".text.entry"))) kmain() {
    char colors[] = {
        COLOR(COL_LIGHT_RED, COL_RED),
        COLOR(COL_YELLOW, COL_BROWN),
        COLOR(COL_LIGHT_GREEN, COL_GREEN),
        COLOR(COL_LIGHT_CYAN, COL_CYAN),
        COLOR(COL_LIGHT_BLUE, COL_BLUE),
        COLOR(COL_LIGHT_MAGENTA, COL_MAGENTA),
    };
    int cols_count = sizeof(colors) / sizeof(colors[0]);
    int inc = 0;
    for (int i = 0;; i++) {
        for (int j = 0; j < HEIGHT; j++) {
            int col_id = (j + inc) % (cols_count * 2 - 1);
            if (col_id >= cols_count) {
                col_id -= cols_count;
            }
            vmem_id += 17;
            print_str("\"hello, world\" from kernel!(azaza lol kek)", colors[col_id]);
            new_line();
        }
        vmem_id = 0;
        inc++;
        for (int j = 0; j < 100000000; j++) asm ("nop");
    }
    // print_str(msg);
}