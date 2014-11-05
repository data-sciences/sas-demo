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
/*=== Example 7.2.1. Theophylline data                            ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\covparms.sas' / nosource2;

data theoph; 
    input subject time conc dose wt;
    datalines; 
 1  0.00  0.74 4.02 79.6 
 1  0.25  2.84 4.02 79.6 
 1  0.57  6.57 4.02 79.6 
 1  1.12 10.50 4.02 79.6 
 1  2.02  9.66 4.02 79.6 
 1  3.82  8.58 4.02 79.6 
 1  5.10  8.36 4.02 79.6 
 1  7.03  7.47 4.02 79.6 
 1  9.05  6.89 4.02 79.6 
 1 12.12  5.94 4.02 79.6 
 1 24.37  3.28 4.02 79.6 
 2  0.00  0.00 4.40 72.4 
 2  0.27  1.72 4.40 72.4 
 2  0.52  7.91 4.40 72.4 
 2  1.00  8.31 4.40 72.4 
 2  1.92  8.33 4.40 72.4 
 2  3.50  6.85 4.40 72.4 
 2  5.02  6.08 4.40 72.4 
 2  7.03  5.40 4.40 72.4 
 2  9.00  4.55 4.40 72.4 
 2 12.00  3.01 4.40 72.4 
 2 24.30  0.90 4.40 72.4 
 3  0.00  0.00 4.53 70.5 
 3  0.27  4.40 4.53 70.5 
 3  0.58  6.90 4.53 70.5 
 3  1.02  8.20 4.53 70.5 
 3  2.02  7.80 4.53 70.5 
 3  3.62  7.50 4.53 70.5 
 3  5.08  6.20 4.53 70.5 
 3  7.07  5.30 4.53 70.5 
 3  9.00  4.90 4.53 70.5 
 3 12.15  3.70 4.53 70.5 
 3 24.17  1.05 4.53 70.5 
 4  0.00  0.00 4.40 72.7 
 4  0.35  1.89 4.40 72.7 
 4  0.60  4.60 4.40 72.7 
 4  1.07  8.60 4.40 72.7 
 4  2.13  8.38 4.40 72.7 
 4  3.50  7.54 4.40 72.7 
 4  5.02  6.88 4.40 72.7 
 4  7.02  5.78 4.40 72.7 
 4  9.02  5.33 4.40 72.7 
 4 11.98  4.19 4.40 72.7 
 4 24.65  1.15 4.40 72.7 
 5  0.00  0.00 5.86 54.6 
 5  0.30  2.02 5.86 54.6 
 5  0.52  5.63 5.86 54.6 
 5  1.00 11.40 5.86 54.6 
 5  2.02  9.33 5.86 54.6 
 5  3.50  8.74 5.86 54.6 
 5  5.02  7.56 5.86 54.6 
 5  7.02  7.09 5.86 54.6 
 5  9.10  5.90 5.86 54.6 
 5 12.00  4.37 5.86 54.6 
 5 24.35  1.57 5.86 54.6 
 6  0.00  0.00 4.00 80.0 
 6  0.27  1.29 4.00 80.0 
 6  0.58  3.08 4.00 80.0 
 6  1.15  6.44 4.00 80.0 
 6  2.03  6.32 4.00 80.0 
 6  3.57  5.53 4.00 80.0 
 6  5.00  4.94 4.00 80.0 
 6  7.00  4.02 4.00 80.0 
 6  9.22  3.46 4.00 80.0 
 6 12.10  2.78 4.00 80.0 
 6 23.85  0.92 4.00 80.0 
 7  0.00  0.15 4.95 64.6 
 7  0.25  0.85 4.95 64.6 
 7  0.50  2.35 4.95 64.6 
 7  1.02  5.02 4.95 64.6 
 7  2.02  6.58 4.95 64.6 
 7  3.48  7.09 4.95 64.6 
 7  5.00  6.66 4.95 64.6 
 7  6.98  5.25 4.95 64.6 
 7  9.00  4.39 4.95 64.6 
 7 12.05  3.53 4.95 64.6 
 7 24.22  1.15 4.95 64.6 
 8  0.00  0.00 4.53 70.5 
 8  0.25  3.05 4.53 70.5 
 8  0.52  3.05 4.53 70.5 
 8  0.98  7.31 4.53 70.5 
 8  2.02  7.56 4.53 70.5 
 8  3.53  6.59 4.53 70.5 
 8  5.05  5.88 4.53 70.5 
 8  7.15  4.73 4.53 70.5 
 8  9.07  4.57 4.53 70.5 
 8 12.10  3.00 4.53 70.5 
 8 24.12  1.25 4.53 70.5 
 9  0.00  0.00 3.10 86.4 
 9  0.30  7.37 3.10 86.4 
 9  0.63  9.03 3.10 86.4 
 9  1.05  7.14 3.10 86.4 
 9  2.02  6.33 3.10 86.4 
 9  3.53  5.66 3.10 86.4 
 9  5.02  5.67 3.10 86.4 
 9  7.17  4.24 3.10 86.4 
 9  8.80  4.11 3.10 86.4 
 9 11.60  3.16 3.10 86.4 
 9 24.43  1.12 3.10 86.4 
10  0.00  0.24 5.50 58.2 
10  0.37  2.89 5.50 58.2 
10  0.77  5.22 5.50 58.2 
10  1.02  6.41 5.50 58.2 
10  2.05  7.83 5.50 58.2 
10  3.55 10.21 5.50 58.2 
10  5.05  9.18 5.50 58.2 
10  7.08  8.02 5.50 58.2 
10  9.38  7.14 5.50 58.2 
10 12.10  5.68 5.50 58.2 
10 23.70  2.42 5.50 58.2 
11  0.00  0.00 4.92 65.0 
11  0.25  4.86 4.92 65.0 
11  0.50  7.24 4.92 65.0 
11  0.98  8.00 4.92 65.0 
11  1.98  6.81 4.92 65.0 
11  3.60  5.87 4.92 65.0 
11  5.02  5.22 4.92 65.0 
11  7.03  4.45 4.92 65.0 
11  9.03  3.62 4.92 65.0 
11 12.12  2.69 4.92 65.0 
11 24.08  0.86 4.92 65.0 
12  0.00  0.00 5.30 60.5 
12  0.25  1.25 5.30 60.5 
12  0.50  3.96 5.30 60.5 
12  1.00  7.82 5.30 60.5 
12  2.00  9.72 5.30 60.5 
12  3.52  9.75 5.30 60.5 
12  5.07  8.57 5.30 60.5 
12  7.07  6.59 5.30 60.5 
12  9.03  6.11 5.30 60.5 
12 12.05  4.57 5.30 60.5 
12 24.15  1.17 5.30 60.5 
run; 


/*----------------------------*/                    
/*--- Code for Output 7.3  ---*/    
/*---      and Figure 7.1  ---*/    
/*----------------------------*/
proc print data=theoph(obs=22) noobs;
 title 'Partial listing of the theophylline PK data';
