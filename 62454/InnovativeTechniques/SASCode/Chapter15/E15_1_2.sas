*E15_1_2.sas
*
* Inserting BY values in titles;

title '15.1.2 BY Values in Titles';
proc sort data=advrpt.demog
          out=demog;
   by race sex;
   run;

ods pdf file="&path\results\E15_1_2.pdf" 
        style=journal2;
options nobyline;
title2 'Summary for #byvar1 #byval1';
/*title2 'Summary for #byvar(race) #byval(race)';*/
proc freq data=demog;
   by race;
   table sex;
   run;

*** CAVEAT
* Multiple groups per page;
option byline;
title2 'BY Information #byline';
proc print data=demog;
   by race sex;
   var lname fname dob;
   run;
ods pdf close;


