 /*===================================================================*/
 /*                                                                   */
 /* Generalized Linear and Nonlinear Models for Correlated Data:      */
 /* Theory and Applications Using SAS,                                */
 /* by Edward F. Vonesh                                               */
 /* Copyright (c) 2012 by SAS Institute Inc., Cary, NC, USA           */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, expressed or implied, as to merchantability or */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Date Last Updated: 28AUG2012                                      */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the authors:                                         */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press                                                         */
 /* Attn: Edward F. Vonesh                                            */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /* If you prefer, you can send e-mail to:  saspress@sas.com          */
 /* Use this for subject field:                                       */
 /*    Comments for Edward F. Vonesh                                  */
 /*                                                                   */
 /*===================================================================*/


 /*=====================================================================
   NOTES                                             
   This file contains the SAS code for Generalized Linear and Nonlinear
   Models for Correlated Data: Theory and Applications Using SAS.

   To run the code for the book successfully, you need the following:  

   -------------------------------------------------------
   ---  1) SAS 9.3 (or 9.2) with the modules           ---
   ---     SAS/BASE                                    ---
   ---     SAS/STAT                                    ---
   ---     SAS/GRAPH                                   ---
   ---     SAS/IML                                     ---
   ---     licensed and installed                      ---
   -------------------------------------------------------

   The code for this dataset is organized by chapters. 
 
   Many programs make use of the ODS SELECT statement in order to reduce
   the procedure output to what is shown in the book. For example, the 
   results shown in Output 2.2 of the book are generated using the 
   following code: 

     ods select ClassLevels Nobs RepeatedLevelInfo Multstat ModelANOVA;
     proc glm data=dental;
      class sex;
      model y1 y2 y3 y4=sex/nouni;
      repeated age 4 (8 10 12 14);
      manova;
     run;
     quit;

   Alternatively, one may use the ODS EXCLUDE statement in order to 
   reduce the procedure output to what is shown in the book. For example,      
   the results shown in Output 2.6 of the book are generated using the 
   following code: 
 
     ods exclude Dimensions NObs IterHistory ConvergenceStatus LRT;
     proc mixed data=example2_2_1 method=ml scoring=200;
      class person sex _age_;
      model y = sex sex*age /noint solution ddfm=kenwardroger;
      repeated _age_ / type=un subject=person(sex) r;
      estimate 'Difference in intercepts' sex 1 -1;
      estimate 'Difference in slopes' age*sex 1 -1;
     run;
     quit;

   To see the full output of the procedure, simply remove the ODS 
   SELECT or the ODS EXCLUDE statements.   


   SAS LIBRARY FOLDERS and LIBNAME statements:

   The user will need to create separate SAS library folders on the computer  
   or network of choice for stored programs, datasets, macros and graphics 
   according to the following notes. 

   IMPORTANT NOTE: The SAS library folders described below and within 
   the book are defined for someone using a Windows based PC and may 
   need to be modified according to the user operating environment.
   The folders listed below can be modified by the user but the programs will then
   need to change the LIBNAME statements shown within the program below. 

   NOTES on SAS programs:
 
   The SAS programs are located in two different library folders. The first  
   library folder is named 
     'c:\SAS programs used in book'
   and it contains one SAS file containing all of the programs sorted 
   according to the sequential order in which they appear in the 
   book by chapter. The second library folder is
     'c:\SAS programs by dataset used in book'
   and it contains individual SAS files containing the SAS programs 
   sorted according to the dataset being analyzed.  
    
   NOTES on SAS datasets: 

   In some examples, the original SAS dataset used in the example
   is a permanent SAS dataset. For example, the ADEMEX adequacy example uses 
   the SAS dataset, ADEMEX_Adequacy_Data.sas7bdat, and the program is written 
   assuming this SAS dataset is located in the following library folder: 
     'c:\SAS datasets used in book\' 
   This library folder contains all such permanent SAS datasets including the
   various ADEMEX datasets used in the book. In other examples, the 
   SAS dataset is provided within the example itself. Within the programs, this
   library folder (which one will need to create) is assigned via the following
   LIBNAME statement:
     LIBNAME SASdata 'c:\SAS datasets used in book\';

   NOTES on SAS temporary datasets: 

   In some examples, one or more temporary SAS datasets are created 
   within the SAS program for later use. These datasets are stored 
   in the library folder 
     'c:\SAS datasets used in book\temporary'. 
   This library folder is assigned via the LIBNAME statement:
     LIBNAME SAStemp 'c:\SAS datasets used in book\temporary';
   which of course the user can change if needed.   

   NOTES on Macros: 

   Macros used in select programs are stored in the library folder 
     'c:\SAS macros used in book\' 
   and are accessed via the %INCLUDE statement. 

   NOTES on Graphs:
 
   1) Graphics generated and replayed using GREPLAY are stored in 
   the library folder 
     'c:\SAS graphs used in book\'
   under the graphics catalog "chapterfigures.sas7bcat" on 
   an example by example basis. When a new example is run that
   calls for new graphs to be displayed, any old graphs stored in this
   graphics library catalog are cleared and only the new graphs are stored.
   The library folder is assigned via the LIBNAME statement: 
     LIBNAME SASgraph 'c:\SAS graphs used in book\';
   In addition, the graph generated by GREPLAY is written to the SAS current 
   folder which is the operating environment folder to which many SAS commands
   and actions apply. The current folder is displayed in the status line at 
   the bottom of the main SAS window. By default, SAS uses the folder that 
   is designated by the SASUSER system option in the SAS configuration file 
   as the current folder when you begin your SAS session. Optionally, one can 
   set the current folder to be  
     'c:\SAS graphs used in book\'
   by submitting the change directory (CD) command with the X statement in SAS
   as follows: 
     X 'cd c:\SAS graphs used in book\';
   Currently, this X statement is included in the program below but is commented
   out so that all graphic output will be written to the SAS current folder of the
   operating environment of the user. One need only remove the comment symbol * in  
   front of the X statement and define whatever current path one chooses to write  
   the graphic records to.  

   2) Graphics generated by ODS GRAPHICS are written to the SAS current 
   folder which is the operating environment folder as described above. Optionally,  
   one can set the current folder to be  
     'c:\SAS graphs used in book\'
   by submitting the change directory (CD) command with the X statement in SAS
   as follows: 
     X 'cd c:\SAS graphs used in book\';
   Currently, this X statement is included in the program below but is commented
   out so that all graphic output will be written to the SAS current folder of the
   operating environment of the user. One need only remove the comment symbol * in  
   front of the X statement and define whatever current path one chooses to write  
   the graphic records to.  

   3) Graphics generated by PROC GPLOT, PROC GCHART, etc. are written to the SAS  
   current folder which is the operating environment folder as described above. 
   Optionally, one can set the current folder to be  
     'c:\SAS graphs used in book\'
   by submitting the change directory (CD) command with the X statement in SAS
   as follows: 
     X 'cd c:\SAS graphs used in book\';
   Currently, this X statement is included in the program below but is commented
   out so that all graphic output will be written to the SAS current folder of the
   operating environment of the user. One need only remove the comment symbol * in  
   front of the X statement and define whatever current path one chooses to write  
   the graphic records to.  Alternatively one can write the graphic output/records   
   using a naming convention assigned by the FILENAME statement associated with the
   graph 
 
   FURTHER NOTES on Graphs:   

   When running several SAS graphic programs from different examples 
   or even within the same example, one may need to specify the goption:
     goptions reset=symbol;
   in order to reset all of the prior symbol statements for possibly 
   a new set of symbol definitions.  

 =====================================================================*/

