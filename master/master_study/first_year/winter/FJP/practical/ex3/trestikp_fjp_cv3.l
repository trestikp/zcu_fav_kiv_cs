%{
	int block_cmmnt_count = 0;
	int line_comment = 0;
%}
%%
\/\*    { 
		if (line_comment == 0) block_cmmnt_count++; 
	} /* start block comment */
\*\/    { 
		if (line_comment == 0)
			if (block_cmmnt_count > 0) block_cmmnt_count--;
			else ECHO;
	} /* end block comment*/
\/\/	{ 
		if (block_cmmnt_count == 0) line_comment = 1; 
	} /* line comment (if not inside block coment) */
\12     |
\15     { /*block_cmmnt_count = 0;*/ line_comment = 0; ECHO; 
	} /* reset state at the end of line (not reseting block to allow "multiline" comment */
.       { 
		if (block_cmmnt_count == 0 && line_comment == 0) ECHO; 
	} /* print at the end of line */
%%
int main(void)
{
yylex();
return 0;
}
