%macro obscnt(dsn);
%* count the number of observations in a sas data set;
%local nobs;
%let nobs=.;

%* Open the data set of interest;
%let dsnid = %sysfunc(open(&dsn));

%* If the open was successful get the;
%* number of observations and CLOSE &dsn;
%if &dsnid %then %do;
     %let nobs=%sysfunc(attrn(&dsnid,nlobs));
     %let rc  =%sysfunc(close(&dsnid));
%end;
%else %do;
     %put Unable to open &dsn - %sysfunc(sysmsg());
%end;

%* Return the number of observations;
&nobs
%mend obscnt;
