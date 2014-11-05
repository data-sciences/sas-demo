* S2_4_5c.sas
*
* Using a format with various statistics;


* Using Define Statements with Statistics;
title1 'Using Proc REPORT';
title2 'Using DEFINE Statements for Statistics';
proc report data=rptdata.clinics nowd;
   column region wt,(n mean var); 
   define region / group;
   define n      / format=4.;
   define mean   / format=6.2;
   define var    / format=7.2;
   run;
