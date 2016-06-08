%{

#include<math.h>
#include<stdio.h>
#include "lisp.tab.c"
%}

%option noyywrap

DIGIT    [0-9]

%%

{DIGIT}+ { yylval.value = atoi(yytext);return NUMBER;}
"+" {yylval.value = 0;return PLUS;}
"-" {return MINUS;}
"/" {return DIVIDE;}
"*" {yylval.value = 1;return MULTIPLY; }
"(" {return OPENB;}
")" {return CLOSEB;}

. {};

%%

