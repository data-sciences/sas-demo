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
/*=== Example 6.6.2. MDRD study - GFR data                        ===*/
/*===================================================================*/

/*----------------------------*/                    
/*--- Code for Output 6.4  ---*/    
/*----------------------------*/
data example6_6_2(rename=(DietK_LowBP=G1 
                          DietK_NormBP=G2
                          DietL_LowBP=G3
                          DietL_NormBP=G4
                          FollowupMonths=T));
 set SASdata.MDRD_data; 
 by ptid Months;
run;
proc print data=example6_6_2 noobs;
 where ptid in (1 7);
 var ptid G1 G2 G3 G4 Months GFR T Dropout;
run;

/* Compute an estimated mean follow-up time */
/* to be used in defining an empirically    */
/* derived residual dropout time covariate  */
proc means data=example6_6_2 noprint; where Months=0;
 var T;
 output out=meanT mean=meanT;
run;
data example6_6_2; set example6_6_2;
 if _n_=1 then set meanT;
 If G1=1 then DietBP='K, Low   ';
 If G2=1 then DietBP='K, Normal';
 If G3=1 then DietBP='L, Low   ';
 If G4=1 then DietBP='L, Normal';
 If G1=1 or G2=1 then Diet='K';
 if G3=1 or G4=1 then Diet='L';
 DietK=(Diet='K'); DietL=(Diet='L');
 /* Define Td to be an empirically derived   */
 /* residual dropout time having a mean of 0 */
 meanT=round(meanT,0.0001);
 Td = T-meanT;
 /* The following variables need to be defined */
 /* in order to run a SP model in NLMIXED      */
 Indicator=0; Response=GFR; t1=0; t2=0; Risktime=0; Event=0;
run;


/*----------------------------*/                    
/*--- Code for Figure 6.1  ---*/    
/*----------------------------*/
proc sort data=example6_6_2;
 by ptid months;
run;
ods graphics on / imagefmt=SASEMF imagename='Fig_6_1' reset=index;
proc sgpanel data=example6_6_2;
 title "GFR Profile of Patients by Diet and Blood Pressure Intervention";
 panelby DietBP;
 series x=Months y=GFR / Group=ptid  lineattrs=(color=black pattern=1)
        legendlabel="GFR Profile" name="series";
 label Months='Months'
       GFR='GFR (ml/min/1.73 m sq)'
       DietBP='Diet, BP'; 
run;
quit;
ods graphics off;
quit;
title;

/*----------------------------*/                    
/*--- Code for Output 6.5  ---*/    
/*----------------------------*/

/*===========================================================                                                    
 * The following programming statements create intervals 
 * for use with piecewise exponential survival analysis in
 * combination with MDRD nonignorable missing data analyses   
 * Key    t1 = Defines starting time point for the different
               intervals being created
          t2 = Defines ending time point for the different 
               intervals being created
       Event = Defines a 0-1 indicator which is 0 in each 
               interval until the interval in which the 
               actual dropout time occurs and then the value
               of Event equals the value of Dropout
    Risktime = Defines the time at risk within each interval
============================================================*/
data dropout;
 set example6_6_2;
 by ptid Months;
 if last.ptid;
run;
data dropout1;
 set dropout;
 do t1=0 to 36 by 6;
    if t1<36 then t2 = t1+6;
    if t1=36 then t2 = 45; 
    Event=0;
    Risktime=t2-t1;
    if t1<T<=t2 then do;
       Event=Dropout;
       Risktime=T-t1;
    end;
    output;
 end;
run;
data dropout1;
 set dropout1;
 Interval=t1;
 if t1>T then delete;
 Log_risktime=log(Risktime);
 Response=Event;
 Indicator=1;
run;
proc sort data=dropout1;
 by ptid t1 t2;
run; 
/* Dataset used for fitting all SP models */
data example6_6_2_SP;
 set example6_6_2 dropout1;
run;
proc sort data=example6_6_2_SP;
 by ptid Indicator Months;
