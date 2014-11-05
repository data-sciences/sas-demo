* S8_6_5a.sas
*
* In-line formatting and line wraps;

ods listing close;
ods html style=default
    file="&path\results\ch8_6_5a.html";
ods pdf style=printer
    file="&path\results\ch8_6_5a.pdf";
ods rtf style=rtf
    file="&path\results\ch8_6_5a.rtf"
    bodytitle;
ods escapechar = '~';

proc format;
   value $genttl
      'f','F'='Fe~mmale~-2nStudents'
      'm','M'='Ma~mle~-2nStudents';
   run;

title1 "Ages 11 - 16";
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group format=$genttl.;
   define height / analysis mean
                   format=5.2
                   'Height';
   define weight / analysis mean
                   format=6.2
                   'Weight';
   rbreak after  / summarize;

   compute after;
      line @1 'Eng~mlish Measures~-2nHeight(in.)~nWeight(lbs.)';
   endcomp;
   run;
ods _all_ close;
