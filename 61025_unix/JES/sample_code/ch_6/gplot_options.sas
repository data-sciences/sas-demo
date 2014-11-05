

/*==== Delete any previously created graphics 
PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT; ====*/

/*==== Specify a location to store graphic files ====*/
FILENAME Fig "&JES.figures/Chapter_6/";

/*==== GOPTIONS =======*/
GOPTIONS RESET=ALL 
	BORDER
	GUNIT=PCT 
	HTEXT=3 
	FTEXT='Arial' 
	CTEXT=Black
	INTERPOL=JOIN
	DEVICE=GIF XMAX=6IN YMAX=4.5IN
	GSFNAME=Fig GSFMODE=REPLACE;    
PROC GPLOT DATA =JES.Results_Tab;	
	PLOT M_Res*Month=Vendor / NAME="F6_12_";
RUN; QUIT;

/*==== Reset GOPTIONS =======*/
GOPTIONS RESET=ALL BORDER GUNIT=PCT HTEXT=3 FTEXT='Arial'; 
SYMBOL1 VALUE=dot    HEIGHT=2 COLOR=green  WIDTH=2 INTERPOL=JOIN;
SYMBOL2 VALUE=square HEIGHT=2 COLOR=red    WIDTH=2 INTERPOL=JOIN;
SYMBOL3 VALUE=plus   HEIGHT=2 COLOR=blue   WIDTH=2 INTERPOL=JOIN; 

/*===== Uncomment this line to save output as postscript files    
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=4IN GSFNAME=Fig GSFMODE=REPLACE;	=====*/  

/*==== Titles and Footnotes =======*/

TITLE1 HEIGHT=5 "Mean Resistance by Vendor";
TITLE2 FONT=SWISSB COLOR= Blue "12 Month Period Beginning Jan. 2008";
FOOTNOTE1 JUSTIFY=LEFT "John Doe" JUSTIFY=RIGHT "BigCorp";
FOOTNOTE2  "Do " 
	COLOR=Red UNDERLIN=2 "NOT" 
	COLOR=Black UNDERLIN=0 "  Distribute This Report";

PROC GPLOT DATA =JES.Results_Tab;	
	PLOT M_Res*Month=Vendor / NAME="F6_13_";
RUN; QUIT;


/*==== Cancelling the FOOTNOTE2 statement ===*/
FOOTNOTE2;

/*==== Cancelling all TITLE and FOOTNOTE statements ===
TITLE1;
FOOTNOTE1;
======*/

/*===== Axes ==========*/
AXIS1 LABEL=(JUSTIFY=Center HEIGHT=4  FONT='Arial' COLOR=Black "Month of Manufacture") 
	  VALUE = (ANGLE=45 ROTATE=0 HEIGHT=3 FONT='Arial')
	  OFFSET= (5, 0); 
AXIS2 LABEL =(H=4  A=90  FONT='Arial' 'Average Resistance')
	  VALUE = (H=3 FONT='Arial')
	  ORDER = (10 TO 25 BY 5) 
	  MINOR = (N=4);
PROC GPLOT DATA =JES.Results_Tab;	
	PLOT M_Res*Mon=Vendor / NAME="F6_14_"
	HAXIS=AXIS1 VAXIS=AXIS2;
	Format M_Res 3.0;
RUN; QUIT;


SYMBOL4 VALUE= =        HEIGHT=3 COLOR=green  WIDTH=2 INTERPOL=join LINE=2;
SYMBOL5 VALUE= diamond  HEIGHT=3 COLOR=red    WIDTH=2 INTERPOL=join LINE=2;
SYMBOL6 VALUE= triangle HEIGHT=3 COLOR=blue   WIDTH=2 INTERPOL=join LINE=2;

AXIS3 LABEL =(ANGLE=270 H=3 F='Arial' 'Average Delay') ORDER=(100 TO 250 BY 50) MINOR=(N=4);
PROC GPLOT DATA =JES.Results_Tab;	
	PLOT M_Res*Mon=Vendor / NAME="F6_C_"
	HAXIS=AXIS1 VAXIS=AXIS2;
	Format M_Res 3.0;
	PLOT2 M_Del*Mon=Vendor / VAXIS=AXIS3;
RUN; QUIT;

	
/*===== LEGENDs ==========*/
LEGEND1
	LABEL = (F='Arial' H=3 C=Black J=CENTER POSITION=TOP "Component Vendor")
	VALUE = (C=Black H=3 "A" "B" "C")
    POSITION = (BOTTOM CENTER INSIDE)
	FRAME
	ACROSS = 3
	MODE = PROTECT;
