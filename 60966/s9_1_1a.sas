* S9_1_1a.sas
*
* Using the BODYTITLE option;

ods listing close;

ods rtf file="&path\results\ch9_1_1a.rtf";

title1 "Ages 11 - 16";
title2 'Without BODYTITLE';
footnote1 'Height in Inches';
footnote2 'Weight in Pounds';
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group;
   define height / analysis mean
                   format=5.2;
   define weight / analysis mean
                   format=6.2;
   rbreak after  / summarize;
   run;
ods rtf close;
