* E14_1_1.sas
*
* Data processing System Options;
title1 '14.1.1 System Options';

* These options must be specified at session initialization
*    -initstmt='%getglobal' -termstmt='%saveglobal'
*;


%let curr_dt = %qsysfunc(datetime(),datetime18.);
%put &curr_dt;
***************************
* These two macros have been added  
* to the autocall library;
***************************
* Save Global Macro Variables;
%macro SaveGlobal;
data advrpt.GlobalVars(keep=name value);
   set sashelp.vmacro(where=(scope='GLOBAL'));
   run;
%mend saveglobal;

****************************
* Retrieve global macro variables;
%macro GetGlobal;
data _null_;
   set advrpt.globalvars(where=(name ne 'PATH'));
   call symputx(name,value,'g');
   run;
%mend getGlobal;
