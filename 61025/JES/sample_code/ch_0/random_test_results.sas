
/*======================================================
JES.Results
JES.Results_1
JES.Results_Tab
JES.Results_Q4
JES.Results_Tab_2
JES.Wafer_Map
JES.Wafer_Data
=======================================================*/

DATA Test_Matrix; LENGTH Vendor $9.;
		DO Month=1 TO 12;
			Mon="2008-"||PUT(Month, Z2.0);
			Num=20+3*INT(Month/3); Mean=18+(Month/12)*3; Sigma=2; DA=125; DB=1; D_Sig=15;  
				Rate=ROUND(1+Month/12, .1); Vendor="ChiTronix"; OUTPUT;
			Num=25+INT(Month/3); Mean=15; Sigma=2+(Month/12);   DA=140; DB=2; D_Sig=30; 
				Rate=1+Month/4;   Vendor="Duality"; OUTPUT;
			Num=15; Mean=20-(Month/12)*5; Sigma=3; DA=120; DB=1; D_Sig=15;  
				Rate=.5;        Vendor="Empirical";   OUTPUT;
		END;
RUN;

DATA Test_Matrix; SET Test_Matrix; 
	IF Month=3 AND Vendor="Duality" THEN Num=0;
	IF Month=11 AND Vendor="Duality" THEN Num=0;
	Mean  = ROUND(Mean, .1);
	Sigma = ROUND(Sigma, .1);
RUN;
PROC SORT DATA=Test_Matrix; BY Vendor Month; RUN;

DATA RECORDS; SET TEST_MATRIX;
	DO Unit=1 TO Num;
		OUTPUT;
	END;
RUN;

%let D=500; %let D=7500; %LET D = 50000; %let B = 1;
DATA JES.Results; SET RECORDS; retain SEED0 SEED1 SEED2 SEED3;
	FORMAT Delay 8.0 Resistance 8.2 Result $8. Fail 8.0;
	if _N_=1 then do; SEED0=12345; SEED1=54321; SEED2=15243; SEED3=34251;  END;
	CALL RANNOR(SEED0, Z); 
	Resistance = Mean + Sigma*Z; 

	IF Vendor="ChiTronix" AND Month=1 AND Unit=1 THEN Resistance=22.6;
	IF Vendor="ChiTronix" AND Month=1 AND Unit=4 THEN Resistance=12.3;

	FORMAT Result $8.;
	Result = "Pass"; Fail=0;
	IF Resistance < 12.5 THEN Result="Low Res";
	IF Resistance > 22.5 THEN Result="High Res";
	IF Result ne "Pass" THEN Fail=1;
	CALL RANNOR(SEED1, De);
	Delay = DA + DB*Resistance + .2*Resistance**2 + D_Sig*De;
	DLO=DA + DB*Resistance + .2*Resistance**2 - 50;
	DHI=DA + DB*Resistance + .2*Resistance**2 + 50;
	
	A = exp(-Resistance/3);
	CALL RANUNI(SEED2, U); 
	Lifetime=ROUND(A*&D*(  (-log(U))**(1/&B)  ));
	Survive=0;
	if Lifetime > 150 then do
		Survive=1;
		Lifetime=150;
	end;
	
	FORMAT Defects 8.0;
	CALL RANPOI(Seed3, Rate, Defects);
	DROP Mean Sigma Z Num  DA DB D_Sig De Rate
		SEED0 SEED1 SEED2 SEED3 DLO DHI A U;
RUN;

DATA JES.Results; SET JES.Results; RETAIN SEED;
	IF _N_=1 THEN SEED=67890;
 	FORMAT ProcessDate DATE9.;
 	ProcessDate=MDY(Month, Min(Unit,30), 2008);
	CALL RANNOR(SEED, Z);
	ProcessTemp=ROUND(30+(-.2*Resistance)+ (.5*Z), .1);
	DROP SEED Z;
RUN;


DATA JES.Results_Q4; SET JES.Results; IF Month >= 10; RUN; 

DATA JES.Results_1; SET JES.Results; IF Unit=1; IF Month <=3; RUN;

PROC MEANS DATA=JES.Results_Q4 NOPRINT;
	CLASS Vendor;
	VAR Defects Resistance Fail;
	OUTPUT OUT=JES.Results_Tab_2
    N(Defects)=N
	SUM(Defects) = N_Def
	MEAN(Defects)=M_Def
	MEAN(Resistance)=M_Res
	SUM(Fail) = N_Fail
	MEAN(Fail) = P_Fail ;
	FORMAT M_Def P_Fail 6.2;
RUN;

DATA JES.Results_Tab_2; SET JES.Results_Tab_2;
	LABEL 
	    N = "Number Tested"
		M_Res="Mean Resistance" 
		P_Fail = "Fraction Failed"
		N_Fail = "Number of Fails";
RUN;

PROC MEANS DATA=JES.Results NOPRINT NWAY ALPHA=.10;
	CLASS Vendor Month Mon;
	VAR Defects Resistance Fail ;
	OUTPUT OUT=JES.Results_Tab
    N(Defects)=N
	SUM(Defects) = N_Def
	MEAN(Defects)=M_Def
	MEAN(Delay)=M_Del
	LCLM(Delay) = D_L
	UCLM(Delay) = D_U
	MEAN(Resistance)=M_Res
	LCLM(Resistance) = R_L
	UCLM(Resistance) = R_U
	SUM(Fail) = N_Fail
	MEAN(Fail) = P_Fail;
	FORMAT M_Def P_Fail 6.2;
RUN;

DATA JES.Results_Tab; SET JES.Results_Tab;
	LABEL 
	    Mon="Month"
		M_Res="Mean Resistance" 
		R_L="Lower Confidence Limit" 
		R_U="Upper Confidence Limit"
		N_Fail="Number of Fails"
		M_Del="Mean Delay" 
		D_L="Lower Confidence Limit" 
		D_U="Upper Confidence Limit";
	DROP _TYPE_ _FREQ_;
RUN;

DATA JES.Wafer_Map;
	DO I=1 TO 8;
		DO J= 1 TO 8;
			Loc = J + 8*(I-1); 
			X= I;     Y = J;     OUTPUT;
			X= (I+1); Y = J;     OUTPUT;
			X= (I+1); Y = (J+1); OUTPUT;
			X= I;     Y = (J+1); OUTPUT;
		END;
	END;
RUN;

DATA JES.Wafer_Data; SET JES.Wafer_Map;
	IF MOD(_N_,4)=1;
	Parm = SQRT((X-5)*(X-5)+(Y-5)*(Y-5));
RUN;

PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE Test_Matrix Records;
RUN; QUIT;


