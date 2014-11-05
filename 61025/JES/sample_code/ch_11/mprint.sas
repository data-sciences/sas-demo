

%MACRO Report5(Year);
  %DO N = 1 %TO 3 %BY 1;
	PROC SQL NOPRINT;
		SELECT Vendor into :Vendor
		FROM JES.Vendor_List
		WHERE N=&N;
	QUIT;
	%LET Vendor=%TRIM(&Vendor);
	DATA Temp; SET JES.Rates_&Year;
		IF Vendor="&Vendor";
	RUN;
	PROC SQL NOPRINT;
		SELECT COUNT(*) INTO :Num FROM Temp;
	QUIT;  
	TITLE1 "Defect Rate Report for &Year at &Vendor";
	%IF &Num>0 %THEN %DO;
		PROC PRINT DATA=Temp NOOBS LABEL; 
			VAR Qtr N_Test Defects Defect_Rate;
	  	RUN;
	%END; /* Ends the %IF ... %THEN; DO; */	
	%ELSE %DO; 
		DATA Temp; Message= "No Data for &Year at &Vendor"; RUN;
		PROC PRINT DATA=Temp NOOBS; RUN;
	%END; /* Ends the %ELSE; DO; */	
  %END; /* Ends the  %DO N = 1 %TO 3 loop */
%MEND Report5; 

%INCLUDE "&JES.utility_macros/delvars.sas";
%delvars
OPTIONS MPRINT MLOGIC SYMBOLGEN; 
%Report5(2009)
OPTIONS NOMPRINT NOMLOGIC NOSYMBOLGEN;
