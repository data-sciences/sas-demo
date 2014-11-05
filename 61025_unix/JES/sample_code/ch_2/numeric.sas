

DATA Stats;
	DO x = -2 TO 2 BY 1;
		F1 = CDF('NORM', x);
		F2 = CDF('NORM', x, 1, 1);
		P = PROBIT(F1);
		OUTPUT;
	END;
RUN;

TITLE "STATS";
PROC PRINT DATA=Stats; RUN;
