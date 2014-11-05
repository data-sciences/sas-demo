* E2_9_4.sas
*
* Detecting duplicates using PROC FREQ;
******************************************;
title1 '2.9.2 Using PROC FREQ';
title2 'Finding Unique Combinations';
proc freq data=advrpt.lab_chemistry;
   table subject*visit / noprint 
                         out=unique(where=(count=1));
   run;
proc print data=unique;
   run;

******************************************;
title2 'Detecting Duplicates';
proc freq data=advrpt.lab_chemistry;
   table subject*visit / noprint out=dups(where=(count^=1));
   run;
proc print data=dups;
   run;

******************************************;
title2 'Unique Combinations';
proc freq data=advrpt.lab_chemistry;
   table subject*visit / noprint out=unique(keep=subject visit);
   run;
proc print data=unique;
   run;


