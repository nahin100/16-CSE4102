%{
#include <stdio.h>
void yyerror(char *s);
int yylex();
%}

%token NUM ADD SUB ID ASSIGN SEMI IF LB RB LP RP EQUAL
%start program
%left ADD SUB

%%
program: statements
    ;

statements: IF LP exp RP LB id_declare id_declare RB
    ;

id_declare: ID ASSIGN exp SEMI
    ;

exp: exp ADD number
    |exp SUB number
    |exp EQUAL number
    |number
    |ID
    ;

number: NUM 
        | SUB NUM
        ;
%%

int main()
{
    yyparse();
    printf("Parsing Finished\n");
}

void yyerror(char *s)
{
    fprintf(stderr, "error: %s", s);
}
