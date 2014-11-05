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
/*=== Example 4.3.3. Epileptic seizure data                       ===*/
/*===================================================================*/
data thall; 
input ID y Visit Trt Bline Age; 
cards; 
104 5 1  0 11 31 
104 3 2  0 11 31 
104 3 3  0 11 31 
104 3 4  0 11 31 
106 3 1  0 11 30 
106 5 2  0 11 30 
106 3 3  0 11 30 
106 3 4  0 11 30 
107 2 1  0 6 25 
107 4 2  0 6 25 
107 0 3  0 6 25 
107 5 4  0 6 25 
114 4 1  0 8 36 
114 4 2  0 8 36 
114 1 3  0 8 36 
114 4 4  0 8 36 
116 7 1  0 66 22 
116 18 2  0 66 22 
116 9 3  0 66 22 
116 21 4 0 66 22 
118 5 1  0 27 29 
118 2 2  0 27 29 
118 8 3  0 27 29 
118 7 4  0 27 29 
123 6 1  0 12 31 
123 4 2  0 12 31 
123 0 3  0 12 31 
123 2 4  0 12 31 
126 40 1 0 52 42 
126 20 2 0 52 42 
126 23 3 0 52 42 
126 12 4 0 52 42 
130 5 1  0 23 37 
130 6 2  0 23 37 
130 6 3  0 23 37 
130 5 4  0 23 37 
135 14 1  0 10 28 
135 13 2  0 10 28 
135  6 3  0 10 28 
135  0 4  0 10 28 
141 26 1  0 52 36 
141 12 2  0 52 36 
141  6 3  0 52 36 
141 22 4 0 52 36 
145 12 1  0 33 24 
145  6 2  0 33 24 
145  8 3  0 33 24 
145  4 4  0 33 24 
201 4 1  0 18 23 
201 4 2  0 18 23 
201 6 3  0 18 23 
201 2 4  0 18 23 
202 7 1  0 42 36 
202 9 2  0 42 36 
202 12 3  0 42 36 
202 14 4  0 42 36 
205 16 1  0 87 26 
205 24 2  0 87 26 
205 10 3  0 87 26 
205 9  4  0 87 26 
206 11 1  0 50 26 
206  0 2  0 50 26 
206  0 3  0 50 26 
206  5 4  0 50 26 
210 0 1  0 18 28 
210 0 2  0 18 28 
210 3 3  0 18 28 
210 3 4  0 18 28 
213 37 1  0 111 31 
213 29 2  0 111 31 
213 28 3  0 111 31 
213 29 4  0 111 31 
215 3 1  0 18 32 
215 5 2  0 18 32 
215 2 3  0 18 32 
215 5 4  0 18 32 
217 3 1  0 20 21 
217 0 2  0 20 21 
217 6 3  0 20 21 
217 7 4  0 20 21 
219 3 1  0 12 29 
219 4 2  0 12 29 
219 3 3  0 12 29 
219 4 4  0 12 29 
220 3 1   0 9 21 
220 4 2 0 9 21 
220 3 3 0 9 21 
220 4 4 0 9 21 
222 2 1   0 17 32 
222 3 2 0 17 32 
222 3 3 0 17 32 
222 5 4 0 17 32 
226 8 1   0 28 25 
226 12 2 0 28 25 
226 2 3 0 28 25 
226 8 4 0 28 25 
227 18 1   0 55 30 
227 24 2 0 55 30 
227 76 3 0 55 30 
227 25 4 0 55 30 
230 2 1   0 9 40 
230 1 2 0 9 40 
230 2 3 0 9 40 
230 1 4 0 9 40 
234 3 1   0 10 19 
234 1 2 0 10 19 
234 4 3 0 10 19 
234 2 4 0 10 19 
238 13 1   0 47 22 
238 15 2 0 47 22 
238 13 3 0 47 22 
238 12 4 0 47 22 
101 11 1   1 76 18 
101 14 2 1 76 18 
101 9 3 1 76 18 
101 8 4 1 76 18 
102 8 1   1 38 32 
102 7 2 1 38 32 
102 9 3 1 38 32 
102 4 4 1 38 32 
103 0 1   1 19 20 
103 4 2 1 19 20 
103 3 3 1 19 20 
103 0 4 1 19 20 
108 3 1   1 10 30 
108 6 2 1 10 30 
108 1 3 1 10 30 
108 3 4 1 10 30 
110 2 1   1 19 18 
110 6 2 1 19 18 
110 7 3 1 19 18 
110 4 4 1 19 18 
111 4 1   1 24 24 
111 3 2 1 24 24 
111 1 3 1 24 24 
111 3 4 1 24 24 
112 22 1   1 31 30 
112 17 2 1 31 30 
112 19 3 1 31 30 
112 16 4 1 31 30 
113 5 1   1 14 35 
113 4 2 1 14 35 
113 7 3 1 14 35 
113 4 4 1 14 35 
117 2 1   1 11 27 
117 4 2 1 11 27 
117 0 3 1 11 27 
117 4 4 1 11 27 
121 3 1   1 67 20 
121 7 2 1 67 20 
121 7 3 1 67 20 
121 7 4 1 67 20 
122 4 1   1 41 22 
122 18 2 1 41 22 
122 2 3 1 41 22 
122 5 4 1 41 22 
124 2 1   1 7 28 
124 1 2 1 7 28 
124 1 3 1 7 28 
124 0 4 1 7 28 
128 0 1   1 22 23 
128 2 2 1 22 23 
128 4 3 1 22 23 
128 0 4 1 22 23 
129 5 1   1 13 40 
129 4 2 1 13 40 
129 0 3 1 13 40 
129 3 4 1 13 40 
137 11 1   1 46 33 
137 14 2 1 46 33 
137 25 3 1 46 33 
137 15 4 1 46 33 
139 10 1   1 36 21 
139 5 2 1 36 21 
139 3 3 1 36 21 
139 8 4 1 36 21 
143 19 1   1 38 35 
143 7 2 1 38 35 
143 6 3 1 38 35 
143 7 4 1 38 35 
147 1 1   1 7 25 
147 1 2 1 7 25 
147 2 3 1 7 25 
147 3 4 1 7 25 
203 6 1   1 36 26 
203 10 2 1 36 26 
203 8 3 1 36 26 
203 8 4 1 36 26 
204 2 1   1 11 25 
204 1 2 1 11 25 
204 0 3 1 11 25 
204 0 4 1 11 25 
207 102 1   1 151 22 
207 65 2 1 151 22 
207 72 3 1 151 22 
207 63 4 1 151 22 
208 4 1   1 22 32 
208 3 2 1 22 32 
208 2 3 1 22 32 
208 4 4 1 22 32 
209 8 1   1 41 25 
209 6 2 1 41 25 
209 5 3 1 41 25 
209 7 4 1 41 25 
211 1 1   1 32 35 
211 3 2 1 32 35 
211 1 3 1 32 35 
211 5 4 1 32 35 
214 18 1   1 56 21 
214 11 2 1 56 21 
214 28 3 1 56 21 
214 13 4 1 56 21 
218 6 1   1 24 41 
218 3 2 1 24 41 
218 4 3 1 24 41 
218 0 4 1 24 41 
221 3 1   1 16 32 
221 5 2 1 16 32 
221 4 3 1 16 32 
221 3 4 1 16 32 
225 1 1   1 22 26 
225 23 2 1 22 26 
225 19 3 1 22 26 
225 8 4 1 22 26 
228 2 1   1 25 21 
228 3 2 1 25 21 
228 0 3 1 25 21 
228 1 4 1 25 21 
232 0 1   1 13 36 
232 0 2 1 13 36 
232 0 3 1 13 36 
232 0 4 1 13 36 
236 1 1 1 12 37 
236 4 2 1 12 37 
236 3 3 1 12 37 
236 2 4 1 12 37 
; 


