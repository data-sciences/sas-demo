*E13_8_3.sas
*
* Accessing meta-data to build a list of numeric variables;

* The ADVRPT library contains two password protected files:
*  advrpt.pword      read password is readpwd   see section 2.1.2
*  advrpt.passtab    read password is READPWD   see section 5.4.2
*;

title1 '13.8.3 Using Meta-Data';
%macro varlist(dsn=sashelp.class, type=1);
%* TYPE  1=numeric
%*       2=character;
%local varlist;
proc contents data=&dsn 
              out=cont(keep=name type 
                       where=(type=&type))
              noprint;
   run;
proc sql noprint;
   select name
      into :varlist separated by ' '
         from cont;
   quit;
   %put The list of type &type variables is: 
      &varlist;
%mend varlist;
%varlist(dsn=advrpt.demog,type=1)

proc contents data=advrpt._all_
              out=cont 
              noprint;
   run;


%macro makelist(dsn=sashelp.class, type=N);
%* TYPE  =  N for numeric
%*          C for character;
%local dsid i varlist rc;
%let dsid = %sysfunc(open(&dsn));
%do i = 1 %to %sysfunc(attrn(&dsid,nvar));
   %if %sysfunc(vartype(&dsid,&i))=%upcase(&type) %then %let varlist=&varlist %sysfunc(varname(&dsid,&i));
%end;
%let rc = %sysfunc(close(&dsid));
&varlist
%mend makelist;
%put Char vars are: %makelist(dsn=advrpt.demog,type=c);
