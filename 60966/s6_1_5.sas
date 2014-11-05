* S6_1_5.sas
*
* Using NOPRINT;

* Masking a column with NOPRINT;
title1 'Refining REPORT Appearance';
title2 'Masking a Column with NOPRINT';
proc report data=rptdata.clinics nowd;
  column lname sex (' Weight' wt wtkg);  
  define lname   / order    width=18   'Last Name';
  define sex     / display  width=6    'Gender';
  define wt      / analysis noprint;
  define wtkg    / computed format=9.2 'Kilograms';
  compute wtkg;  
    wtkg = wt.sum / 2.2;  
  endcomp;  
  run;
