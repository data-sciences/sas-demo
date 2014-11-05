* S2_5_1b.sas
*
* Text headers in the COLUMN statement;
title1 'Using Proc REPORT';
title2 'Grouped Header';
proc report data=rptdata.clinics nowd;
  column region sex ('Patient Weight (lb)' wt,(n mean));
  define region / group;
  define sex    / group format=$6.;
  define wt     / analysis;
  run;
