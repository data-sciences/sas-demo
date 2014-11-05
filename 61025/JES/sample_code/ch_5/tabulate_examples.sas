
/*=========================================================
  Use PROC TABULATE to compute the average resistance 
  by Vendor in a more presentable format
==========================================================*/

PROC TABULATE DATA=JES.Results_Q4;
	CLASS Vendor Month;
	VAR Resistance;
	TABLES Vendor, MEAN*Resistance*Month;
RUN;

/*=========================================================
  Use the ALL keyword to add row and column averages
==========================================================*/

PROC TABULATE DATA=JES.Results_Q4;
	CLASS Vendor Month;
	VAR Resistance;
	TABLES Vendor ALL, MEAN=''*Resistance=' '*(Month ALL)
	/BOX='Average Resistance' ;
RUN;

/*=========================================================
  Add average percent Fail to the table
==========================================================*/

PROC TABULATE DATA=JES.Results_Q4;
	CLASS Vendor Month;
	VAR Resistance Fail;
	TABLES Vendor ALL, ((MEAN=''*F=6.2*Resistance) 
	((MEAN=''*F=PERCENT7.1)*Fail='% Fail'))*(Month ALL)
    / BOX='Test Results' MISSTEXT='N/A';
RUN;



