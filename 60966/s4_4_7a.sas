* S4_4_7a.sas
*
* PROC statement options;

* Using the FORMCHAR option;
title1 'Only in LISTING';
title2 'Using the FORMCHAR Option';
proc report data=rptdata.clinics 
            formchar(7)='|'
            nowd split='*'
            box;
  column region sex ('Patient Weight'wt,(n mean));
  define region / group;
  define sex    / across   'Sex';
  define wt     / analysis '(lb)*__';
  run;
