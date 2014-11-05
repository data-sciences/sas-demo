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
/*=== Example 4.3.4. Schizophrenia data                           ===*/
/*===================================================================*/
data example4_3_4;
 set SASdata.Schizophrenia_data;
run;
proc format;
     VALUE IMPS79b  0 = 'LE Mild' 1 = 'GE Moderate';
     VALUE IMPS79o  1 = ' 1 = Normal' 
                    2 = ' 2 = Mild'
                    3 = ' 3 = Marked'
                    4 = ' 4 = Severe'
                    . = 'Total';
     VALUE IMPS79f  1 = 'Normal' 
                    2 = 'Mild'
                    3 = 'Marked'
                    4 = 'Severe'
                    . = 'Total';
     VALUE IMPS79c  1 = 'Y<=1 (Normal)' 
                    2 = 'Y<=2 (Normal, Mild)'
                    3 = 'Y<=3 (Normal, Mild, Marked)';
     VALUE Trt      0 = 'Placebo' 1 = 'Drug';
run;

/*---------------------------------------------------------------*/
/* Macro PRED_PLOT is used to generate observed versus predicted */
/* probability plots shown in Figure 4.5 and Figure 4.6 of Ch. 4 */
/*---------------------------------------------------------------*/
%macro Pred_Prob(clink=CProbit);
  proc sort data=pred;
   by Trt Week _ORDER_;
  run;
  data pred1;
   set pred;
   by Trt Week _ORDER_;
   if first._ORDER_;
  run;
  data pred2;
   set pred1;
   by Trt Week _ORDER_;
   if first.Week then do;
    _ORDER_=4; CumProb_Hat=1;
    output;
   end;
  run;
  data pred3;
   set pred1 pred2;
   by Trt Week _ORDER_;
  run;
  data pred4;
   set pred3;
   by Trt Week _ORDER_;
   retain LastProb;
   LastProb=lag(CumProb_Hat);
   if first.Week then LastProb=CumProb_Hat;
   if _ORDER_=1 then Prob_Hat=CumProb_Hat;
   else Prob_Hat = CumProb_Hat - LastProb;
   keep Trt Week SWeek _ORDER_ Prob_Hat CumProb_Hat;
  run;
  proc sort data=obs;
   by Trt Week _ORDER_;
  run;
  data obs1; 
   set obs;
   by Trt Week _ORDER_;
   if _ORDER_=. then delete;
  run;
  data both;
   merge obs1 pred4;
   by Trt Week _ORDER_;
   IMPS79o=_ORDER_;
   CumLink="&clink";
   Descrip=put(IMPS79o, IMPS79f.);
   keep Trt Week SWeek _ORDER_ IMPS79o Descrip Prob_Obs Prob_Hat CumLink;
  run;
  ods listing;

  proc sort data=both;
   by IMPS79o Descrip;
  run;

  goptions reset=all rotate=landscape gsfmode=replace ftext=swiss
           htext=1.5 hby=1.5 device=sasemf;
  run;

  goptions reset=symbol;
  options nobyline;
  proc gplot data=both gout=SASgraph.chapterfigures;
   where Week in (0 1 3 6); 
   by IMPS79o Descrip;
   plot  Prob_Obs*SWeek=Trt / vaxis=axis1 haxis=axis2 legend=legend1 name='predp';
   plot2 Prob_Hat*SWeek=Trt / vaxis=axis3 legend=legend2;
   axis1 label=(a=90 'Pr(Y=k)') 
         order=0 to 1 by .1 
         minor=none;
   axis2 label=('Time (Square Root of Week)')
         order=0 to 2.8 by .4
         minor=none;   
   axis3 label=none 
         order=0 to 1 by .1 
         minor=none 
         value=none ;
   legend1 label=none down=2
           shape=symbol(4, 1)
           value=(t=1 'Placebo (observed)' t=2 'Drug (observed)')
           position=(inside top right) ;
   legend2 label=none down=2
           value=(t=1 'Placebo (predicted)' t=2 'Drug (predicted)')
           position=(inside top left) ;
   symbol1 h=2.0 c=black v=dot    i=none; 
   symbol2 h=2.0 c=black v=square i=none; 
   symbol3 c=black v=none i=join l=1 w=3 ; 
   symbol4 c=black v=none i=join l=2 w=3; 
   title "k = #BYVAL(IMPS79o) (#BYVAL(Descrip))";
  run;
  quit;
  options byline;
%mend Pred_Prob;


/*----------------------------*/                    
/*--- Code for Figure 4.3  ---*/    
/*----------------------------*/   
proc sort data=example4_3_4;
 by Trt ID Week;
run;
goptions reset=all rotate=landscape gsfmode=replace ftext=swiss
         htext=1.5 hby=1.5 device=sasemf;
run;
goptions reset=symbol;
options nobyline;
proc gchart data=example4_3_4 gout=SASgraph.chapterfigures;
 by Trt;
 where Week in (0 1 3 6);
 pattern1 c=black value=e  ;
 pattern2 c=black value=r1 ;
 pattern3 c=black value=x1 ;
 pattern4 c=black value=s  ;
 axis1 label=('Week');
 axis2 label=(a=90 'Percent')
       order=0 to 70 by 10 minor=none;
 axis3 label=('IMPS 79');
 legend1 label=('IMPS 79')
         across=4 value=(h=1) 
         position=(BOTTOM CENTER OUTSIDE);
 vbar IMPS79o / type=percent group=Week width=4
                space=0 g100 discrete /* subgroup=IMPS79o INCLUDE THIS FOR PATTERNS TO WORK */
                gaxis=axis1 raxis=axis2 maxis=axis3
                legend=legend1 name='vbar';
 title "#BYVAL(Trt)";
 format Trt Trt.;
run;
quit;
options byline;
title;
proc greplay igout=SASgraph.chapterfigures 
             gout=SASgraph.chapterfigures 
             nofs template=h2 tc=sashelp.templt;
 treplay 1:vbar 2:vbar1 name='Fig4_3';
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 4.14 ---*/    
/*----------------------------*/   
proc sort data=example4_3_4;
 by ID Week;
run;
proc print data=example4_3_4(obs=19) noobs;
run;


/*----------------------------*/                    
/*--- Code for Output 4.15 ---*/    
/*----------------------------*/   
ods listing close ;
ods output crosslist=obs;
proc freq data=example4_3_4;
 table Trt*Week*IMPS79o /crosslist nocol nopercent; 
