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
/*=== Example 2.2.3. ADEMEX adequacy data                         ===*/
/*===================================================================*/
proc sort data=SASdata.ADEMEX_Adequacy_Data out=example2_2_3;
 by Trt ptid Month Visit; 
run;


/*----------------------------*/
/*--- Code for Output 2.12 ---*/
/*----------------------------*/
ods select Type3 LSMeans; 
ods output LSMeans=lsAvgout LSMeanDiffs=lsAvgdiff; 
proc genmod data=example2_2_3;
 where Month>-1;
 class Trt Month ptid;
 model pCCR = Trt Month / type3;
 repeated subject=ptid / type=cs;
 lsmeans Trt /diff cl;
run; 
ods select Type3; 
ods output LSMeans=lsout LSMeanDiffs=lsdiff; 
proc genmod data=example2_2_3;
 where Month<=28;
 class Trt Month ptid;
 model pCCR = Trt Month Trt*Month / type3;
 repeated subject=ptid / type=cs;
 lsmeans Trt*Month /diff cl;
run; 


/*----------------------------*/
/*--- Code for Figure 2.3  ---*/
/*----------------------------*/
data lsAvgDiff;
 set lsAvgDiff;
 Estimate=-1*Estimate;
 EstimatedDiff=Estimate;
 param='Mean Avg';
run;
data lsavgdiffl;
 set lsavgdiff;
 EstimatedDiff=-1*LowerCL;
 param='Lower CL';
run;
data lsavgdiffu;
 set lsavgdiff;
 EstimatedDiff=-1*UpperCL;
 param='Upper CL';
run;
data lsavgdiffCL;
 set lsavgdiff lsavgdiffl lsavgdiffu;
 Months=32;
 drop estimate;
run;
data lsavgout;
 set lsavgout;
 Estimate=Mean;
 if trt='0' then Treatment=0;
 if trt='1' then Treatment=1;
run;
data lsavgdiff;
 set lsavgdiff;
 treatment=2;
run;
data lsavgsummary;
 length Lab $40;
 set lsavgout lsavgdiff;
 if treatment<2 then probdiff=.;
 else probdiff=probchisq; 
run;
data lsdiff;set lsdiff;
 if Month=_Month;
 Estimate=-1*Estimate;
 param='Mean    ';
run;
data lsdiffl;set lsdiff;
 Estimate=-1*LowerCL;
 param='Lower CL';
run;
data lsdiffu;set lsdiff;
 Estimate=-1*UpperCL;
 param='Upper CL';
run;
data lsdiff;
 set lsdiff lsdiffl lsdiffu;
 Months=Month+0;
run;
data lsdiff;
 set lsdiff lsavgdiffCL;
run;

data anno_lsdiff;
   length function color style $ 8 text $ 6;
   retain function 'symbol' when 'a' 
          xsys ysys '2' position '5' size 3.0 hsys '3';
   set lsdiff;
   if param='Mean' or param='Mean Avg';
   if param='Mean' then do;
     color='black';
     x=Months;
     text='dot';
     y=estimate;
   end;
   if param='Mean Avg' then do;
     color='black';
     x=Months;
     text='dot';
     y=EstimatedDiff;
   end;
run;

proc sort data=lsdiff;
 by Months;
run;
data lsavgout;
 set lsavgout;
 estimate=mean;
 estimateavg=estimate;
run;

data anno_avgall;
   length function color style $ 8 text $ 6;
   retain function 'symbol' when 'a' 
          xsys ysys '2' position '5' size 3.0 hsys '3';
   set lsavgout;
   if trt=1 then do;
    color='black';
    x=32;
    text='dot';
    y=estimateavg;
   end;
   if trt=0 then do;
    color='black';
    x=32;
    text='dot';
    y=estimateavg;
   end;
run;

data lsavgoutL;
 set lsavgout;
 estimateavg=lowercl;
run;
data lsavgoutU;
 set lsavgout;
 estimateavg=uppercl;
