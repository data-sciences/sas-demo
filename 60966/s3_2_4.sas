* S3_2_4.sas
*
* Using the PAGE option.;

* Creating Breaks;
title1 'Creating Breaks in the Report';
title2 'One PAGE per Group';
proc report data=rptdata.clinics
               (where=(region in('1' '2' '3' '4'))) 
            nowd;
  column region sex wt,(n mean);
  define region / group format=$6.;
  define sex    / group format=$6. 'Gender';
  define wt     / analysis;
  break after region / skip summarize suppress page;
  run;
