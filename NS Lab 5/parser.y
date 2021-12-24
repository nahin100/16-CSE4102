%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	#ifndef MY_HEADER_SYMTAB_C
		#define MY_HEADER_SYMTAB_C
		#include "symtab.c"
	#endif
	
	#include "codeGen.h"

	extern FILE *yyin;
	extern FILE *yyout;

	extern int lineno;
	extern int yylex();
	void yyerror();
%}

/* YYSTYPE union */
%union{
	int int_val;
	char str_val[100];

	// list_t* id;
}

%token<int_val> INT IF ELSE WHILE CONTINUE BREAK PRINT SCAN
%token<int_val> ADDOP SUBOP MULOP DIVOP EQUOP LT GT
%token<int_val> LPAREN RPAREN LBRACE RBRACE SEMI ASSIGN
%token <str_val> ID
%token <int_val> ICONST

%left ADDOP SUBOP
%left MULOP DIVOP
%left LT GT
%left EQUOP
%right ASSIGN

%start program

%%
program: {gen_code(START, -1);} code {gen_code(HALT, -1);} ;

code: statements;

statements: statements statement |  
			;

statement:  	declaration
			|	assigment  
			;

declaration:	INT ID SEMI
				{
					insert($2, $1);
				}
				| INT ID ASSIGN ICONST SEMI
				{
					insert($2, $1);
					gen_code(LD_INT_VALUE, $4);
					int address = id_check($2);
					gen_code(ST, address);
				}
				| INT ID ASSIGN exp SEMI
				{
					insert($2, $1);
					int address = id_check($2);
					gen_code(STS, address);
				}
				;

assigment: ID ASSIGN exp SEMI
		   {
			   int address = id_check($1);
			  
			  if(address!=-1)
				  gen_code(ST, address);
			  else 
			  {
				printf("Problem\n");
			  	exit(1);
			  }
		   }
		   | PRINT LPAREN ID RPAREN SEMI
			{
				int address = id_check($3);
				printf("%d\n", address);
				
				if(address!=-1)
					gen_code(WRITE_INT, address);
				else
				{
					printf("Problem\n");
					exit(1);
				}
			}
			| SCAN LPAREN ID RPAREN SEMI
			{
				int address = id_check($3);
				printf("%d\n", address);
				
				if(address!=-1)
					gen_code(SCAN_INT, address);
				else
				{
					printf("Problem\n");
					exit(1);
				}
			}
		   ;

exp:  ID  
	  {
		  int address = id_check($1);
			  
			  if(address!=-1)
				  gen_code(LD_VAR, address);
			  else 
			  {
				printf("Problem\n");
			  	exit(1);
			  }
	  }
	| ICONST { gen_code(LD_INT, $1); }			  
	| exp ADDOP exp { gen_code(ADD, -1); } 		  
	| exp SUBOP exp 		  
	| exp MULOP exp 		  
	| exp DIVOP exp 		  
	| exp EQUOP exp 		  
	| exp GT exp 		  	  
	| exp LT exp 	  
	| LPAREN exp RPAREN
	;


%%

void yyerror ()
{
  fprintf(stderr, "Syntax error at line %d\n", lineno);
  exit(1);
}

int main (int argc, char *argv[])
{
	int flag;
	flag = yyparse();
	
	printf("Parsing finished!\n");	

	printf("\n\n================STACK MACHINE INSTRUCTIONS================\n");
	print_code();

	printf("\n\n================x86 Assembly================\n");
	print_assembly();

	return flag;
}
