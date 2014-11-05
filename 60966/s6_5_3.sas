* S6_5_3.sas
*
* Using LIST option to show default values;

title1 'Using Proc REPORT';
title2 'Using the LIST Option';
proc report data=rptdata.clinics 
            list nowd;
  column region ht wt;
  define region / group;
  define ht     / analysis mean 'HEIGHT';
  run;
