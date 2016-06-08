%{

#include<math.h>
#include<stdio.h>
#include "lisp.tab.c"
%}

%option noyywrap

DIGIT    [0-9]

%%

{DIGIT} {yylval.value = atof(yytext);return NUMBER;}
"+" {printf("%s\n",  yytext);yylval.value = 0;return PLUS;}
"-" {printf("%s\n",  yytext);return MINUS;}
"/" {printf("%s\n",  yytext);return DIVIDE;}
"*" {printf("%s\n",  yytext);yylval.value = 1;return MULTIPLY; }
"(" {printf("%s\n",  yytext);return OPENB;}
")" {printf("%s\n",  yytext);return CLOSEB;}
. {};

%%

