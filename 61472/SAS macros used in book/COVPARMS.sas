/*===================== MACRO COVPARMS ========================
  Author:    Edward F. Vonesh, PhD 
  Written:   September 20, 2009 
  Modified:                                    
  Program:   This macro program performs the following:
          1) Macro COVPARMS creates a SAS dataset that contains
             parameter starting values for nonlinear mixed-
             effects models with random effects. This macro 
             appends OLS-based parameter estimates from NLMIXED
             when one has random effects with all variance-
             covariance parameters set to 0 (see example below)
             and one creates a ParameterEstimates dataset 
             (from ODS Output) that contains all fixed effects
             parameters and within-subject variance parameters.
          2) Specifically, it takes an output dataset from the 
             PREDICT statement in NLMIXED that contains the 
             derivatives of the random effects evaluated at
             the final OLS estimates from NLMIXED and obtains 
             estimated variances and covariances of the random
             effects and amends these estimates to those of 
             the fixed-effects in a final dataset defined 
             by OUTPUT=.
===============================================================
 
 
===============================================================
  NOTES 1.To successfully run this macro one MUST
            1. Specify a PREDICT statement in an initial call 
               to NLMIXED that will contain the estimated 
               residuals from a least squares (LS) fit to the 
               data in which random effects, although specified
               initially, are ignored because their variances 
               and covariances are all set equal to 0. This 
               PREDICT statement must include the option DER 
               when specified.
            2. Specify an ODS OUTPUT statement containing the 
               initial NLMIXED results one obtains when 
               essentially running a model with no random-
               effects despite the requirement that one 
               actually does specify the random effects that
               one wishes to incorporate into the model (see 
               example below). This statement is of the form
                  ODS OUTPUT ParameterEstimates='name'.
        2.OUTPUT: The program will print out the initial 
           estimated random-effects variance-covariance matrix
           as well as initial estimates of the correlations 
           of the random effects (useful for deciding whether 
           to include or exclude one or more random effects in
           the final model). It will also print the dataset
           containing all initial starting values of the
           parameters one is attempting to fit with NLMIXED.
           One can edit and delete parameters from the dataset
           to increase the speed at which NLMIXED converges 
           based on reasonable starting values.
        3.DETAILS: This macro computes approximate starting
           values for the variance-covariance matrix of the 
           random effects for nonlinear mixed-effects models in
           NLMIXED. Using input from an initial call to NLMIXED
           the macro calls GLIMMIX to compute the variance-
           covariance parameters of a linear random effects 
           model using a G-side variance-covariance structure 
           specified by the METHOD= option of the macro. One
           must run NLMIXED with the desired random effects 
           specified in the model but with all values within 
           the RANDOM statement set to 0 so that NLMIXED is
           performing an OLS analysis. One must also specify 
           the PREDICT= statement in NLMIXED such that the 
           output dataset contains the residual values from 
           the nonlinear function (i.e., resid=response-pred 
           where pred is the predicted response from each 
           observation and response is the response variable
           specified in the MODEL statement of NLMIXED).   
===============================================================
 
   Macro Key:
   PARMS    = Defines a SAS dataset defined by 
                 ODS OUTPUT ParameterEstimates='name'
              that contains OLS parameter estimates from 
              NLMIXED when all random effect variance-
              covariance parameters are set equal to 0  
   PREDOUT  = Defines a SAS dataset containing residual values 
              from an initial call to NLMIXED that are defined
              by an ID statement in combination with the 
              following general PREDICT statement  
                 PREDICT 'expression' OUT='dataset name' 
              from the initial call to NLMIXED.
   RESID    = Defines the name of the variable that is the 
              residual (y-yhat) from NLMIXED. It must be 
              defined within the initial call to NLMIXED and 
              placed in an ID statement so that it will be 
              included in the dataset 
   METHOD   = Defines what method one wishes to use to estimate
              the random effect variance-covariance parameters
              to be estimated in NLMIXED. The default is 
              METHOD=MSPL which is ML for the pseudo linear
              random effects model. 
   BOUND    = Defines whether the NOBOUND option of GLIMMIX is
              to be invoked or not. If one leaves BOUND= 
              unspecified, then variance components have a 
              default lower boundary constraint of 0. Else
              if BOUND=NOBOUND, then this boundary constraint 
              is lifted. The only valid value is BOUND=NOBOUND
              and the default is BOUND=  
              NOTE: For small datasets, it is advised to use 
                    the default BOUND=  option as otherwise the
                    macro may issue the following warning and 
                    not produce the desired output. 
                    WARNING: Optimization stopped because of 
                             infinite objective function.
                    WARNING: Output 'g' was not created.  Make 
                             sure that the output object name,
                             label or path is spelled correctly
                             Also, verify that the appropriate 
                             procedure options are used to 
                             produce the requested output 
                             object. For example, verify that 
                             the NOPRINT option is not used.
   RANDOM   = Defines the variables having prefix 'Der_'  
              created by NLMIXED corresponding to the dataset 
              specified by the DATA= statement above. These 
              are the random effect derivatives to be used in
              PROC MIXED as a means to compute the covariance 
              parameters from a first-order approximation.   
   SUBJECT  = Defines a SUBJECT variable needed in MIXED. This
              should be the same SUBJECT variable used in the
              initial call to NLMIXED 
   TYPE     = Defines the type of random-effects variance- 
              covariance matrix (typically UN or VC) assumed
   COVNAME  = Defines a prefix name to be used for the 
              character variable PARAMETER that exists within
              the dataset defined by PARMS above. This prefix
              is then used in the creation of values for 
              PARAMETER that specify starting values for the 
              random-effects variance-covariance parameters.  
   OUTPUT   = Defines a SAS dataset, say 'outname' that is to
              contain all of the parameters to be used in a 
              call to NLMIXED using the PARMS / data='outname'
              statement. This dataset will include the OLS 
              regression parameter estimates in the dataset 
              specified by PARMS= statement above as well as 
              the variance-covariance parameter estimates from
              this macro having the prefix defined by the 
              COVNAME= option above.   
=============================================================*/
%macro covparms(parms=,
                predout=, 
                resid=resid, 
                method=mspl, 
                bound=,
                random=der_u1 der_u2 der_u3,
                subject=subject,
                type=un,
                covname=psi, 
                output=parms);

	%let random=%qupcase(&random); 
	%let type=%qupcase(&type); 
	%let bound=%qupcase(&bound);
	%if %index(&bound,NOBOUND) %then %do;
	 %let BOUND=NOBOUND;
	%end;
	%else %do;
	 %let BOUND=;
	%end;
 
	ods output covparms=covparms082152;
	ods select covparms gcorr g covtests;
	proc glimmix data=&predout method=&method &bound;
	 class &subject;
	 model &resid = / dist=normal;
	 random &random / subject=&subject type=&type g gcorr;
	 covtest diagg / cl;
	run; 
	data covparms082152;
	 set covparms082152;
	  if scan(CovParm,1)='UN' then do;
	   i=scan(CovParm,2);
	   j=scan(CovParm,3); 
	   p082152a="&covname";
	   p082152b=p082152a||compress(left(i))||compress(left(j));
	   Parameter=compress(left(p082152b));
	  end;
	  else if scan(CovParm, 1, '_')='Der' then do;
	   i=scan(CovParm, 2, '_');
	   j=' ';
	   p082152a="&covname";
	   p082152b=p082152a||compress(left(i))||compress(left(j));
	   Parameter=compress(left(p082152b));
      end; 
	  else delete;
	  StandardError=StdErr;
	  keep Parameter Estimate StandardError;
	run;
	data &output;
	 set &parms covparms082152;
	 Ratio = Estimate/StandardError;
	 keep Parameter Estimate StandardError Ratio;
	run;