/*----------------------------*/                    
/*--- Code for Output 4.8  ---*/    
/*----------------------------*/   
data example4_3_3;
 set thall;        
 y0=log(Bline/4);
 LogAge=log(Age);
 LogTime=log(2);
 Visit4=(Visit=4);
run;
proc sort data=example4_3_3;
 by ID Visit;
run; 
proc print data=example4_3_3(obs=16) noobs;
 var ID y Visit Trt Bline Age y0;
run;


/*----------------------------*/                    
/*--- Code for Output 4.9  ---*/    
/*----------------------------*/   

/*---------------------------------------------------------------*/
/*------------ Pseudo Likelihood Estimation (PLE)----------------*/
/* The following macro mimics the ModelCorr GENMOD macro from    */
/* Example 4.3.2 in that it compares model parameters as well    */
/* as goodness-of-fit statistics on assumed covariance structure.*/
/*---------------------------------------------------------------*/
%macro ModelCov(cov=ind);
  ods listing close;
  ods output ParameterEstimates=pe;
  ods output CovParms=covparms;
  ods output CovBDetails=covb_fit;
  ods output Tests3=tests;
  proc glimmix data=example4_3_3 empirical;
   class ID Visit;
   model y = y0 Trt y0*Trt LogAge Visit4 
           / dist=Poisson link=log offset=LogTime 
             covb(details) cl s htype=3;
   nloptions maxiter=500;
   random _residual_ / subject=ID type=&cov
    %if %index(&cov, VC) %then %do; group=Visit %end;;
  run;
  data pe; 
   length Structure $4.;
   set pe;
   Structure="&cov";
  run;
  data covparms;
   length Structure $4.;
   set covparms;
   Structure="&cov";
  run;
  data covb_fit; 
   length Structure $4.;
   set covb_fit;
   if Descr IN ('Concordance correlation' 
                'Discrepancy function'
                'Trace(Adjusted Inv(MBased))' );
   Structure="&cov";
   Statistic=Descr;
   Value=Adjusted; 
   Keep Structure Statistic Value;
  run;
  data tests; 
   length Structure $4.;
   set tests;
   Structure="&cov";
  run;
  data covparms_summary;
   set covparms_summary covparms; 
  run;
  data covb_summary;
   set covb_summary covb_fit; 
  run;
  data pe_summary;
   set pe_summary pe;
  run; 
  data tests_summary;
   set tests_summary tests;
  run; 
  ods listing;
%mend ModelCov;
Data pe_summary;
Data covparms_summary;
Data covb_summary;
Data tests_summary;
 %ModelCov(cov=VC);
 %ModelCov(cov=CS);
 %ModelCov(cov=CSH);
 %ModelCov(cov=Toep);
 %ModelCov(cov=UN);
run;

proc report data=pe_summary 
 HEADLINE HEADSKIP SPLIT='|' nowindows;
 where Structure IN ("VC" "CS" "CSH");
 column Effect Structure, (Estimate StdErr);
 define Effect / GROUP "Effect" WIDTH=12;
 define Structure / Across "Working Covariance Structure" order=internal WIDTH=8;
 define Estimate / MEAN FORMAT=6.3 'Estimate' width=8 NOZERO spacing=1;
 define StdErr   / MEAN FORMAT=6.3 'SE' width=6 NOZERO spacing=1;
run;
quit;
proc report data=pe_summary 
 HEADLINE HEADSKIP SPLIT='|' nowindows;
 where Structure IN ("Toep" "UN");
 column Effect Structure, (Estimate StdErr);
 define Effect / GROUP "Effect" WIDTH=12;
 define Structure / Across "Working Covariance Structure" order=internal WIDTH=8;
 define Estimate / MEAN FORMAT=6.3 'Estimate' width=8 NOZERO spacing=1;
 define StdErr   / MEAN FORMAT=6.3 'SE' width=6 NOZERO spacing=1;
run;
quit;
proc sort data=covparms_summary;
 by Structure;
run;
proc print data=covparms_summary noobs split='|';
 where Estimate ne .;
 by Structure;
 id Structure;
 var CovParm Group Estimate StdErr;
 label CovParm='Parameter' 
       Structure='Working|Covariance|Structure'
       StdErr='SE';