run;
/* These MIXED and GENMOD calls are used */
/* to obtain joint estimates of the model*/
/* parameters for GFR and T under S-CRD  */
/* The results from these two models are */
/* then used to define starting values   */
/* for subsequent analyses using NLMIXED */
ods output SolutionR=re;
ods exclude SolutionR;
proc mixed data=example6_6_2 method=ML noclprint=5;
 class DietBP ptid;
 model GFR = DietBP DietBP*Months / noint s;
 random intercept Months / subject=ptid type=un s;
 contrast 'No Overall Diet & BP Intercept Effects' 
           DietBP 1 -1  0  0,
           DietBP 1  0 -1  0,
           DietBP 1  0  0 -1; 
 contrast 'No Overall Diet & BP Slope Effects' 
           DietBP*Months 1 -1  0  0,
           DietBP*Months 1  0 -1  0,
           DietBP*Months 1  0  0 -1; 
 estimate 'Diet K Slope:' 
          DietBP*Months .516 .484    0    0 ;  
 estimate 'Diet L Slope:' 
          DietBP*Months    0    0 .519 .481 ;  
 estimate 'Difference (K-L):' 
          DietBP*Months .516 .484 -.519 -.481;  
run;



/*----------------------------*/                    
/*--- Code for Output 6.6  ---*/    
/*----------------------------*/
ods select ParameterEstimates Type3;
proc genmod data=example6_6_2_SP;
 where Indicator=1;
 class t1 DietBP; 
 model Event = t1 DietBP / noint dist=Poisson 
                        offset=log_risktime
                        type3; 
run;


/*----------------------------*/                    
/*--- Code for Figure 6.2  ---*/    
/*----------------------------*/
data slopes;
 merge re dropout;
 by ptid;
 if effect='Months';
 keep effect ptid estimate dropout T DietBP;
run;
proc format;
 value dropfmt 0='Censored'
               1='Dropout';
run; 
ods graphics on / imagefmt=SASEMF imagename='Fig_6_2' reset=index;
proc sgpanel data=slopes;
 title "Empirical Bayes Estimates of Random Slope Errors by Diet and Blood Pressure";
 panelby DietBP;
 loess x=T y=estimate /group=dropout lineattrs=(color=black)
                       markerattrs=(color=black);
 refline 0 / axis=y lineattrs=(color=black pattern=1) ; 
 label T='Months of follow-up'
       estimate='Empirical Bayes Estimates of Random Slope Errors (ml/min/month)'
	   dropout='Dropout Status' 
       DietBP='Diet, BP'; 
 format dropout dropfmt.;
run;
quit;
ods graphics off;
quit;
title;

/*----------------------------*/                    
/*--- Code for Output 6.7  ---*/    
/*----------------------------*/
ods select SolutionF Contrasts Estimates; 
proc mixed data=example6_6_2 method=ML noclprint=5;
 class DietBP ptid;
 model GFR = DietBP Td DietBP*Months Td*Months / noint s;
 random intercept Months / subject=ptid type=un;
 contrast 'No Overall Diet & BP Intercept Effects' 
           DietBP 1 -1  0  0,
           DietBP 1  0 -1  0,
           DietBP 1  0  0 -1; 
 contrast 'No Overall Diet & BP Slope Effects' 
           DietBP*Months 1 -1  0  0,
           DietBP*Months 1  0 -1  0,
           DietBP*Months 1  0  0 -1; 
 estimate 'Diet K Intercept:' 
          DietBP .516 .484    0    0 ;  
 estimate 'Diet L Intercept:' 
          DietBP    0    0 .519 .481 ;  
 estimate 'Difference (K-L):' 
          DietBP .516 .484 -.519 -.481;  
 estimate 'Diet K Slope:' 
          DietBP*Months .516 .484    0    0 ;  
 estimate 'Diet L Slope:' 
          DietBP*Months    0    0 .519 .481 ;  
 estimate 'Difference (K-L):' 
          DietBP*Months .516 .484 -.519 -.481;  
run;


/*----------------------------*/                    
/*--- Code for Output 6.8  ---*/    
/*----------------------------*/
ods select Dimensions FitStatistics ParameterEstimates
           Contrasts AdditionalEstimates;
