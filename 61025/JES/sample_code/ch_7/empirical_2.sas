


/*=== JES\sample_code\ch_7\empirical_2.sas ===*/
TITLE HEIGHT=5 "Resistance - Empirical - 4Q 2008";

PROC UNIVARIATE DATA=JES.Results_Q4(WHERE=(Vendor="Empirical"));
	VAR Resistance;
	HISTOGRAM Resistance / Normal(MU=est SIGMA=est) HREF=12.5 22.5;
	INSET N MEAN STD SKEWNESS KURTOSIS NORMAL(AD ADPVAL)
	/ HEIGHT=2.5 FORMAT = 5.3 POSITION=NW;
RUN;
