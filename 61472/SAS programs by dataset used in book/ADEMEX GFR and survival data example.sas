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
/*=== Example 7.3.1. ADEMEX study - GFR data and survival         ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\covparms.sas' / nosource2;


proc format;
 value trtfmt 
 0='Control' 1='Treated';
run;
proc sort data=SASdata.ADEMEX_GFR_data 
          out=example7_3_1;
 by ptid Months;
run;
data example7_3_1;
 set example7_3_1;
 by ptid Months;
 Indicator=0;
 t1=0;t2=0;
 Risktime=1;
 Response=GFR_ml_min;
run;

/*===========================================================
 * The following programming statements create intervals 
 * for use with piecewise exponential survival analysis in
 * combination with analysis of the ADEMEX GFR data   
 * Key    t1 = Defines starting time point for the different
               intervals being created
          t2 = Defines ending time point for the different 
               intervals being created
       Event = Defines a 0-1 indicator which is 0 in each 
               interval until the interval in which the 
               actual survival time occurs and then the value
               of Event equals the value of ITTdeath
    Risktime = Defines the time at risk within each interval
============================================================*/
data survival;
 set example7_3_1;
 by ptid Months;
 if last.ptid;
run;
data survival1;
 set survival;
 do t1=0 to 24 by 6;
    if t1<24 then t2 = t1+6;
    if t1=24 then t2 = 36; 
    Event=0;
    Risktime=t2-t1;
    if t1<ITTtime<=t2 then do;
       Event=ITTdeath;
       Risktime=ITTtime - t1;
    end;
    output;
 end;
run;
data survival1;
 set survival1;
 Interval=t1;
 if t1>ITTtime then delete;
 Response=Event;
 Indicator=1;
run;
proc sort data=survival1;
 by ptid t1 t2;
run; 
/* Dataset used for fitting all SP models */
data example7_3_1_SP;
 set example7_3_1 survival1;
run;
proc sort data=example7_3_1_SP;
 by ptid Indicator Months;
run;


/*----------------------------*/                    
/*--- Code for Output 7.12 ---*/    
/*----------------------------*/
proc print data=example7_3_1_SP heading=h rows=page noobs;
 where ptid in ('01 001' '01 028');
 id ptid;
 var Indicator Trt Age Sex Diabetic Albumin0 nPNA0 GFR0 
     Months GFR_ml_min ITTdeath ITTtime 
     t1 t2 risktime event response; 
run;
proc phreg data=example7_3_1_SP;
 where t1=0 and indicator=1;
 model ITTtime*ITTdeath(0) = Trt Age Sex Diabetic 
                             Albumin0 nPNA0 GFR0;
 hazardratio Albumin0 / Units=0.1;
 hazardratio nPNA0 / Units=0.1;
 hazardratio Age / Units=10;
run;


/*----------------------------*/                    
/*--- Code for Output 7.13 ---*/    
/*----------------------------*/
/* Model 1 - Additive random effects and error */
ods output parameterestimates=SAStemp.pe1_1;
ods output fitstatistics=SAStemp.fit1_1;
ods select Specifications Dimensions IterHistory
           ConvergenceStatus FitStatistics ParameterEstimates;
