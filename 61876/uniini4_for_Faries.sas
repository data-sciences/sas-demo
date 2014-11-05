OPTIONS NOCENTER LINESIZE=120 PAGESIZE=64 ;
TITLE1 'Performing Propensity Adjusted Grouped-Time Survival Analysis with NLMIXED';

Title2 "Propensity Analysis for Binary tx";
/* Binary LOGISTIC RANDOM-INTERCEPT MODEL */

Data data1;
	SET "D:\CDS_CL\CDS SAS Chapter_Uni0Vs234\SAS Code\uniint.sas7bdat";
	IF (surv <=7) THEN surv2 = surv;
	ElSE IF (surv > 7) THEN surv2 = 7;


PROC NLMIXED;
PARMS b0=0 b1=0 b2=0 b3=0 b4=0 b5=0 b6=0 b7=0 b8=0 b9=0 b10=0 b11=0 b12=0 b13=0 b14=0 sd=1;
z = b0 + b1*meanpsr + b2*colgrad + b3*somecol + b4*highsch + b5*site1 + b6*site3 + b7*site6 + b8*site7 + b9*agelt30 + b10*age40t49 + b11*age50t59
		+ b12*agege60 + b13*symdec + b14*syminc + sd*u;
IF (tx=0) THEN 
  p = 1 - (1/(1 + EXP(-z)));
ELSE IF (tx=1) THEN
  p = 1 / (1 + EXP(-z));
like = LOG(p);
MODEL tx ~ GENERAL(like);
RANDOM u ~ NORMAL(0,1) SUBJECT=id;
PREDICT z OUT=zest;
ESTIMATE 'ICC' sd*sd/((((ATAN(1)*4)**2)/3)+sd*sd);
RUN;


OPTIONS LINESIZE=80;

/* Generate QUINTILE values (0 to 4) based on estimates from above model */
DATA data2 (Keep = id event tx meanpsr colgrad somecol highsch site1 site3 site6 site7 agelt30 age40t49 age50t59 agege60 symdec syminc  agecat edu traject surv2 pred ppred);
MERGE data1 zest; 

/* Convert to probability scale */
ppred = 1 / (1 + EXP(-pred));

PROC RANK GROUPS=5 OUT=rankout;
     VAR ppred;
     RANKS QUINT;

DATA ALL; SET rankout;
q1=0;q2=0;q3=0;q4=0;
if quint eq 1 then q1 = 1;
if quint eq 2 then q2 = 1;
if quint eq 3 then q3 = 1;
if quint eq 4 then q4 = 1;

/* Table of Quintile by tx */
PROC FREQ; 
TABLES tx*QUINT QUINT*event*tx*surv2;
RUN;

Title2 "Analysis for Grouped-Time Survival - QUINTILE SPECIFIC ANALYSES";
/* Binary Complementary Log-Log RANDOM-INTERCEPT MODEL with censoring */
PROC SORT; BY QUINT ID;
PROC NLMIXED;
PARMS b0=0 b1=0 sd=1 t2=1 t3=1.25 t4=1.5 t5=1.75 t6=2 t7=2.25;
ODS OUTPUT ParameterEstimates=estb;
z = b0 + b1*tx + sd*u;
IF (event = 1) THEN  
DO;                                     /* event occurred */
  IF (surv2=1) THEN 
    p = 1 - EXP(0 - EXP(0+z));
  ELSE IF (surv2=2) THEN
    p = (1 - EXP(0 - EXP(t2+z))) -  (1 - EXP(0 - EXP(0+z)));
  ELSE IF (surv2=3) THEN
    p = (1 - EXP(0 - EXP(t3+z))) -  (1 - EXP(0 - EXP(t2+z)));
  ELSE IF (surv2=4) THEN
    p = (1 - EXP(0 - EXP(t4+z))) -  (1 - EXP(0 - EXP(t3+z)));
  ELSE IF (surv2=5) THEN
    p = (1 - EXP(0 - EXP(t5+z))) -  (1 - EXP(0 - EXP(t4+z)));
  ELSE IF (surv2=6) THEN
    p = (1 - EXP(0 - EXP(t6+z))) -  (1 - EXP(0 - EXP(t5+z)));
  ELSE IF (surv2=7) THEN
    p = (1 - EXP(0 - EXP(t7+z))) -  (1 - EXP(0 - EXP(t6+z)));
