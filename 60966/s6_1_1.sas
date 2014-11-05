* S6_1_1.sas
*
* Changing Display Order with DESCENDING;

* Using DESCENDING;
title1 'Refining REPORT Appearance';
title2 'Using the DESCENDING Option';
proc report data=rptdata.clinics
			(where=(region in('1','2','3'))) nowd;
   columns clinname ht wt;
   define clinname / group descending;
   define ht       / analysis mean format=6.1;
   define wt       / analysis mean format=6.1;
   run;
