* E2_9_2.sas
*
* Detecting duplicates using FIRST. and LAST. processing;
******************************************;
title1 '2.9.2 Using FIRST. and LAST. Processing';
title2 'Detecting and saving duplicate observations';
proc sort data=advrpt.lab_chemistry(keep = subject visit labdt)
           out=labs;
   by subject visit;
   run;
data dups;
   set labs;
   by subject visit;
   if not (first.visit and last.visit);
   run;
proc print data=dups;
   run;

******************************************;
title2 'Building a list of unique combinations of the BY variables';
proc sort data=advrpt.lab_chemistry(keep = subject visit labdt)
           out=labs;
   by subject visit;
   run;
data unique;
   set labs;
   by subject visit;
   if first.visit;
   run;
proc print data=unique;
   run;
