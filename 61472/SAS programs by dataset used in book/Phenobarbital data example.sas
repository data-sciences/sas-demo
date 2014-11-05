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
/*=== Example 7.2.2. Phenobarbital data                           ===*/
/*===================================================================*/

/*----------------------------*/                    
/*--- Code for Output 7.8  ---*/    
/*----------------------------*/
proc print data=SASdata.Phenobarbital_Data noobs;
 where ID in (47 50);
run;
 

/*============================================================
  The following statements are required in order to fit
  a recursive-based NLME model to the phenobarbital data 
  using NLMIXED. The dataset downloaded from the RFPK site 
  http://www.rfpk.washington.edu differs from the SAS dataset
  available with SAS book, SAS for Mixed Models, 2nd Edition, 
  written by Littell et. al. (2006). The following code mimics
  that given by Littell et. al. (2006) for the Phenobarbital 
  example (Littell et. al., 2006, Example 15.7, pp. 607-623)
=============================================================*/
data example7_2_2;
 set SASdata.Phenobarbital_data;
 retain cursub .;
 if cursub ne ID then do;
    newsub = 1; cursub = ID;
 end;
 else newsub = 0;
 apgarind = (apgar < 5);
 lagtime = lag(time);
 if (newsub=1) then lagtime = 0;
 /* eventid =1 if a sustaining dose is given while */
 /* eventid =0 if a serum concentration is given   */ 
 if eventid = 0 and dose=. then dose=0;  
 drop cursub; 
run;


/*----------------------------*/                    
/*--- Code for Figure 7.2  ---*/    
/*----------------------------*/
ods graphics on / imagefmt=SASEMF imagename='Fig_7_2' reset=index;
title1 "Concentration levels by time";
proc sgplot data=example7_2_2 noautolegend;
 series x=time y=conc / group=ID 
                        lineattrs=(color=black pattern=1);
 yaxis values=(0 10 20 30 40 50 60 70);
 xaxis values=(0 to 400 by 50);
 label conc='Concentration (ug/L)' time='time (hr)';
run;
quit;
ods graphics off;
title;


/* PARMS12 is a macro variable for use with macro %PK  */
/* Grid values for PK models 1-2 with no covariates    */
%let parms12=%str(
     parms beta1=0.01 0.5 beta2=.01 .1 1 
           psi11=0.000005 0.0005 .05 
           psi22=.01 0.1 sigsq=.1 3 /best=1; );

/* PARMS34 is a macro variable for use with macro %PK  */
/* Grid values for PK models 3-4 with covariate=weight */
%let parms34=%str(
     parms beta11=0.01 0.5 beta21=.01 .1 1 
           beta12=0 .05 .5 beta22=0 .01 .1 
           psi11=0.000005 0.0005 .05 
           psi22=.01 0.1 sigsq=.1 3 /best=1; );

/*=======================================================
 MACRO PK - A SAS macro that calls NLMIXED to fit a NLME
            model to the phenobarbital data using the   
            NLMIXED specifications that one chooses.  
 KEY:  
      CLOSE    -defines whether NLMIXED output prints
                CLOSE=CLOSE is default (no printout)
                CLOSE='blank' instructs macro to print   
      METHOD   -defines which estimation method to use
                METHOD=GAUSS (with QPOINTS=1) is default 
                METHOD=FIRO calls the first-order method 
      PARMS    -defines the PARMS statement for starting
                values of the parameters using either
                PARMS=&PARMS12 or PARMS=&PARMS34 
      BOUNDS   -defines a bounds statement for NLMIXED
      CL       -defines the clearance parameter as a 
                function of parameters, covariates and
                random effects 
      V        -defines the volume parameter as a 
                function of parameters, covariates and
                random effects 
      VARIANCE -defines the intra-subject variance structure
      MODEL    -defines a Model ID number
      FIT      -defines the dataset that saves the likelihood 
                fit statistics using ODS OUTPUT FitStatistics=
      OUTPUT   -defines the dataset that saves the parameter
                estimates using ODS OUTPUT ParameterEstimates=
      PREDOUT  -defines a dataset containing predicted SS 
                clearances as well as the SS random effects
=======================================================*/
%macro PK(close=close,
          method=Gauss,
          parms=&parms12,
          bounds=%str(bounds beta1>=0, beta2>=0, 
                      psi11>=0, psi22>=0, sigsq>0;),
          Cl= beta1/100 + bi1,   
          V = beta2 + bi2,
          variance=sigsq,
          model=Model 1,
          fit=fit,
          output=pe,
          predout=pred);
  %let method=%upcase(&method);
  ods listing &close;
  ods output fitstatistics=&fit;
  ods output parameterestimates=&output;
  proc nlmixed data=example7_2_2 method=&method qpoints=1;
   &parms;
   &bounds;
   /* Clearance and Volume parameters terms expressed */ 
   /* as functions of parameters and covariates       */
   Cl = &Cl; 
   V  = &V; 
   func =  exp(-(Cl/V)*(time-lagtime));
   /* PK model expressed as a recursive NLME model    */
   if (newsub = 1) then 
      predmean = Dose/V;
   else 
      predmean = Dose/V + 
                 zlag(predmean)*exp(-(Cl/V)*(time-lagtime));
      predvar  = &variance;
   model conc ~ normal(predmean,predvar); 
   random bi1 bi2 ~ normal([0,0],[psi11,0,psi22]) subject=ID;
   predict Cl out=&predout; id Cl V bi1 bi2;
  run; 
  data &fit;
   set &fit;
   Method_="&method";
   if Method_="GAUSS" then Method='Laplace MLE';
   if Method_="FIRO"  then Method='First-order';
   Model="&model";
   drop Method_;
  run;
  data &output;
   length Parameter $6;
   set &output;
   Method_="&method";
   if Method_="GAUSS" then Method='Laplace MLE';
   if Method_="FIRO"  then Method='First-order';
   Model="&model";
   drop Method_;
  run;
  ods listing;
