* S7_2_3.sas
*
* Using an Alias;

title1 'Extending Compute Blocks';
title2 'Using an Alias';

proc report data=rptdata.clinics nowd;
   column region ('Weight in Pounds' wt wt=wtmax wt_range);
   define region   / group format=$6.;
   define wt       / analysis min    'Min';
   define wtmax    / analysis max    'Max';
   define wt_range / computed        'Range';
   compute wt_range;
      wt_range = wtmax - wt.min;  
   endcomp;
   run;
