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
/*=== Example 3.2.3. Estrogen levels in healthy premenopausal women==*/
/*===================================================================*/

proc sort data=SASdata.Estradiol_data out=example3_2_3;
 by Subject_ID Group Visit Breast;
run;


/*----------------------------*/                    
/*--- Code for Output 3.4  ---*/    
/*----------------------------*/                    
proc print data=example3_2_3(obs=24) noobs ;
 var Subject_ID Group Visit Breast NAF_Estradiol Saliva_Estradiol Serum_Estradiol;
run;


/*----------------------------*/                    
/*--- Code for Output 3.5  ---*/    
/*----------------------------*/                    
proc tabulate data=example3_2_3 ;
 class Group Visit Breast;
 var NAF_Estradiol Saliva_Estradiol Serum_Estradiol;
 table Group*Visit, 
       Breast*(NAF_Estradiol)*(N*F=2.0 Mean*F=5.2 Std*F=5.2)
      /rts=16;
run;
proc tabulate data=example3_2_3 ;
 where Breast='Left';
 class Group Visit;
 var Saliva_Estradiol Serum_Estradiol;
 table Group*Visit, 
       (Serum_Estradiol Saliva_Estradiol)*(N*F=2.0 Mean*F=6.2 Std*F=6.2)
      /rts=16;
run;


/*----------------------------*/                    
/*--- Code for Output 3.6  ---*/    
/*----------------------------*/                    
%macro AIC(type=un);
  ods listing close;
  ods output InfoCrit=AIC_i;
  proc mixed data=example3_2_3 scoring=100 covtest ic;
   where Breast='Left';
   class Subject_ID Group Visit;
   model Serum_Estradiol = Group Visit Group*Visit 
                           Saliva_Estradiol /solution;
   repeated visit / subject=Subject_ID type=&type; 
  run; 
  data AIC_i;
   set AIC_i;
   Type="&type";
  run; 
  data AIC;
   set AIC AIC_i;
   if Type=' ' then delete;
  run; 
  ods listing;
%mend;
data AIC;
 %AIC(type=UN);
 %AIC(type=AR(1));
 %AIC(type=CS);
run;
proc print data=AIC split='|';
 id Type;
run;
/*-------------------------------------------------------------------*/
/* The following code is for the Preliminary analysis of the data    */
/* in which we use MIXED to estimate the degree of association       */
/* between serum and saliva estradiol log concentrations. The results*/
/* of this analysis are reported in the book but not as output and   */
/* hence this SAS code is not shown in the book but is included here.*/
/*-------------------------------------------------------------------*/
proc mixed data=example3_2_3 scoring=100 covtest ic;
 where Breast='Left';
 class Subject_ID Group Visit;
 model Serum_Estradiol = Group Visit Group*Visit 
       Saliva_Estradiol /solution;
 repeated visit / subject=Subject_ID type=cs; 
run; 


/*----------------------------*/                    
/*--- Code for Output 3.7  ---*/    
/*----------------------------*/   

/*-------------------------------------------------------------------*/
/* The following code is for the Preliminary analysis of the data    */
/* in which we use MIXED to directly estimate correlations between   */
/* serum and saliva estradiol log concentrations.                    */
/*-------------------------------------------------------------------*/
data example3_2_3_new;
 set example3_2_3;
 if Breast='Left';
 Source='Saliva'; Estradiol=Saliva_Estradiol; output;
 Source='Serum '; Estradiol=Serum_Estradiol;  output;
run;
proc sort data=example3_2_3_new;
 by Subject_ID Group Visit Source;
run;
ods output R=R;
ods output Rcorr=Rcorr;
ods output CovParms=CovParms;
proc mixed data=example3_2_3_new scoring=100 covtest;
 class Subject_ID Group Visit Source;
 model Estradiol = Source Group Source*Group Visit 
                   Source*Visit Group*Visit Source*Group*Visit / solution;
 repeated Source Visit / subject=Subject_ID type=un@cs r=3 rcorr=3;
run; 
data R1;
 set R;
 Type='UN@CS';
 Matrix='1 Cov ';
run;
data Rcorr1;
 set Rcorr;
 Type='UN@CS';
 Matrix='2 Corr';
run;
data Covparm;
 set Covparms;
 Type='UN@CS';
 drop subject;
run;
data R_all;
 set R1 Rcorr1;
 drop index;
run;
proc print data=Covparm noobs;
run;
proc print data=R_all noobs;
 by Matrix;
 id Matrix;
 var Row Col1-Col8;
 format Col1-Col8 5.3;
run;


/*----------------------------*/                    
/*--- Code for Output 3.8  ---*/    
/*----------------------------*/   
proc sort data=example3_2_3;
 by Subject_ID Group Visit Breast;
run;
ods select ModelInfo Dimensions NObs CovParms G V VCorr
           FitStatistics Tests3 ; 
proc mixed data=example3_2_3 ic covtest empirical;
 class Subject_ID Group Visit Breast;
 model NAF_Estradiol = Group Visit Group*Visit Breast 
       Group*Breast Visit*Breast Group*Visit*Breast /
       solution;
 random Intercept / sub=Subject_ID type=un g;
 random Intercept / sub=Subject_ID(Visit) type=un g v vcorr;
run;


/*----------------------------*/                    
/*--- Code for Output 3.9  ---*/    
/*----------------------------*/   
ods select ModelInfo Dimensions NObs CovParms 
           FitStatistics SolutionF Tests3; 
ods select SolutionF Tests3; 
proc mixed data=example3_2_3 ic covtest empirical;
 class Subject_ID Group Visit Breast;
 model NAF_Estradiol = Group Visit Group*Visit Breast Group*Breast 
                       Visit*Breast Group*Visit*Breast  
                       Serum_Estradiol / solution;
 random Intercept / sub=Subject_ID type=un g;
 random Intercept / sub=Subject_ID(Visit) type=un g v vcorr;
run;
/*-------------------------------------------------------------------*/
/* The following code is for fitting a second ANCOVA model to the    */
/* data with Saliva_Estradiol as the covariate rather than           */
/* Serum_Estradiol. The results of this analysis are reported in the */
/* book but not as output and hence this SAS code is not shown in    */
/* the book but is included here.                                    */
/*-------------------------------------------------------------------*/
ods select ModelInfo Dimensions NObs CovParms 
           FitStatistics SolutionF Tests3; 
ods select SolutionF Tests3; 
proc mixed data=example3_2_3 ic covtest empirical;
 class Subject_ID Group Visit Breast;
 model NAF_Estradiol = Group Visit Group*Visit Breast Group*Breast 
                       Visit*Breast Group*Visit*Breast  
                       Saliva_Estradiol / solution;
 random Intercept / sub=Subject_ID type=un g;
 random Intercept / sub=Subject_ID(Visit) type=un g v vcorr;
run;


/*----------------------------*/                    
/*--- Code for Output 3.10 ---*/    
/*----------------------------*/   
ods select ModelInfo Dimensions NObs CovParms 
           FitStatistics SolutionF Tests3; 
proc mixed data=example3_2_3 ic covtest empirical;
 class Subject_ID Group Visit Breast;
 model NAF_Estradiol = Group Visit Group*Visit Breast 
                       Group*Breast Visit*Breast 
                       Group*Visit*Breast Serum_Estradiol 
                       Saliva_Estradiol / solution;
 random Intercept / sub=Subject_ID type=un g;
 random Intercept / sub=Subject_ID(Visit) type=un g v vcorr;
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

