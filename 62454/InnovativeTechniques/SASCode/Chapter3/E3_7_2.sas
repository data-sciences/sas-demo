* E3_7_2.sas
* 
* Variables in Common;

title1 '3.7.2 Variables in Common';

proc sort data=advrpt.lab_chemistry(keep=subject labdt
                                    rename=(labdt=date))
          out=labchem nodupkey;
   by subject;
   run;
proc sort data=advrpt.ae(keep=subject aestdt
                         rename=(aestdt=date))
          out=ae nodupkey;
   by subject;
   run;

data aelab;
   merge labchem(where=(date<'01jul2003'd))
         ae;
   by subject;
   run;
proc print data=aelab;
   run;
