* E2_7_1.sas
*
* Using operators just for the WHERE;

title1 '2.7.1 Operators Just for the WHERE';
title2 'BETWEEN';
proc print data=advrpt.demog;
   var lname fname edu;
   where edu between 15 and 17;
/*   where 15 le edu le 17;*/
   * Negations of the previous ranges;
/*   where edu not between 15 and 17;*/
/*   where edu lt 15 or edu gt 17;*/
   run;

****************************************************;
title2 'CONTAINS';
proc print data=advrpt.demog;
   var lname fname edu;
   where lname contains 'son';
/*   where lname ? 'son';*/
/*   where index(lname,'son');*/
   run;

****************************************************;
title2 'IS MISSING';
proc print data=advrpt.demog;
   var lname fname edu symp;
   where edu is missing or symp is missing;
/*   where edu is null or symp is null;*/
/*   where edu = . or symp = ' ';*/
   * The following is the oposite of the previous WHERE statements.;
/*   where edu is not missing or symp not is missing;*/
   run;

****************************************************;
title2 'LIKE';
proc print data=advrpt.demog;
   var lname fname edu symp;
/*   where lname like 'S%';*/
/*   where lname like '%ly%';*/
   where lname like 'Ch__';
   run;


****************************************************;
title2 'SAME and';
proc print data=advrpt.demog;
   var lname fname edu symp;
   where lname like 'S%';
   where same and edu le 15;
   run;

proc print data=advrpt.demog;
   var lname fname edu symp;
   where lname like 'S%';
   where same edu le 15;
   run;

****************************************************;
title2 'Sounds like';
proc print data=advrpt.demog;
   var lname fname dob;
   where lname =* 'che';
   run;

data _null_;
code1 = soundex('che');
code2 = soundex('xh');
put code1= code2=;
run;
