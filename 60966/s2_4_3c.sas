* S2_4_3c.sas
*
* Ordering the report;

title1 'Using Proc REPORT';
title2 'Ordering Values with ORDER=DATA';
proc report data=rptdata.clinics nowd;
   column region sex ht wt;
   define region / group;
   define sex    / across   order=data;
   define ht     / analysis mean format=4.1;
   define wt     / analysis mean;
   format wt 6.2;
   run;

