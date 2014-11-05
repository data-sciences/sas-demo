


/*==== Delete any previously created graphics 
PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT; ====*/

/*==== Specify a location to store graphic files ====*/
FILENAME Fig "&JES.figures/Chapter_6/";

/*==== Reset GOPTIONS =======*/
GOPTIONS RESET=ALL BORDER GUNIT=PCT HTEXT=3 FTEXT='Arial'; 

/*===== Uncomment the next line to save graphic output as postscript files in the Fig folder  
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=4IN GSFNAME=Fig GSFMODE=REPLACE;	 =====*/


/*===== PROC GCHART: Block Chart =====*/
GOPTIONS COLORS=(Gray60 GRAYD0) CTEXT=Black HPOS=40 VPOS=40;
TITLE1 H=4 "Resistance Test Results by Vendor and Month";
PROC GCHART DATA=JES.Results_Q4;
	BLOCK Month / NAME="F6_44_" 
	GROUP=Vendor 
	SUBGROUP=Result 
	TYPE=FREQ MIDPOINTS=10 TO 12 COUTLINE=Black CAXIS=Green BLOCKMAX=50;
RUN; QUIT;

/*===== PROC GCHART: Pie Chart ===============*/
TITLE1 H=4 "Resistance Test Results by Vendor";
PATTERN1 COLOR=Green  VALUE=P3N135;
PATTERN2 COLOR=Red    VALUE=P3N45;
PATTERN3 COLOR=GRAYD0 VALUE=PSOLID;
PROC GCHART DATA=JES.Results;
	PIE Result / NAME="F6_45_" 
	SUBGROUP=Vendor 
	COUTLINE=Blue NOHEADING;
RUN; QUIT;

/*===== PROC GPLOT: Bubble Plot ===============*/
GOPTIONS YMAX=3.375IN;
TITLE1 H=4 "M_Def and P_Fail by Vendor and Month";
AXIS1 LABEL=('Month') OFFSET=(10, 10);
AXIS2 LABEL=NONE OFFSET=(10, 10);
PROC GPLOT DATA=JES.Results_Tab(WHERE=(Month<=6));
	BUBBLE Vendor*Month=M_Def /NAME="F6_46_" 
		BSIZE=15 HAXIS=AXIS1 VAXIS=AXIS2 BLABEL;
	BUBBLE2 Vendor*Month=P_Fail / 
		BSIZE=10 VAXIS=AXIS2 BCOLOR=Red NOAXIS;
RUN; QUIT;

/*=== PROC GMAP =====*/
DATA Anno; LENGTH FUNCTION COLOR STYLE $8.;	SET JES.Wafer_Data; 
	RETAIN FUNCTION 'LABEL' COLOR 'White' WHEN 'A' 
		STYLE 'SWISSB' XSYS YSYS '2' SIZE 1;
	X=X+.5; Y=Y+.5;TEXT = PUT(Parm, 5.2);
RUN;

/*===== PROC GMAP: CHORO ===============*/
/* GOPTIONS RESET=ALL;
GOPTIONS GUNIT=PCT HTEXT=4 FTEXT='Arial' DEVICE=GIF733 BORDER
	COLORS=(GRAYF0 GRAYD0 GRAYB0 GRAY90 GRAY70 GRAY50 GRAY30) CTEXT=Black; */

GOPTIONS YMAX=4IN COLORS=(GRAYF3 GRAYD0 GRAYB0 GRAY90 GRAY70 GRAY50 GRAY30) CTEXT=Black;
PATTERN1; PATTERN2;
TITLE1 H=4 "Parm Measurement by Wafer Location";
LEGEND1 LABEL=("Parameter");
PROC GMAP MAP=JES.Wafer_Map DATA= JES.Wafer_Data ANNOTATE=Anno;
	CHORO Parm / NAME="F6_47_" MIDPOINTS=0 TO 6 BY 1
          LEVELS=7 COUTLINE=Gray WOUTLINE=3 LEGEND=LEGEND1;
	ID Loc;
RUN; QUIT;

GOPTIONS YMAX=3.375IN;
/*===== PROC GMAP: BLOCK ===============*/
PROC GMAP MAP=JES.Wafer_Map DATA= JES.Wafer_Data;
	BLOCK Parm / NAME="F6_48_" MIDPOINTS=0 TO 6 BY 1 LEVELS=7 COUTLINE=Gray
	LEGEND=LEGEND1 XVIEW=2 YVIEW=-2 ZVIEW=2 BLOCKSIZE=2 SHAPE=CYLINDER;
	ID Loc;
RUN; QUIT;

/*===== PROC GMAP: PRISM ===============*/
PROC GMAP MAP=JES.Wafer_Map DATA= JES.Wafer_Data;
	PRISM Parm / NAME="F6_49_" MIDPOINTS=0 TO 6 BY 1 LEVELS=7 COUTLINE=Gray WOUTLINE=3 
	LEGEND=LEGEND1 XVIEW=2 YVIEW=-2 ZVIEW=2 XLIGHT=8 YLIGHT=8;
	ID Loc;
RUN; QUIT;

/*===== PROC GMAP: SURFACE ===============*/
GOPTIONS COLORS=(Black);
PROC GMAP MAP=JES.Wafer_Map DATA= JES.Wafer_Data;
	SURFACE Parm / NAME="F6_50_" LEVELS=7 ROTATE=40 TILT=60 NLINES=75;
	ID Loc;
RUN; QUIT;



/*===== PROC GCONTOUR: PLOT ===============*/
GOPTIONS COLORS=(GRAYB0 GRAY90 GRAY70 GRAY50 GRAY30);
PROC GCONTOUR DATA=JES.Wafer_Data;
	PLOT X*Y=Parm /NAME="F6_51_" LEVELS=0 TO 6 AUTOLABEL CAXIS=Blue CTEXT=Black;
RUN; QUIT;

/*===== PROC G3D: PLOT ===============*/
PROC G3D DATA=JES.Wafer_Data;
	PLOT X*Y=Parm /NAME="F6_52_" CAXIS=Blue CBOTTOM=Red CTOP=Green;
RUN; QUIT;

/*===== PROC G3D: SCATTER ===============*/
PROC G3D DATA=JES.Wafer_Data;
	SCATTER X*Y=Parm /NAME="F6_53_" CAXIS=Blue COLOR='Red' ROTATE=30 SHAPE='HEART';
RUN; QUIT;