proc nlmixed data=example7_3_1_SP start maxiter=500 empirical
             technique=quanew qpoints=1;
 parms beta11=.1 1 3 beta12=0 
       beta21=-1 -3 0.1 beta22=0 
       eta0=-5 eta1=0 eta2=0 eta3=0 eta4=0 
       eta_TRT=0 eta_Diabetic=0 eta_Age=0 eta_Sex=0
       eta_GFR0=0 eta_nPNA0=0 eta_Albumin0=0  
       psi11=.001 .01 1 10 100
       psi21=0
       psi22=.001 .01 1 10 100
       sigsq=.001 .01 1 10 100 / best=1;
 Model=1;
 ** Re-scale beta2i to be in units of (1/yr) **;
 ** so that the intercept parameter beta21 & **;
 ** psi22 are on a scale similar to beta11   **;
 beta1i = (beta11 + beta12*Trt + bi1);      
 beta2i = (beta21 + beta22*Trt + bi2)/12;     
 MeanGFR  = beta1i*exp(-beta2i*months);     
 VarGFR = sigsq;                            
 ** Define the log-hazard rate for a PE model **;
 eta_i = eta0 + eta1*(t1=6) + eta2*(t1=12) + 
         eta3*(t1=18) + eta4*(t1=24) + eta_TRT*Trt + 
         eta_Diabetic*Diabetic + eta_Age*Age + 
         eta_Sex*Sex + eta_nPNA0*nPNA0 + 
         eta_Albumin0*Albumin0 + eta_GFR0*GFR0 ;
 ** Lambda_i is the PE hazard rate per unit time **;
 Lambda_i = exp(eta_i);                          
 ** Hazard_i defines the PE hazard function **;
 Hazard_i = Lambda_i*risktime; 
 ** ll_y is the conditional log-likelihood of y=GFR **; 
 ll_y = (1-Indicator)*
        (- 0.5*log(2*CONSTANT('PI'))
         - 0.5*((response - MeanGFR)**2)/(VarGFR) 
         - 0.5*log(VarGFR));    
 **************************************************
 ** ll_T is the conditional log-likelihood of T 
 where T is defined as T = Risktime which is the 
 amount of time at risk within each interval (see
 code defining the dataset example7_3_1_SP)   
 for the piecewise exponential survival model
 ***************************************************;  
 ll_T = Indicator*( response*(eta_i) - Lambda_i*risktime );
 ** ll is the joint log-likelihood of (y,T) **;
 ll = ll_y + ll_T;
 model response ~ general(ll);
 random bi1 bi2 ~ normal([0,0],[psi11, 
                                psi21, psi22])
                  subject=ptid;
 id Model MeanGFR VarGFR sigsq beta11 beta12 beta21 beta22 
    psi11 psi22 beta1i beta2i bi1 bi2 
    eta_i Lambda_i Hazard_i ll_y ll_T;
 predict MeanGFR out=SAStemp.nlmix1_1;
run;


/*----------------------------*/                    
/*--- Code for Output 7.14 ---*/    
/*----------------------------*/
/* Model 2 - Multiplicative random effects and error */
ods output parameterestimates=SAStemp.pe2_1;
ods output AdditionalEstimates=SAStemp.ae2_1;
ods output fitstatistics=SAStemp.fit2_1;
ods select Dimensions FitStatistics 
           ParameterEstimates AdditionalEstimates;
