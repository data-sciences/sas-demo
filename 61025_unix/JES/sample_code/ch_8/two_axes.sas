


ODS HTML PATH="&JES.SG/S_8_3" (URL=NONE) BODY="Two_Axes.html";
ODS GRAPHICS ON / RESET IMAGENAME="F8_11_";

TITLE "Mean Resistance and Delay by Month";
PROC SGPLOT DATA=JES.Results_Tab(WHERE=(Vendor="ChiTronix"));
	SERIES Y=M_Res  X=Mon ;
	SERIES Y=M_Del  X=Mon / Y2AXIS;
RUN; 

ODS GRAPHICS / RESET IMAGENAME="F8_12_";
TITLE "Mean Resistance and Delay by Vendor and Month";
PROC SGPLOT DATA=JES.Results_Tab;
	SERIES Y=M_Res  X=Mon / GROUP=Vendor;
	SERIES Y=M_Del  X=Mon / Y2AXIS GROUP=Vendor;
RUN;

ODS GRAPHICS OFF;
ODS HTML CLOSE;

