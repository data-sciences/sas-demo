* S4_4_5.sas
*
* PROC statement options;

* Expanding the space between panels;
title1 'Only in LISTING';
title2 'Using the PSPACE Option';
proc report data=rptdata.clinics nowd 
               split='*' colwidth=3 
               panels=2 pspace=8
               ;
  column lname region wt;
  define lname  / order;
  define region / display  'region';
  define wt     / analysis ' ';
  run;
