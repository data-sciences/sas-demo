/*======================== MACRO GOF ==========================
  Author:    Edward F. Vonesh, PhD 
  Written:   May 14, 2004      
  Modified:  Sep 18, 2008                                  
  Modified:  May 18, 2010                                  
  Program:   This macro program performs the following:
          1) This macro calculates R-square (R) and concordance
             correlation (Rc) Goodness-of-Fit (GOF) statistics
             for the SAS procedures: MIXED, GLIMMIX, NLMIXED
             and GENMOD and is based on the paper by Vonesh,
             Chinchilli and Pu (Biometrics, 52:572-587, 1996).
          2) This macro was originally written on May 14, 2004
             to include unadusted and adjusted R-square and
             concordance correlations (Rc).
          3) The program was modified on Sep 18, 2008 to allow
             R-square and concordance correlation coefficients
             from NLMIXED and GENMOD output. It also contains
             model fit statistics from the procedures.
          4) The program was modified on May 18, 2010 to allow
             the use of the pseudo-likelihood ratio test of
             Vonesh et. al. (1996) to test whether the model
             based covariance matrix of the parameter estimates
             is equal to the robust covariance matrix of the
             parameter estimates. The modifications in this
             version of macro GOF yield essentially the same
             results as the macro GLIMMIX_GOF but with the
             following EXCEPTIONS:
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
  NOTES 1.For the SAS procedure GENMOD, adjusted R-square and
          adjusted concordance correlation coefficients (CCC)
          are computed based ONLY on the number of fixed- 
          effects regression parameters in the model as the
          estimated variance-covariance matrix for the 
          repeated measures setting are method-of-moment
          estimates that are not tied to a likelihood-based 
          objective function. For the SAS procedures MIXED,
          GLIMMIX and NLMIXED, it is based on all of the   
          estimated parameters, both the fixed-effects 
          regression parameters and the variance-covariance 
          parameters provided the parameter that is estimated
          has an associated degrees of freedom. For example,
          if one specifies the following GLIMMIX statement 
             RANDOM _Residual_; 
          then SAS will output all of the fixed-effects
          regression parameters plus an overdispersion
          parameter that has 0 degrees of freedom. This macro
          GOF will NOT include this overdispersion parameter
          when it computes the adjusted R-square or adjusted
          concordance correlation coefficient based on the
          number of parameters used to compute the predicted
          values. 
        2.It should also be noted that the dataset containing
          predicted values must be created from the the 
          appropriate SAS procedure in accordance with the 
          goals for running macro GOF. For example, if one is  
          running a model with random effects using MIXED, 
          GLIMMIX or NLMIXED and one would like to see both 
          population-average R-square and subject-specific 
          R-square values (Vonesh and Chinchilli, 1997), then
          one should create an appropriate dataset containing 
          both the predicted values for the typical subject 
          (random effects set to 0) and the predicted values 
          for each subject (random effects set to the BLUP 
          values). For example, in MIXED one would specify 
          both the OUTP= and OUTPM= options of the MODEL 
          statement specifying PA and SS predicted values. In
          GLIMMIX, one would use the OUTPUT OUT statement with
          specifications pred(noblup ilink)='name' where 'name'
          is the name of the predicted value when the random 
          effects are set to 0 and pred(blup ilink)='name' 
          where 'name' is the name of the predicted value when
          random effects are set to their EBLUP values. 
          Likewsie one will need to specify both kinds of
          predicted values in NLMIXED using the SAS statement
          PREDICT expression OUT='name of dataset'. 
        3.Note that the predicted values correspond the 
          conditional means of the response variable. For a 
          mixed-effects model, let the conditional mean given a
          random effect, bi, be denoted by E(Yij|bi)=f(beta,bi)
          where f(beta,bi) is a possibly nonlinear conditional
          mean of response Yij for ith subject at jth occasion.
          The typical subject mean response is E(Yij|bi=0)= 
          f(beta,0) and the subject-specific (SS) mean response
          is E(Yij|bi)=f(beta,bi) where beta is the vector of 
          fixed-effects regression parameters. If the model 
          is already a marginal model such that E(Yij)=f(beta),
          then the macro GOF will only report goodness-of-fit
          on marginal or PA-based predicted values, E(Yij)= 
          f(beta_hat) whereas if the model is a mixed-effects
          model, it will report goodness-of-fit on both the 
          typical mean response, E(Yij|bi=0)=f(beta_hat,0), 
          denoted PRED_AVG within macro GOF and the SS mean
          response, E(Yij|bi_hat)=f(beta_hat,bi_hat) denoted by
          PRED_IND within GOF PROVIDED one specifies values of
          both PRED_AVG and PRED_IND. If one only specifies 
          PRED_AVG (the minimum default), then macro GOF will 
          report the same PA and SS R-square and Rc values 
          based on PRED_AVG.
===============================================================

   Macro Key:
   WHERE    = Where clause defining subgroups within which to 
              perform GOF 
   PROC     = Defines which procedure was used to create 
              predicted and observed response values.
              Valid values are:
               - PROC = MIXED
               - PROC = GLIMMIX
               - PROC = NLMIXED
               - PROC = GENMOD
   PARMS    = SAS dataset 'name' containing fixed-effects 
              regression parameters. For the different SAS 
              procedures, these correspond to the following 
              ODS OUTPUT statements:
               - MIXED:    ODS OUTPUT SolutionF='name' 
               - GLIMMIX:  ODS OUTPUT ParameterEstimates='name'
               - NLMIXED:  ODS OUTPUT ParameterEstimates='name'
               - GENMOD:   ODS OUTPUT ParameterEstimates='name'
                           if no REPEATED statement is used. 
                           This is useful for univariate 
                           applications.
               - GENMOD:   ODS OUTPUT GEEEmpPEst='name' if a
                           REPEATED statement is used 
              IMPORTANT NOTE:
               For NLMIXED, one should create two datasets 
               based on the dataset created by the ODS OUTPUT
               ParameterEstimates='name'. The first dataset 
               should contain ONLY the fixed-effects regression
               parameters and this is the dataset one should 
               specifiy with the PARMS= argument.   
   COVPARMS = SAS dataset containing unique variance-covariance
              parameters from MIXED or GLIMMIX and NLMIXED (see
              below for NLMIXED explanantion). 
              The dataset corresponds to:
               - MIXED:   ODS OUTPUT CovParms='name' 
                          is established by default regardless
                          of whether one specified a RANDOM or 
                          REPEATED statement
               - GLIMMIX: ODS OUTPUT CovParms='name' 
                          if a RANDOM statement is used
               - NLMIXED: ODS OUTPUT ParameterEstimates='name'
                          (See IMPORTANT NOTE below)
              IMPORTANT NOTE:
               For NLMIXED, one should create two datasets 
               based on the dataset created by the ODS OUTPUT
               ParameterEstimates='name'. The second dataset 
               should contain ONLY the variance-covariance 
               parameters and this is the dataset one should 
               specifiy with the COVPARMS= argument.   
   DATA     = SAS dataset containing predicted values. For the
              different SAS procedures, this dataset would be 
              constructed based on the following statements:
               - MIXED:   MODEL /OUTP='name1' OUTPM='name2' 
               - GLIMMIX: OUTPUT OUT='name' pred(options)= 
               - GENMOD:  OUTPUT OUT='name' pred= 
               - NLMIXED: PREDICT expression OUT='name'
   RESPONSE = Primary response variable 
   SUBJECT  = Identifies the SAS variable representing the 
              unique SUBJECT ID. This must be specified if one
              wishes to test whether the robust covariance
              matrix and the model-based covariance matrix are
              equal. This variable must be included in the 
              DATA= dataset above.
   PRED_AVG = Predicted response for the average individual 
              based on the PA predicted response, f(beta)
   PRED_IND = Predicted response for each individual based on 
              the SS predicted response, f(beta,bi) 
   FITSTATS = SAS dataset containing fit statistics from the 
              given SAS procedure. This is OPTIONAL within the
              macro GOF and is designed to let one print the 
              fit statistics that SAS outputs by default. In 
              MIXED, GLIMMIX and NLMIXED, this dataset 
              corresponds to the statement:
               - ODS OUTPUT FitStatistics='name'.
              Note that for GENMOD, if one runs a model without
              a REPEATED statement, the dataset corresponds to 
               - ODS OUTPUT Modelfit = 'name' 
              but if one runs GENMOD with a REPEATED statement,
              then such a dataset should be given by the 
              following  
               - ODS OUTPUT GEEFitCriteria = 'name' 
   OMEGA    = SAS dataset containing the model-based covariance 
              matrix of the model parameter estimates. This is 
              used for the pseudo-likelihood ratio test of
              Vonesh et. al. (Biometrics, 1996). In MIXED, 
              GLIMMIX, NLMIXED and GENMOD, the dataset 
              corresponds to the statement:
               - MIXED:   ODS OUTPUT CovB='name' 
                          -must specify CovB option in MODEL
               - GLIMMIX: ODS OUTPUT CovB='name' 
                          -must specify CovB option in MODEL
               - NLMIXED: ODS OUTPUT CovMatParmEst='name' 
                          -must specify COV option in NLMIXED
               - GENMOD:  ODS OUTPUT GEENcov='name' 
                          -must specifiy MCOVB and ECOVB 
                           options in the REPEATED statement
              IMPORTANT NOTE:
               For NLMIXED, one should make sure that the  
               regression parameters are listed first within 
               the PARMS= statement (one should ALWAYS use a 
               PARMS= statement if one wishes to perform the 
               pseudo-likelihood ratio test) so that the macro
               will correctly identify the correct elements of
               the overall covariance matrix associated with 
               ONLY the regression parameter estimates and NOT 
               any of the model variance-covariance parameter
               estimates. 
   OMEGA_R  = SAS dataset containing the robust covariance 
              matrix of the model parameter estimates. This is
              used for the pseudo-likelihood ratio test of
              Vonesh et. al. (Biometrics, 1996). In MIXED, 
              GLIMMIX, NLMIXED and GENMOD, the dataset
              corresponds to the statement:
               - MIXED:   ODS OUTPUT CovB='name' 
                          -must specify CovB option in MODEL
                           and the EMPIRICAL option of the 
                           MIXED statement
               - GLIMMIX: ODS OUTPUT CovB='name' 
                          -must specify CovB option in MODEL
                           and the EMPIRICAL option of the 
                           GLIMMIX statement
               - NLMIXED: ODS OUTPUT CovMatParmEst='name' 
                          -must specify COV option in NLMIXED
                           and the EMPIRICAL option of the 
                           NLMIXED statement
               - GENMOD:  ODS OUTPUT GEERcov='name' 
                          -must specifiy MCOVB and ECOVB 
                           options in the REPEATED statement
              IMPORTANT NOTE:
               For NLMIXED, one should make sure that the 
               regression parameters are listed first within 
               the PARMS= statement (one should ALWAYS use a 
               PARMS= statement if one wishes to perform the 
               pseudo-likelihood ratio test) so that the macro
               will correctly identify the correct elements of 
               the overall covariance matrix associated with 
               ONLY the regression parameter estimates and NOT 
               any of the model variance-covariance parameter 
               estimates. 
   TITLE    = Additional title information to be included in 
              the output may be specified here
              Example: TITLE = A Poisson mixed-effects model;
   REF      = Specifies that appropriate references to methods 
              be printed. The default (REF=,) does not print 
              references while specifying REF=yes will print
              references. 
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
=============================================================*/

