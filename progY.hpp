/* A Bison parser, made by GNU Bison 2.4.2.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2006, 2009-2010 Free Software
   Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     PROGRAM = 258,
     VAR = 259,
     DEBUT = 260,
     FIN = 261,
     DEUX_POINT = 262,
     ID = 263,
     AFFECTATION = 264,
     POINT_VIRGULE = 265,
     SI = 266,
     ALORS = 267,
     FINSI = 268,
     PAR_OUVR = 269,
     PAR_FERM = 270,
     ET = 271,
     OU = 272,
     NON = 273,
     ENTIER = 274,
     REEL = 275,
     VIRGULE = 276,
     PLUS = 277,
     MOINS = 278,
     MULT = 279,
     DIV = 280,
     SUP = 281,
     SUP_EGAL = 282,
     INF = 283,
     INF_EGAL = 284,
     EGAL = 285,
     DIFF = 286,
     NB_INT = 287,
     NB_REAL = 288,
     LIRE = 289,
     ECRIRE = 290
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1685 of yacc.c  */
#line 121 "prog.y"
 char chaine[0x100]; double reel; int entier; bool boolean; 


/* Line 1685 of yacc.c  */
#line 90 "progY.hpp"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


