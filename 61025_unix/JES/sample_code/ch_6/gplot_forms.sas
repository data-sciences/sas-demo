


/*==== Delete any previously created graphics 
PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT; ====*/

/*==== Specify a location to store graphic files ====*/
FILENAME Fig "&JES.figures/Chapter_6/";

/*==== Reset any previously set graphic options ====*/
GOPTIONS RESET=ALL BORDER; 

/*===== Uncomment this line to save output to a postscript file  
GOPTIONS DEVICE=PSLEPSFC XMAX=6IN YMAX=4IN GSFNAME=Fig GSFMODE=REPLACE;  ===*/ 

 
GOPTIONS GUNIT=PCT HTEXT=3  FTEXT='Arial' HTITLE=3; 
SYMBOL1 VALUE=dot HEIGHT=2 COLOR=green  WIDTH=2 INTERPOL=NONE;

/*==== Form 1: Simple Y vs X =======*/
PROC GPLOT DATA =JES.Results_Tab;
	PLOT M_Res*Month 
	/ NAME="F6_5_";
RUN; QUIT;


/*==== Form 2: Y vs X for each value of Z - On separate plots=======*/
PROC GPLOT DATA =JES.Results_Tab; 
	BY Vendor;	
	PLOT M_Res*Month / NAME="F6_6_";
RUN; QUIT;

/*==== Form 3: Y vs X for each value of Z - On same plot===== ==*/
SYMBOL1 VALUE=dot    HEIGHT=2 COLOR=green  WIDTH=2 INTERPOL=JOIN;
SYMBOL2 VALUE=square HEIGHT=2 COLOR=red    WIDTH=2 INTERPOL=JOIN;
SYMBOL3 VALUE=plus   HEIGHT=2 COLOR=blue   WIDTH=2 INTERPOL=JOIN; 
PROC GPLOT DATA =JES.Results_Tab;	
	PLOT M_Res*Month=Vendor 
	/ NAME="F6_7_";
RUN; QUIT;


/*==== Form 4: Y1, Y2 vs X - same Y axis =======*/
PROC GPLOT DATA =JES.Results_Tab(WHERE=(Vendor="ChiTronix")); 
	PLOT (M_Res M_Del)*Month / NAME="F6_8_" OVERLAY;
RUN; QUIT;

PROC GPLOT DATA =JES.Results_Tab(WHERE=(Vendor="ChiTronix")); 
	PLOT Month*(M_Res M_Del) / NAME="F6_A_" OVERLAY;
RUN; QUIT;


/*==== Form 5: Y1, Y2 vs X - different Y axes =======*/

PROC GPLOT DATA =JES.Results_Tab(WHERE=(Vendor="ChiTronix")); 
	PLOT M_Res*Month / NAME="F6_9_";
	PLOT2 M_Del*Month;
RUN; QUIT;

/*===You cannot plot against 2 different X axes
	This code results in an error message
PROC GPLOT DATA =JES.Results_Tab(WHERE=(Vendor="ChiTronix")); 
	PLOT  Month*M_Res / NAME="F6_X_";
	PLOT2 Month*M_Del;
RUN; QUIT;
=============================================*/



/*==== Form 3 & 5 ===================================*/
SYMBOL4 VALUE=dot    HEIGHT=2 COLOR=green  WIDTH=2 INTERPOL=JOIN LINE=2;
SYMBOL5 VALUE=square HEIGHT=2 COLOR=red    WIDTH=2 INTERPOL=JOIN LINE=2;
SYMBOL6 VALUE=plus   HEIGHT=2 COLOR=blue   WIDTH=2 INTERPOL=JOIN LINE=2; 
PROC GPLOT DATA =JES.Results_Tab; 
	PLOT  M_Res*Month = Vendor / NAME="F6_10_";
	PLOT2 M_Del*Month = Vendor;
RUN; QUIT;

/*==== Form 4 & 5 ===================================*/
SYMBOL1 VALUE=dot HEIGHT=2 COLOR=green  WIDTH=2 INTERPOL=JOIN;
SYMBOL2 VALUE=dot  HEIGHT=2 COLOR=green  WIDTH=2 INTERPOL=JOIN LINE=2;
SYMBOL3 VALUE=dot HEIGHT=2 COLOR=green  WIDTH=2 INTERPOL=JOIN LINE=2; 
SYMBOL4 VALUE=square HEIGHT=2 COLOR=red WIDTH=2 INTERPOL=JOIN;
SYMBOL5 VALUE=square HEIGHT=2 COLOR=red WIDTH=2 INTERPOL=JOIN LINE=2;
SYMBOL6 VALUE=square HEIGHT=2 COLOR=red WIDTH=2 INTERPOL=JOIN LINE=2;

PROC GPLOT DATA =JES.Results_Tab(WHERE=(Vendor="ChiTronix"));  
	PLOT  (M_Res R_L R_U)*Month / NAME="F6_11_" OVERLAY;
	PLOT2 (M_Del D_L D_U)*Month / OVERLAY;
RUN; QUIT; 


/*==== Form 3 & 4  =======*/
/* This does not work as you might expect -
   It plots M_Res and M_Del on two separate graphs 
	  */
PROC GPLOT DATA =JES.Results_Tab; 
	PLOT (M_Res M_Del)*Month=Vendor / NAME="F6_B_" OVERLAY;
RUN; QUIT;


