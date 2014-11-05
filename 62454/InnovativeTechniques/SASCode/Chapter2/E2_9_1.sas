* E2_9_1.sas
*
* Detecting duplicates using SORT;
******************************************;
title1 '2.9.1 Using NODUP with PROC SORT';
title2 'Show the first 4 observations';
proc print data=advrpt.lab_chemistry(obs=4);
run;

******************************************;
title2 'Sort with an insufficient Key';
proc sort data=advrpt.lab_chemistry 
          out=none noduprec
          ;
   by subject;
   run;
******************************************;
title2 'Sorting with all Variables';
proc sort data=advrpt.lab_chemistry 
           out=none nodup
           dupout=dups;
   by _all_;
   run;

proc print data=dups;
   run;
