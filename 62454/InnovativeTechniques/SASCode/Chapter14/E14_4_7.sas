*E14_4_7.sas
*
* Executing a macro from the KEYS;
* This macro will establish a directory,
* if it does not exist, and assign
* a libref (TEMPWORK);

* These macros have already been added to the autocall library;
title1 '14.4.7 Creating and Removing a temorary work space';
%macro MakeTEMPWORK;
%local rc;
%let rc=%sysfunc(fileexist("c:\tempwork"));
%if &rc=0 %then %do;
   %sysexec md "c:\tempwork";
   %let rc=%sysfunc(libname(tempwork,c:\tempwork));
%end;
%mend maketempwork;

%macro ClearTEMPWORK;
%local rc;
%let rc=%sysfunc(fileexist("c:\tempwork"));
%if &rc ne 0 %then %do;
   %let rc=%sysfunc(libname(tempwork));
   %sysexec del /Q "c:\tempwork\*.*";
   %sysexec rd /Q "c:\tempwork";
%end;
%mend cleartempwork;

options noxwait;
%maketempwork
data tempwork.demog; set sashelp.class; run;
proc print data=tempwork.demog;
run;
%cleartempwork

