* S4_5_1.sas
*
* DEFINE statement options;

* Using the WIDTH option;
title1 'Only in LISTING';
title2 'Using the WIDTH Option';
proc report data=rptdata.clinics nowd 
            split='*' 
            colwidth=4;
  column region sex ('Patient Weight' wt,(n mean));
  define region / group width=6;
  define sex    / across   'Sex' width=2;
  define wt     / analysis '(lb)*__';
  run;