run;
data obs;
 set obs;
 _ORDER_=IMPS79o;
 Prob_Obs=RowPercent/100;
 if Prob_Obs>.;
 keep Trt Week F_IMPS79o IMPS79o _ORDER_ 
      Frequency RowPercent Prob_Obs;;
run;
ods listing;
proc sort data=obs;
 by Trt Week F_IMPS79o;
run;
data N;
 set obs;
 by Trt Week F_IMPS79o;
 if _ORDER_=.;
 N=Frequency;
 keep Trt Week N;
run;
data obs;
 merge obs N;
 by Trt Week;
run;
data odds;
 set obs;
 by Trt Week F_IMPS79o;
 retain CumProb_Obs 0;
 CumProb_Obs = CumProb_Obs + Prob_Obs;
 if first.week then CumProb_Obs=Prob_Obs;
 CumOdds = CumProb_Obs/(1-CumProb_Obs);
 if CumProb_Obs=2 then delete;
run;
data odds0;
 set odds;
 odds0=CumOdds;
 cprob0=CumProb_Obs;
 if trt=0;
 keep Week IMPS79o cprob0 odds0;
run;
data odds1;
 set odds;
 odds1=CumOdds;
 cprob1=CumProb_Obs;
 if trt=1;
 keep Week IMPS79o cprob1 odds1;
run;
data COR;
 merge odds0 odds1;
 CumOddsRatio = odds1/odds0;
run;
proc report data=obs
 HEADLINE HEADSKIP SPLIT='|' nowindows missing;
 where _ORDER_ ne .;
 column Trt Week N _ORDER_, (Frequency Prob_Obs);
 define Trt     / Group "Treatment" WIDTH=12 format=Trt. 
                  order=internal;
 define Week    / Group "Week" order=internal WIDTH=4;
 define N       / Mean FORMAT=3.0 "N" order=internal WIDTH=4;
 define _ORDER_ / Across "IMPS 79 Ordinal Score" 
                  order=formatted Width=8 format=IMPS79o.;
 define Frequency / MEAN FORMAT=6.0 'Freq' 
                   width=6 NOZERO spacing=1;
 define Prob_Obs  / MEAN FORMAT=6.3 'Prob' 
                   width=6 NOZERO spacing=1;
run;
quit;
proc report data=COR 
 HEADLINE HEADSKIP SPLIT='|' nowindows missing;
 where IMPS79o<4 and Week IN (0 1 3 6);
 column Week IMPS79o ('Placebo' cprob0 odds0) 
                     ('Drug' cprob1 odds1) CumOddsRatio;
 define Week    / Group "Week" order=internal WIDTH=4;
 define IMPS79o / Group "Cumulative IMPS 79 Scores" 
                  order=formatted Width=27 format=IMPS79c.;
 define cprob0    / display FORMAT=6.3 'Cum. Prob.'
                   width=9 NOZERO spacing=1 center;
 define odds0     / display FORMAT=6.3 'Cum. Odds'
                   width=8 NOZERO spacing=1 center;
 define cprob1    / display FORMAT=6.3 'Cum. Prob.'
                   width=9 NOZERO spacing=1 center;
 define odds1     / display FORMAT=6.3 'Cum. Odds'
                   width=8 NOZERO spacing=1 center;
 define CumOddsRatio  / display FORMAT=6.3 
                        'Cumulative|Odds Ratio' 
                        width=10 NOZERO spacing=1 center;
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 4.16 ---*/    
/*---      and Figure 4.5  ---*/    
/*----------------------------*/
ods select NObs ModelInfo GEEModInfo GEEFitCriteria 
           GEEEmpPEst ;
ods output Estimates=Estimates;
proc genmod data=example4_3_4; 
 class ID;
 model IMPS79o = Trt SWeek Trt*SWeek 
               / dist=multinomial link=clogit;
 repeated subject=ID / type=ind modelse;
 estimate 'CumLogOR(Week=0)' Trt 1 Trt*SWeek 0 /exp;
 estimate 'CumLogOR(Week=1)' Trt 1 Trt*SWeek 1 /exp;
 estimate 'CumLogOR(Week=3)' Trt 1 Trt*SWeek 1.7321 /exp;
 estimate 'CumLogOR(Week=6)' Trt 1 Trt*SWeek 2.4495 /exp;
 output out=pred prob=CumProb_Hat;
run; 
%Pred_Prob(clink=CLOGIT);
title;
proc greplay igout=SASgraph.chapterfigures 
             gout=SASgraph.chapterfigures 
             nofs template=l2r2 tc=sashelp.templt;
             treplay 1:predp 2:predp1 3:predp2 4:predp3 name='Fig4_5';
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 4.17 ---*/    
/*----------------------------*/
ods select ModelInfo GEEFitCriteria GEEEmpPEst;
proc genmod data=example4_3_4; 
 class ID;
 model IMPS79o = Trt SWeek Trt*SWeek 
               / dist=multinomial link=cprobit;
 repeated subject=ID / type=ind modelse;
run; 


/*----------------------------*/                    
/*--- Code for Output 4.18 ---*/    
/*---      and Figure 4.6  ---*/    
/*----------------------------*/
ods select ModelInfo GEEFitCriteria GEEEmpPEst;
proc genmod data=example4_3_4; 
 class ID;
 model IMPS79o = Trt SWeek Trt*SWeek 
               / dist=multinomial link=ccll;
 repeated subject=ID / type=ind modelse;
 output out=pred prob=CumProb_Hat;
run; 
%Pred_Prob(clink=CCLL);
title;
proc greplay igout=SASgraph.chapterfigures 
             gout=SASgraph.chapterfigures 
             nofs template=l2r2 tc=sashelp.templt;
             treplay 1:predp4 2:predp5 3:predp6 4:predp7 name='Fig4_6';
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 4.19 ---*/    
/*---      and Figure 4.7  ---*/    
/*----------------------------*/
data COR_Pred;
 set Estimates;
 if Label IN ('Exp(CumLogOR(Week=0))' 'Exp(CumLogOR(Week=1))' 
              'Exp(CumLogOR(Week=3))' 'Exp(CumLogOR(Week=6))');
 if Label = 'Exp(CumLogOR(Week=0))' then do;
    Week=0; COR_Pred=LBetaEstimate;
    Lower=LBetaLowerCL; Upper=LBetaUpperCL;
 end;
 if Label = 'Exp(CumLogOR(Week=1))' then do;
    Week=1; COR_Pred=LBetaEstimate;
    Lower=LBetaLowerCL; Upper=LBetaUpperCL;
 end;
 if Label = 'Exp(CumLogOR(Week=3))' then do;
    Week=3; COR_Pred=LBetaEstimate;
    Lower=LBetaLowerCL; Upper=LBetaUpperCL;
 end;
 if Label = 'Exp(CumLogOR(Week=6))' then do;
    Week=6; COR_Pred=LBetaEstimate;
    Lower=LBetaLowerCL; Upper=LBetaUpperCL;
 end;
 SWeek=Sqrt(Week);
 keep Week SWeek COR_Pred Lower Upper;
