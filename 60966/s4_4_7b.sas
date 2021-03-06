* S4_4_7b.sas
*
* PROC statement options;

* Using the FORMCHAR option;
title1 'Only in LISTING';
title2 'Replacing Vertical lines with the FORMCHAR Option';
proc report data=rptdata.clinics 
            formchar(1,4,6,7,8,10)=' - - -'
            nowd split='*' box;
  column region sex ('Patient Weight'wt,(n mean));
  define region / group;
  define sex    / across   'Sex';
  define wt     / analysis '(lb)*__';
  run;
