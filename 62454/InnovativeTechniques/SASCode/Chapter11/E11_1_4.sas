* E11_1_4.sas
*
* Using PERSIST to cross Step boundaries;

ods listing close;


***********************************************;
title1 '11.1.4 Using the Persist Option';
ods output extremeobs(persist=proc)=pmatched;
ods listing close;

proc univariate data=advrpt.demog;
   class sex;
   id lname fname;
   var ht wt;
   run;

proc univariate data=advrpt.demog;
   class edu;
   id lname fname;
   var ht wt;
   run;
ods output close;

ods listing;
title2 'matched';
proc print data=pmatched;
   run; 
