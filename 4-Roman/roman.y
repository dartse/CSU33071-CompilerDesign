%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int yylex();
void yyerror(char *s);
%}

/* declare tokens */
%union {
	int num;
}

%token EOL
%token <num> NUMBER
%type <num> number letters
%%
numlist:  
 | numlist number EOL { printf("%d\n", $2); } 
 ;

number: letters
| number letters {$$ = $1 + $2;}
;

letters:NUMBER {$$ = yylval.num;}
;

%%

int main(){
    yyparse();
    return 0;
}

void yyerror(char *s){
    fprintf(stderr, "%s\n", s);
    exit(0);
}