* E5_3_4.sas
*
* Using IDXWHERE;

title1 '5.3.4 Using IDXWHERE';

* Without IDXWHERE;
title2 'Without IDXWHERE';
proc print data=advrpt.conmed;
   where drug < 'C';
   var drug medspdt;
   run;

* Without IDXWHERE;
title2 'With IDXWHERE';
proc print data=advrpt.conmed(idxwhere=yes);
   where drug < 'C';
   var drug medspdt;
   run;
