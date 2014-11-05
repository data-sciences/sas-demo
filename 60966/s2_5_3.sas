* S2_5_3.sas
*
* Text headers in the DEFINE statement;
title1 'Using Proc REPORT';
title2 'Using SPLIT=';
proc report data=rptdata.clinics nowd split='*';
  column region sex ('Weight*Pounds' wt);
  define region / group    format=$6. ;
  define sex    / across   format=$3. 'Gender';
  define wt     / analysis mean       '(Mean)';
  run;
