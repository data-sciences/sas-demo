

/*==== Delete any previously created graphics 
PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT; ====*/

/*==== Specify a location to store graphic files ====*/
FILENAME Fig "&JES.figures/Chapter_6/";

/*==== Reset GOPTIONS =======*/
GOPTIONS RESET=ALL BORDER GUNIT=PCT HTEXT=3 FTEXT='Arial'; 

/*===== Uncomment this line to save output as postscript files 	
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=3.375IN GSFNAME=Fig GSFMODE=REPLACE;	   ===*/	

/*=============================================
  Using the TYPE option with HBAR
==============================================*/
PROC MEANS DATA=JES.Results NOPRINT;
	CLASS Vendor Month;
	TYPES Vendor Month;
	OUTPUT OUT=Defect_Tab
	SUM(Defects)=Num_Defects
	MEAN(Defects)=Defect_Rate;
	FORMAT Defect_Rate 8.2;
RUN;

/*===== Count ===============*/
AXIS1 LABEL=(HEIGHT=3 "Vendor");
AXIS2 LABEL=(HEIGHT=3 "Number of Units Tested");
TITLE1 H=5 "Number of Units Tested by Vendor";
PROC GCHART DATA=JES.Results;
	HBAR Vendor / NAME="F6_28a" TYPE=FREQ MAXIS=AXIS1 RAXIS=AXIS2;
RUN; QUIT;

/*===== Percent =====*/
TITLE1 H=5 "Percent of Units Tested by Vendor";
AXIS2 LABEL=(HEIGHT=3 "Percent of Units Tested");
PROC GCHART DATA=JES.Results;
	HBAR Vendor / NAME="F6_28b" TYPE=PCT MAXIS=AXIS1 RAXIS=AXIS2;
RUN; QUIT;

/*===== Sum =====*/
TITLE1 H=5 "Number of Defects by Vendor";
AXIS2 LABEL=(HEIGHT=3 "Number of Defects");
PROC GCHART DATA=JES.Results;
	HBAR Vendor / NAME="F6_28c" TYPE=SUM SUMVAR=Defects MAXIS=AXIS1 RAXIS=AXIS2 ;
RUN; QUIT;

/*===== Mean =====*/
TITLE1 H=5 "Defects per Unit by Vendor";
AXIS2 LABEL=(HEIGHT=3 "Defects per Unit");
PROC GCHART DATA=JES.Results;
	HBAR Vendor /NAME="F6_28d" TYPE=MEAN SUMVAR=Defects MAXIS=AXIS1 RAXIS=AXIS2;
	Format Defects 8.1;
RUN; QUIT;

/*==================================================
  Using the DISCRETE and MIDPOINTS options with HBAR
==================================================*/
TITLE1 H=5 "Number of Units Tested by Vendor";
PROC GCHART DATA=JES.Results;
	HBAR Vendor / NAME= "F6_29_"  TYPE=FREQ MIDPOINTS='Empirical' 'ChiTronix';
RUN; QUIT;

/*===== Numerical Variable Without the MIDPOINTS option =====*/
TITLE1 H=5 "Number of Units Tested by Month";
PROC GCHART DATA=JES.Results(WHERE=(Month <=6));
	HBAR Month / NAME= "F6_30_" TYPE=FREQ;
RUN; QUIT;

/*===== Numerical Variable with the DISCRETE option =====*/
AXIS1 LABEL=(HEIGHT=4 "Month");
PROC GCHART DATA=JES.Results(WHERE=(Month <=6));
	HBAR Month / NAME= "F6_31_" TYPE=FREQ
	MAXIS=AXIS1 MIDPOINTS = 1 TO 6 BY 1;
RUN; QUIT;

/*===== Numerical Variable with the DISCRETE option =====*/
PROC GCHART DATA=JES.Results(WHERE=(Month<=6));
	HBAR Month / NAME="F6_F_" TYPE=FREQ
	MAXIS=AXIS1 DISCRETE;
RUN; QUIT;

