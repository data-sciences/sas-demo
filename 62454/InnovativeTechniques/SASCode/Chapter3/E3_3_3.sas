* E3_3_3.sas
*
* Sorting using a HASH table.;
******************************************;

title1 '3.3.3 Sorting Using a HASH table';
title2 'Proc SORT solution';

* determine the list of unique clinic numbers;
proc sort data=advrpt.demog(keep=clinnum subject lname fname dob) 
          out=list nodupkey;
   by clinnum subject;
   run;
proc print data=list;
   run;

******************************************;
title2 'Using the HASH Object';
data _null_;
   if 0 then set advrpt.demog(keep=clinnum subject lname fname dob);
   declare hash clin (dataset:'advrpt.demog', ordered:'Y') ;
      clin.definekey ('clinnum','subject');
      clin.definedata ('clinnum','subject','lname','fname','dob') ;
      clin.definedone () ;
   clin.output(dataset:'clinlist');
   stop;
   run;

proc print data=clinlist;
   run;
