* E12_5_3.sas
* 
* Using Nested Formats;

title1 '12.5.3 Importing Missing numeric codes';
*********************************************;
* 12.5.3
* Importing Missing numeric codes;
proc format;
invalue inage
y, yz = .y
s, ss = .s
other = [2.];
run;
data surveyAge;
input patcode $ age inage.;
datalines;
1 45
2 yz
3 36
4 ss
5 y
run;

proc print data=surveyage;
   run;
