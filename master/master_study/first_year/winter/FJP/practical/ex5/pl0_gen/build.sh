#!/bin/bash

#clean 
rm generator.tab.* lex.yy.c

flex generator.l
bison -d -Wcounterexamples -Wconflicts-sr generator.y
gcc -o generator lex.yy.c generator.tab.c

# clean 
rm generator.tab.* lex.yy.c
