


ODS HTML PATH="&JES.SG/S_8_3" (URL=NONE) BODY="conlim_sg.html";

/*===== Normal Confidence Limits with an HLINE Statement =====*/
ODS GRAPHICS ON / RESET IMAGENAME="F8_23_";
TITLE "Resistance by Vendor - Month 1";
PROC SGPLOT DATA=JES.Results(WHERE=(Month=1));
	HLINE Vendor /RESPONSE=Resistance  
		STAT=MEAN 
		LIMITS=BOTH 
		LIMITSTAT=CLM 
		ALPHA=0.10
		MARKERS 
		DATALABEL;
	    XAXIS VALUES=(10 TO 26 BY 2);
		REFLINE 12.5 22.5 / 
			AXIS=X 
			LABEL=("Lower Limit" "Upper Limit")
			LABELLOC=INSIDE LABELPOS=MIN;
RUN; 

/*===== Normal Confidence Limits with a SCATTER Statement======*/
ODS GRAPHICS / RESET IMAGENAME="F8_24_";
PROC SGPLOT DATA=JES.Results_Tab(WHERE=(Month=1));
	SCATTER Y=Vendor X=M_Res / 
		XERRORLOWER=R_L
		XERRORUPPER=R_U
		LEGENDLABEL="Resistance(Mean), 90% Confidence Limits";
	SERIES Y=Vendor X=M_Res / DATALABEL=M_Res
		LEGENDLABEL=" ";
	XAXIS VALUES=(10 TO 26 BY 2);
	REFLINE 12.5 22.5 / AXIS=X LABEL=("Lower Limit" "Upper Limit")
	LABELLOC=INSIDE LABELPOS=MAX;
RUN;


DATA Tab; SET JES.Results_Tab(WHERE=(Month=1));
	Text=".              N="||TRIM(LEFT(PUT(N,8.0)))||
	" Mean="||TRIM(LEFT(PUT(M_Res,8.2)));
RUN;

ODS GRAPHICS / RESET IMAGENAME="F8_25_";
PROC SGPLOT DATA=Tab;
	SCATTER Y=Vendor X=M_Res /  DATALABEL=Text
		XERRORLOWER=R_L
		XERRORUPPER=R_U;
	SERIES Y=Vendor X=M_Res;
	XAXIS VALUES=(10 TO 26 BY 2);
	REFLINE 12.5 22.5 / AXIS=X LABEL=("Lower Limit" "Upper Limit")
		LABELLOC=OUTSIDE LABELPOS=MAX;
RUN; 

/*===== Poisson Confidence Limits with a SCATTER Statement =====*/
DATA Tab_3; SET JES.Results_Tab(WHERE=(Vendor="ChiTronix"));
	FORMAT LCL UCL 8.3;
	IF N_Def>0 THEN LCL = CINV(.10, 2*N_Def)/(2*N);
	UCL = CINV(.90, 2*(N_Def+1))/(2*N);
	KEEP Mon N N_Def M_Def LCL UCL;
RUN;

ODS GRAPHICS / RESET IMAGENAME="F8_26_";
TITLE "Monthly Defect Rates ChiTronix - 2008";
PROC SGPLOT DATA=Tab_3;
	SCATTER X=Mon Y=M_Def / NAME='a'
		YERRORLOWER=LCL
		YERRORUPPER=UCL 
		MARKERATTRS =(Color=Green SYMBOL=CircleFilled)
		LEGENDLABEL="Mean Defect Rate with 90% Confidence Limits";
	SERIES X=Mon Y=M_Def / 
		DATALABEL=M_Def;
	REFLINE 2 / AXIS=Y 
		LABEL="Spec Limit"
		LABELLOC=INSIDE
		LABELPOS=MIN
		LINEATTRS=(COLOR=Red PATTERN=Dash);
	YAXIS LABEL='Defect Rate' VALUES = (0 TO 3 BY .5);
	XAXIS DISPLAY=(NOLABEL);
	KEYLEGEND 'a' / LOCATION=INSIDE POSITION=N;
RUN;



/*===== Confidence Limits Based on the Normal Approximation to the Poisson =====*/
ODS GRAPHICS ON / RESET IMAGENAME="F8_26a_";
PROC SGPLOT DATA=JES.Results(WHERE=(Vendor="ChiTronix"));
	VLINE Mon /RESPONSE=Defects  
		STAT=MEAN 
		LIMITS=BOTH 
		LIMITSTAT=CLM 
		ALPHA=0.10
		MARKERS 
		DATALABEL;
		FORMAT Defects 8.2;
	    XAXIS VALUES=(0 TO 3 BY .5);
		REFLINE 2 / AXIS=Y 
			LABEL="Spec Limit"
			LABELLOC=INSIDE
			LABELPOS=MIN
			LINEATTRS=(COLOR=Red PATTERN=Dash);
RUN;

ODS GRAPHICS OFF;
ODS HTML CLOSE;
