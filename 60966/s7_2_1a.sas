* S7_2_1a.sas
*
* Using variable names;

title1 'Extending Compute Blocks';
title2 'Using Variable Names';

proc report data=sashelp.class nowd;
   column name weight height BMI;
   define name   / display;
   define weight / display;
   define height / display;
   define bmi    / computed format=4.1 'BMI';
   compute bmi;
      bmi = weight / (height*height) * 703;  
   endcomp;
   run;
