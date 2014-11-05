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
/*=== Example 4.3.2. Respiratory disorder data                    ===*/
/*===================================================================*/

data resp; 
   input Center ID Treatment $ Sex $ Age Baseline visit1-visit4; 
   datalines; 
1  1 P M 46 0 0 0 0 0 
1  2 P M 28 0 0 0 0 0 
1  3 A M 23 1 1 1 1 1 
1  4 P M 44 1 1 1 1 0 
1  5 P F 13 1 1 1 1 1 
1  6 A M 34 0 0 0 0 0 
1  7 P M 43 0 1 0 1 1 
1  8 A M 28 0 0 0 0 0 
1  9 A M 31 1 1 1 1 1 
1 10 P M 37 1 0 1 1 0 
1 11 A M 30 1 1 1 1 1 
1 12 A M 14 0 1 1 1 0 
1 13 P M 23 1 1 0 0 0 
1 14 P M 30 0 0 0 0 0 
1 15 P M 20 1 1 1 1 1 
1 16 A M 22 0 0 0 0 1 
1 17 P M 25 0 0 0 0 0 
1 18 A F 47 0 0 1 1 1 
1 19 P F 31 0 0 0 0 0 
1 20 A M 20 1 1 0 1 0 
1 21 A M 26 0 1 0 1 0 
1 22 A M 46 1 1 1 1 1 
1 23 A M 32 1 1 1 1 1 
1 24 A M 48 0 1 0 0 0 
1 25 P F 35 0 0 0 0 0 
1 26 A M 26 0 0 0 0 0 
1 27 P M 23 1 1 0 1 1 
1 28 P F 36 0 1 1 0 0 
1 29 P M 19 0 1 1 0 0 
1 30 A M 28 0 0 0 0 0 
1 31 P M 37 0 0 0 0 0 
1 32 A M 23 0 1 1 1 1 
1 33 A M 30 1 1 1 1 0 
1 34 P M 15 0 0 1 1 0 
1 35 A M 26 0 0 0 1 0 
1 36 P F 45 0 0 0 0 0 
1 37 A M 31 0 0 1 0 0 
1 38 A M 50 0 0 0 0 0 
1 39 P M 28 0 0 0 0 0 
1 40 P M 26 0 0 0 0 0 
1 41 P M 14 0 0 0 0 1 
1 42 A M 31 0 0 1 0 0 
1 43 P M 13 1 1 1 1 1 
1 44 P M 27 0 0 0 0 0 
1 45 P M 26 0 1 0 1 1 
1 46 P M 49 0 0 0 0 0 
1 47 P M 63 0 0 0 0 0 
1 48 A M 57 1 1 1 1 1 
1 49 P M 27 1 1 1 1 1 
1 50 A M 22 0 0 1 1 1 
1 51 A M 15 0 0 1 1 1 
1 52 P M 43 0 0 0 1 0 
1 53 A F 32 0 0 0 1 0 
1 54 A M 11 1 1 1 1 0 
1 55 P M 24 1 1 1 1 1 
1 56 A M 25 0 1 1 0 1 
2  1 P F 39 0 0 0 0 0 
2  2 A M 25 0 0 1 1 1 
2  3 A M 58 1 1 1 1 1 
2  4 P F 51 1 1 0 1 1 
2  5 P F 32 1 0 0 1 1 
2  6 P M 45 1 1 0 0 0 
2  7 P F 44 1 1 1 1 1 
2  8 P F 48 0 0 0 0 0 
2  9 A M 26 0 1 1 1 1 
2 10 A M 14 0 1 1 1 1 
2 11 P F 48 0 0 0 0 0 
2 12 A M 13 1 1 1 1 1 
2 13 P M 20 0 1 1 1 1 
2 14 A M 37 1 1 0 0 1 
2 15 A M 25 1 1 1 1 1 
2 16 A M 20 0 0 0 0 0 
2 17 P F 58 0 1 0 0 0 
2 18 P M 38 1 1 0 0 0 
2 19 A M 55 1 1 1 1 1 
2 20 A M 24 1 1 1 1 1 
2 21 P F 36 1 1 0 0 1 
2 22 P M 36 0 1 1 1 1 
2 23 A F 60 1 1 1 1 1 
2 24 P M 15 1 0 0 1 1 
2 25 A M 25 1 1 1 1 0 
2 26 A M 35 1 1 1 1 1 
2 27 A M 19 1 1 0 1 1 
2 28 P F 31 1 1 1 1 1 
2 29 A M 21 1 1 1 1 1 
2 30 A F 37 0 1 1 1 1 
2 31 P M 52 0 1 1 1 1 
2 32 A M 55 0 0 1 1 0 
2 33 P M 19 1 0 0 1 1 
2 34 P M 20 1 0 1 1 1 
2 35 P M 42 1 0 0 0 0 
2 36 A M 41 1 1 1 1 1 
2 37 A M 52 0 0 0 0 0 
2 38 P F 47 0 1 1 0 1 
2 39 P M 11 1 1 1 1 1 
2 40 P M 14 0 0 0 1 0 
2 41 P M 15 1 1 1 1 1 
2 42 P M 66 1 1 1 1 1 
2 43 A M 34 0 1 1 0 1 
2 44 P M 43 0 0 0 0 0 
2 45 P M 33 1 1 1 0 1 
2 46 P M 48 1 1 0 0 0 
2 47 A M 20 0 1 1 1 1 
2 48 P F 39 1 0 1 0 0 
2 49 A M 28 0 1 0 0 0 
2 50 P F 38 0 0 0 0 0 
2 51 A M 43 1 1 1 1 0 
2 52 A F 39 0 1 1 1 1 
2 53 A M 68 0 1 1 1 1 
2 54 A F 63 1 1 1 1 1 
2 55 A M 31 1 1 1 1 1 
; 
run; 