proc nlmixed data=example7_3_1_SP start maxiter=500 empirical
             technique=newrap qpoints=1; ** Requires NEWRAP **;
 parms beta11=.1 1 3 beta12=0 
       beta21=-1 -3 0.1 beta22=0 
       eta0=-5 eta1=0 eta2=0 eta3=0 eta4=0 
       eta_TRT=0 eta_Diabetic=0 eta_Age=0 eta_Sex=0
       eta_GFR0=0 eta_nPNA0=0 eta_Albumin0=0  
       theta=.001 .01 1 2 
       psi11=.001 .01 1 10 100
	   psi21=0
       psi22=.001 .01 1 10 100
       sigsq=.001 .01 1 10 100 / best=1;
 Model=2;
 ** Ensures beta1i>0 and beta2i>00 **;
 beta1i = exp(beta11 + beta12*Trt + bi1);       
 beta2i = exp(beta21 + beta22*Trt + bi2);       
 MeanGFR  = beta1i*exp(-beta2i*months);         
 VarGFR = sigsq*(MeanGFR**(2*theta));            
 ** Define the log-hazard rate for a PE model **;
 eta_i = eta0 + eta1*(t1=6) + eta2*(t1=12) + 
         eta3*(t1=18) + eta4*(t1=24) + eta_TRT*Trt + 
         eta_Diabetic*Diabetic + eta_Age*Age + 
         eta_Sex*Sex + eta_nPNA0*nPNA0 + 
         eta_Albumin0*Albumin0 + eta_GFR0*GFR0 ;
 ** Lambda_i is the PE hazard rate per unit time **;
 Lambda_i = exp(eta_i);                          
 ** Hazard_i defines the PE hazard function **;
 Hazard_i = Lambda_i*risktime; 
 ** ll_y is the conditional log-likelihood of y=GFR **; 
 ll_y = (1-Indicator)*
        (- 0.5*log(2*CONSTANT('PI'))
         - 0.5*((response - MeanGFR)**2)/(VarGFR) 
         - 0.5*log(VarGFR));    
 ** ll_T is the log-likelihood function for T **;  
 ll_T = Indicator*( response*(eta_i) - Lambda_i*risktime );
 ** ll is the joint log-likelihood of (y,T) **;
 ll = ll_y + ll_T;
 model response ~ general(ll);
 random bi1 bi2 ~ normal([0,0],[psi11, 
                                psi21, psi22])
                  subject=ptid;
 estimate "PA Intercept(Control):" 
          exp(beta11 + .5*psi11);
 estimate "PA Intercept(Treated):" 
          exp(beta11 + beta12 + .5*psi11);
 estimate "PA Intercept(Diff):" 
          exp(beta11 + .5*psi11) - 
          exp(beta11 + beta12 + .5*psi11);
 estimate "SS Intercept(Control):" 
          exp(beta11);
 estimate "SS Intercept(Treated):" 
          exp(beta11 + beta12);
 estimate "SS Intercept(Diff):" 
          exp(beta11) - exp(beta11 + beta12);
 estimate "PA Decay Rate(Control):" 
          exp(beta21 + .5*psi22);
 estimate "PA Decay Rate(Treated):" 
          exp(beta21 + beta22 + .5*psi22);
 estimate "PA Decay Rate(Diff):" 
          exp(beta21 + .5*psi22) -
          exp(beta21 + beta22 + .5*psi22);
 estimate "SS Decay Rate(Control):" 
          exp(beta21);
 estimate "SS Decay Rate(Treated):" 
          exp(beta21 + beta22);
 estimate "SS Decay Rate(Diff):" 
          exp(beta21) - exp(beta21 + beta22);
 id Model MeanGFR VarGFR sigsq beta11 beta12 beta21 beta22 
    theta psi11 psi22 beta1i beta2i bi1 bi2 
    eta_i Lambda_i Hazard_i ll_y ll_T;
 predict MeanGFR out=SAStemp.nlmix2_1;
run;




/* MACRO CREATE_PLOTDATA is used to generate */
/* Figure 1.6, Figure 7.4 and Figure 7.5     */
%macro create_plotdata(data=,plotdata=plot1);
proc sort data=&data;
 by Trt ptid months;
run;

data nlmix_INDIV;
 set &data;
 by Trt ptid months;
 if first.ptid;
 if Model=1 then do;
  beta1_typ = (beta11 + beta12*Trt);
  beta2_typ = (beta21 + beta22*Trt)/12;       
  beta1_avg = (beta11 + beta12*Trt);
  beta2_avg = (beta21 + beta22*Trt)/12;       
 end;
 if Model=2 then do;
  beta1_typ = exp(beta11 + beta12*Trt);
  beta2_typ = exp(beta21 + beta22*Trt);       
  beta1_avg = exp(beta11 + beta12*Trt + .5*psi11);
  beta2_avg = exp(beta21 + beta22*Trt + .5*psi22);       
 end;
 keep Trt Model ptid beta1_typ beta2_typ beta1_avg beta1_avg beta2_avg
      beta1i beta2i beta11 beta12 beta21 beta22 bi1 bi2;
run;

data nlmix_INDIV;
 set nlmix_INDIV;
 by Trt ptid;
 do AvgMonths=0 to 30 by 1;
    PredGFR_ind = beta1i*exp(-beta2i*AvgMonths);
    PredGFR_ind = beta1i*exp(-beta2i*AvgMonths);
    PredGFR_avg = beta1_avg*exp(-beta2_avg*AvgMonths);
    PredGFR_typ = beta1_typ*exp(-beta2_typ*AvgMonths);
    output;
 end;
run;

proc means data=nlmix_INDIV noprint mean nway;
 class Trt AvgMonths;
 id Model;
 var PredGFR_ind PredGFR_avg PredGFR_typ;
 output out=nlmix_AVG mean=PredGFR_pop PredGFR_avg PredGFR_typ;
