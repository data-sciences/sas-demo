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
/*=== Example 5.4.3. High-flux hemodialyzer data                  ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\covparms.sas' / nosource2;
%include 'c:\SAS macros used in book\nlinmix.sas' /nosource2;
%include 'c:\SAS macros used in book\vech.sas' /nosource2;

data Example5_4_3;
 set SASdata.Hemodialyzer_data;
 /* Re-express UFR in liters/hr*/
 UFR = UFR/1000;      
 /* Target TMP mmHg values     */
 TMP_TARG = round(TMP,25); 
 /* The correct target TMP for */
 /* lowest measured TMP for    */
 /* dialyzer K80798 was 25 mmHg*/
 if Dialyzer='K80798' and TMP=40.0 then TMP_TARG=25;
 I1=(TMP_TARG=25 );
 I2=(TMP_TARG=50 );
 I3=(TMP_TARG=100);
 I4=(TMP_TARG=150);
 I5=(TMP_TARG=200);
 I6=(TMP_TARG=250);
 I7=(TMP_TARG=300);
 /* Define indicator variable  */
 /* for the two Qb values      */
 Qb_300=(Qb=300);
run;


/*----------------------------*/                    
/*--- Code for Figure 5.9  ---*/    
/*----------------------------*/
proc sort data=Example5_4_3;
 by Qb Dialyzer TMP;
run;
options nobyline;
proc format;
 value qbfmt 200='200 ml/min' 300='300 ml/min';
run;
ods graphics on / imagefmt=SASEMF imagename='Fig_5_9' reset=index;
title1 "UFR levels by Blood Flow Rate (Qb)";
proc sgpanel data=example5_4_3;
  panelby Qb ;
  loess x=TMP y=UFR / clm name='UFR';
  format Qb qbfmt.;
  label UFR='UFR (L/hr)';
run;
quit;
ods graphics off;
quit;
title;


proc sort data=example5_4_3;
 by Dialyzer TMP;
run;
/* Confirm no intercept random effect - results not shown in book */
ods listing close;
ods output parameterestimates=SAStemp.OLSparms;
proc nlmixed data=example5_4_3 qpoints=1 tech=newrap maxfunc=1000;  
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 beta1 = (b11 + b12*Qb_300) + (b13 + b14*Qb_300)*TMPd + bi1;
 beta2 = b21 + b22*Qb_300 + bi2;
 beta3 = b31 + b32*Qb_300 + bi3;
 pred = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       sigsq_w=.060 / best=1;
 model UFR~normal(pred, sigsq_w); 
 resid=UFR-pred;
 random bi1 bi2 bi3 ~ normal([0,0,0],
                                   [0,
                                    0,0,
                                    0,0,0])
        subject=Dialyzer;
 predict pred out=SAStemp.predout der; 
 id resid;
run;
ods listing;
%covparms(parms=SAStemp.OLSparms, predout=SAStemp.predout,
          resid=resid, method=mspl, 
          random=der_bi1 der_bi2 der_bi3, subject=Dialyzer,
          type=un, covname=psi, output=MLEparms);

/* Fit model 5.87 and store parameter estimates to pe_model1  */
/* and the predicted values from the model to SAStemp.model1  */
/* The results of this fitted model are not shown in the book */
ods output parameterestimates=pe_model1;
proc nlmixed data=example5_4_3 qpoints=1;  
 beta1 = b11 + b12*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 /* Model description */
 Model='Model (5.87)';
 pred = (beta1+bi1)*(1 - exp(-(beta2+bi2)*(TMPd-beta3)));
 pred_avg = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 parms b11=5 b12=0 b21=1 b22=0 b31=.20 b32=0
       psi11=.1 to 1 by .1 psi21=-0.1 -0.01 0 0.01 0.1
       psi22=.1 to 1 by .1 sigsq_w=.060 / best=1; 
 model UFR~normal(pred, sigsq_w);                                                        
 random bi1 bi2 ~ normal([0,0],[psi11,
                                psi21, psi22]) subject=Dialyzer;
 predict pred_avg out=SAStemp.model1;
 id TMPd Model; 
run;

