* E2_2_4.sas
*
* Compound inequalities;

title1 '2.2.4';
* Assign analysis values using IF-THEN/ELSE;
title2 'Compound Inequalities';
data college;
   set advrpt.demog (keep=lname fname edu);
   if 13 le edu le 16 ;
   run;
proc print data=college; 
   run;

title2 'Misplaced Parens';
proc print data=advrpt.demog (keep=lname fname edu);; 
   where (13 le edu) le 16 ;
   run;

%* Macro compound inequalities;
%macro silly;
%let x = 5;
%let y = 4;
%let z = 3;
%if &x lt &y lt &z %then %put &x < &y < &z;
%mend silly;
%silly

