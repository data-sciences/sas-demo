* S6_1_4.sas
*
* Controlling the Use of Analysis Items with all Missing or Zero Values;

* Create an artificial region (12) with missing and 0 values 
* for WT and HT respectfully;
data reg12(keep=region clinname lname wt ht edu);
   set rptdata.clinics(where=(region in('1','2')));
	region='12';
	wt=.;
	ht=0;
	run;

* DEFINE statement without NOZERO;
title1 'Refining REPORT Appearance';
title2 'Artificial Region 12 Data';
title3 'Without the NOZERO Option';
proc report data=reg12 nowd;
  column region lname edu ht wt;
  define region / group    format=$6.; 
  define lname  / order;
  define edu    / analysis format=9.0;
  define ht     / analysis format=6.1;
  define wt     / analysis format=6.1;
  run;

* Using NOZERO on the DEFINE statement;
title1 'Refining REPORT Appearance';
title2 'Artificial Region 12 Data';
title3 'With the NOZERO Option on EDU HT and WT';
proc report data=reg12 nowd;
  column region lname edu ht wt;
  define region / group    format=$6.; 
  define lname  / order;
  define edu    / analysis format=9.0 nozero;
  define ht     / analysis format=6.1 nozero;
  define wt     / analysis format=6.1 nozero;
  run;

* Using NOZERO on the DEFINE statement;
title1 'Refining REPORT Appearance';
title2 'Artificial Region 12 Data';
title3 'With the NOZERO Option on a Statistic';
proc report data=reg12 nowd;
  column region clinname edu ht wt;
  define region   / group         format=$6.; 
  define clinname / group;
  define edu      / analysis mean format=9.0 nozero;
  define ht       / analysis mean format=6.1 nozero;
  define wt       / analysis mean format=6.1 nozero;
  run;