/*----------------------------*/                    
/*--- Code for Output 5.29 ---*/    
/*----------------------------*/
ods output parameterestimates=pe_model2;
proc nlmixed data=example5_4_3 qpoints=1 
             tech=newrap maxfunc=1000;  
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 /* Model description */
 Model='Model (5.88)';
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = (beta1+bi1)*(1 - exp(-(beta2+bi2)*(TMPd-beta3)));
 pred_avg = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       psi11=.1 to 1 by .1 psi21=-0.1 -0.01 0 0.01 0.1
       psi22=.1 to 1 by .1 sigsq_w=.060 / best=1; 
 model UFR~normal(pred, sigsq_w);
 random bi1 bi2 ~ normal([0,0], [psi11,
                                 psi21, psi22])
        subject=Dialyzer;
 estimate 'Asymptote Intercept, Qb=200:' b11;
 estimate 'Asymptote Intercept, Qb=300:' b11+b12;
 estimate 'Asymptote Slope, Qb=200:' b13;
 estimate 'Asymptote Slope, Qb=300:' b13+b14;
 estimate 'Hydraulic Rate, Qb=200' b21;
 estimate 'Hydraulic Rate, Qb=300' b21+b22;
 estimate 'Intercept TMP, Qb=200' b31;
 estimate 'Intercept TMP, Qb=300' b31+b32;
 predict pred_avg out=SAStemp.model2; 
 id TMPd Model;
run;


/*----------------------------*/                    
/*--- Code for Figure 5.10 ---*/    
/*----------------------------*/
data plotfits; 
 set SAStemp.model1 SAStemp.model2;
run;  
proc sort data=plotfits;
 by Model Qb TMPd;
run;
ods graphics on / imagefmt=SASEMF imagename='Fig_5_10' reset=index;
proc sgpanel data=plotfits;
 title "Fit and Confidence Band for the Average Dialyzer from Models (5.87) and (5.88)";
 title2 "Model (5.87): -2 Log Likelihood = 66.6, AIC = 86.6, AICC = 88.3, BIC=96.6";
 title3 "Model (5.88): -2 Log Likelihood =  8.3, AIC = 32.3, AICC = 34.7, BIC=44.2";
 panelby Model;
 band x=TMP lower=lower upper=upper / 
      Group=Qb legendlabel="95% CLM" name="band1"; 
 scatter x=TMP y=UFR /
         Group=Qb;
 series x=TMP y=pred / lineattrs=GraphPrediction
        Group=Qb markerattrs=(symbol=circle symbol=circlefilled) 
        legendlabel="Predicted Fit" name="series";
 label TMPd='TMP (mmHg)'
       UFR='UFR (L/hour)'
       Qb='Qb (ml/min)'; 
run;
quit;
ods graphics off;
quit; 
title;

/* Run NLME models 1-6 of Table 5.2 to compute information criteria */
%macro NLME_Models;

data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='NLME 1';
 /* Covariance structure description */
 Structure='RE(bi1,bi2)|VC';                     
run;
ods output parameterestimates=SAStemp.pe_NLME_1;
ods output FitStatistics=SAStemp.fit_NLME_1;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;
 by Model Structure;
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = (beta1+bi1)*(1 - exp(-(beta2+bi2)*(TMPd-beta3)));
 pred_avg = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       psi11=.1 to 1 by .1 psi21=-0.1 -0.01 0 0.01 0.1
       psi22=.1 to 1 by .1 sigsq_w=.060 / best=1; 
 model UFR~normal(pred, sigsq_w);
 random bi1 bi2 ~ normal([0,0], [psi11,
                                 psi21, psi22])
        subject=Dialyzer;
 title 'NLME Model 1: bi1, bi2 random, VC';
run;


data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='NLME 2';
 /* Covariance structure description */
 Structure='RE(bi1,bi2)|VC-POM';                     
run;
ods output parameterestimates=SAStemp.pe_NLME_2;
ods output FitStatistics=SAStemp.fit_NLME_2;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;
 by Model Structure;
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = (beta1+bi1)*(1 - exp(-(beta2+bi2)*(TMPd-beta3)));
 pred_avg = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 POM = pred**(2*delta);
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       psi11=.1 to 1 by .1 psi21=-0.1 -0.01 0 0.01 0.1   
       psi22=.1 to 1 by .1 sigsq_w=.060  delta=0 .5 1 / best=1; 
 model UFR~normal(pred, POM*sigsq_w);
 random bi1 bi2 ~ normal([0,0],
                         [psi11,
                          psi21, psi22])
        subject=Dialyzer;
 title 'NLME Model 2: bi1, bi2 random, VC-POM';
