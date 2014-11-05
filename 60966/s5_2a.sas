* S5_2a.sas
*
* Using the compute block;

* Calculations based on statistics block;
title1 'Using The COMPUTE Block';
title2 'Calculations Based on a Statistics Column';
proc report data=rptdata.clinics nowd split='*';
  column region (' Weight *--' wt wtkg);
  define region  / group    width=7 
                            'Region*--';
  define wt      / analysis mean 
                            format=8.1 
                            'Pounds*--';  
  define wtkg    / computed format=9.2 
                            'Kilograms*--';
  compute wtkg;
    wtkg = wt.mean / 2.2;  
  endcomp;
  run;