run;


/*----------------------------*/                    
/*--- Code for Output 4.10 ---*/    
/*----------------------------*/   
proc report data=covb_summary 
 HEADLINE HEADSKIP SPLIT='|' nowindows;
 column Statistic Structure, (Value);
 define Statistic / GROUP "Goodness-of-Fit Measure" 
                    format=$30. WIDTH=30;
 define Structure / Across "Working Covariance Structure" 
                    order=internal WIDTH=8;
 define Value     / MEAN FORMAT=8.4 'Value' 
                    width=8 NOZERO spacing=1;
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 4.11 ---*/    
/*----------------------------*/   
proc report data=tests_summary  
 HEADLINE HEADSKIP SPLIT='|' nowindows;
 column Effect Structure, (NumDF DenDF FValue ProbF);
 define Effect / GROUP "Effect" WIDTH=12 ;
 define Structure / Across "Working Covariance Structure" 
                    order=internal WIDTH=8;
 define NumDF / MEAN FORMAT=6.0 'NumDF' width=6 spacing=1;
 define DenDF / MEAN FORMAT=6.0 'DenDF' width=6 spacing=1;
 define FValue/ MEAN FORMAT=8.2 'FValue' width=6 spacing=1;
 define ProbF / MEAN 'ProbF' width=8 spacing=1;
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 4.12 ---*/    
/*---      and Figure 4.2  ---*/    
/*----------------------------*/   
ods graphics on / imagefmt=SASEMF imagename='Fig_4_2';
proc genmod data=example4_3_3
             plots(Clusterlabel)=DFbetaCS;
 class ID Visit;
 model y = Trt LogAge y0 y0*Trt Visit4 
         / dist=Poisson link=log offset=LogTime Type3;
 repeated subject=ID / type=un ;
run;
ods graphics off;


/*----------------------------*/                    
/*--- Code for Output 4.13 ---*/    
/*----------------------------*/   
ods select ParameterEstimates;
proc glimmix data=example4_3_3 empirical;
 where ID ne 207;
 class ID Visit;
 model y = Trt LogAge y0 y0*Trt Visit4 
         / dist=Poisson link=log offset=LogTime 
           covb(details) s htype=3;
 nloptions maxiter=500;
 random _residual_ / subject=ID type=un;
run;



/*===================================================================*/
/*=== Example 4.5.4. Epileptic seizure data = continued           ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\GOF.sas' /nosource2;

proc format;
 value $effectf  'b0'='Intercept'
                 'b1'='Trt' 
                 'b2'='LogAge' 
                 'b3'='y0' 
                 'b4'='y0*Trt'
				 'Trt*y0'='y0*Trt'
                 'b5'='Visit4'
				 'theta'='Theta'
                 'rho'='Rho'
                 'Correlation'='Rho';
run;


/*----------------------------*/                    
/*--- Code for Output 4.30 ---*/    
/*----------------------------*/

/* Step 1: Run GENMOD (GEE) code */
ods output GEEEmpPEst=GEEpe_ind;
ods select GEEEmpPEst;
proc genmod data=example4_3_3;
 where ID ne 207;
 class ID Visit;
 model y = Trt LogAge y0 y0*Trt Visit4 /
           dist=Poisson noscale scale=1 type3;
 repeated subject=id /type=ind; 
*title "GENMOD: GEE with 'working' independence and Poisson variation"; 
run;
ods output GEEEmpPEst=GEEpe_cs;
ods output GEEExchCorr=GEEcov_cs;
ods output GEENCov = Omega;
ods output GEERCov = Omega_R;
ods select GEEEmpPEst GEEExchCorr;
proc genmod data=example4_3_3;
 where ID ne 207;
 class ID Visit;
 model y = Trt LogAge y0 y0*Trt Visit4 /
           dist=Poisson noscale scale=1 type3;
 repeated subject=id /type=cs modelse ECOVB MCOVB; 
 output out=pred pred=yhat;
*title "GENMOD: GEE with 'working' exchangeable correlation and Poisson variation"; 
run;

/* Step 2: Run macro %GOF to get GOF results for GEE under exchangeable correlation */
%GOF(proc=genmod, 
     parms=GEEpe_cs,
	 covparms=GEEcov_cs,
     data=pred,
	 subject=ID,
	 omega=Omega,
	 omega_r=Omega_R,
     response=y,
     pred_ind=yhat, 
     pred_avg=yhat, 
	 title=,
	 ref=
     );
title;

/* Step 3: Run NLMIXED (GEE2) code */
ods output parameterestimates=GEE2pe_ind;
ods select ParameterEstimates;
proc nlmixed data=example4_3_3 empirical;
 where ID ne 207;
 parms b0 = -3 b1 = -1 b2 = 1 b3 = 1 b4 = .5 b5 = 0 ;
 xbeta = b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt + 
         b5*Visit4;
 Mu_i = exp(xbeta) + u;
 Sigma_i = exp(xbeta);
 Var_i = Sigma_i;
 model y ~ normal(Mu_i, Var_i);
 random u ~ normal(0, 0) subject=ID;
*title "NLMIXED: GEE2/ELS with 'working' independence and Poisson variation";
run; 
ods output parameterestimates=GEE2pe_cs;
ods select ParameterEstimates;
proc nlmixed data=example4_3_3 empirical;
 where ID ne 207;
 parms b0 = -3 b1 = -1 b2 = 1 b3 = 1 b4 = .5 b5 = 0 rho = 0;
 bounds -1<rho<1;
 xbeta = b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt + 
         b5*Visit4;
 Sigma_i = exp(xbeta);
 Mu_i = exp(xbeta) + sqrt(Sigma_i)*u;
 Var_i = Sigma_i*(1-rho);
 model y ~ normal(Mu_i, Var_i);
 random u ~ normal(0, rho) subject=ID;
 predict exp(xbeta) out=pred;
*title "NLMIXED: GEE2/ELS with 'working' exchangeable correlation and Poisson variation";
run; 

