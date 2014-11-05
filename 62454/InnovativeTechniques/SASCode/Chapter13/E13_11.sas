* E13_11.sas
* 
* Using the MFILE system option;

title '13.11 Using MFILE';
%Macro PRINTIT(dsn=,varlist= ,obs=);
proc print data=&dsn
   %if &obs ne %then (obs=&obs);;
   %if &varlist ne %then var &varlist;;
   run;
%mend printit;

options mprint mfile;
filename mprint "&path\sascode\Chapter13\E13_11_mfile.sas";
%printit(dsn=advrpt.demog,varlist=subject lname fname dob,obs=4)
