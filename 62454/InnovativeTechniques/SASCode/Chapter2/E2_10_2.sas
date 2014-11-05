* E2_10_2.sas
*
* Using the MISSING System option;

title '2.10.2 Using the MISSING System Option';
* Reading missing values;
data showmiss;
input name $ age;
datalines;
Fred 15
Sally .f
Joe .
run;
title2 Without MISSING;
options missing=.;
proc print data=showmiss;
run;
options missing=X;
title2 'MISSING Text is: X';
proc print data=showmiss;
*where age=.;
run;