END;
IF (event = 0) THEN  
DO;                      /* event did not occur - censored */
  IF (surv2=1) THEN 
    p = 1 - (1 - EXP(0 - EXP(0+z)));
  ELSE IF (surv2=2) THEN
    p = 1 - (1 - EXP(0 - EXP(t2+z)));
  ELSE IF (surv2=3) THEN
    p = 1 - (1 - EXP(0 - EXP(t3+z)));
  ELSE IF (surv2=4) THEN
    p = 1 - (1 - EXP(0 - EXP(t4+z)));
  ELSE IF (surv2=5) THEN
    p = 1 - (1 - EXP(0 - EXP(t5+z)));
  ELSE IF (surv2=6) THEN
    p = 1 - (1 - EXP(0 - EXP(t6+z)));
  ELSE IF (surv2=7) THEN
    p = 1 - (1 - EXP(0 - EXP(t7+z)));
END;
like = LOG(p);
MODEL surv2 ~ GENERAL(like);
RANDOM u ~ NORMAL(0,1) SUBJECT=id;
ESTIMATE 'ICC' sd*sd/((((ATAN(1)*4)**2)/6)+sd*sd);
BY QUINT;
RUN;

/* Generate pooled results based on results from the above quintile-specific models */
DATA estw; SET estb;
w = 1 / StandardError**2;
west = Estimate*w;

PROC SORT; BY Parameter;

PROC MEANS NOPRINT; CLASS Parameter; VAR west w; 
OUTPUT OUT=sums SUM = sumwest sumw;

DATA poolest; SET sums; IF _TYPE_ EQ 1;
poolest = sumwest / sumw;
poolse  = 1 / sqrt(sumw);
poolz   = poolest / poolse;
poolp   = 2*(1 - probnorm(abs(poolz)));

/* Print the pooled results */
PROC PRINT;
VAR Parameter poolest poolse poolz poolp;
RUN;


/* now run 3 models, the unadjusted model, the model with quintiles, and the model with quintile by tx interactions, 
   to determine if pooling over quintiles is reasonable */

PROC SORT DATA=ALL; BY ID;
RUN;

Title2 "Analysis for Grouped-Time Survival - ALL subjects - unadjusted";
/* Binary Complementary Log-Log RANDOM-INTERCEPT MODEL with censoring   */
PROC NLMIXED;
PARMS b0=0 b1=0 sd=1 t2=1 t3=1.25 t4=1.5 t5=1.75 t6=2 t7=2.25;
z = b0 + b1*tx + sd*u;
IF (event = 1) THEN  
DO;                                     /* event occurred */
  IF (surv2=1) THEN 
    p = 1 - EXP(0 - EXP(0+z));
  ELSE IF (surv2=2) THEN
    p = (1 - EXP(0 - EXP(t2+z))) -  (1 - EXP(0 - EXP(0+z)));
  ELSE IF (surv2=3) THEN
    p = (1 - EXP(0 - EXP(t3+z))) -  (1 - EXP(0 - EXP(t2+z)));
  ELSE IF (surv2=4) THEN
    p = (1 - EXP(0 - EXP(t4+z))) -  (1 - EXP(0 - EXP(t3+z)));
  ELSE IF (surv2=5) THEN
    p = (1 - EXP(0 - EXP(t5+z))) -  (1 - EXP(0 - EXP(t4+z)));
  ELSE IF (surv2=6) THEN
    p = (1 - EXP(0 - EXP(t6+z))) -  (1 - EXP(0 - EXP(t5+z)));
  ELSE IF (surv2=7) THEN
    p = (1 - EXP(0 - EXP(t7+z))) -  (1 - EXP(0 - EXP(t6+z)));
