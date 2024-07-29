#include <stdstring.h>

namespace
{
    const char CharConvArr[] = "0123456789ABCDEF";
}

// reverse string (orignaly from ftoa implementation) - https://www.geeksforgeeks.org/convert-floating-point-number-string/

// Reverses a string 'str' of length 'len'
void reverse(char* str, int len)
{
	int i = 0, j = len - 1, temp;
	while (i < j) {
		temp = str[i];
		str[i] = str[j];
		str[j] = temp;
		i++;
		j--;
	}
}

// ftoa implementation (new) - https://github.com/antongus/stm32tpl/blob/master/ftoa.c

#define MAX_PRECISION	(10)
static const double rounders[MAX_PRECISION + 1] =
{
	0.5,				// 0
	0.05,				// 1
	0.005,				// 2
	0.0005,				// 3
	0.00005,			// 4
	0.000005,			// 5
	0.0000005,			// 6
	0.00000005,			// 7
	0.000000005,		// 8
	0.0000000005,		// 9
	0.00000000005		// 10
};

char * ftoa(double f, char * buf, int precision)
{
	char * ptr = buf;
	char * p = ptr;
	char * p1;
	char c;
	long intPart;

	// check precision bounds
	if (precision > MAX_PRECISION)
		precision = MAX_PRECISION;

	// sign stuff
	if (f < 0)
	{
		f = -f;
		*ptr++ = '-';
	}

	if (precision < 0)  // negative precision == automatic precision guess
	{
		if (f < 1.0) precision = 6;
		else if (f < 10.0) precision = 5;
		else if (f < 100.0) precision = 4;
		else if (f < 1000.0) precision = 3;
		else if (f < 10000.0) precision = 2;
		else if (f < 100000.0) precision = 1;
		else precision = 0;
	}

	// round value according the precision
	if (precision)
		f += rounders[precision];

	// integer part...
	intPart = f;
	f -= intPart;

	if (!intPart)
		*ptr++ = '0';
	else
	{
		// save start pointer
		p = ptr;

		// convert (reverse order)
		while (intPart)
		{
			*p++ = '0' + intPart % 10;
			intPart /= 10;
		}

		// save end pos
		p1 = p;

		// reverse result
		while (p > ptr)
		{
			c = *--p;
			*p = *ptr;
			*ptr++ = c;
		}

		// restore end pos
		ptr = p1;
	}

	// decimal part
	if (precision)
	{
		// place decimal point
		*ptr++ = '.';

		// convert
		while (precision--)
		{
			f *= 10.0;
			c = f;
			*ptr++ = '0' + c;
			f -= c;
		}
	}

	// terminating zero
	*ptr = 0;

	return buf;
}

// end of ftoa implementation

// atof implementation - https://github.com/GaloisInc/minlibc/blob/master/atof.c

#define isdigit(c) (c >= '0' && c <= '9')

double atof(const char *s, bool& is_float)
{
	// This function stolen from either Rolf Neugebauer or Andrew Tolmach. 
	// Probably Rolf.
	double a = 0.0;
	int e = 0;
	int c;
	is_float = true;

	while ((c = *s++) != '\0' && isdigit(c)) 
	{
		a = a * 10.0 + (c - '0');
	}

	if (c == '.') 
	{
		while ((c = *s++) != '\0' && isdigit(c)) 
		{
			a = a * 10.0 + (c - '0');
			e = e - 1;
		}
	}
	else
	{
		// caught non-digit char and if it isn't 0, then its error
		if (c != '\0')
		{
			is_float = false;
			return a;
		}
	}

	if (c == 'e' || c == 'E') 
	{
		int sign = 1;
		int i = 0;
	
		c = *s++;
		if (c == '+')
			c = *s++;
		else if (c == '-') 
		{
			c = *s++;
			sign = -1;
		}

		while (isdigit(c))
		{
			i = i * 10 + (c - '0');
			c = *s++;
		}

		// char in scientific notation - only digits allowed here
		if (c != '\0')
		{
			is_float = false;
			return a;
		}

		e += i * sign;
	}
	else
	{
		// caught non-digit char and if it isn't 0, then its error
		if (c != '\0')
		{
			is_float = false;
			return a;
		}
	}

	while (e > 0) 
	{
		a *= 10.0;
		e--;
	}

	while (e < 0) 
	{
		a *= 0.1;
		e++;
	}

	// everything is zero, the input was empty
	if (a == 0.0 && e == 0 && c == '\0')
		is_float = false;

	return a;
}

// end of atof

// Implementation of itoa() - https://www.geeksforgeeks.org/implement-itoa/
void itoa(int num, char* str, unsigned int base)
{
	int i = 0;
	bool isNegative = false;

	/* Handle 0 explicitly, otherwise empty string is printed for 0 */
	if (num == 0)
	{
		str[i++] = '0';
		str[i] = '\0';
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
}

int atoi(const char* input)
{
	int output = 0;

	while (*input != '\0')
	{
		output *= 10;
		if (*input > '9' || *input < '0')
			break;

		output += *input - '0';

		input++;
	}

	return output;
}

char* strncpy(char* dest, const char *src, int num)
{
	int i;

	for (i = 0; i < num && src[i] != '\0'; i++)
		dest[i] = src[i];
	for (; i < num; i++)
		dest[i] = '\0';

   return dest;
}

int strncmp(const char *s1, const char *s2, int num)
{
	unsigned char u1, u2;
  	while (num-- > 0)
    {
      	u1 = (unsigned char) *s1++;
     	u2 = (unsigned char) *s2++;
      	if (u1 != u2)
        	return u1 - u2;
      	if (u1 == '\0')
        	return 0;
    }

  	return 0;
}

char* strnput(char* dest, const char* src,  int n)
{
	char *ret = dest;

    while(n-- || (*src) != '\0')
    {
        *dest++ = *src++;
    }

    if(*dest != '\0')
    {
        *dest = '\0';
    }

    return ret;
}

char* strncat(char* dest, const char* src,  int n)
{
    char *ret = dest;
    while(*dest != '\0')
    {
        *dest++;
    }

    while(n-- || (*src) != '\0')
    {
        *dest++ = *src++;
    }

    if(*dest != '\0')
    {
        *dest = '\0';
    }

    return ret;
}

int strlen(const char* s)
{
	int i = 0;

	while (s[i] != '\0')
		i++;

	return i;
}

void bzero(void* memory, int length)
{
	char* mem = reinterpret_cast<char*>(memory);

	for (int i = 0; i < length; i++)
		mem[i] = 0;
}

void memcpy(const void* src, void* dst, int num)
{
	const char* memsrc = reinterpret_cast<const char*>(src);
	char* memdst = reinterpret_cast<char*>(dst);

	for (int i = 0; i < num; i++)
		memdst[i] = memsrc[i];
}
