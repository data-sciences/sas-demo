
/*======================== MACRO CCC ==========================
  Author:    Edward F. Vonesh, PhD 
  Written:   August 22, 2008   
  Modified:                                  
  Program:   This macro program performs the following:
          1) Macro CCC calculates an overall correlation matrix
             and a concordance correlation matrix of pairwise
             concordance correlation coefficients (CCC) based
             on a specified marginal linear model with a
             specified marginal variance-covariance structure.
             The macro also computes an overall concordance  
             correlation coefficient (OCCC). These summary 
             measures of agreement are based on papers by 
             Carrasco and Jover (Biometrics 59:849-858, 2003),
             Barnhart, Haber and Song (Biometrics, 58:1020-
             1027, 2002), Barnhart and Williamson (Biometrics
             57:931-940, 2001) and Helenowski et. al. (The 
             Int. Journal of Biostatistics, 7:1-21, 2011).
===============================================================
 

===============================================================
  NOTES 1.Notation: CCC = Concordance Correlation Coefficient 
                    OCCC = Overall CCC
        2.This macro assumes one has run PROC MIXED using a 
          marginal linear model with an intercept, a fixed-
          effects variable representing say p sources over 
          which one wishes to compute pairwise CCC's and the 
          overall CCC (OCCC). The marginal linear model can  
          also include additional covariates one wishes to 
          adjust for (e.g.,  Carrasco and Jover, 2003; 
          Helenowski et. al., 2011).
===============================================================

   Macro Key:
   WHERE     -a where clause that defines a where statement for
              exclusion purposes
   COV       -defines the dataset from PROC MIXED that contains
              the marginal covariance matrix. When using the   
              REPEATED statement, this data set is created by
              specifying the ods statement: 
                 ODS OUTPUT R='name';    
              where 'name' is the dataset. For example, if
              one specifies 
                 ODS OUTPUT R=Rvar; 
              then one would specify
                 COV=Rvar  
   MEAN      -defines the dataset from PROC MIXED that contains 
              the fixed-effects regression parameter estimates 
              which one obtains using the ods statement: 
                 ODS OUTPUT ParameterEstimates='name'        
   EFFECT    -defines the effect variable from the dataset
              defined by the above macro argument MEAN. The 
              EFFECT variable should be that variable in the
              MODEL statement of PROC MIXED that defines what
              the adjusted or unadjusted effects of the p 
              sources of interest have on the response variable
              of interest. These p sources are the levels that
              one wishes to evaluate how reproducible each of
              the sources are relative to one another (i.e., 
              what are the pairwise CCC's between the different
              sources and what is the OCCC across sources). 
              For example, suppose the MODEL statement of PROC
              MIXED is the following:
                 MODEL Y = GROUP X /SOLUTION;
              where X is some continuous covariate one wishes 
              to adjust for and GROUP is a variable that 
              represents the p different sources of interest. 
              Then one would specify
                 EFFECT=GROUP
              as the effect variable of interest.  
   N         -defines the dataset from PROC MIXED that contains
              the number of subjects (experimental units) in 
              the data. This dataset corresponds to the 
              dataset created by the ods statement
                 ODS OUTPUT Dimensions='name' 
              in which case one would specify
                 N='name'                
   LABEL     -defines a label for the single response variable 
              which is being measured across the p sources 
              (i.e., p different assay methods, p different 
              raters, etc.).  
   STRUCTURE -defines a label for the type of variance-    
              covariance structure specified in MIXED.                   
   AIC       -defines the dataset from PROC MIXED that 
              summarizes the model goodness-of-fit based on 
              AIC, etc.          
   TABLE     -defines a Table name or number or description of
              the output from this macro (default is TABLE=1). 
   STATFMT   -define the numeric format for summary measures
              like N, mean, and standard deviation
              The default is STATFMT=6.2
   CORRFMT   -define the numeric format for all measures of 
              correlation (pairwise CCC's and OCCC).
              The default is CORRFMT=6.4
=============================================================*/
%MACRO CCC(where,
           cov=,
           mean=,
           effect=,
           n=,
           label=,
           structure=, 
           AIC=,
           table=1,
           statfmt=6.2,
           corrfmt=6.4);

 %let _effect_=%qupcase(&effect);
 data cov; 
  set &cov;
  drop index row;
 run;
 data intercept;
  set &mean;
  if effect='Intercept';
  keep estimate;
 run;
 data effects;
  set &mean;
  _effect_=UPCASE(effect);
  if _effect_ = "&_effect_"; 
  keep _effect_ effect &effect estimate;
 run; 
 
 data nobs;
  set &N;
  if Descr='Subjects';
  keep Value;
 run;
 data AIC; 
  set &AIC;
  keep Parms Neg2LogLike AIC AICC BIC Model Covariance;
 run;
 PROC IML;
  START CONCORR;
	  /* Get all relevant matrices for computations */
	  USE intercept;
	      read all var _num_ into Mu;
	  USE nobs;
	      read all var _num_ into N;
	  USE effects;
	      read all var {&effect} into &effect;
	  USE effects;
	      read all var {estimate} into Beta;
	  USE cov;
	      read all var _num_ into COVAR;
	  USE AIC;
          READ ALL VAR _num_ INTO InformationCriteria (|COLNAME=AICNAME|);

	  P_Beta=NROW(Beta);   ** Should be same as p below;
	  P=NCOL(COVAR);       ** p is number of variables analyzed;
	  HALF_P=P/2;          ** HALF_P is number of paired variables analyzed;
	  /*--- The following create index vectors for getting pairwise ---*/
	  /*--- elements of VAR for printing purposes.                  ---*/
	  r1=do(1,p-1,2);
	  r2=do(2,p,2);
	  
	  /*---Initialize the matrices for STAT1 and STAT2--*/
	  MEAN = Mu + Beta;
	  SIGMA=DIAG(COVAR);
	  STD=SQRT(SIGMA);
	  CORR=INV(STD)*COVAR*INV(STD);
	  SD=VECDIAG(STD);
	  CORRCHECK=J(P,P,0);
	  CONCORR=J(P,P,0);
	  DIFF=J(P,P,0);
	  NOBS = J(p,1,N);
      CONTRAST=( J((P-1),1,1)||(-1*I(P-1)) );
	  ERROR = CONTRAST*COVAR*CONTRAST`;
      SIGMA_ERROR1 = SUM(DIAG(CONTRAST*COVAR*CONTRAST`))/(p*(p-1));
	  VEC_CORR=J(HALF_P,1,1); 
	  VEC_CONCORR=J(HALF_P,1,1);
	 *print &effect p_beta p Mu Beta COVAR N MEAN STD CORR CONCORR 
            CONTRAST ERROR SIGMA_ERROR1;

	  /*--- Start pairwise computations ---*/
	    DO I=1 TO P;
	     DO J=1 TO P;
	      CORRCHECK[I,J]=COVAR[I,J]/SQRT(COVAR[I,I]*COVAR[J,J]);
	      CONCORR[I,J]=2*COVAR[I,J]/(COVAR[I,I]+COVAR[J,J]+(MEAN[I,]-MEAN[J,])##2);
	     END;
	    END;
	  /*--- End of pairwise computations ---*/

	  /*--- Set up pairwise correlations and concordance correlations ---*/
	   *print CORR CORRCHECK CONCORR;
		DO K=1 TO HALF_P BY 1;
		    I=r1[,K];
		    J=r2[,K]; 
		    VEC_CORR[K,]=CORR[I,J];
		    VEC_CONCORR[K,]=CONCORR[I,J];
		END;

	  /*--- Start overall CCC computations ---*/
		NUM  = 2*SUM(SYMSQR(COVAR)-SYMSQR(SIGMA));
		SIGMA_ALPHA = NUM/(p*(p-1));
		DEN1 = SUM(SIGMA);
		DEN2 = SSQ(BETA); CHECKDEN2 = SUM(Beta##2);
		SIGMA_ERROR2 = DEN1/p - NUM/(p*(p-1)); 
		SIGMA_ERROR = SIGMA_ERROR2;
		SIGMA_BETA = DEN2/(p*(p-1)) - SIGMA_ERROR2/N;
		DEN3 = (p*(p-1)/N)*SIGMA_ERROR;
		Rho_C = NUM / ((p-1)*DEN1 + DEN2 - DEN3);
		rho_c_check = sigma_alpha/(sigma_alpha + sigma_beta + sigma_error); 
	  /*--- End of overall CCC computations ---*/
		*print NUM DEN1 DEN2 CHECKDEN2 DEN3 
              Rho_c SIGMA_ALPHA SIGMA_BETA 
              SIGMA_ERROR1 SIGMA_ERROR2 rho_c_check;
		EFFECT=&effect;
		STAT1=NOBS||MEAN||SD;
		STAT2=CORR;
		STAT3=CONCORR;
        STAT4=Rho_c ;
		CNAMEeff={"&effect"};
		CNAME={"N" "Mean" "SD"};
  		CNAME1={"R"};
  		CNAME2={"Rc"};
  		CNAME3={"Overall Rc (OCCC)"};
        OUTNAME = {" "};
		TABLENAME={"&table"};
		OUTNAME1 = {"Overall Measure of Agreement"};
        TITLEMATRIX = {"Summary statistics (N, Mean, SD), Correlation (R) matrix,",
                       "        and Concordance Correlation (Rc) matrix.         ",
		               "CCC's and OCCC assuming a &STRUCTURE covariance matrix."};  
	    MATTRIB STAT1 ROWNAME=OUTNAME
	                  COLNAME=CNAME
					  FORMAT=&STATFMT
	                  LABEL={"&label"}; 
	    MATTRIB STAT2 ROWNAME=OUTNAME
	                  COLNAME=CNAME1
					  FORMAT=&CORRFMT
	                  LABEL={"&label"}; 
	    MATTRIB STAT3 ROWNAME=OUTNAME
	                  COLNAME=CNAME2
					  FORMAT=&CORRFMT
	                  LABEL={"&label"}; 
	    MATTRIB STAT4 ROWNAME=OUTNAME1
	                  COLNAME=CNAME3
					  FORMAT=&CORRFMT
	                  LABEL={"&label"}; 
	    MATTRIB InformationCriteria ROWNAME={"Criteria"}
	                  COLNAME=AICNAME
                      LABEL={"Information Criteria"}; 
	    MATTRIB TITLEMATRIX ROWNAME=OUTNAME
	                  COLNAME=TABLENAME
                      LABEL={" "} ; 

*       PRINT / "Summary statistics (N, Mean, SD) and",
                "correlation (R) and concordance correlation (Rc) matrices.",
		        "CCC's and OCCC are based on an assumed &STRUCTURE covariance matrix." ;
        PRINT / TITLEMATRIX
         ,,,
        &Effect STAT1
         ,,
        &Effect STAT2 
		 ,,
        &Effect STAT3
         ,, 
        STAT4
         ,,
		"Summary of Goodness-of-Fit for an assumed &STRUCTURE covariance matrix"
		 ,,
        InformationCriteria;
  FINISH;
RUN CONCORR;
quit;
%MEND CCC;