run;
proc sort data=COR_Pred;
 by Week;
run;
data COR_all;
 merge COR COR_Pred;
 by Week;
 if IMPS79o<4 and Week IN (0 1 3 6);
run;

goptions reset=symbol;
goptions reset rotate=landscape gsfmode=replace ftext=swiss
         htext=1.5 hby=1.5 device=sasemf;
proc gplot data=COR_all gout=SASgraph.chapterfigures;
 plot CumOddsRatio*SWeek=1 COR_Pred*SWeek=2
      Lower*SWeek=3 Upper*SWeek=4 / overlay
      vaxis=axis1 haxis=axis2 name='Fig4_7';
 axis1 label=(a=90 'Cumulative Odds Ratio')
       order=0.25 0.5 1 2 4 10 11
       value=(t=7 ' ')
       interval=uneven
       logbase=10
       logstyle=expand
       minor=none;
 axis2 label=('Time (Square Root of Week)')
       order=0 to 2.8 by .4
       minor=none;
 symbol1 c=black v=dot i=none;
 symbol2 c=black v=none i=join l=1 w=5;
 symbol3 c=black v=none i=join l=2 w=3;
 symbol4 c=black v=none i=join l=2 w=3;
run;
quit;

proc report data=COR_all 
 HEADLINE HEADSKIP SPLIT='|' nowindows missing;
 where IMPS79o<4 and Week IN (0 1 3 6);
 column Week IMPS79o ('Placebo' cprob0) 
                     ('Drug' cprob1) CumOddsRatio COR_Pred;
 define Week    / Group "Week" order=internal WIDTH=4;
 define IMPS79o / Group "Cumulative IMPS 79 Scores" 
                  order=formatted Width=27 format=IMPS79c.;
 define cprob0    / display FORMAT=6.3 'Cum. Prob.'
                   width=9 NOZERO spacing=1 center;
 define cprob1    / display FORMAT=6.3 'Cum. Prob.'
                   width=9 NOZERO spacing=1 center;
 define CumOddsRatio  / display FORMAT=6.3 
                        'Observed|Cumulative|Odds Ratio' 
                        width=10 NOZERO spacing=1 center;
 define COR_Pred      / display FORMAT=6.3 
                        'Predicted|Cumulative|Odds Ratio' 
                        width=10 NOZERO spacing=1 center;
run;
quit;



/*===================================================================*/
/*=== Example 5.2.3. Schizophrenia data = continued               ===*/
/*===================================================================*/

/* Here we mimic exactly what was done in Example 4.3.4 to */
/* get the observed probabilities and Cumulative OR values */
data example4_3_4;
 set SASdata.Schizophrenia_data;
run;
proc format;
     VALUE IMPS79b  0 = 'LE Mild' 1 = 'GE Moderate';
     VALUE IMPS79o  1 = ' 1 = Normal' 
                    2 = ' 2 = Mild'
                    3 = ' 3 = Marked'
                    4 = ' 4 = Severe'
                    . = 'Total';
     VALUE IMPS79f  1 = 'Normal' 
                    2 = 'Mild'
                    3 = 'Marked'
                    4 = 'Severe'
                    . = 'Total';
     VALUE IMPS79c  1 = 'Y<=1 (Normal)' 
                    2 = 'Y<=2 (Normal, Mild)'
                    3 = 'Y<=3 (Normal, Mild, Marked)';
     VALUE Trt      0 = 'Placebo' 1 = 'Drug';
     VALUE Trtf     0 = 'Placebo' 1 = 'Active Drug';
run;
ods listing close ;
ods output crosslist=obs;
proc freq data=example4_3_4;
 table Trt*Week*IMPS79o /crosslist nocol nopercent; 
run;
data obs;
 set obs;
 _ORDER_=IMPS79o;
 Prob_Obs=RowPercent/100;
 if Prob_Obs>.;
 keep Trt Week F_IMPS79o IMPS79o _ORDER_ 
      Frequency RowPercent Prob_Obs;;
run;
ods listing;
proc sort data=obs;
 by Trt Week F_IMPS79o;
run;
data N;
 set obs;
 by Trt Week F_IMPS79o;
 if _ORDER_=.;
 N=Frequency;
 keep Trt Week N;
run;
data obs;
 merge obs N;
 by Trt Week;
run;
data odds;
 set obs;
 by Trt Week F_IMPS79o;
 retain CumProb_Obs 0;
 CumProb_Obs = CumProb_Obs + Prob_Obs;
 if first.week then CumProb_Obs=Prob_Obs;
 CumOdds = CumProb_Obs/(1-CumProb_Obs);
 if CumProb_Obs=2 then delete;
run;
data odds0;
 set odds;
 odds0=CumOdds;
 cprob0=CumProb_Obs;
 if trt=0;
 keep Week IMPS79o cprob0 odds0;
run;
data odds1;
 set odds;
 odds1=CumOdds;
 cprob1=CumProb_Obs;
 if trt=1;
 keep Week IMPS79o cprob1 odds1;
run;
data COR;
 merge odds0 odds1;
 CumOddsRatio = odds1/odds0;
run;


/*----------------------------*/                    
/*--- Code for Output 5.10 ---*/    
/*----------------------------*/
proc sort data=example4_3_4 out=example5_2_3;
 by ID Week;
run;
ods select CovTests FitStatistics CondFitStatistics
           Covparms ParameterEstimates Estimates;
