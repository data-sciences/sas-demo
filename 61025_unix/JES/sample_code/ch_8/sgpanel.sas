
ODS HTML PATH="&JES.SG/S_8_4" (URL=NONE) BODY="sgpanel.html";
ODS GRAPHICS ON / RESET IMAGENAME="F8_27_";

TITLE1 "Delay vs Resistance by Vendor and Month";
PROC SGPANEL DATA=JES.Results;
	PANELBY Mon / 
		ROWS=3 COLUMNS=2 
		UNISCALE=ALL;
		SCATTER Y=Delay X=Resistance / GROUP=Vendor;
RUN; QUIT;

ODS GRAPHICS OFF;
ODS HTML CLOSE;



