%{
#include <iostream>
#include <stdlib.h>
#include <string>
#include <algorithm>
#include "xml.tab.c"

using std::string;
  /* We want the tokens defined in xml.y*/
%}

%option noyywrap
letter  [A-Za-z]
digit   [0-9]
%%

"<"({digit}|{letter})("/"|":"|" "|"."|"\""|"="|{digit}|{letter})+">"   {std::string string1 = string(yytext); std::string tempString = string1.substr(1, std::min(string1.find(">"),string1.find(" "))-1); strcpy(yylval.name,tempString.c_str()); return OPENTAG;}

"</"({digit}|{letter})(":"|" "|"."|"\""|"="|{digit}|{letter})+">" { std::string string1 = string(yytext); std::string tempString = string1.substr(2, std::min(string1.find(">"),string1.find(" "))-2); strcpy(yylval.name,tempString.c_str()); return CLOSETAG;}

(":"|" "|"."|"\""|"="|{digit}|{letter})+ {return TEXT;}

[\t\r\n]+              { /* Ignore white characters. */ }


.                       {printf("Invalid\n"); exit(1);  }
%%