Data example4_3_2;
 set resp;                 
 y=Visit1; Visit=1; OUTPUT;
 y=Visit2; Visit=2; OUTPUT;
 y=Visit3; Visit=3; OUTPUT;
 y=Visit4; Visit=4; OUTPUT;
run;


/*----------------------------*/                    
/*--- Code for Figure 1.5  ---*/    
/*----------------------------*/   
proc means data=Example4_3_2;
class Treatment Visit;
var y;
output out=p mean=p;
data p;
 set p;
 if Treatment ne ' ';
 label Treatment='Drug';
run;
proc format;
 value $ drugfmt 'A'='Active' 'P'='Placebo';
run;
goptions reset=all device=SASEMF 
         gsfmode=replace handshake=none htext=1.5 ftext=swiss;
footnote;
proc gplot data=p gout=SASgraph.chapterfigures; 
 axis1 label=(A=90 'Proportion with Positive Response') width=2
       minor=none order=0 to 1 by .2 major=(w=2);
 axis2 label=('Visit') order=1 to 4 by 1 width=2
       minor=none major=(w=2);
 plot p*visit=treatment/vaxis=axis1 haxis=axis2 name='Fig1_5';
 symbol1 c=black h=1.5 v=dot    i=join l=1 w=3;
 symbol2 c=black h=1.5 v=square i=join l=2 w=3;
 format treatment $drugfmt.;
 title;
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 4.5  ---*/    
/*----------------------------*/   
proc sort data=example4_3_2;
 by Center ID;
run;
proc print data=example4_3_2(obs=20);
 var Center ID Treatment Sex Age Baseline Visit y; 
run;


/*----------------------------*/                    
/*--- Code for Output 4.6  ---*/    
/*---      and Figure 4.1  ---*/    
/*----------------------------*/   
Data example4_3_2;
 set example4_3_2;
 by Center ID;
 Trt=(Treatment='A');
 Gender=(Sex='F');
 Center_=(Center=2);
 Subject=Compress(Trim(Center_)||'-'||Trim(ID));
 y0=Baseline; 
run;
ods graphics on / imagefmt=SASEMF imagename='Resp_Assess_Test' reset=index;
ods select NObs GEEModInfo GEEFitCriteria GEEModPEst GEEEmpPEst 
           AssessmentSummary CumulativeResiduals; 
