



ODS HTML PATH="&JES.SG/S_8_3" (URL=NONE) BODY="Basic.html";
ODS GRAPHICS ON / RESET IMAGENAME="F8_2_";
TITLE "SERIES";
PROC SGPLOT DATA=JES.Results_Tab(WHERE=(Vendor="ChiTronix"));
	SERIES Y=M_Res X=Mon;
RUN; 
TITLE "SCATTER";
PROC SGPLOT DATA=JES.Results_Tab(WHERE=(Vendor="ChiTronix"));
	SCATTER Y=M_Res X=Mon;
RUN; 
TITLE "STEP";
PROC SGPLOT DATA=JES.Results_Tab(WHERE=(Vendor="ChiTronix"));
	STEP Y=M_Res X=Mon;
RUN; 
TITLE "NEEDLE";
PROC SGPLOT DATA=JES.Results_Tab(WHERE=(Vendor="ChiTronix"));
	NEEDLE  Y=M_Res X=Mon / BASELINE=20;
RUN;
TITLE "PBSPLINE";
PROC SGPLOT DATA=JES.Results_Tab(WHERE=(Vendor="ChiTronix"));
	PBSPLINE  Y=M_Res X=Month;
RUN;
ODS GRAPHICS OFF;
ODS HTML CLOSE;

