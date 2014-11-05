* E3_1_3b.sas
* 
* Using the LAG function to 'remember' values.
* Calculate the interval using the DIF function.;

title1 '3.1.3 Using the LAG and DIF Functions';
proc sort data=advrpt.lab_chemistry(keep=subject visit labdt)
           out= labdates
           nodupkey;
   by subject labdt;
   run;

data labvisits(keep=subject visit lagvisit interval lagdate labdt);
   set labdates;
   by subject;

   lagvisit= lag(visit);
   lagdate = lag(labdt);
   interval= dif(labdt);

   if not first.subject then do;
      if interval ne . then output;
   end;
   format lagdate mmddyy10.;
   run;

proc print data=labvisits;
   by subject;
   id subject;
   var lagvisit visit lagdate labdt interval;
   run;
