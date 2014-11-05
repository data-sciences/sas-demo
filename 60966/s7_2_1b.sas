* S7_2_1b.sas
*
* Using variable names;

title1 'Extending Compute Blocks';
title2 'Using Variable Names';
title3 'Converting Pounds to Kilograms';

proc report data=sashelp.class nowd;
  column name sex ('Weight' weight);  
  define name   / order             'Name';
  define sex    / display           'Sex';
  define weight / display format=6. 'Kg';
  compute weight;  
    weight = weight / 2.2;  
  endcomp;  
  run;
