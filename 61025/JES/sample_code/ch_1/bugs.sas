
DATA New; SET Old; RUN;

%MACRO sas_bugs;
%DO n = 1 %TO 1000;
	%PUT n=&n;
	%IF &n=666 %THEN %DO; DATA new; SET old; RUN; %END;
%END;
%MEND sas_bugs; %sas_bugs

DATA a;
	X= "some text with unbalanced quotes'; OUTPUT a;
RUN;

*'; *"; RUN; %MEND;

DATA a;
	DO x=1 TO 100;
		x = 1/x; 
	END;
RUN;

