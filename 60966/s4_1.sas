* S4_1.sas
*
* Using Headline and Headskip;
title1 'Only in LISTING';
title2 'With HEADLINE and HEADSKIP';
proc report data=rptdata.clinics
            nowd headline headskip;
  column region sex wt;
  define region / group;
  define sex    / across;
  define wt     / analysis mean format=6.2;
  run;
