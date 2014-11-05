* E3_1_5.sas
* 
* Look-Ahead using a double SET;

title1 '3.1.5 Double SET Statement Look-Ahead';
proc sort data=advrpt.lab_chemistry(keep=subject visit labdt)
           out= labdates
           nodupkey;
   by subject labdt;
   run;

data nextvisit(keep=subject visit labdt days2nextvisit);
   set labdates(keep=subject visit labdt) 
       end=lastlab;
   if not lastlab then do;
      set labdates(firstobs=2
                   keep=subject labdt
                   rename=(subject=nextsubj labdt=nextdt));
      Days2NextVisit = ifn(subject=nextsubj,nextdt-labdt, ., .);
   end;
   run;
proc print data=nextvisit;
run;