run;

data nlmix_AVG;
 set nlmix_AVG;
 by Trt AvgMonths;
run;

data nlmix;
 set &data;
 if indicator=0;
 AvgMonths=Round(Months);
run;

proc sort data=nlmix;
 by Trt AvgMonths;
run;

data &plotdata;
 merge nlmix nlmix_AVG;
 by Trt AvgMonths;
 keep Trt Model ptid AvgMonths Months GFR_ml_min PredGFR_pop PredGFR_avg PredGFR_typ; 
run;

proc sort data=&plotdata;
 by Trt ptid AvgMonths Months;
run;

proc print data=&plotdata(obs=10);
 var Trt Model ptid AvgMonths Months GFR_ml_min PredGFR_pop PredGFR_avg PredGFR_typ; 
run;

proc sort data=&plotdata;
 by Model Trt AvgMonths;
run;

%mend create_plotdata;

goptions reset=all rotate=landscape gsfmode=replace ftext=swiss
	     htext=1.5 hby=1.5 device=sasemf;
goptions reset=symbol;
run;


/*----------------------------*/                    
/*--- Code for Figure 1.6  ---*/    
/*----------------------------*/
%create_plotdata(data=SAStemp.nlmix1_1, plotdata=plot1_1);
proc gplot data=plot1_1 gout=SASgraph.chapterfigures;
  where trt=0;
  axis1 label=(a=90 "GFR (ml/min)") 
        order=0 to 8 by 1
        minor=none;
  axis2 length=75 pct 
        label=('Months of Follow-up') 
	    order=0 to 28 by 4
        minor=none;
  axis3 label=none order=0 to 8 by 1 minor=none value=none;
  legend1 position=(top inside right) 
          label=none 
          shape=line(4)
          down=2
          value=(h=1.5 t=1 'SS Mean Response' t=2 'PA Mean Response');
  plot PredGFR_typ*AvgMonths=1 
       PredGFR_pop*AvgMonths=2 
     / overlay legend=legend1 vaxis=axis1 haxis=axis2 frame name='Fig_1_6';
  plot2 GFR_ml_min*AvgMonths=ptid 
     / nolegend vaxis=axis3;
  symbol1 c=black h=1.5 v=none   i=join l=27 w=3 mode=include;
  symbol2 c=black h=1.5 v=none   i=join l=1  w=3 mode=include;
  symbol3 c=black h=1.5 v=none   i=join l=33 w=.01 r=1000 mode=exclude;
  title 'Control Patients';
  footnote;
run;
quit; 


/*----------------------------*/                    
/*--- Code for Figure 7.4  ---*/    
/*----------------------------*/
%create_plotdata(data=SAStemp.nlmix2_1, plotdata=plot2_1);
proc gplot data=plot2_1 gout=SASgraph.chapterfigures;
 where Trt=0;
 axis1 label=(a=90 "GFR (ml/min)") 
       order=0 to 8 by 1
       minor=none;
 axis2 length=75 pct 
       label=('Months of Follow-up') 
       order=0 to 28 by 4 minor=none;
 axis3 label=none order=0 to 8 by 1 minor=none value=none;
 legend1 position=(top inside right) 
         label=none 
         shape=line(5)
         down=2
         value=(h=1.5  t=1 'SS Mean Response(typ.)' 
                       t=2 'SS Mean Response(avg.)' 
                       t=3 'PA Mean Response' );
 plot PredGFR_typ*AvgMonths=1 
      PredGFR_avg*AvgMonths=2 
      PredGFR_pop*AvgMonths=3 
    / overlay legend=legend1 vaxis=axis1 haxis=axis2 frame name='Fig_7_4';
 plot2 GFR_ml_min*AvgMonths=ptid 
    / nolegend vaxis=axis3;
 symbol1 c=black h=1.5 v=none   i=join l=27 w=3 r=1 mode=include;
 symbol2 c=black h=1.5 v=none   i=join l=3  w=3 r=1 mode=include;
 symbol3 c=black h=1.5 v=none   i=join l=1  w=3 r=1 mode=include;
 symbol4 c=black h=1.5 v=none   i=join l=33 w=.01 r=1000;
 title 'Control Patients' ;
 footnote;
 format Trt trtfmt.;
