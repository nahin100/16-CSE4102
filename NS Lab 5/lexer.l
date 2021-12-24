%option noyywrap

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	// #ifndef MY_HEADER_SYMTAB_C
    // 	#define MY_HEADER_SYMTAB_C
    // 	#include "symtab.c"
	// #endif
	#include "parser.tab.h"
	extern FILE *yyin;
	extern FILE *yyout;
	
	int lineno = 1; // initialize to 1
	void ret_print(char *token_type);
	void yyerror();
%}

alpha     [a-zA-Z]
digit     [0-9]
alnum     {alpha}|{digit}
print     [ -~]

ID        {alpha}+{alnum}*
ICONST    "0"|[0-9]{digit}*

%%

"//".*        { printf("Comment at line %d\n", lineno); } 

"int"       { return INT; }

"if"        { return IF; }
"else"      { return ELSE; }

"while"     { return WHILE; }
"continue"  { return CONTINUE; }
"break"     { return BREAK; }

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
"print"   { return PRINT; }
"scan"   { return SCAN; }

{ID}    {
		// yylval.id = (list_t*)malloc(sizeof(list_t));
		strcpy(yylval.str_val, yytext); return ID;

        //strcpy(yylval.id->st_name, yytext);
        }
{ICONST}    { yylval.int_val   = atoi(yytext); return ICONST; }

"\n"        { lineno += 1; }
[ \t\r\f]+  

.       { yyerror("Unrecognized character"); }

%%
