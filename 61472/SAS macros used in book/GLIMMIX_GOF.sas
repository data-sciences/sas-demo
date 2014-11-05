
/*================== MACRO GLIMMIX_GOF ========================
  Author:    Edward F. Vonesh, PhD 
  Written:   August 11, 2008      
  Modified:  August 10, 2009 
  Program:   This macro program performs the following:
          1) This macro calculates R-square (R) and concordance
             correlation (Rc) Goodness-of-Fit (GOF) statistics
             for the SAS procedure GLIMMIX and is based on the
             paper by Vonesh, Chinchilli and Pu (Biometrics,
             52:572-587, 1996) as well as the book by Vonesh
             and Chinchilli (1997).
          2) This macro also compares the robust sandwich 
             estimator of Var(beta) to a model-based estimator
             of Var(beta) using the pseudo-likelihood ratio 
             test of Vonesh et al (1996). It should be noted
             that this macro is intended ONLY for applications
             that involve a single set of random effects 
             parameters and has not been tested for 
             applications involving nested random effects such
             as the multi-level random-effects models of 
             Goldstein et al.  
          3) The program was modified on Aug 10, 2009 to allow
             a modified form of the pseudo-likelihood ratio 
             test of Vonesh et al (1996) to test whether the
             model-based covariance matrix of the regression
             parameter estimates is equal to the empirical or
             robust covariance matrix of those estimates. 
          4) The modifications in this version of the macro 
             yield essentially the same results as the macro 
             GOF but with the following EXCEPTIONS:
             - GLIMMIX_GOF bases the variance-covariance
               concordance correlation coefficient (CCC) on  
               a slight modification of the variance-covariance
               CCC by Vonesh (see the GLIMMIX documentation for
               details) whereas macro GOF is based on the
               original publication of Vonesh, Chinchilli and
               Pu (Biometrics 52:572-587, 1996).
             - GLIMMIX_GOF bases adjusted R-Square and adjusted
               Rc (CCC) values on the number of regression
               parameters whereas GOF bases the adjusted
               R-Square and Rc values on the total number of
               parameters.
===============================================================
 
===============================================================
  NOTES. When running %GLIMMIX_GOF one must use ODS OUTPUT 
         statements to create the necessary datasets which this
         macro uses to construct concordance correlations and 
         to carry out the necessary pseudo-likelihood ratio 
         test of the assumed variance-covariance structure 
         based on the discrepancy function output by GLIMMIX 
         and described by Vonesh, Chinchilli and Pu (1996) and 
         Vonesh and Chinchilli (1997). The macro arguments 
         used in this macro are defined as follows:  
===============================================================
 
   Macro Key:
   WHERE    = Where clause defining subgroups within which one 
              wishes to perform a GOF. Typically, these 
              subgroups are defined by a BY statement used with
              the GLIMMIX procedure. 
   DIMENSION= SAS dataset containing the dimensions of the 
              model run using GLIMMIX. This is the dataset 
              created with ODS OUTPUT Dimesnions='name' 
   PARMS    = SAS dataset containing fixed-effects parameters. 
              This is the dataset created with ODS OUTPUT 
              ParameterEstimates='name' statement. 
   COVB_GOF = SAS dataset containing GOF output when one 
              specifies the COVB(DETAILS) option of MODEL 
              statement. This is the dataset created with 
              ODS OUTPUT CovBDetails='name'  
   OUTPUT   = SAS dataset containing data from OUTPUT OUT= 
              statement from GLIMMIX. When running GLIMMIX with
              assumed random effects specified by the RANDOM 
              statement, the OUTPUT OUT= statement should 
              contain two sets of predicted values, one for the
              population-average mean using 
                 PRED(NOBLUP ILINK)='name1' 
              and one for the subject-specific mean using 
                 PRED(ILINK)='name2'.
              One can easily accomplish these tasks using the 
              option ALLSTATS with the OUTPUT OUT= statement 
              as this will produce all the required statistics
   RESPONSE = Primary response variable (this is the name of 
              the response variable used in the GLIMMIX MODEL
              statement).
   PRED_AVG = Predicted mean response for typical or average
              individual based on the inverse link function 
              and the fixed-effects parameters only. If one 
              simply specifies
                 OUTPUT OUT=name / ALLSTATS; 
              then PRED_AVG=PredMuPA.
   PRED_IND = Predicted mean response for each individual based 
              on the inverse link function and the fixed-
              effects and random-effects estimates for each
              individual. If one simply specifies
                 OUTPUT OUT=name / ALLSTATS; 
              then PRED_IND=PredMu. 
   OPT      = option to print or not print the results of the
              SUMMARY statement used in IML. This option will
              produce summary statistics on the response 
              variable, the PA and SS predicted responses and 
              the corresponding PA and SS residuals (Y-YHAT)  
                  OPT=NOPRINT (no output is printed - default)
                  OPT=PRINT (output is printed)            
   PRINTOPT = option to print or not print the results of the
              macro. The available options are  
                  PRINTOPT=NOPRINT (no output is printed)
                  PRINTOPT=PRINT (output is printed - default)
              Regardless of which option one selects, the 
              results are stored in the dataset, _fitting, 
              which contains a description of the statistic 
              and its value which one can also print out.
   FORMAT   = option to format summary GOF statistics. The        
              default is FORMAT=BEST8.                       
=============================================================*/
%macro GLIMMIX_GOF(where,
           dimension=, 
           parms=,
           covb_gof=,
           output=,
           response=,
           pred_ind=, 
           pred_avg=,
           opt=noprint,
           printopt=print,
           format=best8.);

