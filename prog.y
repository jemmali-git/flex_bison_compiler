%{
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <ctype.h>
using namespace std;
 
#include <string.h>
#include <vector>
#include <typeinfo>

int lineNumber;
int yylex(void);
struct def_var
{
    string nom;
    double valeur ;
    string type ;
    def_var(string nom="",double value=0,string type="")
    {
        this->nom=nom;
        this->valeur=value;
        this->type=type;
    }
};

vector<def_var> table_symbol;
vector<string> list_id;

void yyerror(const char * msg)
{
	cerr << "line " << lineNumber << ": "<< msg << endl;
}
void push_type(string type)
{
	for (unsigned i = 0; i<list_id.size(); i++)
    {
        table_symbol.push_back(def_var(list_id.at(i),0,type));
    }
    list_id.clear();
}
double value_of_id(string id)
{
	for (unsigned i = 0; i<table_symbol.size(); i++)
    {
        if(table_symbol.at(i).nom==id)
            return (table_symbol.at(i).valeur);
    }	
    return (0);
}
string type_of_id(string id)
{
    for (unsigned i = 0; i<table_symbol.size(); i++)
    {
        if(table_symbol.at(i).nom==id)
            return (table_symbol.at(i).type);
    }   
    char msg[0x20];
    sprintf(msg,"undeclared variable : %s",id.c_str());
    yyerror(msg);
    exit (EXIT_FAILURE);
}
double index_of_id(string id)
{
	for (unsigned i = 0; i<table_symbol.size(); i++)
    {
        if(table_symbol.at(i).nom==id)
            return (i);
    }
    char msg[0x20];
    sprintf(msg,"undeclared variable : %s",id.c_str());
    yyerror(msg);
    exit (EXIT_FAILURE);
}
void update_id (string id, double &value)
{
	if(type_of_id(id)=="entier")
	   table_symbol.at(index_of_id(id)).valeur=(int)value;
    else if(type_of_id(id)=="reel")
            table_symbol.at(index_of_id(id)).valeur=(double)value;
    else
    {
        char msg[0x20];
        sprintf(msg,"type of variable unknown : %s",type_of_id(id).c_str());
        yyerror(msg);
        exit (EXIT_FAILURE);   
    }

}
void div_zero(double&val)
{
	if(!val)
	{
		char msg[0x20];
    	sprintf(msg,"division par zero");
    	yyerror(msg);
		exit (EXIT_FAILURE);
	}
}


extern FILE * yyin;
%}
%token PROGRAM VAR DEBUT FIN   
%token DEUX_POINT
%token ID 
%token AFFECTATION
%token POINT_VIRGULE
%token SI ALORS  FINSI
%token PAR_OUVR PAR_FERM
%token ET OU NON  
%token ENTIER REEL 
%token VIRGULE
%token PLUS MOINS MULT DIV
%token SUP SUP_EGAL
%token INF INF_EGAL
%token EGAL DIFF
%token NB_INT NB_REAL
%token LIRE ECRIRE

%union { char chaine[0x100]; double reel; int entier; bool boolean; }
%type<chaine> ID  
%type<reel> NB_REAL  Expa 
%type<entier> NB_INT 
%type<boolean> Expr	 Expb


%start P 
%%
P :	PROGRAM ID S_DCL  DEBUT S_INST FIN 
|	PROGRAM ID   	  DEBUT        FIN 
|	PROGRAM ID S_DCL  DEBUT 	   FIN
|	PROGRAM ID        DEBUT S_INST FIN  
;
S_DCL : DCL 
| 		DCL S_DCL
;
DCL : 	VAR L_id DEUX_POINT ENTIER  POINT_VIRGULE	{ push_type("entier");}
|		VAR L_id DEUX_POINT REEL 	POINT_VIRGULE	{ push_type("reel");} 	  	
;
L_id : 	ID 				{	list_id.push_back($1);	}
|	   	ID VIRGULE L_id	{	list_id.push_back($1);	}			
;

S_INST :INST 	{}
| 		INST S_INST	{}
;
INST : 	ID AFFECTATION Expa POINT_VIRGULE 	{ double a=$3; update_id($1,a);} 
|						    POINT_VIRGULE	{}
|	                   Expa POINT_VIRGULE	{}
|		ID AFFECTATION Expb POINT_VIRGULE	{ double a=$3; update_id($1,a);}
|		LIRE PAR_OUVR ID PAR_FERM POINT_VIRGULE		{double a; cin>>a; update_id($3,a);  }
|		ECRIRE PAR_OUVR ID PAR_FERM POINT_VIRGULE	{ cout <<value_of_id($3)<<endl	; 	 }
|       ECRIRE PAR_OUVR Expa PAR_FERM POINT_VIRGULE   { cout <<$3<<endl  ;    }
;
INST :	SI Expb ALORS ID AFFECTATION Expa           POINT_VIRGULE FINSI	{if($2) { double a=$6; update_id($4,a);}}
|       SI Expb ALORS ID AFFECTATION Expb           POINT_VIRGULE FINSI {if($2) { double a=$6; update_id($4,a);}}
|       SI Expb ALORS LIRE PAR_OUVR ID PAR_FERM     POINT_VIRGULE FINSI {if($2) {double a;cin>>a;update_id($6,a);}}
|       SI Expb ALORS ECRIRE PAR_OUVR ID PAR_FERM   POINT_VIRGULE FINSI {if($2){cout <<value_of_id($6)<<endl;}}
|       SI Expb ALORS ECRIRE PAR_OUVR Expa PAR_FERM   POINT_VIRGULE FINSI {if($2){cout <<$6<<endl;}}
|       SI Expb ALORS Expa                          POINT_VIRGULE FINSI
|       SI Expb ALORS                               POINT_VIRGULE FINSI 
;
 
Expb : PAR_OUVR Expb PAR_FERM       {$$=$2;  }
|      Expr 						{$$=$1; 	}
|      NON PAR_OUVR Expr PAR_FERM 	{$$=!($3); 	}
|      Expr ET Expr				{$$=$1&&$3; }
|      Expr OU Expr				{$$=$1||$3;	}
;
Expr : PAR_OUVR Expr PAR_FERM  {$$=$2; }
|      Expa SUP Expa		{$$=$1>$3 ;		}
|      Expa SUP_EGAL Expa	{$$=$1>=$3 ;	}
|      Expa INF Expa		{$$=$1<$3 ;		}
|      Expa INF_EGAL Expa	{$$=$1<=$3 ;	}
|      Expa DIFF Expa		{$$=!($1==$3) ;	}
|      Expa EGAL Expa		{$$=$1==$3 ;}
|	   Expa					{$$=$1;		}
;

Expa :	PAR_OUVR Expa PAR_FERM 	{$$=($2);	}
|		ID 						{$$=value_of_id($1);}
|		NB_REAL 				{$$=$1;		}
|		NB_INT 					{$$=$1;		}
|		Expa PLUS Expa			{$$=$1+$3;  } 
|		Expa DIV Expa			{div_zero($3);  $$=$1/$3;	}
|		Expa MOINS Expa			{$$=$1-$3;	}
|		Expa MULT Expa			{$$=$1*$3;	}
;

%%
		 
int main(int argc,char ** argv)
{
	if(argc>1) yyin=fopen(argv[1],"r"); 
		lineNumber=1;

	if(!yyparse()) cerr << "0 error(s)" << endl;
	/*for (unsigned i = 0; i<table_symbol.size(); i++)
    {
    	cout << table_symbol.at(i).nom <<"  "<<table_symbol.at(i).valeur <<" "<<table_symbol.at(i).type << endl;
    }*/

		return(0);
}
