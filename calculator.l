%option noyywrap

%{
    #include <stdio.h>
    #include <math.h>
    #include <string.h>
    #include "calculator.tab.h"
%}

end_line "\n"
white_space [ \t]+
digit [0-9]
integer {digit}+
sqrt "sqrt"
log "log"
plus "+"
minus "-"
division "/"
multiply "*"
equal "="
left_p "("
right_p ")"
variable [a-z]+

%%

{integer}   {yylval.val = atoi(yytext); return INT;}
{sqrt}      {return SQRT;}
{log}       {return LOG;}
{plus}      {return PLUS;}
{minus}     {return MINUS;}
{division}  {return DIVISION;}
{multiply}  {return MULTIPLY;}
{equal}     {return EQUAL;}
{left_p}    {return LEFT_P;}
{right_p}   {return RIGHT_P;}
{variable}  {strcpy(yylval.var, yytext);return VARIABLE;}
{end_line}  {return ENDL;}
{white_space} {}

%%