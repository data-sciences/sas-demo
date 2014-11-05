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
/*=== Example 5.4.2. Soybean growth data                          ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\covparms.sas' / nosource2;
%include 'c:\SAS macros used in book\nlinmix.sas' /nosource2;

/* Step 1: Arrange Data and Get Starting Values */
data Example5_4_2;
 set SASdata.Soybean_Data; 
 Days=D1 ;Weight=W1 ; output;
 Days=D2 ;Weight=W2 ; output;
 Days=D3 ;Weight=W3 ; output;
 Days=D4 ;Weight=W4 ; output;
 Days=D5 ;Weight=W5 ; output;
 Days=D6 ;Weight=W6 ; output;
 Days=D7 ;Weight=W7 ; output;
 Days=D8 ;Weight=W8 ; output;
 Days=D9 ;Weight=W9 ; output;
 Days=D10;Weight=W10; output;
 drop D1-D10 W1-W10;
run;
data Example5_4_2;
 set Example5_4_2;
 Trt=Compress(Trim(Genotype)||'-'||Trim(Year));
 /* Rename response variable as y */
 y=Weight;
 /* Define cell means indicator variables */
 X1=(Trt='F-1988');
 X2=(Trt='P-1988');
 X3=(Trt='F-1989');
 X4=(Trt='P-1989');
 X5=(Trt='F-1990');
 X6=(Trt='P-1990');
 _Days_=Days; 
 if y=. then delete;
run;

/*---------------------------
proc sort data=Example5_4_2;
 by Trt Days subject;
run;
---------------------------*/

/*----------------------------------------------------------------------------------
NOTE: The above commented out SORT is what is shown in Program 5.15 of the book.
      This PROC SORT shown in the book erroneously sorts by Trt Days and subject
      but since there is no variable subject in the dataset, this results in an 
      error message. However, the data is already sorted by Plot (which is the 
      SUBJECT variable needed for NLMIXED) and the results in the book remain valid. 
      One can correct the above sort with

      proc sort data=Example5_4_2;
       by Plot Trt Days;
      run;
 
      and get the same results as in the book. However, we need first sort by Trt, 
      Days and Plot in order to generate Figure 1.4 of the book and then use the  
      correct SORT to run NLMIXED.                                                 
----------------------------------------------------------------------------------*/

/*----------------------------*/                    
/*--- Code for Figure 1.4  ---*/    
/*----------------------------*/
proc sort data=Example5_4_2;
 by Trt Days Plot;
run;
goptions reset=all rotate=landscape ftext=swiss
         htitle=1.75 htext=1.75 hby=1.75 device=sasemf;
proc gplot data=Example5_4_2 gout=SASgraph.chapterfigures;
 by trt;
 axis1 label = (A=90 R=0 'Leaf Weights (g)')
       order= 0 to 40 by 10
       minor = none;
 axis4 order = 0 to 90 by 15
       label = ('Days after planting')
       minor = none;
 plot Weight*Days=Plot / vaxis=axis1 haxis=axis4 frame nolegend name='WTxDAYS';
 symbol1 C=black H=1.0 V=dot I=join L=1 W=1 R=48;
 title;   
run;
quit;
proc greplay igout=SASgraph.chapterfigures 
             gout=SASgraph.chapterfigures 
             nofs template=scat23 tc=temp;
 tdef SCAT23 DES="Scatterplots 2x3 Display"
   1/ULX=0 ULY=100 URX=33 URY=100 LLX=0 LLY=50 LRX=33 LRY=50
   2/COPY=1 XLATEX=33
   3/COPY=2 XLATEX=34
   4/COPY=1 XLATEY=-50
   5/COPY=2 XLATEY=-50
   6/COPY=3 XLATEY=-50;
 treplay 1:1 2:2 3:3 4:4 5:5 6:6 name='Fig_1_4';
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 5.23 ---*/    
/*----------------------------*/
proc sort data=Example5_4_2;
 by Plot Trt Days;
run;
ods listing close;
ods output parameterestimates=SAStemp.OLSparms;
proc nlmixed data=Example5_4_2 method=gauss qpoints=1; 
 parms b11=20 b12=20 b13=10 b14=18 b15=15 b16=18 
       b21=50 b22=50 b23=50 b24=50 b25=50 b26=50
       b31=-0.1 b32=-0.1 b33=-0.1 b34=-0.1 b35=-0.1 b36=-0.1  
       sigsq_w=.05 delta=1; 
 beta1 = b11*X1 + b12*X2 + b13*X3 +
         b14*X4 + b15*X5 + b16*X6;
 beta2 = b21*X1 + b22*X2 + b23*X3 +
         b24*X4 + b25*X5 + b26*X6;
 beta3 = b31*X1 + b32*X2 + b33*X3 +
         b34*X4 + b35*X5 + b36*X6;
 beta3 = beta3/100;
 pred = (beta1+bi1)/(1+exp((beta3+bi3)*(Days-(beta2+bi2)))); 
 var = sigsq_w*(pred**(2*delta));
 resid = y - pred;
 model y ~ normal(pred, var); 
 random bi1 bi2 bi3 ~ normal([0,0,0],
                             [0,
                              0,0,
                              0,0,0])
        subject=Plot; 
 predict pred out=SAStemp.predout der; 
 id resid;
