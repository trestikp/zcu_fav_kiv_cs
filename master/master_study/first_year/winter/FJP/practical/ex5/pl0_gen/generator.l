%{
#include <stdlib.h>
#include <stdio.h>
#include "generator.tab.h"

#define YYSTYPE	int
extern YYSTYPE yylval;
%}
%%
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }
r[0-9]	{ yylval = atoi(yytext + 1); return IDENT; }
:= 		{ return ASSIGN; }
;		{ return SEMICOLON; }
if		{ return IF; }
fi      { return FI; }
then	{ return THEN; }
=		{ return O_EQ; }
\<>		{ return O_NE; }
>		{ return O_GT; }
>=		{ return O_GE; }
\<		{ return O_LT; }
\<=		{ return O_LE; }
\. 		{ return DOT; }
[aA][nN][dD]    { return O_AND; }
[oO][rR]        { return O_OR;  }
[nN][oO][tT]    { return O_NOT; }
[ \t\n]+	;
.	    { return (int) yytext[0]; }
%%
