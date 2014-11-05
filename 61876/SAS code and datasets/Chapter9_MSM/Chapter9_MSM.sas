 /*-------------------------------------------------------------------*/
 /*      Analysis of Observational Health Care Data Using SAS         */
 /*           by Faries, Leon, Haro, and Obenchain                    */
 /*                                                                   */
 /*       Copyright 2010 by SAS Institute Inc., Cary, NC, USA         */
 /*                        ISBN 978-1-60764-227-5                     */
 /*                                                                   */
 /*-------------------------------------------------------------------*/

  *********************************************************************;
  * This code performs a Marginal Structural Model analysis utilizing *;
  * dataset MSMADAT.  This code is the same as provided in Chapter 9  *;
  * 'Analysis of Longitudinal Obsersvational Data Using Marginal      *;
  * Structural Models.'  The variable names differ from the code in   *;
  * Chapter 9 in order to run for the provided example (simulated)    *;
  * dataset MSMADAT. Dataset MSMADAT must be stored in the location   *;
  * listed in the LIBNAME statement or the LIBNAME changed accordingly*;  
  *********************************************************************;

LIBNAME IN 'D:/TEMP';
  
DATA MSMADAT;
  SET IN.MSMADAT;


/* This section of code computes the treatment selection and censoring weights. This is accomplished in 4 steps:     
1) multinomial model to compute numerator of treatment selection weights;   
2) multinomial model to compute denominator of treatment selection weights;  
3) binomial model to compute numerator of censoring adjustment weights; 
4) binomial model to compute denominator of censoring adjustment weights.            */

/* treatment selection weights:  numerator calculation 
(probability of treatment using only baseline covariates) */
	    
PROC LOGISTIC DATA = MSMADAT;
  CLASS VIS PR_TRT B_X1 B_X3; 
  MODEL TRT = VIS PR_TRT B_X1 B_X2 B_X3 B_X4 
    /LINK=GLOGIT;
  OUTPUT OUT=PREDTRT0 PRED=PREDTRT0;
run;
     
/* treatment selection weights:  denominator calculation 
(probability of treatment with baseline covariates and time-dependent covariates) */
	    
PROC LOGISTIC DATA = MSMADAT;
  CLASS VIS PR_TRT B_X1 B_X3 PR_X1 PR_X3; 
  MODEL TRT = VIS PR_TRT B_X1 B_X2 B_X3 B_X4 PR_X1 PR_X2 PR_X3 PR_X4 
    /LINK=GLOGIT;
  OUTPUT OUT=PREDTRT1 PRED=PREDTRT1;
run;
    
 
/* censoring adjustment weights:  numerator calculation 
(probability of censoring using only baseline covariates) */
	   
ODS LISTING EXCLUDE OBSTATS;
PROC GENMOD DATA = MSMADAT;
  CLASS PATSC VIS TRT B_X1 B_X3;
  MODEL CFLAG = VIS TRT B_X1 B_X2 B_X3 B_X4 
    /DIST = BIN LINK = LOGIT TYPE3 OBSTATS;
  REPEATED SUBJECT = PATSC / TYPE = EXCH;
  ODS OUTPUT OBSTATS = PREDCEN0(RENAME=(PRED=PREDCEN0));
RUN;
ODS LISTING SELECT ALL;
     
/* censoring adjustment weights:  denominator calculation 
(probability of censoring using baseline covariates and time-dependent covariates) */
	  
ODS LISTING EXCLUDE OBSTATS;
PROC GENMOD DATA = MSMADAT;
  CLASS PATSC VIS TRT B_X1 B_X3 X1 X3;
  MODEL CFLAG = VIS TRT B_X1 B_X2 B_X3 B_X4 X1 X2 X3 X4 
    /DIST = BIN LINK = LOGIT TYPE3 OBSTATS;
  REPEATED SUBJECT = PATSC / TYPE = EXCH;
  ODS OUTPUT OBSTATS = PREDCEN1(RENAME=(PRED=PREDCEN1));
RUN;
ODS LISTING SELECT ALL;
         
/* This section of code performs the steps necessary to merge the output from the weight models (Program 9.1) to allow for computation of a single adjustment for each observation in the analysis data set (stabilized weight).  This is followed by code to produce summaries of the final weights.    */
       