proc glimmix data=example5_2_3 method=Quad maxopt=50 empirical;
 class ID;
 model IMPS79o = Trt SWeek Trt*SWeek 
               / dist=multinomial link=clogit s; 
 random intercept / subject=ID;
 estimate 'CumLogOR(Week=0)' Trt 1 Trt*SWeek 0 /exp;
 estimate 'CumLogOR(Week=1)' Trt 1 Trt*SWeek 1 /exp;
 estimate 'CumLogOR(Week=3)' Trt 1 Trt*SWeek 1.7321 /exp;
 estimate 'CumLogOR(Week=6)' Trt 1 Trt*SWeek 2.4495 /exp;
 covtest 'H0: No random intercept variance' 0;
run;


/*----------------------------*/                    
/*--- Code for Output 5.11 ---*/    
/*----------------------------*/
ods select CovTests FitStatistics CondFitStatistics
           Covparms ParameterEstimates Estimates;
proc glimmix data=example5_2_3 method=Quad maxopt=50 empirical;
 class ID ;
 model IMPS79o = Trt SWeek Trt*SWeek 
               / dist=multinomial link=clogit s; 
 random intercept Sweek / subject=ID type=un s;
 estimate 'CumLogOR(Week=0)' Trt 1 Trt*SWeek 0 /exp;
 estimate 'CumLogOR(Week=1)' Trt 1 Trt*SWeek 1 /exp;
 estimate 'CumLogOR(Week=3)' Trt 1 Trt*SWeek 1.7321 /exp;
 estimate 'CumLogOR(Week=6)' Trt 1 Trt*SWeek 2.4495 /exp e;
 covtest 'H0: No covariance component' . 0 .;
 covtest 'H0: No random intercept variance' 0 0 .;
 covtest 'H0: No random slope variance' . 0 0;
 covtest 'H0: No random-effects' 0 0 0;
 covtest DiagG;
 covtest ZeroG;
 output out=pred pred(ilink blup)=pred 
                 pred(ilink noblup)=predmean;
run;


