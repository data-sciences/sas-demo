* S1_1.sas
* Simple report;
options nocenter;
title1 'Using Proc REPORT';
title2 'Simple Report';
proc report data=rptdata.clinics nowd;
   columns region lname fname wt;
   define region / display;
   define lname / display;
   define fname / display;
   define wt / display;
   run;
