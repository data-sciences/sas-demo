data trees.splitexample;
set trees.bestrest;
numberof = numberof + 3;
distance = length_of_residence;
hour = income + 8;
run;
proc freq data=trees.splitexample;
tables hour;
run;
/*
attrib age format=8.;
set trees.shoplines;
age = (today() - Order_date)/10;
if age > 100 then age = age/10;

if numberofitems > 5 then age = age - 10;
if age < 0 then age = age/10 * -1;
if age > 50 then age = age - 30;
if age < 10 then age = age + 12;
run;
proc freq data=trees.shoplines;
tables age;
run;