/*----------------------------*/                    
/*--- Code for Figure 5.7  ---*/    
/*----------------------------*/
/* MACRO Pred_SSProb generates observed vs predicted probability plots */
%macro Pred_SSProb(clink=CLogit,spline=SM50);
	data pred;
	 set pred;
	 _ORDER_=_LEVEL_;
	 CumProb_Hat = pred;       ** Ind. SS Prob(Yij<=K|Xij,Zij,bi);
	 CumProb_Hat0 = predmean;  ** Avg. SS Prob(Yij<=K|Xij, Zij, bi=0);
	run;
	proc sort data=pred;
	 by ID Trt Week _ORDER_;
	run;
	data pred1;
	 set pred;
	 by ID Trt Week _ORDER_;
	 if first._ORDER_;
	run;
	data pred2;
	 set pred1;
	 by ID Trt Week _ORDER_;
	 if first.Week then do;
	  _ORDER_=4; CumProb_Hat=1; CumProb_Hat0=1;
	  output;
	 end;
	run;
	data pred3;
	 set pred1 pred2;
	 by ID Trt Week _ORDER_;
	run;
	data pred4;
	 set pred3;
	 by ID Trt Week _ORDER_;
	 retain LastProb LastProb0;
	 LastProb=lag(CumProb_Hat);
	 LastProb0=lag(CumProb_Hat0);
	 if first.Week then do;
	    LastProb=CumProb_Hat;
	    LastProb0=CumProb_Hat0;
	 end;
	 if _ORDER_=1 then do;
	    Prob_Hat=CumProb_Hat;
	    Prob_Hat0=CumProb_Hat0;
	 end;
	 else do;
	    Prob_Hat = CumProb_Hat - LastProb;
	    Prob_Hat0 = CumProb_Hat0 - LastProb0;
	 end;
	 keep ID Trt Week SWeek _ORDER_ Prob_Hat Prob_Hat0 CumProb_Hat CumProb_Hat0;
	run;
	proc sort data=obs;
	 by Trt Week _ORDER_;
	run;
	data obs1; 
	 set obs;
	 by Trt Week _ORDER_;
	 if _ORDER_=. then delete;
	run;

	proc means data=pred4 noprint nway mean;
	 class Trt Week _ORDER_;
	 id SWeek Prob_Hat0 CumProb_Hat0;
	 var Prob_Hat CumProb_Hat;
	 output out=pred5 mean=Prob_Hat CumProb_Hat;
	run;

	data both;
	 merge obs1 pred5;
	 by Trt Week _ORDER_;
	 IMPS79o=_ORDER_;
	 CumLink="CLogit";
	 Descrip=put(IMPS79o, IMPS79f.);
	 keep Trt Week SWeek _ORDER_ IMPS79o Descrip CumLink
          Prob_Obs Prob_Hat Prob_Hat0 CumProb_Hat CumProb_Hat0;
	run;
	ods listing;

	proc sort data=both;
	 by Week IMPS79o Descrip Trt;
	run;
	data both;
	 set both;
	 by Week IMPS79o Descrip Trt;
	 Last_CumProb_Hat =lag(CumProb_Hat);
	 Last_CumProb_Hat0=lag(CumProb_Hat0);
	 if first.IMPS79o then do;
	  Last_CumProb_Hat =CumProb_Hat;
	  Last_CumProb_Hat0=CumProb_Hat0;
	 end;
	 CumOddsRatio = (CumProb_Hat/(1-CumProb_Hat))/(Last_CumProb_Hat/(1-Last_CumProb_Hat));
	 CumOddsRatio0 = (CumProb_Hat0/(1-CumProb_Hat0))/(Last_CumProb_Hat0/(1-Last_CumProb_Hat0));
	run;

	proc sort data=both;
	 by Week IMPS79o Trt Descrip;
	run;

	proc print data=both;
	 where Week in (0 1 3 6); 
	run;

	proc sort data=both; 
	 by IMPS79o Descrip;
	run;

	goptions reset rotate=landscape gsfmode=replace ftext=swiss
	         htext=1.5 hby=1.5 device=sasemf;
	run;

	goptions reset=symbol;
	options nobyline;
	proc gplot data=both gout=SASgraph.chapterfigures;
	 where Week in (0 1 3 6); 
	 by IMPS79o Descrip;
	 plot  Prob_Obs*SWeek=Trt / vaxis=axis1 haxis=axis2 legend=legend1 NAME='Prob';;
	 plot2 Prob_Hat*SWeek=Trt / vaxis=axis3 legend=legend2;
	 axis1 label=(a=90 'Pr(Y=k)') 
	       order=0 to 1 by .1 
	       minor=none;
	 axis2 label=('Time (Square Root of Week)')
	       order=0 to 2.8 by .4
	       minor=none;   
	 axis3 label=none 
	       order=0 to 1 by .1 
	       minor=none 
	       value=none ;
	 legend1 label=none down=2
	         shape=symbol(5, 1)
	         value=(t=1 'Placebo (observed)' t=2 'Drug (observed)')
	         position=(inside top right) ;
	 legend2 label=none down=2
	         shape=symbol(5, 1)
	         value=(t=1 'Placebo (predicted)' t=2 'Drug (predicted)')
	         position=(inside top left) ;
	 symbol1 h=1.5 c=black v=dot    i=none; 
	 symbol2 h=1.5 c=black v=square i=none; 
	 symbol3 c=black v=none i=join l=1 w=3 ; 
	 symbol4 c=black v=none i=join l=2 w=3; 
	 title "k = #BYVAL(IMPS79o) (#BYVAL(Descrip))";
	run;
	quit;
	options byline;


	proc sort data=pred4;
	 by Week Trt ID;
	run;

	data plotpred4_0;
	 set pred4;
	 by Week Trt ID;
	 if first.ID;
	 if week=6;
	 Descrip=put(Trt, Trt.);
     IMPS79o=0; CumProb_Hat=0; CumProb_Hat0=0;
	 Odds_SS  = CumProb_Hat/(1-CumProb_Hat);
	 Odds_SS0 = CumProb_Hat0/(1-CumProb_Hat0);
	 keep Trt Descrip ID Week SWeek IMPS79o CumProb_Hat CumProb_Hat0 Odds_SS Odds_SS0;
    run; 
	data plotpred4_1;
	 set pred4;
	 by Week Trt ID;
	 if Week=6;
	 IMPS79o=_ORDER_; 	 
	 Descrip=put(Trt, Trt.);
 	 Odds_SS  = CumProb_Hat/(1-CumProb_Hat);
	 Odds_SS0 = CumProb_Hat0/(1-CumProb_Hat0);	
	 keep Trt Descrip ID Week SWeek IMPS79o CumProb_Hat CumProb_Hat0 Odds_SS Odds_SS0;
	run; 
	data plotpred4;
	 set plotpred4_0 plotpred4_1;
	run;

	data temp;
	 set both;
	 drop Descrip;
	run;

	data PAprob_0;
     set temp;
	 if week=6 and _ORDER_=1;
	 Descrip=put(Trt, Trt.);
	 ID=9999;
     IMPS79o=0; CumProb_Hat=0; CumProb_Hat0=0;
	 Odds_SS  = CumProb_Hat/(1-CumProb_Hat);
	 Odds_SS0 = CumProb_Hat0/(1-CumProb_Hat0);
	 keep Trt Descrip ID Week SWeek IMPS79o CumProb_Hat CumProb_Hat0 Odds_SS Odds_SS0;
    run; 
	data PAprob_1;
     set temp;
	 if week=6;
	 Descrip=put(Trt, Trt.);
	 ID=9999;
     IMPS79o=_ORDER_; 
     Odds_SS  = CumProb_Hat/(1-CumProb_Hat);
	 Odds_SS0 = CumProb_Hat0/(1-CumProb_Hat0);
	 keep Trt Descrip ID Week SWeek IMPS79o CumProb_Hat CumProb_Hat0 Odds_SS Odds_SS0;
    run; 
	data PAprob;
	 set PAprob_0 PAprob_1;
	run;
	proc sort data=PAprob;
	 by Week Trt ID IMPS79o;
	run;
	run;
	data plotpred;
	 set plotpred4 PAprob;
	run;

	proc sort data=plotpred;
	 by Week Trt ID IMPS79o;
	run;

	proc means data=plotpred4 nway;
	 class Trt IMPS79o;
	 var CumProb_Hat CumProb_Hat0;
	run;

	data plotpred4;
	 set plotpred4;
	 if IMPS79o in (0 4) then delete;
	run;
	proc means data=plotpred4 nway;
	 class Trt IMPS79o;
	 var CumProb_Hat CumProb_Hat0;
	run;

	proc sort data=plotpred4;
	 by Week Trt Descrip ID IMPS79o;
	run;
	proc sort data=plotpred;
	 by Week Trt Descrip ID IMPS79o;
	run;

	goptions reset=symbol;
	options nobyline;
	proc gplot data=plotpred4 gout=SASgraph.chapterfigures;
	 where Trt=0;
	 by Week Trt Descrip;
	 plot  CumProb_Hat*IMPS79o=ID  / vaxis=axis1 haxis=axis2 nolegend NAME='CumProb0';
	 plot2 CumProb_Hat0*IMPS79o=ID / vaxis=axis3 nolegend;
	 axis1 label=(a=90 'Pr(Y<=k)') 
	       order=0 to 1 by .2 
	       minor=none;
	 axis2 label=('k = IMPS79 Ordinal Score')
	       order=1 to 3 by 1
		   offset=(2 cm)
		   value=(t=1 '1-Normal' t=2 '2-Mild' t=3 '3-Marked')
	       minor=none;   
	 axis3 label=none 
	       order=0 to 1 by .2 
	       minor=none 
		   major=none
	       value=none ;
	 symbol1 c=black v=none i=&spline  l=2 w=.25 r=70; 
	 symbol2 c=black v=none i=&spline  l=1 w=4 r=70; 
	 title "Treatment = #BYVAL(Trt) (#BYVAL(Descrip)) at Week #BYVAL(Week)";
	run;
	quit;

	proc gplot data=plotpred4 gout=SASgraph.chapterfigures;
	 where Trt=1;
	 by Week Trt Descrip;
	 plot  CumProb_Hat*IMPS79o=ID  / vaxis=axis1 haxis=axis2 nolegend NAME='CumProb1';
	 plot2 CumProb_Hat0*IMPS79o=ID / vaxis=axis3 nolegend;
	 axis1 label=(a=90 'Pr(Y<=k)')
	       order=0 to 1 by .2
           value=(t=7 ' ') 
	       minor=none;
	 axis2 label=('k = IMPS79 Ordinal Score')
	       order=1 to 3 by 1
		   value=(t=1 '1-Normal' t=2 '2-Mild' t=3 '3-Marked')
		   offset=(2 cm)
	       minor=none;   
	 axis3 label=none 
	       order=0 to 1 by .2 
	       minor=none 
		   major=none
	       value=none ;
	 symbol1 c=black v=none i=&spline  l=2 w=.25 r=265; 
	 symbol3 c=black v=none i=&spline  l=1 w=4 r=265; 
	 title "Treatment = #BYVAL(Trt) (#BYVAL(Descrip)) at Week #BYVAL(Week)";
	run;
	quit;
	options byline;
