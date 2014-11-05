
/*======================================================
JES.First
JES.First_Sum
JES.Second
JES.Second_Sum
JES.Third
JES.Third_Sum
JES.Production
JES.Production_Sum
=======================================================*/

DATA Test_Matrix; 
	LENGTH Study $10.;
	FORMAT Mean 8.2;
	DO Batch=1 TO 25;
		Study = "First";       Num=10; Mean=15+Batch/6;  Sigma=3; Rate =  .05; OUTPUT;
		Study = "Second";      Num=10; Mean=15+Batch/48; Sigma=3; Rate =  .05; OUTPUT;
		Study = "Third";       Num=10; Mean=17.5;        Sigma=1.5; Rate =  .05;      OUTPUT;
		Study = "Production";  Num=10; Mean=17.5;        Sigma=1.25; Rate =  .05;     OUTPUT; 
	END;
RUN;

DATA Test_Matrix; SET Test_Matrix;
	IF Study="First" AND Batch=10 THEN Mean=20.5;

	IF Study="Production" AND Batch>20 THEN Mean=18;

RUN;
DATA Records; SET Test_Matrix;
	DO i = 1 TO Num; 
		Sample=i;
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
	IF Study="First" AND Batch=1 AND Sample=3 THEN Defects=2;
	IF Study="First" AND Batch=2 AND Sample =2 THEN Defects=1;
	DROP Mean Sigma Rate Seed SeedP Z Num i;
RUN;

DATA First;  SET Results; IF Study="First"; DROP Study; RUN;
DATA Second; SET Results; IF Study="Second"; DROP Study; RUN;
DATA Third; SET Results; IF Study="Third"; DROP Study; RUN;
DATA Production; SET Results; IF Study="Production"; DROP Study; RUN;

PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE Records Test_Matrix Results;
RUN; QUIT;

PROC MEANS DATA=First NOPRINT NWAY;
	CLASS Batch;
	OUTPUT OUT=First_Sum
	N(Resistance)=ResistanceN
	MEAN(Resistance)=ResistanceX
	STDDEV(Resistance)=ResistanceS
	RANGE(Resistance)=ResistanceR;
RUN;
DATA First_Sum; SET First_Sum;
	KEEP Batch ResistanceN ResistanceX ResistanceS ResistanceR;
RUN;

PROC MEANS DATA=Second NOPRINT NWAY;
	CLASS Batch;
	OUTPUT OUT=Second_Sum
	N(Resistance)=ResistanceN
	MEAN(Resistance)=ResistanceX
	STDDEV(Resistance)=ResistanceS
	RANGE(Resistance)=ResistanceR;
RUN;
DATA Second_Sum; SET Second_Sum;
	KEEP Batch ResistanceN ResistanceX ResistanceS ResistanceR;
RUN;

PROC MEANS DATA=Third NOPRINT NWAY;
	CLASS Batch;
	OUTPUT OUT=Third_Sum
	N(Resistance)=ResistanceN
	MEAN(Resistance)=ResistanceX
	STDDEV(Resistance)=ResistanceS
	RANGE(Resistance)=ResistanceR;
RUN;
DATA Third_Sum; SET Third_Sum;
	KEEP Batch ResistanceN ResistanceX ResistanceS ResistanceR;
RUN;

PROC MEANS DATA=Production NOPRINT NWAY;
	CLASS Batch;
	OUTPUT OUT=Production_Sum
	N(Resistance)=ResistanceN
	MEAN(Resistance)=ResistanceX
	STDDEV(Resistance)=ResistanceS
	RANGE(Resistance)=ResistanceR;
RUN;
DATA Production_Sum; SET Production_Sum;
	KEEP Batch ResistanceN ResistanceX ResistanceS ResistanceR;
RUN;

DATA JES.First; SET First; RUN;
DATA JES.First_Sum; SET First_Sum; RUN;
DATA JES.Second; SET Second; RUN;
DATA JES.Second_Sum; SET Second_Sum; RUN;
DATA JES.Third; SET Third; RUN;
DATA JES.Third_Sum; SET Third_Sum; RUN;
DATA JES.Production; SET Production; RUN;
DATA JES.Production_Sum; SET Production_Sum; RUN;

PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE First First_1 First_Sum Second Second_Sum Third Third_Sum Production Production_Sum;
RUN; QUIT;