%mend covparms;

/*--------------------------------------------------------------*/
/* Example code illustrating how this macro works is as follows */
/* The following is the orange tree dataset which is anlayzed   */
/* using NLMIXED in combination with starting values for the    */
/* random-effect variance parameters. Simply highlight the code */
/* within the macro EXAMPLE and run it (running the macro will  */
/* not work because macros do not recognize the DATA statement  */
/* and hence will not read the otree dataset and execute.       */  
/*--------------------------------------------------------------*/
%macro example;
data otree;
 input TREE $ DAYS Y;
 INTERCEP=1;
 GROUP=1;
 x=days;
 p=7;               ** Number of observations per subject;
 psi_mm=1264.3021;  ** MM estimates from MIXNLIN;
 sig_mm=  61.6907;  ** MM estimates from MIXNLIN; 
cards;
1  118   30
1  484   58
1  664   87
1 1004  115
1 1231  120
1 1372  142
1 1582  145
2  118   33
2  484   69
2  664  111
2 1004  156
2 1231  172
2 1372  203
2 1582  203
3  118   30
3  484   51
3  664   75
3 1004  108
3 1231  115
3 1372  139
3 1582  140
4  118   32
4  484   62
4  664  112
4 1004  167
4 1231  179
4 1372  209
4 1582  214
5  118   30
5  484   49
5  664   81
5 1004  125
5 1231  142
5 1372  174
5 1582  177
;

proc sort DATA=otree;
 by tree;
run;
proc print data=otree;
run; 

proc nlmixed data=otree qpoints=1;
    parms b1=150 b2=700  b3=350 sigma=60 psi21=0 psi31=0 psi32=0;
    num = b1+u1;                                          
    e = exp(-(x-(b2+u2))/(b3+u3));                                         
    den = 1 + e;                                        
    predmean = (num/den);
    predvar = sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
    random u1 u2 u3 ~ normal([0,0,0], [psi11,
                                       psi21, psi22,
                                       psi31, psi32, psi33]) subject=tree;
    predict predmean out=predout der;
    id resid;  
run;

ods output ParameterEstimates=OLSparms;
proc nlmixed data=otree qpoints=1;
    parms b1=150 b2=700  b3=350 sigma=60;
    num = b1+u1;                                          
    e = exp(-(x-(b2+u2))/(b3+u3));                                         
    den = 1 + e;                                        
    predmean = (num/den);
    predvar = sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
    random u1 u2 u3 ~ normal([0,0,0], [0,
                                       0, 0,
                                       0, 0, 0]) subject=tree;
    predict predmean out=predout der;
    id resid;  
