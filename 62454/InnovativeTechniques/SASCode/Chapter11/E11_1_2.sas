* E11_1_2.sas
*
* Naming the OUTPUT data set;

ods listing close;
title1 '11.1.2a Naming the OUTPUT Data Set';
ods output extremeobs=maxmin;
proc univariate data=advrpt.demog;
   id lname fname;
   var ht wt;
   run;

ods listing;
proc print data=maxmin;
   run;

***********************************************;
title1 '11.1.2b CLASS Variable Present';
ods output extremeobs=maxclass(keep=sex varname high lname_high fname_high);
ods listing close;
proc univariate data=advrpt.demog;
   class sex;
   id lname fname;
   var ht wt;
   run;

ods listing;
proc print data=maxclass;
   run;

***********************************************;
title1 '11.1.2c Using the Object Label';
ods output 'extreme observations'=extobs;
/*ods output 'extreme observations'=extobs(keep=varname low lowobs lname_low fname_low);*/
ods listing close;
proc univariate data=advrpt.demog;
   id lname fname;
   var wt;
   run;

ods listing;
proc print data=extobs;
   run;

* show the documentation and options for this tagset;
ODS tagsets.excelxp file="&path\results\test.xml" 
                    options(doc="help");
