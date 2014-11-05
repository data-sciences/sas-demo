

GOPTIONS RESET=ALL GUNIT=PCT HTEXT=4 FTEXT='Arial' BORDER; 

/* Use ODS TRACE to find out what kind of output is available  */
ODS TRACE ON;
TITLE HEIGHT=5 "Distribution of Resistance - All Vendors";
PROC UNIVARIATE DATA=JES.Results_Q4;
	VAR Resistance;
	HISTOGRAM Resistance / NORMAL(MU=est SIGMA=est);
	INSET N MEAN STD SKEWNESS KURTOSIS NORMAL(AD ADPVAL)
	/ HEIGHT=2.5 FORMAT = 5.3 POSITION=NW;
RUN;
ODS TRACE OFF;



/* Use ODS OUTPUT to create SAS data sets from procedure output  */
ODS OUTPUT
	Moments         = WORK.Moments
	BasicMeasures   = WORK.Basic
	FitQuantiles    = WORK.Quant;
PROC UNIVARIATE DATA=JES.Results_Q4;
	VAR Resistance;
	HISTOGRAM Resistance / NORMAL(MU=est SIGMA=est);
	INSET N MEAN STD SKEWNESS KURTOSIS NORMAL(AD ADPVAL)
	/ HEIGHT=2.5 FORMAT = 5.3 POSITION=NW;
RUN;



/* Use PROC SQL to save a parameter as a macro variable */
PROC SQL NOPRINT;
	SELECT nValue2 INTO :Kurt
	FROM Moments
	WHERE Label2 = "Kurtosis";
QUIT;
%PUT Kurtosis = &Kurt;

/* Use CALL SYMPUT to save a parameter as a macro variable */
DATA _NULL_; SET Moments; 
	IF Label2="Kurtosis" THEN CALL SYMPUT('Kurt', nValue2);
RUN;
%PUT Kurtosis = &Kurt;

/* Use ODS SELECT and EXCLUDE to control which outputs are included in your document  */
ODS LISTING CLOSE;
ODS HTML PATH="&JES.ods_output/page5" (URL=NONE)
	BODY="select.html" STYLE=MINIMAL;
ODS HTML SELECT BasicMeasures GoodnessOfFit;
GOPTIONS RESET=ALL GUNIT=PCT HTEXT=4 FTEXT='Arial'; 
TITLE HEIGHT=5 "Distribution of Resistance - All Vendors";
PROC UNIVARIATE DATA=JES.Results_Q4;
	VAR Resistance;
	HISTOGRAM Resistance / Normal(MU=est SIGMA=est);
	INSET N MEAN STD SKEWNESS KURTOSIS NORMAL(AD ADPVAL)
	/ HEIGHT=2.5 FORMAT = 5.3 POSITION=NW;
RUN;
ODS HTML CLOSE;
ODS LISTING;

ODS LISTING CLOSE;
ODS HTML PATH="&JES.ods_output/page6" (URL=NONE)
	BODY="exclude.html" STYLE=MINIMAL;
ODS HTML EXCLUDE Moments BasicMeasures TestsForLocation Quantiles 
         ExtremeObs ParameterEstimates GoodnessOfFit FitQuantiles;
GOPTIONS RESET=ALL GUNIT=PCT HTEXT=4 FTEXT='Arial'; 
TITLE HEIGHT=5 "Distribution of Resistance - All Vendors";
PROC UNIVARIATE DATA=JES.Results_Q4;
	VAR Resistance;
	HISTOGRAM Resistance / Normal(MU=est SIGMA=est);
	INSET N MEAN STD SKEWNESS KURTOSIS NORMAL(AD ADPVAL)
	/ HEIGHT=2.5 FORMAT = 5.3 POSITION=NW;
RUN;
ODS HTML CLOSE;
ODS LISTING;