proc genmod data=example4_3_2 desc ; 
 class ID Center ; 
 model y = Trt Center_ Gender Age y0 / dist=bin itprint;
 repeated subject=ID(Center) / corr=ind modelse; 
 assess link / resample=1000 seed=60370754 crpanel; 
run; 
ods graphics off;
quit;

 
/*----------------------------*/                    
/*--- Code for Output 4.7  ---*/    
/*----------------------------*/   
%macro ModelCorr(corr=ind);
  ods listing close;
  ods select GEEModInfo GEEFitCriteria LSMeanDiffs;
  ods output GEEModInfo=info;
  ods output GEEFitCriteria=fit;
  ods output LSMeanDiffs=lsdiff; 
  proc genmod data=example4_3_2 desc ; 
   class ID Center Treatment(ref="P"); 
   model y = Treatment Center_ Gender Age y0 / dist=bin;
   repeated subject=ID(Center) / corr=&corr; 
   lsmeans Treatment / diff cl; 
  run; 
  data info; set info;
   if Label1='Correlation Structure';
   Structure=cValue1; keep Structure;
  run;
  data fit; set fit; 
   if Criterion='QIC';
   QIC=Value; keep QIC;
  run;
  data lsdiff;
   set lsdiff;
   OR=exp(estimate);
   OR_LowerCL=exp(LowerCL);
   OR_UpperCL=exp(UpperCL);
   p=ProbChiSq;
   keep OR OR_LowerCL OR_UpperCL p;
  run;
  data _summary_;
   merge info fit lsdiff; 
  run;
  data summary;
   set summary _summary_;
  run; 
  ods listing;
%mend ModelCorr;

Data Summary;
 %ModelCorr(corr=ind);
 %ModelCorr(corr=un);
 %ModelCorr(corr=cs);
 %ModelCorr(corr=mdep(1));
run;

proc print data=Summary split='|';
 id Structure;
 var QIC OR OR_LowerCL OR_UpperCL p;
 label OR='Odds Ratio'
       OR_LowerCL='95% LCL'
       OR_UpperCL='95% UCL'
       p='p-value';
 format OR_LowerCL OR_UpperCL 6.3 p 7.5;
run;


/*===================================================================*/
/*=== Example 4.5.3. Respiratory disorder data = continued        ===*/
/*===================================================================*/

/*----------------------------*/                    
/*--- Code for Output 4.28 ---*/    
/*----------------------------*/
ods output parameterestimates=GEE2pe_ind;
proc nlmixed data=Example4_3_2 empirical;
  parms b0=-0.8561 b1=1.2654 b2=0.6495 b3=0.1368 
        b4=-0.0188 b5=1.8457;
  X_b = b0 + b1*Trt + b2*Center_ + b3*Gender + b4*Age + b5*y0;
  pi = exp(X_b)/(1+exp(X_b));
  Sigma_i = pi*(1-pi);
  Mu_i = pi + u;
  Var_i = Sigma_i;
  model y ~ normal(Mu_i, Var_i);
  random u ~ normal(0, 0) subject=Subject;
run; 


/*----------------------------*/                    
/*--- Code for Output 4.29 ---*/    
/*----------------------------*/
ods output parameterestimates=GEE2pe_cs;
ods select parameterestimates;
proc nlmixed data=Example4_3_2 empirical;
  parms b0=-0.8561 b1=1.2654 b2=0.6495 b3=0.1368 
        b4=-0.0188 b5=1.8457 rho=.327;
  bounds -1<rho<1;
  X_b = b0 + b1*Trt + b2*Center_ + b3*Gender + b4*Age + b5*y0;
  pi = exp(X_b)/(1+exp(X_b));
  Sigma_i = pi*(1-pi);
  Mu_i = pi + sqrt(Sigma_i)*u;
  Var_i = Sigma_i*(1-rho);
  model y ~ normal(Mu_i, Var_i);
  random u ~ normal(0, rho) subject=Subject;
run;
ods output GEEEmpPEst=GEEpe_ind;
ods select GEEEmpPEst;
proc genmod data=Example4_3_2 desc;
 class subject;
 model y = Trt Center_ Gender Age y0 / dist=bin itprint;
 repeated subject=subject / type=ind modelse;
 title 'GEE-based estimates with working independence';
