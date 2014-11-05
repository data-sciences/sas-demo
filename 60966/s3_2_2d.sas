* S3_2_2d.sas
*
* Summarizing across a group with HTML;

ods html file="&path/results/ch3_2_2d.html";

* Creating Breaks;
title1 'Creating Breaks in the Report';
title2 'Summarizing With BREAK';
proc report data=rptdata.clinics
                   (where=(region in('1' '2' '3' '4'))) 
            nowd;
  column region sex wt,(n mean);
  define region / group format=$6.;
  define sex    / group format=$6. 'Gender';
  define wt     / analysis;
  break after region / summarize skip;
  run;
ods html close;
