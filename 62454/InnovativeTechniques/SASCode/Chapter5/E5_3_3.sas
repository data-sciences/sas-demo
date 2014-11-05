* E5_3_3.sas
*
* Creating a composite index;

title1 '5.3.3 Creating a Composite Index';
options msglevel=i;
* Index on subject;
* Using DATASETS;
proc datasets lib=advrpt;
   modify conmed;
   index create drgstart=(drug medstdt);
   quit;

* Using SQL;
proc sql noprint;
   create index drgstart
      on advrpt.conmed (drug, medstdt);
   quit;

* Build in the DATA step;
data demog3(index=(drgstart=(drug medstdt)));
   set advrpt.conmed;
   run;

* Use the NAME index;
proc print data=advrpt.conmed;
   where drug < 'C';
   var medspdt mednumber;
   by drug medstdt;
   id drug medstdt;
   run;

* Use the group index;
proc means data=advrpt.conmed noprint;
   by drug;
   var mednumber;
   output out=sumry max= n=/autoname;
   run;
proc print data=sumry;
   run;


* Delete a compound index;
proc datasets lib=advrpt;
   modify conmed;
   index delete drgstart;
   quit;
