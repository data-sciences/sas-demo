* E2_1.sas
* 
* Using Data set options;

title1 '2.1. Using Data Set Options';
proc sort data=advrpt.demog(keep= lname fname ssn)
               out=namesonly;
by lname fname;
run;

***************************************************;
data year2007 year2006;
   set advrpt.lab_chemistry;
   if year(labdt)=2007 then output year2007;
   else if year(labdt)=2006 then output year2006;
   run;

data yr6_7;
   set year2006 year2007(keep=subject visit labdt);
   run;
data yr6_7;
   set year:(keep=subject visit labdt);
   run;
