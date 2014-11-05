* E2_6_1.sas
*
* Using shorthand Lists;
title1 '2.6.1 Variable Shorthand Lists';
title2 'List of variables and their positions';
proc contents data=advrpt.demog varnum;
   run;

title2 'List of mixed types';
proc print data=advrpt.demog;
   var death -character- symp;
   run;

title2 'Using the Colon - Named Prefix Lists';
proc summary data=advrpt.demog;
   class race edu;
   var ht wt;
   output out=stats
          mean=
          stderr=
          min=/autoname;
   run;

proc print data=stats;
   id race edu;
   var ht_:;
   run;
*****************************;
* Remove labels;
data demog;
  set advrpt.demog;
  run;

proc contents data=demog;
run;

proc datasets lib=work nolist;
   modify demog;
      attrib _all_ label=' '
                   format=;
      contents;
   quit; 
proc contents data=demog;
run;
