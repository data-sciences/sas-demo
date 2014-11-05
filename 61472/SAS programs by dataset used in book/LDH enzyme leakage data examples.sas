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
/*=== Example 4.5.1. LDH enzyme leakage data                      ===*/
/*===================================================================*/
%include 'c:\SAS macros used in book\nlinmix.sas' /nosource2;
%include 'c:\SAS macros used in book\GOF.sas' /nosource2;

data LDH_data;
 input Flask CCl4 CHCl3 LDH0 LDH001 LDH025 LDH05 LDH1 LDH2 LDH3;
cards;
   1    0.0      0     8     9      9      8   10   10   12   
   2    0.0      0     8    10     10      9   12   15   13   
   3    0.0      0     7     8      8      8    9    9   10   
   4    0.0      0     6     8      6      7    8   10   11   
   5    0.0      5     6    11     14     12   14   13   14   
   6    0.0      5    11    14     16     18   20   21   21   
   7    0.0      5     5     7     13     13   14   15   16   
   8    0.0      5     6     6      7      9   11   12   12   
   9    0.0     10     6    11     20     36   46   44   46   
  10    0.0     10     8    14     24     27   29   32   34   
  11    0.0     10     6     7     17     18   21   22   22   
  12    0.0     10     5     5     15     16   19   22   23   
  13    0.0     25     7    10     25     51   65   66   70   
  14    0.0     25    11    11     33     39   48   52   55   
  15    0.0     25     7     7     17     24   34   37   41   
  16    0.0     25     7     6     16     24   31   36   41   
  17    1.0      0     6    11     13      9   10   11   11   
  18    1.0      0     8    14     15     14   16   19   21   
  19    1.0      0     5     8     10     10   11   12   13   
  20    1.0      0     5     9      8      9   11   12   13   
  21    1.0      5     5    13     18     37   41   42   46   
  22    1.0      5    10    16     22     22   29   30   21   
  23    1.0      5     6    10     14     16   16   20   18   
  24    1.0      5     5     8     15     18   19   21   21   
  25    1.0     10     6    10     25     61   57   60   63   
  26    1.0     10    11    14     26     30   30   35   29   
  27    1.0     10     5     7     24     27   29   32   32   
  28    1.0     10     5     6     16     21   24   27   27   
  29    1.0     25     7     9     23     39   58   53   67   
  30    1.0     25     8    11     28     40   42   75   72   
  31    1.0     25     6     6     15     22   30   44   56   
  32    1.0     25     6     5     15     27   36   43   55   
  33    2.5      0     6     9     19     56   64   33   34   
  34    2.5      0    10    10     19     21   23   28   23   
  35    2.5      0     5     8     18     19   19   21   20   
  36    2.5      0     5    10     21     23   28   29   31   
  37    2.5      5     7    10     22     57   62   66   70   
  38    2.5      5    12    11     24     28   30   35   30   
  39    2.5      5     6     8     19     23   24   27   31   
  40    2.5      5     6     7     21     25   28   30   32   
  41    2.5     10     5    12     28     33   43   49   58   
  42    2.5     10     8    14     23     37   43   47   40   
  43    2.5     10     6     9     33     26   31   34   36   
  44    2.5     10     6     9     19     23   29   34   34   
  45    2.5     25     5     7     22     59   65   67   67   
  46    2.5     25     9     9     24     31   35   46   45   
  47    2.5     25     4     5     21     29   36   54   72   
  48    2.5     25     5     4     15     25   36   40   48   
  49    5.0      0     6     9     52     77   78   73   76   
  50    5.0      0     8     9     60     60   57   73   79   
  51    5.0      0     6     8     45     50   49   60   71   
  52    5.0      0     6    10     42     44   62   62   73   
  53    5.0      5     5    11     21     27   30   36   41   
  54     5       5     9    12     21     22   27   32   28   
  55     5       5     5    10     20     22   24   28   33   
  56     5       5     5     8     17     21   26   27   32   
  57     5      10     4    10     24     26   33   39   47   
  58     5      10    11    11     23     27   31   36   31   
  59     5      10     6     9     25     29   33   37   40   
  60     5      10     5     5     12     16   22   27   29   
  61     5      25     7     7     21     55   60   66   66   
  62     5      25     8     9     23     31   40   58   67   
  63     5      25     5     5     23     31   35   53   66   
  64     5      25     6     4     12     20   31   41   57   
;


/*----------------------------*/                    
/*--- Code for Output 4.20 ---*/    
/*---      and Figure 4.8  ---*/    
/*----------------------------*/
proc print data=LDH_data(obs=32) noobs;
 var Flask CCl4 CHCl3 LDH0 LDH001 LDH025 LDH05 LDH1 LDH2 LDH3;
run;
proc sort data=LDH_data out=example4_5_1;
 by Flask CCl4 CHCl3;
