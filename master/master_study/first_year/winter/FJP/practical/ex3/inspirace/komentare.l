%{
	int pocet_komentaru = 0;
	int radkovy_komentar = 0;
%}
%%
\/\*    { if (radkovy_komentar == 0) {pocet_komentaru++;} }
\*\/    { if (radkovy_komentar == 0) {if (pocet_komentaru > 0) {pocet_komentaru--;} else { ECHO; } } }
\/\/	{ if (pocet_komentaru == 0) {radkovy_komentar = 1;} }
\12		{ radkovy_komentar = 0; ECHO; }
.  		{ if (pocet_komentaru == 0 && radkovy_komentar == 0) ECHO; }
%%
int main(void)
{
yylex();
return 0;
}
