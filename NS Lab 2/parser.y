%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror();
    #include "symtab.c"
	extern int lineno;
	extern int yylex();
%}

%union
{
    char str_val[100];
    int int_val;
}

%token INT IF ELSE WHILE CONTINUE BREAK PRINT DOUBLE CHAR
%token ADDOP SUBOP MULOP DIVOP EQUOP LT GT
%token LPAREN RPAREN LBRACE RBRACE SEMI ASSIGN
%token<str_val> ID
%token<str_val> ICONST
%token<str_val> FCONST
%token<str_val> CCONST

%type<int_val> type constant exp statement

%left ADDOP SUBOP
%left MULOP DIVOP
%left LT GT
%left EQUOP
%right ASSIGN

%start code

%%
code: statements;

statements: statements statement | ;

statement:    declaration
            | if_statement
            | ID ASSIGN exp SEMI
            {
                printf("ID ASSIGN exp SEMI\n");
                if(id_check($1)==-1)
                {
                    printf("%s is not declared\n", $1);
                    yyerror();
                }

                printf("%d + %d\n",get_type($1), $3);

                if(type_check(get_type($1), $3)==-1)
                    yyerror();
            }
            ;

declaration: type ID SEMI
            {
                insert($2, $1);
            }
            |type ID ASSIGN exp SEMI
            ;

type: INT {$$=INT_TYPE;} 
    | DOUBLE {$$=REAL_TYPE;}
    | CHAR {$$=CHAR_TYPE;};

exp: ID
    |constant
    |exp ADDOP exp
    {
        printf("%d + %d\n", $1, $3);

        if(type_check($1, $3)==-1)
            yyerror();
        else 
            $$ = type_check($1, $3);
    }
    |exp SUBOP exp
    |exp MULOP exp
    |exp DIVOP exp
    |exp GT exp
    |exp LT exp
    |LPAREN exp RPAREN
    ;

constant: ICONST {$$=INT_TYPE;} 
        | FCONST {$$=REAL_TYPE;}
        | CCONST {$$=CHAR_TYPE;}
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
	return 0;
}
