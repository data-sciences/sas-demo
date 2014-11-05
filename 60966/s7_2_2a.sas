* S7_2_2a.sas
*
* Using compound variable names;

title1 'Extending Compute Blocks';
title2 'Using Compound Variable Names';

proc report data=sashelp.class nowd;
   column name weight height BMI;
   define name   / display;
   define weight / analysis;
   define height / analysis;
   define bmi    / computed format=4.1 'BMI';
   compute bmi;
      bmi = weight.sum / (height.sum*height.sum) * 703;  
   endcomp;
   run;
