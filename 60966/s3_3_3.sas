* S3_3_3.sas
*
* Creating a summary report;

ods html file="&path\results\ch3_3_3.html"
         style=journal;

* Creating Breaks;
title1 'Creating Breaks in the Report';
title2 'Summarizing After the REPORT';
proc report data=rptdata.clinics
               (where=(region in('1' '2' '3' '4'))) 
            nowd;
  column region sex wt,(n mean);
  define region / group format=$6.;
  define sex    / group format=$6. 'Gender';
  define wt     / analysis;
  define mean   / format=5.1;
  break after region / skip summarize suppress;
  rbreak after / summarize;  
  run;
ods html close;