options ps=60 ls=120 center;
title; footnote;
libname SASdata 'c:\SAS datasets used in book\';
libname SAStemp 'c:\SAS datasets used in book\temporary';
libname SASgraph 'c:\SAS graphs used in book\';
/*--------------------------------------------------------------- 
The following X statement is commented out. By removing the 
comment symbol * the X command will set the SAS current folder
to be
  'c:\SAS graphs used in book\'
which is where GREPLAY, GPLOT, etc. records will be written to
provided one has created this SAS library folder.
----------------------------------------------------------------*/
* X 'cd c:\SAS graphs used in book\';
proc greplay igout=SASgraph.chapterfigures nofs;
  delete _all_;
run;
quit;
run;



/*===================================================================*/
/*=== Example 2.2.1. Dental growth data                           ===*/
/*===================================================================*/
data dental_data;
 input gender person age y;
 if gender=1 then sex='boys ';
             else sex='girls';
 _age_=age;
cards;
1 1   8 26
1 1  10 25
1 1  12 29
1 1  14 31
1 2   8 21.5
1 2  10 22.5
1 2  12 23
1 2  14 26.5
1 3   8 23
1 3  10 22.5
1 3  12 24
1 3  14 27.5
1 4   8 25.5
1 4  10 27.5
1 4  12 26.5
1 4  14 27
1 5   8 20
1 5  10 23.5
1 5  12 22.5
1 5  14 26
1 6   8 24.5
1 6  10 25.5
1 6  12 27
1 6  14 28.5
1 7   8 22
1 7  10 22
1 7  12 24.5
1 7  14 26.5
1 8   8 24
1 8  10 21.5
1 8  12 24.5
1 8  14 25.5
1 9   8 23
1 9  10 20.5
1 9  12 31
1 9  14 26
1 10  8 27.5
1 10 10 28
1 10 12 31
1 10 14 31.5
1 11  8 23
1 11 10 23
1 11 12 23.5
1 11 14 25
1 12  8 21.5
1 12 10 23.5
1 12 12 24
1 12 14 28
1 13  8 17
1 13 10 24.5
1 13 12 26
1 13 14 29.5
1 14  8 22.5
1 14 10 25.5
1 14 12 25.5
1 14 14 26
1 15  8 23
1 15 10 24.5
1 15 12 26
1 15 14 30
1 16  8 22
1 16 10 21.5
1 16 12 23.5
1 16 14 25
2 1   8 21
2 1  10 20
2 1  12 21.5
2 1  14 23
2 2   8 21
2 2  10 21.5
2 2  12 24
2 2  14 25.5
2 3   8 20.5
2 3  10 24
2 3  12 24.5
2 3  14 26
2 4   8 23.5
2 4  10 24.5
2 4  12 25
2 4  14 26.5
2 5   8 21.5
2 5  10 23
2 5  12 22.5
2 5  14 23.5
2 6   8 20
2 6  10 21
2 6  12 21
2 6  14 22.5
2 7   8 21.5
2 7  10 22.5
2 7  12 23
2 7  14 25
2 8   8 23
2 8  10 23
2 8  12 23.5
2 8  14 24
2 9   8 20
2 9  10 21
2 9  12 22
2 9  14 21.5
2 10  8 16.5
2 10 10 19
2 10 12 19
2 10 14 19.5
2 11  8 24.5
2 11 10 25
2 11 12 28
2 11 14 28
;

