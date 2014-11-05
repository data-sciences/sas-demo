
/*======================================================
JES.Production_2
=======================================================*/

DATA Test_Matrix; 
	LENGTH Study $10.;
	FORMAT Mean 8.2;
	DO Batch=1 TO 25;
		Study = "Production";  Num=1000; Mean=17.5;   Sigma=1.5; Rate =  .01;     OUTPUT; 
	END;
RUN;

DATA Test_Matrix; SET Test_Matrix;
	IF Study="Production" AND Batch>20 THEN DO; Mean=18.25; Sigma=1.75; END;
	IF Study="Production" AND Batch = 4 THEN DO; Rate=.025; END;
	IF Study="Production" AND Batch = 16 THEN DO; Rate=.025; END;
RUN;
DATA Records; SET Test_Matrix;
	DO i = 1 TO Num; 
		Sample_Number=i;
		OUTPUT; 
	END;
RUN;

DATA Results; SET Records; RETAIN Seed SeedP;
	FORMAT Resistance 8.2 ;
	IF _N_=1 then Seed=12345; IF _N_=1 then SeedP=12345;
	CALL RANNOR(Seed, Z); 
	Resistance = Mean + Sigma*Z; 
	FORMAT Fail 8.0 Result $8.; 
    Result = "Pass"; Fail=0;
	IF Resistance < 12.5 THEN Result="Low Res";
	IF Resistance > 22.5 THEN Result="High Res";
	IF Result ne "Pass" THEN Fail=1;
	FORMAT Defects 8.0;
	CALL RANPOI(SeedP, Rate, Defects);
	DROP Mean Sigma Rate Seed SeedP Z Num i;
RUN;

DATA JES.Production_2; SET Results; IF Study="Production"; DROP Study; RUN;

PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE Records Test_Matrix Results;
RUN; QUIT; 

