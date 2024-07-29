%%
^([+-]?([0-9]*)?)\.[0-9]+$	printf("float - %s\n", yytext);
^([+-]?([0-9]*)?)\.[0-9]+[eE][+-]?[0-9]*$	printf("exp - %s\n", yytext);
^([+-]?[1-9])[0-9]*$		printf("int - %s\n", yytext);
.*				printf("nezname\n");
%%
int main()
{
yylex();
return 0;
}