%macro GOF(where,
           proc=, 
           parms=,
           covparms=, 
           data=,
           subject=,
           fitstats=,
           omega=,
           omega_r=,
           response=,
           pred_ind=, 
           pred_avg=, 
           title=,
           ref=,
           opt=noprint,
           printopt=print);

	%let proc=%qupcase(&proc); 
	%let opt=%qupcase(&opt);

/*=============================================================
   Newest module for calculating concordance correlations:
   RHO_PA and RHO_SS are concordance correlations for Y 
=============================================================*/
	DATA pe2152;
	 SET &PARMS;
	 &where; 
	 /* To eliminate "parameters" that are 0 or . */
	 %if %index(&proc, NLMIXED) %then %do;
	  Effect=Parameter;
	 %end;
	 %if %index(&proc, GENMOD) %then %do;
	  if Stderr=. or Stderr=0 then delete;
	  Effect=Parm;
	 %end;
	 %else %do;
	  if DF=. or DF=0 then delete; 
	 %end;
	 keep Effect Estimate;
	RUN;
 
	DATA cov2152;
	 CovParm='None';
	 Estimate=.;
	run;
 
	%if %index(&proc, NLMIXED) %then %do;
	%if %length(&COVPARMS) %then %do;
	DATA cov2152;
	 SET &COVPARMS;
	 &where;
	 if Estimate ne .;
	 CovParm=Parameter;
	 keep CovParm Parameter Estimate;
	RUN;
	data pe2152all;
	 set pe2152 cov2152;
	run;
	%end;
	%end;
 
	%if %index(&proc, MIXED) %then %do;
	DATA cov2152;
	 SET &COVPARMS;
	 &where;
	 if Estimate ne .;
	 keep CovParm Estimate;
	RUN;
	data pe2152all;
	 set pe2152 cov2152;
	run;
	%end;

	%if %index(&proc, GLIMMIX) %then %do;
	DATA cov2152;
	 SET &COVPARMS;
	 &where;
	 if Estimate ne .;
	 keep CovParm Estimate;
	RUN;
	data pe2152all;
	 set pe2152 cov2152;
	run;
	%end;

	** The following was added August 29, 2012 **;
	%if %index(&proc, GENMOD) %then %do;
	data pe2152all;
	 set pe2152;
	run;
	%end;

	DATA d2152;
	 SET &DATA;
	 &where;
	RUN;

	%if %length(&subject) %then %do;
	proc sort data=d2152;
	 by &SUBJECT;
	run;
	DATA dim2152;
     set d2152;
	 by &subject;
	 if first.&subject;
	 dum2152=1;
	run;
	proc means data=dim2152 noprint n;
	 var dum2152;
	 output out=N2152 n=n;
	run;
	data N2152;
	 set N2152;
	 keep n;
	run;
	%end;

	DATA d2152;
	 SET d2152; 
	  PRED_AVG2152=&pred_avg;
	 %if %length(&pred_ind) %then %do;  
	  PRED_IND2152=&pred_ind;
	 %end;
	 %else %do;  
	  PRED_IND2152=&pred_avg;
	 %end;
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
   defined variable names 