%mend;


/*----------------------------*/                    
/*--- Code for Output 7.9  ---*/    
/*----------------------------*/
%PK(method=FIRO,
    parms=&parms12,
    bounds=%str(bounds beta1>=0, beta2>=0, 
                psi11>=0, psi22>=0, sigsq>0;),
    Cl= beta1/100 + bi1,   
    V = beta2 + bi2,
    variance = sigsq,
    model=Model 1,
    fit=fit11,
    output=pe11);
%PK(method=GAUSS,
    parms=&parms12,
    bounds=,
    Cl= beta1/100 + bi1,   
    V = beta2 + bi2,
    variance = sigsq,
    model=Model 1,
    fit=fit12,
    output=pe12);
%PK(method=FIRO,
    parms=&parms12,
    bounds=%str(bounds beta1>=0, beta2>=0, 
                psi11>=0, psi22>=0, sigsq>0;),
    Cl= (beta1/100)*(1 + bi1),   
    V = (beta2)*(1 + bi2),
    variance = sigsq*(predmean**2),
    model=Model 2,
    fit=fit21,
    output=pe21);
%PK(method=GAUSS,
    parms=&parms12,
    bounds=,
    Cl= (beta1/100)*(1 + bi1),   
    V = (beta2)*(1 + bi2),
    variance = sigsq*(predmean**2),
    model=Model 2,
    fit=fit22,
    output=pe22);
%PK(method=FIRO,
    parms=&parms34,
    bounds=%str(bounds beta11>=0, beta21>=0, 
                psi11>=0, psi22>=0, sigsq>0;),
    Cl = (beta11 + beta12*weight)/100 + bi1, 
    V  = (beta21 + beta22*weight) + bi2, 
    variance = sigsq,
    model=Model 3,
    fit=fit31,
    output=pe31);
%PK(method=GAUSS,
    parms=&parms34,
    bounds=,
    Cl = (beta11 + beta12*weight)/100 + bi1, 
    V  = (beta21 + beta22*weight) + bi2, 
    variance = sigsq,
    model=Model 3,
    fit=fit32,
    output=pe32);
%PK(method=FIRO,
    parms=&parms34,
    bounds=%str(bounds beta11>=0, beta21>=0, 
                psi11>=0, psi22>=0, sigsq>0;),
    Cl = ((beta11 + beta12*weight)/100)*(1 + bi1), 
    V  = (beta21 + beta22*weight)*(1 + bi2), 
    variance = sigsq*(predmean**2),
    model=Model 4,
    fit=fit41,
    output=pe41);
%PK(method=GAUSS,
    parms=&parms34,
    bounds=,
    Cl = ((beta11 + beta12*weight)/100)*(1 + bi1), 
    V  = (beta21 + beta22*weight)*(1 + bi2), 
    variance = sigsq*(predmean**2),
    model=Model 4,
    fit=fit42,
    output=pe42);
data peALL;
 set pe11 pe12 pe21 pe22 pe31 pe32 pe41 pe42;
 if Method='First-order' then Method='FIRO ';
 if Method='Laplace MLE' then Method='GAUSS';
run;
proc sort data=peALL;
 by Parameter Model Method;
run;
data fitALL;
 set fit11 fit12 fit21 fit22 fit31 fit32 fit41 fit42;
 if Method='First-order' then Method='FIRO ';
 if Method='Laplace MLE' then Method='GAUSS';