proc nlmixed data=example6_6_2 start 
             technique=newrap  
             qpoints=1;
 **************************************************
 The following define the model parameters:
   -(beta11, beta12,...) define the LME regression 
    parameters as rounded from PROC MIXED output
   -(psi11, psi12, psi22) define the random 
    effects covariance parameters (also rounded)
   -Sigma_Sq defines the within-subject variance,
   -MuT and VarT define the sample mean and variance  
    of the follow-up times T assuming normality
   -(b1i, b2i) define the random intercept and slope
 ***************************************************;  
 parms beta11=19.4 beta12=19.0 
       beta13=19.6 beta14=19.7 beta15=0
       beta21=-.25 beta22=-.25 
       beta23=-.29 beta24=-.33 beta25=0  
       psi11=19.9335 psi12=0.0613 psi22=0.05007  
       Sigma_Sq=5.2287  
       MuT=30 VarT=1;  
 ** Define SS intercepts and slopes **;
 beta1i=beta11*G1 + beta12*G2 + beta13*G3 + 
        beta14*G4 + beta15*(T-MuT) + b1i;
 beta2i=beta21*G1 + beta22*G2 + beta23*G3 + 
        beta24*G4 + beta25*(T-MuT) + b2i;
 MeanGFR = beta1i + beta2i*Months;
 VarGFR  = Sigma_Sq;
 ** ll_y is the conditional log-likelihood of GFR **; 
 ll_y = (- 0.5*log(2*CONSTANT('PI'))
         - 0.5*((GFR - MeanGFR)**2)/(VarGFR) 
         - 0.5*log(VarGFR));              
 ****************************************************
 ll_T is the marginal log-likelihood of T assuming 
 normality with mean MuT and variance VarT. T-MuT then 
 serves as a single residual covariate for the general
 linear mixture model (conditional LME model) for GFR 
 ****************************************************;  
 ll_T = (Months=0)*
        (- 0.5*log(2*CONSTANT('PI'))
         - 0.5*((T - MuT)**2)/(VarT) 
         - 0.5*log(VarT));              
 ** ll is the joint log-likelihood of (GFR,T) **;
 ll = ll_y + ll_T;
 ** response is a dummy response variable **;
 model response ~ general(ll); 
 random b1i b2i ~ normal([0,0],[psi11,
                                psi12, psi22])
        subject=ptid;
 ** Frequency of patients in each Diet and BP group **;
 f1=65;f2=61;f3=67;f4=62;
 ** Diet K and Diet L average intercepts and slopes **; 
 estimate 'Diet K Intercept:' 
          (f1*beta11+f2*beta12)/(f1+f2); 
 estimate 'Diet L Intercept:' 
          (f3*beta13+f4*beta14)/(f3+f4); 
 estimate 'Difference (K-L):' 
          (f1*beta11+f2*beta12)/(f1+f2) - 
          (f3*beta13+f4*beta14)/(f3+f4); 
 estimate 'Diet K Slope:' 
          (f1*beta21+f2*beta22)/(f1+f2); 
 estimate 'Diet L Slope:' 
          (f3*beta23+f4*beta24)/(f3+f4); 
 estimate 'Difference (K-L):'
          (f1*beta21+f2*beta22)/(f1+f2) - 
          (f3*beta23+f4*beta24)/(f3+f4); 
 contrast 'No Overall Diet & BP Intercept Effects:' 
           beta11-beta12, beta11-beta13, beta11-beta14;
 contrast 'No Overall Diet & BP Slope Effects:'   
           beta21-beta22, beta21-beta23, beta21-beta24;
run;


/*----------------------------*/                    
/*--- Code for Output 6.9  ---*/    
/*----------------------------*/
ods select Dimensions FitStatistics ParameterEstimates
           Contrasts AdditionalEstimates;
