* S8_6_5c.sas
*
* Inserting Error text;

%let rc=2;
ods html style=default
    file="&path\results\ch8_6_5c.html";
ods pdf style=printer
    file="&path\results\ch8_6_5c.pdf";
ods rtf style=rtf
    file="&path\results\ch8_6_5c.rtf"
    bodytitle;
ods escapechar = '~';

title1 "Ages 11 - 16";
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
      line @1 "~&rc.z Return Code Status";
   endcomp;
   run;
ods _all_ close;