/* Step 4: Run macro %GOF to get GOF results for GEE2 under exchangeable correlation */
data pe; 
 set GEE2pe_cs;
 if Parameter in ('b1' 'b2' 'b3' 'b4' 'b5' 'b6');
run;
data cov; 
 set GEE2pe_cs;
 if Parameter in ('rho');
run;
%GOF(proc=nlmixed,
     parms=pe,
	 covparms=cov,
     data=pred,
	 subject=ID,
	 fitstats=,
	 omega=,
	 omega_r=,
     response=y,
     pred_ind=pred, 
     pred_avg=pred, 
	 title=,
	 ref=
     );
title;

/* Step 5: Collect data for PROC REPORT */
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
data all_pe;
 length Effect $16;
 set GEEpe_ind GEEpe_cs GEE2pe_ind GEE2pe_cs;
 bys=1;
 if Effect='Correlation' or Effect='rho' then bys=2;
run;

/*--- Output 4.30 ---*/
proc report data=all_pe
 HEADLINE HEADSKIP SPLIT='|' nowindows;
 column Structure Effect Method, (Estimate StandardError DF Test p);
 define Structure / GROUP "Correlation|Structure" center WIDTH=16 order=data;
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


/* Code for GEE2 via GLIMMIX under working independence */
proc glimmix data=example4_3_3 empirical method=laplace;
 where ID ne 207;
 class ID; 
 _variance_=_mu_;
 parms (0) / hold=1;
 model y = Trt LogAge y0 y0*Trt Visit4 / link=log s;
 random intercept / subject=id;
 output out=GEE2out pred=yhat;
      id id _xbeta_ _mu_ _variance_ ;
*title "GLIMMIX: GEE2/ELS with 'working' independence and Poisson variation";
run; 


/*----------------------------*/                    
/*--- Code for Output 4.31 ---*/    
/*----------------------------*/
proc means data=example4_3_3 noprint mean;
 where Visit=1 and ID ne 207;
 var y0 LogAge;
 output out=MeanCovariates mean=Avg_y0 Avg_LogAge;
run;
data example4_5_4;
 set example4_3_3;
 by ID;
 if _n_=1 then set MeanCovariates;
run; 
ods output ParameterEstimates = pe;
ods output AdditionalEstimates = ae;
ods listing close;
proc nlmixed data=example4_5_4 qpoints=1 cov empirical;
 where ID ne 207;
 parms b0 = -3 b1 = 1 b2 = 1 b3 = -1 b4 = .5 
       b5 = -.30 theta=0;
 /* Define time-dependent conditional linear predictor */
 xbeta = b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt + 
         b5*Visit4;
 /* Define Mu_ij=E(Zij) and Mu = E(Ui) under the */
 /* multivariate Poisson model: Yij=Ui+Zij       */
 Mu_ij = exp(xbeta);
 Mu = exp(theta);
 /* Define an exchangeable random effect Ui */
 /* and the conditional moments of Yij | Ui */
 Ui =  exp(theta) + sqrt(exp(theta))*u;
 Mean_ij = exp(xbeta) + Ui;
 Var_ij = exp(xbeta);
 /* Define least squares mean linear predictors  */
 /* for visits 1 and 4 for both treatment groups */
 xbeta1_0 = b0 + b1*0 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*0;
 xbeta4_0 = b0 + b1*0 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*0 + b5;
 xbeta1_1 = b0 + b1*1 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*1;
 xbeta4_1 = b0 + b1*1 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*1 + b5;
 /* Define predicted mean count per individual */
 E_Yij = Mu + Mu_ij;
 /* Define first- and second-order moments evaluated at */
 /* the least squares mean linear predictors for both   */
 /* treatment groups at visits 1 and 4 noting that the  */
 /* moments are all the same for visits 1-3             */ 
 Mu1_0 = exp(xbeta1_0) + exp(theta);
 Mu4_0 = exp(xbeta4_0) + exp(theta);
 Mu1_1 = exp(xbeta1_1) + exp(theta);
 Mu4_1 = exp(xbeta4_1) + exp(theta);
 Var1_0 = Mu1_0; 
 Var4_0 = Mu4_0;
 Var1_1 = Mu1_1; 
 Var4_1 = Mu4_1;
 Cov_jk =  exp(theta);
 Corr_jk_0 = Cov_jk/Var1_0;
 Corr_j4_0 = Cov_jk/( sqrt(Var1_0)*sqrt(Var4_0) );
 Corr_jk_1 = Cov_jk/Var1_1;
 Corr_j4_1 = Cov_jk/( sqrt(Var1_1)*sqrt(Var4_1) );
 estimate 'Mean Rate Trt(0): Visit<4' Mu1_0;
 estimate 'Mean Rate Trt(1): Visit<4' Mu1_1;
 estimate 'Mean Difference : Visit<4' Mu1_0 - Mu1_1;
 estimate 'Rate Ratio(1:0) : Visit<4' Mu1_1/Mu1_0;
 estimate 'Mean Rate Trt(0): Visit=4' Mu4_0;
 estimate 'Mean Rate Trt(1): Visit=4' Mu4_1;
 estimate 'Mean Difference : Visit=4' Mu4_0 - Mu4_1;
 estimate 'Rate Ratio(1:0) : Visit=4' Mu4_1/Mu4_0;
 estimate 'Cov(Yij,Yik): All Visits' Cov_jk;
 estimate 'Corr(Yij,Yik) (j<k, k<4) Trt(0):' Corr_jk_0;
 estimate 'Corr(Yij,Yik) (j<k, k=4) Trt(0):' Corr_j4_0;
 estimate 'Corr(Yij,Yik) (j<k, k<4) Trt(1):' Corr_jk_1;
 estimate 'Corr(Yij,Yik) (j<k, k=4) Trt(1):' Corr_j4_1;
 model y ~ Normal(Mean_ij, Var_ij);
 random u ~ normal(0,1) subject=ID;
 predict E_Yij out=pred;
run; 
ods listing;
data pe; 
 set pe;
 Effect=Parameter;
