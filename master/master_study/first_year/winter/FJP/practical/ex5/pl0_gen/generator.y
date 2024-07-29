%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#define YYSTYPE int

typedef enum {
	LIT, // stores constant to stack
	OPR, // do operation
	LOD, // saves value from adress to stack
	STO, // writes value from stack to adress
	CAL, // call procedure
	INT, // increase top register by value
	JMP, // jump
	JMC, // jump if top of stack value is 0
	RET  // return from procedure
} i_set;

const char* i_set_string[] = {
	"LIT",
	"OPR",
	"LOD",
	"STO",
	"CAL",
	"INT",
	"JMP",
	"JMC",
	"RET",
};

typedef struct {
	const char* inst;
	int param1;
	int param2;
} instruction;

typedef enum {
	COND_EQ = 8,
	COND_NE = 9,
	COND_LT = 10,
	COND_GE = 11,
	COND_GT = 12,
	COND_LE = 13
} conditions;

typedef enum {
	OP_ADD = 2,
	OP_SUB = 3,
	OP_MUL = 4,
	OP_DIV = 5
} operations;

#define IDENT_TABLE_BASE 3

instruction* inst_buffer[2048] = {0};
uint16_t inst_pointer = 0;
uint16_t if_start_pointer = 0;

int add_instruction(i_set inst, int param1, int param2);
void print_inst_buffer();
void free_inst_buffer();

%}
%token NUMBER ASSIGN SEMICOLON IDENT DOT
%token IF FI THEN
%token O_AND O_OR O_NOT
%token O_EQ O_NE O_LT O_GE O_GT O_LE
%left '+' '-'
%left '*' '/'
%left UMINUS
%%
session: 
		program DOT 					{ add_instruction(RET, 0, 0); YYACCEPT; /* accept to end the parsing */ }
		;
program:
		program command
		|
		;
command:
		/* expression -- cannot keep just expresion, it breaks */
		assignment SEMICOLON
		| branchoff
		;
assignment:
		IDENT ASSIGN expression 		{ add_instruction(STO, 0, IDENT_TABLE_BASE + $1); }
		;
branchoff:
		IF condition 					{ if_start_pointer = inst_pointer; add_instruction(JMC, 0, 0);  }
		THEN program
		FI								{ inst_buffer[if_start_pointer]->param2 = inst_pointer; }
		;
condition:
		  expression O_EQ expression	{ add_instruction(OPR, 0, COND_EQ); }
		| expression O_NE expression	{ add_instruction(OPR, 0, COND_NE); }
		| expression O_LT expression	{ add_instruction(OPR, 0, COND_LT); }
		| expression O_GE expression	{ add_instruction(OPR, 0, COND_GE); }
		| expression O_GT expression	{ add_instruction(OPR, 0, COND_GT); }
		| expression O_LE expression	{ add_instruction(OPR, 0, COND_LE); }
		| '(' condition ')'          	{ $$ = $2; }
		| condition O_AND condition		{ add_instruction(OPR, 0, OP_ADD);  add_instruction(LIT, 0, 2); add_instruction(OPR, 0, COND_EQ); }
		| condition O_OR condition		{ add_instruction(OPR, 0, OP_ADD);  add_instruction(LIT, 0, 1); add_instruction(OPR, 0, COND_GE); }
		| O_NOT condition				{ add_instruction(LIT, 0, 1); 		add_instruction(OPR, 0, COND_LT); }
		;
expression:  	
		  NUMBER 						{ add_instruction(LIT, 0, $1); }
		| IDENT							{ add_instruction(LOD, 0, IDENT_TABLE_BASE + $1); }
		| expression '+' expression   	{ add_instruction(OPR, 0, OP_ADD); }
		| expression '-' expression   	{ add_instruction(OPR, 0, OP_SUB); }
		| expression '*' expression   	{ add_instruction(OPR, 0, OP_MUL); }
		| expression '/' expression   	{ add_instruction(OPR, 0, OP_DIV); }
		| '(' expression ')'          	{ $$ = $2; }
		| '-' expression %prec UMINUS 	{ add_instruction(LIT, 0, $1); }
		;
%%
int main(int argc, char **argv)
{
  printf("Welcome to PL/0 instruction generator. There is 10 available variables: r0-r9. Values can be assigned."
  		 " Values can be compared and boolean operations can be applied between conditions (AND, OR, NOT)."
		 " Comparing values is done"
		 " through \"if\" - \"then\" - \"fi\" statement. Watch out, that if must be end with fi! Semicolons are"
		 " required after assignment.\n");
  add_instruction(INT, 0, 13);
  int ret = yyparse();
  if (ret == 0) print_inst_buffer();
  free_inst_buffer();
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


int add_instruction(i_set inst, int param1, int param2) {
	instruction* i = calloc(1, sizeof(instruction));
	if (!i) {
		printf("fatal error: cannot allocate memory for instruction\n");
		exit(1);
	}

	i->inst   = i_set_string[inst];
	i->param1 = param1;
	i->param2 = param2;

	inst_buffer[inst_pointer] = i;
	inst_pointer++;

	return 0;
}

void print_inst_buffer() {
	int i = 0;
	for (i = 0; i < inst_pointer; i++) {
		printf("%d %s %d %d\n", i, inst_buffer[i]->inst, inst_buffer[i]->param1, inst_buffer[i]->param2);
	}
}

void free_inst_buffer() {
	int i = 0;
	for (i = 0; i < inst_pointer; i++) {
		free(inst_buffer[i]);
	}
}