=============================================================*/
	  D82152A=&response-PRED_AVG2152;          
	  D82152I=&response-PRED_IND2152;          
	  Residual_avg=&response-PRED_AVG2152;     
	  Residual_ind=&response-PRED_IND2152;     
/*=============================================================
 To get balanced data wrt YOBS and YPRED values, we delete
 missing residual values. Note also if PRED_AVG is not 
 specified then all data is missing and we will get a warning
=============================================================*/
	 if D82152I = . or D82152A = . then delete;     
	run;
	%if %length(&fitstats) %then %do;
	DATA fit2152;
	 SET &fitstats;
	RUN;
	%end;

/*=============================================================
   Newest module for calculating pseudo-likelihood ratio tests
   comparing model-based versus robust variance-covariance 
   matrices of the estimated regression parameters from a model
=============================================================*/
	%if %length(&omega) %then %do;
	DATA omega;
	 set &omega;
	%if %index(&proc, MIXED) %then %do;
	  Drop Row Effect;
	 %end;
	 %if %index(&proc, GLIMMIX) %then %do;
	  Drop Row Effect;
	 %end;
	 %if %index(&proc, NLMIXED) %then %do;
	  Drop Row Parameter;
	 %end;
	 %if %index(&proc, GENMOD) %then %do;
	  Drop RowName;
	 %end;
	run;
	%end;

	%if %length(&omega_r) %then %do;
	DATA omega_r;
	 set &omega_r;
	 %if %index(&proc, MIXED) %then %do;
	  Drop Row Effect;
	 %end;
	 %if %index(&proc, GLIMMIX) %then %do;
	  Drop Row Effect;
	 %end;
	 %if %index(&proc, NLMIXED) %then %do;
	  Drop Row Parameter;
	 %end;
	 %if %index(&proc, GENMOD) %then %do;
	  Drop RowName;
	 %end;
	run;
	%end;


	PROC IML;
	 RESET NONAME;