PROC SQL;
	   
  /*ratio of probabilities for treatment*/
	   
  CREATE TABLE PREDTRT AS
    SELECT *,PREDTRT0/PREDTRT1 AS PREDTRT
    FROM PREDTRT1(KEEP=PATSC VIS PREDTRT1)
         NATURAL FULL JOIN
         PREDTRT0(KEEP=PATSC VIS PREDTRT0)
    ORDER PATSC,VIS
  ;     
  /*ratio of probabilities for censoring*/
	    
  CREATE TABLE PREDCEN AS
    SELECT *,PREDCEN0/PREDCEN1 AS PREDCEN
    FROM (SELECT INPUT(PATSC,BEST.) AS PATSC, INPUT(VIS,BEST.) AS VIS, PREDCEN0 FROM PREDCEN0)
         NATURAL FULL JOIN
         (SELECT INPUT(PATSC,BEST.) AS PATSC, INPUT(VIS,BEST.) AS VIS, PREDCEN1 FROM PREDCEN1)
    ORDER PATSC,VIS;
QUIT;
       
/*calculate stabilized weight*/
	   
PROC SORT DATA=MSMADAT OUT=WEIGHTS;
  BY PATSC VIS;
RUN;

DATA WEIGHTS;
  MERGE WEIGHTS PREDTRT PREDCEN; 
  BY PATSC VIS;
  VWT=PREDTRT*PREDCEN;
  IF FIRST.PATSC THEN STABWT=VWT;   
                 ELSE STABWT=VWT*DUM;
  RETAIN DUM;
  DROP DUM;
  DUM=STABWT;
RUN;
      
/*diagnostic plot for weights*/
	 
PROC SORT DATA = WEIGHTS; 
  BY VIS; 
RUN;

ODS RTF FILE="%SYSFUNC(PATHNAME(WORK))\FIG1.RTF";

FILENAME FIGURE "%SYSFUNC(PATHNAME(WORK))\SASGRAPH.EMF";

GOPTIONS RESET=ALL TARGET=SASEMF DEVICE=SASEMF FTEXT=DUPLEX HTEXT=.75
   CBACK=WHITE XMAX=6IN XPIXELS=1200 YMAX=5IN YPIXELS=1000 
   GSFNAME=FIGURE GSFMODE=REPLACE;

SYMBOL1 COLOR=BLACK INTERPOL=JOIN
        WIDTH=2 VALUE=SQUARE
        HEIGHT=1;

AXIS1 MINOR = NONE COLOR = BLACK LABEL=("STABILIZED WEIGHT" ANGLE=90 ROTATE=0);

PROC BOXPLOT DATA=WEIGHTS;
  PLOT STABWT*VIS / CFRAME = WHITE   
                    CBOXES = DAGR
                    CBOXFILL = WHITE
                    VAXIS = AXIS1;
  TITLE "SUMMARY OF VISITWISE WEIGHT VALUES";
  TITLE2 "(box and whiskers: min, 1st quartile, median, 3rd quartile, max; square: mean)";
RUN;

GOPTIONS RESET=ALL;

ODS RTF CLOSE;


/*final analysis model*/
   
PROC GENMOD DATA = WEIGHTS;
  CLASS VIS PATSC INVSC TRT;
  WEIGHT STABWT;
  MODEL CAVAR = INVSC BAVAR VIS TRT VIS*TRT
                / DIST=NORMAL LINK=ID TYPE3;
  REPEATED SUBJECT = PATSC / TYPE=EXCH;
  LSMEANS TRT VIS*TRT / PDIFF;
  TITLE 'MSM FINAL ANALYSIS MODEL';
  ODS OUTPUT LSMEANS=LSMEANS;
RUN;
       
/*LS means plot for the final model*/
   
PROC SQL;
  CREATE TABLE LSMEANS3 AS
    SELECT TRT, VIS, MEAN(ESTIMATE) AS ESTIMATE
    FROM LSMEANS
    GROUP TRT, VIS
  ;
QUIT;

ODS RTF FILE="%SYSFUNC(PATHNAME(WORK))\FIG2.RTF";

FILENAME FIGURE "%SYSFUNC(PATHNAME(WORK))\SASGRAPH.EMF";

GOPTIONS RESET=ALL TARGET=SASEMF DEVICE=SASEMF FTEXT=DUPLEX HTEXT=.75 CBACK=WHITE 
         XMAX=6IN XPIXELS=1200 YMAX=5IN YPIXELS=1000 GSFNAME=FIGURE GSFMODE=REPLACE;

AXIS1 MINOR = NONE COLOR = BLACK LABEL=(ANGLE=90 ROTATE=0 "CHANGE IN BPRS TOTAL SCORE");

SYMBOL1 I=JOIN W=2 L=1 C=RED   V=SQUARE;
SYMBOL2 I=JOIN W=2 L=2 C=BLACK V=CIRCLE;

PROC GPLOT DATA=LSMEANS3;
  PLOT ESTIMATE*VIS=TRT/VAXIS=AXIS1;
  TITLE "MSM ESTIMATED MEAN CHANGE FROM BASELINE BPRS SCORES";
  LABEL VIS="VISIT";
  LABEL TRT="TREATMENT";
RUN;

GOPTIONS RESET=ALL;

ODS RTF CLOSE;

     
