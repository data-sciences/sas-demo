* S4_3_2b.sas
*
* Splitting text headers in the DEFINE statement;
title1 'Only in LISTING';
title2 'Text Line with ONLY Repeated Text';
proc report data=rptdata.clinics nowd split='*';
  column region sex ('Patient Weight'wt,(n mean));
  define region / group;
  define sex    / across   'Sex';
  define wt     / analysis '(lb)*__';
  run;
