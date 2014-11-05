

/*=====================================
Macro: %obscnt(dsn)
Source: Carpenter's Complete Guide, Second Edition, p. 320
Parameters: dsn = name of SAS data set
Example: 
	DATA A; DO i=1 TO 10; OUTPUT; END; RUN;
	%LET N=%obscnt(A);
	%PUT N=&N;
	%LET M=%obscnt(No_Such_Data_Set);
	%PUT M=&M;

%PUT The number of rows in JES.Vendor_List is %obscnt(JES.Vendor_List);
%MACRO Test;
	%IF %obscnt(JES.Vendor_List)=0 %THEN %GOTO DONE;
	%DO i=1 %TO %obscnt(JES.Vendor_List);
		%PUT &i;
	%END;	
%DONE: ;
%MEND Test;
%Test
*/

%MACRO obscnt(dsn);
	%LOCAL nobs;
	%LET nobs=.;
	%IF %SYSFUNC(EXIST(&dsn)) %THEN %DO;
		%LET dsnid=%SYSFUNC(OPEN(&dsn));
		%IF &dsnid %THEN %DO;
			%LET nobs=%SYSFUNC(ATTRN(&dsnid, nlobs));
    		%LET rc  =%SYSFUNC(CLOSE(&dsnid));
		%END;
		%ELSE %DO;
    		%PUT Unable to open &dsn - %SYSFUNC(SYSMSG());
		%END;
	%END;
    %ELSE %DO;
		%LET NOBS=0;
	%END; 
	&nobs
%MEND obscnt;




