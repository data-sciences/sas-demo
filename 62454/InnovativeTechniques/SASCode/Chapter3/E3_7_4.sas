* E3_7_4.sas
* 
* Insufficient Key Values;

title1 '3.7.4 Fuzzy Merge for Numeric Values';

proc sort data=advrpt.lab_chemistry(keep=subject visit labdt)
          out=labchem;
   by subject;
   run;
proc sort data=advrpt.ae(keep=subject aestdt aedesc)
          out=ae;
   by subject;
   run;

* Fuzzy merge using SQL;
* Find all AE start dates that are within 5 days of the labdate;
proc sql noprint;
create table aelab as
   select a.subject,labdt, visit, aestdt, aedesc
      from labchem as L, ae as a
         where (l.subject=a.subject)
             & (labdt le aestdt le labdt+5)
            ;
quit;
proc print data=aelab;
   run;
