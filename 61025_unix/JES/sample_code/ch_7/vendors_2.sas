




/*=== JES\sample_code\ch_7\vendors_2.sas ===*/
TITLE1 "Resistance by Vendor - 4Q 2008";
PROC REPORT DATA=JES.Results_Tab(WHERE=(Mon>="2008-10")) NOWINDOWS;
	COLUMN Vendor Mon M_Res R_L R_U N_Fail;
	DEFINE Vendor/ORDER;
	DEFINE Mon /ORDER;
	DEFINE M_Res / ANALYSIS WIDTH=10;
	DEFINE R_L / ANALYSIS WIDTH=10;
	DEFINE R_U / ANALYSIS WIDTH=10;
	DEFINE N_Fail / ANALYSIS;
RUN;







