%{

#include<math.h>
#include<stdio.h>
#include "calc.tab.cac"
%}

%option noyywrap

DIGIT    [0-9]

%%

{DIGIT} {return NUMBER;yylval.value = atof(yytext);}
"+" {return PLUS;yylval.value = 0;}
"-" {return MINUS;}
"/" {return DIVIDE;}
"*" {return MULTIPLY; yylval.value = 1;}
"(" {return OPENB;}
")" {return CLOSEB;}
. {};

%%

