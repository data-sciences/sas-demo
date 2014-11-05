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
/*=== Example 4.5.2. Orange tree data                             ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\GOF.sas' /nosource2;
%include 'c:\SAS macros used in book\nlinmix.sas' /nosource2;

data OrangeTree_data;
 input Tree $ Days y;
cards;
1  118   30
1  484   58
1  664   87
1 1004  115
1 1231  120
1 1372  142
1 1582  145
2  118   33
2  484   69
2  664  111
2 1004  156
2 1231  172
2 1372  203
2 1582  203
3  118   30
3  484   51
3  664   75
3 1004  108
3 1231  115
3 1372  139
3 1582  140
4  118   32
4  484   62
4  664  112
4 1004  167
4 1231  179
4 1372  209
4 1582  214
5  118   30
5  484   49
5  664   81
5 1004  125
5 1231  142
5 1372  174
5 1582  177
;


/*----------------------------*/                    
/*--- Code for Figure 1.1  ---*/    
/*----------------------------*/
goptions reset=all rotate=landscape ftext=swiss
         htext=1.5 hby=1.5 device=sasemf;
footnote;

proc gplot data=OrangeTree_data gout=SASgraph.chapterfigures ;
AXIS1 LABEL = (A=90 R=0 'Trunk Circumference (mm)')
      ORDER=0 TO 250 BY 50
      WIDTH=2
      MINOR = NONE
      MAJOR = (w=2);
AXIS2 ORDER = 0 TO 1600 BY 200
      LENGTH=80 PCT
      WIDTH=2
      LABEL = ('Days')
      MINOR = NONE
      MAJOR = (w=2);
 plot y*Days=Tree / vaxis=axis1 haxis=axis2 nolegend name='Fig1_1';
 symbol1 c=black h=1.5 v=dot i=join l=1 w=2;
 symbol2 c=black h=1.5 v=circle i=join l=1 w=2;
 symbol3 c=black h=1.5 v=square i=join l=1 w=2;
 symbol4 c=black h=2.0 v=diamond i=join l=1 w=2;
 symbol5 c=black h=1.5 v=star i=join l=1 w=2;
 title;
run;
quit; 


/*----------------------------*/                    
/*--- Code for Output 4.23 ---*/    
/*----------------------------*/
proc sort data=OrangeTree_data out=example4_5_2;
 by Tree;
run;
proc print data=example4_5_2 noobs;
run;


/*----------------------------*/                    
/*--- Code for Output 4.24 ---*/    
/*----------------------------*/
ods output CovMatParmEst=Omega;
proc nlmixed data=example4_5_2 cov;
 parms b1=150 b2=700  b3=350  sigma_sq=60;
 num = b1+u1;
 den = 1 + exp(-(Days-b2)/b3);
 predmean = (num/den);
 predvar = sigma_sq; 
 model y ~ normal(predmean, predvar);
 random u1 ~ normal(0, psi) subject=Tree;
run;


/*----------------------------*/                    
/*--- Code for Output 4.25 ---*/    
/*----------------------------*/
ods output ParameterEstimates=PE;
ods output CovMatParmEst=Omega_R;
ods select ParameterEstimates CovMatParmEst;
proc nlmixed data=example4_5_2 cov empirical;
 parms b1=150 b2=700  b3=350  sigma_sq=60;
 num = b1+u1;                                          
 den = 1 + exp(-(Days-b2)/b3);                                         
 predmean = (num/den);
 predvar = sigma_sq; 
 model y ~ normal(predmean, predvar);
 random u1 ~ normal(0, psi) subject=Tree;
 predict predmean out=PRED;
run;


/*----------------------------*/                    
/*--- Code for Output 4.26 ---*/    
/*----------------------------*/
data PE_beta; 
 set PE;
 if Parameter IN ('b1' 'b2' 'b3'); 
run; 
data PE_cov;
 set PE;
 if Parameter IN ('sigma_sq' 'psi'); 
run; 
%GOF(proc=nlmixed, 
     parms=PE_beta,
     covparms=PE_cov,
     data=PRED,
     subject=Tree,
     omega=Omega,
     omega_r=Omega_R,
     response=y,
     pred_ind=pred, 
     pred_avg=pred 
    );

 
/*----------------------------*/                    
/*--- Code for Output 4.27 ---*/    
/*----------------------------*/
%nlinmix(data=example4_5_2,                                          
    procopt=method=ml covtest,
    model=%str(
       num = b1+u1;
       den = 1 + exp(-(Days-b2)/b3);
       predv=num/den;
    ),
    parms=%str(b1=150 b2=700 b3=350), 
    stmts=%str(class Tree;
      model pseudo_y = d_b1 d_b2 d_b3 / 
                       noint notest s cl covb;
      random d_u1 / subject=Tree type=un s cl; 
      ods output CovB=Omega; ),
    expand=zero
 ); 
run;




/*===================================================================*/
/*=== Example 5.4.1. Orange tree data = continued                 ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\covparms.sas' / nosource2;

proc sort data=example4_5_2 out=example5_4_1;
 by Tree Days;
run;


/*----------------------------*/                    
/*--- Code for Output 5.20 ---*/    
/*----------------------------*/
/* Step 1: Run NLMIXED on the proposed model */
ods listing close;
ods output ParameterEstimates=OLSparms;
proc nlmixed data=example5_4_1 qpoints=1;
 parms b1=175 b2=700 b3=300 sigsq_w=10 to 100 by 10;
 num = b1+bi1;
 den = 1 + exp(-(Days-(b2+bi2))/(b3+bi3)); 
 predmean = num/den;
 resid = y - predmean;
 model y ~ normal(predmean, sigsq_w);
 random bi1 bi2 bi3 ~ normal([0,0,0],
                             [0,
                              0,0,
                              0,0,0]) 
        subject=Tree;
 predict predmean out=predout der;
 id resid;
