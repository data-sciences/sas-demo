* S6_6_3.sas
*
* BY Group Processing;

* Using the BY statement;
proc sort data=rptdata.clinics
          out=clinics;
   by region;
   run;

options nobyline;  
title1 'Refining REPORT Appearance';
title2 'Using the BY Statement with TITLE Options';
title3 '#byvar1 is #byval1';  
proc report data=clinics nowd;
   by region;
   columns clinname ht wt;
   define clinname / group;
   define ht       / analysis mean;
   define wt       / analysis mean;
   run;
