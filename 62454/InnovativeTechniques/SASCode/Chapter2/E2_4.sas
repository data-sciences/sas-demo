* E2_4.sas
* 
* Normalized Data;

title1 '2.4 Normalizing Data';
title2 'Normal Form';
proc sort data=advrpt.lab_chemistry
           out=lab_chemistry(where= (subject in('208', '209')))
           nodupkey;
   by subject visit sodium;
   run;

proc print data=lab_chemistry;
   var subject visit sodium;
   run;

title2 'Non-normal Form';
proc transpose data=lab_chemistry(keep=subject visit sodium)
                 out=lab_nonnormal(keep=subject visit:)
                 prefix=Visit;
   by subject;
   id visit;
   var sodium;
   run;

proc print data=lab_nonnormal;
   run;