PROC GPLOT DATA =JES.Results_Tab;	
	PLOT M_Res*Mon=Vendor / NAME="F6_15_"
	HAXIS=AXIS1 VAXIS=AXIS2 LEGEND=LEGEND1;
	Format M_Res 3.0;
RUN; QUIT;


LEGEND2 POSITION=(TOP CENTER INSIDE) FRAME;
PROC GPLOT DATA =JES.Results_Tab;	
	PLOT M_Res*Mon=Vendor / NAME="F6_D_"
	HAXIS=AXIS1 VAXIS=AXIS2 LEGEND=LEGEND1;
	Format M_Res 3.0;
	PLOT2 M_Del*Mon=Vendor / VAXIS=AXIS3 LEGEND=LEGEND2;
RUN; QUIT;



/*===== Automatic Reference Lines ==========*/
TITLE1 H=5 "Delay vs Resistance by Vendor: Months 10-12";
TITLE2 H=3 "Specification Limits: Resistance(12.5-22.5) Delay(150-250)";
SYMBOL1 FONT=SWISSB VALUE='C' HEIGHT=2 COLOR=green  INTERPOL=NONE;
SYMBOL2 FONT=SWISSB VALUE='D' HEIGHT=2 COLOR=navy   INTERPOL=NONE;
SYMBOL3 FONT=SWISSB VALUE='E' HEIGHT=2 COLOR=black  INTERPOL=NONE;
AXIS1 ORDER=(5 TO 25 BY 5); 
AXIS2 ORDER=(100 TO 350 BY 50);
PROC GPLOT DATA =JES.Results_Q4;
	PLOT Delay*Resistance=Vendor / NAME="F6_E_"
	HAXIS=AXIS1 VAXIS=AXIS2
	AUTOHREF AUTOVREF;
	FORMAT Resistance 8.0;
RUN; QUIT;

/*===== User Defined Reference Lines ==========*/
TITLE1 H=5 "Delay vs Resistance by Vendor: Months 10-12";
TITLE2 H=3 "Specification Limits: Resistance(12.5-22.5) Delay(150-250)";
SYMBOL1 FONT=SWISSB VALUE='C' HEIGHT=2 COLOR=green  INTERPOL=NONE;
SYMBOL2 FONT=SWISSB VALUE='D' HEIGHT=2 COLOR=navy   INTERPOL=NONE;
SYMBOL3 FONT=SWISSB VALUE='E' HEIGHT=2 COLOR=black  INTERPOL=NONE;
AXIS1 ORDER=(5 TO 25 BY 5); 
AXIS2 ORDER=(100 TO 350 BY 50);
PROC GPLOT DATA =JES.Results_Q4;
	PLOT Delay*Resistance=Vendor / NAME="F6_16_"
	HAXIS=AXIS1 VAXIS=AXIS2
	HREF=12.5 22.5 VREF=150 250
	LHREF=2 LVREF=2 CHREF=GRAY80 CVREF=GRAY80;
	FORMAT Resistance 8.0;
RUN; QUIT;



/*===== Reference Line LABELs =====*/
AXIS1 ORDER=(5 TO 25 BY 5) 
	REFLABEL=(H=3 F='Arial' POSITION=TOP J=CENTER 'LSL' 'USL');  
AXIS2 ORDER=(100 TO 350 BY 50) 
	REFLABEL=(H=3 F='Arial' J=LEFT POSITION=MIDDLE ' LSL' ' USL');
PROC GPLOT DATA =JES.Results_Q4;
	PLOT Delay*Resistance=Vendor / NAME="F6_17_"
	HAXIS=AXIS1 VAXIS=AXIS2
	HREF=12.5 22.5 VREF=150 250
	LHREF=2 LVREF=2 CHREF=GRAY80 CVREF=GRAY80;
	FORMAT Resistance 8.0;
RUN; QUIT;



/*===== SYMBOLs and LINE TYPEs =====*/
SYMBOL1 FONT=Marker VALUE='V'  HEIGHT=2 COLOR=Blue   
	INTERPOL=STEPJ WIDTH=2 LINE=2;
SYMBOL2 FONT=SWISS  VALUE='D'  HEIGHT=3 COLOR=Red    
	INTERPOL=JOIN WIDTH=1 LINE=1;
SYMBOL3 FONT=       VALUE=DOT  HEIGHT=4 COLOR=Black  
	INTERPOL=SPLINE WIDTH=3 LINE=3;
