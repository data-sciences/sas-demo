* S8_6_3.sas
*
* Generating a dagger symbol;

ods html file="&path\results\ch8_6_3.html";
ods pdf  file="&path\results\ch8_6_3.pdf";
ods rtf  file="&path\results\ch8_6_3.rtf"
         style=rtf 
         bodytitle;
ods escapechar = '~';

title1 "Ages 11 - 16 ~{dagger}";
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group;
   define height / analysis mean
                   format=5.2
                   'Height';
   define weight / analysis mean
                   format=6.2
                   'Weight';
   rbreak after  / summarize;

   compute after;
      line @3 '~{dagger} Data extracted from the ABC study';
   endcomp;
   run;
ods _all_ close;
