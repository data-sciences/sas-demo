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
/*=== Example 2.2.4. MCM2 biomarker data                          ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\CONCORR.sas' /nosource2;
%include 'c:\SAS macros used in book\CCC.sas' /nosource2;

data MCM2_data;
input Subject Core Row Col MCM2Index;
cards;
  16         1      4      2      23.8908
  16         2      3      2      26.1251
  16         3      2      2      31.0541
  16         4      1      2      32.0144
  16         6      4      1        .
  16         7      3      1      31.9534
  16         8      2      1      26.7631
  16         9      1      1      32.5031
  17         1      4      2      52.9183
  17         2      3      2      36.4055
  17         3      2      2      52.8875
  17         4      1      2      59.8259
  17         6      4      1      45.0262
  17         7      3      1      41.9355
  17         8      2      1      46.4435
  17         9      1      1      40.3614
  21         1      4      2      46.7846
  21         2      3      2      33.3333
  21         3      2      2      38.5057
  21         4      1      2        .
  21         6      4      1      30.4749
  21         7      3      1      35.4309
  21         8      2      1      30.8294
  21         9      1      1      35.1515
  22         1      4      2      25.5000
  22         2      3      2      47.1774
  22         3      2      2      35.3952
  22         4      1      2      28.5437
  22         6      4      1      30.5556
  22         7      3      1      34.2229
  22         8      2      1      40.1141
  22         9      1      1      38.5346
  23         1      4      2      48.1132
  23         2      3      2      33.1058
  23         3      2      2      31.7130
  23         4      1      2      43.5294
  23         6      4      1      35.4037
  23         7      3      1      33.4096
  23         8      2      1      39.9054
  23         9      1      1      30.5400
  24         1      4      2      20.2476
  24         2      3      2      30.3136
  24         3      2      2      33.7607
  24         4      1      2      26.8235
  24         6      4      1      26.7423
  24         7      3      1      23.6769
  24         8      2      1      28.3255
  24         9      1      1      29.1866
  25         1      4      2      32.7586
  25         2      3      2      31.4634
  25         3      2      2      31.1757
  25         4      1      2      30.6849
  25         6      4      1      38.3721
  25         7      3      1      46.1538
  25         8      2      1      31.4286
  25         9      1      1      34.4262
;


/*----------------------------*/                    
/*--- Code for Output 2.13 ---*/    
/*----------------------------*/                    
proc print data=MCM2_data noobs;
 where Subject in (16 17);
 id Subject;
 var Core Row Col MCM2Index;
run;


/*----------------------------*/                    
/*--- Code for Output 2.14 ---*/    
/*----------------------------*/                    
proc sort data=MCM2_data out=Example2_2_4;
 By Subject;
run;
proc transpose data=Example2_2_4 out=pairwise prefix=Core_;
 var MCM2Index;
 by Subject;
 id Core;
run;
title 'Pairwise CCC on original data';
%CONCORR(DATA=Pairwise, 
   VAR=Core_1 Core_2 Core_1 Core_3 Core_1 Core_4 
       Core_1 Core_6 Core_1 Core_7 Core_1 Core_8
       Core_1 Core_9
       Core_2 Core_3 Core_2 Core_4 Core_2 Core_6 
       Core_2 Core_7 Core_2 Core_8 Core_2 Core_9
       Core_3 Core_4 Core_3 Core_6 Core_3 Core_7 
       Core_3 Core_8 Core_3 Core_9                      
       Core_4 Core_6 Core_4 Core_7 Core_4 Core_8 
       Core_4 Core_9                    
       Core_6 Core_7 Core_6 Core_8 Core_6 Core_9 
       Core_7 Core_8 Core_7 Core_9
       Core_8 Core_9,
       LABEL1=Core,
       LABEL2=With,  
       FORMAT=5.2);


/*----------------------------*/                    
/*--- Code for Output 2.15 ---*/    
/*----------------------------*/                    
ods output solutionF=pe1;
ods output covparms=var1;
ods output R=rvar1;
ods output infocrit=IC1;
ods output Dimensions=no_subjects1;
proc mixed data=Example2_2_4 ic;
 class Subject Core ;
 model MCM2Index = Core /solution;
 repeated Core / subject=Subject r=2 rcorr=2 type=cs;
run;
ods output solutionF=pe2;
ods output covparms=var2;
ods output R=rvar2;
ods output infocrit=IC2;
ods output Dimensions=no_subjects2;
proc mixed data=Example2_2_4 ic;
 class Subject Core ;
 model MCM2Index = Core /solution;
 repeated /subject=Subject r=2 rcorr=2 type=sp(lin) (row col);
run;
data IC1;
 set IC1;
 Model=1;
 Covariance='Compound Symmetry';
run; 
data IC2;
 set IC2;
 Model=2;
 Covariance='Spatial Linearity';
run; 
title 'CCC matrix and OCCC assuming compound symmetry';
%CCC(structure=compound symmetric, 
     effect=Core, 
     cov=Rvar1, 
     mean=pe1, 
     n=no_subjects1, 
     AIC=ic1);
run;
title 'CCC matrix and OCCC assuming spatial linearity';
%CCC(structure=spatially linear, 
     effect=Core, 
     cov=Rvar2, 
     mean=pe2, 
     n=no_subjects2, 
     AIC=ic2);
run;
title;
data AIC;
 set ic1 ic2;
run;
proc print data=AIC;
 id Model Covariance;
 var Parms Neg2LogLike AIC AICC HQIC BIC;  
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

