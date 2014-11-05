*E11_4_2.sas
*
* Establishing Hyperlinks;

title1  '11.4.2 LINK= Option';

ods pdf file="&path\results\E11_4_2.pdf" 
        style=journal;
title2 'Patient List Report';
title3 link='E11_4_1.htm' 'Symptom Report';
proc print data=advrpt.demog;
   var lname fname sex dob symp;
   run;
ods _all_ close;

