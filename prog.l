%{ 
#include <stdio.h>
#include <iostream>
using namespace std;
extern int lineNumber;			 			
void yyerror(const char * msg);
#include "progY.hpp" 

%}
%option noyywrap
%x comment 

integer \-?[0-9]+
real \-?[0-9]+\.[0-9]*|\.[0-9]+
id [a-zA-Z_][0-9a-zA-Z_]*

%%
"Program"		{ return(PROGRAM);	}
"Debut" 		{ return(DEBUT);	}
"Fin" 			{ return(FIN);		}
"Var" 			{ return(VAR);		}
":" 			{ return(DEUX_POINT);	}
":=" 			{ return(AFFECTATION);	}
";" 			{ return(POINT_VIRGULE);}
"Si" 			{ return(SI); 		}
"alors" 		{ return(ALORS); 	}
"FinSi" 		{ return(FINSI); 	}
"non" 			{ return(NON); 		}
"et" 			{ return(ET); 		}
"ou" 			{ return(OU); 		}
"(" 			{ return(PAR_OUVR); }
")" 			{ return(PAR_FERM); }
"+"				{ return(PLUS); 	}
"*"				{ return(MULT); 	}
"/"	  			{ return(DIV); 		}
"-"				{ return(MOINS); 	}
"<"				{ return(INF); 		}
">"				{ return(SUP); 		}
"<="			{ return(INF_EGAL); }
">="  			{ return(SUP_EGAL); }
"<>"  			{ return(DIFF); 	}
"="  			{ return(EGAL); 	}
"entier" 		{ return(ENTIER);   	}
"reel"  		{ return(REEL); 		}
"lire"			{ return (LIRE);		}
"ecrire"		{ return (ECRIRE);		}
{integer}		{ sscanf(yytext,"%d",&yylval.entier); return NB_INT ;	}
{real}			{ sscanf(yytext,"%lf",&yylval.reel); return NB_REAL ;	}
{id} 			{ sprintf(yylval.chaine,"%s",yytext); return(ID);		}
","   			{ return VIRGULE ;	}
"\n" 			{ ++lineNumber; 	}
[ \t]+ 			{}
"+-"			{ BEGIN(comment);}
<comment>"-+"	{ BEGIN(INITIAL);}
<comment>\n     { ++lineNumber;  }
<comment>.       ; 
. 				{ char msg[0x20];  sprintf(msg,"lexical error <%s>",yytext); yyerror(msg); }
%%