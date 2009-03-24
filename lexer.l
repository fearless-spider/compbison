%{
  #include "global.h";
  int install_num(void);
  int install_id(void);
  int lineno = 1;
  int tokenval = NONE;
  int p;
%}
delim [ \t]
delimplus	[\n] 
ws {delim}+ 
newline	{delimplus}
letter [A-Za-z] 
digit [0-9] 
id {letter}({letter}|{digit})* 
number {digit}+(\.{digit}+)?(E[+\-]?{digit}+)?
%option nounput
%%
{newline}	{lineno++;}
{ws}	{/* no action and no return */} 
{id}	{install_id(); return(symtable[tokenval].token);} 
{number}	{install_num(); return(NUM);} 
.	{return yytext[0];}
<<EOF>>	{return DONE;}
%%
int install_num() {	
  tokenval = atoi(yytext);
  return NUM;
}
      
int install_id() {	
  p = lookup (yytext);
  if (p == 0)
    p = insert (yytext, ID);
  tokenval = p;
  return symtable[p].token;
}