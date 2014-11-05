* E3_7_3.sas
* 
* Repeating BY Variables;

title1 '3.7.3 Repeating BY Variables';

proc sort data=advrpt.lab_chemistry(keep=subject visit labdt)
          out=labchem;
   by subject;
   run;
proc sort data=advrpt.ae(keep=subject aestdt aedesc
                         rename=(aestdt=labdt))
          out=ae;
   by subject;
   run;

data aelab;
   merge labchem
         ae;
   by subject;
   run;
proc print data=aelab(where=(subject='200'));
   run;
