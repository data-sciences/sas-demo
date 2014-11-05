* S5_1.sas
*
* Using the compute block;

* Creating a new column with a compute block;
title1 'Using The COMPUTE Block';
title2 'Adding a Computed Column';
proc report data=rptdata.clinics nowd split='*';
  column lname sex (' Weight *--' wt wtkg);  
  define lname   / order   width=18 'Last Name*--';
  define sex     / display width=6  'Gender*--';
  define wt      / display format=6. 'Pounds*--';
  define wtkg    / computed format=9.2 'Kilograms*--';
  compute wtkg;  
    wtkg = wt / 2.2;  
  endcomp;  
  run;