run;


data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='NLME 3';
 /* Covariance structure description */
 Structure='RE(bi1,bi2)|CS-POM';                     
run;
ods output parameterestimates=SAStemp.pe_NLME_3;
ods output FitStatistics=SAStemp.fit_NLME_3;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;
 by Model Structure;
 bounds sigsq_b>0;
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = (beta1+bi1)*(1 - exp(-(beta2+bi2)*(TMPd-beta3)));
 pred_avg = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 POM = pred**(2*delta);
 mu = pred + sqrt(POM)*eij;
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       psi11=.1 to 1 by .1 psi21=-0.1 -0.01 0 0.01 0.1   
       psi22=.1 to 1 by .1 sigsq_w=.060 sigsq_b=.01 .1 1 delta=0 .5 1 / best=1; 
 model UFR~normal(mu, POM*sigsq_w);
 random bi1 bi2 eij ~ normal([0,0,0],
                             [psi11,
                              psi21, psi22,
                                0  ,   0  , sigsq_b])
        subject=Dialyzer;
 estimate 'rho' sigsq_b/(sigsq_w+sigsq_b);
 title 'NLME Model 3: bi1, bi2 random, CS-POM';
run;


/* FAILED using both QUANEW and NEWRAP techniques */
data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='NLME 4';
 /* Intra-subject covariance structure description */
 Structure='RE(bi1,bi2)|AR(1)-POM';                     
