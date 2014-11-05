

GOPTIONS RESET=ALL;

ODS HTML PATH="&JES.SG/S_10_4" (URL=NONE) BODY="Lifetest.html";

ODS GRAPHICS ON / RESET IMAGENAME="F10_8_";
ODS OUTPUT HomTests = Tests;
PROC LIFETEST DATA=JES.LifeTest  METHOD=KM ALPHA=.1;
	TIME TestTime*Censor(-1);
	STRATA Temp_C;
	SURVIVAL OUT=Life_Table
	PLOTS=SURVIVAL(EPB ATRISK STRATA=PANEL);
RUN;

ODS GRAPHICS OFF;
ODS HTML CLOSE;