run; 
proc print data=pe noobs split='|' ;
 var Parameter Effect Estimate StandardError DF tValue Probt Lower Upper;
 label StandardError='SE' tValue='t Value' Probt='p' ;
 format Effect $effectf. Estimate StandardError tValue Probt Lower Upper 5.3;
run;
proc print data=ae noobs split='|' ;
 var Label Estimate StandardError DF Lower Upper;
 label Label='Statistic' StandardError='SE' tValue='t Value' Probt='p-value' ;
 format Estimate StandardError Lower Upper 5.3;
run;
/* Code to get Adjusted R-square for GOF comparisons */
data PE_beta;
 set pe;
 if Parameter in ('b1' 'b2' 'b3' 'b4' 'b5');
run;
data PE_cov;
 set pe;
 if Parameter in ('theta');
run; 
%GOF(proc=nlmixed, 
     parms=PE_beta,
	 covparms=PE_cov,
     data=pred,
	 subject=ID,
	 fitstats=,
     response=y,
     pred_ind=pred, 
     pred_avg=pred, 
	 title=,
	 ref=
     );

/*----------------------------*/                    
/*--- Code for Output 4.32 ---*/    
/*----------------------------*/
proc transpose data=example4_5_4 out=new prefix=y;
 by ID;
 var y;
 copy y0 LogAge Avg_y0 Avg_LogAge Trt LogTime;
run;
data new;
 set new;
 if _NAME_='y';
 Yij=1;	 
 Drop _NAME_;
run;
proc print data=new;
run;
ods output CovMatParmEst=Omega_R;
ods output ParameterEstimates = pe_ML;
ods output AdditionalEstimates = ae_ML;
ods listing close;
proc nlmixed data=new qpoints=1 cov empirical;
 where ID ne 207;
 parms b0 = -3 b1 = -1 b2 = 0 b3 = 0 b4 = 0 b5 = 0 
       theta=0;
 /* Define xbeta for visits 1-4 */
 xbeta1  = (b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt);
 xbeta2  = (b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt);
 xbeta3  = (b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt);
 xbeta4  = (b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt + b5);
 /* Define joint likelihood function via Johnson and Kotz */
 logexpon = -( exp(xbeta1) + exp(xbeta2) + 
               exp(xbeta3) + exp(xbeta4) + exp(theta) + u );
 array y[4] y1-y4; 
 array xbeta[4] xbeta1-xbeta4; 
 Min_y=min(of y1-y4);
 Summ_ij = 0; 
 do j=0 to Min_y by 1;
   xbeta_j = xbeta[1]*(y[1]-j);  
   gamma_j = gamma(y[1]-j+1);
  do k=2 to 4;
   xbeta_j = xbeta_j + xbeta[k]*(y[k]-j);  
   gamma_j = gamma_j*gamma(y[k]-j+1);
  end;
  Summ_ij = Summ_ij + 
           (exp(theta*j)/gamma(j+1))*exp(xbeta_j)/gamma_j; 
 end;
 random u ~ normal(0,0) subject=ID;
 loglike = logexpon + log(Summ_ij);
 /* Define least squares mean linear predictors  */
 /* for visits 1 and 4 for both treatment groups */
 xbeta1_0 = b0 + b1*0 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*0;
 xbeta4_0 = b0 + b1*0 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*0 + b5;
 xbeta1_1 = b0 + b1*1 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*1;
 xbeta4_1 = b0 + b1*1 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*1 + b5;
 /* Define first- and second-order moments evaluated at */
 /* the least squares mean linear predictors for both   */
 /* treatment groups at visits 1 and 4 noting that the  */
 /* moments are all the same for visits 1-3             */ 
 Mu1_0 = exp(xbeta1_0) + exp(theta);
 Mu4_0 = exp(xbeta4_0) + exp(theta);
 Mu1_1 = exp(xbeta1_1) + exp(theta);
 Mu4_1 = exp(xbeta4_1) + exp(theta);
 Var1_0 = Mu1_0; 
 Var4_0 = Mu4_0;
 Var1_1 = Mu1_1; 
 Var4_1 = Mu4_1;
 Cov_jk =  exp(theta);
 Corr_jk_0 = Cov_jk/Var1_0;
 Corr_j4_0 = Cov_jk/( sqrt(Var1_0)*sqrt(Var4_0) );
 Corr_jk_1 = Cov_jk/Var1_1;
 Corr_j4_1 = Cov_jk/( sqrt(Var1_1)*sqrt(Var4_1) );
 estimate 'Mean Rate Trt(0): Visit<4' Mu1_0;
 estimate 'Mean Rate Trt(1): Visit<4' Mu1_1;
 estimate 'Mean Difference : Visit<4' Mu1_0 - Mu1_1;
 estimate 'Rate Ratio(1:0) : Visit<4' Mu1_1/Mu1_0;
 estimate 'Mean Rate Trt(0): Visit=4' Mu4_0;
 estimate 'Mean Rate Trt(1): Visit=4' Mu4_1;
 estimate 'Mean Difference : Visit=4' Mu4_0 - Mu4_1;
 estimate 'Rate Ratio(1:0) : Visit=4' Mu4_1/Mu4_0;
 estimate 'Cov(Yij,Yik): All Visits' Cov_jk;
 estimate 'Corr(Yij,Yik) (j<k, k<4) Trt(0):' Corr_jk_0;
 estimate 'Corr(Yij,Yik) (j<k, k=4) Trt(0):' Corr_j4_0;
 estimate 'Corr(Yij,Yik) (j<k, k<4) Trt(1):' Corr_jk_1;
 estimate 'Corr(Yij,Yik) (j<k, k=4) Trt(1):' Corr_j4_1;
 model Yij ~ general(loglike);
 id E_Yi1 E_Yi4 b1-b6 theta;
 predict E_Yi1 out=predMLE;
run; 
ods listing;
data pe_ML; 
 set pe_ML;
 Effect=Parameter;
