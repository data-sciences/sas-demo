* E13_10.sas
*
* Using the Macro IN operator;

title '13.10 Using the IN Operator'; 

*********************************************************;
* 13.10.1 What can go wrong;
%macro BrokenIN;
* Broken in SAS9.0;
* Broken in SAS9.2 & 9.3 when MINOPERATOR is set;
%let state=in;
%if &state=CA %then %put California;
%else %put Not California;
%mend brokenin;
%brokenin

options minoperator;
%macro FixedIN;
%let state=in;
%if %bquote(&state)=CA %then %put California;
%else %put Not California;
%mend fixedin;
%fixedin

*********************************************************;
* 13.10.2 Using the MINOPERATOR;
option minoperator;
%macro BrokenIN;
%let state=in;
%if &state=CA %then %put California;
%else %put Not California;
%mend brokenin;
%brokenin

options nominoperator;
%macro testIN(dsn=demog)/minoperator;
%if %upcase(&dsn) # AE CONMED DEMOG LAB_CHEMISTRY %then %do;
   %put &dsn count %obscnt(advrpt.&dsn);
%end;
%mend testin;
%testin(dsn=ae)

*********************************************************;
* 13.10.3 Using the MINDELIMITER option;
%macro testIN(dsn=demog)/minoperator mindelimiter=',';
%if %upcase(&dsn) in(AE,CONMED,DEMOG,LAB_CHEMISTRY) %then %do;
   %put &dsn count %obscnt(advrpt.&dsn);
%end;
%mend testin;
%testin(dsn=demog)

*********************************************************;
* 13.10.4 Showing compile time issues;
options minoperator mindelimiter=',';
%macro testIN(dsn=demog);
%if %upcase(&dsn) in(AE,CONMED,DEMOG) %then %do;
   %put &dsn count %obscnt(advrpt.&dsn);
%end;
%else %PUT &DSN not on the list;
%mend testin;
%testin(dsn=conmed)
*******
* change in mindelimiter does not break the macro;
options minoperator mindelimiter=' ';
%testin(dsn=conmed)
*******
* turning off minoperator breaks the macro;
options nominoperator;
%testin(dsn=conmed)

*****
* Use options on the MACRO statement!!!;
%macro testIN(dsn=demog)/minoperator mindelimiter=',';
%if %upcase(&dsn) in(AE,CONMED,DEMOG) %then %do;
   %put &dsn count %obscnt(advrpt.&dsn);
%end;
%mend testin;
*** subsequent changes to the system options
*** have no affect;
options nominoperator mindelimiter=' ';
%testin(dsn=conmed)