proc nlmixed data=example6_6_2_SP start 
             technique=newrap 
             qpoints=1;
 **************************************************
 The following defines the model parameters:
   -(beta11, beta12,...) define the LME regression 
    parameters including random effects, 
   -(psi11, psi12, psi22) define the random 
    effects covariance parameters,
   -Sigma_Sq defines the within-subject variance,
   -(eta0 eta1...eta_G1 eta_G2 eta_G3 eta_b1i eta_b2i)   
    define the PE regression parameters under
    the assumption of non-ignorable dropout,
   -(b1i, b2i) define the random intercept and slope
 ***************************************************;  
 parms beta11=19.4 beta12=19.0 beta13=19.6 beta14=19.7 
       beta21=-.25 beta22=-.25 beta23=-.29 beta24=-.33   
       psi11=19.9335 psi12=0.0613 psi22=0.05007  
       Sigma_Sq=5.2287 
       eta1=-6.14 eta2=-4.35 eta3=-3.62 eta4=-3.58  
       eta5=-4.18 eta6=-3.90 eta7=-4.21 
       eta_G1=-.1 eta_G2=-.1 eta_G3=-.1 
       eta_b1i=0 eta_b2i=0;
 ** Define SS intercepts and slopes **;
 beta1i = beta11*G1 + beta12*G2 + beta13*G3 + beta14*G4 + b1i;
 beta2i = beta21*G1 + beta22*G2 + beta23*G3 + beta24*G4 + b2i;
 MeanGFR = (beta1i + beta2i*Months);
 VarGFR  = Sigma_Sq;
 ** Define the log-hazard rate for a PE model **;
 eta_i = eta1*(t1=0) + eta2*(t1=6) + eta3*(t1=12) + 
         eta4*(t1=18) +  eta5*(t1=24) + eta6*(t1=30) + 
         eta7*(t1=36) +
         eta_G1*G1 + eta_G2*G2 + eta_G3*G3 +   
         eta_b1i*b1i + eta_b2i*b2i;
 ** Lambda_i defines the PE hazard rate per unit time **;
 Lambda_i = exp(eta_i);                          
 ** ll_y is the conditional log-likelihood of y=GFR **; 
 ll_y = (1-Indicator)*
        (- 0.5*log(2*CONSTANT('PI'))
         - 0.5*((GFR - MeanGFR)**2)/(VarGFR) 
         - 0.5*log(VarGFR));              
 **************************************************
 ** ll_T is the conditional log-likelihood of T 
    Here T is distributed across intervals according  
    to the variable risktime which is defined as the
    amount of time at risk within each interval (see
    above code defining the dataset example6_6_2_SP)   
    Note that b1i and b2i act as covariates for T
 ***************************************************;  
 ll_T = indicator*( Event*(eta_i) - Lambda_i*risktime );
 ** ll is the joint log-likelihood of (y,T) **;
 ll = ll_y + ll_T;
 ** response is a dummy response variable **;
 model response ~ general(ll); 
 random b1i b2i ~ normal([0,0],[psi11,
                                psi12, psi22])
        subject=ptid;
 ** Frequency of patients in each Diet and BP group **;
 f1=65;f2=61;f3=67;f4=62;
 ** Diet K and Diet L average intercepts and slopes **; 
 estimate 'Diet K Intercept:' 
          (f1*beta11+f2*beta12)/(f1+f2); 
 estimate 'Diet L Intercept:' 
          (f3*beta13+f4*beta14)/(f3+f4); 
 estimate 'Difference (K-L):' 
          (f1*beta11+f2*beta12)/(f1+f2) - 
          (f3*beta13+f4*beta14)/(f3+f4); 
 estimate 'Diet K Slope:' 
          (f1*beta21+f2*beta22)/(f1+f2); 
 estimate 'Diet L Slope:' 
          (f3*beta23+f4*beta24)/(f3+f4); 
 estimate 'Difference (K-L):'
          (f1*beta21+f2*beta22)/(f1+f2) - 
          (f3*beta23+f4*beta24)/(f3+f4); 
 contrast 'No Overall Diet & BP Intercept Effects:' 
           beta11-beta12, beta11-beta13, beta11-beta14;
 contrast 'No Overall Diet & BP Slope Effects:'   
           beta21-beta22, beta21-beta23, beta21-beta24;
 contrast 'No Treatment Effect on Dropout:'  
           eta_G1, eta_G2, eta_G3;