/* Read in required input from datasets */
	 USE N2152;
	  READ ALL VAR _num_ into N;
	 USE pe2152;
	  READ ALL VAR {Estimate} into BetaEstimate;    
	  ** = All Estimated parameters (location ONLY);
	 USE pe2152all;
	  READ ALL VAR {Estimate} into Estimate;        
	  ** = All Estimated parameters (location and scale);
	 USE d2152;
	  READ ALL VAR {&response} into YOBS;           
	  READ ALL VAR {PRED_IND2152} into YHAT_SS;     
	  READ ALL VAR {PRED_AVG2152} into YHAT;      
/* Start calculations of R-square and Rc */
	  N_beta  = NROW(BetaEstimate);
	  ** N_beta = number of regression coefficients only;
	  PQ = NROW(Estimate);                        
	  ** PQ includes regression and covariance parameters except for GENMOD;

	  *print 'N_beta' N_beta 'PQ' PQ 'BetaEstimate' BetaEstimate 'Estimate' Estimate; 
	  SUMMARY VAR {&response PRED_AVG2152 PRED_IND2152 
	               d82152A d82152I}
	          STAT {N MEAN CSS USS}
	          OPT {NOPRINT SAVE};
	  SUMMARY VAR {&response &pred_avg &pred_ind 
	               residual_avg residual_ind}
	          STAT {N MEAN CSS USS}
	          OPT {&opt NOSAVE};
