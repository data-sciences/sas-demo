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
/*=== Example 6.4.4. A repeated measures ANCOVA                   ===*/
/*===================================================================*/
data RM_ANCOVA;
input Subject Trt $ Y0 Y1 @@;
cards;
1  Placebo 5.36 4.64 2  Placebo 5.10 4.70 3  Placebo 5.49 5.42 
4  Placebo 6.04 5.45 5  Placebo 5.36 5.65 6  Placebo 5.07 4.55 
7  Placebo 4.99 4.52 8  Placebo 4.61 5.53 9  Placebo 5.67 5.82 
10 Placebo 5.45 5.36 1  Drug    5.35 5.62 2  Drug    5.39 5.07 
3  Drug    4.28 5.23 4  Drug    5.48 5.09 5  Drug    5.51 6.83 
6  Drug    4.23 5.37 7  Drug    5.33 5.72 8  Drug    4.50 4.67 
9  Drug    5.90 6.24 10 Drug    5.37 6.21                      
;
/* Center the baseline covariate */
%macro X0(data=_last_);
	proc means data=&data nway noprint;
	 where Yd>.;
	 var Y0;
	 output out=basemean mean=MeanY0;
	run;
	data &data;
	 set &data;
	 if _n_=1 then set basemean;
	run;
	data &data;
	 set &data;
	 X0 = Y0 - MeanY0; ** Centered covariate; 
	run;
%mend X0;


/*----------------------------*/                    
/*--- Code for Table 6.4   ---*/    
/*----------------------------*/

/* Part 1: ANCOVA based on complete data */
data complete;
 length Type $8;
 set RM_ANCOVA;
 Type='Complete'; ** Type of data;
 Yd = Y1-Y0;      ** Change from baseline; 
run;
%X0(data=complete);
proc sort data=complete;
 by Trt Subject;
run; 
ods output Estimates=est_Complete_REML;
ods select Estimates;
proc mixed data=complete;
 class Trt Subject;
 model Yd = Trt X0 /solution;
 lsmeans Trt / diff;
 estimate 'Trt Effect' Trt 1 -1;
run;

/* Part 2: ANCOVA based on incomplete MAR data */
data MAR;
 length Type $8;
 set RM_ANCOVA;
 Type='MAR     ';
 if Y0 >5.6 then Y1=.; 
 Yd = Y1-Y0;                 
 r1=1;  ** Response indicator variable at week 4;
 if Yd=. then r1=0;
run;
%X0(data=MAR);
proc sort data=MAR;
 by Trt Subject;
run; 
ods output Estimates=est_MAR_REML;
ods select Estimates;
proc mixed data=MAR;
 class Trt Subject;
 model Yd = Trt X0 /solution;
 estimate 'Trt Effect' Trt 1 -1;
run;

/* Part 3: MI ANCOVA based on incomplete MAR data   */
/* Create datasets with imputed missing data        */
proc mi data=MAR seed=8957565 nimpute=15
        out=MI_out;
 by Trt;
 mcmc chain=multiple displayinit initial=em(itprint);
 var Y0 Y1;
run;
data MI_out;
 set MI_out;
 Yd = Y1-Y0;
 drop X0 MeanY0;
run;
%X0(data=MI_out);
proc sort data=MI_out;
 by _Imputation_ Trt Subject;
run;
ods output Estimates=est_MI;
ods select Estimates;
proc mixed data=MI_out;
 by _Imputation_;
 class Trt Subject;
 model Yd = Trt X0 /solution;
 estimate 'Trt Effect' Trt 1 -1;
run;
ods output ParameterEstimates=est_MAR_MI;
ods select ParameterEstimates;
proc mianalyze data=est_MI;
 modeleffects Estimate;
 stderr StdErr;
run; 

/* Part 4: IPW ANCOVA based on incomplete MAR data    */
/* Compute Prob(r1=0) for IPW approach to missingness */
proc logistic data=MAR;
 class Trt;
 model r1(desc) = Trt / link=logit;
 output out=prob_out pred=pi1;
run;
data prob_out;
 set prob_out;
 IPW = r1/pi1;
 zscore = (5.6-5.0)/0.5;
 _pi1_ = probnorm(zscore); ** True Pr(Y0<=5.6)=Pr(r1=1|Y0); 
 IPW_true = r1/_pi1_;
run;
ods output Estimates=est_MAR_IPW;
ods select Estimates;
proc mixed data=prob_out;
 class Trt Subject;
 model Yd = Trt X0 /solution;
 weight IPW;
 estimate 'Trt Effect' Trt 1 -1;
 title 'IPW estimate under MAR';
