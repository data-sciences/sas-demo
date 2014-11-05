
ODS LISTING;	
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;

/*=== Define a Macro Program ===*/
%MACRO myMacro;
	%PUT Some SAS code here;
%MEND myMacro;

/*=== Run the Macro Program ===*/
%myMacro

%MACRO Report1;
	TITLE1 "Defect Rate Report for 2006 at ChiTronix";
	DATA Temp; SET JES.Rates_2006;
		IF Vendor="ChiTronix";
	RUN;
	PROC PRINT DATA=Temp NOOBS LABEL; 
		VAR Qtr N_Test Defects Defect_Rate;
	RUN;
%MEND Report1;  
%Report1

%MACRO Report2(Vendor, Year);
	TITLE1 "Defect Rate Report for &Year at &Vendor";
	DATA Temp; SET JES.Rates_&Year;
		IF Vendor="&Vendor";
	RUN;
	PROC PRINT DATA=Temp NOOBS LABEL; 
		VAR Qtr N_Test Defects Defect_Rate;
	RUN;
%MEND Report2;  
%Report2(Empirical, 2008)


%MACRO Report3(Vendor, Year=2006, Note = Normal Test Process);
	TITLE1 "Defect Rate Report for &Year at &Vendor";
	TITLE2 "&Note";
	DATA Temp; SET JES.Rates_&Year;
		IF Vendor="&Vendor";
	RUN;
	PROC PRINT DATA=Temp NOOBS LABEL; 
		VAR Qtr N_Test Defects Defect_Rate;
	RUN;
%MEND Report3;  
%Report3(ChiTronix) 
%Report3(Empirical, Note= Extended Test Process, Year=2007)














