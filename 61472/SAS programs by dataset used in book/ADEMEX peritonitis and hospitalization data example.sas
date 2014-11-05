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
/*=== Example 4.3.1. ADEMEX peritonitis infection data            ===*/
/*===================================================================*/

data example4_3_1;
 set SASdata.ADEMEX_Peritonitis_Data;
 log_time=log(MonthsAtRisk); ** Offset;
run;


/*----------------------------*/                    
/*--- Code for Output 4.1  ---*/    
/*----------------------------*/   
proc print data=example4_3_1(obs=10) noobs;
 var ptid Trt Age Sex Diabetic Albumin 
     PriorMonths MonthsAtRisk Episodes Hosp;   
run;


/*----------------------------*/                    
/*--- Code for Output 4.2  ---*/    
/*----------------------------*/   
ods output LSMeans=lsout_P;
ods output LSMeanDiffs=lsdiff_P;
ods exclude ConvergenceStatus ParmInfo LSMeans LSMeanDiffs; 
proc genmod data=example4_3_1;
  class Trt;
  model  Episodes=Trt Sex Age Diabetic Albumin PriorMonths
       / dist=Poisson link=log offset=log_time type3 ;
  lsmeans Trt /diff cl;
run;


/*----------------------------*/                    
/*--- Code for Output 4.3  ---*/    
/*----------------------------*/   
ods output LSMeans=lsout_NB;
ods output LSMeanDiffs=lsdiff_NB;
ods select ModelInfo Modelfit
           ParameterEstimates Type3; 
proc genmod data=example4_3_1;
  class Trt;
  model  Episodes=Trt Sex Age Diabetic Albumin PriorMonths
       / dist=NegBin link=log offset=log_time type3;
  lsmeans Trt /diff cl;
run;


/*----------------------------*/                    
/*--- Code for Output 4.4  ---*/    
/*----------------------------*/   
data lsout;
 set lsout_NB;
 Rate = exp(LBeta)*12;
run;
data lsdiff;
 set lsdiff_NB;
 RR = exp(-estimate);
 RR_lower = exp(-UpperCL);
 RR_upper = exp(-LowerCL);
 p=ProbChiSq;
 Trt='1';
run;
proc sort data=lsdiff;
 by Trt;
run;
proc sort data=lsout;
 by Trt;
run;
data summary;
 merge lsout lsdiff;
 by Trt;
run;
proc format;
 value $_trtfmt_ '0'='Control' '1'='Treated';
run;
proc print data=summary split='|' noobs;
 var Trt Rate RR RR_lower RR_upper p;
 label Rate='Peritonitis|(Episodes/Year)'
         RR='Rate Ratio|(Treated:Control)'
   RR_Lower='Lower|95% CL'
   RR_Upper='Upper|95% CL'
   p='p-value';
 format Trt $_trtfmt_.;
run;


/*===================================================================*/
/*=== Example 5.2.4. ADEMEX hospitalization data                  ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\GLIMMIX_GOF.sas' /nosource2;

data example4_3_1;
 set SASdata.ADEMEX_Peritonitis_Data;
 log_time=log(MonthsAtRisk); ** Offset;
run;


/*----------------------------*/                    
/*--- Code for Output 5.13 ---*/    
/*----------------------------*/
ods output LSMeans=lsout_P;
ods output LSMeanDiffs=lsdiff_P;
ods select ModelInfo Modelfit
           ParameterEstimates Type3; 
proc genmod data=example4_3_1;
  class Trt;
  model  Hosp=Trt Sex Age Diabetic PriorMonths Albumin
       / dist=Poisson link=log offset=log_time pscale type3 ;
  lsmeans Trt /diff cl;
run;
data lsout;
 set lsout_P;
 Rate = exp(LBeta)*12;
run;
data lsdiff;
 set lsdiff_P;
 RR = exp(-estimate);
 RR_lower = exp(-UpperCL);
 RR_upper = exp(-LowerCL);
 p=ProbChiSq;
 Trt='1';
run;
proc sort data=lsdiff;
 by Trt;
run;
proc sort data=lsout;
 by Trt;
run;
data summary;
 merge lsout lsdiff;
 by Trt;
run;
proc format;
 value $_trtfmt_ '0'='Control' '1'='Treated';
run;
proc print data=summary split='|' noobs;
 var Trt Rate RR RR_lower RR_upper p;
 label Rate='Hospitalization|Rate|(Admissions/Year)'
       RR='Rate Ratio|(Trt:Cntrl)'
       RR_Lower='Lower|95% CL'
       RR_Upper='Upper|95% CL'
       p='p-value';
 format Trt $_trtfmt_.;
