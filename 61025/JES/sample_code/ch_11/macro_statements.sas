

/* Delete all data sets in the WORK library  */
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;


/*===== Add a DO Loop =====*/
%MACRO Report4(Year);
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
	TITLE1 "Defect Rate Report for &Year at &Vendor";
	PROC PRINT DATA=Temp NOOBS LABEL; 
		VAR Qtr N_Test Defects Defect_Rate;
	RUN;
%END; /* Completes %DO N = 1 %TO ...; code block */
%MEND Report4;  
%Report4(2006) 
%Report4(2008)





/*=== Logical Expressions ===*/

/*=== Re-Create the Macro Variables====*/
DATA Tab;  FORMAT Test_Date DATE9.;
	DO n=1 TO 90 BY 30; 
		Vendor="Duality Logic";
		Test_Date='05JUN2008'd+n; 
		Num_Test=1000; 
		Num_Fail=ROUND(Num_Test*RANUNI(12345)/50); 
		Rate=Num_Fail/Num_Test;
		OUTPUT; 
	END;
	DROP N;
RUN;

PROC SQL NOPRINT;
	SELECT Vendor, Num_Test, Rate, Test_Date INTO :Vend, :NTest, :Rate, :Test_Date
	FROM Tab
	WHERE Test_Date='06JUL2008'd;
QUIT;

%PUT Vend=[&Vend] NTest=[&NTest] Rate=[&Rate] Test_Date=[&Test_Date];

%PUT %EVAL(&Vend=Duality);
%PUT %EVAL(&Ntest > 50 OR &Vend=Duality);
%PUT %EVAL(&Vend EQ Duality Logic);
%PUT %EVAL(%UPCASE(&Vend) = DUALITY LOGIC);
%PUT %EVAL(&NTest > 50 AND NOT &NTest=1000);
%PUT %EVAL(1 > 9);
%PUT %EVAL(0.1 > .9);
%PUT %SYSEVALF(0.1 > .9);
%PUT %EVAL(2+2);




/*==== Add IF ... THEN ... ELSE =====*/
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
%Report5(2008)
%Report5(2009)



/*==== Add a GOTO =====*/
%MACRO Report6(Year);
%IF %SYSFUNC(EXIST(JES.Rates_&Year))=0 %THEN %GOTO Done;
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
%Done: 	
%MEND Report6;   
%Report6(2006) 
%Report6(2009) 
%Report6(2008) 