proc sort data=dental_data out=example2_2_1;
 by sex person;
run;


/*---------------------------*/                    
/*--- Code for Output 2.1 ---*/                    
/*---------------------------*/                    
proc transpose data=example2_2_1 out=dental prefix=y;
 by sex person;
 var y;
run;
proc report data=dental split = '|' nowindows spacing=1;
 column sex person ('age' y1 y2 y3 y4);
 define sex /group 'sex';
 define person /display 'person';
 define y1 /display '8';
 define y2 /display '10' ;
 define y3 /display '12';
 define y4 /display '14';
 title;
 format y1--y4 4.1;
run;
quit;

/*---------------------------*/                    
/*--- Code for Figure 2.1 ---*/                    
/*---------------------------*/                    
goptions reset=symbol;
goptions reset=all rotate=landscape gsfmode=replace ftext=swiss
         htext=2.0 hby=2.0 device=sasemf;
run;
options nobyline;
proc sort data=example2_2_1;
 by sex person;
run;
data boys;
 set example2_2_1;
 by sex person;
 if sex='boys ';
run;
proc gplot data=boys gout=SASgraph.chapterfigures ;
 plot y*age=person/vaxis=axis1 haxis=axis2 nolegend name='boys';
 axis1 label=(a=90 'Distance (mm)')
       minor=none  major=none
       order=(10 to 40 by 5);
 axis2 label=('Age')
       order=(8 to 14 by 2)  
       minor=none major=none;;
 symbol1 value=none font=swiss interpol=join line=1 color=black w=1 repeat=55;
 title "Boys";
