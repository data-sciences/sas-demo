* E2_5_4.sas
* 
* Using a CLASSDATA data set to Sparse a Table;

title1 '2.5.4 Using CLASSDATA';
title2 'MEANS / SUMMARY';

ods pdf file="&path\results\E2_5_4.pdf";
proc sort data=advrpt.demog(keep=subject)
   out=subjects nodupkey;
   by subject;
   run;

data Visits(keep=subject visit);
   set subjects(rename=(subject=nsub));
   subject=put(nsub,3.);
   do visit = 1 to 16;
      output visits;
   end;
   run;
proc means data=advrpt.lab_chemistry
           classdata=visits
           noprint nway exclusive;
   class subject visit;
   var sodium potassium chloride;
   output out=allvisits sum=;
   run;

proc print data=allvisits(where=(subject='210'));
run;
ods pdf close;
