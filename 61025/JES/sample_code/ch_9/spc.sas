
GOPTIONS RESET=ALL;
ODS HTML PATH="&JES.SG/S_9" (URL=NONE) BODY="SPC.html";

/*==== Mean Chart for First 25 Batches ====*/
ODS GRAPHICS ON / RESET IMAGENAME="F9_1_";
ODS OUTPUT XCHART=Sum_Tab;
PROC SHEWHART DATA=JES.First; 
	XCHART Resistance*Batch / STDDEVIATIONS
	TESTS=1 TO 8 
	ZONELABELS TABLEALL;
RUN;

/*==== Mean Chart for Second 25 Batches ====*/
ODS GRAPHICS ON / RESET IMAGENAME="F9_2_";
PROC SHEWHART DATA=JES.Second; 
	XSCHART Resistance*Batch / STDDEVIATIONS 
	TESTS=1 TO 8 
	TABLEALL ZONELABELS;
RUN;

/*==== Box Plots for Second 25 Batches ====*/
ODS GRAPHICS ON / RESET IMAGENAME="F9_3_";
PROC SHEWHART DATA=JES.Second; 
	BOXCHART Resistance*Batch /	
	BOXCONNECT BOXSTYLE=SCHEMATICID 
	VREF=12.5 22.5 VREFLABELS='LSL' 'USL';
	ID Sample;
RUN;

/*==== Process Capability - Second 25 Batches ====*/
ODS GRAPHICS ON / RESET IMAGENAME="F9_4_";
PROC CAPABILITY DATA=JES.Second OUTTABLE=Second_Tab; 
	VAR Resistance; 
	 	SPEC TARGET=17.5 LSL=12.5 USL=22.5
			CLEFT=Red CRIGHT=Red;
	HISTOGRAM / NORMAL CFILL=GRAYD0 ;  INSET N MEAN STD CPK;
RUN;


/*==== Process Capability - Third 25 Batches ====*/
ODS GRAPHICS ON / RESET IMAGENAME="F9_5_";
PROC CAPABILITY DATA=JES.Third OUTTABLE=Third_Tab; 
	VAR Resistance; 
	 	SPEC TARGET=17.5 LSL=12.5 USL=22.5
		CLEFT=Red CRIGHT=Red;
	HISTOGRAM / NORMAL; INSET N MEAN STD CPK; 
RUN;

/*==== Mean Chart for Resistance - Third 25 Batches ====*/
ODS GRAPHICS ON / RESET IMAGENAME="F9_6_";
PROC SHEWHART HISTORY=JES.Third_Sum; 
	XCHART Resistance*Batch / STDDEVIATIONS OUTLIMITS=ResLim
	TESTS=1 TO 8 
	ZONELABELS
	TABLEALL;
RUN;

/*==== Mean Chart for Resistance - Production Samples ====*/
ODS GRAPHICS ON / RESET IMAGENAME="F9_7_";
PROC SHEWHART HISTORY=JES.Production_Sum LIMITS=ResLim; 
	XCHART Resistance*Batch / 
	TESTS=1 TO 8 
	ZONELABELS
	TABLEALL;
RUN;

/*===== P Chart for Fraction Failing - First 25 Batches =====*/
PROC MEANS DATA=JES.Production_2 NWAY NOPRINT;
	CLASS Batch;
	OUTPUT OUT=Fail_Tab N=Num_Test SUM(Fail)=Num_Fail; 
RUN;

ODS GRAPHICS ON / RESET IMAGENAME="F9_8_";
PROC SHEWHART DATA=Fail_Tab; 
	PCHART Num_Fail*Batch / SUBGROUPN=Num_Test
	P0 = .001
	PSYMBOL=P0
	ALPHA=.01;
RUN;

/*===== U Chart for Defects per Unit - First 25 Batches =====*/
PROC MEANS DATA=JES.Production_2 NWAY NOPRINT;
	CLASS Batch;
	OUTPUT OUT=Defect_Tab N=Num_Inspect SUM(Defects)=Num_Defects;
RUN;

ODS GRAPHICS ON / RESET IMAGENAME="F9_9_";
PROC SHEWHART DATA=Defect_Tab; 
	UCHART Num_Defects*Batch / SUBGROUPN=Num_Inspect
	U0=.01
	USYMBOL=U0
	ALPHA = .01;
RUN;

ODS GRAPHICS ON / RESET IMAGENAME="F9_10_";
PROC CUSUM DATA=JES.Production; 
	XCHART Resistance*Batch / 
	MU0=17.5 SIGMA0=1.5
	DELTA=1 ALPHA = .1
	VAXIS=-12 TO 8 BY 2;
RUN;

ODS GRAPHICS OFF;
ODS HTML CLOSE;





