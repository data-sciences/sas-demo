* S2_4_2.sas
*
* Using Formats;

title1 'Using Proc REPORT';
title2 'MEAN for Height and Weight';
proc report data=rptdata.clinics nowd;
   column region sex ht wt;
   define region / group;
   define sex    / across;
   define ht     / analysis mean format=4.1;
   define wt     / analysis mean;
   format wt 6.2;
   run;
