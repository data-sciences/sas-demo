* E2_4_1.sas
* 
* Using PROC TRANSPOSE;

title1 'Using PROC TRANSPOSE';
title2 '2.4.1a Incompletely Specified Observations';
proc sort data=advrpt.lab_chemistry
           out=lab_chemistry(where= (subject in('208', '209')))
           nodupkey;
   by subject visit sodium;
   run;

proc transpose data=lab_chemistry(keep=subject visit sodium)
                 out=lab_nonnormal(keep=subject visit:)
                 prefix=Visit;
   by subject;
   var sodium;
   run;

proc print data=lab_nonnormal;
   run;

title2 '2.4.1b BY and ID Form a Unique Key';
proc transpose data=lab_chemistry(keep=subject visit sodium)
                 out=lab_nonnormal(keep=subject visit:)
                 prefix=Visit;
   by subject;
   id visit;
   var sodium;
   run;

proc print data=lab_nonnormal;
   run;
