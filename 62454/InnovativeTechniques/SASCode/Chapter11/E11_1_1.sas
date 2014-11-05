* E11_1_1.sas
*
* Using the ODS TRACE statement;

title1 '11.1.1 Using ODS TRACE';
ods trace on;

proc univariate data=advrpt.demog;
   var ht wt;
   run;

ods trace off;
