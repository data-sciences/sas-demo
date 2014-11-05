
/*======================================================
JES.Contacts
JES.TimeStamp
JES.Poisson
JES.Units
JES.Fails
JES.Rates
=======================================================*/

DATA JES.Contacts;
	INPUT Name $15. City $10. State $5. Number $15.;
	DATALINES;
John X. Doe    Lodi       nj  201-555-O123
Mary Murphy    San  Jose  CA  408.555.678
;
RUN;

DATA JES.TimeStamp;
	Time = "Tue Apr 03 08:25:00 MST 2004";  OUTPUT;
	Time = "Tue Mar 26 17:52:31 MST 2004";  OUTPUT;
	Time = "Tue Jun 03 08:25:00 MDT 2004";  OUTPUT;
RUN;

DATA JES.Poisson;
	DO K = 0 TO 5;
		F = CDF('POISSON', K, 5);
		P = PDF('POISSON', K, 5);
		OUTPUT;
	END;
RUN;

DATA JES.Units; FORMAT SN $4. Install MMDDYY10.;
	SEED=12345;
	DO I=1 TO 10;
		CALL RANUNI(SEED, X); CALL RANUNI(SEED, Y); CALL RANUNI(SEED, Z);
		SN=put(FLOOR(99*X), Z4.0); 
		Install = '01JUN2006'd + ROUND(21*Y);
		Loc ="CA"; IF Z<.45 THEN Loc="NY";
		OUTPUT;
	END;
	DROP i X Y Z SEED;
RUN;
DATA JES.Units; SET JES.Units;
	L=LAG3(SN);
	IF _N_ in (4,6,8) THEN SN=L; 
	DROP L; 
RUN;

DATA JES.Fails; FORMAT SN $4. Fail MMDDYY10. Loc $6.;
	SEED=12345;
	DO I=1 TO 10;
		CALL RANUNI(SEED, X); CALL RANUNI(SEED, Y); CALL RANUNI(SEED, Z);
		SN=put(FLOOR(99*X), Z4.0); 
		Fail = '01JUL2006'd + FLOOR(90*Y);
		Loc ="Top"; IF Z<.45 THEN Loc="Bottom";  
		OUTPUT;
	END;
	DROP i X Y Z SEED;
RUN;

DATA JES.Fails; SET JES.Fails; L=Lag4(SN);
	IF _N_=5 THEN SN=L;
	IF _N_ NE 4; IF _N_ NE 8; IF _N_ NE 10;
	DROP L;
RUN;
PROC SORT DATA=JES.Fails; BY Fail; RUN;

DATA JES.Rates; 
	Format Vendor $15. GEO $4.  QTR $2. Rate 8.4 Test 8.0; SEED=12345;
	Vendor = "ChiTronix";  GEO = "APAC"; Test = 5000; 
			DO i=1 TO 4; QTR="Q"||PUT(i, 1.0); Fail=RANPOI(SEED, .05*Test);  OUTPUT;  END;
	Vendor = "Duality";  GEO = "EMEA";  Test = 1000; Fail =   7; 
			DO i=2 TO 4; QTR="Q"||PUT(i, 1.0); Fail=RANPOI(SEED, .02*Test);  OUTPUT;  END;
	Vendor = "Empirical"; GEO="AMER"; Test = 7000; Fail = 100; 
		DO i=1 TO 3; QTR="Q"||PUT(i, 1.0); Fail=RANPOI(SEED, .01*Test);  OUTPUT;  END;
RUN;

DATA JES.Rates; set JES.Rates; Format Rate percent8.2;
	if Test>0 then Rate=Fail/Test;
	drop SEED i;
RUN;