run;

/*----------------------------*/                    
/*--- Code for Output 5.14 ---*/    
/*----------------------------*/
data example5_2_4; 
 set SASdata.ADEMEX_Peritonitis_Data;
 log_time=log(MonthsAtRisk); ** Offset;
 Center=scan(ptid, 1);
run;
proc sort data=example5_2_4;
 by Center ptid;
run;
ods select ModelInfo FitStatistics CondFitStatistics
           CovParms CovTests ParameterEstimates Tests3; 
ods output LSMeans = LSmeans;
ods output Diffs = LSdiffs;
ods output CovBDetails=gof;
ods output ParameterEstimates=pe;
ods output CovParms=cov;
ods output dimensions=n;
proc glimmix data=example5_2_4 noclprint=3 order=formatted
                           method=Quad maxopt=50 empirical;
  class Center Trt;
  model  Hosp=Trt Sex Age Diabetic PriorMonths Albumin
       / dist=Poisson link=log offset=log_time s covb(details);
  lsmeans Trt /diff cl ilink;
  random intercept / subject=Center type=vc;
  covtest ZeroG;
  output out=pred /allstats;
run;
data lsout;
 set LSmeans;
 Rate = exp(estimate)*12;
run;
data lsdiff;
 set LSdiffs;
 RR = exp(-estimate);
 RR_lower = exp(-Upper);
 RR_upper = exp(-Lower);
 p=Probt;
 Trt='1';
run;
proc sort data=lsdiff;
 by Trt;
run;
proc sort data=lsout;
 by Trt;
run;
data summary;
 merge lsout lsdiff;
 by Trt;
run;
proc format;
 value _trtfmt_ 0='Control' 1='Treated';
run;
proc print data=summary split='|' noobs;
 var Trt Rate RR RR_lower RR_upper p;
 label Rate='Hospitalization|Rate|(Admissions/Year)'
       RR='Rate Ratio|(Trt:Cntrl)'
       RR_Lower='Lower|95% CL'
       RR_Upper='Upper|95% CL'
       p='p-value';
 format Trt _trtfmt_.;
run;


/*----------------------------*/                    
/*--- Code for Output 5.15 ---*/    
/*----------------------------*/
%GLIMMIX_GOF(dimension=n, 
             parms=pe,
             covb_gof=gof,
             output=pred,
             response=HOSP,
             pred_ind=PredMu, 
             pred_avg=PredMuPA, 
             printopt=NOPRINT);
proc print data=_fitting noobs;
run;


/*----------------------------*/                    
/*--- Code for Output 5.16 ---*/    
/*----------------------------*/

/*----------------------------------------------------*/
/* Because we include a random effect at the patient  */
/* level and center level, the default denominator DF */
/* becomes 0 and no t-tests etc. are produced. To get */
/* z-tests and chi-square tests, one must specify the */
/* model option DDFM=NONE as indicated below.         */
/*----------------------------------------------------*/
ods select ModelInfo FitStatistics CondFitStatistics
           CovParms CovTests ParameterEstimates Tests3; 
ods output LSMeans = LSmeans;
ods output Diffs = LSdiffs;
ods output CovBDetails=gof;
ods output ParameterEstimates=pe;
ods output CovParms=cov;
ods output Dimensions=n;
proc glimmix data=example5_2_4 noclprint=3 order=formatted
                           method=Laplace maxopt=50 empirical;
  class Center ptid Trt;
  model  Hosp=Trt Sex Age Diabetic PriorMonths Albumin
       / dist=Poisson link=log offset=log_time s covb(details) 
         chisq ddfm=none;
  lsmeans Trt /diff cl ilink;
  random intercept / subject=Center type=vc;
  random intercept / subject=ptid(Center) type=vc;
  covtest 'No Center effect' 0 .;
  covtest 'No ptid(Center) effect' . 0;
  covtest ZeroG;
  output out=pred /allstats;
run;
data lsout;
 set LSmeans;
 Rate = exp(estimate)*12;
run;
data lsdiff;
 set LSdiffs;
 RR = exp(-estimate);
 RR_lower = exp(-Upper);
 RR_upper = exp(-Lower);
 p=Probt;
 Trt='1';
run;
proc sort data=lsdiff;
 by Trt;
run;
proc sort data=lsout;
 by Trt;
run;
data summary;
 merge lsout lsdiff;
 by Trt;
run;
proc print data=summary split='|' noobs;
 var Trt Rate RR RR_lower RR_upper p;
 label Rate='Hospitalization|Rate|(Admissions/Year)'
       RR='Rate Ratio|(Trt:Cntrl)'
       RR_Lower='Lower|95% CL'
       RR_Upper='Upper|95% CL'
       p='p-value';
 format Trt _trtfmt_.;
