%{
#include<stdio.h>

int yyerror(const char* s)
{
    printf("bison:Error parsing \n");
}
%}


 /* Specify left precedence. The symbols specified first get a lower */
 /* precedence than symbols specified later */ 
%left PLUS MINUS
%left MULTIPLY DIVIDE

 /* We only need a float value from each token */
%union
{
    float value;
};

 /* Declaring type of terminals */		
%start expression	 
%token<value> NUMBER MULTIPLY PLUS

%token STOP DIVIDE MINUS OPENB CLOSEB

 /* Declaring type of non-terminals */
%type<value> expression		

%%
expression: PLUS|MINUS|DIVIDE|MULTIPLY

NUMBER: OPENB PLUS CLOSEB|
		OPENB MINUS CLOSEB|
		OPENB DIVIDE CLOSEB|
		OPENB MULTIPLY CLOSEB {$$ = $2;}

PLUS: PLUS NUMBER {$$ = $1 + $2 }
MULTIPLY: MULTIPLY NUMBER {$$ = $1 + $2 }
MINUS: MINUS NUMBER NUMBER {$$ = $2 - $3}
DIVIDE: MINUS NUMBER NUMBER {$$ = $2 - $3}


%%
int main()
{
    yyparse();
    return 0;
}
