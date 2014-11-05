* S7_2_2b.sas
*
* Using compound variable names;

title1 'Extending Compute Blocks';
title2 'Using Compound Variable Names';
title3 'Converting Pounds to Kilograms';

proc report data=sashelp.class nowd;
  column sex ('Weight' weight);  
  define sex    / group 'Sex' format=$3.;
  define weight / analysis mean format=6.1 'Kg';
  compute weight;  
    weight.mean = weight.mean / 2.2;  
  endcomp;  
  run;
