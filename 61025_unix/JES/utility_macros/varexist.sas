/*============================================================
Macro: %varexist(dsn, varlist)
Source: Carpenter's Complete Guide to the SAS Macro Language, 
		Second Edition, p. 313.
Parameters:
	dsn = Data set name
	varlist = list of variable names
Action:
	Returns 1 if all names in varlist are variables in dsn
	Returns 0 otherwise
Example:
%PUT %varexist(JES.Results, Vendor Month Resistance);
%PUT %varexist(JES.Results, Vendor Week Resistance); 
===========================================================*/


%MACRO varexist(dsn, varlist);
	%LOCAL dsid i ok var num rc;
	%LET dsid=%SYSFUNC(OPEN(&dsn, i));
	%LET i=1;
	%LET ok=1;
	%LET var=%SCAN(&varlist, &i);
	%DO %WHILE(&var ne );
		%LET num=%SYSFUNC(VARNUM(&dsid, &var));
		%IF &num=0 %THEN %LET ok=0;
		%LET i=%EVAL(&i+1);
		%LET var=%SCAN(&varlist,&i);
	%END;
	%LET rc=%SYSFUNC(CLOSE(&dsid));
	&ok
%MEND varexist;



