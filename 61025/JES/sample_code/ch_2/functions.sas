
DATA Rand;
	Seed=12345;
	DO I = 1 TO 5;
	 CALL RANNOR(Seed,  X);
 	 Y =  RANNOR(Seed);
	 OUTPUT;
	END;
RUN;

TITLE "RAND";
PROC PRINT DATA=Rand; RUN;


