* E13.6.sas
*
* Meta Data Exceptions;

title '13.6 Meta data Exceptions';

* Hardcoded exception removal;
data conmed;
   set advrpt.conmed(where=(subject ne '202'));
   run;

**********************************************************;
* Code to a macro;
%macro exceptions;
where=(subject ne '202')
%mend exceptions;
data conmed;
   set advrpt.conmed(%exceptions);
   run;


*********************************************************
* Use meta-data to control the exceptions.;
data advrpt.DataExceptions;
   length dsn $12 exception $35;
   dsn='AE';     exception="(subject le '204')"; output;
   dsn='conmed'; exception="(subject ne '202')"; output;
   dsn='conmed'; exception="(subject ne '208')"; output;
   run;

%macro exceptions(dsn=ae);
   * Build exception list;
   proc sql noprint;
      select exception into :explist separated by '&'
         from advrpt.dataexceptions
            where upcase(dsn)=upcase("&dsn");
      quit;
   %if &explist ne %then %let explist=where=(&explist);
%mend exceptions;

%let explist = ;
%exceptions(dsn=ae)
%put &explist;
proc print data=advrpt.ae(&explist);
   run;

%let explist = ;
%exceptions(dsn=conmed)
%put &explist;
proc print data=advrpt.conmed(&explist);
   run;
