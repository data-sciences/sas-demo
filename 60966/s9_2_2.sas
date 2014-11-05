* S9_2-2.sas
*
* Setting the margins;

ods listing close;
option leftmargin="5 in" topmargin="3 in";
ods pdf file="&path\results\ch9_2_2.pdf";
ods rtf file="&path\results\ch9_2_2.rtf"
        bodytitle;

title1 "Ages 11 - 16";
footnote1 'Height in Inches';
footnote2 'Weight in Pounds';

proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group;
   define height / analysis mean
                   format=5.2;
   define weight / analysis mean
                   format=6.2;
   rbreak after  / summarize suppress;
   run;
ods _all_ close;
