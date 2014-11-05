* S4_5_3.sas
*
* DEFINE statement options;

* Define Statement spacing option;
title1 'Using Proc REPORT';
title2 'Define Statement SPACING Option';
proc report data=rptdata.clinics nowd;
  column region clinnum clinname;
  define region   / group width=6;
  define clinnum  / group          spacing=5;
  define clinname / group width=15 spacing=5 flow;
  run;