%let printopt=%qupcase(&printopt);

/*=============================================================
   Newest module for calculating concordance correlations:
   RHO_PA and RHO_SS are concordance correlations for Y 
=============================================================*/

DATA pe2152;
 SET &PARMS;
 &where;
 if DF=. then delete; ** Eliminate "parameters" that are 0 by definition;
 keep effect estimate;
RUN;

DATA gof2152;
 SET &COVB_GOF;
 &where;
 if descr='Discrepancy function';
 lambda_n=adjusted;
 keep lambda_n;
RUN;
DATA s2152;
 SET &COVB_GOF;
 &where;
 if descr='Non-zero entries';
 s=adjusted;
 keep s;
RUN;
DATA ccc2152;
 SET &COVB_GOF;
 &where;
 if descr='Concordance correlation';
 ccc=adjusted;
 keep ccc;
RUN;
DATA n2152;
 SET &DIMENSION;
 &where;
 if descr='Subjects (Blocks in V)';
 N=value;
 keep N;
RUN;

DATA pred2152;
 SET &OUTPUT;
 &where;
RUN;


/*=============================================================
   The following code computes PA and SS residuals used to    
   compute the goodness-of-fit statistics:
     D82152A = PA Residual = response - pred_avg
     D82152S = SS Residual = response - pred_avg
     Residual_avg = PA Residual = response - pred_avg
     Residual_ind = SS Residual = response - pred_avg
   We re-compute Residual_avg and Residual_ind for printing
   purposes whereas D82152A and D82152S are internal variable
   names used so as to not interefer with possible user 
   defined variable names. To get balanced data wrt YOBS 
   and YPRED values, we delete missing residual values. Note 
   also if PRED_AVG is not specified then all data is missing 
   and we will get a warning
=============================================================*/
DATA pred2152;
 SET pred2152; 
 D82152A=&response-&pred_avg;                ** PA Residual = response - pred_avg;
 D82152I=&response-&pred_ind;                ** SS Residual = response - pred_ind;
 Residual_avg=&response-&pred_avg;           ** PA Residual = response - pred_avg;
 Residual_ind=&response-&pred_ind;           ** SS Residual = response - pred_ind;
 if D82152I = . or D82152A = . then delete;  ** To get balanced data wrt YOBS and YPRED values;
run;

