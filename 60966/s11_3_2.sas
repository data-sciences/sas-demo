* S11_3_2.sas
*
* Adding a computed variable;

title1 'Multiple Computed Blocks';
title2 'Metric Measures';
proc report data=sashelp.class(where=(age in(12,13))) 
            out=out11_3_2 nowd;
   column age sex n weight height bmi;

   define age    / group;
   define sex    / group 'Gender' format=$6.;
   define n      / 'N' format=2.;
   define weight / analysis mean 'Mean Weight' format=6.1;
   define height / analysis mean 'Mean Height' format=6.2;
   define bmi    / computed format=4.1 'BMI';

   compute bmi;
      bmi = weight.mean / (height.mean*height.mean) * 1e4;  
   endcomp;
   run;

proc print data=out11_3_2;
run;
