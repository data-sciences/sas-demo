* S3_2_2b.sas
*
* Summarizing across a group;

* Creating Breaks;
title1 'Creating Breaks in the Report';
title2 'Summarizing and Skipping With BREAK';
title3 'Using Two BREAK Statements';
proc report data=rptdata.clinics
               (where=(region in('1' '2' '3' '4'))) 
            nowd;
  column region sex wt,(n mean);
  define region / group format=$6.;
  define sex    / group format=$6. 'Gender';
  define wt     / analysis;
  break before region / skip;  
  break after  region /summarize;  
  run;
