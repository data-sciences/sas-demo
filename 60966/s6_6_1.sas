* S6_6_1.sas
*
* BY Group Processing;

* Using the BY statement;
proc sort data=rptdata.clinics
          out=clinics;
   by region;
   run;
ods pdf file="&path\results\ch6_6_1.pdf" style=printer;
ods rtf file="&path\results\ch6_6_1.rtf" style=rtf;
title1 'Refining REPORT Appearance';
title2 'Using the BY Statement';
proc report data=clinics nowd;
   by region;
   columns clinname ht wt;
   define clinname / group;
   define ht       / analysis mean;
   define wt       / analysis mean;
   run;
ods pdf close;
ods rtf close;