run; 
title;
proc print data=pe_ML noobs split='|' ;
 var Parameter Effect Estimate StandardError DF 
     tValue Probt Lower Upper;
 label StandardError='SE' tValue='t Value' Probt='p' ;
 format Effect $effectf. Estimate StandardError 
        tValue Probt Lower Upper 5.3;
run;
proc print data=ae_ML noobs split='|' ;
 var Label Estimate StandardError DF Lower Upper;
 label Label='Statistic' StandardError='SE';
 format Estimate StandardError Lower Upper 5.3;
run;


/*-------------------------------------------------*/
/* The following code was run in order to obtain   */
/* goodness-of-fit statistics using the %GOF macro */
/* as reported in the book but not shown. The GOF  */
/* statistic shows the adjusted R-square is 0.443  */
/* as indicated in the discussion following the    */
/* output shown in Output 4.32. This NLMIXED call  */
/* computes standard error estimates based on the  */
/* model-based ML estimates rather than the robust */
/* covariance matrix. The GOF macro tests whether  */
/* there is significant depature between the ML    */
/* based covariance and robust covariance. The     */
/* result suggests there is a discrepancy and the  */
/* multivariate Poisson model might be incorrect.  */
/*-------------------------------------------------*/
ods output CovMatParmEst=Omega;
ods output parameterestimates=pe_MULTPOISS_MLE;
proc nlmixed data=new qpoints=1 cov;
 where ID ne 207;
 parms b0 = -3 b1 = -1 b2 = 0 b3 = 0 b4 = 0 b5 = 0 
       theta=0;
 /* Define xbeta for visits 1-4 */
 xbeta1  = (b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt);
 xbeta2  = (b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt);
 xbeta3  = (b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt);
 xbeta4  = (b0 + b1*Trt + b2*LogAge + b3*y0 + b4*y0*Trt + b5);
 /* Define Mu_ij=E(Zij) under the MVP model: Yij=Ui+Zij */
 Mu_i1 = exp(xbeta1);
 Mu_i2 = exp(xbeta2);
 Mu_i3 = exp(xbeta3);
 Mu_i4 = exp(xbeta4);
 /* Define Mu=E(Ui) under the MVP model: Yij=Ui+Zij */
 Mu  = exp(theta);
 /* Define mean predicted seizure counts at visits 1 and 4 */
 E_Yi1 = Mu + Mu_i1;
 E_Yi4 = Mu + Mu_i4;

 /* Define joint likelihood function via Johnson and Kotz */
 logexpon = -( exp(xbeta1) + exp(xbeta2) + 
               exp(xbeta3) + exp(xbeta4) + exp(theta) + u );
 array y[4] y1-y4; 
 array xbeta[4] xbeta1-xbeta4; 
 Min_y=min(of y1-y4);
 
 Summ_ij = 0; 
 do j=0 to Min_y by 1;
   xbeta_j = xbeta[1]*(y[1]-j);  
   gamma_j = gamma(y[1]-j+1);
  do k=2 to 4;
   xbeta_j = xbeta_j + xbeta[k]*(y[k]-j);  
   gamma_j = gamma_j*gamma(y[k]-j+1);
  end;
  Summ_ij = Summ_ij + 
           (exp(theta*j)/gamma(j+1))*exp(xbeta_j)/gamma_j; 
 end;
 random u ~ normal(0,0) subject=ID;
 loglike = logexpon + log(Summ_ij);

 /* Define mean xbeta for Trt=0 for visits 1-3 */
 xbeta1_0 = b0 + b1*0 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*0;
 /* Define mean xbeta for Trt=0 for visit 4 */
 xbeta4_0 = b0 + b1*0 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*0 + b5;
 /* Define mean xbeta for Trt=1 for visits 1-3 */
 xbeta1_1 = b0 + b1*1 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*1;
 /* Define mean xbeta for Trt=1 for visit 4 */
 xbeta4_1 = b0 + b1*1 + b2*Avg_LogAge + b3*Avg_y0 +
            b4*Avg_y0*1 + b5;

 /* Define LS means, variances, covariances and correlations */ 
 /* for visit 1 and visit 4 for the control and trt groups at*/
 /* the mean Log(Age)=Avg_LogAge and mean log baseline count=*/
 /* Avg_yo. Note that we need only define these for visits 0 */
 /* and 4 since the means, etc. are the same for visits 1-3. */ 
 Mu1_0 = exp(xbeta1_0) + exp(theta);
 Mu4_0 = exp(xbeta4_0) + exp(theta);
 Mu1_1 = exp(xbeta1_1) + exp(theta);
 Mu4_1 = exp(xbeta4_1) + exp(theta);
 Var1_0 = Mu1_0; 
 Var4_0 = Mu4_0;
 Var1_1 = Mu1_1; 
 Var4_1 = Mu4_1;
 Cov_jk =  exp(theta);
 Corr_jk_0 = Cov_jk/Var1_0;
 Corr_j4_0 = Cov_jk/( sqrt(Var1_0)*sqrt(Var4_0) );
 Corr_jk_1 = Cov_jk/Var1_1;
 Corr_j4_1 = Cov_jk/( sqrt(Var1_1)*sqrt(Var4_1) );

 estimate 'Mean Rate Trt(0): Visit<4' Mu1_0;
 estimate 'Mean Rate Trt(1): Visit<4' Mu1_1;
 estimate 'Mean Difference : Visit<4' Mu1_0 - Mu1_1;
 estimate 'Rate Ratio(1:0) : Visit<4' Mu1_1/Mu1_0;
 estimate 'Mean Rate Trt(0): Visit=4' Mu4_0;
 estimate 'Mean Rate Trt(1): Visit=4' Mu4_1;
 estimate 'Mean Difference : Visit=4' Mu4_0 - Mu4_1;
 estimate 'Rate Ratio(1:0) : Visit=4' Mu4_1/Mu4_0;
 estimate 'Cov(Yij,Yik): All Visits' Cov_jk;
 estimate 'Corr(Yij,Yik) (j<k, k<4) Trt(0):' Corr_jk_0;
 estimate 'Corr(Yij,Yik) (j<k, k=4) Trt(0):' Corr_j4_0;
 estimate 'Corr(Yij,Yik) (j<k, k<4) Trt(1):' Corr_jk_1;
 estimate 'Corr(Yij,Yik) (j<k, k=4) Trt(1):' Corr_j4_1;
 model Yij ~ general(loglike);
 id E_Yi1 E_Yi4 b1-b6 theta;
 predict E_Yi1 out=predMLE;
