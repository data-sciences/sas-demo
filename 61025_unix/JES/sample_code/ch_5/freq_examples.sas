
/*==== Delete any previously created data sets in the WORK Library ====*/
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;


PROC FREQ DATA=JES.Results_Q4;
	TABLES Vendor*Fail /CHISQ  FISHER;
RUN;
