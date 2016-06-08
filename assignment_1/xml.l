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

"<"({digit}|{letter})("/"|":"|" "|"."|"\""|"="|{digit}|{letter})+">"   {std::string string1 = string(yytext); std::string tempString = string1.substr(1, std::min(string1.find(">"),string1.find(" "))-1);printf("flex opentag token:  *%s*\n", tempString.c_str()); strcpy(yylval.name,tempString.c_str()); return OPENTAG;}

"</"({digit}|{letter})(":"|" "|"."|"\""|"="|{digit}|{letter})+">" { std::string string1 = string(yytext); std::string tempString = string1.substr(2, std::min(string1.find(">"),string1.find(" "))-2);printf("flex closetag token: = *%s*\n", tempString.c_str()); strcpy(yylval.name,tempString.c_str()); return CLOSETAG;}

(":"|" "|"."|"\""|"="|{digit}|{letter})+ {printf("flex body token: %s\n", string(yytext));return TEXT;}

[\t\r\n]+              { /* Ignore white characters. */ }


.                       {printf("Invalid token\n"); exit(1);  }
%%