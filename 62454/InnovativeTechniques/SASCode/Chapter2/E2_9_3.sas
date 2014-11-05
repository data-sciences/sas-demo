* E2_9_3.sas
*
* Detecting duplicates using SQL;
******************************************;
title1 '2.9.3 Detecting duplicates using SQL';
title2 'Creating a unique key';
* Make the key variables unique;
proc SQL noprint; 
create table nodups as 
   select distinct *
      from advrpt.lab_chemistry(keep=subject visit);
quit;

proc print data=nodups;
   run;


* Eliminate any duplicate observations;
proc SQL noprint; 
create table nodups as 
   select distinct *
      from advrpt.lab_chemistry
         order by subject, visit;
quit;

proc print data=nodups;
   run;
proc print data=advrpt.lab_chemistry;
   run;
