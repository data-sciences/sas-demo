* E11_1_3.sas
*
* Naming the OUTPUT data set Using MATCH_ALL;

ods listing close;

***********************************************;
title1 '11.1.3 Using MATCH_ALL';
ods output extremeobs(match_all)=matched;
ods listing close;

proc sort data=advrpt.demog
          out=bysex;
   by sex;
   run;
proc univariate data=bysex;
   by sex;
   id lname fname;
   var ht wt;
   run;

ods listing;
title2 'matched';
proc print data=matched;
   run; 

title2 'matched1';
proc print data=matched1;
   run;

title2 'matched2';
proc print data=matched2;
   run;

title2 'matched3';
proc print data=matched3;
   run;

