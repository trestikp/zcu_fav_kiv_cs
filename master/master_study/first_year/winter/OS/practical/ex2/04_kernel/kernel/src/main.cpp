#include <drivers/gpio.h>
#include <drivers/lcg.h>

// GPIO pin 47 je pripojeny na LED na desce (tzv. ACT LED)
constexpr uint32_t ACT_Pin = 47;

void wait_active(int ticks) {
	volatile unsigned int tim;

	for(tim = 0; tim < ticks; tim++)
		;
}

extern "C" int _kernel_main(void)
{
	// nastavime ACT LED pin na vystupni
	sGPIO.Set_GPIO_Function(ACT_Pin, NGPIO_Function::Output);

	LCG lcg;
	int gen_number;
	
    while (1)
    {
		// for a range use: lower + lcg.get_next() % (upper - lower) - eg: 5000 + lcg.get_next % 5000; (<5000, 10000))
		// gen_number = lcg.get_next();
		gen_number = lcgInstance.get_next(); // testing lcgInstance
		if (gen_number < 0) gen_number = -gen_number; // make sure sleep number is positive - to prevent active sleep for "0"
		wait_active(gen_number % 10000000); // limit the number to 10 mil max
		
		// zhasneme LED
		sGPIO.Set_Output(ACT_Pin, true);

		wait_active(2000000);

		// rozsvitime LED
		sGPIO.Set_Output(ACT_Pin, false);
    }
	
	return 0;
}
