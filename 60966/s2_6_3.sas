* S2_6_3.sas
*
* Adding text lines using the compute block;

proc format;  
  value $regname
    '1' = 'New England'  
    '2' = 'New York'
    '3' = 'Maryland' 
    '4' = 'South East'; 
  run;

* Text Line using COMPUTE;
title1 'Using Proc REPORT';
title2 'Formatted Values';
footnote1;
proc report data=rptdata.clinics
                 (where=(region in('1' '2' '3' '4'))) 
            nowd;
  column region sex wt,(n mean);
  define region / group format=$6.;
  define sex    / group format=$6. 'Gender';
  define wt     / analysis;
  compute before region;
    line @3 region $regname12.;
  endcomp;
  compute after region;
    line ' ';
  endcomp;
  compute after;
    line @20 'Weight taken during';
    line @20 'the entrance exam.';
  endcomp;
  run;
