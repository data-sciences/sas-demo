%macro MakeTEMPWORK;
%local rc;
%let rc=%sysfunc(fileexist("c:\tempwork"));
%if &rc=0 %then %do;
   %sysexec md "c:\tempwork";
   %let rc=%sysfunc(libname(tempwork,c:\tempwork));
%end;
%mend maketempwork;
