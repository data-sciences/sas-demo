
GOPTIONS RESET=ALL;

ODS HTML PATH="&JES.SG/S_10_3" (URL=NONE) BODY="Lifereg.html";

/*===== Fit the 160 degree test results only =====*/
ODS GRAPHICS ON / RESET IMAGENAME="F10_5_";
ODS OUTPUT ParameterEstimates=Estimates_1;
PROC LIFEREG DATA=JES.LifeTest(WHERE=(Temp_C=160));
	MODEL TestTime*Censor(-1) = Temp_C /
	DISTRIBUTION=WEIBULL;
	PROBPLOT;
	INSET;
	OUTPUT OUT=Fit_1 PREDICTED=Weibull_Scale QUANTILE= .63212055 CDF=CDF ;
RUN;

/*===== Fit an Arrhenius Model =====*/
DATA LifeTest_2; SET JES.LifeTest;
	Z = 1000/(Temp_C+273.15);
RUN;
ODS GRAPHICS ON / RESET IMAGENAME="F10_6_";
ODS OUTPUT ParameterEstimates=Estimates_2;
PROC LIFEREG DATA=LifeTest_2(KEEP=Temp_C Z TestTime Censor);
	MODEL TestTime*Censor(-1)= Z / 
	DISTRIBUTION=WEIBULL;
	PROBPLOT ;
	INSET;
	OUTPUT OUT=Fit_2 PREDICTED=Weibull_Scale QUANTILE= .63212055 CDF=CDF;
RUN;

/*===== Add the Actual and Fitted values of Log(1/(1-F(t)) =====*/
PROC SORT DATA=Fit_2 OUT=Fit_2A; BY Temp_C TestTime; RUN;
DATA Fit_2A; SET Fit_2A; BY Temp_C TestTime; RETAIN Cum_Fail;
	IF FIRST.Temp_C=1 THEN DO;
		IF Censor=-1 THEN Cum_Fail=0;
		IF Censor= 1 THEN Cum_Fail=1; 
	END;
	IF FIRST.Temp_C=0 THEN DO;
		IF Censor=1 THEN Cum_Fail=Cum_Fail+1;
	END;
	P_Fail= (Cum_Fail-.5)/(300);
	LSA  = LOG(1/(1-P_Fail));
	LSF  = LOG(1/(1-CDF));
RUN;

/*===== Plot Actual and Fit =====*/
TITLE1 "Arrhenius Fit to Accelerated Life Test Data";
ODS GRAPHICS ON / RESET IMAGENAME="F10_7_";
PROC SGPLOT DATA=Fit_2A;
	SCATTER Y=LSA X=TestTime / GROUP=Temp_C;
	SERIES  Y=LSF  X=TestTime / GROUP=Temp_C;
	YAXIS LABEL="Percent Failed" TYPE=LOG; XAXIS TYPE=LOG;
	FORMAT LSA PERCENT8.0;
RUN; QUIT:

ODS GRAPHICS OFF;
ODS HTML CLOSE;

