* E2_7_2.sas
*
* Using WHERE When processing BY Groups;

title1 '2.7.2 WHERE and BY Group Processing';

* subset the data for demonstration purposes;
proc sort data=advrpt.demog(where=(substr(clinnum,2,1) in('3','4')))
           out=demog;
   by clinnum symp;
   run;

proc print data=demog;
   var clinnum symp subject;
   run;

* count symptoms within clinnum;
title2 'Counts generated Using a Subsetting IF';
**** This step miscounts!!!!! **********;
data IFcnt(keep=clinnum IFsympcnt);
   set demog(keep=clinnum symp);
   by clinnum symp;
   if symp ne ' ';
   if first.clinnum then do;
      IFsympcnt=0;
      end;
   if first.symp then IFsympcnt+1;
   if last.clinnum then output;
   run;
proc print data=ifcnt;
   run;
 
title2 'Counts generated Using a WHERE';
data WHEREcnt(keep=clinnum Wsympcnt);
   set demog(keep=clinnum symp);
   by clinnum symp;
   where symp ne ' ';
   if first.clinnum then do;
      Wsympcnt=0;
      end;
   if first.symp then Wsympcnt+1;
   if last.clinnum then output;
   run;
proc print data=wherecnt;
   run;

title2 'Showing Counts';
data bothcounts;
   merge ifcnt wherecnt;
   by clinnum;
   run;
proc print data=bothcounts;
   run;

* *******************************************************
* Correct the problem in the DATA step using the IF;

* count symptoms within clinnum;
title2 'Counts generated Using a Subsetting IF';
data IFcnt(keep=clinnum IFsympcnt);
   set demog(keep=clinnum symp);
   by clinnum symp;
   if first.clinnum then do;
      IFsympcnt=0;
      end;
   * Only count non missing symptoms;
   if first.symp & symp ne ' ' then IFsympcnt+1;
   if last.clinnum then output;
   run;
proc print data=ifcnt;
   run;
 
title2 'Showing Counts Using the Corrected IF';
data bothcounts;
   merge ifcnt wherecnt;
   by clinnum;
   run;
proc print data=bothcounts;
   run;