run; 
proc transpose data=example4_5_1 out=example4_5_1T 
               name=timechar prefix=LDH;
 by Flask CCl4 CHCl3;
run;
proc sort data=example4_5_1T;
 by CCl4 CHCl3;
run;
data example4_5_1T;
 retain Group 0;
 set example4_5_1T;
 by CCl4 CHCl3;
 if first.CHCl3 then do;
  Group+1;
 end;
 Time=0 + 10*('.'||substr(timechar,4));
 LDHpct=LDH1;
 LDH=LDH1/100;
 _Time_=Time;
 keep Flask CCl4 CHCl3 Group Time _Time_ LDHpct LDH;
run;
proc means data=example4_5_1T noprint nway mean;
 class Group Time;
 id CCl4 CHCl3;
 var LDH;
 output out=LDHprofile mean=MeanLDH;
run;
proc sort data=LDHprofile(drop=_Type_ _Freq_);
 by Group Time; 
run;
/* Graph the data (Figure 4.8) */
goptions reset=symbol;
goptions reset=all rotate=landscape ftext=swiss
         htext=1.5 hby=1.5 device=sasemf;
footnote;
proc gplot data=LDHprofile gout=SASgraph.chapterfigures;
 plot MeanLDH*Time=Group / vaxis=axis1 haxis=axis2 nolegend frame name='Fig_4_8';
 axis1 label=(a=90 'Proportion LDH Leakage')
       minor=none major=(w=2)
       order=(0 TO 0.80 BY 0.20);
 axis2 label=('Time (hours)') 
       minor=none major=(w=2) order=(0 TO 3 BY .5);
 symbol1 value=none i=join l=1 c=black w=2 repeat=16;
run;
quit;


/*----------------------------*/                    
/*--- Code for Figure 4.9  ---*/    
/*----------------------------*/
proc sort data=example4_5_1T;
 by Group Time;
run;
/* Multivariate Weibull growth model by dose group */
ods listing close;
proc nlmixed data=example4_5_1T;
 by Group; 
 parms b0=2.2 b1=-.693 b2=1 sigsq=0.1;
 eta0 = 1/(1+exp(-b0)); 
 eta1 = exp(b1);       
 eta2 = b2;
 if time=0 then predv = 1 - eta0;
 if time>0 then predv = 1 - eta0*exp(-eta1*(time**eta2));  
 model LDH ~ normal(predv, sigsq);
 id b0 b1 b2 sigsq predv;
 predict predv out=pred ;
run; 
ods listing;
proc print data=pred;
run;
data pred;
 merge pred LDHprofile;
 by Group Time;
run;
proc sort data=pred;
 by CCl4 CHCl3 Time; 
run;
data anno_pred;
 length function color style $ 8 text $ 9;
 retain function 'label' when 'a' 
        xsys ysys '2' position '6' size 4.0 hsys '3';
 set pred;
 by CCl4 CHCl3 Time; 
 if time=3;
  color='black';
  style='SWISS';
  x=time+.05;
  text=compress(left('CHCl3=')||left(chcl3));
  y=MeanLDH;
  if CCl4=0   and CHCl3=5  then position='C';
  else if CCl4=2.5 and CHCl3=10 then position='C';
  else if CCl4=5 and CHCl3=10 then position='C';
  else position='6';
run;

proc gplot data=pred gout=SASgraph.chapterfigures ;
 By CCl4;
 plot  LDH*Time=CHCl3 / vaxis=axis1 haxis=axis2 nolegend /*frame*/ 
                        anno=anno_pred name='Weib_By';
 plot2 predv*Time=CHCl3 / vaxis=axis3 nolegend /*frame*/ anno=anno_pred;
 axis1 label=(a=90 '% LDH Leakage')
       minor=none major=(w=2)
       order=(0 TO 0.80 BY .2);
 axis2 label=('Time (hours)') 
       minor=none major=(w=2) order=(0 TO 3.5 BY .5)
       offset=(,1.5 cm)
       value=(t=8 ' ');
 axis3 label=none
       minor=none major=none
       order=(0 TO 0.80 BY .2)
       value=none;
 symbol1 value=none i=std1mjt l=1 c=black w=2 mode=include repeat=4;
 symbol2 value=none i=join    l=2 c=black w=2 mode=include repeat=4;
 title;
 footnote;
run;
quit;
proc greplay igout=SASgraph.chapterfigures gout=SASgraph.chapterfigures nofs 
             template=L2R2s tc=sashelp.templt;
 treplay 1:Weib_by 2:Weib_by2 3:Weib_by1 4:Weib_by3 name='Fig_4_9';
run;
quit;


