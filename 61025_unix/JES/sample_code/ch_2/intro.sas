


DATA XSquare;
	DO X = 0 TO 5;
		Y=X*X;
		OUTPUT;
	END;
RUN;


PROC PRINT DATA=XSquare; RUN;

