 /*------------------------------------------------------------------ */
 /*              Validating Clinical Trials Using SAS®                */
 /*                                                                   */                                                                                               
 /*               by Carol I. Matthews and Brian C. Shilling          */
 /*       Copyright(c) 2008 by SAS Institute Inc., Cary, NC, USA      */
 /*                        ISBN 978-1-59994-128-8                     */                  
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
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the authors:                                         */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* SAS Press Series                                                  */
 /* Attn: Carol I. Matthews and Brian C. Shilling                     */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  saspress@sas.com           */
 /* Use this for subject field:                                       */
 /*     Comments for Carol I. Matthews and Brian C. Shilling          */
 /*                                                                   */
 /*-------------------------------------------------------------------*/



/*--------------------------------------------------------------**
** PROGRAM:    CHAPTER6_EXAMPLES.SAS
**
** PURPOSE:    PROGRAM EXAMPLES SHOWN IN CHAPTER 6
**
** CREATED:    12/2007
**
** INPUT:      ORGLIB.LABS
**
**--------------------------------------------------------------**
** PROGRAMMED USING SAS VERSION 9.1.3                           **
**--------------------------------------------------------------*/

libname orglib "C:\Data\Original" ;

options noreplace ;


**------------------------------------------------------------------------------**;
**  GET THE LAB DATA                                                            **;
**------------------------------------------------------------------------------**;

data labs ;
   set orglib.labs (keep = patid visitid testname result normlow normhi
                    where=(patid ne ' ' and upcase(testname) in ('ALBUMIN','SERUM SODIUM')));

  lbtest=upcase(testname) ;
  if anyalpha(normlow)=0 then lbstnrlo = input(normlow,best12.);
  if anyalpha(normhi)=0 then lbstnrhi = input(normhi,best12.);


  select(visitid);
    when('SCR') visitnum = 1;
    when('W1')  visitnum = 2;
    when('W2')  visitnum = 3;
    when('W3')  visitnum = 4;
    when('W5')  visitnum = 5;
    when('W6')  visitnum = 6;
   otherwise
  end;

run ;


proc sort data=labs (rename=(result=lbstresn));
   by lbtest ;
run ;

**-------------------------------------------------------------------------------**;
**  EXAMPLE 6.2 - HISTOGRAM PLOTS                                                **;
**-------------------------------------------------------------------------------**;
options nodate nonumber nobyline mprint;

title1 "Laboratory Values by Test Name";
title2 "Laboratory Test: #byval(lbtest)";

ods select plots;
proc univariate data = labs plots;
   by lbtest;
   var lbstresn;
   **title "CHECK FOR EXTREME LAB VALUES";
run;



**-------------------------------------------------------------------------------**;
**  SCATTER PLOTS OF NORMAL RANGES                                               **;
**-------------------------------------------------------------------------------**;

**----- SET GRAPHICS OPTIONS -----**;

** GRAPHING OPTIONS **;
axis1 label = (angle=90 "Result")
      offset= (2);

axis2 label = ('Visit')
      order = (1 to 6 by 1)
      /*value = ('Visit 0' 'Visit 2' 'Visit 3' 'Visit 4' 'Visit 5' 'Visit 6')*/
      value = ('SCR' 'W1' 'W2' 'W3' 'W5' 'W6')
      offset= (2);

symbol1  value=star color=black h=2.00 width=2;
symbol2  value=dot  color=black h=1.50;

** SYSTEM OPTIONS **;
options nodate nonumber nobyline orientation = landscape;
goptions hsize=9.0in vsize=5.5000in htext=10pt ;

ods listing close ;
ods escapechar='^' ;
ods rtf  file="C:\lab_graphs.rtf"
         nogtitle nogfootnote;

%macro graph(test);

   title1 "Laboratory Values by Test Name";
   title2 "Laboratory Test: &test";


   data graph;
     set labs (where = (upcase(lbtest)= "&test")) end=end;

     ** SEND THE NORMAL RANGE HI AND LO VALUES TO MACRO VARIABLES **;
     if end then
       do;
         if lbstnrlo ne . then call symput("lo",put(lbstnrlo,best12.));
         else call symput("lo",put(0,best12.));

         if lbstnrhi ne . then call symput("hi",put(lbstnrhi,best12.));
         else call symput("hi",put(0,best12.));
       end;

   run;

   proc gplot data = graph;
      plot lbstresn * visitnum /
      vaxis=axis1
      haxis=axis2
      noframe
      vref = &lo. &hi.
      lvref = (2 4);
    run;
   quit;

%mend graph;
%graph(ALBUMIN)
%graph(SERUM SODIUM)

ods rtf close ;
ods listing ;
