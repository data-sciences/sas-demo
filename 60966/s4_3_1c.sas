* S4_3_1c.sas
*
* Repeated Text headers in the DEFINE statement;
title1 'Only in LISTING';
title2 'Repeated < and >Text in the DEFINE Statement';
proc report data=rptdata.clinics nowd;
  column region sex ('Patient Weight' wt,(n mean));
  define region / group;
  define sex    / across   'Sex';
  define wt     / analysis '<(lb)>';
  run;
