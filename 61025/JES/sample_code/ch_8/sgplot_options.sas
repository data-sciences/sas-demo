


ODS HTML PATH="&JES.SG/S_8_3" (URL=NONE) BODY="sgplot_options.html";
ODS GRAPHICS ON / RESET IMAGENAME="F8_13_";

/*==== Titles and Footnotes =======*/
TITLE1 "Mean Resistance by Vendor";
TITLE2 COLOR= Blue "12 Month Period Beginning Jan. 2008";
FOOTNOTE1 JUSTIFY=LEFT "John Doe" JUSTIFY=RIGHT "BigCorp";
FOOTNOTE2  "Do " 
	COLOR=Red UNDERLIN=2 "NOT" 
	COLOR=Black UNDERLIN=0 "  Distribute This Report";
PROC SGPLOT DATA =JES.Results_Tab;	
	SERIES Y=M_Res X=Mon / GROUP=Vendor;
RUN; 

/*===== Axes ==========*/
ODS GRAPHICS / RESET IMAGENAME="F8_14_";
TITLE1 "Mean Resistance and Delay by Vendor";
FOOTNOTE;
PROC SGPLOT DATA =JES.Results_Tab;
	SERIES Y=M_Res  X=Mon / GROUP=Vendor ;
	SERIES Y=M_Del  X=Mon / GROUP=Vendor Y2AXIS;
	YAXIS  LABEL = 'Mean Resistance' 
		VALUES=(0 TO 30 BY 1)  FITPOLICY=THIN;
	Y2AXIS LABEL = 'Mean Delay' MIN=180 MAX=250 GRID;
	XAXIS  LABEL="Month of Production" 
		 FITPOLICY=ROTATE REFTICKS;
RUN;

/*===== SYMBOLs and LINEs =====*/
ODS GRAPHICS / RESET IMAGENAME="F8_15_";
PROC SGPLOT DATA =JES.Results_Tab;
	SERIES Y=M_Res  X=Mon / GROUP=Vendor 
	LINEATTRS =(PATTERN=Solid THICKNESS=3);
	SERIES Y=M_Del  X=Mon / GROUP=Vendor Y2AXIS
	LINEATTRS = (PATTERN=Dash THICKNESS=2)
		MARKERS
		MARKERATTRS=(COLOR=Red SIZE=10 SYMBOL=Triangle);
	YAXIS  LABEL = 'Mean Resistance' 
		VALUES=(0 TO 30 BY 1)  FITPOLICY=THIN;
	Y2AXIS LABEL = 'Mean Delay' MIN=180 MAX=250 GRID;
	XAXIS  LABEL = "Month of Production" 
		 FITPOLICY=ROTATE REFTICKS;
RUN; 




/*===== LEGENDs ==========*/
ODS GRAPHICS / RESET IMAGENAME="F8_16_";
TITLE1 "Mean Resistance and Delay by Month: ChiTronix";
PROC SGPLOT DATA =JES.Results_Tab(WHERE=(Vendor="ChiTronix"));
	SERIES Y=M_Res  X=Mon / NAME='a' 
	LINEATTRS =(PATTERN=Solid THICKNESS=3)
		LEGENDLABEL="Resistance" ;
	SERIES Y=M_Del  X=Mon / NAME='b' Y2AXIS
	LINEATTRS = (PATTERN=Dot THICKNESS=2)
		MARKERS
		MARKERATTRS=(COLOR=Red SIZE=10 SYMBOL=Triangle)
		LEGENDLABEL="Delay" ;
	YAXIS  LABEL = 'Mean Resistance' 
		VALUES=(0 TO 30 BY 1)  FITPOLICY=THIN;
	Y2AXIS LABEL = 'Mean Delay' MIN=180 MAX=250 GRID;
	XAXIS  LABEL = "Month of Production" 
		 FITPOLICY=ROTATE REFTICKS;
	KEYLEGEND 'a' 'b'  / TITLE='Measurement'
		ACROSS=1 LOCATION=INSIDE POSITION=NW;
RUN;


/*===== Curve Labels ==========*/
ODS GRAPHICS / RESET IMAGENAME="F8_17_";
TITLE1 "Mean Resistance and Delay by Month and Vendor";
TITLE2 "Solid Lines are Resistance, Dashed Lines are Delay";
PROC SGPLOT DATA =JES.Results_Tab;
	SERIES Y=M_Res  X=Mon / GROUP=Vendor NAME='a' 
	LINEATTRS =(PATTERN=Solid THICKNESS=3)
		LEGENDLABEL="Resistance" 
		CURVELABEL
		CURVELABELLOC=INSIDE
		CURVELABELPOS=MAX;
	SERIES Y=M_Del  X=Mon /GROUP=Vendor NAME='b' Y2AXIS
	LINEATTRS = (PATTERN=Dot THICKNESS=2)
		MARKERS
		MARKERATTRS=(COLOR=Red SIZE=10 SYMBOL=Triangle)
		LEGENDLABEL="Delay" 
		CURVELABEL
		CURVELABELLOC=INSIDE
		CURVELABELPOS=MIN;
	YAXIS  LABEL = 'Mean Resistance' 
		VALUES=(0 TO 30 BY 1)  FITPOLICY=THIN;
	Y2AXIS LABEL = 'Mean Delay' MIN=180 MAX=250 GRID;
	XAXIS  LABEL = "Month of Production" 
		 FITPOLICY=ROTATE REFTICKS;
	KEYLEGEND 'a' 'b'  / TITLE='Measurement'
		ACROSS=3 LOCATION=INSIDE POSITION=NW;
RUN;


/*===== Reference Lines ==========*/
ODS GRAPHICS / RESET IMAGENAME="F8_18_";
TITLE1 "Delay vs Resistance by Vendor: Months 10-12";
TITLE2 "Specification Limits: Resistance(12.5-22.5) Delay(150-250)";
PROC SGPLOT DATA=JES.Results_Q4;
	SCATTER Y=Delay X=Resistance / GROUP=Vendor;
	XAXIS  VALUES=(5 TO 25 BY 5);
	YAXIS  VALUES=(100 TO 350 BY 50);
	REFLINE 12.5 22.5 / AXIS=X LABEL=("LSL" "USL")
		LINEATTRS=(COLOR=Red PATTERN=Dash)
		LABELLOC=INSIDE LABELPOS=MIN;
	REFLINE 150 250 / AXIS=Y LABEL=("LSL" "USL")
		LABELLOC=OUTSIDE LABELPOS=MAX;
RUN;

/*===== Insets =====*/
ODS GRAPHICS ON / RESET IMAGENAME="F8_19_";
PROC SGPLOT DATA=JES.Results_Q4;
	SCATTER Y=Delay X=Resistance / GROUP=Vendor;
	XAXIS  VALUES=(5 TO 25 BY 5);
	YAXIS  VALUES=(100 TO 350 BY 50);
	REFLINE 12.5 22.5 / AXIS=X LABEL=("LSL" "USL")
		LINEATTRS=(COLOR=Red PATTERN=Dash)
		LABELLOC=INSIDE LABELPOS=MIN;
	REFLINE 150 250 / AXIS=Y LABEL=("LSL" "USL")
		LABELLOC=OUTSIDE LABELPOS=MAX;
	INSET ("ChiTronix"="APAC" "Duality"="EMEA" "Empirical"="AMER") / 
	BORDER TITLE="Vendor Locations" 
		POSITION=NW
        LABELALIGN=LEFT
		VALUEALIGN=RIGHT;
RUN; 

ODS GRAPHICS OFF;
ODS HTML CLOSE;
