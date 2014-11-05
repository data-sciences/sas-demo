
/*======================================================
%include "&JES.sample_code/ch_0/import_this.sas
=======================================================*/

DATA Test_Matrix; LENGTH Vendor $21.;
		DO Month=1 TO 12;
			Mon="2008-"||PUT(Month, Z2.0);
			Num=20+3*INT(Month/3); Mean=18; Sigma=2; DA=120; DB=.75; D_Sig=10;  
				Rate=.75;  Vendor="ChiTronix Components"; OUTPUT;
			Num=25+INT(Month/3); Mean=17; Sigma=2+(Month/12);   DA=120; DB=2; D_Sig=20; 
				Rate=4-Month/4;   Vendor="Duality Logic"; OUTPUT;
			Num=15; Mean=13; Sigma=3; DA=140; DB=.5; D_Sig=15;  
				Rate=ROUND(1+Month/3, .1);        Vendor="Empirical Engineering";   OUTPUT;
		END;
RUN;


DATA Test_Matrix; SET Test_Matrix; 
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
DATA Import_This; SET RECORDS; retain SEED0 SEED1 SEED2 SEED3;
	FORMAT Test_Time $25. Delay $12. Del 8.0 Resistance 8.2  Result $8. Fail 8.0;
	FORMAT TestTime DATETIME20. TestDate MMDDYY10.;
	TestTime=MDY(Month, min(30,Unit), 2008)*60*60*24;
	TestDate=DATEPART(TestTime);
    Test_Time=PUT(TestTime, DateTime20.);
	IF Vendor="Empirical Engineering" THEN Test_Time=PUT(TestDate, MMDDYY10.);
	if _N_=1 then do; SEED0=12345; SEED1=54321; SEED2=15243; SEED3=34251;  END;
	CALL RANNOR(SEED0, Z); 
	Resistance = Mean + Sigma*Z; 

  


	FORMAT Result $8.;
	Result = "Pass"; Fail=0;
	IF Resistance < 12.5 THEN Result="Fail Low";
	IF Resistance > 22.5 THEN Result="Fail Hi";
	IF Result ne "Pass" THEN Fail=1;
	CALL RANNOR(SEED1, De);
	Del = DA + DB*Resistance + .2*Resistance**2 + D_Sig*De;
    Delay=PUT(Del, 8.0);
	  IF Vendor="Duality Logic" THEN DO;
		IF Month=12 AND Unit>20 THEN Delay="N/A";
	END;
	IF Vendor="Empirical Engineering" THEN DO;
		IF Month=4 AND Unit>10 THEN Delay="N/A";
	END;

	
	FORMAT Defects 8.0;
	CALL RANPOI(Seed3, Rate, Defects);
	DROP Mean Sigma Z Num  DA DB D_Sig De Rate
		SEED0 SEED1 SEED2 SEED3 
		TestTime TestDate Del Defects;
RUN;




PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
       DELETE Test_Matrix Records;
RUN; QUIT;


PROC EXPORT DATA=Import_This 
	OUTFILE ="&JES.input_data/import_this.csv" REPLACE;
RUN;

PROC IMPORT DATAFILE="&JES.input_data/import_this.csv" 
	OUT =Import REPLACE;
RUN;
