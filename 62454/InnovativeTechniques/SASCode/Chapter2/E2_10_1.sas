* E2_10_1.sas
*
* Missing Numeric values.;

title '2.10.1 Missing Numerics';
* Reading missing values;
data ages;
input name $ age;
if age=.y then note='Too Young';
else if age=.f then note='Refused';
datalines;
Fred 15
Sally .f
Joe .y
run;
proc print data=ages;
run;
**************************;
* Using the MISSING statement;
data ages;
missing f y;
input name $ age;
if age=.y then note='Too Young';
else if age=.f then note='Refused';
datalines;
Fred 15
Sally f
Joe y
run;
proc print data=ages;
run;



**********************;
* Show order of numeric missings;
data missorder;
   do x = ., ._, .a, .b, .x, .y, .z;
      output missorder;
   end;
   run;
proc sort data=missorder;
by x;
run;
proc print data=missorder;
run;
