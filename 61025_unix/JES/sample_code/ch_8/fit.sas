


ODS HTML PATH="&JES.SG/S_8_3" (URL=NONE) BODY="Fit.html";
ODS GRAPHICS ON / RESET IMAGENAME="F8_6_";

TITLE "PBSPLINE";
PROC SGPLOT DATA=JES.Results;
	PBSPLINE Y=Delay X=Resistance / CLM CLI DEGREE=3;
RUN; 

TITLE "LOESS";
PROC SGPLOT DATA=JES.Results;
	LOESS Y=Delay X=Resistance / CLM INTERPOLATION=CUBIC;
RUN; 

TITLE "REG";
PROC SGPLOT DATA=JES.Results;
	REG Y=Delay X=Resistance / CLM CLI DEGREE=3;
RUN;

TITLE "ELLIPSE";
PROC SGPLOT DATA=JES.Results;
	ELLIPSE Y=Delay X=Resistance / TYPE=MEAN FILL FILLATTRS=(COLOR=RED);
	ELLIPSE Y=Delay X=Resistance / TYPE=PREDICTED;
	SCATTER Y=Delay X=Resistance;
RUN;

DATA Results; SET JES.Results;
    D_Low  = 125 + Resistance + .2*Resistance**2 - 50;
	D_High = 125 + Resistance + .2*Resistance**2 + 50;
RUN;
TITLE "BAND";
PROC SGPLOT DATA=Results;
	BAND X=Resistance UPPER=D_High LOWER=D_Low;
	SCATTER Y=Delay X=Resistance;
RUN; 

ODS GRAPHICS OFF;
ODS HTML CLOSE;
