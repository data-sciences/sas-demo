* E12_2_4.sas
* 
* Picture Formats and data directives;

title1 '12.2.4 Picture Formats';
title2 'Limiting Significant Digits';
proc format;
  picture Tons
           0         =  '9'
          0< -    <1 =  '99' (prefix='0.' mult=100)
           1 -   <10 =  '9.99' 
          10 - <1000 =  '000.9' 
        1000 - <1e06 =  '000,000'   
        1e06 - <1e09 =  '000.999M' (mult=1e-03)   
        1e09 - <1e12 =  '000.999B' (mult=1e-06);
  run;

data imports;
   do tons = 0, .15, 1.5,1.5e2, 1.5e4, 1.5e7, 1.5e10;
      fmttons = tons;
      output;
   end;
   format fmttons tons.;
   run;
proc print data=imports;
   run;
