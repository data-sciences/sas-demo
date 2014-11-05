* S4_4_1.sas
*
* PROC statement options;

* Using the BOX option;
title1 'Only in LISTING';
title2 'Using the BOX Option';
proc report data=rptdata.clinics 
            nowd split='*' 
            box;
  column region sex ('Patient Weight'wt,(n mean));
  define region / group;
  define sex    / across   'Sex';
  define wt     / analysis '(lb)*__';
  run;
