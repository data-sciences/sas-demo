* E8_5_3.sas
*
* Using PRINT to form a Table of Contents;

ods html style=journal
         path="&path\results"
         body="E8_5_3.html";

title1 '8.5.3 Clinics in the Study';

proc sort data=advrpt.clinicnames
          out=clinicnames;
   by clinname;
   run;
data clinlinks(keep=region clinnum clinic);
   set clinicnames;
   length clinic $70;
   clinic = catt("<a href='cn",
                 clinnum,
                 ".html'>",
                 clinname,
                 "</a>");
   run;

proc print data=clinlinks;
   var region clinnum clinic;
   run;
ods html close;

