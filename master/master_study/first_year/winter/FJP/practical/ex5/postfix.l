%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"

#define YYSTYPE	int
extern YYSTYPE yylval;
%}
%%
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }
[ \t]+	;
\n	return ENTER;
.	return (int) yytext[0];
%%
