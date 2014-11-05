* S4_4_6.sas
*
* PROC statement options;

* Changing the size of the page;
title1 'Only in LISTING';
title2 'Using the PS and LS Options';
proc report data=rptdata.clinics nowd 
               split='*' colwidth=3 
               panels=3
               ls=80 ps=30
               ;
  column lname region wt;
  define lname  / order;
  define region / display 'region';
  define wt     / analysis ' ';
  run;