run;
ods output Estimates=est_MAR_IPW_true;
ods select Estimates;
proc mixed data=prob_out;
 class Trt Subject;
 model Yd = Trt X0 /solution;
 weight IPW_true;
 estimate 'Trt Effect' Trt 1 -1;
 title 'True IPW under MAR';
run;

/* Compile results from the different methods & print */
data MARestimates;
set est_Complete_REML(in=a) est_MAR_REML(in=b) 
    est_MAR_MI(in=c)   est_MAR_IPW(in=d) 
    est_MAR_IPW_true(in=e);  
 if a then Method="Complete Data ANCOVA          ";
 if b then Method="Available Case ANCOVA         ";
 if c then Method="MI-based ANCOVA               ";
 if d then Method="IPW (Estimated Weights) ANCOVA";
 if e then Method="IPW (True Weights) ANCOVA     ";
run;
proc print data=MARestimates noobs split='*';
 var Method Estimate StdErr DF tValue Probt;
run;



/*===================================================================*/
/*=== Example 6.5.4. A repeated measures ANCOVA - continued       ===*/
/*===================================================================*/

/*----------------------------*/                    
/*--- Code for Table 6.5   ---*/    
/*----------------------------*/

/* Part 5: ANCOVA based on incomplete MNAR data */
data MNAR;
 length Type $8;
 set RM_ANCOVA;
 Type='MNAR    ';
 Yd = Y1-Y0;                 
 if Yd >1.0 then do;
  Y1=.;Yd=.;
 end; 
 r1=1;  ** Response indicator variable at week 4;
 if Yd=. then r1=0;
run;
%X0(data=MNAR);
proc sort data=MNAR;
 by Trt Subject;
run; 
proc print data=MNAR;
run;
data LOCF;
 set MNAR;
 by Trt Subject;
 if Yd = . then Yd=0;
 drop X0 MeanY0;
run;
%X0(data=LOCF);
/* Fit available-case ANCOVA and LOCF ANCOVA */ 
ods output Estimates=est_MNAR_REML;
ods select Estimates;
proc mixed data=MNAR;
 class Trt Subject;
 model Yd = Trt X0 /solution;
 lsmeans Trt / diff;
 estimate 'Trt Effect' Trt 1 -1;
 title 'MNAR: Trt Effect under MAR'; 
run;
ods output Estimates=est_LOCF_REML;
ods select Estimates;
proc mixed data=LOCF;
 class Trt Subject;
 model Yd = Trt X0 /solution;
 lsmeans Trt / diff;
 estimate 'Trt Effect' Trt 1 -1;
 title 'MNAR: Trt Effect under LOCF'; 
run;

/* Part 6: PMM ANCOVA based on incomplete MNAR data   */
/* Pattern Mixture Model(PMM) for sensitivity analysis*/ 
data MNAR_sensitivity;
 set MNAR;
 do Delta = -1 to 1 by .25;
 output;
 end;
run;
data MNAR_sensitivity;
 set MNAR_sensitivity;
 ind=1; response=r1; output;
 ind=0; response=Yd; output;
run;
data MNAR_sensitivity;
 set MNAR_sensitivity;
 if ind=1 and Trt='Placebo' then delete;
 if ind=1 and Yd=. then Yd=0;
run;
proc sort data=MNAR_sensitivity;
 by Delta ind Trt Subject;
run;
ods output additionalestimates=ae;
ods select additionalestimates;
proc nlmixed data=MNAR_sensitivity df=15;
 by Delta;
 parms Beta0=2.0131 Beta_d=0.3848 Beta=-0.4071
       eta0=1;
 SigmaSq=0.2194; ** REML estimate from PROC MIXED;
 PredMean = Beta0 + Beta_d*(Trt="Drug") + Beta*X0; 
 linpred = eta0;
 p1 = 1/(1+exp(-linpred));
 ll_r = r1*log(p1) + (1-r1)*log(1-p1);
 ll_Y = (- 0.5*log(2*CONSTANT('PI'))
         - 0.5*((Yd - PredMean)**2)/SigmaSq 
         - 0.5*log(SigmaSq));
 ll = ll_r*ind + ll_Y*(1-ind);
 Trt_Effect = p1*Beta_d + (1-p1)*(Beta_d+Delta);
 Trt_Effect_Unadj = 0.80*Beta_d + 0.20*(Beta_d+Delta);
 model response ~ General(ll);
 estimate "Trt Effect (Adjusted SE)"   Trt_Effect;
 estimate "Trt Effect (Unadjusted SE)" Trt_Effect_Unadj;
run;
proc print data=ae noobs;
 title "PMM with adjusted and unadjusted standard errors";
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