END;
IF (event = 0) THEN  
DO;                      /* event did not occur - censored */
  IF (surv2=1) THEN 
    p = 1 - (1 - EXP(0 - EXP(0+z)));
  ELSE IF (surv2=2) THEN
    p = 1 - (1 - EXP(0 - EXP(t2+z)));
  ELSE IF (surv2=3) THEN
    p = 1 - (1 - EXP(0 - EXP(t3+z)));
  ELSE IF (surv2=4) THEN
    p = 1 - (1 - EXP(0 - EXP(t4+z)));
  ELSE IF (surv2=5) THEN
    p = 1 - (1 - EXP(0 - EXP(t5+z)));
  ELSE IF (surv2=6) THEN
    p = 1 - (1 - EXP(0 - EXP(t6+z)));
  ELSE IF (surv2=7) THEN
    p = 1 - (1 - EXP(0 - EXP(t7+z)));
END;
like = LOG(p);
MODEL surv2 ~ GENERAL(like);
RANDOM u ~ NORMAL(0,1) SUBJECT=id;
ESTIMATE 'ICC' sd*sd/((((ATAN(1)*4)**2)/6)+sd*sd);
RUN;


Title2 "Analysis for Grouped-Time Survival - ALL subjects - all QUINTILES main effects";
/* Binary Complementary Log-Log RANDOM-INTERCEPT MODEL with censoring   */
PROC NLMIXED;
PARMS b0=0 b1=0 b2=0 b3=0 b4=0 b5=0  sd=1  
      t2=1 t3=1.25 t4=1.5 t5=1.75 t6=2 t7=2.25;
z = b0 + b1*tx + b2*q1 + b3*q2 + b4*q3 + b5*q4 + sd*u;
IF (event = 1) THEN  
DO;                                     /* event occurred */
  IF (surv2=1) THEN 
    p = 1 - EXP(0 - EXP(0+z));
  ELSE IF (surv2=2) THEN
    p = (1 - EXP(0 - EXP(t2+z))) -  (1 - EXP(0 - EXP(0+z)));
  ELSE IF (surv2=3) THEN
    p = (1 - EXP(0 - EXP(t3+z))) -  (1 - EXP(0 - EXP(t2+z)));
  ELSE IF (surv2=4) THEN
    p = (1 - EXP(0 - EXP(t4+z))) -  (1 - EXP(0 - EXP(t3+z)));
  ELSE IF (surv2=5) THEN
    p = (1 - EXP(0 - EXP(t5+z))) -  (1 - EXP(0 - EXP(t4+z)));
  ELSE IF (surv2=6) THEN
    p = (1 - EXP(0 - EXP(t6+z))) -  (1 - EXP(0 - EXP(t5+z)));
  ELSE IF (surv2=7) THEN
    p = (1 - EXP(0 - EXP(t7+z))) -  (1 - EXP(0 - EXP(t6+z)));
END;
IF (event = 0) THEN  
DO;                      /* event did not occur - censored */
  IF (surv2=1) THEN 
    p = 1 - (1 - EXP(0 - EXP(0+z)));
  ELSE IF (surv2=2) THEN
    p = 1 - (1 - EXP(0 - EXP(t2+z)));
  ELSE IF (surv2=3) THEN
    p = 1 - (1 - EXP(0 - EXP(t3+z)));
  ELSE IF (surv2=4) THEN
    p = 1 - (1 - EXP(0 - EXP(t4+z)));
  ELSE IF (surv2=5) THEN
    p = 1 - (1 - EXP(0 - EXP(t5+z)));
  ELSE IF (surv2=6) THEN
    p = 1 - (1 - EXP(0 - EXP(t6+z)));
  ELSE IF (surv2=7) THEN
    p = 1 - (1 - EXP(0 - EXP(t7+z)));
END;
like = LOG(p);
MODEL surv2 ~ GENERAL(like);
RANDOM u ~ NORMAL(0,1) SUBJECT=id;
ESTIMATE 'ICC' sd*sd/((((ATAN(1)*4)**2)/6)+sd*sd);
RUN;


Title2 " Analysis for Grouped-Time Survival - ALL subjects - all QUINTILES main effects and interactions";
/* Binary Complementary Log-Log RANDOM-INTERCEPT MODEL with censoring    */
PROC NLMIXED;
PARMS b0=0 b1=0 b2=0 b3=0 b4=0 b5=0 b6=0 b7=0  b8=0 b9=0 sd=1  
      t2=1 t3=1.25 t4=1.5 t5=1.75 t6=2 t7=2.25;