/*====================================================
 Using PATTERN Statements to control Bar Fill Patterns
=====================================================*/
AXIS1 LABEL=(HEIGHT=3 "Month");
AXIS2 LABEL=(HEIGHT=3 "Number of Units");
TITLE1 H=5 "Number of Units Tested by Month";
PROC GCHART DATA=JES.Results;
	HBAR Month / NAME= "F6_32_" TYPE=FREQ
	MAXIS=AXIS1 RAXIS=AXIS2 MIDPOINTS = 1 TO 12 BY 1
	PATTERNID=MIDPOINT;
RUN; QUIT;

PATTERN1 COLOR=SlateBlue VALUE=S;
PATTERN2 COLOR=Tomato  VALUE=S;
PATTERN3 COLOR=GRAY99  VALUE=S;
PATTERN4 COLOR=Blue VALUE=R1;
PATTERN5 COLOR=Red VALUE=R3;
PATTERN6 COLOR=Green VALUE=R5;
PATTERN7 COLOR=Blue VALUE=L1;
PATTERN8 COLOR=Red VALUE=L3;
PATTERN9 COLOR=Green  VALUE=L5;
PATTERN10 COLOR=Blue VALUE=X1;
PATTERN11 COLOR=Red VALUE=X3;
PATTERN12 COLOR=Green VALUE=X5;

PROC GCHART DATA=JES.Results;
	HBAR Month / NAME= "F6_33_" TYPE=FREQ
	MAXIS=AXIS1 RAXIS=AXIS2 MIDPOINTS = 1 TO 12 BY 1
	PATTERNID=MIDPOINT;
RUN; QUIT;

/*================================================
 Using the GROUP option with HBAR
=================================================*/
PATTERN1 COLOR=Red   VALUE=SOLID;
PATTERN2 COLOR=Blue  VALUE=R3;
PATTERN3 COLOR=Green VALUE=L3;
AXIS2 LABEL=(HEIGHT=3 "Number of Units");
TITLE1 H=5 "Number of Units Tested by Month and Vendor";
PROC GCHART DATA=JES.Results(WHERE=(Month<=3));
	HBAR Vendor /NAME="F6_34_" TYPE=FREQ RAXIS=AXIS2
	GROUP=Month  
	PATTERNID=GROUP;
RUN; QUIT;

TITLE1 H=5 "Number of Units Tested by Vendor and Month";
PROC GCHART DATA=JES.Results(WHERE=(Month<=3));
	HBAR Month / NAME="F6_35_" TYPE=FREQ RAXIS=AXIS2
	GROUP=Vendor
	DISCRETE
	PATTERNID=MIDPOINT;
RUN; QUIT;

/*=================================================
 Using the WIDTH, SPACE and GSPACE options with VBAR
==================================================*/
/*===== Uncomment this line to save output as postscript files 	 
GOPTIONS DEVICE=PSLEPSFC XMAX=12IN YMAX=6.75IN GSFNAME=Fig GSFMODE=REPLACE;	   ===*/ 

AXIS1 LABEL =(H=4  A=90  FONT='Arial' 'Number of Units')
	  VALUE = (H=3 FONT='Arial');
TITLE1 H=5 "Number of Units Tested by Vendor";
PROC GCHART DATA=JES.Results;
	VBAR Vendor / NAME="F6_36_" TYPE=FREQ RAXIS=AXIS1;
RUN; QUIT;

PROC GCHART DATA=JES.Results;
	VBAR Vendor /NAME="F6_37_" TYPE=FREQ RAXIS=AXIS1 
	WIDTH=50 SPACE=20;
RUN; QUIT;

TITLE1 H=5 "Number of Units Tested by Vendor and Month";
PROC GCHART DATA=JES.Results(WHERE=(Month<=3));
	VBAR Month /NAME="F6_38_" TYPE=FREQ RAXIS=AXIS1 GROUP=Vendor 
	DISCRETE 
	PATTERNID=MIDPOINT
	WIDTH=17 SPACE=3 GSPACE=6;
RUN; QUIT;

