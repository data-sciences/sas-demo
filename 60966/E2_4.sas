* E2_4.sas
*
* Chapter 2 Exercise 4
*
* Why does this step fail?;

title 'HEIGHT nested within SEX';
proc report data=sashelp.class nowd;
column  age sex,height;
define age / group;
define sex /across;
define height/display;
run;