run; 
data PE_beta;
 set pe_MULTPOISS_MLE;
 if Parameter in ('b0' 'b1' 'b2' 'b3' 'b4' 'b5');
run;
data PE_cov;
 set pe_MULTPOISS_MLE;
 if Parameter in ('theta');
run;
data predMLE;
 set predMLE;
 Visit = 1; predMLE = E_Yi1; y=y1; output;
 Visit = 1; predMLE = E_Yi1; y=y2; output;
 Visit = 1; predMLE = E_Yi1; y=y3; output;
 Visit = 1; predMLE = E_Yi4; y=y4; output;
run; 
%GOF(proc=nlmixed, 
     parms=PE_beta,
	 covparms=PE_cov,
     data=predMLE,
	 subject=ID,
	 fitstats=,
	 omega=Omega,
	 omega_r=Omega_R,
     response=y,
     pred_ind=predMLE, 
     pred_avg=predMLE, 
	 title=,
	 ref=
     );


/*===================================================================*/
/*=== Example 5.2.2. Epileptic seizure data = continued           ===*/
/*===================================================================*/

/*----------------------------*/                    
/*--- Code for Output 5.7  ---*/    
/*---      and Figure 5.4, ---*/    
/*---      Figure 5.5 and  ---*/    
/*---      Figure 5.6      ---*/    
/*----------------------------*/
proc sort data=example4_3_3;
 by ID Trt;
run; 
proc format;
 value Trtfmt 0='Placebo' 1='Active';
data example5_2_2; set example4_3_3;
 by ID Trt;
 noobs=_n_; 
run;
ods graphics on / imagefmt=SASEMF imagename='Fig_5_4_thru_5_6' ;
ods exclude IterHistory NObs SolutionR;
ods output SolutionR=re;
proc glimmix data=example5_2_2 noclprint=3 order=formatted
             plots(obsno)=(Boxplot(Fixed Observed ILINK)
                           PearsonPanel(ILINK) ) empirical;
 class ID Trt;
 model y = Trt LogAge y0 y0*Trt Visit4 / dist=Poisson s;
 random _residual_ / subject=ID ;
 random intercept / subject=ID type=vc s;
 lsmeans Trt / ilink diff e;
 output out=out1 Pearson(blup ilink)=residual;
 format Trt Trtfmt.;
run;
ods graphics off;
 


/*----------------------------*/                    
/*--- Code for Output 5.8  ---*/    
/*---      and Output 5.9  ---*/    
/*----------------------------*/
data new1;
 set example5_2_2;
 Case=1;
run;
data new2;
 set example5_2_2;
 if ID = 207 then delete;
 Case=2;
run;
data new3;
 set example5_2_2;
 if ID = 227 and visit=3 then delete;
 Case=3;
run;
data new4;
 set example5_2_2;
 if ID=207 or (ID = 227 and visit=3) then delete;
 Case=4;
run;
data new; 
 set new1 new2 new3 new4;
run;
proc sort data=new;
 by Case ID visit;
run;
ods listing close;
ods output ParameterEstimates=SSpe;
ods output lsmeans=SSlsmeans;
ods output diffs=SSdiffs;
proc glimmix data=new noclprint=3 order=formatted empirical;
 by Case; 
 class ID Trt;
 model y = Trt LogAge y0 y0*Trt Visit4 / 
           dist=Poisson link=log s;
 nloptions maxiter=500;
 format Trt Trtfmt.;
 random _residual_ / subject=ID ;
 random intercept / subject=ID type=vc;
 lsmeans Trt / ilink diff cl at y0=0.56; ** 0% qunatile;
 lsmeans Trt / ilink diff cl at y0=1.18; ** 25% quantile;
 lsmeans Trt / ilink diff cl at y0=1.79; ** 50% quantile;
 lsmeans Trt / ilink diff cl at y0=2.25; ** 75% quantile;
 lsmeans Trt / ilink diff cl at y0=3.63; ** 100% quantile;
run;
ods output ParameterEstimates=PApe;
ods output lsmeans=PAlsmeans;
ods output diffs=PAdiffs;
proc glimmix data=new noclprint=3 order=formatted empirical;
 by Case; 
 class ID Trt;
 model y = Trt LogAge y0 y0*Trt Visit4 / 
           dist=Poisson link=log s;
 nloptions maxiter=500;
 format Trt Trtfmt.;
 random _residual_ / subject=ID type=cs;
 lsmeans Trt / ilink diff cl at y0=0.56; ** 0% quantile;
 lsmeans Trt / ilink diff cl at y0=1.18; ** 25% quantile;
 lsmeans Trt / ilink diff cl at y0=1.79; ** 50% quantile;
 lsmeans Trt / ilink diff cl at y0=2.25; ** 75% quantile;
 lsmeans Trt / ilink diff cl at y0=3.63; ** 100% quantile;
run;
ods listing;
data pe;
 set PApe(in=a) SSpe(in=b);
 if a then Model='PA';
 if b then Model='SS';
run;
data lsmeans;
 set PAlsmeans(in=a) SSlsmeans(in=b);
 if a then Model='PA';
 if b then Model='SS';
run;
data lsdiffs;
 set PAdiffs(in=a) SSdiffs(in=b);
 if a then Model='PA';
 if b then Model='SS';
 Trt=_Trt;
 Diff=estimate;
 SEdiff=StdErr;
 DFdiff=DF;  
 p_diff=probt;
 RR=exp(estimate);
 LowerRR=exp(Lower);
 UpperRR=exp(Upper);
 keep Case Model Trt Diff SEdiff DFdiff p_diff RR LowerRR UpperRR;  