run;


/*----------------------------*/                    
/*--- Code for Output 5.17 ---*/    
/*----------------------------*/
%GLIMMIX_GOF(dimension=n, 
             parms=pe,
             covb_gof=gof,
             output=pred,
             response=HOSP,
             pred_ind=PredMu, 
             pred_avg=PredMuPA, 
             printopt=NOPRINT);
proc print data=_fitting noobs;run;


/*----------------------------*/                    
/*--- Code for Output 5.18 ---*/    
/*----------------------------*/
ods select ModelInfo FitStatistics CondFitStatistics
           CovParms CovTests ParameterEstimates Tests3; 
ods output LSMeans = LSmeans;
ods output Diffs = LSdiffs;
ods output CovBDetails=gof;
ods output ParameterEstimates=pe;
ods output CovParms=cov;
ods output dimensions=n;
proc glimmix data=example5_2_4 noclprint=3 order=formatted
                           method=Quad maxopt=50 empirical;
  class Center Trt;
  model  Hosp=Trt Sex Age Diabetic PriorMonths Albumin
       / dist=NB link=log offset=log_time s covb(details);
  lsmeans Trt /diff cl ilink;
  random intercept / subject=Center type=vc;
  covtest ZeroG;
  output out=pred /allstats;
run;
data lsout;
 set LSmeans;
 Rate = exp(estimate)*12;
run;
data lsdiff;
 set LSdiffs;
 RR = exp(-estimate);
 RR_lower = exp(-Upper);
 RR_upper = exp(-Lower);
 p=Probt;
 Trt='1';
run;
proc sort data=lsdiff;
 by Trt;
run;
proc sort data=lsout;
 by Trt;
run;
data summary;
 merge lsout lsdiff;
 by Trt;
run;
proc print data=summary split='|' noobs;
 var Trt Rate RR RR_lower RR_upper p;
 label Rate='Hospitalization|Rate|(Admissions/Year)'
       RR='Rate Ratio|(Trt:Cntrl)'
       RR_Lower='Lower|95% CL'
       RR_Upper='Upper|95% CL'
       p='p-value';
 format Trt _trtfmt_.;
run;


/*----------------------------*/                    
/*--- Code for Output 5.19 ---*/    
/*----------------------------*/
%GLIMMIX_GOF(dimension=n, 
             parms=pe,
             covb_gof=gof,
             output=pred,
             response=HOSP,
             pred_ind=PredMu, 
             pred_avg=PredMuPA, 
			 opt=noprint,
             printopt=NOPRINT);
proc print data=_fitting;run;


/*===================================================================*/
/*=== Example 7.1.1. ADEMEX peritonitis and hospitalization data  ===*/
/*===================================================================*/

/*----------------------------*/                    
/*--- Code for Output 7.1  ---*/    
/*----------------------------*/
data example7_1_1;
 set SASdata.ADEMEX_Peritonitis_Data;
 log_time=log(MonthsAtRisk); ** Offset;
 Center=scan(ptid, 1);
run;
proc sort data=example7_1_1;
 by ptid;
run; 
ods listing close;
ods output parameterestimates=pe1;
proc genmod data=example7_1_1;
  model Episodes=Trt Sex Age Diabetic Albumin PriorMonths 
       / dist=NB link=log offset=log_time;
run;
ods output parameterestimates=pe2;
proc genmod data=example7_1_1;
  model Hosp=Trt Sex Age Diabetic Albumin PriorMonths
       / dist=Poisson link=log offset=log_time;
run; ods listing;
data pe1;
 length Parameter $16; 
 set pe1;
 length Parameter $16; 
 Parameter=compress('eta_'||left(Parameter));
 if Parameter='eta_Dispersion' then Parameter='alpha';
run; 
data pe2;
 length Parameter $16; 
 set pe2;
 length Parameter $16; 
 Parameter=compress('beta_'||left(Parameter));
 if Parameter='beta_Scale' then delete;
run; 
data peINITIAL;
 set pe1 pe2;
run;
/*=========================================================
  Fit a joint model to peritonitis (gamma-Poisson model) 
  and hospitalization (Poisson model) data assuming the
  two sets of count data are independently distributed. 
==========================================================*/
data example7_1_1_SP;
 set example7_1_1;
 response=hosp;    ind=0;output;
 response=episodes;ind=1;output;
run;
proc sort data=example7_1_1_SP;
 by ind ptid;
