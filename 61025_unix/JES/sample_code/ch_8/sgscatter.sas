

ODS HTML PATH="&JES.SG/S_8_5" (URL=NONE) BODY="sgscatter.html";

ODS GRAPHICS ON / RESET IMAGENAME="F8_28_";
TITLE1 "Delay vs Resistance and Process Temperature vs Date";
PROC SGSCATTER DATA=JES.Results_Q4;
	PLOT Delay*Resistance ProcessTemp*ProcessDate / 
		GROUP=Vendor
		REG=(DEGREE=2 NOGROUP);
RUN; QUIT;

ODS GRAPHICS ON / RESET IMAGENAME="F8_29_";
PROC SGSCATTER DATA=JES.Results_Q4;
	PLOT Delay*Resistance ProcessTemp*ProcessDate / 
		GROUP=Vendor
		REG=(DEGREE=2);
RUN; QUIT;

ODS GRAPHICS / RESET IMAGENAME="F8_30_";
TITLE1 "Resistance and Delay vs Process Date and Temperature";
PROC SGSCATTER DATA=JES.Results_Q4;
	PLOT (Delay Resistance) * (ProcessDate ProcessTemp) / 
	GROUP=Vendor 
	ELLIPSE=(TYPE=PREDICTED ALPHA=.05);
RUN; QUIT;

ODS GRAPHICS / RESET IMAGENAME="F8_31_";
TITLE1 "Resistance and Delay vs Process Date and Temperature";
PROC SGSCATTER DATA=JES.Results_Q4;
	COMPARE Y=(Delay Resistance) X=(ProcessDate ProcessTemp) / 
	GROUP=Vendor 
	ELLIPSE=(TYPE=PREDICTED ALPHA=.05);
RUN; QUIT;

ODS GRAPHICS / RESET IMAGENAME="F8_32_";
TITLE1 "Resistance, Delay and Process Temperature";
PROC SGSCATTER DATA=JES.Results_Q4;
	MATRIX Resistance Delay ProcessTemp / 
		GROUP=Vendor
		ELLIPSE=(TYPE=PREDICTED);
RUN; QUIT;

ODS GRAPHICS / RESET IMAGENAME="F8_33_";
PROC SGSCATTER DATA=JES.Results_Q4;
	MATRIX Resistance Delay ProcessTemp / 
		DIAGONAL=(HISTOGRAM NORMAL)
		GROUP=Vendor 
		ELLIPSE=(TYPE=MEAN ALPHA=.01);
RUN; QUIT;

ODS GRAPHICS OFF;
ODS HTML CLOSE;








