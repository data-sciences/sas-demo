* E13_4_3.sas
* Stored Compiled Macro Library review;

* Specify the stored compiled macro library;
libname complib "&path\sascode\storedmacros";
options mstored
        sasmstore=complib;

%macro def / store;
   %put Stored compiled Version of DEF;
%mend def;

