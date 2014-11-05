* S6_6_2.sas
*
* BY Group Processing;

* Using the BY statement;
proc sort data=rptdata.clinics
          out=clinics;
   by region;
   run;

title1 'Refining REPORT Appearance';
title2 'Using the BY Statement with RBREAK';
proc report data=clinics nowd;
   by region;
   columns clinname ht wt;
   define clinname / group;
   define ht       / analysis mean;
   define wt       / analysis mean;
   rbreak after / dol summarize;
   run;
