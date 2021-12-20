%option noyywrap

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "parser.tab.h"
    #include "symtab.h"
	
	int lineno = 1; // initialize to 1
	void yyerror();
%}

alpha     [a-zA-Z]
digit     [0-9]
alnum     {alpha}|{digit}
print     [ -~]

ID        {alpha}{alnum}*
ICONST    [0-9]{digit}*
FCONST    {digit}*"."{digit}+
CCONST    (\'{print}\')
%%

"//".*        { } 

"int"       { return INT; }
"double"    { return DOUBLE; }
"char"		{ return CHAR; }

"if"		{return IF;}
"else"		{return ELSE;}

"+"       { return ADDOP; }
"-"       { return SUBOP; }
"*"       { return MULOP; }
"/"       { return DIVOP; }
"=="      { return EQUOP; }
">"       { return GT; }
"<"       { return LT; }

"("       { return LPAREN; }
")"       { return RPAREN; }
"{"       { return LBRACE; }
"}"       { return RBRACE; }
";"       { return SEMI; }
"="       { return ASSIGN; }

{ID}        {strcpy(yylval.str_val, yytext); return ID;}
{ICONST}    {yylval.int_val = atoi(yytext); return ICONST;}
{FCONST}    {yylval.double_val = atof(yytext); return FCONST;}
{CCONST}    {strcpy(yylval.str_val, yytext); return CCONST;}

"\n"        { lineno += 1; }
[ \t\r\f]+  

.       { yyerror("Unrecognized character"); }
