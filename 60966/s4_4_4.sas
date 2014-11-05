* S4_4_4.sas
*
* PROC statement options;

* Creating Panels;
title1 'Only in LISTING';
title2 'Using the PANELS Option';
proc report data=rptdata.clinics nowd 
               split='*' colwidth=3 
               panels=2
               ;
  column lname region wt;
  define lname  / order;
  define region / display  'region';
  define wt     / analysis ' ';
  run;
