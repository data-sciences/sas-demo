* S2_4_5b.sas
*
* Using a format with the N statistic;


title1 'Using Proc REPORT';
title2 'No Statistic for PROCED';
proc report data=rptdata.clinics nowd;
   column region n proced;
   define region / group;
   define proced / across;
   define n      / format=8.;
   run;
