* E3_2.sas
* 
* Calculating age;

title1 '3.2 Calculating Age';
ods listing;
data Age;
   set advrpt.demog(keep=dob death);
   where death ne .;
   age1 = (death-dob)/365.25;
   age2 = (death - dob) / 365;
   age3 = year(death) - year(dob);
   age4 = year(death-dob) - 1960;
   age5 = intck('year',dob,death);
   age5c = intck('year',dob,death,'c');
   age5d = intck('year',dob,death,'d');
   age6 = yrdif(dob,death,'actual');
   age6a = yrdif(dob,death,'age');
   age7 = floor(( intck( 'month', dob, death) - ( day(death) < day(dob)))/ 12);
   run;

proc print data=age noobs;
   run;

**********************************
* compare the AGE option on YRDIF;
data dates;
   start = '07jan2000'd; end = '07jan2001'd; output;
   start = '07jan2011'd; end = '07jan2012'd; output;
   start = '01jan2011'd; end = '01jan2012'd; output;
   start = '01jan2011'd; end = '01jan2013'd; output;
   start = '01jan2012'd; end = '01jan2013'd; output;
   start = '01jan2009'd; end = '01jan2013'd; output;
   start = '01jan1950'd; end = '01jan2013'd; output;
   format start end date9.;
   run;
data ages;
   set dates;
   age1 = (end-start)/365.25;
   age6 = yrdif(start,end,'actual');
   age6age = yrdif(start,end,'age');
   run;
title2 'Comparing the three best continuous values';
proc print data=ages;
format age1 age6 age6age best12.8;
   run;
