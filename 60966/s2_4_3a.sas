* S2_4_3a.sas
*
* Ordering the report;

title1 'Using Proc REPORT';
title2 'Ordering Values with ORDER=FREQ';
proc report data=rptdata.clinics nowd;
   column region sex ht wt;
   define region / group order=freq;
   define sex / across;
   define ht / analysis mean format=4.1;
   define wt / analysis mean;
   format wt 6.2;
   run;
