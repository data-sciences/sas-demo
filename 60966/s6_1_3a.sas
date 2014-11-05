* S6_1_3a.sas
*
* Allowing the Use of MISSING Classification Items;

* Counting Procedure types within Region;
title1 'Refining REPORT Appearance';
title2 'Counting Procedures Without MISSING';
proc report data=rptdata.clinics nowd;
   column region n proced,n;
   define region / group  width=6;
   define n      /        width=3;  
   define proced / across width=3;
   run;
