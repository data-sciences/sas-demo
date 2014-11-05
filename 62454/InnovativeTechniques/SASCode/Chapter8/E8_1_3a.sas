* E8_1_3a.sas
*
* Using STYLE= with TABULATE;

ods html style=journal
         path="&path\results"
         body='E8_1_3a.html';
title1 '8.1.3a TABULATE Using the Journal Style';
proc tabulate data=advrpt.demog;
   class race;
   var ht wt;
   table race,
         (ht wt)*(n*f=2. min*f=4. median*f=7.1 max*f=4.)
         /rts=6;
   run;
ods html close;
