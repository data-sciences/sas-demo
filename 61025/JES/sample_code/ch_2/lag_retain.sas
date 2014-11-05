

DATA Lag_Table; SET JES.Poisson;
	Dif_F = DIF(F); 
	Lag2_P = LAG2(P);
	IF K IN (0,2) THEN Lag_F=LAG(F);
RUN;



DATA Retain_Table; SET JES.Poisson; 
	RETAIN Sum_P 0;
	Sum_P = Sum_P + P;
RUN;


DATA Retain_Table_2; SET Retain_Table; 
	RETAIN Sum_P 0;
	Sum_P = Sum_P + P;
RUN;


DATA Retain_Table_3; SET Retain_Table(DROP=Sum_P); 
	RETAIN Sum_P 0;
	Sum_P = Sum_P + P;
RUN;

