* E13_12.sas
*
* Macro quoting;
***********************************************;
%let list = butter, cheese, milk;
%put %left(&list);

%let list = %str(butter, cheese, milk);
%put %left(&list);

/* the first two titles do not work. */
/*title1 "13.12 %left(%sysfunc(date(),worddate18.))";*/
/*title1 "13.12 %qleft(%sysfunc(date(),worddate18.))";*/
title1 "13.12 %left(%qsysfunc(date(),worddate18.))";
proc print data=sashelp.class;
   run;

**********************************************************;
%let p = proc;
%let store= %nrstr(A&P. );



***************************************************;
%let p = proc;
%let store= %nrstr(  My favorite store is the A&P. );
%put |&store|;
%put %left(&store);
%put %qleft(&store);
