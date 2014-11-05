*E5_6_1.sas
*
* Renaming SAS data sets;

* create data sets to rename;
data  male 
      female 
      allgender(alter=pharmer);
   set sashelp.class;
   output allgender;
   if sex='M' then output male;
   else output female;
   run;

***********************************
title1 '5.6.1 Using the RENAME Function';
%let rc=%sysfunc(rename(work.male,Males,data));
%put &RC; 

* Using RENAME in a DATA step;
filename pwfile "&path\results\pwfile.txt";
proc pwencode in='pharmer' out=pwfile;
  run;

/* the encoded password becomes
{sas002}81F6943F251507393B969C0753B2D73B 
*/


data _null_;
length tmp $100;
infile pwfile truncover;
input tmp;
put tmp=;
*rc=rename('work.allgender','fullclass','data',,tmp); /* this should work but does not */
*rc=rename('work.allgender','fullclass','data',,'{sas002}81F6943F251507393B969C0753B2D73B');
rc=rename('work.allgender','fullclass','data',,"pharmer"); /* This works - documentation is wrong*/
txt=sysmsg();
put rc= txt=;
run;