run;
proc sort data=fitALL;
 by Model Method;
run;
proc report data=peALL headskip split='|' nowindows ;
 where Model in ('Model 1' 'Model 2');
 column ("MLE's for models 1 and 2 (with no covariates)"
         'Method: FIRO=First-order approximation GAUSS=Laplace approximation'    
          Method Parameter Model, (Estimate StandardError Probt));
 define Method / group width=12 left;
 define Parameter / group width=9 left;
 define Model / across ;
 define Estimate / mean;
 define StandardError / mean 'StdErr';
 define Probt / mean;
run;
proc report data=peALL headskip split='|' nowindows ;
 where Model in ('Model 3' 'Model 4');
 column ("MLE's for models 3 and 4 (weight included as a covariate)" 
         'Method: FIRO=First-order approximation GAUSS=Laplace approximation'    
          Method Parameter Model, (Estimate StandardError Probt));
 define Method / group width=12 left;
 define Parameter / group width=9 left;
 define Model / across ;
 define Estimate / mean;
 define StandardError / mean 'StdErr';
 define Probt / mean;
run;
proc report data=fitALL headskip split='|' nowindows ;
 column ('Likelihood-based Fit Statistics based on Model and Method'
         'Method: FIRO=First-order approximation GAUSS=Laplace approximation'    
          Method Descr Model, (Value));
 define Method / group width=12 left;
 define descr / 'Fit statistic' width=25 group; 
 define Model / across width=8 ; 
 define Value / mean width=8;
run;


/*----------------------------*/                    
/*--- Code for Output 7.10 ---*/    
/*----------------------------*/
%PK(method=FIRO,
    parms=&parms34,
    bounds=,
    Cl = exp(beta11 + beta12*weight + bi1), 
    V  = exp(beta21 + beta22*weight + bi2), 
    variance = sigsq,
    model=Model 3a,
    fit=fit31a,
    output=pe31a);
%PK(method=GAUSS,
    parms=&parms34,
	bounds=,
    Cl = exp(beta11 + beta12*weight + bi1), 
    V  = exp(beta21 + beta22*weight + bi2), 
    variance = sigsq,
    model=Model 3a,
    fit=fit32a,
    output=pe32a);
data peALLa;
 set pe31a pe32a;
 if Method='First-order' then Method='FIRO ';
 if Method='Laplace MLE' then Method='GAUSS';
run;
proc sort data=peALLa;
 by Parameter Model Method;
run;
data fitALLa;
 set fit31a fit32a;
 if Method='First-order' then Method='FIRO ';
 if Method='Laplace MLE' then Method='GAUSS';
run;
proc sort data=fitALLa;
 by Model Method;
run;
proc report data=peALLa headskip split='|' nowindows ;
 column ("MLE's for model 3a (weight included as a covariate)"
         'Method: FIRO=First-order approximation GAUSS=Laplace approximation'    
          Parameter Method, (Estimate StandardError Probt));
 define Parameter / group width=9 left;
 define Method / across ;
 define Estimate / mean;
 define StandardError / mean 'StdErr';
 define Probt / mean;
run;
quit;
proc report data=fitALLa headskip split='|' nowindows ;
 column ("Likelihood-based fit statistics for model 3a by method of estimation"
         'Method: FIRO=First-order approximation GAUSS=Laplace approximation'    
          Descr Method, (Value));
 define descr / 'Fit statistic' width=25 group; 
 define Method / across width=8 ; 
 define Value / mean width=8;
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 7.11 ---*/    
/*----------------------------*/
%PK(close=,
    method=GAUSS,
    parms=%str(
    parms beta11=0.01 0.5 
          beta21=.01 .1 1 beta22=0 .01 .1 
          psi11=0.000005 0.0005 .05 
          psi22=.01 0.1 sigsq=.1 3 /best=1; ),
    bounds=,
    Cl = (beta11/100*weight)*exp(bi1), 
    V  = (beta21*weight)*(1 + beta22*apgarind)*exp(bi2), 
    variance = sigsq*(predmean**2),
    model=Model 6,
    fit=fit62,
    output=pe62,
    predout=pred62);


/*----------------------------*/                    
/*--- Code for Figure 7.3  ---*/    
/*----------------------------*/
ods graphics on / imagefmt=SASEMF imagename='Fig_7_3' reset=index;
title1 "Predicted clearances and volumes versus birth weight";
proc sgscatter data=pred62;
 plot (Cl V)*weight / reg;
 label Cl='Clearance' V='Volume' weight='Birth weight (kg)';
run;
quit;
ods graphics off;
title;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

