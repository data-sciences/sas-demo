* E2_2_5.sas
*
* the MIN and MAX operators;
title1 '2.2.5';
title2 'MIN and MAX';
* following expression is true;
data _null_;
if -2 = (-5 min 2) then put 'true';
run;
* Not true in a WHERE;
proc print data=advrpt.demog;
   var lname fname edu symp;
   where -2 = (-5 min 2);
   run;
* True in a WHERE;
proc print data=advrpt.demog;
   var lname fname edu symp;
   where -5 = (-5 min 2);
   run;

* True in a WHERE;
proc print data=advrpt.demog;
   var lname fname edu symp;
   where 1 = (5<>6);
   run;