run; 
ods output GEEEmpPEst=GEEpe_cs;
ods output GEEExchCorr=GEEcov_cs;
ods select GEEEmpPEst GEEExchCorr;
proc genmod data=Example4_3_2 desc;
 class subject;
 model y = Trt Center_ Gender Age y0 / dist=bin itprint;
 repeated subject=subject / type=cs modelse corrw;
 title 'GEE-based estimates with working exchangeable correlation';
run;
proc format;
 value $effectf  'b0'='Intercept'
                 'b1'='Trt' 
                 'b2'='Center_' 
                 'b3'='Gender' 
                 'b4'='Age' 
                 'b5'='y0' 
                 'rho'='Rho'
                 'Correlation'='Rho';
run;
data GEEpe_ind;
 set GEEpe_ind;
 length Parm $16;
 Method='GEE     ';
 Structure="1.Independence";
 Effect=Parm;
 StandardError=StdErr;
 Test = Z;
 p=probZ;
 Lower=LowerCL;
 Upper=UpperCL;
 DF=.;
run;
data GEEcov_cs;
 set GEEcov_cs;
 Parm=Label1;
 Estimate=nValue1;
run;
data GEEpe_cs;
 length Parm $16;
 set GEEpe_cs GEEcov_cs;
 Method='GEE     ';
 Structure="2.Exchangeable";
 Effect=Parm;
 StandardError=StdErr;
 Test = Z;
 p=probZ;
 Lower=LowerCL;
 Upper=UpperCL;
 DF=.;
run;
data GEE2pe_ind;
 set GEE2pe_ind;
 Method='GEE2/ELS';
 Structure="1.Independence";
 Test = tValue;
 p=probt;
 Effect=Parameter;
run;
data GEE2pe_cs;
 set GEE2pe_cs;
 Method='GEE2/ELS';
 Structure="2.Exchangeable";
 Test = tValue;
 p=probt;
 Effect=Parameter;
run;
data all;
 length Effect $16;
 set GEEpe_ind GEEpe_cs GEE2pe_ind GEE2pe_cs;
 bys=1;
 if Effect='Correlation' or Effect='rho' then bys=2;
run;
proc sort data=all;
 by Structure Method bys;
run;
proc report data=all  
 HEADLINE HEADSKIP SPLIT='|' nowindows;
 column Structure Effect Method, (Estimate StandardError DF Test p);
 define Structure / GROUP "Correlation|Structure" center WIDTH=16 ;
 define Effect / GROUP "Effect" WIDTH=12 center format=$effectf. order=data;
 define Method / Across "Method of Estimation" 
                    order=internal WIDTH=8;
 define Estimate / MEAN FORMAT=6.3 'Estimate' 
                   width=8 NOZERO spacing=1;
 define StandardError / MEAN FORMAT=6.3 'SE' 
                   width=6 NOZERO center spacing=1;
 define DF / MEAN FORMAT=3.0 'DF' 
                   width=3 NOZERO center spacing=1;
 define Test / MEAN FORMAT=6.3 'Test|Statistic' 
                   width=9 NOZERO center spacing=1;
 define p / MEAN FORMAT=6.3 'p-value' 
                   width=7 NOZERO center spacing=1;
run;
quit;


/*===================================================================*/
/*=== Example 5.2.1. Respiratory disorder data = continued        ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\GLIMMIX_GOF.sas' /nosource2;

/*----------------------------*/                    
/*--- Code for Output 5.1  ---*/    
/*----------------------------*/
proc sort data=example4_3_2 out=example5_2_1;
 by Center ID;
run; 
ods select Dimensions ModelInfo FitStatistics CovParms
           ParameterEstimates;
proc glimmix data=example5_2_1 method=MMPL empirical;
 class ID Center ; 
 model y = Trt Center_ Gender Age y0 / 
           dist=bin solution covb(details);
 random intercept / subject=ID(Center) ;
run; 
quit;


