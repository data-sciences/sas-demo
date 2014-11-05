* E2_2_2.sas
*
* Colon Comparison Operator Modifier;

title1 '2.2.2';
* Retrieve last names that start with Mar;
title2 'Last Names beginning with "Mar"';
data Mar;
   set advrpt.demog (keep=lname fname);
   if lname =: 'Mar';
   run;
proc print data=mar; 
   run;

title2 'Using : with the IN operator';
proc print data=advrpt.demog;
   var subject lname fname;
   where lname in:('Me', 'Mar', 'Adam');
   run;

* Check for shorter names;
Title2 'The importance of TRIM';
* What is returned when LNAME = 'Adams'?;
proc print data=advrpt.demog;
   var subject lname fname;
   *where lname =: 'Adamso';
   where 'Adamso'=: trim(lname);
   run;

***************************************;
* Similar functionality in SQL;
proc sql;
   title2 'Used in SQL data set WHERE=';
   select lname, fname, dob
      from advrpt.demog(where=(lname=:'Adams'));

   /* this use of =: causes the step to terminate with errors */
   title2 'Used in SQL WHERE Clause';
   select lname, fname, dob
      from advrpt.demog
         where lname=:'Adams';
   quit;
proc sql;
   title2 'Using the EQT operator';
   select lname, fname, dob
      from advrpt.demog
         where lname eqt 'Adams';
   quit;