%mend Pred_SSProb;

goptions reset rotate=landscape gsfmode=replace ftext=swiss
         htext=1.5 hby=1.5 device=sasemf;
run;

%Pred_SSProb(clink=CLOGIT, spline=join);
proc greplay igout=SASgraph.chapterfigures 
             gout=SASgraph.chapterfigures 
             nofs template=l2r2 tc=sashelp.templt;
 treplay 1:Prob 2:Prob1 3:Prob2 4:Prob3 name='Fig5_7';
run;
quit;
proc greplay igout=SASgraph.chapterfigures 
             gout=SASgraph.chapterfigures 
             nofs template=h2s tc=sashelp.templt;
 treplay 1:CumProb0 2:CumProb1 name='Fig5_8';
run;
quit;
title;


/*----------------------------*/                    
/*--- Code for Output 5.12 ---*/    
/*----------------------------*/
proc sort data=both out=summary;
 by Trt Week IMPS79o;
run;
data summary;
 set summary;
 by Trt Week IMPS79o;
 CumProb_Obs+Prob_Obs;
 if first.Week then CumProb_Obs=Prob_Obs;
run;
data summary;
 set summary;
 by Trt Week IMPS79o;
 CumOdds_Obs=CumProb_Obs/(1-CumProb_Obs);
 CumOdds_Hat=CumProb_Hat/(1-CumProb_Hat);
 CumOdds_Hat0=CumProb_Hat0/(1-CumProb_Hat0);
 if Trt=0 then do;
  CumOddsRatio0=.;
  CumOddsRatio=.;
 end;
run;
proc report data=summary 
 HEADLINE HEADSKIP SPLIT='|' nowindows missing;
 where IMPS79o<4 and Week IN (0 1 3 6);
 column Week IMPS79o Trt, (CumProb_Obs CumProb_Hat0 CumProb_Hat); 
 define Week    / Group "Week" order=internal WIDTH=4;
 define IMPS79o / Group "IMPS 79 Scores" 
                  order=internal Width=12 format=IMPS79f. ;
 define Trt     / Across "_Treatment Group_" order=internal format=trtf. width=8;
 define CumProb_Obs / mean FORMAT=6.3 'Observed Cum. Prob.'
                      width=9 NOZERO spacing=1 center;
 define CumProb_Hat0 / mean FORMAT=6.3 "SS|Cum. Prob."
                      width=7 NOZERO spacing=1 center;
 define CumProb_Hat / mean FORMAT=6.3 'PA|Cum. Prob.'
                      width=9 NOZERO spacing=1 center;
run;
quit;
proc report data=summary 
 HEADLINE HEADSKIP SPLIT='|' nowindows missing;
 where IMPS79o<4 and Week IN (0 1 3 6);
 column Week IMPS79o Trt, (CumOdds_Obs CumOdds_Hat0 CumOdds_Hat) ('Odds Ratios' CumOddsRatio0 CumOddsRatio); 
 define Week    / Group "Week" order=internal WIDTH=4;
 define IMPS79o / Group "IMPS 79 Scores" 
                  order=internal Width=12 format=IMPS79f. ;
 define Trt     / Across "_Treatment Group_" order=internal format=trtf. width=8;
 define CumOdds_Obs / mean FORMAT=6.3 'Obs.|Cum. Odds'
                      width=8 NOZERO spacing=1 center;
 define CumOdds_Hat0 / mean FORMAT=6.3 "SS|Cum. Odds"
                       width=6 NOZERO spacing=1 center;
 define CumOdds_Hat / mean FORMAT=6.3 'PA|Cum. Odds'
                      width=6 NOZERO spacing=1 center;
 define CumOddsRatio0 / mean FORMAT=5.2 "SS|Cum. OR"
                        width=5 NOZERO spacing=1 center;
 define CumOddsRatio / mean FORMAT=5.2 'PA|Cum. OR'
                       width=5 NOZERO spacing=1 center;
run;
quit;



/*===================================================================*/
/*=== Example 6.6.3. Schizophrenia data - continued               ===*/
/*===================================================================*/
libname SASdata 'c:\SAS datasets used in book\';
libname SAStemp 'c:\SAS temporary datasets used in book\';

/*----------------------------*/                    
/*--- Code for Output 6.12 ---*/    
/*----------------------------*/

/* Create primary response variable dataset */
data example6_6_3;
 set SASdata.Schizophrenia_data;
 /* Ind is a 0-1 indicator variable for a SP model */
 /* Ind=0 implies we are modeling IMPS79o response */ 
 Ind=0;
run;
/* Calculate the maximum value of WEEK for each subject */
/* This is the last week at which IMPS79o was measured  */
/* prior to dropout or upon completion of the study     */
proc means data=example6_6_3 noprint nway; 
 class ID Trt;
 var Week; 
 output out=temp1 max=LastWeek;
run;
/* Create discrete time survival dataset */
data temp2; 
 set temp1;
 /* Ind is a 0-1 indicator variable for a SP model */
 /* Ind=1 implies we are modeling Dropout response */ 
 Ind=1;
 Keep ID Trt LastWeek Ind;
run;
data dropout;
 set temp2;
 /* Time represents the interval dropout time   */
 /* Time = 3 is the interval between week 2 and */
 /* week 3 with the subject dropping out after  */
 /* start of week 2 but prior to start of week 3*/
 Time = LastWeek+1; 
 do Week=2 to Time;
  if (Week<7) then do; 
     Dropout=(Week=Time); t1=Week-1; t2=Week;
     if Week=2 then t1=0;
     Interval=compress('['||left(t1)||','||left(t2)||')');
     output;
  end;
 end;
run;
/* Dataset required to fit a shared parameter model */
data example6_6_3;
 set example6_6_3 dropout;
 if Ind=0 then do;
  Response=IMPS79o;
 end;
 if Ind=1 then do;
  Response=Dropout;
  SWeek=0;
 end;
