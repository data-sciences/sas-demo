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
/*=== Example 5.4.4. Cefamandole pharmacokinetic data             ===*/
/*===================================================================*/

data cefamandole_data;
input Subject time Conc;
datalines;
1  10 127.00
1  15  87.00
1  20  47.40
1  30  39.90
1  45  24.80
1  60  17.90
1  75  11.70
1  90  10.90
1 120   5.70
1 150   2.55
1 180   1.84
1 240   1.50
1 300   0.70
1 360   0.34
2  10 120.00
2  15  90.10
2  20  70.00
2  30  40.10
2  45  24.00
2  60  16.10 
2  75  11.60
2  90   9.20
2 120   5.20
2 150   3.00
2 180   1.54
2 240   0.73
2 300   0.37
2 360   0.19
3  10 154.00
3  15  94.00
3  20  84.00
3  30  56.00
3  45  37.10
3  60  28.90
3  75  25.20
3  90  20.00
3 120  12.40
3 150   8.30
3 180   4.50
3 240   3.40
3 300   1.70
3 360   1.19
4  10 181.00
4  15 119.00
4  20  84.30
4  30  56.10
4  45  39.80
4  60  23.30
4  75  22.70
4  90  13.00
4 120   8.00
4 150   2.40
4 180   1.60
4 240   1.10
4 300   0.48
4 360   0.29
5  10 253.00
5  15 176.00
5  20 150.00
5  30  90.30
5  45  69.60
5  60  42.50
5  75  30.60
5  90  19.60
5 120  13.80
5 150  11.40
5 180   6.30
5 240   3.80
5 300   1.55
5 360   1.22
6  10 140.00
6  15 120.00
6  20 106.00
6  30  60.40
6  45  60.90
6  60  42.20
6  75  26.80
6  90  22.00
6 120  14.50
6 150   8.80
6 180   6.00
6 240   3.00
6 300   1.30
6 360   1.03
;


/*----------------------------*/                    
/*--- Code for Figure 5.12 ---*/    
/*----------------------------*/
data example5_4_4;
 set cefamandole_data;
 log_conc=log(Conc);
 hour=time/60;
run;
proc sort data=	example5_4_4 ;
 by Subject time;
run;
goptions reset=all rotate=landscape ftext=swiss
         htext=1.5 hby=1.5 device=sasemf;
proc gplot data=example5_4_4 gout=SASgraph.chapterfigures ;
 axis1 label = (A=90 R=0 'Concentration (ug/mL)')
       order=0 TO 300 by 30
       width=2
       minor = none
       major = (W=2);
 axis2 order = 0 TO 6 by 1
       width=2
       label = ('Time (hours)')
       minor = none
       major = (W=2);
 plot Conc*hour=Subject / vaxis=axis1 haxis=axis2 frame nolegend name='Cefam';
 symbol1 c=black v=none I=join L=1 R=12 w=2;
run;
quit;
proc gplot data=example5_4_4 gout=SASgraph.chapterfigures ;
 axis1 label = (A=90 R=0 'Ln(Concentration (ug/mL))')
       order=-2 TO 6 by 2
       width=2
       minor = none
       major = (W=2);
 axis2 order = 0 to 6 by 1
       width=2
       label = ('Time (hours)')
       minor = none
       major = (W=2);
 plot log_Conc*hour=Subject / vaxis=axis1 haxis=axis2 frame nolegend name='LogCefam';
 symbol1 c=black v=none I=join L=1 R=12 w=2;
run;
quit;
proc greplay igout=SASgraph.chapterfigures gout=SASgraph.chapterfigures nofs
             template=h2ednf tc=temp;
 tdef h2ednf   1 / llx=0 lly=0 ulx=0 uly=100
                   urx=100 ury=100 lrx=100 lry=0
               2 / llx=1 lly=1 ulx=1 uly=90
                   urx=49 ury=90 lrx=49 lry=1
               3 / llx=50 lly=1 ulx=50 uly=90
                   urx=99  ury=90 lrx=99  lry=1;
 treplay 2:cefam 3:logcefam name='Fig_5_12';
run;
quit; 


/*----------------------------*/                    
/*--- Code for Output 5.31 ---*/    
/*----------------------------*/
ods listing close; 
ods output parameterestimates=OLSpe;
proc nlmixed data=example5_4_4 ;
 by Subject;
 parms beta1=5.5 beta2=1.5 beta3=4 beta4=-0.12 
       sigsq_w=1 delta=1;
 func = exp(beta1)*exp(-exp(beta2)*hour) + 
        exp(beta3)*exp(-exp(beta4)*hour);
 var_conc = sigsq_w*(func**(2*delta));
 model conc ~ normal(func, var_conc); 
run;
ods listing;
data OLSpe1; set OLSpe;
 by Subject;
 if Parameter = 'beta4' then do;
    Parameter = 't_half'; Estimate=log(2)/exp(Estimate); 
 end;
 if Parameter = 't_half'; 
run;
data OLSpe2; set OLSpe OLSpe1;
 by Subject;