/*=============================================================
 The following variables are calculated:
 TOTAL= N;
 SS_OBS=YOBS`*(I(N)-(1/N)*J(N,1,1)*J(N,1,1)`)*YOBS;
 SS_HAT=YHAT`*(I(N)-(1/N)*J(N,1,1)*J(N,1,1)`)*YHAT;
 SS_HATI=YHAT_SS`*(I(N)-(1/N)*J(N,1,1)*J(N,1,1)`)*YHAT_SS;
 AVG_OBS=SUM(YOBS)/N;
 AVG_HAT=SUM(YHAT)/N;
 AVG_HATI=SUM(YHAT_SS)/N;
 SS_AVG=(AVG_OBS-AVG_HAT)**2;
 SS_AVGI=(AVG_OBS-AVG_HATI)**2;
 USS_AVG=(YOBS-YHAT)'*(YOBS-YHAT);
 USS_SS=(YOBS-YHAT_SS)'*(YOBS-YHAT_SS);
=============================================================*/
	   TOTAL=&response[,1];      
	   SS_OBS=&response[,3];     
	   SS_HAT=pred_avg2152[,3];  
	   SS_HATI=pred_ind2152[,3]; 
	   AVG_OBS=&response[,2];    
	   AVG_HAT=pred_avg2152[,2]; 
	   AVG_HATI=pred_ind2152[,2];
	   SS_AVG=(AVG_OBS-AVG_HAT)**2;
	   SS_AVGI=(AVG_OBS-AVG_HATI)**2;
	   USS_AVG=d82152A[,4];      
	   USS_SS=d82152I[,4];     
	   RHO_PA=1 - USS_AVG/(SS_OBS+SS_HAT+TOTAL*SS_AVG);
	   adjRHO_PA=1 - (1-RHO_PA)*(TOTAL/(TOTAL-PQ));
	   RHO_SS=1 - USS_SS/(SS_OBS+SS_HATI+TOTAL*SS_AVGI);
	   adjRHO_SS=1 - (1-RHO_SS)*(TOTAL/(TOTAL-PQ));
	   RSQ_PA = 1 - USS_AVG/SS_OBS;
	   adjRSQ_PA = 1 - (1-RSQ_PA)*(TOTAL/(TOTAL-PQ));
	   RSQ_SS = 1 - USS_SS/SS_OBS;
	   adjRSQ_SS = 1 - (1-RSQ_SS)*(TOTAL/(TOTAL-PQ));

	   NAMEFIT1={"Total Observations",
                "N (number of subjects)", 
	            "Number of Total Parameters",
	            "Number of Fixed-Effects Regression Parameters",
	            "Average Model R-Square:",
	            "Average Model Adjusted R-Square:",
	            "Average Model Concordance Correlation:",
	            "Average Model Adjusted Concordance Correlation:",
	            "Conditional Model R-Square:",
	            "Conditional Model Adjusted R-Square:",
	            "Conditional Model Concordance Correlation:",
	            "Conditional Model Adjusted Concordance Correlation:"};
	   Descrip="123456789012345678901234567890123456789012345678901";

	   VALFIT1 = TOTAL//N//PQ//N_beta//RSQ_PA//adjRSQ_PA//
                 RHO_PA//adjRHO_PA//RSQ_SS//adjRSQ_SS//
                 RHO_SS//adjRHO_SS;
	   Descrip=NAMEFIT1;
	   Value=VALFIT1;

	   %if %length(&fitstats) %then %do;
	   USE fit2152;
	   READ ALL VAR _char_ into FITdescr 
           (|COLNAME=FITNAME1|);                
	   READ ALL VAR _num_ into FIT 
           (|COLNAME=FITNAME2|);                
	   %end;

	   %if %length(&omega) %then %do;
	    %if %length(&omega_r) %then %do;
		/*  Module to compute Log(DETERMINANT) of any matrix */
		START LOG_DET(AAAA);
		 SCALE=MAX(VECDIAG(AAAA));
		 IF SCALE<1 THEN SCALE=1;
		 VI_SCALE=AAAA/SCALE;
		 CHECK1=DET(VI_SCALE);
		 IF CHECK1>0 THEN GO TO ENDSC2;
		 DO III=1 TO 100 UNTIL(CHECK1 > 0);
		  IF SCALE<1 THEN GO TO ENDSC1;
		  ELSE SCALE=SCALE/10;
		  VI_SCALE=AAAA/SCALE;
		  CHECK1=DET(VI_SCALE);
		 ENDSC1:
		 END;
		 ENDSC2:
		 IF CHECK1=0 THEN DO;
		 _LOGDET_=LOG(.10**20);
		 END;
		 ELSE DO;
		 _LOGDET_ = ( NCOL(AAAA)*LOG(SCALE) + LOG(CHECK1) );
		 END;
		  RETURN (_LOGDET_);
		FINISH;

		START ROBUST;
	     USE omega;
	     READ ALL VAR _num_ into Omega; 
	     USE omega_r;
	     READ ALL VAR _num_ into Omega_R; 
         %if %index(&proc, NLMIXED) %then %do;
          Omega=Omega[1:N_beta, 1:N_beta];  
          Omega_R=Omega_R[1:N_beta, 1:N_beta];
         %end;  
		  NonZeroCount=0;
		  do i=1 to N_beta;
           do j=1 to N_beta;
             if any(Omega_r[i,j]) then NonZeroCount=NonZeroCount+1;
           end;
		  end;