run;
ods output ParameterEstimates=SAStemp.peJOINT;
ods select Specifications Dimensions IterHistory
           ConvergenceStatus FitStatistics ParameterEstimates;
proc nlmixed data=example7_1_1_SP method=Gauss 
             tech=newrap noad qpoints=20;
 parms /data=peINITIAL;
 ui = CDF('NORMAL',zi);
 if ui>0.999999 then ui=0.999999;
 /*========================================================
 -alpha is the negative binomial dispersion parameter  
  in GENMOD (see equations 5.43-5.46 for a derivation) 
 -gi~G(1/alpha, 1/alpha) has the gamma distribution as 
  defined by the pdf (7.7) with E(gi)=1 Var(gi)=alpha 
 -bi is log-gamma distributed (Nelson et. al., 2006)   
 =========================================================*/
 gi1 = quantile('GAMMA', ui, 1/alpha); 
 gi = alpha*gi1; 
 bi = log(gi);
 /* Define conditional mean count for peritonitis data    */
 x_eta = eta_Intercept + eta_Trt*Trt + eta_Sex*Sex + 
         eta_Age*Age + eta_Diabetic*Diabetic +
         eta_Albumin*Albumin + eta_PriorMonths*PriorMonths + 
         log_time; 
 mu1_i = exp(x_eta + bi);
 /* Define the marginal mean for hospitalization data     */
 x_beta = beta_Intercept + beta_Trt*Trt + beta_Sex*Sex + 
          beta_Age*Age + beta_Diabetic*Diabetic +
          beta_Albumin*Albumin + beta_PriorMonths*PriorMonths +
          log_time; 
 mu2_i = exp(x_beta);
 /*========================================================
  Define the numerator of the Poisson overdispersion      
  parameter phi as defined in equation (4.6) of Ch. 4     
  for the hospitalization data                            
 =========================================================*/
 phi_num = (((response-mu2_i)**2)/mu2_i)*(ind=0);
 /*========================================================
  Define the joint independent means for y1i and y2i    
  where y1i is the number of episodes of peritonitis    
  (response=Episodes) and y2i is the number of hospital 
  admissions (response=Hosp) from the ADEMEX dataset.   
 =========================================================*/
 mu = mu1_i*(ind=1) + mu2_i*(ind=0);
 model response ~ Poisson(mu);
 random zi ~ N(0,1) subject=ptid;
 id mu1_i mu2_i phi_num ;
 predict mu2_i out=pred;
run;
 
/*=========================================================
 Calculate the Poisson overdispersion parameter and 
 associated scale (square root) parameter as a means 
 for assessing model goodness-of-fit with respect to 
 the hospitalization data       
 ==========================================================*/
proc means data=pred sum noprint;
 where ind=0;
 var phi_num; 
 output out=phi n=n sum=phi_num;
run;
data phi; set phi;
 phi = phi_num/(n-7);
 Scale = sqrt(phi);
run;
proc print data=phi noobs split='|';
 var phi Scale;
 label phi='Poisson overdispersion estimate (phi)'
       Scale='Poisson scale parameter';
run; 


/*----------------------------*/                    
/*--- Code for Output 7.2  ---*/    
/*----------------------------*/
data pe_bi;
 Parameter='beta_bi';estimate=0.5;
run;
data peJOINT1;
 set SAStemp.peJOINT pe_bi;
run;
ods select Specifications Dimensions IterHistory
           ConvergenceStatus FitStatistics ParameterEstimates;
proc nlmixed data=example7_1_1_SP method=Gauss 
             tech=newrap noad qpoints=20;
 parms /data=peJOINT1;
 ui = CDF('NORMAL',zi);
 if ui>0.999999 then ui=0.999999;
 /*========================================================
 -alpha is the negative binomial dispersion parameter  
  in GENMOD (see equations 5.43-5.46 for a derivation) 
 -gi~G(1/alpha, 1/alpha) has the gamma distribution as 
  defined by the pdf (7.7) with E(gi)=1 Var(gi)=alpha 
 -bi is log-gamma distributed (Nelson et. al., 2006)   
 =========================================================*/
 gi1 = quantile('GAMMA', ui, 1/alpha); 
 gi = alpha*gi1; 
 bi = log(gi);
 /* Define conditional mean count for peritonitis data    */
 x_eta = eta_Intercept + eta_Trt*Trt + eta_Sex*Sex + 
         eta_Age*Age + eta_Diabetic*Diabetic +
         eta_Albumin*Albumin + eta_PriorMonths*PriorMonths + 
         log_time; 
 mu1_i = exp(x_eta + bi);
 /* Define the marginal mean for hospitalization data     */
 x_beta = beta_Intercept + beta_Trt*Trt + beta_Sex*Sex + 
          beta_Age*Age + beta_Diabetic*Diabetic +
          beta_Albumin*Albumin + beta_PriorMonths*PriorMonths +
          log_time; 
 mu2_i = exp(x_beta + beta_bi*bi);
 /*========================================================
  Define the numerator of the Poisson overdispersion      
  parameter phi as defined in equation (4.6) of Ch. 4     
  for the hospitalization data                            
 =========================================================*/
 phi_num = (((response-mu2_i)**2)/mu2_i)*(ind=0);
 /*========================================================
  Define the joint independent means for y1i and y2i    
  where y1i is the number of episodes of peritonitis    
  (response=Episodes) and y2i is the number of hospital 
  admissions (response=Hosp) from the ADEMEX dataset.   
 =========================================================*/
 mu = mu1_i*(ind=1) + mu2_i*(ind=0);
 model response ~ Poisson(mu);
 random zi ~ N(0,1) subject=ptid;
 id mu1_i mu2_i phi_num;
 predict mu2_i out=pred1;
 title 'SP model for peritonitis (gamma-Poisson RE model) and hospitalization (Poisson with random rate as covariate)';
