* S6_1_7.sas
*
* Using the ID Option with PAGE;

ods pdf file="&path\results\ch6_1_7.pdf" style=printer;
* Using PAGE;
title1 'Refining REPORT Appearance';
title2 'Using ID with PAGE';
proc report data=rptdata.clinics
                     (where=(region in('1','2'))) 
               nowd;
   columns region clinname ht wt;
   define region   / group    width=6;
   define clinname / group    id;
   define ht       / analysis mean;
   define wt       / analysis mean page;
   run;
ods pdf close;
