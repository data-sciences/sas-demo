





DATA Temp; 
	Vendor = "ChiTronix Components";  Test = 5000; Fail =  25; OUTPUT;
	Vendor = "Duality Logic";         Test = 1000; Fail =   7; OUTPUT;
RUN;


DATA Temp2;
	INPUT Vendor $20. Test Fail;
	DATALINES;
ChiTronix Components  5000  25
Duality Logic         1000   7
	;
RUN;

DATA Temp2X;
	INPUT Vendor $25. Test Fail;
	DATALINES;
ChiTronix Components  5000  25
Duality Logic         1000   7
	;
RUN;




DATA Poisson_Table;
	DO K = 0 TO 10 BY 1;
		F = CDF('POISSON', K, 5);
		P = PDF('POISSON', K, 5);
		IF P < .05 THEN Chance = 'Unlikely';
		           ELSE Chance = 'Likely  ';
		IF F > .95 THEN DO;
			F_GT_95 = "YES";
		END;
		OUTPUT;
	END;
RUN;


DATA Temp3; SET Temp; 
RUN;

DATA More;
	Vendor = "Empirical Engineering"; Test = 7000; Fail = 100; OUTPUT;
RUN;


DATA New; SET Temp More; 
RUN;



DATA Good; LENGTH Vendor $50.;  SET Temp More; 
	IF Test>0 THEN Rate = Fail/Test;
RUN;


/*========================================
FORMAT statements
=========================================*/
DATA Better; LENGTH Vendor $50.;  SET Good;
	FORMAT Rate 6.4 Test Fail 8.0 Vendor $25.; 
RUN;


DATA Best; SET Better;
	LABEL Test = "Number of Units Tested"
		  Fail = "Number of Units Failed"
		  Rate = "Fraction Failed";
RUN;

PROC PRINT DATA=Best; RUN;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
TITLE "Best";
PROC PRINT DATA=Best NOOBS LABEL; 
	VAR Rate Fail Vendor;
RUN;
TITLE;

 