TITLE1 H=5 "Symbols and Line Types";
PROC GPLOT DATA =JES.Results_Tab;
	PLOT M_Res*Month=Vendor / NAME="F6_18_";
	Format M_Res 3.0;
RUN; QUIT;


/*===== Line Types  =====*/
/*===== Uncomment the next line to save graphic output as postscript files in the Fig folder  
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=3.75IN GSFNAME=Fig GSFMODE=REPLACE; =====*/ 
 

%MACRO linetypes(n);
	%DO i=1 %TO &n;
		SYMBOL&i V=NONE W=2 C=blue I=JOIN L=&i;
	%END;
DATA a; DO Line_Type=1 TO &n; x=0; OUTPUT; x=1; OUTPUT; END; RUN;
AXIS1 LABEL=NONE VALUE=(H=5) ORDER=1 TO &n OFFSET=(5,5);
AXIS2 LABEL=NONE VALUE=NONE;
TITLE1 H=5 "Line Types";  FOOTNOTE;
PROC GPLOT DATA=a;
	PLOT Line_Type*x=Line_Type / NAME="F6_19_" VAXIS=AXIS1 HAXIS=AXIS2 NOLEGEND;
RUN; QUIT;
%MEND linetypes;  
%linetypes(10);



/*===== PROC GFONT =====*/

TITLE H=5 "Marker Font";
PROC GFONT NAME=MARKER  HEIGHT=6 CTEXT=blue 
	 SHOWROMAN ROMHT=3  ROMCOL=Black ROMFONT=SWISSB NOBUILD; 
RUN;



/*===== SAS Color Names =====*/

PROC REGISTRY LIST
	STARTAT='COLORNAMES';
RUN;

%INCLUDE "&JES.sample_code/ch_6/colors.sas";
%Show_Colors


/*=================================================
Box Plot Examples
=================================================*/
GOPTIONS XMAX=6IN YMAX=3.375IN;
/*=== Schematic Box Plot ===*/
TITLE1 H=5 "Resistance by Vendor";
TITLE2 H=4 "Schematic Box Plot";
AXIS1 LABEL=NONE VALUE=(F=Arial H=4) OFFSET=(10, 10);
AXIS2 LABEL=(H=5 F='Arial' ANGLE=90 "Resistance") 
		VALUE=(F='Arial' H=4) 
		ORDER=(5 TO 30 BY 5);
SYMBOL1 INTERPOL=BOXT BWIDTH=5 
	CO=green WIDTH=2
	FONT=Marker VALUE='V'  HEIGHT=2 CV=red;
PROC GPLOT DATA=JES.Results;
	PLOT Resistance*Vendor / NAME="F6_21_"  
	HAXIS=AXIS1 VAXIS=AXIS2 VREF=12.5 22.5;
	FORMAT Resistance 8.0;
RUN; QUIT;

/*=== Box Plot with Whiskers at 5th and 95th Percentile ===*/
TITLE2 H=4 "Box Plot with Whiskers at 5th and 95th Percentile";
SYMBOL1 INTERPOL=BOX05TJ BWIDTH=10 
	CO=Blue WIDTH=3 CI=Green LINE=2
	FONT= VALUE='X' H=3  CV=Red;
PROC GPLOT DATA=JES.Results;
	PLOT Resistance*Vendor / NAME="F6_22_" HAXIS=AXIS1 VAXIS=AXIS2 VREF=12.5 22.5;
	FORMAT Resistance 8.0;
RUN; QUIT;



/*=== CAUTION =====*/
/*=== In the example below, the AXIS2 statement causes several data points to
      be ignored in creating the box plot ===*/


GOPTIONS GUNIT=PCT HTEXT=4 FTEXT='Arial'; 
TITLE1 H=5 "Resistance by Vendor";
TITLE2 H=4 "Schematic Box Plot";
AXIS1 label=none VALUE=(F=Arial H=4) OFFSET=(10, 10);
AXIS2 label=(H=5 F='Arial' ANGLE=90 "Resistance") 
		VALUE=(F='Arial' H=4)
		ORDER=10 TO 20 BY 2;

/*=== Schematic Box Plot ===*/
SYMBOL1 VALUE= dot H=3 CO=Blue CV=Red INTERPOL=BOXT BWIDTH=5;
PROC GPLOT DATA=JES.Results;
	PLOT Resistance*Vendor / NAME="F6_F_"  HAXIS=AXIS1 VAXIS=AXIS2;
RUN; QUIT;

