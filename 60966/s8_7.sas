* S8_7.sas
*
* TITLE and FOOTNOTE statement options;

proc format;
   value $genttl
      'f','F'='Female~nStudents'  
      'm','M'='Male~nStudents';
   run;

ods html style=default
         file="&path\results\ch8_7.html";

title1 f='times new roman' h=20pt c=blue bc=yellow 'Student Summary';
title2 f='Arial' h=20pt c=red j=l bold 'English Units';
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group format=$genttl.;
   define height / analysis mean
                   format=5.2
                   'Height';
   define weight / analysis mean
                   format=6.2
                   'Weight';
   rbreak after  / summarize suppress;
   run;
ods html close;  