run;
quit;


/*----------------------------*/                    
/*--- Code for Figure 7.5  ---*/    
/*----------------------------*/
data plotALL;
 set plot1_1 plot2_1;
run;
proc sort data=plotALL;
 by Model Trt AvgMonths;
run; 
proc gplot data=plotALL gout=SASgraph.chapterfigures;
  where Trt=0;
  by Model;
  axis1 label=(a=90 "GFR (ml/min)") 
        order=0 to 8 by 1
        minor=none;
  axis2 length=75 pct 
        label=('Months of Follow-up') 
	    order=0 to 28 by 4
		offset=(1 cm, 0 cm)
        minor=none;
  axis3 label=none order=0 to 8 by 1 minor=none value=none;
  legend1 position=(top inside right) 
          label=none 
		  shape=line(7) down=2
          value=(h=1.5 t=1 'SS Mean Response(typ.)' t=2 'PA Mean Response');
  plot predGFR_typ*AvgMonths=1
       predGFR_pop*AvgMonths=2
     / overlay legend=legend1 vaxis=axis1 haxis=axis2 frame name='model';
  plot2 GFR_ml_min*AvgMonths=3 
     / nolegend vaxis=axis3 frame;
  symbol1 c=black h=1.5 v=none   i=join l=27 w=3 mode=include;
  symbol2 c=black h=1.5 v=none   i=join l=1  w=3 mode=include;
  symbol3 c=black h=1.5 v=none   i=std1tj l=1 w=1 r=1 mode=exclude;
  title 'Control Patients';
  footnote;
 run;
quit;
title;
proc greplay igout=SASgraph.chapterfigures 
             gout=SASgraph.chapterfigures 
             nofs template=scat21 tc=temp;
		tdef scat21 des="scatterplots 2x1 display"
		    1/ulx=0 uly=100 urx=50 ury=100 llx=0 lly=0 lrx=50 lry=0
		    2/copy=1 xlatex=50;
		treplay 1:model 2:model1 name='Fig_7_5';
run;
quit;



/*----------------------------*/                    
/*--- Code for Output 7.15 ---*/    
/*----------------------------*/
data peNEW;
 Parameter='eta_bi1';estimate=0;output;
 Parameter='eta_bi2';estimate=0;output;
run;
data initial;
 set SAStemp.pe1_1 peNEW;
 if Parameter in ('eta_GFR0') then delete;
run;
ods output parameterestimates=SAStemp.pe1_2;
ods output fitstatistics=SAStemp.fit1_2;
ods select Dimensions FitStatistics 
           ParameterEstimates;
proc nlmixed data=example7_3_1_SP start maxiter=500 empirical
             technique=quanew qpoints=1;
 parms / data=initial;
 Model=3;
 beta1i = (beta11 + beta12*Trt + bi1);      
 beta2i = (beta21 + beta22*Trt + bi2)/12;     
 MeanGFR  = beta1i*exp(-beta2i*months);     
 VarGFR = sigsq;                            
 ** Define the log-hazard rate for a PE model **;
 eta_i = eta0 + eta1*(t1=6) + eta2*(t1=12) + 
         eta3*(t1=18) + eta4*(t1=24) + eta_TRT*Trt + 
         eta_Diabetic*Diabetic + eta_Age*Age + 
         eta_Sex*Sex + eta_nPNA0*nPNA0 + 
         eta_Albumin0*Albumin0 + 
         eta_bi1*bi1 + eta_bi2*bi2;
 ** Lambda_i is the PE hazard rate per unit time **;
 Lambda_i = exp(eta_i);                          
 ** Hazard_i defines the PE hazard function **;
 Hazard_i = Lambda_i*risktime; 
 ** ll_y is the conditional log-likelihood of y=GFR **; 
 ll_y = (1-Indicator)*
        (- 0.5*log(2*CONSTANT('PI'))
         - 0.5*((response - MeanGFR)**2)/(VarGFR) 
         - 0.5*log(VarGFR));    
 **************************************************
 ** ll_T is the conditional log-likelihood of T 
 where T is defined as T = Risktime which is the 
 amount of time at risk within each interval (see
 above code defining the dataset SP_data). Here b1i 
 and b2i serve as the covariates for time to survival
 ***************************************************;  
 ll_T = Indicator*( response*(eta_i) - Lambda_i*risktime );
 ** ll is the joint log-likelihood of (y,T) **;
 ll = ll_y + ll_T;
 model response ~ general(ll);
 random bi1 bi2 ~ normal([0,0],[psi11, 
                                psi21, psi22])
                  subject=ptid;
 HR_bi2 = exp(eta_bi2*bi2);
 id Model MeanGFR VarGFR sigsq beta11 beta12 beta21 beta22 
    psi11 psi22 beta1i beta2i bi1 bi2 eta_bi1 eta_bi2 eta_Trt
    eta_i Lambda_i Hazard_i ll_y ll_T;
 predict HR_bi2 out=SAStemp.nlmix1_2;
