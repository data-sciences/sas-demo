* S2_4_3b.sas
*
* Ordering the report;

ods pdf file="&path\results\ch2_4_3.pdf" style=sansprinter;
title1 'Using Proc REPORT';
title2 'Ordering Values with ORDER=FREQ';
proc report data=rptdata.clinics nowd;
   column region sex ht wt;
   define region / group order=freq descending;
   define sex    / across;
   define ht     / analysis mean format=4.1;
   define wt     / analysis mean;
   format wt 6.2;
   run;
ods pdf close;
