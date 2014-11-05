* S1_2.sas
* Simple report with ODS;

ods html file="&path\results\ch1_2simple.html";

title1 'Using Proc REPORT';
title2 'Simple Report';
proc report data=rptdata.clinics nowd;
   columns region lname fname wt;
   define region / display;
   define lname / display;
   define fname / display;
   define wt / display;
   run;

ods html close;