run;


/*----------------------------*/                    
/*--- Code for Output 6.10 ---*/    
/*----------------------------*/
data example6_6_2_PM;
 set example6_6_2;
 /* Define Missing Data Patterns  */
 d1=0;d2=0;d3=0;d4=0;d5=0;d6=0;
 if dropout=1 then do;
  if T<=12 then d1=1;
  if 12<T<=18 then d2=1;
  if 18<T<=24 then d3=1;
  if T>24 then d4=1;
 end;
 if dropout=0 then do;
  if T<=30 then d5=1;
  if T>30 then d6=1;
 end;
 if d1=1 then Pattern=1;
 if d2=1 then Pattern=2;
 if d3=1 then Pattern=3;
 if d4=1 then Pattern=4;
 if d5=1 then Pattern=5;
 if d6=1 then Pattern=6;
run;
proc sort data=example6_6_2_PM;
 by Diet ptid months;
run;
proc mixed data=example6_6_2_PM method=ml;
 class Diet ptid;
 model GFR=	Diet Diet*Months / noint s;
 random intercept Months / subject=ptid type=un;
 contrast 'No Diet effect on slopes' Diet*Months 1 -1;
 title 'Model 5 of Li and Schluchter (2004, Table I)';
run;
proc mixed data=example6_6_2_PM method=ml;
 class Diet Pattern ptid;
 model GFR = Diet*Pattern Diet*Pattern*Months / noint s;
 random intercept Months / subject=ptid type=un;
 title 'Model 4 of Li and Schluchter (2004, Table I)';
run;
proc glimmix data=example6_6_2_PM;
 where months=0;
 model Pattern = DietK / dist=multinomial link=glogit s;
