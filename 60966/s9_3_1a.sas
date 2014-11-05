* S9_3_1a.sas
*
* Writing to an EXCEL table;

ods listing close;

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

ods html style=default
         path="&path\results"
         body="ch9_3_1a.xls";

title1 'ODS Destination Specifics'; 
title2 "Writing a Table to Excel";

proc report data=rptdata.clinics nowd split='*';
  column region ('Mean Weight*in Pounds' sex,wt ratio);
  define region  / group width=10 'Region'
                   format=$regname. order=formatted;
  define sex     / across 'Gender' 
                     format=$gender. order=data;
  define wt      / analysis mean format=6. ' ';
  define ratio   / computed format=6.3 'Ratio*F/M ';
  rbreak after   / dol skip summarize;
  compute ratio;
     ratio = _c3_ / _c2_;
  endcomp;
  run;

ods _all_ close;
