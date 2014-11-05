/*============================================================
Macro: %vars_in(dsn, varlist)
Parameters:
	dsn = Data set name
	varlist = list of variable names
Action:
	Creates a GLOBAL macro variable &vars_in_dsn which contains
	a list of all variable names in &varlist which are also
	variables in dsn
Example:


%vars_in(JES.Results, Vendor Month Week Resistance)
%PUT vars_in_dsn = [&vars_in_dsn]; 
PROC PRINT DATA=JES.Results;
	VAR Vendor Month Week Resistance;
RUN;
PROC PRINT DATA=JES.Results;
	VAR &vars_in_dsn;
RUN;
===========================================================*/


%MACRO vars_in(dsn, varlist);
	%GLOBAL vars_in_dsn;
	%LOCAL dsid i ok var num rc;
	%LET dsid=%SYSFUNC(OPEN(&dsn, i));
	%LET vars_in_dsn = ;
	%LET i=1;
	%LET var=%SCAN(&varlist, &i);
	%DO %WHILE(&var ne );
		%IF %varexist(&dsn, &var)=1 
			%THEN %LET vars_in_dsn=&vars_in_dsn &var;
		%LET i=%EVAL(&i+1);
		%LET var=%SCAN(&varlist, &i);
	%END;
%MEND vars_in;



