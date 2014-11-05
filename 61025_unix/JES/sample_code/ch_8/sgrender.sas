


PROC TEMPLATE;
	DEFINE STATGRAPH mygraph.hist;
	MVAR Var1 Var2;
	BEGINGRAPH;
		ENTRYTITLE "Study of " Var1 " Measurements";
		LAYOUT LATTICE / COLUMNS=2 ROWS=2 ROWGUTTER=5px;
			SCATTERPLOT X=Var1 Y=Var2 / GROUP=Vendor;
			LAYOUT OVERLAY;
				HISTOGRAM Var1;
				DENSITYPLOT Var1;
			ENDLAYOUT; 
			SCATTERPLOT X=Var1 Y=ProcessTemp / GROUP=Vendor;				
			BOXPLOT Y=Var1 X=Class / ORIENT=HORIZONTAL;
		ENDLAYOUT;
	ENDGRAPH;
	END;
RUN;


ODS HTML PATH="&JES.SG/S_8_6" (URL=NONE) BODY="sgrender.html";
%LET Var1=Resistance; %LET Var2=Delay; 
ODS GRAPHICS ON / RESET IMAGENAME="F8_34_";
PROC SGRENDER DATA=JES.Results_Q4
	TEMPLATE="mygraph.hist";
	LABEL Resistance="Resistance" Delay="Delay" Vendor="Vendor";
RUN;
%LET Var1=Delay; %LET Var2=resistance; 
ODS GRAPHICS / RESET IMAGENAME="F8_35_";
PROC SGRENDER DATA=JES.Results_Q4
	TEMPLATE="mygraph.hist";
	LABEL Resistance="Resistance" Delay="Delay" Vendor="Vendor";
RUN;

ODS GRAPHICS OFF;
ODS HTML CLOSE;