/*----------------------------*/                    
/*--- Code for Output 5.2  ---*/    
/*---      and Output 5.3  ---*/    
/*----------------------------*/
proc format;
 value $methfmt 'mmpl'='1. MMPL'
                'mspl'='2. MSPL'
                'laplace'='3. Laplace'
                'quad'='4. Quad';
run;
/*-----------------------------------------------------------------*/
/* MACRO Run_Model fits a logistic random-effects model in GLIMMIX */
/* KEY: method = specifies the GLIMMIX method of estimation        */
/*      pe     = dataset name for ODS Output ParameterEstimate=    */
/*      cv     = dataset name for ODS Output CovParms=             */
/*      fit    = dataset name for ODS Output FitStatistics=        */
/*      n      = dataset name for ODS Output Dimensions=           */
/*      pred   = dataset name for Output Out=                      */
/*-----------------------------------------------------------------*/
%macro Run_Model(method=mmpl,pe=,cv=,fit=,gof=,n=,pred=);
	ods listing close;
	proc glimmix data=example5_2_1 method=&method empirical;
	 class ID Center ; 
	 model y = Trt Center_ Gender Age y0 / 
               dist=bin solution cl covb(details);
	 random intercept / subject=ID(Center) ;
	 ods output ParameterEstimates=&pe;
	 ods output CovParms=&cv;
	 ods output FitStatistics=&fit;	
	 ods output CovBDetails=&gof;
	 ods output dimensions=&n;
	 output out=&pred /allstats;
	run; 
	quit;
	 data &pe;set &pe;format Method $methfmt.; Method="&method"; 
	 data &cv;set &cv;format Method $methfmt.; Method="&method"; 
	 data &fit;set &fit;format Method $methfmt.; Method="&method"; 
	 data &gof;set &gof;format Method $methfmt.; Method="&method"; 
	 data &n;set &n;format Method $methfmt.; Method="&method"; 
	 data &pred;set &pred;format Method $methfmt.; Method="&method"; 
	run; 
	quit;
	ods listing;
%mend;
%Run_Model(method=mmpl,pe=pe_mmpl,cv=cv_mmpl,fit=fit_mmpl,
           gof=gof_mmpl,n=n_mmpl,pred=pred_mmpl);
%Run_Model(method=mspl,pe=pe_mspl,cv=cv_mspl,fit=fit_mspl,
           gof=gof_mspl,n=n_mspl,pred=pred_mspl);
%Run_Model(method=laplace,pe=pe_lmle,cv=cv_lmle,fit=fit_lmle,
           gof=gof_lmle,n=n_lmle,pred=pred_lmle);
%Run_Model(method=quad,pe=pe_mle,cv=cv_mle,fit=fit_mle,
           gof=gof_mle,n=n_mle,pred=pred_mle );
data pe;
 set pe_mmpl pe_mspl pe_lmle pe_mle;
 if Effect='Trt' then do;
  OR=exp(estimate); LowerOR=exp(Lower); UpperOR=exp(Upper);
 end;
run;
proc report data=pe
 HEADLINE HEADSKIP SPLIT='|' nowindows;
 column Method Effect (Estimate StdErr DF /*tValue*/ Probt /*Lower Upper*/ OR LowerOR UpperOR);
 define Method / GROUP "Method" 
                 order=formated WIDTH=10;
 define Effect / GROUP "Effect" WIDTH=12 center order=data;
 define Estimate / MEAN FORMAT=6.3 'Estimate' 
                   width=8 NOZERO spacing=1;
 define StdErr / MEAN FORMAT=6.3 'SE' 
                 width=6 NOZERO center spacing=1;
 define DF / MEAN FORMAT=3.0 'DF' 
             width=3 NOZERO center spacing=1;
 define probt / MEAN FORMAT=6.4 'p-value' 
                width=7 NOZERO center spacing=1;
 define or / MEAN FORMAT=6.2 'Odds Ratio' 
             width=7 NOZERO center spacing=1;
 define loweror / MEAN FORMAT=6.2 'Odds Ratio Lower CL' 
                  width=7 NOZERO center spacing=1;
 define upperor / MEAN FORMAT=6.2 'Odds Ratio Upper CL' 
                  width=7 NOZERO center spacing=1;
