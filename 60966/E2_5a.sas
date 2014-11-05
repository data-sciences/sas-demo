* E2_5a.sas
*
* Chapter 2 Exercise 5
*
* Create a counter for each age group.  
* Why does the following fail.  Can you fix the problem?;

proc sort data=sashelp.class out=cl1;
by age;
run;

data class;
set cl1;
by age;
if first.age then cnt+1;
run;

title 'Count the Age Groups';
proc report data=class nowd;
column  cnt age sex,height;
define cnt / order;
define age / group;
define sex /across;
define height/analysis mean;
run;
