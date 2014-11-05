* E13_5_2.sas
*
* Using meta-data to drive data validation checks;

title1 "13.5.2 Meta-data Driven Field Checks";

* Create some sample field checks;
data advrpt.fldchk;
infile datalines truncover;
length dsn $15 var $10 chkrating chktype $10 chktext $25;
INPUT @1 DSN $
      @15 VAR 
      @25 chkrating $
      @27 CHKTYPE $
      @36 CHKTEXT $
      ;
datalines;
demog         subject   1 notmiss
demog         RACE      2 list     ('1','2','3','4','5','6')
conmed        medstdt_  4 datefmt  mmddyy10.
lab_chemistry potassium 2 maximum  6.7
run;
proc print data=advrpt.fldchk;
run;

%macro errrpt(dsn=, keyvars=subject);
%local i;
data _null_;
   set advrpt.fldchk(where=(upcase(dsn)=upcase("&dsn")));
   fldcnt+1;
   cnt = left(put(fldcnt,6.));
   call symputx('errdsn'||cnt,dsn,'l');
   call symputx('errvar'||cnt,var,'l');
   call symputx('errrating'||cnt,chkrating,'l');
   call symputx('errtype'||cnt,chktype,'l');
   call symputx('errtext'||cnt,chktext,'l');
   call symputx('chkcnt',cnt,'l');
   run;   
data errrpt&dsn
          (keep=dsn 
                 &keyvars
                 errvar errval errtxt errrating);
   length dsn        $25
          errvar     $15
          errval     $25
          errtxt     $25
          errrating  8;

set advrpt.&dsn;

%do i = 1 %to &chkcnt;
   %* Write as many error checks as are needed;
   if
      %* Determine the error expression;
      %if %upcase(&&errtype&i)       = NOTMISS  %then missing(&&errvar&i);
      %else %if %upcase(&&errtype&i) = LIST     %then &&errvar&i not in(&&errtext&i);
      %else %if %upcase(&&errtype&i) = DATEFMT  %then input(&&errvar&i,&&errtext&i) eq .;
      %else %if %upcase(&&errtype&i) = MAXIMUM  %then &&errvar&i gt &&errtext&i;
   then do;
      dsn = "&dsn";
      errvar = "&&errvar&i";
      errval = &&errvar&i;
      errtxt = "&&errtext&i";
      errrating= &&errrating&i;
      output errrpt&dsn;
      end;
   %end;
   run;

title2 "Data Errors for the &dsn data set";
proc print data=errrpt&dsn;
   run;
%mend errrpt;

%macro dataval;
%local i;
* Determine list of data sets to check;
data _null_;
   set advrpt.dsncontrol;
   cnt = left(put(_n_,5.));
   call symputx('dsn'||cnt,dsn,'l');
   call symputx('keyvars'||cnt,keyvars,'l');
   call symputx('dsncnt',cnt,'l');
   run;

%* Perform data validation checks on each data set;
%do i = 1 %to &dsncnt;
   %errrpt(dsn=&&dsn&i, keyvars=&&keyvars&i)
%end;
%mend dataval;

/*filename mprint 'c:\temp\errrpt.sas';*/
/*options mprint mfile;*/
%dataval

************************************************
** Alternate forms of the DATAVAL macro********;

* Use SQL to build the lists;
%macro dataval2;
%local i;
* Determine list of data sets to check;
proc sql noprint;
   select dsn,keyvars
      into :dsn1-:dsn999,
           :keyvars1-:keyvars999
      from advrpt.dsncontrol;
   %let dsncnt=&sqlobs;
   quit;

%* Perform data validation checks on each data set;
%do i = 1 %to &dsncnt;
   %errrpt(dsn=&&dsn&i, keyvars=&&keyvars&i)
%end;
%mend dataval2;
%dataval2

*****************************************************
* Use CALL EXECUTE and avoid making the lists;
%macro dataval3;
* Determine list of data sets to check;
data _null_;                                                                                                                            
   set advrpt.dsncontrol;                                                                                                               
   call execute('%nrstr(%errrpt(dsn='||dsn||', keyvars='||keyvars||'))');                                                                         
run;   
%mend dataval3;
%dataval3
