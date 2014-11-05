* S7_2_5a.sas
*
* Examining the _BREAK_ variable.;

proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   value $gender
     'M' = 'Male'
     'F' = 'Female';
   run;

title1 'Extending Compute Blocks';
title2 'Examining the _BREAK_ Variable';

proc report data=rptdata.clinics nowd split='*'
            out=temptbl;
  column region wt wt=wtmean;
  define region  / group width=10 'Region'
                   order=formatted format=$regname.;
  define wt      / analysis n      format=2.;
  define wtmean  / analysis mean   format=6.2;

  rbreak after   / dol summarize;
  run;

proc print data=temptbl;
  run;
