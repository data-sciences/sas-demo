

GOPTIONS RESET=ALL;
ODS HTML PATH="&JES.SG/S_10_2" (URL=NONE) BODY="Reliability.html";

/*===== Probability Plot for Units tested at 160 =====*/
ODS GRAPHICS ON / RESET IMAGENAME="F10_1_";
ODS OUTPUT ParmEst=ParmEst_1 PctEst=PctEst_1;
PROC RELIABILITY DATA=JES.LifeTest(WHERE=(Temp_C=160));
		DISTRIBUTION WEIBULL;
		PROBPLOT TestTime*Censor(-1) / CONFIDENCE=.9;
RUN;

/*===== Probability Plots for each temperature on the same graph=====*/
ODS GRAPHICS ON / RESET IMAGENAME="F10_2_";
ODS OUTPUT ParmEst=ParmEst_2;
PROC RELIABILITY DATA=JES.LifeTest;
	DISTRIBUTION WEIBULL;
	PROBPLOT TestTime*Censor(-1)=Temp_C / OVERLAY NOCONF;
RUN;

/*===== Plots for each temperature - with a common shape parameter=====*/
ODS GRAPHICS ON / RESET IMAGENAME="F10_3_";
ODS OUTPUT ParmEst=ParmEst_3;
PROC RELIABILITY DATA=JES.LifeTest;
	DISTRIBUTION WEIBULL;
	MODEL TestTime*Censor(-1)=Temp_C;
	PROBPLOT TestTime*Censor(-1)=Temp_C / FIT=MODEL OVERLAY NOCONF;
RUN;

/*===== Fitting an Arrhenius Model to the data =====*/
ODS GRAPHICS ON / RESET IMAGENAME="F10_4_";
ODS OUTPUT ModPrmEst=ModPrmEst_4 ParmEst=ParmEst_4;
PROC RELIABILITY DATA=JES.LifeTest;
	DISTRIBUTION WEIBULL;
	MODEL TestTime*Censor(-1)=Temp_C/ RELATION=ARRHENIUS ;
	PROBPLOT TestTime*Censor(-1)=Temp_C / FIT=MODEL OVERLAY NOCONF;
RUN;

ODS GRAPHICS OFF;
ODS HTML CLOSE;