PROC IML;
 RESET NONAME;
 USE pe2152;
  READ ALL VAR {Estimate} into Estimate;     ** = All Estimated parameters (location and scale);
 USE ccc2152;
  READ ALL VAR {ccc} into CCC;               ** = Variance-covariance concordance correlation coefficient;   
 USE gof2152;
  READ ALL VAR {lambda_n} into DISCREP_FUNC; ** = ML-based discrepancy function under noramlity;  
 USE s2152;
  READ ALL VAR {s} into s;                   ** = s = number of non-zero components of robust sandwich estimator;  
 USE n2152;
  READ ALL VAR {n} into N;                   ** = Number of subjects;
 USE pred2152;
  READ ALL VAR {&response} into YOBS;        ** = Primary response variable of model;
  READ ALL VAR {&pred_ind} into YHAT_SS;     ** = mu(beta, bi) = the conditional means defined by 
                                                  the PRED(ILINK) syntax of the OUTPUT OUT= 
                                                  statement of GLIMMIX;
  READ ALL VAR {&pred_avg} into YHAT;        ** = mu(beta) = the average subject means defined by 
                                                  the PRED(NOBLUP ILINK) syntax of the OUTPUT OUT= 
                                                  statement of GLIMMIX;

   PQ = NROW(Estimate);      ** = Number of fixed-effects regression parameters only = rank of robust sandwich estimator;
   s1 = (s-PQ)/2;            ** = Number of unique non-zero off-diagonal elements of robust sandwich estimator;
   SUMMARY VAR {&response &pred_avg &pred_ind d82152A d82152I}
           STAT {N MEAN CSS USS}
           OPT {NOPRINT SAVE};
   SUMMARY VAR {&response &pred_avg &pred_ind Residual_avg Residual_ind}
           STAT {N MEAN CSS USS}
           OPT {&opt NOSAVE};
   TOTAL=&response[,1];      ** = Total number of observations;
   SS_OBS=&response[,3];     ** = YOBS`*(I(TOTAL)-(1/TOTAL)*J(TOTAL,1,1)*J(TOTAL,1,1)`)*YOBS;
   SS_HAT=&pred_avg[,3];     ** = YHAT`*(I(TOTAL)-(1/TOTAL)*J(TOTAL,1,1)*J(TOTAL,1,1)`)*YHAT;
   SS_HATI=&pred_ind[,3];    ** = YHAT_SS`*(I(TOTAL)-(1/TOTAL)*J(TOTAL,1,1)*J(TOTAL,1,1)`)*YHAT_SS;
   AVG_OBS=&response[,2];    ** = SUM(YOBS)/TOTAL;
   AVG_HAT=&pred_avg[,2];    ** = SUM(YHAT)/TOTAL;
   AVG_HATI=&pred_ind[,2];   ** = SUM(YHAT_SS)/TOTAL;
   SS_AVG=(AVG_OBS-AVG_HAT)**2;
   SS_AVGI=(AVG_OBS-AVG_HATI)**2;
   USS_AVG=d82152A[,4];      ** = (YOBS-YHAT)'*(YOBS-YHAT);
   USS_SS=d82152I[,4];       ** = (YOBS-YHAT_SS)'*(YOBS-YHAT_SS);
   RHO_PA=1 - USS_AVG/(SS_OBS+SS_HAT+TOTAL*SS_AVG);
   adjRHO_PA=1 - (1-RHO_PA)*(TOTAL/(TOTAL-PQ));
   RHO_SS=1 - USS_SS/(SS_OBS+SS_HATI+TOTAL*SS_AVGI);
   adjRHO_SS=1 - (1-RHO_SS)*(TOTAL/(TOTAL-PQ));
   RSQ_PA = 1 - USS_AVG/SS_OBS;
   adjRSQ_PA = 1 - (1-RSQ_PA)*(TOTAL/(TOTAL-PQ));
   RSQ_SS = 1 - USS_SS/SS_OBS;
   adjRSQ_SS = 1 - (1-RSQ_SS)*(TOTAL/(TOTAL-PQ));

   LRTEST = N*DISCREP_FUNC;
   DFLRTEST_OLD=.5*PQ*(PQ+1);** Original formulation of Vonesh et al (1996) where PQ = rank(Omega) = rank of robust sandwich estimator;
   DFLRTEST_NEW=PQ+ s1;      ** New formulation based on number of unique non-zero elements of robust sandwich estimator (rather than its rank);
   P_LRTEST_OLD=1-PROBCHI(MIN(LRTEST,200),DFLRTEST_OLD);
   P_LRTEST_NEW=1-PROBCHI(MIN(LRTEST,200),DFLRTEST_NEW);
   P_LRTEST_OLD=P_LRTEST_OLD<>.0001;
   P_LRTEST_NEW=P_LRTEST_NEW<>.0001;

   NAMEFIT={"Total Observations",
            "N (number of subjects)", 
            "Number of Fixed-Effects Parameters",
            "Average Model R-Square:",
            "Average Model Adjusted R-Square:",
            "Average Model Concordance Correlation:",
            "Average Model Adjusted Concordance Correlation:",
            "Conditional Model R-Square:",
            "Conditional Model Adjusted R-Square:",
            "Conditional Model Concordance Correlation:",
            "Conditional Model Adjusted Concordance Correlation:",
            "Variance-Covariance Concordance Correlation:",
            "Discrepancy Function",
			"s = Rank of robust sandwich estimator, OmegaR",
			"s1 = Number of unique non-zero off-diagonal elements of OmegaR",
            "Approx. Chi-Square for H0: Covariance Structure is Correct",
            "DF1 = s(s+1)/2, per Vonesh et al (Biometrics 52:572-587, 1996)",
            "Pr > Chi Square based on degrees of freedom, DF1", 
            "DF2 = s+s1, a modified degress of freedom",
            "Pr > Chi Square based on modified degrees of freedom, DF2"}; 
      Descr="123456789012345678901234567890123456789012345678901234567890123";

   VALFIT = TOTAL//N//PQ//RSQ_PA//adjRSQ_PA//RHO_PA//adjRHO_PA//
            RSQ_SS//adjRSQ_SS//RHO_SS//adjRHO_SS//CCC//DISCREP_FUNC//PQ//s1//LRTEST//DFLRTEST_OLD//P_LRTEST_OLD//DFLRTEST_NEW//P_LRTEST_NEW;
   Description=NAMEFIT;
   Value=VALFIT;
   RESET SPACES=2;

   PRINTOPTIONS={&printopt};

   IF ANY(PRINTOPTIONS="PRINT") THEN DO;
   PRINT / 'R-Square Type Goodness-of-Fit Information',,
       'MODEL FITTING INFORMATION',
        NAMEFIT (|COLNAME='DESCRIPTION' FORMAT=$63.|)
        VALFIT  (|COLNAME='Value' FORMAT=&format|);
   RESET SPACES=1;
   END;

   CREATE _fitting VAR {Description Value};
   APPEND;

RUN;
QUIT;

%mend GLIMMIX_GOF;
