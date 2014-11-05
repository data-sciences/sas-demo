

PROC TRANSPOSE DATA=JES.Rates OUT = TRates;
	ID QTR; 
	VAR Fail;
	BY Vendor GEO; 
RUN;



