* E2_2_3.sas
*
* Boolean and comparison operators in an assignment statement;

title1 '2.2.3';
* Assign analysis values using IF-THEN/ELSE;
title2 'IF-THEN/ELSE';
data values;
   set advrpt.demog (keep=lname fname dob sex);
   if sex = 'M' and year(dob) >  1949 then group=1;
   else if sex = 'M' and year(dob) le  1949 then group=2; 
   else if sex = 'F' and year(dob) >  1949 then group=3;
   else if sex = 'F' and year(dob) le  1949 then group=4; 
   run;
proc print data=values; 
   run;

* Assign analysis values using an assignment statement;
title2 'Building Flags';
data flags;
   set advrpt.demog (keep=lname fname dob sex);
   if year(dob) >  1949 then boomer=1; else boomer=0;
   boomer2 = year(dob) >  1949;
   boomer3 = ifn(year(dob) >  1949, 1, 0);
   run;
proc print data=flags; 
   run;

**************************************************
* Determine if an item is in a list of values;
data _null_;
input x1-x4;
array a {*} x1-x4;
flag1 = (3 in a);
flag2 = ^^whichn(3,of x:);
put flag1= flag2=;
datalines;
1 2 3 4
5 6 7 8
run;
