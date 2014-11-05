* E3_4_4c.sas
* 
* Using INTNX with intervals;

title1 '3.4.4c Building a Date Interval';

%let date=12jun2007;
* select all dates within the same month as &date;
data june07;
set advrpt.lab_chemistry;
if intnx('month',labdt,0) le "&date"d le intnx('month',labdt,0,'end');
run;

title2 'June 2007 lab dates';
proc print data=june07;
   var subject visit labdt;
run;
