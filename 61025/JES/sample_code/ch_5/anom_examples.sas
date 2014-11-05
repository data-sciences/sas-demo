
GOPTIONS RESET=ALL GUNIT=PCT HTEXT=3 FTEXT=SWISS BORDER; 

/*===== Uncomment the next two lines to send graphic output to a postscript file 
FILENAME Fig "c:\JES\figures\Chapter_5\";
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=4IN GSFNAME=Fig GSFMODE=REPLACE;   =====*/

PROC ANOM DATA=JES.Results_Q4;
	XCHART Resistance*Vendor / ALPHA=.05;
	BOXCHART Resistance*Vendor / VREF=12.5 22.5;
RUN;

PROC MEANS DATA=JES.Results_Q4 NOPRINT NWAY;
	CLASS Vendor;
	VAR Defects Fail;
	OUTPUT OUT=Tab_9
    N(Defects)=N
	SUM(Defects) = N_Def
	SUM(Fail) = N_Fail;
RUN;

PROC ANOM DATA=Tab_9;
	UCHART N_Def*Vendor/GROUPN=N;
RUN;

PROC ANOM DATA=Tab_9;
	PCHART N_Fail*Vendor/GROUPN=N;
RUN;