run;
proc sort data=pe;
 by Case Model;
run;
proc sort data=lsmeans;
 by Case Model Trt;
run;
proc sort data=lsdiffs;
 by Case Model Trt;
run;
data lsout;
 merge lsmeans lsdiffs;
 by Case Model Trt;
 results='Result';
run;

/* Output 5.8 */
proc print data=pe noobs;
 where Model='SS';
 var Case Effect Trt Estimate StdErr DF tValue Probt;
run;

/* Output 5.9 */
proc report data=lsout split = '|' nowindows spacing=1;
 where Model='PA';
 column Case y0 Trt Model, (('_Log Link Scale_' Estimate Diff SEdiff p_diff) 
                            ('Mean' Mu) ('Rate' RR));
 define Case /group 'Case' width=4;
 define y0 /group 'y0' width=4;
 define Trt /group 'Trt' width=7;
 define Model /across 'Marginal Model' width=5 spacing=3;
 define Estimate  / mean format=6.3 'LS Mean' center width=8;
 define Diff  / mean format=6.3 'Diff.' center width=6;
 define SEdiff  / mean format=5.3 'Std Err' center width=7;
 define p_diff  / mean format=6.4 'p-value' center width=7;
 define Mu  / mean format=5.2 'Count' center width=5;
 define RR  / mean format=4.2 'Ratio' center width=5;
 title;
run;
quit;
proc report data=lsout split = '|' nowindows spacing=1;
 where Model='SS';
 column Case y0 Trt Model, (('_Log Link Scale_' Estimate Diff SEdiff p_diff) 
                            ('Mean' Mu) ('Rate' RR));
 define Case /group 'Case' width=4;
 define y0 /group 'y0' width=4;
 define Trt /group 'Trt' width=7;
 define Model /across 'Mixed-Effects Model' width=5 spacing=3;
 define Estimate  / mean format=6.3 'LS Mean' center width=8;
 define Diff  / mean format=6.3 'Diff.' center width=6;
 define SEdiff  / mean format=5.3 'Std Err' center width=7;
 define p_diff  / mean format=6.4 'p-value' center width=7;
 define Mu  / mean format=5.2 'Count' center width=5;
 define RR  / mean format=4.2 'Ratio' center width=5;
 title;
run;
quit;


/*===================================================================*/
/*=== Example 5.4.5. Epileptic seizure data - continued           ===*/
/*===================================================================*/

/*----------------------------*/                    
/*--- Code for Output 5.33 ---*/    
/*----------------------------*/
data example5_4_5;
 set example4_3_3;      
 by ID Visit;
 if Visit=1 then Vtime=-3; ** As per Breslow and Clayton **;
 if Visit=2 then Vtime=-1;
 if Visit=3 then Vtime= 1;
 if Visit=4 then Vtime= 3;
 Vtime=Vtime/10;
run;
data pe;
data cov;
%macro FitModels(method=rspl, random=intercept, 
                 model=Model 1, parms=pe1, covparms=cov1); 
 %let method=%qupcase(&method);
 ods listing close;
 ods output parameterestimates=&parms; 
 ods output covparms=&covparms; 
 proc glimmix data=example5_4_5 method=&method empirical;
  class id;          
  model y=Trt LogAge y0 y0*Trt Vtime / link=log dist=normal s;
  _variance_=_phi_*_mu_;
  nloptions technique=newrap maxiter=500;
  random &random / subject=id type=vc g;
 run;
 data &parms;
  set &parms;
  Model="&model";
  estimation="&method";
  if estimation='RSPL'    then Method='         PQL ';
  if estimation='LAPLACE' then Method='Modified PELS';
 run;
 data &covparms;
  set &covparms;
  Model="&model";
  estimation="&method";
  if estimation='RSPL'    then Method='         PQL ';
  if estimation='LAPLACE' then Method='Modified PELS';
 run;
 data pe;
  set pe &parms;
  Parameter='Fixed ';
  if estimate=. then delete;
 run;
 data cov;
  set cov &covparms;
  Parameter='Random';
  if estimate=. then delete;
  if CovParm='Intercept' then CovParm='psi11';
  if CovParm='Vtime    ' then CovParm='psi22';
  if CovParm='Scale    ' then CovParm='Scale';
 run;
 ods listing;
%mend;
%FitModels(method=rspl, random=Intercept, 
           model=Model IV-a, parms=pe1, covparms=cov1); 
%FitModels(method=laplace, random=Intercept, 
           model=Model IV-a, parms=pe2, covparms=cov2); 
%FitModels(method=rspl, random=Intercept Vtime, 
           model=Model IV-b, parms=pe3, covparms=cov3); 
%FitModels(method=laplace, random=Intercept Vtime, 
           model=Model IV-b, parms=pe4, covparms=cov4);
data all;
 set pe cov(rename=(CovParm=Effect));
run;
proc report data=all HEADLINE HEADSKIP SPLIT='|' nowindows;
 column Model Parameter Effect Method, (Estimate StdErr);
 define Model / Group 'Model' width=10 center;
 define Parameter / Group 'Effect' width=9 center; 
 define Effect / GROUP "Variable" center width=9 ;
 define Method / Across "Method of Estimation" width=25 center;
 define Estimate / MEAN FORMAT=7.4 'Estimate' 
                   width=9 NOZERO spacing=1;
 define StdErr   / MEAN FORMAT=7.4 'Robust SE' 
                   width=9 NOZERO center spacing=1;
run;
quit;


/*----------------------------*/                    
/*--- Code for Figure 5.14 ---*/    
/*----------------------------*/
ods graphics on / imagefmt=SASEMF imagename='Fig_5_14' reset=index;
proc glimmix data=example5_4_5 method=rspl empirical 
             plots = residualpanel(blup ilink);
 class id;          
 model y=Trt LogAge y0 y0*Trt Vtime / link=log dist=normal s;
 _variance_=_phi_*_mu_;
 nloptions technique=newrap maxiter=500;
 random intercept / subject=id type=vc g;
run;
ods graphics off;
quit; 
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/




