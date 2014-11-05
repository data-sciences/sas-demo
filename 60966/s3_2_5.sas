* S3_2_5.sas
*
* Summarizing in a detail report;

* Creating Breaks;
title1 'Creating Breaks in the Report';
title2 'Detail Report With BREAK';
proc report data=rptdata.clinics
                   (where=(region in('2' '3'))) 
            nowd;
   column region lname wt;
   define region / group width=6;
   define lname  / display;
   define wt     / mean;

   break after region / summarize skip;
   run;