run;


/*----------------------------*/                    
/*--- Code for Output 7.16 ---*/    
/*----------------------------*/
data peNEW;
 Parameter='eta_bi1';estimate=0.50;output;
 Parameter='eta_bi2';estimate=0.50;output;
run;
data initial;
 set SAStemp.pe2_1 peNEW;
 if Parameter in ('eta_GFR0') then delete;
run;
ods output parameterestimates=SAStemp.pe2_2;
ods output AdditionalEstimates=SAStemp.ae2_2;
ods output fitstatistics=SAStemp.fit2_2;
ods select Dimensions FitStatistics 
           ParameterEstimates AdditionalEstimates;
proc nlmixed data=example7_3_1_SP start maxiter=500 empirical
             technique=newrap qpoints=1;
 parms / data=initial;
 Model=4;
 ** Ensures beta1i>0 and beta2i>00 **;
 beta1i = exp(beta11 + beta12*Trt + bi1);       
 beta2i = exp(beta21 + beta22*Trt + bi2);   
 MeanGFR  = beta1i*exp(-beta2i*months);         
 VarGFR = sigsq*(MeanGFR**(2*theta));            
 ** Define the log-hazard rate for a PE model **;
 eta_i = eta0 + eta1*(t1=6) + eta2*(t1=12) + 
         eta3*(t1=18) + eta4*(t1=24) + eta_TRT*Trt + 
         eta_Diabetic*Diabetic + eta_Age*Age + 
         eta_Sex*Sex + eta_nPNA0*nPNA0 + 
         eta_Albumin0*Albumin0 + 
         eta_bi1*bi1 + eta_bi2*bi2;
 ** Lambda_i is the PE hazard rate per unit time **;
 Lambda_i = exp(eta_i);                          
 ** Hazard_i defines the PE hazard function **;
 Hazard_i = Lambda_i*risktime; 
 ** ll_y is the conditional log-likelihood of y=GFR **; 
 ll_y = (1-Indicator)*
        (- 0.5*log(2*CONSTANT('PI'))
         - 0.5*((response - MeanGFR)**2)/(VarGFR) 
         - 0.5*log(VarGFR));    
 **************************************************
 ** ll_T is the conditional log-likelihood of T 
 where T is defined as T = Risktime which is the 
 amount of time at risk within each interval (see
 above code defining the dataset SP_data). Here b1i 
 and b2i serve as the covariates for time to survival
 ***************************************************;  
 ll_T = Indicator*( response*(eta_i) - Lambda_i*risktime );
 ** ll is the joint log-likelihood of (y,T) **;
 ll = ll_y + ll_T;
 model response ~ general(ll);
 random bi1 bi2 ~ normal([0,0],[psi11, 
                                psi21, psi22])
                  subject=ptid;
 estimate "PA Intercept(Control):" 
          exp(beta11 + .5*psi11);
 estimate "PA Intercept(Treated):" 
          exp(beta11 + beta12 + .5*psi11);
 estimate "PA Intercept(Diff):" 
          exp(beta11 + .5*psi11) - 
          exp(beta11 + beta12 + .5*psi11);
 estimate "SS Intercept(Control):" 
          exp(beta11);
 estimate "SS Intercept(Treated):" 
          exp(beta11 + beta12);
 estimate "SS Intercept(Diff):" 
          exp(beta11) - exp(beta11 + beta12);
 estimate "PA Decay Rate(Control):" 
          exp(beta21 + .5*psi22);
 estimate "PA Decay Rate(Treated):" 
          exp(beta21 + beta22 + .5*psi22);
 estimate "PA Decay Rate(Diff):" 
          exp(beta21 + .5*psi22) -
          exp(beta21 + beta22 + .5*psi22);
 estimate "SS Decay Rate(Control):" 
          exp(beta21);
 estimate "SS Decay Rate(Treated):" 
          exp(beta21 + beta22);
 estimate "SS Decay Rate(Diff):" 
          exp(beta21) - exp(beta21 + beta22);
 HR_bi2 = exp(eta_bi2*bi2);
 id Model MeanGFR VarGFR sigsq beta11 beta12 beta21 beta22 
    theta psi11 psi22 beta1i beta2i bi1 bi2 eta_bi1 eta_bi2  
    eta_Trt eta_i Lambda_i Hazard_i ll_y ll_T;
 predict HR_bi2 out=SAStemp.nlmix2_2;
