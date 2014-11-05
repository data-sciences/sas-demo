* S7_2_1c.sas
*
* Using variable names;

title1 'Extending Compute Blocks';
title2 'Using Variable Names';
title3 'Creating an OBS Column';

proc report data=sashelp.class nowd;
  column obs name sex weight;  
  define obs    / computed 'Obs'    format=3.;
  define name   / order    'Name';
  define sex    / display  'Sex';
  define weight / display  'Weight' format=6.2 ;
  compute obs;
     cnt + 1; 
     obs = cnt;  
  endcomp;  
  run;