run;
proc sort data=example6_6_3;
 by ID Ind Week;
run;
proc print data=example6_6_3 noobs;
 where ID in (1103 1105 1118 2118);
 var ID Trt Ind LastWeek Week SWeek IMPS79o 
     Interval Dropout Response;
run;


/*----------------------------*/                    
/*--- Code for Output 6.13 ---*/    
/*----------------------------*/
proc format;
 value Trt 0 = 'Placebo' 1 = 'Drug';
run;
/* Discrete time proportional hazards model for dropout  */
/* This model is used to get starting values for NLMIXED */
proc logistic data=dropout;
 class Interval /param=glm;
 model Dropout(event='1')= Interval Trt / 
       noint link=cloglog technique=newton;
run; 
/* Joint model for IMPS79o and Dropout under S-CRD */
ods output parameterestimates=SAStemp.peCRD;
proc nlmixed data=example6_6_3 qpoints=5 tech=newrap;
 parms beta11=-7.3 beta12=-3.4 beta13=-0.8 
       beta_Trt = -0.06 beta_SWeek = 0.88 
       beta_Trt_x_SWeek = 1.68
	   psi11=6.85 psi12=-1.44 psi22=1.95
	   eta1=-1.9 eta2=-3.2 eta3=-1.7 
       eta4=-3.7 eta5=-3.2 eta_Trt=-0.69;
 /* Define SS intercepts and slopes */
 bi = b1i + b2i*SWeek;
 /* Define log-likelihood for the GLME logit model */
 if Ind=0 then do;
 /* Define linear predictor as defined in GLIMMIX  */
 /* In the comments below the variable y = IMPS79o */
 /* is the ordinal response variable of interest   */
 linpred = beta_Trt*Trt + beta_SWeek*SWeek +
           beta_Trt_x_SWeek*Trt*SWeek + bi;
 Z1 = (beta11 + linpred);
 Z2 = (beta12 + linpred);
 Z3 = (beta13 + linpred);
 /* Define the cumulative response probabilities   */
 P1 = exp(Z1)/(1+exp(Z1)); ** = Pr[y<=1]=Pr[y=1];
 P2 = exp(Z2)/(1+exp(Z2)); ** = Pr[y<=2];
 P3 = exp(Z3)/(1+exp(Z3)); ** = Pr[y<=3];
 P4 = 1;                   ** = Pr[y<=4];
 /* Define the individual response probabilities   */
 pi1 = P1;                 ** = Pr[y=1];
 pi2 = P2-P1;              ** = Pr[y=2];
 pi3 = P3-P2;              ** = Pr[y=3];
 pi4 = 1-P3;               ** = Pr[y=4]=1-Pr[y<=3];
 P = (IMPS79o=1)*pi1 + (IMPS79o=2)*pi2 + 
     (IMPS79o=3)*pi3 + (IMPS79o=4)*pi4;
 LogL = log(P); 
 end;
 /* Define log-likelihood for discrete time PH model */
 if Ind=1 then do;
 Lambda_i = eta1*(Week=2) + eta2*(Week=3) + eta3*(Week=4) + 
            eta4*(Week=5) + eta5*(Week=6) + eta_Trt*Trt; 
 ** Complementary log-log link = Hazard function;
 Hazard_i = 1 - exp(-exp(Lambda_i));       
 ** Binary(1,H_i) log likelihood;
 LogL = response*log(Hazard_i/(1-Hazard_i)) + log(1-Hazard_i); 
 end;
 model response ~ general(LogL);
 random b1i b2i ~ normal([0,0],[psi11,
                                psi12, psi22]) subject=ID;
 estimate 'CumLogOR(Week=0)' 
  beta_Trt;
 estimate 'CumLogOR(Week=1)' 
  beta_Trt + beta_Trt_x_SWeek*1;
 estimate 'CumLogOR(Week=3)' 
  beta_Trt + beta_Trt_x_SWeek*1.7321;
 estimate 'CumLogOR(Week=6)' 
  beta_Trt + beta_Trt_x_SWeek*2.4495;
 estimate 'CumOR(Week=0)' 
  exp(beta_Trt);
 estimate 'CumOR(Week=1)' 
  exp(beta_Trt + beta_Trt_x_SWeek*1);
 estimate 'CumOR(Week=3)' 
  exp(beta_Trt + beta_Trt_x_SWeek*1.7321);
 estimate 'CumOR(Week=6)' 
  exp(beta_Trt + beta_Trt_x_SWeek*2.4495);
run;


/*----------------------------*/                    
/*--- Code for Output 6.14 ---*/    
/*----------------------------*/
data initial;
 Parameter='eta_b1i';Estimate=0; output;
 Parameter='eta_b2i';Estimate=0; output;
run;
data initial;
 set SAStemp.peCRD initial;
run;
ods output parameterestimates=SAStemp.peSP;
ods select Specifications Dimensions IterHistory 
           ConvergenceStatus FitStatistics 
		   ParameterEstimates AdditionalEstimates;
