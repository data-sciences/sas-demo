* S6_1_6.sas
*
* Using the ID Option;

ods pdf file="&path\results\ch6_1_6.pdf" style=printer;
* Using ID;
title1 'Refining REPORT Appearance';
title2 'Using ID';
proc report data=rptdata.clinics
                  (where=(region in('1','2'))) 
            nowd;
   columns region clinname (ht wt),(min max n mean median);
   define region   / group    width=6;
   define clinname / group    id;
   define ht       / analysis;
   define wt       / analysis;
   run;
ods pdf close;