z = b0 + b1*tx + b2*q1 + b3*q2 + b4*q3 + b5*q4 
       + b6*tx*q1 + b7*tx*q2 + b8*tx*q3 + b9*tx*q4 + sd*u;
IF (event = 1) THEN  
DO;                                     /* event occurred */
  IF (surv2=1) THEN 
    p = 1 - EXP(0 - EXP(0+z));
  ELSE IF (surv2=2) THEN
    p = (1 - EXP(0 - EXP(t2+z))) -  (1 - EXP(0 - EXP(0+z)));
  ELSE IF (surv2=3) THEN
    p = (1 - EXP(0 - EXP(t3+z))) -  (1 - EXP(0 - EXP(t2+z)));
  ELSE IF (surv2=4) THEN
    p = (1 - EXP(0 - EXP(t4+z))) -  (1 - EXP(0 - EXP(t3+z)));
  ELSE IF (surv2=5) THEN
    p = (1 - EXP(0 - EXP(t5+z))) -  (1 - EXP(0 - EXP(t4+z)));
  ELSE IF (surv2=6) THEN
    p = (1 - EXP(0 - EXP(t6+z))) -  (1 - EXP(0 - EXP(t5+z)));
  ELSE IF (surv2=7) THEN
    p = (1 - EXP(0 - EXP(t7+z))) -  (1 - EXP(0 - EXP(t6+z)));
END;
IF (event = 0) THEN  
DO;                      /* event did not occur - censored */
  IF (surv2=1) THEN 
    p = 1 - (1 - EXP(0 - EXP(0+z)));
  ELSE IF (surv2=2) THEN
    p = 1 - (1 - EXP(0 - EXP(t2+z)));
  ELSE IF (surv2=3) THEN
    p = 1 - (1 - EXP(0 - EXP(t3+z)));
  ELSE IF (surv2=4) THEN
    p = 1 - (1 - EXP(0 - EXP(t4+z)));
  ELSE IF (surv2=5) THEN
    p = 1 - (1 - EXP(0 - EXP(t5+z)));
  ELSE IF (surv2=6) THEN
    p = 1 - (1 - EXP(0 - EXP(t6+z)));
  ELSE IF (surv2=7) THEN
    p = 1 - (1 - EXP(0 - EXP(t7+z)));
END;
like = LOG(p);
MODEL surv2 ~ GENERAL(like);
RANDOM u ~ NORMAL(0,1) SUBJECT=id;
ESTIMATE 'ICC' sd*sd/((((ATAN(1)*4)**2)/6)+sd*sd);
RUN;


Title2 "Compare the treatment groups on PSR using quintile adjustment";
/*Linear random intercept model*/
PROC SORT DATA=ALL; BY QUINT ID;

PROC MIXED data=ALL;
ODS OUTPUT SolutionF=estc1;
MODEL meanpsr = tx / S;
RANDOM INTERCEPT / SUB=id;
BY QUINT;
RUN;

/* Generate pooled results based on results from the above quintile-specific models */
DATA estw1; SET estc1;
w = 1 / StdErr**2;
west = Estimate*w;

PROC SORT; BY Effect;

PROC MEANS NOPRINT; CLASS Effect; VAR west w; 
OUTPUT OUT=sums1 SUM = sumwest sumw;

DATA poolest1; SET sums1; IF _TYPE_ EQ 1;
poolest = sumwest / sumw;
poolse  = 1 / sqrt(sumw);
poolz   = poolest / poolse;
poolp   = 2*(1 - probnorm(abs(poolz)));

/* Print the pooled results */
PROC PRINT;
VAR Effect poolest poolse poolz poolp;
RUN;

Title2 "Compare the treatment groups on PSR using unadjusted model";
PROC SORT DATA=ALL; BY ID;
RUN;
PROC MIXED data =ALL;
MODEL meanpsr = tx / S;
RANDOM INTERCEPT / SUB=id;
RUN;


