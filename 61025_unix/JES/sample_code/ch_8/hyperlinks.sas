

DATA Results_Tab; SET JES.Results_Tab;
	Point_Link=CATS('../../ods_output/page4/',Vendor,'.html');
RUN;

ODS HTML PATH="&JES.SG/S_8_3" (URL=NONE) BODY="hyperlinks.html";
ODS GRAPHICS ON / RESET IMAGENAME="F8_H_" IMAGEMAP=YES;

TITLE1 "Mean Resistance by Vendor";
PROC SGPLOT DATA =Results_Tab;	
	SERIES Y=M_Res X=Mon / GROUP=Vendor URL=Point_Link
	LINEATTRS = (PATTERN=SOLID THICKNESS=2)
		MARKERS
		MARKERATTRS=( SIZE=10 );
	YAXIS  LABEL = 'Mean Resistance' 
		VALUES=(0 TO 30 BY 1)  FITPOLICY=THIN;
	XAXIS  LABEL="Month of Production" 
		 FITPOLICY=ROTATE REFTICKS;
RUN; QUIT;

ODS GRAPHICS OFF;
ODS HTML CLOSE;