run;
ods listing;
/* Step 2: Run the macro COVPARMS based on NLMIXED output */
%covparms(parms=OLSparms, predout=predout, resid=resid, 
          method=mspl, random=der_bi1 der_bi2 der_bi3,
          subject=Tree, type=un, covname=psi, output=MLEparms); 
proc print data=MLEparms;
run;
/* ADDITIONAL CALLS TO %COVPARMS - RESULTS NOT SHOWN IN BOOK */
%covparms(parms=OLSparms, predout=predout, resid=resid,
          method=mspl, random=der_bi1 der_bi2 der_bi3,
          subject=tree, type=vc, covname=psi, output=MLEparms);
%covparms(parms=OLSparms, predout=predout, resid=resid,
          method=mspl, random=der_bi1 der_bi2,
          subject=tree, type=un, covname=psi, output=MLEparms);


/*----------------------------*/                    
/*--- Code for Output 5.21 ---*/    
/*----------------------------*/
/* Step 3: Final call to macro and final run of NLMIXED */
%covparms(parms=OLSparms, predout=predout, resid=resid,
          method=mspl, random=der_bi1,
          subject=tree, type=un, covname=psi, output=MLEparms);
ods listing close;
ods output parameterestimates=pe;
proc nlmixed data=example5_4_1 qpoints=1 ;
 parms / data=MLEparms;
 num = b1+bi1;
 den = 1 + exp(-(Days-b2)/b3);
 predmean = (num/den);
 model y ~ normal(predmean, sigsq_w);
 random bi1 ~ normal(0, psi11) 
        subject=tree;
run;
ods listing;
proc print data=pe noobs; 
 var Parameter Estimate StandardError DF tValue Probt;
run;


/*----------------------------*/                    
/*--- Code for Output 5.22 ---*/    
/*----------------------------*/
data example5_4_1;
 set example5_4_1;
 by Tree Days; 
 retain index;
 array Ind[7] I1-I7;
 if first.Tree then index=0;
 index+1;
 do i=1 to 7;
  Ind[i]=(index=i);
 end;
 days1= 118; days2= 484; days3= 664; days4=1004;
 days5=1231; days6=1372; days7=1582;
run;
/* Add initial value for the autoregressive correlation */
data rho;
 Parameter='rho';estimate=.9;
run;
data MLEparms_rho;
 set MLEparms rho;
 if Parameter='sigsq_w' then estimate=61.5125;
run;
/* Macro VECH creates a vech representation of the */
/* intra-cluster covariance matrix defined in the  */
/* NLMIXED code for any particular application that*/
/* requires an intra-cluster or within-subject     */
/* covariance structure (see Appendix D of Ch  7   */
/* for a more detailed presentation of the macro)  */
%macro vech(dim=4, cov=cov, vechcov=vechcov, name=c);
    %global n vech;
    %let n=%eval(&dim*(&dim+1)/2);
    array &vechcov.[&n] &name.1-&name.&n;
    %let k=0;
    %do i=1 %to &dim;
     %do j=1 %to &i;
        %let k=%eval(&k+1);
        &vechcov.[&k] = &cov.[&i, &j];
     %end;
    %end;
    %let temp = &name.1;
    %do i=2 %to &n;
     %let temp=&temp,&name.&i;
    %end;
    %let vech = &temp;
%mend vech;	

proc nlmixed data=example5_4_1 df=4 qpoints=1;
 parms / data=MLEparms_rho;
 bounds -1<rho<1;
 /* The following variable, eij, is a within-tree   */
 /* error term expressed as a linear combination of */
 /* linear random effects that have a first-order   */
 /* autoregressive structure for unequally spaced   */
 /* time points as defined by ARRAY statements      */
 eij = I1*e1+I2*e2+I3*e3+I4*e4+I5*e5+I6*e6+I7*e7;
 num = b1+bi1;
 den = 1 + exp(-(Days-b2)/b3);
 predmean = (num/den) + eij;
 delta=1e-8;
 /* The following array statements define the first */
 /* order autoregressive covariance matrix assuming */
 /* unequally spaced time points within a cluster   */
 array cov[7,7];
 array d[7] days1-days7;
 do i=1 to 7;
  do j=1 to 7;
   cov[i,j] = sigsq_w*(rho**abs(d[i]-d[j]));
  end;
 end;
 /* This call to the macro VECH creates a 7x7 lower */
 /* diagonal autoregressive covariance matrix with  */
 /* successive elements c1, c2, c3,..., c28 being   */
 /* the components of the vech representation of    */
 /* this matrix where c is determined by the macro  */
 /* variable NAME= option. This is then used in the */
 /* specification of a block diagonal covariance    */
 /* structure where the random effect bi1 is assumed*/
 /* orthogonal to (independent of) the linear random*/
 /* effects, e1, e2,...,e7                          */ 
 %vech(dim=7, cov=cov, name=c);
 model y ~ normal(predmean, delta);
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
        subject=tree;
run;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/
