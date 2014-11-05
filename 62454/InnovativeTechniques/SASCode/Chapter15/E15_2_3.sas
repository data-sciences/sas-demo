* E15_2_3.sas
* 
* Interface with the macro language;

********************************************;
proc fcmp outlib=advrpt.functions.utilities;
subroutine prntcrit(dsn$,kvar $,cvar $);
   rc=run_macro('printit',dsn,kvar,cvar);
endsub;
run;
%macro printit();
%let dsn  = %sysfunc(dequote(&dsn));
%let kvar = %sysfunc(dequote(&kvar));
%let cvar = %sysfunc(dequote(&cvar));
title2 "&dsn";
proc print data=advrpt.&dsn;
%if &kvar ne %then id &kvar;;
%if &cvar ne %then var &cvar;;
run;
%mend printit;

options cmplib=(advrpt.functions);
title1 '15.2.3 Macro Language Interface';
data _null_;
   set advrpt.dsncontrol;
   call prntcrit(dsn,keyvars,critvars);
   put 'Print ' dsn keyvars critvars;
   run;
proc print data=advrpt.dsncontrol;
run;
