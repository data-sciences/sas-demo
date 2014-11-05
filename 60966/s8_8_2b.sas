* S8_8_2b.sas
*
* Demonstrate header tip text;

ods listing close;
ods html style=default
    path="&path\results"
    body="ch8_8_2b.html";
ods pdf style=printer
    file="&path\results\ch8_8_2b.pdf";

title1 "Ages 11 - 16";
proc report data=sashelp.class nowd;
   columns sex height weight;
   define sex    / group;
   define height / analysis mean
                   format=5.2
                   'Height' 
                   style(header)={flyover='Measured in Inches'};
   define weight / analysis mean
                   format=6.2
                   'Weight'
                   style(header)={flyover='Measured in Pounds'};
   rbreak after  / summarize;
   run;
ods _all_ close;

