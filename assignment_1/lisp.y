%{
#include<stdio.h>
int yylex(); // A function that is to be generated and provided by flex,

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
%token<value> NUMBER MULTIPLY PLUS

%token STOP DIVIDE MINUS OPENB CLOSEB

 /* Declaring type of non-terminals */
%type<value> RESULT TERM PLUS_NUMBER PLUS_TERM MULTIPLY_NUMBER MULTIPLY_TERM DIVIDE_TERM MINUS_TERM	

%%

RESULT: OPENB PLUS_TERM CLOSEB {$$ = $2; printf("result: %f\n",$2);}|
		OPENB MINUS_TERM CLOSEB {$$ = $2;}|
		OPENB DIVIDE_TERM CLOSEB {$$ = $2;}|
		OPENB MULTIPLY_TERM CLOSEB {$$ = $2;}

TERM: NUMBER | RESULT

PLUS_NUMBER: PLUS_TERM TERM {$$ = $1 + $2; printf("result: %f\n",$$);}

PLUS_TERM: PLUS | PLUS_NUMBER 

MULTIPLY_NUMBER: MULTIPLY_TERM TERM {$$ = $1 * $2;} 

MULTIPLY_TERM: MULTIPLY | MULTIPLY_NUMBER

MINUS_TERM: MINUS TERM TERM {$$ = $2 - $3;}

DIVIDE_TERM: DIVIDE TERM TERM {$$ = $2 / $3;}


%%
int main()
{
    yyparse();
    return 0;
}
