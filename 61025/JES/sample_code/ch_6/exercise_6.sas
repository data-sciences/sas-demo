

/*==== Delete any previously created graphics 
PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT; ====*/

/*==== Specify a location to store graphic files ====*/
FILENAME Fig "c:\JES\figures\Chapter_6\";

/*==== Reset GOPTIONS =======*/
GOPTIONS RESET=ALL BORDER GUNIT=PCT HTEXT=3 FTEXT='Arial'; 

/*===== Uncomment the next line to save graphic output as postscript files in the Fig folder  
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=3.375IN GSFNAME=Fig GSFMODE=REPLACE;	 =====*/

/*==========================================================
Exercise: Show the effect of the POSITION option of ANNOTATE
===========================================================*/
DATA Temp;
	DO X= 1 TO 3;
		DO Y = 1 TO 5;
			P = PUT(X+((6-Y)-1)*3, $2.);
			IF P="10" THEN P="A";
			IF P="11" THEN P="B";
			IF P="12" THEN P="C";
			IF P="13" THEN P="D";
			IF P="14" THEN P="E";
			IF P="15" THEN P="F";
			OUTPUT;
		END;
	END;
RUN;
DATA myAnno; SET Temp;
	FUNCTION='LABEL'; XSYS='2'; YSYS='2'; X=X; Y=Y;
	POSITION=TRIM(LEFT(P)); TEXT='POS = '||TRIM(LEFT(P));
RUN;
/*
GOPTIONS RESET=ALL GUNIT=PCT HTEXT=4 FTEXT='Arial' DEVICE=PNG BORDER; 
*/
SYMBOL1 VALUE=dot      HEIGHT=3 COLOR=green;
AXIS1 LABEL=NONE OFFSET=(10, 10);
AXIS2 LABEL=NONE OFFSET=(20, 20);
TITLE "Effect of the POSITION Variable in an ANNOTATE Data Set";
PROC GPLOT DATA=Temp;
	PLOT Y*X / NAME="F6_54_" ANNOTATE=myAnno HAXIS=AXIS2 VAXIS=AXIS1;
RUN; QUIT;




