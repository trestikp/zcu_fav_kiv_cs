%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE	int
%}
%token NUMBER ENTER
%%
session:	/* empty */
		| session line
		;
line:		expression ENTER { printf("---- %d\n", $1); }
		;
expression:	NUMBER { $$ = $1; }
		| expression expression '+' { $$ = $1 + $2; }
		| expression expression '-' { $$ = $1 - $2; }
		| expression expression '*' { $$ = $1 * $2; }
		| expression expression '/' { $$ = $1 / $2; }
		;
%%
int main(int argc, char **argv)
{
  yyparse();
  return 0;
}

int yyerror(char *s)
{
  printf("error: %s\n", s);
}

int yywrap(void)
{
  return 1;
}