run;
title;
/* Save all parameter estimates etc. */
/* in case we want to estimate other */
/* functions or test other hypotheses*/
ods output parameterestimates=SAStemp.pePM;
ods output fitstatistics=SAStemp.fitPM;
ods output additionalestimates=SAStemp.aePM;
proc nlmixed data=example6_6_2_PM start 
             technique=newrap maxfunc=1000 maxit=100
             qpoints=1 ;
 parms beta1_L=19.6  beta1_K=19.2
       beta1_L1=0 beta1_L2=0 beta1_L3=0 
       beta1_L4=0 beta1_L5=0 
       beta1_K1=0 beta1_K2=0 beta1_K3=0 
       beta1_K4=0 beta1_K5=0 
	   beta2_L=-.31 beta2_K=-.25
       beta2_L1=0 beta2_L2=0 beta2_L3=0 
       beta2_L4=0 beta2_L5=0 
       beta2_K1=0 beta2_K2=0 beta2_K3=0 
       beta2_K4=0 beta2_K5=0 
       psi11=19.9 psi12=0 psi22=0.05 Sigma_Sq=5.2 
	   phi_K1=0 phi_K2=0 phi_K3=0 phi_K4=0 phi_K5=0
	   phi_1=-1.6 phi_2=-1.2 phi_3=-1.3 
       phi_4=-1.4 phi_5=-.67;
 /* Define pattern-specific probability estimates   */
 /* as well as centered pattern-specific covariates */
 num_d1 = exp( (phi_1 + phi_K1*DietK ));
 num_d2 = exp( (phi_2 + phi_K2*DietK ));
 num_d3 = exp( (phi_3 + phi_K3*DietK ));
 num_d4 = exp( (phi_4 + phi_K4*DietK ));
 num_d5 = exp( (phi_5 + phi_K5*DietK ));
 den_d  = sum(of num_d1-num_d5);
 pi_d6 = 1/(1+den_d);  
 pi_d1 = pi_d6*num_d1; 
 pi_d2 = pi_d6*num_d2; 
 pi_d3 = pi_d6*num_d3; 
 pi_d4 = pi_d6*num_d4; 
 pi_d5 = pi_d6*num_d5; 
 d1_=d1-pi_d1;
 d2_=d2-pi_d2;
 d3_=d3-pi_d3;
 d4_=d4-pi_d4;
 d5_=d5-pi_d5;
 d6_=d6-pi_d6;
 numK_d1 = exp( (phi_1 + phi_K1) );
 numK_d2 = exp( (phi_2 + phi_K2) );
 numK_d3 = exp( (phi_3 + phi_K3) );
 numK_d4 = exp( (phi_4 + phi_K4) );
 numK_d5 = exp( (phi_5 + phi_K5) );
 denK_d  = sum(of numK_d1-numK_d5);
 piK_d6 = 1/(1+denK_d);
 piK_d1 = piK_d6*numK_d1;
 piK_d2 = piK_d6*numK_d2;
 piK_d3 = piK_d6*numK_d3;
 piK_d4 = piK_d6*numK_d4;
 piK_d5 = piK_d6*numK_d5;
 numL_d1 = exp( phi_1 );
 numL_d2 = exp( phi_2 );
 numL_d3 = exp( phi_3 );
 numL_d4 = exp( phi_4 );
 numL_d5 = exp( phi_5 );
 denL_d  = sum(of numL_d1-numL_d5);
 piL_d6 = 1/(1+denL_d);
 piL_d1 = piL_d6*numL_d1;
 piL_d2 = piL_d6*numL_d2;
 piL_d3 = piL_d6*numL_d3;
 piL_d4 = piL_d6*numL_d4;
 piL_d5 = piL_d6*numL_d5;
 /* Define patient-specific intercepts and slopes */
 beta1i=(beta1_L + beta1_L1*d1_ + beta1_L2*d2_ + beta1_L3*d3_ +
         beta1_L4*d4_ + beta1_L5*d5_ )*DietL +
        (beta1_K + beta1_K1*d1_ + beta1_K2*d2_ + beta1_K3*d3_ + 
         beta1_K4*d4_ + beta1_K5*d5_ )*DietK
         + b1i;
 beta2i=(beta2_L + beta2_L1*d1_ + beta2_L2*d2_ + beta2_L3*d3_ +
         beta2_L4*d4_ + beta2_L5*d5_ )*DietL +
        (beta2_K + beta2_K1*d1_ + beta2_K2*d2_ + beta2_K3*d3_ +
         beta2_K4*d4_ + beta2_K5*d5_ )*DietK
         + b2i;
 /* Define pattern-specific intercepts and slopes for Diet L */
 beta1L6_=(beta1_L1*piL_d1+beta1_L2*piL_d2+beta1_L3*piL_d3+
           beta1_L4*piL_d4+beta1_L5*piL_d5);
 beta1L6 = beta1_L - beta1L6_;
 beta2L6_=(beta2_L1*piL_d1+beta2_L2*piL_d2+beta2_L3*piL_d3+
           beta2_L4*piL_d4+beta2_L5*piL_d5);
 beta2L6 = beta2_L - beta2L6_;
 beta1L1 = beta1_L1 + beta1L6;  beta2L1 = beta2_L1 + beta2L6;
 beta1L2 = beta1_L2 + beta1L6;  beta2L2 = beta2_L2 + beta2L6;
 beta1L3 = beta1_L3 + beta1L6;  beta2L3 = beta2_L3 + beta2L6;
 beta1L4 = beta1_L4 + beta1L6;  beta2L4 = beta2_L4 + beta2L6;
 beta1L5 = beta1_L5 + beta1L6;  beta2L5 = beta2_L5 + beta2L6;
 /* Define pattern-specific intercepts and slopes for Diet K */
 beta1K6_=(beta1_K1*piK_d1+beta1_K2*piK_d2+beta1_K3*piK_d3+
           beta1_K4*piK_d4+beta1_K5*piK_d5);
 beta1K6 = beta1_K - beta1K6_;
 beta2K6_=(beta2_K1*piK_d1+beta2_K2*piK_d2+beta2_K3*piK_d3+
           beta2_K4*piK_d4+beta2_K5*piK_d5);
 beta2K6 = beta2_K - beta2K6_;
 beta1K1 = beta1_K1 + beta1K6;  beta2K1 = beta2_K1 + beta2K6;
 beta1K2 = beta1_K2 + beta1K6;  beta2K2 = beta2_K2 + beta2K6;
 beta1K3 = beta1_K3 + beta1K6;  beta2K3 = beta2_K3 + beta2K6;
 beta1K4 = beta1_K4 + beta1K6;  beta2K4 = beta2_K4 + beta2K6;
 beta1K5 = beta1_K5 + beta1K6;  beta2K5 = beta2_K5 + beta2K6;

 MeanGFR = (beta1i + beta2i*Months);
 VarGFR  = Sigma_Sq;

 ll_y = (- 0.5*log(2*CONSTANT('PI'))
         - 0.5*((GFR - MeanGFR)**2)/(VarGFR) 
         - 0.5*log(VarGFR));              
 ll_d = (months=0)*(  d1*log(pi_d1)+ d2*log(pi_d2)
                    + d3*log(pi_d3)+ d4*log(pi_d4)
                    + d5*log(pi_d5)+ d6*log(pi_d6) );              

 ** ll is the joint log-likelihood of (GFR,Pattern) **;
 ll = ll_y + ll_d;
 ** response is a dummy response variable **;
 model response ~ general(ll); 
 random b1i b2i ~ normal([0,0],[psi11,
                                psi12, psi22])
        subject=ptid;
 estimate 'Intercept L-Pattern 1:' beta1L1;
 estimate 'Intercept L-Pattern 2:' beta1L2;
 estimate 'Intercept L-Pattern 3:' beta1L3;
 estimate 'Intercept L-Pattern 4:' beta1L4;
 estimate 'Intercept L-Pattern 5:' beta1L5;
 estimate 'Intercept L-Pattern 6:' beta1L6;
 estimate 'Intercept K-Pattern 1:' beta1K1;
 estimate 'Intercept K-Pattern 2:' beta1K2;
 estimate 'Intercept K-Pattern 3:' beta1K3;
 estimate 'Intercept K-Pattern 4:' beta1K4;
 estimate 'Intercept K-Pattern 5:' beta1K5;
 estimate 'Intercept K-Pattern 6:' beta1K6;
 estimate 'Intercept L:' beta1_L;
 estimate 'Intercept K:' beta1_K;
 estimate 'Difference (L-K):' beta1_L - beta1_K;
 estimate 'Slope L-Pattern 1:' beta2L1;
 estimate 'Slope L-Pattern 2:' beta2L2;
 estimate 'Slope L-Pattern 3:' beta2L3;
 estimate 'Slope L-Pattern 4:' beta2L4;
 estimate 'Slope L-Pattern 5:' beta2L5;
 estimate 'Slope L-Pattern 6:' beta2L6;
 estimate 'Slope K-Pattern 1:' beta2K1;
 estimate 'Slope K-Pattern 2:' beta2K2;
 estimate 'Slope K-Pattern 3:' beta2K3;
 estimate 'Slope K-Pattern 4:' beta2K4;
 estimate 'Slope K-Pattern 5:' beta2K5;
 estimate 'Slope K-Pattern 6:' beta2K6;
 estimate 'Slope L:' beta2_L;
 estimate 'Slope K:' beta2_K;
 estimate 'Dfference (L-K):' beta2_L - beta2_K;
