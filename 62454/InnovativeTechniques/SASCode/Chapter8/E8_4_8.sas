* E8_4_8.sas
*
* Dates within Dates;


title1 '8.4.8 Dates within Dates';
ods listing;

data visits;
   set advrpt.lab_chemistry(keep=visit labdt sodium);
   year=year(labdt);
   qtr = qtr(labdt);
   run;

title2 'Using Derived Variables';
proc report data=visits nowd;
   column visit year, qtr, sodium,n;
   define visit  / group'Visit';
   define year   / across format=4. ' ';
   define qtr    / across format=1. ' ';
   define sodium / display          ' ';
   define n      /        format=2. ' ';
   run;

***********************************************************;

ods pdf file="&path\results\E8_4_8.pdf" 
        style=journal;
title2 'Using the Original Date Variable';
proc report data=advrpt.lab_chemistry nowd;
   column visit ( 'Patient Counts Within Quarter' labdt=year, labdt,sodium,n);
   define visit  / group'Visit';
   define year   / across format=year. order=formatted ' ';
   define labdt  / across format=yyq6. order=internal ' ';
   define sodium / display ' ';
   define n      / ' ' format=2. nozero
                   style={just=center};
   run;
ods pdf close;



