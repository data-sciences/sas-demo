* E5_3_2.sas
*
* Creating a simple index;

title1 '5.3.2 Creating a Simple Index';

* Index on clinic number;
* Using DATASETS;
proc datasets lib=advrpt;
   modify demog;
   index create clinnum;
   quit;

* Using SQL to build an index on subject;
proc sql noprint;
   create index clinnum
      on advrpt.demog (clinnum);
   quit;

* Use the DATA step ;
data advrpt.demog(index=(clinnum));
   set advrpt.demog;
   run;

/** Delete an index;*/
/*proc datasets lib=advrpt;*/
/*   modify demog;*/
/*   index delete clinnum;*/
/*   quit;*/

* Create index on ssn;
proc sql noprint;
   create index ssn
      on advrpt.demog (ssn);
   quit;

options msglevel=i;
* Use the ssn index;
proc print data=advrpt.demog;
   var lname fname;
   where ssn < '3';
   id ssn;
   run;

* Use the subject index;
proc print data=advrpt.demog;
   by clinnum;
   id clinnum;
   run;

* Print using the SSN index;
proc print data=advrpt.demog;
   by ssn;
   id ssn;
   run;
