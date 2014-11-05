


ODS HTML PATH="&JES.SG/S_8_3" (URL=NONE) BODY="Overlay.html";
ODS GRAPHICS ON / RESET IMAGENAME="F8_9_";

TITLE "Distribution of Resistance";
PROC SGPLOT DATA=JES.Results;
	HISTOGRAM Resistance;
	DENSITY Resistance / TYPE=NORMAL(MU=15 SIGMA=3) ;
	DENSITY Resistance / TYPE=KERNEL;
RUN; 


ODS GRAPHICS / RESET IMAGENAME="F8_10_";
TITLE "Mean Resistance and Delay by Month for ChiTronix";
PROC SGPLOT DATA=JES.Results_Tab(WHERE=(Vendor="ChiTronix"));
	SERIES Y=M_Res   X=Mon;
	SERIES Y=M_Del   X=Mon;
RUN;

ODS GRAPHICS OFF;
ODS HTML CLOSE;

