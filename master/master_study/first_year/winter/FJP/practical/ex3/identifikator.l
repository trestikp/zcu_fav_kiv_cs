%%
[a-zA-Z_][0-9a-zA-Z_]*	printf("IDENTIFIKATOR");
%%
int main(void)
{
yylex();
return 0;
}
