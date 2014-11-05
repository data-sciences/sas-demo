* S8_6_1a.sas
*
* Using in-line formatting;

ods pdf file="&path\results\ch8_6_1a.pdf";
ods escapechar = '~';

title1 "Ages 11 - 16";
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group;
   define height / analysis mean
                   format=5.2
                   'Height~{super 1}';
   define weight / analysis mean
                   format=6.2
                   'Weight~{super 2}';
   rbreak after  / summarize;

   compute after;
      line @3 '~{super 1} Mean height in inches.';
      line @3 '~{super 2} Mean weight in pounds.';
   endcomp;
   run;
ods pdf close;
