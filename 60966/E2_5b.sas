* E2_5b.sas
*
* Chapter 2 Exercise 5
*
* The presence of the usage type ORDER
* prevents the formation of groups.  Both
* CNT and AGE should have a usage of GROUP.;

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
define cnt / group;
define age / group;
define sex /across;
define height/analysis mean;
run;