run;
proc print data=predout;
run;

%covparms(parms=OLSparms, predout=predout, resid=resid, method=ml, 
               random=der_u1 der_u2 der_u3, 
               subject=tree, type=un, covname=psi, output=MLEparms);
proc nlmixed data=otree qpoints=1;
    parms /data=MLEparms;
    num = b1+u1;                                          
    e = exp(-(x-(b2+u2))/(b3+u3));                                         
    den = 1 + e;                                        
    predmean = (num/den);
    predvar = sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
    random u1 u2 u3 ~ normal([0,0,0], [psi11,
                                       psi21, psi22,
                                       psi31, psi32, psi33]) subject=tree;
run;

%covparms(parms=OLSparms, predout=predout, resid=resid, method=ml, 
               random=der_u1 der_u2, 
               subject=tree, type=un, covname=psi, output=MLEparms);
proc nlmixed data=otree qpoints=1;
    parms /data=MLEparms;
    num = b1+u1;                                          
    e = exp(-(x-(b2+u2))/b3);                                         
    den = 1 + e;                                        
    predmean = (num/den);
    predvar = sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
    random u1 u2 ~ normal([0,0], [psi11,
                                  psi21, psi22]) subject=tree;
run;


%covparms(parms=OLSparms, predout=predout, resid=resid, method=ml, 
               random=der_u1 der_u2 der_u3, 
               subject=tree, type=vc, covname=psi, output=MLEparms);
proc nlmixed data=otree qpoints=1;
    parms /data=MLEparms;
    num = b1+u1;                                          
    e = exp(-(x-(b2+u2))/(b3+u3));                                         
    den = 1 + e;                                        
    predmean = (num/den);
    predvar = sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
    random u1 u2 u3 ~ normal([0,0,0], [psiu1,
                                         0  , psiu2,
                                         0  ,   0  , psiu3]) subject=tree;
run;


%covparms(parms=OLSparms, predout=predout, resid=resid, method=ml, 
               random=der_u1 der_u2, 
               subject=tree, type=vc, covname=psi, output=MLEparms);
%covparms(parms=OLSparms, predout=predout, resid=resid, method=ml, 
               random=der_u1, 
               subject=tree, type=vc, covname=psi, output=MLEparms);
proc nlmixed data=otree qpoints=1;
    parms /data=MLEparms;
    num = b1+u1;                                          
    e = exp(-(x-b2)/b3);                                         
    den = 1 + e;                                        
    predmean = (num/den);
    predvar = sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
    random u1 ~ normal(0, psiu1) subject=tree;
run;

%covparms(parms=OLSparms, predout=predout, resid=resid, method=ml, 
               random=der_u1, 
               subject=tree, type=un, covname=psi, output=MLEparms); 
/* The following is optional. One can modify the sigma parmeter manually as follows:
data MLEparms;
 set MLEparms;
 if parameter='sigma' then estimate=60;
run;
proc print data=MLEparms;run;
*/
proc nlmixed data=otree qpoints=1;
    parms /data=MLEparms;
    num = b1+u1;                                          
    e = exp(-(x-b2)/b3);                                         
    den = 1 + e;                                        
    predmean = (num/den);
    predvar = sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
    random u1 ~ normal(0, psi11) subject=tree;
run;

/* IMPORTANT EXAMPLE: A model with a random effect and conditional AR(1) correlation */
proc nlmixed data=otree qpoints=1;
    parms /data=MLEparms;
    num = b1+u1;                                          
    e = exp(-(x-b2)/b3);                                         
    den = 1 + e;                                        
    predmean = (num/den);
    predvar = sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
    random u1 ~ normal(0, psi11) subject=tree;
run;




ods output ParameterEstimates=OLSparms;
proc nlmixed data=otree qpoints=1;
    parms b1=150 b2=700  b3=350 sigma=60;
    num = b1;                                          
    e = exp(-(x-b2)/b3);                                         
    den = 1 + e;                                        
    predmean = (num/den)*(1+u1);
    predvar = (num/den)*sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
    random u1 ~ normal(0, 0) subject=tree;
    predict predmean out=predout_ der;
    id resid;  
run;

%covparms(parms=OLSparms, predout=predout_, resid=resid, method=ml, 
               random=der_u1, 
               subject=tree, type=un, covname=psi, output=MLEparms); 
proc nlmixed data=otree qpoints=1;
    parms /data=MLEparms;
    num = b1;                                          
    e = exp(-(x-b2)/b3);                                         
    den = 1 + e;                                        
    predmean = (num/den)*(1+u1);
    predvar = (num/den)*sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
    random u1 ~ normal(0, psi11) subject=tree;
run;
proc nlmixed data=otree qpoints=1;
    parms /data=OLSparms;
    num = b1;                                          
    e = exp(-(x-b2)/b3);                                         
    den = 1 + e;                                        
    predmean = (num/den);
    predvar = (num/den)*sigma; 
    resid = y - predmean;
    model y ~ normal(predmean, predvar);
run;

%mend example;
