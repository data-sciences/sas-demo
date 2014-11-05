* S4_5_2.sas
*
* DEFINE statement options;

* Define Statement wrap option;
title1 'Using Proc REPORT';
title2 'Define Statement FLOW Option';
proc report data=rptdata.clinics nowd;
  column region clinnum clinname;
  define region   / group width=6;
  define clinnum  / group ;
  define clinname / group width=15 flow;
  run;
