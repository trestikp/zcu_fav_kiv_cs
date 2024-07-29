#pragma once

#define FLOAT_MAX_PRECISION 6

// void itoa(unsigned int input, char* output, unsigned int base);
void itoa(int num, char* str, unsigned int base);
int atoi(const char* input);
char * ftoa(double f, char * buf, int precision);
double atof(const char* s, bool& is_float); // modified for error detection
char* strncpy(char* dest, const char *src, int num);
int strncmp(const char *s1, const char *s2, int num);
char* strnput(char* dest, const char* src,  int n); // this isnt standard linux function. Puts at most n char from src to dest overwriting dest.
char* strncat(char* dest, const char* src,  int n);
int strlen(const char* s);
void bzero(void* memory, int length);
void memcpy(const void* src, void* dst, int num);