* S2_5_1a.sas
*
* Adding Text headers;

ods rtf file="&path\results\ch2_5_1a.rtf" style=rtf bodytitle;
* Text headers in the COLUMN statement;
title1 'Using Proc REPORT';
title2 'Column Text';
proc report data=rptdata.clinics nowd;
  column region ('Gender' sex) ;
  define region / group;
  define sex    / across format=$3.;
  run;
ods rtf close;
