* S6_6_4b.sas
*
* BY Group Processing;

ods html file="&path\results\ch6_6_4b0.html" 
         newfile=bygroup;

* Using the BY statement;
proc sort data=rptdata.clinics
          out=clinics;
   by region;
   run;

title1 'Refining REPORT Appearance';
title2 'Using the BY Statement';
title3 'Paging in HTML with NEWFILE=BYGROUP';
proc report data=clinics nowd;
   by region;
   columns clinname ht wt;
   define clinname / group;
   define ht / analysis mean;
   define wt / analysis mean;
   run;
ods html close;