run;
ods listing;
%covparms(parms=SAStemp.OLSparms, predout=SAStemp.predout,
          resid=resid, method=mspl, 
          random=der_bi1 der_bi2 der_bi3, subject=Plot,
          type=un, covname=psi, output=MLEparms);

/*----------------------------------------------------*/
/* This additional call to %COVPARMS is included here */
/* but the results are only discussed within the book */
/*----------------------------------------------------*/
%covparms(parms=SAStemp.OLSparms, predout=SAStemp.predout,
          resid=resid, method=mspl, 
          random=der_bi1 der_bi3, subject=Plot,
          type=un, covname=psi, output=MLEparms);

/*----------------------------*/                    
/*--- Code for Output 5.24 ---*/    
/*----------------------------*/
%covparms(parms=SAStemp.OLSparms, predout=SAStemp.predout,
          resid=resid, method=mspl, 
          random=der_bi1 der_bi2, subject=Plot,
          type=un, covname=psi, output=MLEparms);

/*----------------------------------------------------*/
/* The following call to NLMIXED fails to converge as */
/* discussed in the book.                             */
/*----------------------------------------------------*/
proc nlmixed data=Example5_4_2 qpoints=1; 
 parms /data=MLEparms;
 beta1 = b11*X1 + b12*X2 + b13*X3 +
         b14*X4 + b15*X5 + b16*X6;
 beta2 = b21*X1 + b22*X2 + b23*X3 +
         b24*X4 + b25*X5 + b26*X6;
 beta3 = b31*X1 + b32*X2 + b33*X3 +
         b34*X4 + b35*X5 + b36*X6;
 beta3 = beta3/100;
 pred = (beta1+bi1)/(1+exp(beta3*(Days-(beta2+bi2)))); 
 pred_avg = beta1/(1+exp(beta3*(Days-beta2))); 
 var = sigsq_w*(pred**(2*delta));
 rho21 = psi21/(sqrt(psi11)*sqrt(psi22));
 resid = y - pred;
 model y ~ normal(pred, var); 
 random bi1 bi2 ~ normal([0, 0],
                         [psi11, 
                          psi21, psi22])
        subject=Plot; 
 estimate 'corr(bi1,bi2)=' rho21;
 contrast 'Test of Asymptote Effects:'
          b11-b12, b11-b13, b11-b14, b11-b15, b11-b16;
 contrast 'Test of Half-Life Effects:' 
          b21-b22, b21-b23, b21-b24, b21-b25, b21-b26;
 contrast 'Test of Growth Rate Effects:' 
          b31-b32, b31-b33, b31-b34, b31-b35, b31-b36;
run; 


/*----------------------------*/                    
/*--- Code for Output 5.25 ---*/    
/*----------------------------*/
proc nlmixed data=Example5_4_2 qpoints=1 
     maxfunc=1000 tech=newrap; 
 parms /data=MLEparms;
 beta1 = b11*X1 + b12*X2 + b13*X3 +
         b14*X4 + b15*X5 + b16*X6;
 beta2 = b21*X1 + b22*X2 + b23*X3 +
         b24*X4 + b25*X5 + b26*X6;
 beta3 = b31*X1 + b32*X2 + b33*X3 +
         b34*X4 + b35*X5 + b36*X6;
 beta3 = beta3/100;
 pred = (beta1+bi1)/(1+exp(beta3*(Days-(beta2+bi2)))); 
 pred_avg = beta1/(1+exp(beta3*(Days-beta2))); 
 var = sigsq_w*(pred**(2*delta));
 rho21 = psi21/(sqrt(psi11)*sqrt(psi22));
 resid = y - pred;
 model y ~ normal(pred, var); 
 random bi1 bi2 ~ normal([0, 0],
                         [psi11, 
                          psi21, psi22])
        subject=Plot; 
 estimate 'corr(bi1,bi2)=' rho21;
 contrast 'Test of Asymptote Effects:'
          b11-b12, b11-b13, b11-b14, b11-b15, b11-b16;
 contrast 'Test of Half-Life Effects:' 
          b21-b22, b21-b23, b21-b24, b21-b25, b21-b26;
 contrast 'Test of Growth Rate Effects:' 
          b31-b32, b31-b33, b31-b34, b31-b35, b31-b36;
run; 