proc nlmixed data=example6_6_3 qpoints=5 tech=newrap;
 parms / data=initial;
 /* Define SS intercepts and slopes */
 bi = b1i + b2i*SWeek;
 /* Define log-likelihood for the GLME logit model */
 if Ind=0 then do;
 /* Define linear predictor as defined in GLIMMIX  */
 linpred = beta_Trt*Trt + beta_SWeek*SWeek +
           beta_Trt_x_SWeek*Trt*SWeek + bi;
 Z1 = (beta11 + linpred);
 Z2 = (beta12 + linpred);
 Z3 = (beta13 + linpred);
 P1 = exp(Z1)/(1+exp(Z1)); ** = Pr[y<=1]=Pr[y=1];
 P2 = exp(Z2)/(1+exp(Z2)); ** = Pr[y<=2];
 P3 = exp(Z3)/(1+exp(Z3)); ** = Pr[y<=3];
 P4 = 1;                   ** = Pr[y<=4];
 pi1 = P1;                 ** = Pr[y=1];
 pi2 = P2-P1;              ** = Pr[y=2];
 pi3 = P3-P2;              ** = Pr[y=3];
 pi4 = 1-P3;               ** = Pr[y=4]=1-Pr[y<=3];
 P = (IMPS79o=1)*pi1 + (IMPS79o=2)*pi2 + 
     (IMPS79o=3)*pi3 + (IMPS79o=4)*pi4;
 LogL = log(P); 
 end;
 /* Define log-likelihood for discrete time dropout data */
 if Ind=1 then do;
 Lambda_i = eta1*(Week=2) + eta2*(Week=3) + eta3*(Week=4) + 
            eta4*(Week=5) + eta5*(Week=6) + eta_Trt*Trt + 
            eta_b1i*b1i + eta_b2i*b2i;
 ** Complementary log-log link = Hazard function **;
 Hazard_i = 1 - exp(-exp(Lambda_i));       
 ** Binomial(1,H_i) log likelihood;
 LogL = response*log(Hazard_i/(1-Hazard_i)) + log(1-Hazard_i); 
 end;
 model response ~ general(LogL);
 random b1i b2i ~ normal([0,0],[psi11,
                                psi12, psi22]) subject=ID;
 estimate 'CumLogOR(Week=0)' beta_Trt;
 estimate 'CumLogOR(Week=1)' beta_Trt + beta_Trt_x_SWeek*1;
 estimate 'CumLogOR(Week=3)' beta_Trt + beta_Trt_x_SWeek*1.7321;
 estimate 'CumLogOR(Week=6)' beta_Trt + beta_Trt_x_SWeek*2.4495;
 estimate 'CumOR(Week=0)' exp(beta_Trt);
 estimate 'CumOR(Week=1)' exp(beta_Trt + beta_Trt_x_SWeek*1);
 estimate 'CumOR(Week=3)' exp(beta_Trt + beta_Trt_x_SWeek*1.7321);
 estimate 'CumOR(Week=6)' exp(beta_Trt + beta_Trt_x_SWeek*2.4495);
run;


/*----------------------------*/                    
/*--- Code for Output 6.15 ---*/    
/*----------------------------*/
data initial1;
 Parameter='eta_Trt_b1i';Estimate=0; output;
 Parameter='eta_Trt_b2i';Estimate=0; output;
run;
data initial2;
 set initial initial1;
run;
/* Joint SP model for IMPS79o and Dropout */
ods output parameterestimates=SAStemp.peSP1;
ods select IterHistory ConvergenceStatus FitStatistics 
		   ParameterEstimates AdditionalEstimates;
proc nlmixed data=example6_6_3 qpoints=5 tech=newrap;
 parms / data=initial2;
 /* Define SS intercepts and slopes */
 bi = b1i + b2i*SWeek;
 /* Define log-likelihood for the GLME logit model */
 if Ind=0 then do;
 /* Define linear predictor as defined in GLIMMIX  */
 linpred = beta_Trt*Trt + beta_SWeek*SWeek +
           beta_Trt_x_SWeek*Trt*SWeek + bi;
 Z1 = (beta11 + linpred);
 Z2 = (beta12 + linpred);
 Z3 = (beta13 + linpred);
 P1 = exp(Z1)/(1+exp(Z1)); ** = Pr[y<=1]=Pr[y=1];
 P2 = exp(Z2)/(1+exp(Z2)); ** = Pr[y<=2];
 P3 = exp(Z3)/(1+exp(Z3)); ** = Pr[y<=3];
 P4 = 1;                   ** = Pr[y<=4];
 pi1 = P1;                 ** = Pr[y=1];
 pi2 = P2-P1;              ** = Pr[y=2];
 pi3 = P3-P2;              ** = Pr[y=3];
 pi4 = 1-P3;               ** = Pr[y=4]=1-Pr[y<=3];
 P = (IMPS79o=1)*pi1 + (IMPS79o=2)*pi2 + 
     (IMPS79o=3)*pi3 + (IMPS79o=4)*pi4;
 LogL = log(P); 
 end;
 if Ind=1 then do;
 /* Define log-likelihood for discrte time dropout data */
 Lambda_i = eta1*(Week=2) + eta2*(Week=3) + eta3*(Week=4) + 
            eta4*(Week=5) + eta5*(Week=6) + eta_Trt*Trt + 
            eta_b1i*b1i + eta_b2i*b2i + 
            eta_Trt_b1i*Trt*b1i + eta_Trt_b2i*Trt*b2i;
 ** Complementary log-log link = Hazard function **;
 Hazard_i = 1 - exp(-exp(Lambda_i));       
 ** Binomial(1,H_i) log likelihood;
 LogL = response*log(Hazard_i/(1-Hazard_i)) + log(1-Hazard_i); 
 end;
 model response ~ general(LogL);
 random b1i b2i ~ normal([0,0],[psi11,
                                psi12, psi22]) subject=ID;
 estimate 'CumLogOR(Week=0)' beta_Trt;
 estimate 'CumLogOR(Week=1)' beta_Trt + beta_Trt_x_SWeek*1;
 estimate 'CumLogOR(Week=3)' beta_Trt + beta_Trt_x_SWeek*1.7321;
 estimate 'CumLogOR(Week=6)' beta_Trt + beta_Trt_x_SWeek*2.4495;
 estimate 'CumOR(Week=0)' exp(beta_Trt);
 estimate 'CumOR(Week=1)' exp(beta_Trt + beta_Trt_x_SWeek*1);
 estimate 'CumOR(Week=3)' exp(beta_Trt + beta_Trt_x_SWeek*1.7321);
 estimate 'CumOR(Week=6)' exp(beta_Trt + beta_Trt_x_SWeek*2.4495);
run;

/* Likelihood ratio test as reported in book */
data LRT;
 LogL1=4055.2;df1=17;
 LogL2=4033.4;df2=19;
 LRT = -LogL2 - (-LogL1);
 df=df2-df1;
 ProbChiSq = 1-ProbChi(LRT,DF);
run;
proc print data=LRT;
run;


/*----------------------------*/                    
/*--- Code for Output 6.16 ---*/    
/*----------------------------*/
data peALL;
 set SAStemp.peSP(in=a)
     SAStemp.peSP1(in=b);
 if a then Model='SP Model 1 (AIC=4089.2)'; 
 if b then Model='SP Model 2 (AIC=4071.4)'; 
run;
proc report data=peALL headskip split='*' nowindows spacing=1;
 column ("Comparison of Shared Parameter Model Results" 
         Parameter Model, (Estimate StandardError Probt) );
 define Parameter / group;
 define Model / across 'Model';
 define Estimate / mean width=8 format=7.4;
 define StandardError / mean 'StdErr';
 define Probt / mean 'Pr>|t|' width=6;
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