run;


/*----------------------------*/                    
/*--- Code for Output 6.11 ---*/    
/*----------------------------*/
ods select FitStatistics ParameterEstimates AdditionalEstimates;
proc nlmixed data=example6_6_2_SP start 
             technique=quanew 
             qpoints=1;
 **************************************************
 ** The following defines the model parameters:
   -(beta11, beta12,...) define the LME regression 
    parameters including random effects, 
   -(psi11, psi12, psi22) define the random 
    effects covariance parameters,
   -Sigma_Sq defines the within-subject variance,
   -(eta0 eta1...eta_DietK eta_b1i eta_b2i)   
    define the PE regression parameters under
	the assumption of non-ignorable dropout,
   -(b1i, b2i) define the random intercept and slope
 ***************************************************;  
 parms beta11=19.2 beta12=19.6  
       beta21=-.25 beta22=-.31   
       psi11=19.9391 psi12=0.0615 psi22=0.04997  
       Sigma_Sq=5.2324 
       eta1=-6.14 eta2=-4.35 eta3=-3.62 eta4=-3.58  
       eta5=-4.18 eta6=-3.90 eta7=-4.21 
       eta_DietK=-.1 eta_b1i=0 eta_b2i=0;
 ** Define SS intercepts and slopes **;
 beta1i = beta11*DietL + beta12*DietK + b1i;
 beta2i = beta21*DietL + beta22*DietK + b2i;
 MeanGFR = beta1i + beta2i*Months;
 VarGFR  = Sigma_Sq;
 ** Define the log-hazard rate for a PE model **;
 eta_i = eta1*(t1=0) + eta2*(t1=6) + eta3*(t1=12) + eta4*(t1=18) +
         eta5*(t1=24) + eta6*(t1=30) + eta7*(t1=36) +
         eta_DietK*DietK + eta_b1i*b1i + eta_b2i*b2i;
 ** Lambda_i defines the PE hazard rate per unit time **;
 Lambda_i = exp(eta_i);                          
 ** ll_y is the conditional log-likelihood of y=GFR **; 
 ll_y = (1-Indicator)*
        (- 0.5*log(2*CONSTANT('PI'))
         - 0.5*((GFR - MeanGFR)**2)/(VarGFR) 
         - 0.5*log(VarGFR));              
 **************************************************
 ** ll_T is the conditional log-likelihood of T 
    Here T is re-defined as T = Risktime which is the 
    amount of time at risk within each interval (see
    above code defining the dataset SP_data). Here b1i 
    and b2i serve as the covariates for time to dropout
 ***************************************************;  
 ll_T = indicator*( Event*(eta_i) - Lambda_i*risktime );
 ** ll is the joint log-likelihood of (y,T) **;
 ll = ll_y + ll_T;
 ** response is a dummy response variable **;
 model response ~ general(ll); 
 random b1i b2i ~ normal([0,0],[psi11,
                                psi12, psi22])
        subject=ptid;
 estimate 'Intercept L:' beta11; 
 estimate 'Intercept K:' beta12;
 estimate 'Difference (L-K):' 
           beta11-beta12;
 estimate 'Slope L:' beta21; 
 estimate 'Slope K:' beta22;
 estimate 'Difference (L-K):'
           beta21-beta22;
