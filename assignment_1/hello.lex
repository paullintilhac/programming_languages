%{
#include<math.h>
#include<stdio.h>
%}

%%

[0-9]+ {printf("Number = %s\n", yytext );}

%%

int main()
{
    yylex();
}



