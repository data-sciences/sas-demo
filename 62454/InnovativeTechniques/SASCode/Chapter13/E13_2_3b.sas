* E13_2_3b.sas
* 
* Using SQL to build a list of macro variables;

title1 '13.2.3 Using SQL to Create a list of Macro Variables';

***********************************************;
* Create a list of variable names;

%macro Varlist(dsn=, type=num)/minoperator;
%local lib mem;

%* Determine the data set of interest;
%if %index(&dsn,.) %then %let lib = %scan(&dsn,1,.);
%else %let lib=work;
%let mem = %scan(&dsn,-1,.);

%* Determine data type;
%if %substr(&type,1,1) # $ C c %then %let type=char;
%else %if %substr(&type,1,1) # . N n %then %let type=num;
%else %let type =;

proc sql noprint;
select name 
   into :varname1 - :varname9999
      from sashelp.vcolumn
         where libname="%upcase(&lib)" 
             & memname="%upcase(&mem)" 
             %if &type ne %then & type="&type";;
%let varcnt = &sqlobs;
quit;

%do i = 1 %to &varcnt;
   %put &&varname&i;
%end;
%mend varlist;
%varlist(dsn=advrpt.demog, type=n)
%varlist(dsn=advrpt.demog, type=C)
%varlist(dsn=advrpt.demog, type=all)