/*----------------------------*/                    
/*--- Code for Output 5.26 ---*/    
/*----------------------------*/
%covparms(parms=SAStemp.OLSparms, predout=SAStemp.predout,
          resid=resid, method=mspl, 
          random=der_bi1, subject=Plot,
          type=un, covname=psi, output=MLEparms);
proc nlmixed data=Example5_4_2 qpoints=1 
     maxfunc=1000 tech=newrap; 
 parms /data=MLEparms;
 beta1 = b11*X1 + b12*X2 + b13*X3 +
         b14*X4 + b15*X5 + b16*X6;
 beta2 = b21*X1 + b22*X2 + b23*X3 +
         b24*X4 + b25*X5 + b26*X6;
 beta3 = b31*X1 + b32*X2 + b33*X3 +
         b34*X4 + b35*X5 + b36*X6;
 beta3 = beta3/100;
 pred = (beta1+bi1)/(1+exp(beta3*(Days-(beta2)))); 
 pred_avg = (beta1)/(1+exp(beta3*(Days-beta2))); 
 var = sigsq_w*(pred**(2*delta));
 resid = y - pred;
 model y ~ normal(pred, var); 
 random bi1 ~ normal(0, psi11) subject=Plot; 
 contrast 'Test of Asymptote Effects:'
          b11-b12, b11-b13, b11-b14, b11-b15, b11-b16;
 contrast 'Test of Half-Life Effects:' 
          b21-b22, b21-b23, b21-b24, b21-b25, b21-b26;
 contrast 'Test of Growth Rate Effects:' 
          b31-b32, b31-b33, b31-b34, b31-b35, b31-b36;
run; 


/*----------------------------*/                    
/*--- Code for Output 5.27 ---*/    
/*----------------------------*/
data MLEparms;
 set MLEparms;
 if Parameter='delta' then delete;
run; 
proc print data=MLEparms;
run;
ods output parameterestimates=SAStemp.pe_Model3_MLE;
ods select FitStatistics ParameterEstimates;
proc nlmixed data=Example5_4_2 qpoints=1 
     maxfunc=1000 tech=newrap; 
 parms /data=MLEparms;
 beta1 = b11*X1 + b12*X2 + b13*X3 +
         b14*X4 + b15*X5 + b16*X6;
 beta2 = b21*X1 + b22*X2 + b23*X3 +
         b24*X4 + b25*X5 + b26*X6;
 beta3 = b31*X1 + b32*X2 + b33*X3 +
         b34*X4 + b35*X5 + b36*X6;
 beta3 = beta3/100;
 pred = (beta1+bi1)/(1+exp(beta3*(Days-(beta2)))); 
 pred_avg = (beta1)/(1+exp(beta3*(Days-beta2))); 
 var = sigsq_w*(pred**2);
 resid = y - pred;
 model y ~ normal(pred, var); 
 random bi1 ~ normal(0, psi11) subject=Plot; 
 contrast 'Test of Asymptote Effects:'
          b11-b12, b11-b13, b11-b14, b11-b15, b11-b16;
 contrast 'Test of Half-Life Effects:' 
          b21-b22, b21-b23, b21-b24, b21-b25, b21-b26;
 contrast 'Test of Growth Rate Effects:' 
          b31-b32, b31-b33, b31-b34, b31-b35, b31-b36;
run; 


/*----------------------------*/                    
/*--- Code for Output 5.28 ---*/    
/*----------------------------*/
%nlinmix(data=example5_4_2,                                          
  procopt=method=ml covtest cl,
  parms=%str( b11=18 b12=21 b13=10 b14=18 b15=15 b16=17 
              b21=54 b22=54 b23=52 b24=51 b25=49 b26=48
              b31=-13 b32=-12 b33=-14 b34=-14 b35=-14 b36=-14), 
  model=%str(      
   beta1 = b11*X1 + b12*X2 + b13*X3 +
           b14*X4 + b15*X5 + b16*X6;
   beta2 = b21*X1 + b22*X2 + b23*X3 +
           b24*X4 + b25*X5 + b26*X6;
   beta3 = b31*X1 + b32*X2 + b33*X3 +
           b34*X4 + b35*X5 + b36*X6;
   beta3=beta3/100;
   predv = (beta1+bi1)/(1+exp(beta3*(Days-beta2)));
   pred_avg = beta1/(1+exp(beta3*(Days-beta2)));
  ), 
  weight=%str(
   _weight_= 1/predv;
  ),
  stmts=%str(
   class Plot _Days_ ;
   model pseudo_y = d_b11 d_b12 d_b13 d_b14 d_b15 d_b16
                    d_b21 d_b22 d_b23 d_b24 d_b25 d_b26
                    d_b31 d_b32 d_b33 d_b34 d_b35 d_b36 / 
                    noint notest s cl;
   random d_bi1 / subject=Plot type=un s;
   weight _weight_; 
   contrast 'Test of Asymptote Effects:'   
      d_b11 1 d_b12 -1, 
      d_b11 1 d_b13 -1, 
      d_b11 1 d_b14 -1, 
      d_b11 1 d_b15 -1, 
      d_b11 1 d_b16 -1;
   contrast 'Test of Half-Life Effects:'   
      d_b21 1 d_b22 -1, 
      d_b21 1 d_b23 -1, 
      d_b21 1 d_b24 -1, 
      d_b21 1 d_b25 -1, 
      d_b21 1 d_b26 -1;
   contrast 'Test of Growth Rate Effects:' 
      d_b31 1 d_b32 -1, 
      d_b31 1 d_b33 -1, 
      d_b31 1 d_b34 -1, 
      d_b31 1 d_b35 -1, 
      d_b31 1 d_b36 -1;
   ods output SolutionF=SAStemp.pe_Model3_PL;
   ods output CovParms=SAStemp.cov_Model3_PL;
  ),
  expand=eblup
); 
run;

