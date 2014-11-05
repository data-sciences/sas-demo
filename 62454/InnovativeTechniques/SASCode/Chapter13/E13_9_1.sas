* E13_9_1.sas
*
* Hiding macro source code;

title '13.9.1 Hiding Macro Source Code'; 

* Turn on stored compiled macro library;
options mstored
        sasmstore=advrpt;

%macro abc/store source;
%PUT SECURE was not used for this definition.;
%mend abc;
* Write compiled version of the ABC macro;
filename maccat catalog 'advrpt.sasmacr.abc.macro';
data _null_;
   infile maccat;
   input;
   list;
   run;

%macro def/store secure;
%* Store macro using the secure option;
%PUT This is the OFFICIAL version of DEF!!;
%mend def;
* Write compiled version of the secure DEF macro;
filename maccat catalog 'advrpt.sasmacr.def.macro';
data _null_;
   infile maccat;
   input;
   list;
   run;

options mprint symbolgen mlogic;
%macro dtest/secure;
proc print data=sashelp.class;
   run;
%mend dtest;
%dtest