run;

/*------------------ Additional Analysis Not Shown --------------------*/ 
/* The pattern mixture model 4 of Li and Schluchter (2004) without     */
/* adjusted standard error estimates as estimated by the delta method. */
/* The results from this analysis agree with the NLMIXED results but   */
/* do not have the same standard errors and are not shown in the book. */
/*---------------------------------------------------------------------*/ 
proc freq data=example6_6_2_PM;
 where Months=0;
 by Diet;
 tables Pattern / list;
run;
proc mixed data=example6_6_2_PM method=ml;
 class Diet Pattern ptid;
 model GFR=	Diet*Pattern Diet*Pattern*Months / noint s;
 random intercept Months / subject=ptid type=un;
 estimate 'Intercept K' Diet*Pattern .0794 .1270 .0873 .0952 .1984 .4127 0 0 0 0 0 0;
 estimate 'Intercept L' Diet*Pattern 0 0 0 0 0 0 .0775 .1240 .1085 .0930 .2016 .3953;
 estimate 'Intercept K-L' Diet*Pattern .0794 .1270 .0873 .0952 .1984 .4127 
                                      -.0775 -.1240 -.1085 -.0930 -.2016 -.3953;
 estimate 'Slope K' Diet*Pattern*Months .0794 .1270 .0873 .0952 .1984 .4127 0 0 0 0 0 0;
 estimate 'Slope L' Diet*Pattern*Months 0 0 0 0 0 0 .0775 .1240 .1085 .0930 .2016 .3953;
 estimate 'Slope K-L' Diet*Pattern*Months .0794 .1270 .0873 .0952 .1984 .4127 
                                         -.0775 -.1240 -.1085 -.0930 -.2016 -.3953;
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

