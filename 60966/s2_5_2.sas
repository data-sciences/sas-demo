* S2_5_2.sas
*
* Text headers in the DEFINE statement;
title1 'Using Proc REPORT';
title2 'DEFINE Statement Text';
proc report data=rptdata.clinics nowd;
  column region sex ('Weight' wt);
  define region / group    format=$6.;
  define sex    / across   format=$3. 'Gender';
  define wt     / analysis mean       '(Mean)';
  run;
