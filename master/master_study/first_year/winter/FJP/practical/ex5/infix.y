%{
 #include <stdio.h>
 #include <stdlib.h>
 #define YYSTYPE int
%}
%token NUMBER ENTER
%left '+' '-'
%left '*' '/'
%left UMINUS
%%
session:	/* empty */
		| session line
		;
line:		expression ENTER { printf("---- %d\n", $1); }
		;
expression:	NUMBER { $$ = $1; }
		| expression '+' expression   { $$ = $1 + $3; }
		| expression '-' expression   { $$ = $1 - $3; }
		| expression '*' expression   { $$ = $1 * $3; }
		| expression '/' expression   { $$ = $1 / $3; }
		| '(' expression ')'          { $$ = $2; }
		| '-' expression %prec UMINUS { $$ = -$2; }
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

