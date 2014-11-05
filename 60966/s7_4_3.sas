* S7_4_3.sas
*
* Creating a dummy column ;

* Changing Summary Line Text;
proc format;
   value $regname
     '1','2','3' = 'No. East'  
     '4'         = 'So. East'
     '5' - '8'   = 'Mid West' 
     '9', '10'   = 'Western';
   run;

title1 'Extending Compute Blocks';
title2 'Using COMPUTE to Create a Text Column';

proc report data=rptdata.clinics nowd split='*';
  column region regname edu ht wt;
  define region  / group noprint format=$regname.;
  define regname / computed 'Region';
  define edu     / analysis mean format=9.2 'Years of*Education';
  define ht      / analysis mean format=6.2 'Height';
  define wt      / analysis mean format=6.2 'Weight';
  rbreak after   / summarize dol;

  * Determine the region name;
  compute regname / char length=8;
     if _break_='_RBREAK_' then regname = 'Combined';
     else regname = put(region,$regname.);
  endcomp;
  run;
