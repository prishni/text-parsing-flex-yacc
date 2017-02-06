%{
#include <stdio.h>
#include <string.h> 
#include <stdlib.h>
extern FILE *yyin;
FILE *out;
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap() {
        return 1;
} 
  
void main(int argc, char** argv) {
        if(argc<2) {
                fprintf(stderr, "Provide filename\n");
                exit(0);
        }
        char outfilename[256] = {0};
        char fname[256] = {0};
        int dotposition = strchr(argv[1], '.') - argv[1];
        strcpy(outfilename, "./databaseinp/");
        strncat(outfilename, argv[1], dotposition);
        strcat(outfilename, ".csv");
        strcpy(fname, "./fac/");
        strcat(fname, argv[1]);
        FILE * p =fopen(fname,"r");
        out = fopen(outfilename, "a");
        yyin =p;
        yyparse();
} 

%}

%union {
        char *str;
}

%token <str> PBEGIN CHR PEND NAME PHONE AWARD WEB DESG RESP EMAIL
%type <str>  info chr publist start garbage

%%
start: 
        /*empty*/
        | start info
        | start garbage
        | start chr  
        | start publist  
        ;
name:
        NAME { 
               fprintf(out,"NAME$%s\n",$1);
        }
        ;
phone:
        PHONE { 
                fprintf(out,"PHONE$%s\n",$1);
        }
        ;
award:
        AWARD { 
                fprintf(out,"%s\n",$1);
        }
        ;        
email: 
        EMAIL {
                fprintf(out,"EMAIL$%s\n",$1);
        }
        ;
desg: 
        DESG {
                fprintf(out,"DESG$%s\n",$1);
        }
        ;
web:   
        WEB {
                fprintf(out,"WEB$%s\n",$1); fflush(NULL); 
        }
        ;  
resp: 
        RESP {
                fprintf(out,"RESP$%s\n",$1);
        }
        ;
publist:
        PBEGIN chr PEND {
               //char *text1 = malloc(sizeof(char)*(strlen($2)+2));
               //strcpy(text1, $2); //strcat(text, "$");
               //$$ = strdup(text1);
               fprintf(out,"%s\n\n",$2);
          }
        | publist PBEGIN chr PEND {
               //char *text1 = malloc(sizeof(char)*(strlen($2)+2));
               //strcpy(text1, $1);
               //strcat(text1, $3);
               //$$ = strdup(text1);
               fprintf(out,"%s\n\n",$3);

          }
        ;

chr: 
        CHR {
               char *text = malloc(sizeof(char)*(strlen($1)+2));
               strcpy(text, $1); //strcat(text, "$");
               $$ = strdup(text);
          }
        | chr CHR {
                char *text = malloc(sizeof(char)*(strlen($1)+strlen($2)+2));
                strcpy(text, $1); 
                strcat(text, $2);
                $$ = strdup(text);
        }
        ;
garbage: /*empty string*/
        | garbage PEND
        ;

info:   name
        | phone
        | web
        | award
        | desg
        | email
        | resp
        ;

%%
