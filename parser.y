%{
#include "global.h"
int yyerror(char const *);
%}

%token NUM ID DIV MOD
%left '+' '-'
%left '*' '/'
%%
line:	'\n'
  |	exp ';' line
  |	/*Czarny Kot*/
  ;
exp:	exp '+' ter { $$ = $1 + $3; emit('+', NONE); }
  |	exp '-' ter { $$ = $1 - $3; emit('-', NONE); }
  |	ter
  ;
ter:	ter '*' fac { $$ = $1 * $3; emit('*', NONE); }
  |	ter '/' fac { $$ = $1 / $3; emit('/', NONE); }
  |	ter DIV fac { emit(DIV, NONE); }
  |	ter MOD fac { emit(MOD, NONE); }
  |	fac
  ;
fac:	dig
  |	'(' exp ')' { $$ = $2; }
  ;
dig:	NUM { emit(NUM, tokenval); }
  |	ID { emit(ID, tokenval); }
  ;
%%
int yyerror(char const * s) {
  printf("11%s \n", s);
  return 0;
}