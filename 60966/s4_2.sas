* S4_2.sas
*
* Options with BREAK and RBREAK;
title1 'Only in LISTING';
title2 'RBREAK with Double Overline (DOL)';
proc report data=rptdata.clinics nowd;
  column region sex wt;
  define region / group;
  define sex    / across;
  define wt     / analysis mean format=6.2;
  rbreak after / summarize dol;
  run;