run;
proc transpose data=OLSpe2 out=OLS;
 by subject;
 var estimate;
 id Parameter;
run;
proc print data=OLS noobs;
 var Subject beta1-beta4 sigsq_w delta t_half;
run;


/*----------------------------*/                    
/*--- Code for Output 5.32 ---*/    
/*---      and Table 5.4   ---*/    
/*----------------------------*/
proc means data=OLSpe2 nonobs n mean median var
                       stderr nway maxdec=4;
 class Parameter;
 var Estimate;
 output out=STSresults mean=Estimate Median=Median 
                       var=Variance stderr=SE;
run;
data STSparms; set STSresults;
 if Parameter='beta1' then output;
 if Parameter='beta2' then output;
 if Parameter='beta3' then output;
 if Parameter='beta4' then output;
 if Parameter='beta1' then do;
    Parameter='psi11'; Estimate=Variance;output;
 end;
 if Parameter='beta2' then do;
    Parameter='psi22'; Estimate=Variance;output;
 end;
 if Parameter='beta3' then do;
    Parameter='psi33'; Estimate=Variance;output;
 end;
 if Parameter='beta4' then do;
    Parameter='psi44'; Estimate=Variance;output;
 end;
 if Parameter='delta' then do;
    Parameter='delta'; Estimate=Median;output;
 end;
 if Parameter='sigsq_w' then do;
    Estimate=Median;output;
 end;
 if Parameter='t_half' then delete;
run;
proc sort data=STSparms;
 by Parameter;
run;
proc print data=STSparms;
run;

proc nlmixed data=example5_4_4 qpoints=1;
 parms /data=STSparms;
 beta1i = beta1 + b1i; beta2i = beta2 + b2i;
 beta3i = beta3 + b3i; beta4i = beta4 + b4i;
 t_half = log(2)/exp(beta4);
 func = exp(beta1i)*exp(-exp(beta2i)*hour) + 
        exp(beta3i)*exp(-exp(beta4i)*hour);
 var_conc = sigsq_w*(func**(2*delta));
 model conc ~ normal(func, var_conc); 
 random b1i b2i b3i b4i ~ normal([0,0,0,0],
                                 [psi11,
                                    0  , psi22,
                                    0  ,   0  , psi33, 
                                    0  ,   0  ,   0  , psi44])
        subject=Subject; 
 estimate 't(1/2) - terminal' t_half;
 predict func out=predplot;id func;
run;
proc nlmixed data=example5_4_4 method=firo;
 parms /data=STSparms;
 beta1i = beta1 + b1i; beta2i = beta2 + b2i;
 beta3i = beta3 + b3i; beta4i = beta4 + b4i;
 t_half = log(2)/exp(beta4);
 func = exp(beta1i)*exp(-exp(beta2i)*hour) + 
        exp(beta3i)*exp(-exp(beta4i)*hour);
 var_conc = sigsq_w*(func**(2*delta));
 model conc ~ normal(func, var_conc); 
 random b1i b2i b3i b4i ~ normal([0,0,0,0],
                                 [psi11,
                                    0  , psi22,
                                    0  ,   0  , psi33, 
                                    0  ,   0  ,   0  , psi44])
        subject=Subject; 
 estimate 't(1/2) - terminal' t_half;
run;


/*----------------------------*/                    
/*--- Code for Figure 5.13 ---*/    
/*----------------------------*/
proc sort data=predplot;
 by subject hour;
run;
goptions reset=all rotate=landscape ftext=swiss
         htext=1.5 hby=1.5 device=sasemf;
goptions reset=symbol;
proc gplot data=predplot gout=SASgraph.chapterfigures ;
 by Subject;
 axis1 label = (A=90 R=0 'Concentration (ug/mL)')
       order=0 to 300 by 50
       minor = none;
 axis3 label = none
       order=0 to 300 by 50
       minor = none
       value = none ;
 axis2 order = 0 to 6 by 1
       label = ('Time (hours)')
       minor = none;
 plot  pred*hour=1 / vaxis=axis1 haxis=axis2 frame nolegend name='SSpred';
 plot2 conc*hour=2 / vaxis=axis3 haxis=axis2;
 symbol1 c=black v=none I=spline L=1 R=1 w=2;
 symbol2 c=black h=1.5 v=dot  I=none R=1;
 title;
 footnote;
run;
quit;
proc greplay igout=SASgraph.chapterfigures  gout=SASgraph.chapterfigures 
             nofs template=scat23 tc=temp;
 tdef SCAT23 des="Scatterplots 2x3 Display"
   1/ULX=0 ULY=100 URX=33 URY=100 LLX=0 LLY=50 LRX=33 LRY=50
   2/COPY=1 XLATEX=33
   3/COPY=2 XLATEX=34
   4/COPY=1 XLATEY=-50
   5/COPY=2 XLATEY=-50
   6/COPY=3 XLATEY=-50;
 treplay 1:SSpred 2:SSpred1 3:SSpred2 4:SSpred3 5:SSpred4 6:SSpred5 name='Fig_5_13';
run;
quit;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

