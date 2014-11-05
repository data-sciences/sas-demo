%macro GetGlobal;
data _null_;
   set advrpt.globalvars(where=(name ne 'PATH'));
   call symput(name,value);
   run;
%mend getGlobal;
