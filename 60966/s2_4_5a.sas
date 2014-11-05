* S2_4_5a.sas
*
* Using a format with the N statistic;


title1 'Using Proc REPORT';
title2 'Using N with a Format';
proc report data=rptdata.clinics nowd;
   column region n proced,n;
   define region / group;
   define proced / across;
   define n      / format=2.;
   run;
