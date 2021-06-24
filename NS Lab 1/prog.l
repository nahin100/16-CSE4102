%option noyywrap

%{
    #include "prog.tab.h"
%}

delim [ \t\n]
ws {delim}+
digit [0-9]
number ({digit}+)
letter [A-Za-z]
us [_]
id ({us}|{letter})({letter}|{us}|{digit})*

%%
{ws} {}
{number} {yylval = atoi(yytext); return(NUM);}

"if" {return(IF);}

{id} {return(ID);}

"==" {return(EQUAL);}
"=" {return(ASSIGN);}
";" {return(SEMI);}

"+" {return(ADD);}
"-" {return(SUB);}

"(" {return(LP);}
")" {return(RP);}

"{" {return(LB);}
"}" {return(RB);}
%%