run;
quit;
data girls;
 set example2_2_1;
 by sex person;
 if sex='girls';
run;
proc gplot data=girls gout=SASgraph.chapterfigures ;
 plot y*age=person/vaxis=axis1 haxis=axis2 nolegend name='girls';
 axis1 label=(a=90 'Distance (mm)')
       minor=none  major=none
       order=(10 to 40 by 5);
 axis2 label=('Age')
       order=(8 to 14 by 2)  
       minor=none major=none;;
 symbol1 value=none font=swiss interpol=join line=1 color=black w=1 repeat=55;
 title "Girls";
run;
quit;
proc greplay igout=SASgraph.chapterfigures gout=SASgraph.chapterfigures  
             nofs template=h2ednf tc=temp;
 tdef h2ednf   1 / llx=0 lly=0 ulx=0 uly=100
                   urx=100 ury=100 lrx=100 lry=0
               2 / llx=1 lly=1 ulx=1 uly=90
                   urx=49 ury=90 lrx=49 lry=1
               3 / llx=50 lly=1 ulx=50 uly=90
                   urx=99  ury=90 lrx=99  lry=1;
 treplay 2:boys 3:girls name='Fig2_1';
run;
quit;
title;


/*---------------------------*/                    
/*--- Code for Output 2.2 ---*/
/*---------------------------*/                    
ods select ClassLevels Nobs RepeatedLevelInfo Multstat ModelANOVA;
proc glm data=dental;
 class sex;
 model y1 y2 y3 y4=sex/nouni;
 repeated age 4 (8 10 12 14);
 manova;
run;
quit;


/*---------------------------*/                    
/*--- Code for Output 2.3 ---*/
/*---------------------------*/
proc sort data=example2_2_1;
 by sex person;
run;
ods select R hlm3 hlps3;
proc mixed data=example2_2_1 method=reml ANOVAF scoring=200;
 class person sex age;
 model y = sex age sex*age ;
 repeated age / type=un subject=person(sex) hlm hlps r;
run;
quit;


/*---------------------------*/                    
/*--- Code for Output 2.4 ---*/                    
/*---------------------------*/                    
proc sort data=example2_2_1;
 by sex person;
run;
ods select Tests3;
proc mixed data=example2_2_1 method=reml ANOVAF scoring=200;
 class person sex age;
 model y = sex age sex*age ;
 repeated age / type=un subject=person(sex) hlm hlps r;
run;
quit;


/*---------------------------*/                    
/*--- Code for Output 2.5 ---*/                    
/*---------------------------*/                    
ods select Tests3;
proc glimmix data=example2_2_1 method=rmpl scoring=200;
 class person sex age;
 model y = sex age sex*age / ddfm=kenwardroger;
 random age / type=un subject=person(sex) rside;
run;
quit;


/*---------------------------*/                    
/*--- Code for Output 2.6 ---*/                    
/*---------------------------*/                    
ods exclude Dimensions NObs IterHistory ConvergenceStatus LRT;
proc mixed data=example2_2_1 method=ml scoring=200;
 class person sex _age_;
 model y = sex sex*age /noint solution ddfm=kenwardroger;
 repeated _age_ / type=un subject=person(sex) r;
 estimate 'Difference in intercepts' sex 1 -1;
 estimate 'Difference in slopes' age*sex 1 -1;
run;
quit;



/*===================================================================*/
/*=== Example 3.2.1. Dental growth data = continued               ===*/
/*===================================================================*/

proc sort data=example2_2_1;
 by sex person;
run;


/*----------------------------*/                    
/*--- Code for Output 3.1  ---*/    
/*----------------------------*/                    
ods exclude Dimensions NObs IterHistory ConvergenceStatus LRT;
proc mixed data=example2_2_1 method=ml scoring=200;
 class person sex _age_;
 model y = sex sex*age /noint solution ddfm=kenwardroger;
 random intercept age / type=un subject=person(sex);
 estimate 'Difference in intercepts' sex 1 -1;
 estimate 'Difference in slopes' age*sex 1 -1;
run;
quit;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/
