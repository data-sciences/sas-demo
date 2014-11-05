* S6_1_2.sas
*
* Column Justification options;

ods html file="&path\results\ch6_1_2.html";

* Using Justification options;
title1 'Refining REPORT Appearance';
title2 'Using Justification Options';
proc report data=rptdata.clinics
                  (where=(region in('1','2','3'))) 
            nowd;
   columns region ht wt;
   define region / group width=7 center;
   define ht     / analysis mean left  format=6.1;
   define wt     / analysis mean right format=6.1;
   run;
ods html close;
