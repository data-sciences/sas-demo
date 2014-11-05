
/*==== Delete any previously created graphics 
PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT; ====*/

/*===== Univariate analysis of the Resistance variable =====*/
PROC UNIVARIATE DATA=JES.Results_Q4;
	VAR Resistance;
RUN;

/*===== Test the hypothesis that the mean = 16 =====*/
PROC UNIVARIATE DATA=JES.Results_Q4 MU0=16;
	VAR Resistance;
RUN;

/*===== Test the hypothesis of normality =====*/
PROC UNIVARIATE DATA=JES.Results_Q4  NORMALTEST;
	VAR Resistance ;
RUN;

GOPTIONS RESET=ALL GUNIT=PCT HTEXT=4 FTEXT='Arial' BORDER; 

/*===== Uncomment the next two lines to send graphic output to a postscript file  
FILENAME Fig "c:\JES\figures\Chapter_5\";
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=4IN GSFNAME=Fig GSFMODE=REPLACE;  =====*/

/*===== Use the HISTOGRAM statement to create a histogram =====*/
TITLE HEIGHT=5 "Distribution of Resistance - All Vendors";
PROC UNIVARIATE DATA=JES.Results_Q4;
	VAR Resistance;
	HISTOGRAM Resistance / NORMAL(MU=est SIGMA=est);
	INSET N MEAN STD SKEWNESS KURTOSIS NORMAL(AD ADPVAL)
	/ HEIGHT=2.5 FORMAT = 5.3 POSITION=NW;
RUN;

/*===== Use the PROBPLOT statement to greate a probability plot =====*/
TITLE HEIGHT=5 "Probability Plot for Resistance - All Vendors";
PROC UNIVARIATE DATA=JES.Results_Q4 NORMALTEST ;
	VAR Resistance;
	PROBPLOT Resistance / NORMAL(MU=EST SIGMA=EST) PCTLMINOR;
	INSET N MEAN STD SKEWNESS KURTOSIS
	/ HEIGHT=2.5 FORMAT = 5.3 POSITION=NW;
RUN;

/*===== Use a CLASS statement to create separate histograms for each  vendor =====*/
GOPTIONS GUNIT=PCT HTEXT=3; 
TITLE HEIGHT=5 "Distribution of Resistance by Vendor";
PROC UNIVARIATE DATA=JES.Results_Q4;
	CLASS Vendor;
	VAR Resistance;
	HISTOGRAM Resistance / NORMAL(MU=est SIGMA=est) NROW=3;
	INSET N MEAN STD 
	/ HEIGHT=2 FORMAT = 5.2 POSITION=NW;
RUN;

/*===== Use a CLASS statement to create separate histograms for each 
combination of vendor and month =====*/
TITLE HEIGHT=5 "Distribution of Resistance by Vendor and Month";
PROC UNIVARIATE DATA=JES.Results_Q4;
	CLASS Vendor Month;
	VAR Resistance;
	HISTOGRAM Resistance / NORMAL(MU=est SIGMA=est) NROW=3 NCOL=3;
	INSET N MEAN
	/ HEIGHT=2 FORMAT = 5.3 POSITION=NE;
RUN;
TITLE;

