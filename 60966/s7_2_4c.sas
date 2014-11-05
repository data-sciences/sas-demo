* S7_2_4c.sas
*
* Counting columns;

* Using indirect column references;
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
title2 'Using Indirect Column References';

proc report data=rptdata.clinics nowd split='*';
  column region ('Mean Weight*in Pounds' sex,wt ratio);
  define region  / group width=10 'Region'
                   format=$regname. order=formatted;
  define sex     / across 'Gender' 
                     format=$gender. order=formatted;
  define wt      / analysis mean format=6. ' ';
  define ratio   / computed format=6.3 'Ratio*F/M ';
  rbreak after   / dol summarize;
  compute ratio;
     ratio = _c2_ / _c3_;
  endcomp;
  run;
