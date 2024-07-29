#include <drivers/gpio.h>
#include <drivers/uart.h>

// GPIO pin 47 je pripojeny na LED na desce (tzv. ACT LED)
constexpr uint32_t ACT_Pin = 47;

void burn_time(int time) {
	volatile unsigned int tim;
	for(tim = 0; tim < time; tim++)
		;
}

/* A utility function to reverse a string (used in itoa) 
	This implementation will be moved to a more appropriate file
*/
void reverse(char str[], int length)
{
    int start = 0;
    int end = length -1;
    while (start < end)
    {
        // swap(*(str+start), *(str+end));
		int tmp = *(str+start);
		*(str+start) = *(str+end);
		*(str+end) = tmp;
        start++;
        end--;
    }
}
 
/* Implementation of itoa()
	This implementation will be moved to a more appropriate file
 */
char* itoa(int num, char* str, int base)
{
    int i = 0;
    bool isNegative = false;
 
    /* Handle 0 explicitly, otherwise empty string is printed for 0 */
    if (num == 0)
    {
        str[i++] = '0';
        str[i] = '\0';
        return str;
    }
 
    // In standard itoa(), negative numbers are handled only with
    // base 10. Otherwise numbers are considered unsigned.
    if (num < 0 && base == 10)
    {
        isNegative = true;
        num = -num;
    }
 
    // Process individual digits
    while (num != 0)
    {
        int rem = num % base;
        str[i++] = (rem > 9)? (rem-10) + 'a' : rem + '0';
        num = num/base;
    }
 
    // If number is negative, append '-'
    if (isNegative)
        str[i++] = '-';
 
    str[i] = '\0'; // Append string terminator
 
    // Reverse the string
    reverse(str, i);
 
    return str;
}

extern "C" int _kernel_main(void)
{
	// nastavime ACT LED pin na vystupni
	sGPIO.Set_GPIO_Function(ACT_Pin, NGPIO_Function::Output);

	// inicializujeme UART kanal 0
	sUART0.Set_Baud_Rate(NUART_Baud_Rate::BR_115200);
	sUART0.Set_Char_Length(NUART_Char_Length::Char_8);
	// sUART0.Start(); // this was used to test with real RPi0 (because it sets gpio functions)

	// vypiseme ladici hlasku
	sUART0.Write("Welcome to KIV/OS RPiOS kernel\r\n");
	
    while (1)
    {
		burn_time(500000); // kind of useless wait, but w/e
		sUART0.Write("Cislo je: ");

		int a = 15;
		char buf[64] = {0};
		itoa(a, buf, 10);

		sUART0.Write(buf);
		sUART0.Write("\r\n");
		sUART0.Write("Zadej znak: ");
		
		char c;
		c = sUART0.Read();

		// kind of useless action, but it should verify reading correctly
		sUART0.Write(++c);
		sUART0.Write("\r\n");
    }
	
	return 0;
}
