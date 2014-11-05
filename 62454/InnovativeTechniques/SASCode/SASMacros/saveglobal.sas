%macro SaveGlobal;
data advrpt.GlobalVars(keep=name value);
   set sashelp.vmacro(where=(scope='GLOBAL'));
   run;
%mend saveglobal;
