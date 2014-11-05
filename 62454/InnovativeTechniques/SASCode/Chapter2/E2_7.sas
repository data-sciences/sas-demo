*E2_7.sas
*
* Using WHERE;

title1 'E2.7a WHERE Statement';
proc print data=advrpt.demog;
   var lname fname sex dob;
   where year(dob)>1960;
   run;

title1 'E2.7b WHERE Data Set Option';
proc print data=advrpt.demog(where=(year(dob)>1960));
   var lname fname sex dob;
   run;
