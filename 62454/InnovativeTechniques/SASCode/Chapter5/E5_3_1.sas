* E5_3_1.sas
*
* Looking at the meta data for an indexed table;

title1 '5.3.1 Meta Data for an Indexed Table';

* Index on subject;
* Using DATASETS;
proc datasets lib=advrpt;
   modify demog;
   index create subject;
   quit;

proc contents data=advrpt.demog;
   run;