run;


/* MACRO HR computes select hazard ratio estimates */
%macro HR(data=, unit_bi1=1, unit_bi2=1);
 ** &unit_bi1 and &unit_bi2 define the unit  **
 ** measure of increase for bi1 and bi2 with ** 
 ** which to compute the hazard ratio for    ** 
 ** the latent random effects bi1 and bi2    **; 
 data hazards;
  set &data;
  if Parameter IN ('eta_TRT'  'eta_Diabetic' 
                   'eta_GFR0' 'eta_Sex') 
  then do;
    Units=1.0;
    HR=exp(estimate*Units);
    LCL=exp(lower*Units);
    UCL=exp(upper*Units); 
  end;
  if Parameter IN ('eta_Age') 
  then do;
    Units=10.0;
    HR=exp(estimate*Units);
    LCL=exp(lower*Units);
    UCL=exp(upper*Units); 
  end;
  if Parameter IN ('eta_bi1') then do;
    Units=&unit_bi1;
    HR=exp(estimate*Units);
    LCL=exp(lower*Units);
    UCL=exp(upper*Units); 
  end;
  if Parameter IN ('eta_bi2') then do;
    Units=&unit_bi2;
    HR=exp(estimate*Units);
    LCL=exp(lower*Units);
    UCL=exp(upper*Units); 
  end;
  if Parameter IN ('eta_nPNA0' 'eta_Albumin0')
  then do;
    Units=0.1;
    HR=exp(estimate*Units);
    LCL=exp(lower*Units);
    UCL=exp(upper*Units); 
  end;
  StdErr=StandardError;
 run;
 ods listing;
 proc print data=hazards noobs;
  where HR ne .;
  var Parameter Estimate StdErr Probt 
      Lower Upper Units HR LCL UCL;
  format HR LCL UCL 5.2; 
 run; 
%mend HR;


/*----------------------------*/                    
/*--- Code for Output 7.17 ---*/    
/*----------------------------*/
%HR(data=SAStemp.pe1_1);
data HR1;
 set Hazards;
 Model=1;
run;
%HR(data=SAStemp.pe1_2,unit_bi1=0.5, 
                       unit_bi2=0.1/12);
data HR3;
 set Hazards;
 Model=3;
run;
%HR(data=SAStemp.pe2_2,unit_bi1=log(1.165), 
                       unit_bi2=log(1.11));
data HR4;
 set Hazards;
 Model=4;
run;
data HR;
 set HR1 HR3 HR4;
run;
proc sort data=HR;
 by Model;
run;
proc print data=HR noobs;
 where HR ne .;
 by Model; id Model;
 var Parameter Estimate Lower Upper Units HR LCL UCL;
 format HR LCL UCL 5.2 Units 5.3; 
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

