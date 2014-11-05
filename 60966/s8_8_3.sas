* S8_8_3.sas
*
* Using escape sequence to specify tip text;

ods listing close;
ods html style=default
    path="&path\results"
    body="ch8_8_3.html";
ods pdf style=printer
    file="&path\results\ch8_8_3.pdf";

ods escapechar=~;

title1 "Ages 11 - 16";
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group;
   define height / analysis mean
                   format=5.2
                   '~S={flyover="Measured in Inches"
                        htmlstyle="cursor:hand"}Height';
   define weight / analysis mean
                   format=6.2
                   '~S={flyover="Measured in Pounds"
                        htmlstyle="cursor:hand"}Weight';
   rbreak after  / summarize;
   run;
ods _all_ close;

