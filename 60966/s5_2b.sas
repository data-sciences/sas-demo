* S5_2b.sas
*
* Using the compute block;

* Calculations based on two statistics columns;
title1 'Using The COMPUTE Block';
title2 'Calculations Based on Two Statistics Columns';
proc report data=rptdata.clinics nowd split='*';
  column region (wt,(mean std stderr n) wtse);  
  define region / group    width=7 'Region*--';
  define wt     / analysis 'Pounds*--';
  define wtse   / computed format=9.2 'STD Error*--';
  compute wtse;
    wtse = wt.std / sqrt(wt.n);  
  endcomp;
  run;
