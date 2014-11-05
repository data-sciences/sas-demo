* E3_4_4a.sas
* 
* Using INTNX with intervals;

title1 '3.4.4a Collapsing Dates';

data hourly;
   set advrpt.mfgdata(keep=datetime);
   hourgrp = intnx('hour',datetime,0);
   halfhr  = intnx('hour',datetime,0,'m');
   twohr   = intnx('hour2',datetime,0);
   format hourgrp halfhr twohr datetime19.;
   run;

proc print data=hourly;*(obs=10);
   run;
