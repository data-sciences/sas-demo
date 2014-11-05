* E1_1_1.sas
*
* Using engines;

* *********************************
* Using the EXCEL engine;
libname toxls excel "&path\data\newwb.xls";
title1 '1.1.1 Using Engines';

proc sort data=advrpt.demog
           out=toxls.demog;
   by clinnum;
   run;

data getdemog;
   set toxls.demog;
   run;

libname toxls clear;

