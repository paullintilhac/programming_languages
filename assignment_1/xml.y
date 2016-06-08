%{
#include <iostream>
#include <string>
#include <stdlib.h>
#include <algorithm>
#include <ctype.h>
#include <stdio.h>
#include <iomanip>
#include <fstream>
#include <sstream>
#include <iterator>
#define MAX_LEN 1024
using namespace std;
int yylex(); // A function that is to be generated and provided by flex,
             // which returns a next token when called repeatedly.
int yyerror(const char *p) { std::cerr << "error: " << p << std::endl; };
%}

%union {
    char name[MAX_LEN];;
    /* You may include additional fields as you want. */
    /* char op; */
};

%start COMPLETES

%token TEXT 
%token <name> OPENTAG CLOSETAG    /* 'val' is the (only) field declared in %union
                       which represents the type of the token. */

%%


COMPLETES : EMPTY | COMPLETE | COMPLETE COMPLETES | EMPTY COMPLETES{ std::cout << "concatenating tag" << std::endl;}

COMPLETE : OPENTAG COMPLETEBODIES CLOSETAG { 
      int size1 = sizeof($1);
      int size3 = sizeof($3);
      char temp1[size1];
      char temp3[size3];
      strcpy(temp1, $1);
      strcpy(temp3,$3);
      
      for(int i = 0; i < size1; i++){
        temp1[i] = tolower(temp1[i]);}
      for(int i = 0; i < size3; i++){
        temp3[i] = tolower(temp3[i]);}

        if (strcmp(temp1, temp3)==0)
           {std::cout << "bison matched tag: " << $1 <<"\n";}
	else {std::cout<< "bison could not find matched tag: "<< $1 << "  " << $3 << "\n"; exit(1);}
          }

EMPTY : OPENTAG CLOSETAG { 
      int size1 = sizeof($1);
      int size2 = sizeof($2);
      char temp1[size1];
      char temp2[size2];
      strcpy(temp1, $1);
      strcpy(temp2,$2);
      
      for(int i = 0; i < size1; i++){
        temp1[i] = tolower(temp1[i]);}
      for(int i = 0; i < size2; i++){
        temp2[i] = tolower(temp2[i]);}

        if (strcmp(temp1, temp2)==0)
           {std::cout << "bison matched tag: " << $1 <<"\n";}
  else {std::cout<< "bison could not find matched tag: "<< $1 << "  " << $2 << "\n"; exit(1);}
          }

COMPLETEBODIES : COMPLETEBODY | COMPLETEBODY COMPLETEBODIES | "" {std::cout << "made COMPLETEBODIES" <<std::endl;}

COMPLETEBODY : TEXT | COMPLETE{std::cout << "made COMPLETEBODY" << std::endl;}


%%

int main()
{
    yyparse(); // A parsing function that will be generated by 
    return 0;
}
