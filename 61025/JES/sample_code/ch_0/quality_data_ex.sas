
/*======================================================
JES.Fourth
JES.Fourth_Sum
JES.Fifth
JES.Fifth_Sum
JES.Sixth
JES.Sixth_Sum
=======================================================*/

DATA Test_Matrix; 
	LENGTH Study $10.;
	FORMAT Mean 8.2;
	DO Batch=1 TO 25;
		Study = "Fourth";     Num=10; Mean=19+Batch/60;  Sigma=1;   Rate =  .05; OUTPUT;
		Study = "Fifth";      Num=10; Mean=20-Batch/12; Sigma=2.5; Rate =  .05; OUTPUT;
		Study = "Sixth";      Num=10; Mean=17.5;  IF Batch IN (14, 15, 16, 17) THEN Mean=19;      Sigma=1.5; Rate =  .05; OUTPUT; 
	END;
RUN;



DATA Test_Matrix; SET Test_Matrix;
	IF Study="Fourth" AND Batch=10 THEN Mean=20.5;
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
	IF Study="Fourth" AND Batch=1 AND Sample=3 THEN Defects=2;
	IF Study="Fourth" AND Batch=2 AND Sample =2 THEN Defects=1;
	DROP Mean Sigma Rate Seed SeedP Z Num i;
RUN;

DATA Fourth;  SET Results; IF Study="Fourth"; DROP Study; RUN;
DATA Fifth; SET Results; IF Study="Fifth"; DROP Study; RUN;
DATA Sixth; SET Results; IF Study="Sixth"; DROP Study; RUN;

PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE Records Test_Matrix Results;
RUN; QUIT;

PROC MEANS DATA=Fourth NOPRINT NWAY;
	CLASS Batch;
	OUTPUT OUT=Fourth_Sum
	N(Resistance)=ResistanceN
	MEAN(Resistance)=ResistanceX
	STDDEV(Resistance)=ResistanceS
	RANGE(Resistance)=ResistanceR;
RUN;
DATA Fourth_Sum; SET Fourth_Sum;
	KEEP Batch ResistanceN ResistanceX ResistanceS ResistanceR;
RUN;

PROC MEANS DATA=Fifth NOPRINT NWAY;
	CLASS Batch;
	OUTPUT OUT=Fifth_Sum
	N(Resistance)=ResistanceN
	MEAN(Resistance)=ResistanceX
	STDDEV(Resistance)=ResistanceS
	RANGE(Resistance)=ResistanceR;
RUN;
DATA Fifth_Sum; SET Fifth_Sum;
	KEEP Batch ResistanceN ResistanceX ResistanceS ResistanceR;
RUN;


PROC MEANS DATA=Sixth NOPRINT NWAY;
	CLASS Batch;
	OUTPUT OUT=Sixth_Sum
	N(Resistance)=ResistanceN
	MEAN(Resistance)=ResistanceX
	STDDEV(Resistance)=ResistanceS
	RANGE(Resistance)=ResistanceR;
RUN;
DATA Sixth_Sum; SET Sixth_Sum;
	KEEP Batch ResistanceN ResistanceX ResistanceS ResistanceR;
RUN;



DATA JES.Fourth; SET Fourth; RUN;
DATA JES.Fourth_Sum; SET Fourth_Sum; RUN;
DATA JES.Fifth; SET Fifth; RUN;
DATA JES.Fifth_Sum; SET Fifth_Sum; RUN;
DATA JES.Sixth; SET Sixth; RUN;
DATA JES.Sixth_Sum; SET Sixth_Sum; RUN;

PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE Fourth Fourth_1 Fourth_Sum Fifth Fifth_Sum Sixth Sixth_Sum Production Production_Sum;
RUN; QUIT;