/*=================================================
 Controlling the display of statisics
==================================================*/
AXIS1 LABEL=(HEIGHT=4 "Vendor");
AXIS2 LABEL=(HEIGHT=4 "Defects per Unit");
TITLE1 H=5 "Defects per Unit by Vendor";
PROC GCHART DATA=JES.Results;
	HBAR Vendor / NAME="F6_39_" TYPE=MEAN SUMVAR=Defects
	MAXIS=AXIS1 RAXIS=AXIS2	WIDTH=10
	FREQ SUM MEAN
	FREQLABEL="Number of Units"
	SUMLABEL="Number of Defects"
	MEANLABEL="Defects per Unit";
	FORMAT Defects 8.1;
RUN; QUIT;

GOPTIONS HTEXT=3;
TITLE1 H=5 "Defects per Unit by Vendor and Month";
AXIS2 LABEL=(H=4 A=90 "Defects per Unit");
PATTERN1 COLOR=GRAYCC VALUE=SOLID;
PROC GCHART DATA=JES.Results(WHERE=(Month<=3));
	VBAR Month / NAME="F6_40_" TYPE=MEAN SUMVAR=Defects GROUP=Vendor
	DISCRETE WIDTH=18 SPACE=2 GSPACE=6 RAXIS=AXIS2
	OUTSIDE=MEAN INSIDE=SUM;
	FORMAT Defects 8.1;
RUN; QUIT;

/*=================================================
 Using the SUBGROUP option with HBAR
==================================================*/
GOPTIONS HTEXT=4;
PATTERN1 COLOR=Red     VALUE=L1;
PATTERN2 COLOR=GRAYD0  VALUE=SOLID;
LEGEND1 LABEL=(J=CENTER POSITION=LEFT "Failure Mode") FRAME; 
TITLE1 H=5 "Total Number of Resistance Failures by Vendor and Cause";

PROC GCHART DATA=JES.Results(WHERE=(Result NE 'Pass'));
	HBAR Vendor /NAME="F6_41_" TYPE=SUM SUMVAR=Fail SUM 
	SUMLABEL="Total # Fails"
	SUBGROUP=Result
	LEGEND=LEGEND1 WIDTH=8 SPACE=2;
RUN; QUIT;

/*===== Mean =====*/
TITLE1 H=5 "Average Number of Resistance Failures by Vendor and Cause";
PROC GCHART DATA=JES.Results(WHERE=(Result NE 'Pass'));
	HBAR Vendor / NAME="F6_42_" TYPE=MEAN SUMVAR=Fail MEAN 
	MEANLABEL="Avg # Fails"
	SUBGROUP=Result
	LEGEND=LEGEND1 WIDTH=8 SPACE=2;
RUN; QUIT;

/*=================================================
 Creating a Stacked Bar Chart for Failure Rates
==================================================*/
PROC MEANS DATA=JES.Results NOPRINT;
	CLASS Vendor Result;
	TYPES Vendor Vendor*Result;
	OUTPUT OUT=Tab
	N(Fail)=N_Test SUM(Fail)=N_Fail;
RUN;

DATA Summary; 
	MERGE Tab(WHERE=(_TYPE_=2) KEEP=Vendor N_Test _TYPE_) 
		  Tab(WHERE=(_TYPE_=3) KEEP=Vendor Result N_Fail _TYPE_) ; 
	BY Vendor; 
	FORMAT P_Fail percent8.2;
	P_Fail=N_Fail/N_Test;
RUN;

GOPTIONS HTEXT=3;
TITLE1 H=5 "Resistance Test Failure Rate by Vendor and Cause";
AXIS1 LABEL=(H=4 "% Fail") ;
AXIS2 LABEL=(HEIGHT=4 "Vendor") VALUE=(H=4);
PATTERN1 COLOR=Red     VALUE=L1;
PATTERN2 COLOR=GRAYD0  VALUE=SOLID;
PROC GCHART DATA=Summary(WHERE=(Result ne 'Pass'));
	VBAR Vendor / NAME="F6_43_" TYPE=SUM SUMVAR=P_Fail SUBGROUP=Result
	WIDTH=30 SPACE=25 RAXIS=AXIS1 MAXIS=AXIS2 COUTLINE=Blue
	OUTSIDE=SUM INSIDE=SUM;
RUN; QUIT;







