
/*======================================================
JES.Vendor_list
JES.Rates_2006
JES.Rates_2007
JES.Rates_2008
=======================================================*/

DATA Rates;
	INPUT Qtr $9. RateC RateD RateE 5.2;
	DATALINES;
2006_Q1    .05  .03   .07
2006_Q2    .06  .03   .07
2006_Q3    .12  .03   .07
2006_Q4    .06  .03   .07
2007_Q1    .05  .03   .07
2007_Q2    .05  .03   .07
2007_Q3    .04  .03   .07
2007_Q4    .03  .03   .07
2008_Q1    .02  .03   .07
2008_Q2    .10  .03   .07
2008_Q3    .02  .03   .07
2008_Q4    .02  .03   .07
	;
RUN;

DATA Weeks;
	FORMAT Year $4. Qtr $9. Test_Date DATE9.;
	DO i = 0 TO 1095;
		Test_Date = '01JAN2006'd +i;
		Qtr=PUT(Year(Test_Date), 4.0)||"_Q"||PUT(QTR(Test_Date), Z1.);
		Year = PUT(Year(Test_Date), 4.0);
		N_Test = 30;
		OUTPUT;
	END;
RUN;

DATA Weeks; MERGE Weeks Rates; BY Qtr; DROP i; RUN;

DATA ChiTronix; LENGTH Vendor $9.; SET Weeks; RETAIN SEED ;
	FORMAT Defects 8.0 ;
	Vendor="ChiTronix";
	IF _N_=1 THEN SEED=12345; 
	CALL RANPOI(SEED, RateC*N_Test, Defects);
	DROP RateC RateD RateE SEED;
RUN;

DATA Duality; LENGTH Vendor $9.; SET Weeks; RETAIN SEED ;
	FORMAT Defects 8.0 ;
	Vendor="Duality";
	IF _N_=1 THEN SEED=23456; 
	CALL RANPOI(SEED, RateD*N_Test, Defects);
	IF Year < "2008";
	DROP RateC RateD RateE SEED;
RUN;

DATA Empirical; LENGTH Vendor $9.; SET Weeks; RETAIN SEED ;
	FORMAT Defects 8.0 ;
	Vendor="Empirical";
	IF _N_=1 THEN SEED=34567; 
	CALL RANPOI(SEED, RateE*N_Test, Defects);

	DROP RateC RateD RateE SEED;
RUN;

DATA Test_Results; SET ChiTronix Duality Empirical; 
RUN;

PROC SORT DATA=Test_Results; BY Test_Date Vendor; RUN;

PROC MEANS DATA=Test_Results NOPRINT;
	CLASS Year Qtr Vendor;
	OUTPUT OUT=Tab SUM(N_Test Defects)=N_Test Defects;
RUN;

DATA Tab; SET Tab;
	FORMAT Defect_Rate 8.3;
	Defect_Rate=Defects/N_Test;
RUN;

DATA Defect_Rates; SET Tab;
	IF _TYPE_=7;
	LABEL Qtr="Quarter" N_Test="Number Tested" Defects="Number Defects" 
	Defect_Rate="Defect Rate";
	KEEP Year Qtr Vendor N_Test Defects Defect_Rate;
RUN;

DATA JES.Vendor_List; LENGTH Vendor $9. ;
	N=1; Vendor="ChiTronix"; OUTPUT;
	N=2; Vendor="Duality";   OUTPUT;
	N=3; Vendor="Empirical"; OUTPUT;
RUN;
DATA JES.Rates_2006; SET Defect_Rates; IF Year=2006; RUN;
DATA JES.Rates_2007; SET Defect_Rates; IF Year=2007; RUN;
DATA JES.Rates_2008; SET Defect_Rates; IF Year=2008; RUN;

PROC DATASETS LIBRARY=WORK GENNUM=ALL NOLIST;
        DELETE Rates Weeks Chitronix Duality Empirical Test_Results Tab Defect_Rates ;
RUN; QUIT;
