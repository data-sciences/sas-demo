* E1_3_2.sas
*
* INPUT statement informat modifiers;

title '1.3.2a List Input Modifiers';
data base;
length lname $15;
*input fname $ dob mmddyy10. lname $ ;
*input fname $ dob :mmddyy10. lname $ ;
input fname $ dob :mmddyy10. lname $ &;
datalines;
Sam 12/15/1945 Johnson
Susan   10/10/1983 Mc Callister
run;
proc print data=base;
   format dob mmddyy10.;
   run;

title '1.3.2b List Input Modifiers';
data base;
length lname $15;
input fname $ dob :mmddyy10. lname $ &;
format dob mmddyy10.;
datalines;
Sam 12/15/1945 Johnson   Seattle
Susan   10/10/1983 Mc Callister New York
;
run;
proc print data=base;
   run;
