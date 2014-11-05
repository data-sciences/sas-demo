%macro ClearTEMPWORK;
%local rc;
%let rc=%sysfunc(fileexist("c:\tempwork"));
%if &rc ne 0 %then %do;
   %let rc=%sysfunc(libname(tempwork));
   %sysexec del /Q "c:\tempwork\*.*";
   %sysexec rd /Q "c:\tempwork";
%end;
%mend cleartempwork;
