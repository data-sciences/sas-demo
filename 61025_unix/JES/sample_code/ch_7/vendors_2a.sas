




/*=== JES\sample_code\ch_7\vendors_2a.sas ===*/
TITLE1 "Resistance by Vendor - 4Q 2008";
PROC REPORT DATA=Results_Tab(WHERE=(Mon>="2008-10")) NOWINDOWS;
	COLUMN Vendor Mon M_Res R_L R_U N_Fail Report_Link;
	DEFINE Vendor/ORDER;
	DEFINE Mon  /ORDER;
	DEFINE M_Res / ANALYSIS;
	DEFINE R_L / ANALYSIS;
	DEFINE R_U / ANALYSIS;
	DEFINE N_Fail / ANALYSIS;
	DEFINE Report_Link / DISPLAY NOPRINT;
	COMPUTE Report_Link;
		CALL DEFINE("_C1_", "URL", Report_Link);
	ENDCOMP;
RUN;