run;
quit;
data cv;
 set cv_mmpl cv_mspl cv_lmle cv_mle;
run;
proc print data=cv;
 id Method;
 var CovParm Subject Estimate StdErr;
run;


/*----------------------------*/                    
/*--- Code for Output 5.4  ---*/    
/*---      and Output 5.5  ---*/    
/*----------------------------*/
%GLIMMIX_GOF(dimension=n_mmpl, 
             parms=pe_mmpl,
             covb_gof=gof_mmpl,
             output=pred_mmpl,
             response=y,
             pred_ind=PredMu, 
             pred_avg=PredMuPA, 
             opt=noprint,
			 format=5.2,
             printopt=noprint);	
data _fitall;
 set _fitting;
 MMPL = Value;
 drop Value;
run;
%GLIMMIX_GOF(dimension=n_mspl, 
             parms=pe_mspl,
             covb_gof=gof_mspl,
             output=pred_mspl,
             response=y,
             pred_ind=PredMu, 
             pred_avg=PredMuPA, 
             opt=noprint);
data _fitall;
 merge _fitting _fitall;
 MSPL = Value;
 drop Value;
run;
%GLIMMIX_GOF(dimension=n_lmle, 
             parms=pe_lmle,
             covb_gof=gof_lmle,
             output=pred_lmle,
             response=y,
             pred_ind=PredMu, 
             pred_avg=PredMuPA, 
             opt=noprint);
data _fitall;
 merge _fitting _fitall;
 Laplace = Value;
 drop Value;
run;
%GLIMMIX_GOF(dimension=n_mle , 
             parms=pe_mle ,
             covb_gof=gof_mle ,
             output=pred_mle ,
             response=y,
             pred_ind=PredMu, 
             pred_avg=PredMuPA, 
             opt=noprint);
data _fitall;
 merge _fitting _fitall;
 Quad  = Value;
 drop Value;
run;
proc print data=_fitall noobs;
run;


/*----------------------------*/                    
/*--- Code for Output 5.6  ---*/    
/*----------------------------*/
ods listing close;
ods output ParameterEstimates=pe;
ods output AdditionalEstimates=ae;
proc nlmixed data=example5_2_1 empirical;
 parms b0=-1.5  b1=2  b2=1 b3=0 b4=0 b5=3 psi=4;
 Pi=Constant('PI');
 c=16*sqrt(3)/(15*Pi);
 A_psi = ((c**2)*psi + 1)**(-1/2);
 logit_pij = b0 + b1*Trt + b2*Center_ + b3*Gender +
                  b4*Age + b5*y0 + bi;
 pij = exp(logit_pij)/(1+exp(logit_pij));
 OddsRatioPA = exp(b1)**A_psi;
 OddsRatioSS = exp(b1);
 LogOddsRatioPA = b1*A_psi;
 LogOddsRatioSS = b1;
 model y ~ binary(pij);
 random bi ~ normal(0,psi) subject=id;
 estimate 'PA OR(Active:Placebo)' OddsRatioPA;
 estimate 'SS OR(Active:Placebo)' OddsRatioSS;
 estimate 'PA Log OR(Active:Placebo) ' LogOddsRatioPA;
 estimate 'SS Log OR(Active:Placebo) ' LogOddsRatioSS;
run;
quit;
data ae;
 set ae;
 output;
 If Label='PA Log OR(Active:Placebo) ' then do;
    Label='Alt. PA OR(Active:Placebo)';
    Estimate=exp(Estimate);
    StandardError=Estimate*StandardError;
    Lower=exp(Lower);
    Upper=exp(Upper);
    output;
 end;
 If Label='SS Log OR(Active:Placebo) ' then do;
    Label='Alt. SS OR(Active:Placebo)';
    Estimate=exp(Estimate);
    StandardError=Estimate*StandardError;
    Lower=exp(Lower);
    Upper=exp(Upper);
	output;
 end;
run;
ods listing;
proc print data=pe noobs;
 var Parameter Estimate StandardError DF Alpha Lower Upper;
 run;
proc print data=ae noobs;
 var Label Estimate StandardError Lower Upper;
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/
