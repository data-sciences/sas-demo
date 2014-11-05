* S3_2_2c.sas
*
* Summarizing across a group;

* Creating Breaks;
title1 'Creating Breaks in the Report';
title2 'Using BEFORE With BREAK';
proc report data=rptdata.clinics
               (where=(region in('1' '2' '3' '4'))) 
            nowd;
  column region sex wt,(n mean);
  define region / group format=$6.;
  define sex    / group format=$6. 'Gender';
  define wt     / analysis;
  break after  region / skip;  
  break before region / summarize;  
  run;
