* E1_3_3.sas
*
* INPUT statement modifiers;

* 1.3.3;
title '1.3.3a Delimited List Input Modifiers';
data base;
length lname $15;
*infile datalines dlm=','; /* Shows quotes are retained*/
infile datalines dlm=',' dsd;
input fname $ lname $ dob :mmddyy10.;
datalines;
'Sam','Johnson',12/15/1945 
'Susan','Mc Callister',10/10/1983 
run;
proc print data=base;
   format dob mmddyy10.;
   run;


title '1.3.3b Delimited List Input Modifiers';
title2 'Using the ~ Format Modifier';
data base;
length lname $15;
infile datalines dlm=',' dsd;
input fname $ lname $ birthloc $~15. dob :mmddyy10. ;
datalines;
'Sam','Johnson', 'Fresno, CA','12/15/1945' 
'Susan','Mc Callister','Seattle, WA',10/10/1983 
run;
proc print data=base;
   format dob mmddyy10.;
   run;

* 1.3.3c;
title '1.3.3c Delimited List Input Modifiers';
title2 'BIRTHLOC without a Format Modifier';
title3 'BIRTHLOC Length Specified';
data base;
length lname birthloc $15;
infile datalines dlm=',' dsd;
input fname $ lname $ birthloc $ dob :mmddyy10. ;
datalines;
'Sam','Johnson', 'Fresno, CA',12/15/1945 
'Susan','Mc Callister','Seattle, WA',10/10/1983 
run;
proc print data=base;
   format dob mmddyy10.;
   run;

*1_3_3d.sas;
title '1.3.3d Read delimited code with multiple delimiters';
data imports;
infile cards dlm='/,';
input id importcode $ value;
cards;
14,1,13
25/Q9,15
6,D/20
run;
proc print data=imports;
run;

*1_3_3e.sas;
title '1.3.3e Read delimited code with multiple delimiters';
title2 'Using a variable to specify the delimiter';
data imports;
retain dlmvar '/,';
infile cards dlm=dlmvar;
input id importcode $ value;
cards;
14,1,13
25/Q9,15
6,D/20
run;
proc print data=imports;
run;


*1_3_3f.sas;
title '1.3.3f Read delimited code with multiple delimiters';
title2 'Reading the delimiter during execution';
data imports;
infile cards;
input dlmvar $1. @;
infile cards dlm=dlmvar;
input @2 id importcode $ value;
cards;
,14,1,13
/25/Q9/15
~6~D~20
run;
proc print data=imports;
run;


*1_3_3g.sas;
title '1.3.3g Use a delimiter string';
data imports;
infile cards dlmstr=',,/';
input  id importcode $ value;
cards;
14,,/1/,,/13
25,,/Q9,,,/15
6,,/,D,,/20
run;
proc print data=imports;
run;
