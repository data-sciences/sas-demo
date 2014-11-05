

/*==== Delete any previously created graphics ====*/
PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;

/*==== Reset any previously set graphic options ====*/
GOPTIONS RESET=ALL BORDER; 

GOPTIONS GUNIT=PCT HTEXT=3  FTEXT='Arial' HTITLE=3; 
SYMBOL1 VALUE=dot HEIGHT=2 COLOR=green  WIDTH=2 INTERPOL=JOIN;
SYMBOL2 VALUE=square  HEIGHT=2 COLOR=red    WIDTH=2 INTERPOL=JOIN;
SYMBOL3 VALUE=plus  HEIGHT=2 COLOR=blue   WIDTH=2 INTERPOL=JOIN; 
/*======================*/
PROC GPLOT DATA =JES.Results_Tab;
	PLOT M_Res*Month=Vendor;
RUN; QUIT;

/*==== Specify a location to store graphic files ====*/
FILENAME Fig "&JES.figures/Chapter_6/";

/*===== Save the graph as a PostScript file =====*/
GOPTIONS DEVICE=GIF 
	XMAX=6IN YMAX=3.375IN 
	GSFNAME=Fig 
	GSFMODE=REPLACE;   
 
PROC GPLOT DATA =JES.Results_Tab;
	PLOT M_Res*Month=Vendor / NAME="F6_3_";
RUN; QUIT;


/*===== Save the graph as a PostScript file =====*/
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=3.375IN 
	GSFNAME=Fig GSFMODE=REPLACE;   

PROC GPLOT DATA =JES.Results_Tab;
	PLOT M_Res*Month=Vendor / NAME="F6_4_";
RUN; QUIT;