%nlinmix(data=example5_4_2, 
  procopt=method=ml covtest cl,
  parms=%str( b11=18 b12=21 b13=10 b14=18 b15=15 b16=17 
              b21=54 b22=54 b23=52 b24=51 b25=49 b26=48
              b31=-13 b32=-12 b33=-14 b34=-14 b35=-14 b36=-14), 
  model=%str(      
   beta1 = b11*X1 + b12*X2 + b13*X3 +
           b14*X4 + b15*X5 + b16*X6;
   beta2 = b21*X1 + b22*X2 + b23*X3 +
           b24*X4 + b25*X5 + b26*X6;
   beta3 = b31*X1 + b32*X2 + b33*X3 +
           b34*X4 + b35*X5 + b36*X6;
   beta3=beta3/100;
   predv = (beta1+bi1)/(1+exp(beta3*(Days-beta2))); 
   pred_avg = beta1/(1+exp(beta3*(Days-beta2))); 
  ), 
  weight=%str(
   _weight_= 1/predv;
  ),
  stmts=%str(
   class Plot _Days_ ;
   model pseudo_y = d_b11 d_b12 d_b13 d_b14 d_b15 d_b16
                    d_b21 d_b22 d_b23 d_b24 d_b25 d_b26
                    d_b31 d_b32 d_b33 d_b34 d_b35 d_b36 / 
                    noint notest s cl;
   random d_bi1 / subject=Plot type=un s;
   repeated _Days_ / subject=Plot type=SP(POW) (Days); 
   weight _weight_; 
   ods output SolutionF=SAStemp.pe_Model4_PL;
   ods output CovParms=SAStemp.cov_Model4_PL;
  ),
  expand=eblup
); 
run;

data pe_Model3_MLE ;
 length Parameter $8.;
 set SAStemp.pe_Model3_MLE;
 Method='Laplace MLE (Model 1)';
run;
data pe_Model3_PL (rename=(StdErr=StandardError));
 length Parameter $8.;
 set SAStemp.pe_Model3_PL;
 Parameter=scan(Effect,2, '_');
 Method='PL/CGEE1 (Model 1)   ';
 drop Effect;
run;
data cov_Model3_PL (rename=(StdErr=StandardError));
 length Parameter $8.;
 set SAStemp.cov_Model3_PL;
 if CovParm='Residual' then Parameter='sigsq_w';
 if CovParm='UN(1,1)'  then Parameter='psi11  ';
 DF=.;
 tValue=ZValue;
 Probt=ProbZ;
 Method='PL/CGEE1 (Model 1)   ';
 drop CovParm Subject;
run;
data pe_Model4_PL (rename=(StdErr=StandardError));
 length Parameter $8.;
 set SAStemp.pe_Model4_PL;
 Parameter=scan(Effect,2, '_');
 Method='PL/CGEE1 (Model 2)   ';
 drop Effect;
run;
data cov_Model4_PL (rename=(StdErr=StandardError));
 length Parameter $8.;
 set SAStemp.cov_Model4_PL;
 if CovParm='Residual' then Parameter='sigsq_w';
 if CovParm='UN(1,1)'  then Parameter='psi11  ';
 if CovParm='SP(POW)'  then Parameter='rho    ';
 DF=.;
 tValue=ZValue;
 Probt=ProbZ;
 Method='PL/CGEE1 (Model 2)   ';
 drop CovParm Subject;
run;
data pe;
 set pe_Model3_MLE pe_Model3_PL cov_Model3_pl pe_Model4_PL cov_Model4_pl;
run;

/*--- Output 5.28 ---*/
proc report data=pe headskip split='|' nowindows ;
 column ('Parameter Estimates' Parameter Method, (Estimate StandardError));
 define Parameter / group width=9 left;
 define Method / across ;
 define Estimate / mean;
 define StandardError / mean 'StdErr';
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/


