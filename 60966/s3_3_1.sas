* S3_3_1.sas
*
* Using the RBREAK statement;

ods html file="&path\results\ch3_3_1.html"
         style=statdoc;

* Creating Breaks;
title1 'Creating Breaks in the Report';
title2 'Summarizing After the Detail REPORT';
proc report data=rptdata.clinics
               (where=(region in('1' '2' '3' '4'))) 
            nowd;
  column lname fname sex dob wt,(n mean);
  define lname / order;
  define fname / order;
  define sex   / group format=$6. 'Gender';
  define dob   / display 'Birthday';  
  define wt    / analysis format=5.1;
  rbreak before / summarize;  
  run;

ods html close;
