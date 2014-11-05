* S4_4_3.sas
*
* PROC statement options;

* Using the COLWIDTH option;
title1 'Only in LISTING';
title2 'Using the COLWIDTH Option';
proc report data=rptdata.clinics 
            nowd 
            split='*' 
            colwidth=4;
  column region sex ('Patient Weight'wt,(n mean));
  define region / group;
  define sex    / across   'Sex';
  define wt     / analysis '(lb)*__';
  run;
