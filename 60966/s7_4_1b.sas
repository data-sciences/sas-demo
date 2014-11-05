
* S7_4_1b.sas
*
* Assigning a character value to a numeric variable;

proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Extending Compute Blocks';
title2 'Using COMPUTE to Supply Summary Text';

proc report data=rptdata.clinics nowd split='*';
  column region ht wt;
  define region  / group width=8 format=$regname. 'Region' 
                   format=9.2 ;
  define ht      / analysis mean format=6.2 'Height';
  define wt      / analysis mean format=6.2 'Weight';
  rbreak after   / summarize dol suppress;

  * Text for the report summary line;
  * This will fail because region is a 
  * Character variable;
  compute after;
     region = 999;
  endcomp;
  run;
