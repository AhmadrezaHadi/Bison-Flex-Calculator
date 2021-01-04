%{
    #include <stdio.h>
    #include <math.h>
    #include <string.h>
    #include <stdlib.h>

    extern int yylex(void);
    int yyerror (char const *s);
    
    typedef struct var{
        int val;
        char var[256];
    } var;

    var vars[100];
    int vars_index = 0;
%}

%union{
    double val;
    char var[256];
}

%token<val> INT
%token<var> VARIABLE
%token PLUS MINUS
%token DIVISION MULTIPLY 
%token SQRT LOG
%token LEFT_P RIGHT_P
%token EQUAL
%token ENDL

%type<val> Expression
%type<val> Line
%type<val> PAR


%left PLUS MINUS
%left MULTIPLY DIVISION
%left LOG SQRT
%left LEFT_P RIGHT_P

%start Input

%%

Input: /* empty */;
Input: Input Line;

Line: Expression ENDL { printf("%f\n", $1); }


Line: VARIABLE EQUAL Expression ENDL{
    int check = 0;
    $$ = $3;
    for(int i=0;i<vars_index;i++){
        if(strcmp(vars[i].var, $1) == 0){
            vars[i].val = $3;
            check = 1;
            break;
        }
    }
    if(!check){
        strcpy(vars[vars_index].var, $1);
        vars[vars_index++].val = $3;

    }
};


Expression: INT{$$ = $1;};
Expression: MINUS INT{$$= -$2;};
Expression: VARIABLE{
    int checked=0;
    for(int i = 0; i<vars_index; i++)
    {
        if (!strcmp(vars[i].var, $1))
        {
            $$ = vars[i].val;
            checked=1;
        }
    }
    if (!checked)
    {
        printf("UNDEFINED VARIABLE\n");
        exit(0);
    }
};
Expression: Expression PLUS Expression{$$ =$1 + $3;};
Expression: Expression MINUS Expression{$$ = $1 - $3;};
Expression: Expression MULTIPLY Expression{$$ = $1 * $3;};
Expression: Expression DIVISION Expression{$$ = $1 / $3;};
Expression: LOG PAR{$$ = log10($2);};
Expression: SQRT PAR{$$ = sqrt($2);}; 
Expression: PAR{$$ = $1;};
PAR: LEFT_P Expression RIGHT_P{$$ = $2;};


%%





int yyerror(char const *s) {
  printf("%s\n", s);
}

int main() {
    int ret = yyparse();
    if (ret){
	fprintf(stderr, "%d error found.\n",ret);
    }
    return 0;
}

