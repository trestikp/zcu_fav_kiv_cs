// GPIO pin 47 is wired to onboard LED (so called ACT LED)

// "function select register" - here we select "output" mode for pin 47
#define GPFSEL4 0x20200010

// "set" register - here we turn on the output of pin 47
#define GPSET1  0x20200020
// "clear" register - here we turn off the output of pin 47
#define GPCLR1  0x2020002C

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
    reg = read32(GPFSEL4);
    reg &= ~(7 << 21);           // mask out current (3-bit, hence the 7) setting of pin 47 - see the BCM manual for how we came up with the "21"
    reg |= 1 << 21;              // set "1" to the setting, which means "output" (also see the manual)
    write32(GPFSEL4, reg);       // write back the value to the function select register

    // we will loop there indefinitely
    while(1)
    {
        // set the output on
        write32(GPSET1, 1 << (47 - 32));

        // wait for some time
        active_sleep(0x80000);

        // clear the output
        write32(GPCLR1, 1 << (47 - 32));

        // wait again
        active_sleep(0x80000);

        // .. and repeat
    }
}
