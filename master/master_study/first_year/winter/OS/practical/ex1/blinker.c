// GPIO pin 47 is wired to onboard LED (so called ACT LED)

// "function select register" - here we select "output" mode for pin 47
//#define GPFSEL4 0x20200010
#define GPFSEL1 0x20200004

// "set" register - here we turn on the output of pin 47
//#define GPSET1  0x20200020
#define GPSET0  0x2020001C
// "clear" register - here we turn off the output of pin 47
#define GPCLR0  0x20200028

// write to a given memory (to avoid optimizations)
void write32(unsigned int address, unsigned int val)
{
    *((volatile unsigned int*)address) = val;
}

// read from a given memory
unsigned int read32(unsigned int address)
{
    return *((volatile unsigned int*)address);
}

// "burn" some CPU cycles for nothing - this just creates a delay
void active_sleep(unsigned int ticks)
{
    volatile int ra;
    for (ra = 0; ra < ticks; ra++)
        ;
}

// this gets called from start.s
void kernel_main()
{
    unsigned int reg;

    // read current content of function select register
    reg = read32(GPFSEL1);
    reg &= ~(7 << 24);           // mask out current (3-bit, hence the 7) setting of pin 47 - see the BCM manual for how we came up with the "21"
    reg |= 1 << 24;              // set "1" to the setting, which means "output" (also see the manual)
    write32(GPFSEL1, reg);       // write back the value to the function select register

    // we will loop there indefinitely
    while(1)
    {
        volatile unsigned int counter = 0;
        for (counter = 0; counter < 3; counter++) {
            write32(GPSET0, 1 << 18);
            active_sleep(0xFFF00);
            write32(GPCLR0, 1 << 18);
            active_sleep(0xFFF00);
        }

        for (counter = 0; counter < 3; counter++) {
            write32(GPSET0, 1 << 18);
            active_sleep(0x400000);
            write32(GPCLR0, 1 << 18);
            active_sleep(0x400000);
        }

        for (counter = 0; counter < 3; counter++) {
            write32(GPSET0, 1 << 18);
            active_sleep(0xFFF00);
            write32(GPCLR0, 1 << 18);
            active_sleep(0xFFF00);
        }
        
        write32(GPCLR0, 1 << 18);
        active_sleep(0xF00000);
    }
}
