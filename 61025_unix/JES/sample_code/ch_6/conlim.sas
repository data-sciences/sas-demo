


/*==== Delete any previously created graphics 
PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;  ====*/

/*==== Specify a location to store graphic files ====*/
FILENAME Fig "&JES.figures/Chapter_6/";

/*=== Plot Average Resistance and Confidence Limits by Vendor ===*/
DATA Tab; SET JES.Results_Tab; 
	IF Month=1; 
	KEEP Vendor M_Res R_L R_U;
RUN;

/*==== Reset GOPTIONS =======*/
GOPTIONS RESET=ALL BORDER GUNIT=PCT HTEXT=3 FTEXT='Arial'; 

/*===== Uncomment this line to save output as postscript files 	
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=3.375IN GSFNAME=Fig GSFMODE=REPLACE;	  ===*/  


TITLE H=5 "Resistance by Vendor - Month 1";
SYMBOL1 VALUE=dot      HEIGHT=3 COLOR=green;
SYMBOL2 VALUE=diamond  HEIGHT=3 COLOR=blue;
SYMBOL3 VALUE=diamond  HEIGHT=3 COLOR=blue;
AXIS1 label=none VALUE=(F=Arial H=4) OFFSET=(10,10);
AXIS2 label=(H=5 F='Arial' "Resistance") 
	VALUE=(F='Arial' H=4)
	ORDER=10 TO 26 by 2
	REFLABEL=(H=3 J=Center POSITION=Top 'Lower Limit' 'Upper Limit');
PROC GPLOT DATA=Tab;
PLOT Vendor*(M_Res R_L R_U) / NAME="F6_23_"
	OVERLAY VAXIS=AXIS1 HAXIS=AXIS2 HREF=12.5 22.5;
RUN; QUIT;

/*=========================================================
  Create Tab_1 with both lower and upper confidence limits
  in the same CL variable
==========================================================*/
DATA Tab_1; 
	SET Tab(RENAME=(R_L=CL)) Tab(RENAME=(R_U=CL));
RUN;
PROC SORT DATA=Tab_1; BY Vendor CL; RUN;

/*=========================================================
  Plot Mean and Confidence Limits, with a line joining
  the lower and upper limits
==========================================================*/
SYMBOL2 INTERPOL=JOIN;
PROC GPLOT DATA=Tab_1;
	PLOT Vendor*(M_Res CL) / NAME="F6_24_" OVERLAY 
	VAXIS=AXIS1 HAXIS=AXIS2 HREF=12.5 22.5;
RUN; QUIT;

/*=== Use SKIPMISS to break the line at each Vendor===*/
PROC SQL NOPRINT;
	CREATE TABLE Missing AS SELECT DISTINCT Vendor FROM Tab_1;
QUIT;
DATA Tab_2; set Tab_1 Missing;  RUN;
PROC SORT DATA=Tab_2; BY Vendor CL; RUN;

PROC GPLOT DATA=Tab_2;
	PLOT Vendor*(M_Res CL) / NAME="F6_25_" OVERLAY 
	VAXIS=AXIS1 HAXIS=AXIS2 HREF=12.5 22.5 SKIPMISS;
RUN; QUIT;


/*=== ANNOTATE the Points ===*/
DATA My_Anno; SET Tab_2(WHERE=(R_U>0));
	FUNCTION='LABEL'; 
	XSYS='2'; YSYS='2'; HSYS='3';
	X= R_U; YC=Vendor; 
	POSITION='6';	
	STYLE='"Arial"';
	SIZE=3; 
	TEXT="  Mean = "||TRIM(LEFT(PUT(M_Res, 6.2)));
	KEEP XSYS YSYS HSYS STYLE FUNCTION POSITION SIZE X YC TEXT;
RUN;

PROC GPLOT DATA=Tab_2;
 PLOT Vendor*(M_Res CL)/ NAME="F6_26_" 
 OVERLAY VAXIS=AXIS1 HAXIS=AXIS2 HREF=12.5 22.5 SKIPMISS ANNOTATE=My_Anno;
RUN; QUIT;

DATA Tab_3; SET JES.Results_Tab;
	IF Vendor="ChiTronix";
	FORMAT LCL UCL 8.3;
	LCL = CINV(.10, 2*N_Def)/(2*N);
	UCL = CINV(.90, 2*(N_Def+1))/(2*N);
	KEEP Mon N N_Def M_Def LCL UCL;
RUN;
DATA Tab_4; 
	SET Tab_3(RENAME=(LCL=CL) ) 
		Tab_3(RENAME=(UCL=CL)) 
		Tab_3(KEEP=Mon M_Def); RUN;
PROC SORT DATA=Tab_4; BY Mon CL; RUN;


DATA My_Anno_2; SET Tab_4(WHERE=(UCL>0));
	FUNCTION='LABEL';
	XSYS='2'; YSYS='2'; HSYS='3'; XC=Mon; Y = UCL; POSITION='2';
	STYLE='"Arial"'; SIZE=2.5; TEXT=PUT(M_Def, 6.3);
	KEEP FUNCTION XSYS YSYS HSYS XC Y POSITION STYLE SIZE TEXT;
RUN;


TITLE H=5 "Monthly Defect Rates - ChiTronix - 2008";
SYMBOL1 VALUE=dot      HEIGHT=3 COLOR=green INTERPOL=JOIN;
SYMBOL2 VALUE=diamond  HEIGHT=3 COLOR=blue INTERPOL=JOIN;
LEGEND1 LABEL=NONE POSITION=(BOTTOM CENTER INSIDE) FRAME
		VALUE=('Mean' '90% Limits') MODE=PROTECT;
AXIS1 LABEL=NONE
	  	VALUE=(ANGLE=45 ROTATE=0 F=Arial H=4) OFFSET=(4,4);
AXIS2 LABEL=(ANGLE=90 H=5 F='Arial' "Defect Rate") 
		VALUE=(F='Arial' H=4) ORDER=0 TO 3 BY .5  
		REFLABEL=(H=4 J=Left POSITION=Top '  Spec Limit  ');
PROC GPLOT DATA=Tab_4;
	PLOT (M_Def CL)*Mon / NAME="F6_27_" OVERLAY LEGEND=LEGEND1
	HAXIS=AXIS1 VAXIS=AXIS2 SKIPMISS 
	LVREF=2 CVREF=Black VREF=2 ANNOTATE= my_Anno_2;
RUN; QUIT;