/*----------------------------*/                    
/*--- Code for Output 4.21 ---*/    
/*----------------------------*/
%nlinmix(data=example4_5_1T,
    procopt=method=ml covtest,
    maxit=150,
    model=%str(
       beta0 = b00 + b01*ccl4 + b02*chcl3 + b03*ccl4*chcl3; 
       beta1 = b10 + b11*ccl4 + b12*chcl3 + b13*ccl4*chcl3;
       beta2 = b20 + b21*ccl4 + b22*chcl3 + b23*ccl4*chcl3;
       eta0 = 1/(1+exp(-beta0)); 
       eta1 = exp(beta1);
       eta2 = beta2;
       if time=0 then predv = 1-eta0;
       if time>0 then predv = 1-eta0*exp(-eta1*(time**eta2));  
    ),                                                        
    parms=%str(b00=2.2 b01=0 b02=0 b03=0
               b10=-0.693 b11=0 b12=0 b13=0
               b20=1 b21=0 b22=0 b23=0),                        
    stmts=%str(
      class Flask _Time_;
      model pseudo_LDH = d_b00 d_b01 d_b02 d_b03
                         d_b10 d_b11 d_b12 d_b13 
                         d_b20 d_b21 d_b22 d_b23 / 
                         noint notest s cl;
      repeated _Time_ / subject=Flask type=un;
      ods output CovParms=_cov;
      ods exclude ClassLevels; )
); 


/*----------------------------*/                    
/*--- Code for Output 4.22 ---*/    
/*----------------------------*/
%GOF(proc=mixed, 
     parms=_soln,
     covparms=_cov, 
     data=_nlinmix,
	 subject=Flask,
     response=LDH,
     pred_ind=predv, 
     pred_avg=predv, 
     title=,
     opt=noprint);


/*----------------------------*/                    
/*--- Code for Figure 4.10 ---*/    
/*----------------------------*/
proc sort data=_nlinmix;
 by Group Time;
run;
data predRS;
 merge _nlinmix LDHprofile;
 by Group Time;
run;
proc sort data=predRS;
 by Time CCl4 CHCl3;
run;
proc g3d data=predRS gout=SASgraph.chapterfigures;
 by Time;
 where Time>=.5;
 plot CCl4*CHCl3=predv / grid zaxis=axis1 zmin=0 zmax=1 xytype=3 name='Plot3D';          
 axis1 major=(n=4) order=(0 .33 .67 1);
 label predv='% LDH';
run;
quit;
proc greplay igout=SASgraph.chapterfigures gout=SASgraph.chapterfigures nofs 
             template=L2R2s tc=sashelp.templt;
 treplay 1:Plot3D 2:Plot3D2 3:Plot3D1 4:Plot3D3 name='Fig_4_10';
run;
quit; 


/*----------------------------*/                    
/*--- Code for Figure 4.11 ---*/    
/*----------------------------*/
proc sort data=predRS;
 by CCl4 CHCl3 Time; 
run;
data anno_predRS;
 length function color style $ 8 text $ 9;
 retain function 'label' when 'a' 
        xsys ysys '2' position '6' size 4.0 hsys '3';
 set predRS;
 by CCl4 CHCl3 Time; 
 if time=3;
  color='black';
  style='SWISS';
  x=time+.05;
  text=compress(left('CHCl3=')||left(chcl3));
  y=MeanLDH;
  if CCl4=0   and CHCl3=5  then position='C';
  else if CCl4=2.5 and CHCl3=10 then position='C';
  else if CCl4=5 and CHCl3=10 then position='C';
  else position='6';
run;
proc gplot data=predRS gout=SASgraph.chapterfigures ;
 By CCl4;
 plot  LDH*Time=CHCl3 / vaxis=axis1 haxis=axis2 nolegend frame 
                        name='Weibull' anno=anno_predRS;
 plot2 predv*Time=CHCl3 / vaxis=axis3 nolegend frame anno=anno_predRS;
 axis1 label=(a=90 '% LDH Leakage')
       minor=none major=(w=2)
       order=(0 TO 0.80 BY .2);
 axis2 label=('Time (hours)') 
       minor=none major=(w=2) 
       order=(0 TO 3.5 BY .5)
       offset=(,1.5 cm)
       value=(t=8 ' ');
 axis3 label=none
       minor=none major=none
       order=(0 TO 0.80 BY .2)
       value=none;
 symbol1 value=none i=std1mjt l=1 c=black w=2 mode=include repeat=4;
 symbol2 value=none i=join    l=2 c=black w=2 mode=include repeat=4;
 title;
 footnote;
run;
quit;
proc greplay igout=SASgraph.chapterfigures gout=SASgraph.chapterfigures nofs 
             template=L2R2s tc=sashelp.templt;
 treplay 1:Weibull 2:Weibull2 3:Weibull1 4:Weibull3 name='Fig_4_11';
run;
quit; 
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/

