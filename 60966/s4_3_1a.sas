* S4_3_1a.sas
*
* Repeated Text headers in the COLUMN statement;
title1 'Only in LISTING';
title2 'Repeated Text';
proc report data=rptdata.clinics nowd;
  column region sex ('-wt(lb)-' wt,(n mean));
  define region / group;
  define sex    / across;
  define wt     / analysis;
  run;