run;
ods graphics on / imagefmt=SASEMF imagename='Fig_7_1' reset=index;
title1 "Concentration levels by time";
proc sgplot data=theoph noautolegend;
 series x=time y=conc / group=subject 
                        lineattrs=(color=black pattern=1);
 label conc='Concentration (mg/L)' time='time (hr)';
run;
quit;
ods graphics off;
title;


/*----------------------------*/                    
/*--- Code for Output 7.4  ---*/    
/*----------------------------*/
proc means data=theoph noprint;
 where time=0;
 var dose;
 output out=MeanDose(keep=MeanDose) mean=MeanDose;
run;
proc sort data=theoph;
 by subject time;
run;
/* Exclude time zero and merge in mean dose from above */
data example7_2_1;
 set theoph;
 by subject time;
 if _n_=1 then set MeanDose;
 if time>0;
run;
/*=============================================================
  Step 1: Compute unweighted standard two-stage estimates of 
  the population PK parameters as starting values 
==============================================================*/
ods listing close; 
ods output parameterestimates=OLSpe;
proc nlmixed data=example7_2_1 qpoints=1;
 by subject; 
 parms beta_Cl=-10 to -1 by 1 
       beta_ka=0.1 to 1 by 0.1
       beta_V=-5 to -1 by 1 
       sigsq=.1 to 1 by .1 delta=1; 
 Cl = exp(beta_Cl); 
 ka = exp(beta_ka); 
 V  = exp(beta_V ); 
 ke = Cl/V;
 expfunc = exp(-ke*time) - exp(-ka*time);
 predmean = (dose*ka/(V*(ka-ke))) * expfunc;
 predvar = sigsq*(predmean**(2*delta));
 model conc ~ normal(predmean,predvar); 
run; 
ods listing;
proc means data=OLSpe mean median var nway;
 class Parameter;
 var Estimate;
 title 'STS estimates of theophylline PK parameters';
run;
title;

