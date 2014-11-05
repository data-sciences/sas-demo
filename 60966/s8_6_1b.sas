* S8_6_1b.sas
*
* Using in-line formatting;

ods pdf file="&path\results\ch8_6_1b.pdf";
ods escapechar = '~';

proc format;
   value $mgen
      'M' = 'Male~{super 2}'
      'F' = 'Female~{super 1}';
   run;
title1 "Ages 11 - 16";
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group format=$mgen.;
   define height / analysis mean
                   format=5.2
                   'Height';
   define weight / analysis mean
                   format=6.2
                   'Weight';
   rbreak after  / summarize;

   compute after;
      line @3 '~{super 1} Girls Swim Team';
      line @3 '~{super 2} Boys Soccer Team';
   endcomp;
   run;
ods pdf close;