run;

/*=========================================================
 Calculate the conditional Poisson overdispersion parameter  
 and associated scale (square root) parameter as a means 
 for assessing model goodness-of-fit with respect to 
 the hospitalization data under the SP model      
 ==========================================================*/
proc means data=pred1 sum noprint;
 where ind=0;
 var phi_num; 
 output out=phi1 n=n sum=phi_num;
run;
data phi1; set phi1;
 phi = phi_num/(n-7);
 Scale = sqrt(phi);
run;
proc print data=phi1 noobs split='|';
 var phi Scale;
 label phi='Conditional Poisson overdispersion (phi)'
       Scale='Conditional Poisson scale';
run; 


/*==============================================================*/
/* Note: This alternative code gives same estimates as in       */
/*       Output 7.1 (first call to NLMIXED above), but it also  */
/*       provides lower DF because we do not use 2N but N obs   */
/*       and subsequently we do get a slightly different BIC    */
/*       value and we also get slightly different p-values.     */
/*       This alternative code is not referenced within the     */
/*       book but is included here for future reference as it   */ 
/*       provides a far more efficient estimation procedure.    */ 
/*==============================================================*/
proc nlmixed data=example7_1_1 method=Gauss 
             tech=newrap noad qpoints=20;
 parms /data=peINITIAL;
 ui = CDF('NORMAL',zi);
 if ui>0.999999 then ui=0.999999;
 /*========================================================
 -alpha is the negative binomial dispersion parameter  
  in GENMOD (see equations 5.43-5.46 for a derivation) 
 -gi~G(1/alpha, 1/alpha) has the gamma distribution as 
  defined by the pdf (7.7) with E(gi)=1 Var(gi)=alpha 
 -bi is log-gamma distributed (Nelson et. al., 2006)   
 =========================================================*/
 gi1 = quantile('GAMMA', ui, 1/alpha); 
 gi = alpha*gi1; 
 bi = log(gi);
 /* Define conditional mean count for peritonitis data    */
 x_eta = eta_Intercept + eta_Trt*Trt + eta_Sex*Sex + 
         eta_Age*Age + eta_Diabetic*Diabetic +
         eta_Albumin*Albumin + eta_PriorMonths*PriorMonths + 
         log_time; 
 mu1_i = exp(x_eta + bi);
 /* Define the marginal mean for hospitalization data     */
 x_beta = beta_Intercept + beta_Trt*Trt + beta_Sex*Sex + 
          beta_Age*Age + beta_Diabetic*Diabetic +
          beta_Albumin*Albumin + beta_PriorMonths*PriorMonths +
          log_time; 
 mu2_i = exp(x_beta);
 ll_1 = episodes*log(mu1_i) - lgamma(episodes+1) - mu1_i;
 ll_2 = hosp*log(mu2_i) - lgamma(hosp+1) - mu2_i;
 ll = ll_1 + ll_2;
 /*========================================================
  Define the joint independent means for y1i and y2i    
  where y1i is the number of episodes of peritonitis    
  (response=Episodes) and y2i is the number of hospital 
  admissions (response=Hosp) from the ADEMEX dataset.   
 =========================================================*/
 model hosp ~ general(ll);
 random zi ~ N(0,1) subject=ptid;
 id mu1_i mu2_i ll_1 ll_2 ll;
 title 'Joint model for peritonitis (Neg. Bin. - Output 4.3) and hospitalization (fixed Poisson - Output 5.13)';
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

