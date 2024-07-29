%{
	int number = 0;
%}
%%
^[+-]?[0-9]+$	/* match natural number */ {
	number = atoi(yytext);
	printf("result: %d\n", number % 7 == 0 ? number + 3 : number);
}
.*	printf("ERR - NaN!\n");
%%
int main(void)
{
yylex();
return 0;
}
