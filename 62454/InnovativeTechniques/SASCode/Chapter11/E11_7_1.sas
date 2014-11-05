* E11_7_1.sas
*
* Using the ASIS option;
ods html style=default path="&path\results"
         body='E11_7_1.html';

title1 '11.7.1 Using ASIS';
title2 'Without ASIS';
proc print data=advrpt.demog(obs=5);
   id lname;
   var fname ht wt;
   format wt 8.1;
run;

title2 'With ASIS';
proc print data=advrpt.demog(obs=5);
   id lname;
   var fname ht; 
   var wt /style(data)={asis=yes}
           style(header)={just=c};
   format wt 8.1;
run;
ods html close;

