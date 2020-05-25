%{
    #include <stdlib.h>
    #include "def.h"
    Value lexval;
    int line = 1;
%}
%option noyywrap

spacing     ([ \t])+
letter      [A-Za-z]
digit       [0-9]
intconst    {digit}+
realconst   {intconst}\.{intconst}
strconst    \"([^\"])*\"
boolconst   false|true
id          {letter}({letter}|{digit})*
sugar       [(){};,]
%%
{spacing}   ;
\n          {line++;}
func        {return(FUNC);}
body        {return(T_BODY);}
end         {return(END);}
if          {return(IF);}
then        {return(THEN);}
else        {return(ELSE);}
while       {return(WHILE);}
do          {return(DO);}
for         {return(FOR);}
to          {return(TO);}
break       {return(BREAK);}
return      {return(RETURN);}
write       {lexval.ival = WRITE; return(WRITE);}
writeln     {lexval.ival = WRITELN; return(WRITELN);}
read        {return(READ);}
and         {lexval.ival = AND; return(LOGIC_OP);}
or          {lexval.ival = OR; return(LOGIC_OP);}
not         {lexval.ival = NOT; return(UNARY_OP);}
"<"         {lexval.ival = LT; return(REL_OP);}
"<="        {lexval.ival = LE; return(REL_OP);}
">"         {lexval.ival = GT; return(REL_OP);}
">="        {lexval.ival = GE; return(REL_OP);}
"=="        {lexval.ival = EQ; return(REL_OP);}
"!="        {lexval.ival = NE; return(REL_OP);}
"+"         {lexval.ival = PLUS; return(LOW_PREC_OP);}
"-"         {lexval.ival = MINUS; return(LOW_PREC_OP);}
"*"         {lexval.ival = MUL; return(HIGH_PREC_OP);}
"/"         {lexval.ival = DIV; return(HIGH_PREC_OP);}
":"         {return(DECL);}
void        {return(VOID);}
integer     {return(INTEGER);}
string      {return(STRING);}
boolean     {return(BOOLEAN);}
real        {return(REAL);}
{realconst} {lexval.fval = atof(yytext); return(REALCONST);}
{intconst}  {lexval.ival = atoi(yytext); return(INTCONST);}
{strconst}  {lexval.sval = newstring(yytext); return(STRCONST);}
{boolconst} {
               lexval.bval = (yytext[0] == 'f' ? FALSE : TRUE);
               return(BOOLCONST);
            }
{id}        {lexval.sval = newstring(yytext); return(ID);}
{sugar}     {return(yytext[0]);}
"="        {return(ASSIGN);}
.          {ECHO; return(ERROR);}
%%
char *newstring(char *s)
{
  char *p;
  
  p = malloc(strlen(s)+1);
  strcpy(p, s);
  return(p);
}

void main() {
  yylex();
}