* E13_9_2.sas
*
* Hiding macro source code;

title '13.9.2 Forcing the Execution of Your Macro'; 

* Turn on stored compiled macro library;
options mstored
        sasmstore=advrpt;

%macro abc/store;
%PUT SECURE was not used for this definition.;
%mend abc;
%macro def/store secure;
%* Store macro using the secure option;
%PUT This is the OFFICIAL version of DEF!!;
%mend def;

********************************************************;
* Demonstrate use of NOMCOMPILE;
options nomcompile;

%* attempt to compile an autocall macro(%OBSCNT);
%* The macro compiles!!!; 
%put The obs count for DEMOG is %obscnt(advrpt.demog);

* Macro MYGHI does not compile; 
%macro myghi;
%put compile from within program;
%mend myghi;
%myghi

* Included macro definitions do not compile; 
%inc "&path\sascode\Chapter13\frominc13_9_2.sas";
%frominc13_9_2

* The macro is not stored or compiled; 
%macro storeghi / store;
%put macro was compiled and stored;
%mend storeghi;
%storeghi
* So that it will not interfer with the 
* following examples, clear the NOMCOMPILE;
options mcompile;

********************************************************;
* Demonstrate use of NOMREPLACE;
options mcompile nomreplace;

* Compile the autocall macro GHI;
* Definition is stored in WORK.SASMACR; 
* (entry GHI.MACRO does not already exist);
%ghi

* Unauthorized version of GHI
* does not replace version from the 
* autocall library;
%macro ghi;
%put Unauthorized version of GHI;
%mend ghi;
%ghi


********************************************************;
* Copy stored compiled library to WORK and 
* use NOMREPLACE.;
* The macro MUST be compiled and stored in a previous SAS session!!!;
%macro copysasmacr/store;
proc catalog catalog=advrpt.sasmacr;
   copy out=work.sasmacr;
   quit;
%mend copysasmacr;
%copysasmacr

options nomreplace;
%macro copysasmacr/store;
proc datasets nolist;
   copy in=advrpt 
        out=work
        mtype=cat;
      select sasmacr;
   quit;
%mend copysasmacr;
%copysasmacr

***********************************************;
** Purge the work catalog;
%macro purgework(macname=);
proc catalog cat=work.sasmacr 
             entrytype=macro;
   delete &macname;
   quit;
%mend purgework;
%purgework(macname=abc def ghi myghi)
*****************************************;
* Use VERCOPY to copy compiled macros to WORK;
%macro vercopy(verlist=)/store;
proc catalog c=complib.sasmacr 
             force 
             et=macro;  
    copy out=work.sasmacr ;
    select &verlist;
    quit;
%mend vercopy;
%macro bigstep;
   %vercopy(verlist=cleanup ghi)
   %cleanup  
   %* do other things;
   %ghi  
%mend bigstep;

