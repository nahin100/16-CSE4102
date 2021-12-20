%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror();
    #include "symtab.c"
    #include "codeGen.h"
	extern int lineno;
	extern int yylex();



%}

%union
{
    char str_val[100];
    int int_val;
    double double_val;
    // temp_t* temp_val;
}

%token INT IF ELSE WHILE CONTINUE BREAK PRINT DOUBLE CHAR
%token ADDOP SUBOP MULOP DIVOP EQUOP LT GT
%token LPAREN RPAREN LBRACE RBRACE SEMI ASSIGN
%token<str_val> ID
%token<int_val> ICONST
%token<double_val> FCONST
%token<str_val> CCONST

%type<int_val> type statement
%type<int_val> constant exp

%left ADDOP SUBOP
%left MULOP DIVOP
%left LT GT
%left EQUOP
%right ASSIGN

%start program

%%
program: {gen_code(START, -1);} code {gen_code(HALT, -1);};

code: statements;

statements: statements statement | ;

statement:    declaration
            | if_statement
            | ID ASSIGN exp SEMI
            {
                // // printf("ID ASSIGN exp SEMI\n");
                // if(id_check($1)==-1)
                // {
                //     printf("%s is not declared\n", $1);
                //     yyerror();
                // }

                // // printf("%d + %d\n",get_type($1), $3);

                // if(type_check(get_type($1), $3)==-1)
                //     yyerror();
            }
            ;

declaration: type ID SEMI
            {
                insert($2, $1);
            }
            |type ID ASSIGN constant SEMI
            {
                insert($2, $1);
                gen_code(LD_INT_VALUE, $4);
                int address = id_check($2);
                gen_code(ST, address);
            }
            |type ID ASSIGN exp SEMI
            {
                insert($2, $1);
                int address = id_check($2);
                gen_code(STS, address);
            }
            ;

type: INT {$$=INT_TYPE;} 
    | DOUBLE {$$=REAL_TYPE;}
    | CHAR {$$=CHAR_TYPE;};

exp: ID
    {
        int address = id_check($1);

        if (address!=-1)
            gen_code(LD_VAR, address);
        else
        {
            printf("%s is not declared\n", $1);
            yyerror();
        }

        $$=-1;        
    }
    |constant
    {
        gen_code(LD_INT, $1);
    }
    |exp ADDOP exp
    {
        // printf("%d + %d\n", $1, $3);

        // if(type_check($1, $3)==-1)
        //     yyerror();
        // else 
        //     $$ = type_check($1, $3);
        gen_code(ADD, -1);

    }
    |exp SUBOP exp
    |exp MULOP exp
    |exp DIVOP exp
    |exp GT exp
    |exp LT exp
    |LPAREN exp RPAREN
    ;

constant: ICONST {$$ = $1;} 
        | FCONST {$$ = REAL_TYPE;}
        | CCONST {$$ = CHAR_TYPE;}
        ;

if_statement: IF LPAREN exp RPAREN tail else_statement;

else_statement: ELSE tail | ;

tail: LBRACE statements RBRACE;

%%

void yyerror ()
{
	printf("Syntax error at line %d\n", lineno);
	exit(1);
}

int main (int argc, char *argv[])
{
	yyparse();
	printf("Parsing finished!\n");

    printf("\n\n================STACK MACHINE INSTRUCTIONS================\n");
    print_code();
	return 0;
}
