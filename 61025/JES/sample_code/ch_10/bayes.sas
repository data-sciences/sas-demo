
GOPTIONS RESET=ALL;

ODS HTML PATH="&JES.SG/S_10_7" (URL=NONE) BODY="Lifereg.html";

/*===== Fit the 160 degree test results only =====*/
ODS GRAPHICS ON / RESET IMAGENAME="F10_12_";
ODS OUTPUT ParameterEstimates=MLE
		   PostSummaries=Summary;
PROC LIFEREG DATA=JES.LifeTest(WHERE=(Temp_C=160));
	MODEL TestTime*Censor(-1) = Temp_C /
	DISTRIBUTION=WEIBULL;
	BAYES SEED=1 WEIBULLSHAPEPRIOR=GAMMA;
RUN;

ODS GRAPHICS OFF;
ODS HTML CLOSE;
