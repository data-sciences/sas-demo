* E8_1_4.sas
*
* Using CLASSDATA= with TABULATE;


* Create a subset of symptoms ('00' does not exist in the data);
data symplevels;
      symp='00'; output symplevels;
      symp='01'; output symplevels;
      symp='02'; output symplevels;
   run;

ods html style=journal
         path="&path\results"
         body='E8_1_4a.html';
title1 '8.1.4a Using CLASSDATA= with EXCLUSIVE';

proc tabulate data=advrpt.demog
              classdata=symplevels exclusive;
   class symp;
   var ht wt;
   table symp,
         (ht wt)*(n*f=2. min*f=4. median*f=7.1 max*f=4.);
   run;
ods html close;

ods html style=journal
         path="&path\results"
         body='E8_1_4b.html';
title1 '8.1.4b Using CLASSDATA= without EXCLUSIVE';

proc tabulate data=advrpt.demog
               classdata=symplevels;
   class symp;
   var ht wt;
   table symp,
         (ht wt)*(n*f=2. min*f=4. median*f=7.1 max*f=4.);
   run;
ods html close;