run;
ods output parameterestimates=SAStemp.pe_NLME_4;
ods output FitStatistics=SAStemp.fit_NLME_4;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;
 by Model Structure;
 bounds -1<rho<1;
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 eij = I1*e1+I2*e2+I3*e3+I4*e4+I5*e5+
	   I6*e6+I7*e7; 
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = (beta1+bi1)*(1 - exp(-(beta2+bi2)*(TMPd-beta3)));
 pred_avg = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 array cov[7,7];
 do i=1 to 7;
  do j=1 to 7;
   cov[i,j] = sigsq_w*(rho**abs(i-j));    
  end;
 end;
 %vech(dim=7, cov=cov, name=c);
 _delta_=1e-8;
 POM = pred**(2*delta);
 mu = pred + sqrt(POM)*eij;
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       psi11=.1 to 1 by .1 psi21=-0.1 -0.01 0 0.01 0.1
       psi22=.1 to 1 by .1 sigsq_w=.060 rho=-.5 .01 .1 .5 delta=0 .5 1  / best=1; 
 model UFR~normal(mu, _delta_);
 random bi1 bi2 e1 e2 e3 e4 e5 e6 e7 ~ 
        normal([ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
               [ psi11,
			     psi21, psi22,
                   0  ,   0  , c1 ,
                   0  ,   0  , c2 , c3 ,  
                   0  ,   0  , c4 , c5 , c6 ,
                   0  ,   0  , c7 , c8 , c9 , c10, 
                   0  ,   0  , c11, c12, c13, c14, c15,
                   0  ,   0  , c16, c17, c18, c19, c20, c21,
                   0  ,   0  , c22, c23, c24, c25, c26, c27, c28 ])
		subject=Dialyzer; 
 title 'NLME Model 4: bi1, bi2 random, AR(1)-POM';
run;


data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='NLME 5';
 /* Intra-subject covariance structure description */
 Structure='RE(bi1)|CSH';                     
run;
ods output parameterestimates=SAStemp.pe_NLME_5;
ods output FitStatistics=SAStemp.fit_NLME_5;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;
 by Model Structure;
 bounds -1<rho<1;
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 eij = I1*e1+I2*e2+I3*e3+I4*e4+I5*e5+
	   I6*e6+I7*e7; 
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = (beta1+bi1)*(1 - exp(-beta2*(TMPd-beta3)));
 pred_avg = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 array cov[7,7];
 array sigsq_w[7] sigsq_w1-sigsq_w7;
 do i=1 to 7;
  do j=1 to 7;
   dij=1-(i=j);
   cov[i,j] = sqrt(sigsq_w[i]*sigsq_w[j])*(rho**dij);    
  end;
 end;
 %vech(dim=7, cov=cov, name=c);
 _delta_=1e-8;
 mu = pred + eij;
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       psi11=.1 to 1 by .1 
       sigsq_w1=.1 sigsq_w2=.1 sigsq_w3=.1 sigsq_w4=.1 
       sigsq_w5=.1 sigsq_w6=.1 sigsq_w7=.1 rho=.01 .1 .5/best=1;
 model UFR~normal(mu, _delta_);
 random bi1 e1 e2 e3 e4 e5 e6 e7 ~ 
        normal([ 0, 0, 0, 0, 0, 0, 0, 0 ],
               [ psi11,
                   0  , c1 ,
                   0  , c2 , c3 ,  
                   0  , c4 , c5 , c6 ,
                   0  , c7 , c8 , c9 , c10, 
                   0  , c11, c12, c13, c14, c15,
                   0  , c16, c17, c18, c19, c20, c21,
                   0  , c22, c23, c24, c25, c26, c27, c28 ])
		subject=Dialyzer; 
 title 'NLME Model 5: bi1 random, CSH';
run;


data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='NLME 6';
 /* Intra-subject covariance structure description */
 Structure='RE(bi1)|ARH(1)';                     
run;
ods output parameterestimates=SAStemp.pe_NLME_6;
ods output FitStatistics=SAStemp.fit_NLME_6;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;
 by Model Structure;
 bounds -1<rho<1;
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 eij = I1*e1+I2*e2+I3*e3+I4*e4+I5*e5+I6*e6+I7*e7;
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = (beta1+bi1)*(1 - exp(-beta2*(TMPd-beta3)));
 pred_avg = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 array cov[7,7];
 array sigsq_w[7] sigsq_w1-sigsq_w7;
 do i=1 to 7;
  do j=1 to 7;
   cov[i,j] = sqrt(sigsq_w[i]*sigsq_w[j])*(rho**abs(i-j));
  end;
 end;
 %vech(dim=7, cov=cov, name=c);
 _delta_=1e-8;
 mu = pred + eij;
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       psi11=.1 to 1 by .1 
       sigsq_w1=.1 sigsq_w2=.1 sigsq_w3=.1 sigsq_w4=.1 
       sigsq_w5=.1 sigsq_w6=.1 sigsq_w7=.1 
       rho=.01 .1 .5 / best=1;
 model UFR~normal(mu, _delta_);
 random bi1 e1 e2 e3 e4 e5 e6 e7 ~ 
        normal([ 0, 0, 0, 0, 0, 0, 0, 0 ],
               [ psi11,
                   0  , c1 ,
                   0  , c2 , c3 ,  
                   0  , c4 , c5 , c6 ,
                   0  , c7 , c8 , c9 , c10, 
                   0  , c11, c12, c13, c14, c15,
                   0  , c16, c17, c18, c19, c20, c21,
                   0  , c22, c23, c24, c25, c26, c27, c28 ])
        subject=Dialyzer; 
 predict pred_avg out=SAStemp.pred_NLME_6;
 title 'NLME Model 6: bi1 random, ARH(1)';
run;

%mend NLME_Models;

/* Run GNLMs 1-7 of Table 5.3 to compute information criteria */
%macro GNLM_Models;

%nlinmix(data=example5_4_3,
  procopt=method=ml covtest cl,
  parms=%str(b11=5 b12=0 b13=0 b14=0
             b21=1 b22=0 b31=.20 b32=0),
  model=%str( 
   TMPd = TMP/100; 
   beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
   beta2 = b21 + b22*Qb_300;
   beta3 = b31 + b32*Qb_300;
   predv = beta1*(1 - exp(-beta2*(TMPd-beta3)));
  ), 
  stmts=%str(
   class Dialyzer TMP_TARG;
   model pseudo_UFR = d_b11 d_b12 d_b13 d_b14 
                      d_b21 d_b22 d_b31 d_b32 / 
                      noint notest s cl;
   repeated TMP_TARG / subject=Dialyzer type=UN;
   ods output SolutionF=SAStemp.pe_GNLM_1_initial;
   ods output CovParms=SAStemp.cov_GNLM_1_initial;
  ),
  expand=zero,
  options=
); 
run;

data pe_GNLM_1 (rename=(StdErr=StandardError));
 length Parameter $8.;
 set SAStemp.pe_GNLM_1_initial;
 Parameter=scan(Effect,2, '_');
 drop Effect;
run;
data cov_GNLM_1 (rename=(StdErr=StandardError));
 length Parameter $8.;
 set SAStemp.cov_GNLM_1_initial;
 Parameter = compress( left('psi')||left(scan(CovParm,2))||left(scan(CovParm,3)) );
 DF=.;
 tValue=ZValue;
 Probt=ProbZ;
 drop CovParm Subject;
run;
data SAStemp.pe_GNLM_1_initial;
 set pe_GNLM_1 cov_GNLM_1;
run;
proc print data=SAStemp.pe_GNLM_1_initial;run;

data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='GNLM 1';
 /* Intra-subject covariance structure description */
 Structure='UN';                     
run;
ods output parameterestimates=SAStemp.pe_GNLM_1;
ods output FitStatistics=SAStemp.fit_GNLM_1;
proc nlmixed data=runmodel qpoints=1;* tech=newrap maxfunc=3000; 
 by Model Structure; 
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 eij = I1*e1+I2*e2+I3*e3+I4*e4+I5*e5+I6*e6+I7*e7; 
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 pred_avg = pred;
 _delta_=1e-8;
 mu = pred + eij;
 parms /data=SAStemp.pe_GNLM_1_initial;
 model UFR~normal(mu, _delta_);
 random e1 e2 e3 e4 e5 e6 e7 ~ 
        normal([ 0, 0, 0, 0, 0, 0, 0 ],
               [ psi11,
                 psi21, psi22,
                 psi31, psi32, psi33,
                 psi41, psi42, psi43, psi44,
                 psi51, psi52, psi53, psi54, psi55,
                 psi61, psi62, psi63, psi64, psi65, psi66,
                 psi71, psi72, psi73, psi74, psi75, psi76, psi77 ])
        subject=Dialyzer; 
 title 'GNLM 1: UN';
run;

%nlinmix(data=example5_4_3,                                          
  procopt=method=ml covtest cl,
  parms=%str(b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0), 
  model=%str( 
   TMPd = TMP/100; 
   beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
   beta2 = b21 + b22*Qb_300;
   beta3 = b31 + b32*Qb_300;
   predv = beta1*(1 - exp(-beta2*(TMPd-beta3)));
  ), 
  stmts=%str(
   class Dialyzer TMP_TARG;
   model pseudo_UFR = d_b11 d_b12 d_b13 d_b14 
                      d_b21 d_b22 d_b31 d_b32 / 
                      noint notest s cl;
   repeated TMP_TARG / subject=Dialyzer type=CS;
   ods output SolutionF=SAStemp.pe_GNLM_2_initial;
   ods output CovParms=SAStemp.cov_GNLM_2_initial;
  ),
  expand=eblup,
  options=
); 
run;

data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='GNLM 2';
 /* Covariance structure description */
 Structure='CS';                     
run;
ods output parameterestimates=SAStemp.pe_GNLM_2;
ods output FitStatistics=SAStemp.fit_GNLM_2;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;   
 by Model Structure;
 bounds sigsq_b>0;
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 pred_avg = pred;
 mu = pred + eij;
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       sigsq_w=.060 sigsq_b=.01 .1 1 / best=1; 
 model UFR~normal(mu, sigsq_w);
 random eij ~ normal(0, sigsq_b) subject=Dialyzer;
 title 'GNLM 2: CS';
run;


%nlinmix(data=example5_4_3, 
  procopt=method=ml covtest cl,
  parms=%str(b11=5 b12=0 b13=0 b14=0 
             b21=1 b22=0 b31=.20 b32=0),
  model=%str( 
   TMPd = TMP/100; 
   beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
   beta2 = b21 + b22*Qb_300;
   beta3 = b31 + b32*Qb_300;
   predv = beta1*(1 - exp(-beta2*(TMPd-beta3)));
  ), 
  stmts=%str(
   class Dialyzer TMP_TARG;
   model pseudo_UFR = d_b11 d_b12 d_b13 d_b14 
                      d_b21 d_b22 d_b31 d_b32 / 
                      noint notest s cl;
   repeated TMP_TARG / subject=Dialyzer type=CSH;
   ods output SolutionF=SAStemp.pe_GNLM_3_initial;
   ods output CovParms=SAStemp.cov_GNLM_3_initial;
  ),
  expand=eblup,
  options=
); 
run;

data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='GNLM 3';
 /* Covariance structure description */
 Structure='CSH';                     
run;
ods output parameterestimates=SAStemp.pe_GNLM_3;
ods output FitStatistics=SAStemp.fit_GNLM_3;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;
 by Model Structure;
 bounds -1<rho<1;
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 eij = I1*e1+I2*e2+I3*e3+I4*e4+I5*e5+I6*e6+I7*e7; 
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 pred_avg = pred;
 array cov[7,7];
 array sigsq_w[7] sigsq_w1-sigsq_w7;
 do i=1 to 7;
  do j=1 to 7;
   dij = 1-(i=j);
   cov[i,j] = sqrt(sigsq_w[i]*sigsq_w[j])*(rho**dij);    
  end;
 end;
 %vech(dim=7, cov=cov, name=c);
 _delta_=1e-8;
 mu = pred + eij;
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       sigsq_w1=.1 sigsq_w2=.1 sigsq_w3=.1 sigsq_w4=.1 
       sigsq_w5=.1 sigsq_w6=.1 sigsq_w7=.1 
       rho=.01 .1 .5 / best=1; 
 model UFR~normal(mu, _delta_);
 random e1 e2 e3 e4 e5 e6 e7 ~ 
        normal([ 0, 0, 0, 0, 0, 0, 0 ],
               [ c1 ,
                 c2 , c3 ,  
                 c4 , c5 , c6 ,
                 c7 , c8 , c9 , c10, 
                 c11, c12, c13, c14, c15,
                 c16, c17, c18, c19, c20, c21,
                 c22, c23, c24, c25, c26, c27, c28 ])
        subject=Dialyzer;
 title 'GNLM 3: CSH';
run;


data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='GNLM 4';
 /* Covariance structure description */
 Structure='CS-POM';                     
run;
ods output parameterestimates=SAStemp.pe_GNLM_4;
ods output FitStatistics=SAStemp.fit_GNLM_4;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;   
 by Model Structure;
 bounds sigsq_b>0;
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 pred_avg = pred;
 POM = pred**(2*delta);
 mu = pred + sqrt(POM)*eij;
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       sigsq_w=.060 sigsq_b=.01 .1 1 delta=0 .5 1 / best=1; 
 model UFR~normal( mu, sigsq_w*POM );
 random eij ~ normal(0, sigsq_b) subject=Dialyzer;
 title 'GNLM 4: CS-POM';
run;


%nlinmix(data=example5_4_3,                                          
  procopt=method=ml covtest cl,
  parms=%str(b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0), 
  model=%str( 
   TMPd = TMP/100; 
   beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
   beta2 = b21 + b22*Qb_300;
   beta3 = b31 + b32*Qb_300;
   predv = beta1*(1 - exp(-beta2*(TMPd-beta3)));
  ), 
  stmts=%str(
   class Dialyzer TMP_TARG;
   model pseudo_UFR = d_b11 d_b12 d_b13 d_b14 
                      d_b21 d_b22 d_b31 d_b32 / 
                      noint notest s cl;
   repeated TMP_TARG / subject=Dialyzer type=AR(1);
   ods output SolutionF=SAStemp.pe_GNLM_5_initial;
   ods output CovParms=SAStemp.cov_GNLM_5_initial;
  ),
  expand=eblup,
  options=
); 
run;

data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='GNLM 5';
 /* Covariance structure description */
 Structure='AR(1)';                     
run;
proc sort data=runmodel;
 by Model Structure Dialyzer TMP_TARG;
run;
ods output parameterestimates=SAStemp.pe_GNLM_5;
ods output FitStatistics=SAStemp.fit_GNLM_5;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;   
 by Model Structure;
 bounds -1<rho<1; 
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 eij = I1*e1+I2*e2+I3*e3+I4*e4+I5*e5+
	   I6*e6+I7*e7; 
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 pred_avg = pred;
 array cov[7,7];
 do i=1 to 7;
  do j=1 to 7;
   cov[i,j] = sigsq_w*(rho**abs(i-j));    
  end;
 end;
 %vech(dim=7, cov=cov, name=c);
 _delta_=1e-8;
 mu = pred + eij;
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       sigsq_w=.060 rho=.01 .1 .5 / best=1; 
 model UFR~normal(mu, _delta_);
 random e1 e2 e3 e4 e5 e6 e7 ~ 
        normal([ 0, 0, 0, 0, 0, 0, 0 ],
               [ c1 ,
                 c2 , c3 ,  
                 c4 , c5 , c6 ,
                 c7 , c8 , c9 , c10, 
                 c11, c12, c13, c14, c15,
                 c16, c17, c18, c19, c20, c21,
                 c22, c23, c24, c25, c26, c27, c28 ])
		subject=Dialyzer; 
 title 'GNLM 5: AR(1)';
run;

%nlinmix(data=example5_4_3,                                          
  procopt=method=ml covtest cl,
  parms=%str(b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0), 
  model=%str( 
   TMPd = TMP/100; 
   beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
   beta2 = b21 + b22*Qb_300;
   beta3 = b31 + b32*Qb_300;
   predv = beta1*(1 - exp(-beta2*(TMPd-beta3)));
  ), 
  stmts=%str(
   class Dialyzer TMP_TARG;
   model pseudo_UFR = d_b11 d_b12 d_b13 d_b14 
                      d_b21 d_b22 d_b31 d_b32 / 
                      noint notest s cl;
   repeated TMP_TARG / subject=Dialyzer type=ARH(1);
   ods output SolutionF=SAStemp.pe_GNLM_6_initial;
   ods output CovParms=SAStemp.cov_GNLM_6_initial;
  ),
  expand=eblup,
  options=
); 
run;

data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='GNLM 6';
 /* Covariance structure description */
 Structure='ARH(1)';                     
run;
ods output parameterestimates=SAStemp.pe_GNLM_6;
ods output FitStatistics=SAStemp.fit_GNLM_6;
proc nlmixed data=runmodel qpoints=1 tech=newrap maxfunc=1000;   
 by Model Structure;
 bounds -1<rho<1; 
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 eij = I1*e1+I2*e2+I3*e3+I4*e4+I5*e5+
	   I6*e6+I7*e7; 
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 pred_avg = pred;
 array cov[7,7];
 array sigsq_w[7] sigsq_w1-sigsq_w7;
 do i=1 to 7;
  do j=1 to 7;
   cov[i,j] = sqrt(sigsq_w[i]*sigsq_w[j])*(rho**abs(i-j));    
  end;
 end;
 %vech(dim=7, cov=cov, name=c);
 _delta_=1e-8;
 mu = pred + eij;
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       sigsq_w1=.1 sigsq_w2=.1 sigsq_w3=.1 sigsq_w4=.1 
       sigsq_w5=.1 sigsq_w6=.1 sigsq_w7=.1 rho=.01 .1 .5
      /best=1; 
 model UFR~normal(mu, _delta_);
 random e1 e2 e3 e4 e5 e6 e7 ~ 
        normal([ 0, 0, 0, 0, 0, 0, 0 ],
               [ c1 ,
                 c2 , c3 ,  
                 c4 , c5 , c6 ,
                 c7 , c8 , c9 , c10, 
                 c11, c12, c13, c14, c15,
                 c16, c17, c18, c19, c20, c21,
                 c22, c23, c24, c25, c26, c27, c28 ])
		subject=Dialyzer; 
 predict pred out=SAStemp.pred_GNLM_6;
 title 'GNLM 6: ARH(1)';
run;

data runmodel;
 length Model $7 Structure $25;
 set example5_4_3;
 /* Model description */
 Model='GNLM 7';
 /* Covariance structure description */
 Structure='AR(1)-POM';                     
run;
ods output parameterestimates=SAStemp.pe_GNLM_7;
ods output FitStatistics=SAStemp.fit_GNLM_7;
proc nlmixed data=runmodel qpoints=1;* tech=newrap maxfunc=1000;   
 by Model Structure;
 bounds -1<rho<1; 
 /* Rescale TMP to units of dmHg */
 TMPd = TMP/100;
 eij = I1*e1+I2*e2+I3*e3+I4*e4+I5*e5+
	   I6*e6+I7*e7; 
 beta1 = b11 + b12*Qb_300 + b13*TMPd + b14*TMPd*Qb_300; 
 beta2 = b21 + b22*Qb_300;
 beta3 = b31 + b32*Qb_300;
 pred = beta1*(1 - exp(-beta2*(TMPd-beta3)));
 pred_avg = pred;
 POM = pred**(2*delta);
 array cov[7,7];
 do i=1 to 7;
  do j=1 to 7; 
  *dij=(1-(i=j)); ** CS;
   dij=abs(i-j);  ** AR(1);
   cov[i,j] = sigsq_w*(rho**dij);    
  end;
 end;
 %vech(dim=7, cov=cov, name=c);
 _delta_=1e-8;
 mu = pred + sqrt(POM)*eij;
 parms b11=5 b12=0 b13=0 b14=0 b21=1 b22=0 b31=.20 b32=0
       sigsq_w=.01 .06 rho=.01 .1 .5 delta=0 .5 1 /best=1; 
 model UFR ~ normal(pred + sqrt(POM)*eij, _delta_);
 random e1 e2 e3 e4 e5 e6 e7 ~ 
        normal([ 0, 0, 0, 0, 0, 0, 0 ],
               [ c1 ,
                 c2 , c3 ,  
                 c4 , c5 , c6 ,
                 c7 , c8 , c9 , c10, 
                 c11, c12, c13, c14, c15,
                 c16, c17, c18, c19, c20, c21,
                 c22, c23, c24, c25, c26, c27, c28 ])
		subject=Dialyzer; 
 predict pred out=SAStemp.pred_GNLM_7;
 title 'GNLM 7: AR(1)-POM';
run;

%mend GNLM_Models;


/*----------------------------*/                    
/*--- Code for Output 5.30 ---*/    
/*----------------------------*/
ods listing close;
 %NLME_Models;
 %GNLM_Models;
 title;
ods listing;
data NLMEfit;
 set SAStemp.fit_NLME_1 SAStemp.fit_NLME_2 SAStemp.fit_NLME_3 /*SAStemp.fit_NLME_4*/
     SAStemp.fit_NLME_5 SAStemp.fit_NLME_6;
 Order=1;
run;
data GNLMfit;
 set SAStemp.fit_GNLM_1 SAStemp.fit_GNLM_2 SAStemp.fit_GNLM_3 SAStemp.fit_GNLM_4
     SAStemp.fit_GNLM_5 SAStemp.fit_GNLM_6 SAStemp.fit_GNLM_7;
 Order=2;
run;
data ModelFits;
 set NLMEfit GNLMfit;
 IC=Descr;
 if IC='-2 Log Likelihood'        then IC='-2L ' ;
 if IC='AIC (smaller is better)'  then IC='AIC ';
 if IC='AICC (smaller is better)' then IC='AICC';
 if IC='BIC (smaller is better)'  then IC='BIC ';
 drop Descr;
run;
proc sort data=ModelFits;
 by IC; 
run;
proc rank data=ModelFits out=RankModels;
 by IC;
 var Value;
 ranks Rank;
run;
proc report data=RankModels HEADLINE HEADSKIP SPLIT='|' nowindows;
 where IC ne '-2L';
 column Order Model Structure IC, (Value Rank);
 define Order / Group ' ' width=1 center;
 define Model / Group width=7 center; 
 define Structure / GROUP "Covariance|Structure" center width=25 ;
 define IC / Across "Information Criterion" width=25 center;
 define Value / MEAN FORMAT=7.2 'Statistic' 
                   width=9 NOZERO spacing=1;
 define Rank  / MEAN FORMAT=6.0 'Rank' 
                   width=6 NOZERO center spacing=1;
run;
quit;


/*----------------------------*/                    
/*--- Code for Figure 5.11 ---*/    
/*----------------------------*/
data plotfits1; 
 set SAStemp.pred_NLME_6 SAStemp.pred_GNLM_6;
run;  
proc sort data=plotfits1;
 by Model Qb TMP;
run;
ods graphics on / imagefmt=SASEMF imagename='Fig_5_11' reset=index;
proc sgpanel data=plotfits1;
 title "Fit and Confidence Band for the PA Mean Response of NLME Model 6 and GNLM Model 6";
 title2 "NLME model 6: -2 Log Likelihood = -27.6, AIC = 6.38, AICC = 11.40, BIC=23.31";
 title3 "GNLM model 6: -2 Log Likelihood = -27.1, AIC = 4.91, AICC =  9.34, BIC=20.84";
 panelby Model;
 band x=TMP lower=lower upper=upper / 
      Group=Qb legendlabel="95% CLM" name="band1"; 
 scatter x=TMP y=UFR /
         Group=Qb;
 series x=TMP y=pred / lineattrs=GraphPrediction
        Group=Qb markerattrs=(symbol=circle symbol=circlefilled) 
        legendlabel="Predicted Fit" name="series";
 label TMP='TMP (mmHg)'
       UFR='UFR (L/hour)'
       Qb='Qb (ml/min)'; 
run;
ods graphics off;
quit;
title;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/


