  #include "global.h";
  int lineno = 1;
  int tokenval = NONE;
  int yylval;
delim [ \t\n] 
ws {delim}+ 
letter [A-Za-z] 
digit [0-9] 
id {letter}({letter}|{digit})* 
number {digit}+(\.{digit}+)?(E[+\-]?{digit}+)?
%option nounput
%% 
{ws} {/* no action and no return */} 
{id} {yylval = install_id(); return(ID);} 
{number} {yylval = install_num(); return(NUM);} 
<<EOF>>	{return DONE;}
%%
int install_num() {	
  tokenval = atoi(yytext);
  return NUM;
}
      
int install_id() {
  int p;	
  p = lookup (yytext);
  if (p == 0)
    p = insert (yytext, ID);
  tokenval = p;
  return symtable[p].token;
}