/* Failed attempt to fit the NLME model using      */
/* NLMIXED as described in the book (section 7.2.1)*/
ods output parameterestimates=MLEparms;
proc nlmixed data=example7_2_1 qpoints=1;
 parms beta_Cl=-3.214 beta_ka=0.475 beta_V=-0.764 
       sigsq=2.865 delta=2.00 
       psi11=0.082 psi22=0.455 psi33=0.026
       psi21=0 psi31=0 psi32=0; 
 Cl = exp(beta_Cl + bi1); 
 ka = exp(beta_ka + bi2); 
 V  = exp(beta_V  + bi3); 
 ke=Cl/V;
 expfunc = exp(-ke*time) - exp(-ka*time);
 predmean = (dose*ka/(V*(ka-ke))) * expfunc;
 predvar = sigsq*(predmean**(2*delta));
 model conc ~ normal(predmean,predvar); 
 random bi1 bi2 bi3 ~ normal([0,0,0],[psi11,
                                      psi21, psi22,
                                      psi31, psi32, psi33])
        subject=subject; 
run; 


/*----------------------------*/                    
/*--- Code for Output 7.5  ---*/    
/*----------------------------*/
/*=============================================================
  Step 2: Using the STS estimates as starting values, we next use
  macro COVPARMS to determinine starting values for the variance 
  covariance parameters of the random effects assuming Cl, ka
  and V are all patient-specific random effects with a 
  multiplicative random error structure. To do this, we run
  NLMIXED with all random effects variance-covariance parameters
  set equal to 0 as described in the COVPARMS macro.
==============================================================*/
ods listing close;
ods output parameterestimates=MLEparms;
proc nlmixed data=example7_2_1 qpoints=1;
 parms beta_Cl=-3.214 beta_ka=0.475 beta_V=-0.764 
       sigsq=2.865 delta=2.00;
 Cl = exp(beta_Cl + bi1); 
 ka = exp(beta_ka + bi2); 
 V  = exp(beta_V  + bi3); 
 ke=Cl/V;
 expfunc = exp(-ke*time) - exp(-ka*time);
 predmean = (dose*ka/(V*(ka-ke))) * expfunc;
 predvar = sigsq*(predmean**(2*delta));
 model conc ~ normal(predmean,predvar); 
 random bi1 bi2 bi3 ~ normal([0,0,0],[0,
                                      0, 0,
                                      0, 0, 0]) 
        subject=subject; 
 resid = conc - predmean;
 predict predmean out=predout der;
 id resid;
run; 
ods listing;
%covparms(parms=MLEparms, predout=predout, 
          resid=resid, method=mspl,
          random=der_bi1 der_bi2 der_bi3, 
          subject=subject, type=un, covname=psi, 
          output=MLEparms1);


/* Failed attempt to fit the NLME model using      */
/* NLMIXED as described in the book (section 7.2.1)*/
proc nlmixed data=example7_2_1 qpoints=1;
 parms /data=MLEparms1;
 Cl = exp(beta_Cl + bi1); 
 ka = exp(beta_ka + bi2); 
 V  = exp(beta_V  + bi3); 
 ke=Cl/V;
 expfunc = exp(-ke*time) - exp(-ka*time);
 predmean = (dose*ka/(V*(ka-ke))) * expfunc;
 predvar = sigsq*(predmean**(2*delta));
 model conc ~ normal(predmean,predvar); 
 random bi1 bi2 bi3 ~ normal([0,0,0],[psi11,
                                      psi21, psi22,
                                      psi31, psi32, psi33])
        subject=subject; 
run; 


/*----------------------------*/                    
/*--- Code for Output 7.6  ---*/    
/*----------------------------*/
data MLEparms2;
 set MLEparms1;
 if Parameter in ('psi31' 'psi32' 'psi33') then delete;
run;
ods output parameterestimates=peLMLE;
ods output additionalestimates=aeLMLE;
ods select Specifications Dimensions IterHistory
           ConvergenceStatus FitStatistics 
           ParameterEstimates AdditionalEstimates;