run;
data lsavgout;
 set lsavgout lsavgoutL lsavgoutU;
 Months=32;
 drop estimate;
run;

data lsout;
 set lsout;
 Estimate=Mean;
 param='Mean    ';
 Months=Month+0;
run;

data anno_avg;
   length function color style $ 8 text $ 6;
   retain function 'symbol' when 'a' 
          xsys ysys '2' position '5' size 3.0 hsys '3';
   set lsout;
   if .<Months<=28;
   if trt=1 then do;
    color='black';
    x=Months;
    text='dot';
    y=estimate;
   end;
   if trt=0 then do;
    color='black';
    x=Months;
    text='dot';
    y=estimate;
   end;
run;

data lsoutU;
 set lsout;
 estimate=uppercl;
 param='Upper CL';
run;
data lsoutL;
 set lsout;
 estimate=lowercl;
 param='Lower CL';
run;
data lsout;
 set lsout lsoutL lsoutU;
run;
data lsoutsummary;
 set lsavgout lsout;
run;

proc means data=example2_2_3 nway noprint;
 class ptid TriYear Trt;
 var pCCr;
 output out=avgout_indiv mean=pCCr;
run; 
proc means data=avgout_indiv nway noprint;
 class TriYear Trt;
 var pCCr;
 output out=avgout n=n mean=Estimate;
run; 

data anno1;
   length function color style $ 8 text $ 4;
   retain function 'label' when 'a' style "swiss"
          xsys ysys '2' position '5' size 3.0 hsys '3';
   set avgout;
   if TriYear<=28 then do;
    if trt=1 then do;
     color='black';
     x=TriYear;
     text=left(put(n,3.0));
     y=26+4;
    end;
    if trt=0 then do;
     color='black';
     x=TriYear;
     text=left(put(n,3.0));
     y=26;
    end;
   end;
   if TriYear=32 then do;
    if trt=1 then do;
     color='black';
     x=TriYear-1;
     text=compress(left('Test'));
     y=26+4;
    end;
    if trt=0 then do;
     color='black';
     x=TriYear-1;
     text=compress(left('Cntr'));
     y=26;
    end;
   end;	
run;
proc sort data=lsoutsummary;
 by trt Months; 
run;

goptions reset=symbol;
goptions reset=all rotate=landscape gsfmode=replace ftext=swiss
         htext=1.25 hby=1.25 device=sasemf;
run;
proc gplot data=lsoutsummary anno=anno1 gout=SASgraph.chapterfigures;
 axis1 label=(a=90 "Mean Trends in Peritoneal CCr (L/weel/1.73)") 
 order=25 to 75 by 10
 minor=none;
 axis3 label=none 
 order=25 to 75 by 10
 minor=none 
 value=none;
 axis2 label=('Months After Randomization')
 order=-4 to 32 by 4
 offset=(0 cm, 1 cm)
 value=(t=1 ' ' t=10 'Avg.')
 minor=none;
 legend1 position=(inside top right) label=('Group:') 
         shape=symbol(10, 1.5) down=2
         value=(t=1 'Control' t=2 'Treated'); 
 plot Estimate*Months=Trt /vaxis=axis1 haxis=axis2 legend=legend1 
                           anno=anno_avg vref=60 name='Fig2_3';
 plot2 EstimateAvg*Months=Trt / vaxis=axis3  
                                nolegend anno=anno_avgall;
 symbol1 c=black v=none i=hilotj w=3 l=2 mode=include;
 symbol2 c=black f=simplex v=- i=hilotj w=3 l=1 mode=include;
 symbol3 c=black v=none i=hilotj w=3 l=2 mode=include;
 symbol4 c=black f=simplex v=- i=hilotj w=3 l=1 mode=include;
 format Estimate 7.2;
 title;
 footnote;
run;
quit;
/*===================================================================*/
/*====================== End of this example ========================*/
/*===================================================================*/


