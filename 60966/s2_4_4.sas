* S2_4_4.sas
*
* Using the N statistic with an ACROSS Variable;

title1 'Using Proc REPORT';
title2 'Using N';
proc report data=rptdata.clinics nowd;
   column region n proced,n;
   define region / group;
   define proced / across;
   run;