proc nlmixed data=example7_2_1 qpoints=1 tech=newrap;
 parms /data=MLEparms2;
 Cl = exp(beta_Cl + bi1); 
 ka = exp(beta_ka + bi2); 
 V  = exp(beta_V); 
 ke=Cl/V;
 Cl_mean = exp(beta_Cl+.5*psi11);
 ka_mean = exp(beta_ka+.5*psi22);
 ke_mean = exp(beta_Cl+.5*psi11-beta_V);
 Tmax = log(ka_mean/ke_mean)/(ka_mean-ke_mean);
 AUC_mean = MeanDose/(V*ke_mean);
 expfunc = exp(-ke*time) - exp(-ka*time);
 predmean = (dose*ka/(V*(ka-ke))) * expfunc;
 predvar = sigsq*(predmean**(2*delta));
 resid = conc - predmean;
 model conc ~ normal(predmean,predvar); 
 random bi1 bi2 ~ normal([0,0],[psi11,
                                psi21, psi22])
        subject=subject; 
 estimate 'Cl' Cl_mean;
 estimate 'V' V;
 estimate 'ka' ka_mean;
 estimate 'ke' ke_mean;
 estimate 'Tmax' Tmax;
 estimate 'AUC' AUC_mean;
run; 


/*----------------------------*/                    
/*--- Code for Output 7.7  ---*/    
/*----------------------------*/
ods listing close;
ods output parameterestimates=peMLE;
ods output additionalestimates=aeMLE;
proc nlmixed data=example7_2_1 tech=newrap;
 parms /data=MLEparms2;
 Cl = exp(beta_Cl + bi1); 
 ka = exp(beta_ka + bi2); 
 V  = exp(beta_V); 
 ke=Cl/V;
 Cl_mean = exp(beta_Cl+.5*psi11);
 ka_mean = exp(beta_ka+.5*psi22);
 ke_mean = exp(beta_Cl+.5*psi11-beta_V);
 Tmax = log(ka_mean/ke_mean)/(ka_mean-ke_mean);
 AUC_mean = MeanDose/(V*ke_mean);
 expfunc = exp(-ke*time) - exp(-ka*time);
 predmean = (dose*ka/(V*(ka-ke))) * expfunc;
 predvar = sigsq*(predmean**(2*delta));
 resid = conc - predmean;
 model conc ~ normal(predmean,predvar); 
 random bi1 bi2 ~ normal([0,0],[psi11,
                                psi21, psi22])
        subject=subject; 
 estimate 'Cl' Cl_mean;
 estimate 'V' V;
 estimate 'ka' ka_mean;
 estimate 'ke' ke_mean;
 estimate 'Tmax' Tmax;
 estimate 'AUC' AUC_mean;
run; 
ods output parameterestimates=peFIRO;
ods output additionalestimates=aeFIRO;
proc nlmixed data=example7_2_1 method=firo tech=newrap;
 parms /data=MLEparms2;
 Cl = exp(beta_Cl + bi1); 
 ka = exp(beta_ka + bi2); 
 V  = exp(beta_V); 
 ke=Cl/V;
 Cl_mean = exp(beta_Cl+.5*psi11);
 ka_mean = exp(beta_ka+.5*psi22);
 ke_mean = exp(beta_Cl+.5*psi11-beta_V);
 Tmax = log(ka_mean/ke_mean)/(ka_mean-ke_mean);
 AUC_mean = MeanDose/(V*ke_mean);
 expfunc = exp(-ke*time) - exp(-ka*time);
 predmean = (dose*ka/(V*(ka-ke))) * expfunc;
 predvar = sigsq*(predmean**(2*delta));
 resid = conc - predmean;
 model conc ~ normal(predmean,predvar); 
 random bi1 bi2 ~ normal([0,0],[psi11,
                                psi21, psi22])
        subject=subject; 
 estimate 'Cl' Cl_mean;
 estimate 'V' V;
 estimate 'ka' ka_mean;
 estimate 'ke' ke_mean;
 estimate 'Tmax' Tmax;
 estimate 'AUC' AUC_mean;
run; 
ods listing;
data pe;
 set peMLE(in=a) peLMLE(in=b) peFIRO(in=c);
 if a then Method='MLE (qpoints=5)';
 if b then Method='Laplace MLE    ';
 if c then Method='First order    ';
run;
data ae;
 set aeMLE(in=a) aeLMLE(in=b) aeFIRO(in=c);
 if a then Method='MLE (qpoints=5)';
 if b then Method='Laplace MLE    ';
 if c then Method='First order    ';
run;
proc report data=pe headskip split='|' nowindows ;
 column ('Parameter Estimates' Parameter Method, (Estimate StandardError));
 define Parameter / group width=9 left;
 define Method / across ;
 define Estimate / mean;
 define StandardError / mean 'StdErr';
run;
proc report data=ae headskip split='|' nowindows ;
 column ('Parameter Estimates' Label Method, (Estimate StandardError));
 define Label / 'PK Parameters' group width=24 left;
 define Method / across ;
 define Estimate / mean;
 define StandardError / mean 'StdErr';
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