/*=============================================================
 The following variables are defined as follows:
 nz = number of non-zero components of the empirical or robust 
      sandwich estimator
 s  = rank(Omega_R)=dim(Beta)=number of regression parameters
 s1 = number of unique non-zero off-diagonal elements of the 
      empirical or robust sandwich estimator
=============================================================*/
		  nz= NonZeroCount; 
          s = N_beta;  
          s1 = (nz-s)/2;
 

/*=============================================================
 The following is so we do not perform LR test if RESTRICT is
 in effect 
=============================================================*/

		  DETERR=
		  "if overflow then do;
		   OMEGACHK=1;
		   CALL PUSH(DETERR); RESUME; END;";

		  CALL PUSH(DETERR);
		  overflow=1;
		  OMEGACHK=(DET(OMEGA)=0)|(DET(OMEGA_R)=0);
		  overflow=0;

		  IF OMEGACHK=1 THEN GOTO OMEGARUN;
		  SQOMEGA = GINV(ROOT(OMEGA));
		  ASYVAR = SYMSQR(SQOMEGA`*OMEGA_R*SQOMEGA);
		  ROBVAR = SYMSQR(I(N_beta));
		  DIFVAR = ASYVAR - ROBVAR;
		  NVAR=NROW(ASYVAR);
		  MSG1={" "};
		  RHO_CVAR = 1 - (DIFVAR`*DIFVAR)/(ASYVAR`*ASYVAR + ROBVAR`*ROBVAR);
		  LRTEST= N*( LOG_DET(OMEGA) - LOG_DET(OMEGA_R) +
		           TRACE(OMEGA_R*GINV(OMEGA)) - N_beta );
          DISCREP_FUNC = LRTEST/N;
		  ** Original formulation of Vonesh et al (1996) where
		     r= rank(Omega_R) = rank of robust sandwich estimator;
		  DFLRTEST_OLD=.5*s*(s+1);
		  ** New formulation based on number of non-zero elements 
		     of robust sandwich estimator (rather than its rank);
		  DFLRTEST_NEW=s+s1;       
		  P_LRTEST_OLD=1-PROBCHI(MIN(LRTEST,200),DFLRTEST_OLD);
		  P_LRTEST_NEW=1-PROBCHI(MIN(LRTEST,200),DFLRTEST_NEW);
		  P_LRTEST_OLD=P_LRTEST_OLD<>.0001;
		  P_LRTEST_NEW=P_LRTEST_NEW<>.0001;

		  OMEGARUN:
		  IF OMEGACHK=1 THEN DO;
		   msg1={"Singular Estimate of Omega or Overflow error detected: Test not done"};
		   RHO_CVAR=.;LRTEST=.;DFLRTEST_OLD=.;DFLRTEST_NEW=.;P_LRTEST_OLD=.;P_LRTEST_NEW=.;
		  END;
          NAMEFIT2={"Variance-Covariance Concordance Correlation:",
                   "Discrepancy Function",
			       "s = Rank of robust sandwich estimator, OmegaR",
			       "s1 = Number of unique non-zero off-diagonal elements of OmegaR",
                   "Approx. Chi-Square for H0: Covariance Structure is Correct",
                   "DF1 = s(s+1)/2, per Vonesh et al (Biometrics 52:572-587, 1996)",
                   "Pr > Chi Square based on degrees of freedom, DF1", 
                   "DF2 = s+s1, a modified degress of freedom",
                   "Pr > Chi Square based on modified degrees of freedom, DF2"}; 
		  VALFIT2 = RHO_CVAR//DISCREP_FUNC//s//s1//LRTEST//DFLRTEST_OLD//P_LRTEST_OLD//DFLRTEST_NEW//P_LRTEST_NEW;
		FINISH;
        %end; 
	   %end;

	   %if %length(&omega) %then %do;
	    %if %length(&omega_r) %then %do;
		RUN ROBUST;
        %end; 
	   %end;


	   Description=NAMEFIT1;
	   Value=VALFIT1;

       %if %length(&omega) %then %do;
 	     %if %length(&omega_r) %then %do;
		   NAMEFIT3={"Total Observations",
		            "N (number of subjects)", 
		            "Number of Total Parameters",
		            "Number of Fixed-Effects Regression Parameters",
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

		   VALFIT3 = TOTAL//N//PQ//N_beta//RSQ_PA//adjRSQ_PA//RHO_PA//adjRHO_PA//
		            RSQ_SS//adjRSQ_SS//RHO_SS//adjRHO_SS//RHO_CVAR//DISCREP_FUNC//s//
	                s1//LRTEST//DFLRTEST_OLD//P_LRTEST_OLD//DFLRTEST_NEW//P_LRTEST_NEW;
		   Description=NAMEFIT3;
		   Value=VALFIT3;
         %end;
 	   %end;  

	   PRINTOPTIONS={&printopt};

	   IF ANY(PRINTOPTIONS="PRINT") THEN DO;

	   RESET SPACES=2;
	   PRINT / 'R-Square Type Goodness-of-Fit Information',
               "Results based on predicted values from SAS procedure &proc",
               "&TITLE",,
	       'MODEL FITTING INFORMATION',
	        NAMEFIT1 (|COLNAME='DESCRIPTION' FORMAT=$60.|)
	        VALFIT1  (|COLNAME='VALUE' FORMAT=BEST8.|),,
	   %if %length(&fitstats) %then %do;
	       "Goodness-of-Fit Statistics from SAS Procedure &proc",
           "&TITLE",,
            FITdescr FIT,,, 
	   %end;
       %if %length(&omega) %then %do;
 	     %if %length(&omega_r) %then %do;
		   "Pseudo-Likelihood Ratio Test of Variance-Covariance Structure",
           "Results based on predicted values from SAS procedure &proc",
           "&TITLE",,
		   MSG1,
		   NAMEFIT2 (|COLNAME='DESCRIPTION' FORMAT=$63.|)				
		   VALFIT2  (|COLNAME='VALUE'  FORMAT=BEST8.|),
         %end;
       %end; 
 	   %if %length(&ref) %then %do;
           'References:                                                           ',
           '1. Vonesh, Chinchilli and Pu, Biometrics 52:572-587, 1996             ',
           '2. Vonesh and Chinchilli, Linear and Nonlinear Models for the Analysis',
           '   of Repeated Measurements, Marcel Dekker, New York, 1997            ',,,
	   %end;
	   %else %do;
        ;
	   %end;

	   END;

     RESET SPACES=1;
	 CREATE _fitting VAR {Description Value};
	 APPEND;

	RUN;
	QUIT;

%mend GOF;

