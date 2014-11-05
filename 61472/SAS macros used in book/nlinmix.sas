/*

NOTE: The NLMIXED procedure is available beginning in SAS 8. 
PURPOSE:
The %NLINMIX macro fits nonlinear mixed models using PROC NLIN and PROC MIXED. 
HISTORY:
 Initial coding                                     01Jun92
 Revision                                           21Oct92
 Removed PROC NLIN from iterations and revised      08Mar94
 Changed syntax to include random effects                        
    explicitly, added numerical derivatives and                  
    optional Gauss-Newton steps                     19Dec94
 Added rtype=                                       09Feb95
 Changed tech= to expand=                           13Feb95
 Suggestions from Ken Goldberg, Wyeth-Ayerst        29May96
 Added random2                                      07Jan98
 More suggestions from Ken Goldberg: covparms   
    only used in iter 0 unless noprev, added   
    covpopt=,nlinopt=,nlinstmt=,outdata=,   
    nestrsub                                        16Nov98
 Fixed problem from Ken Goldberg with random2,   
    eblup, and unequal subject2 block sizes         16Apr99
 Added stmts= and deleted options involving    
    random, repeated, response, and Gauss-Newton    28Feb00
 Added append= from Andrzej Galecki, U Mich.        07Mar00
 Additional improvements from Andrzej Galecki       04Apr00
 Added nlmem=, enhanced syntax for expand=  
    from Andrzej Galecki                            15Feb01
 Added weight=                                      11Nov04

REQUIREMENTS:
Version 8 or later of base SAS and SAS/STAT software is required. 

USAGE:
Follow the instructions in the Downloads tab of this sample to save the %NLINMIX macro definition. Replace the 
text within quotes in the following statement with the location of the %NLINMIX macro definition file on your system. 
In your SAS program or in the SAS editor window, specify this statement to define the %NLINMIX macro and make it 
available for use: 

   %inc "<location of your file containing the NLINMIX macro>";

Following this statement, you may call the %NLINMIX macro. See the Results tab for an example.

The following options can be specified:

  data=    specifies the input data set. The default is
           the last created data set.

  model=   specifies the nonlinear mixed model in terms of 
           SAS programming statements using parameters of 
           your choice.  You may use multiple SAS  
           statements and auxiliary variables from the
           input data set.  The names of all fixed- and random- 
           effects parameters should be unique and not the
           same as any of the variables in the input data set.       
           You must assign the final value of the model 
           to a variable named PREDV; this is the predicted      
           value for an observation. You should enclose the 
           entire block of code with the %str() macro (see example 
           syntax below). In addition, the fixed-effects       
           parameters must be listed in the PARMS= argument       
           and the random-effects in the RANDOM= argument.    
           In your specification of PREDV, you should scale all 
           parameters so that they are all are around the same order
           of magnitude to avoid instabilities in the
           algorithm.
                                              
  modinit= specifies modeling statements to be called only    
           once at the beginning of the modeling step; this   
           option is usually used in conjunction with         
           initializing recursively defined models which      
           are to be differentiated numerically.  This code    
           should have no references to the fixed- or random- 
           effects parameters and should be enclosed with
           the %str() macro.                                

  derivs=  specifies derivatives of PREDV in the preceding model 
           specification with respect to the fixed- and random-effects 
           parameters.  The derivatives are specified using the same 
           parameter names but with "d_" appended beforehand.  You 
           may use multiple statements, auxiliary variables,  
           and variables defined in the model specification,  
           and you should enclose the entire specification    
           with the %str() macro.  If you do not specify this 
           argument, derivatives are computed numerically using 
           central differences with width tol*(1+abs(parm)), where 
           tol is from the TOL= argument.  You may also specify only
           selected derivatives and the remaining ones will be
           computed numerically.

  tol=     specifies the tolerance for numerical derivatives. 
           The default is 1e-5, and the width is computed as         
           tol*(1+abs(parm)), where parm is the parameter     
           being differentiated.                               

  parms=   specifies the starting values of the fixed-effects 
           parameters in the form %str(b1=value b2=value ...  
           bN=value).  When not using the SKIPNLIN option,     
           the form can be %str(b1=values b2=values ...       
           bN=values), where the form of the values is        
           defined in the documentation of the PROC NLIN
           PARAMETER statement.  You may also specify starting
           values for the parameters in the input data set,
           and these take precedence over those in the PARMS=
           specification if they are present.

  stmts=   specifies PROC MIXED statements to be evaluated
           at each iteration.  You must include a MODEL
           statement with dependent variable equal to
           the response variable in your input data set, but with
           the prefix "pseudo_" (e.g. "pseudo_y").  The macro 
           creates a new version of this pseudo response variable 
           during each iteration.  The independent variables in
           the MODEL statement must consist of the list
           derivatives of PREDV with respect to the fixed-effect 
           parameters (all with prefix "d_"). You must also specify 
           the NOINT and SOLUTION options in your MODEL statement.
           Include the CL option if you want approximate confidence
           limits for the fixed-effects parameters.

           You may also include one or more RANDOM statements
           with effects being one or more of the derivatives of 
           of PREDV with respect to the random-effect parameters (again, 
           all with prefix "d_"). Each derivative variable must be 
           included in one and only one RANDOM statement, and their 
           names must be unique.  You must also specify the SUBJECT=
           option in every RANDOM statement.  Multiple RANDOM 
           statements with different SUBJECT= effects enable you
           to fit nested or crossed hierarchies in your model.  Finally, 
           if you are using EXPAND=EBLUP, then you must specify the 
           SOLUTION option in at least one of the RANDOM statements.  

           Other PROC MIXED statements that you can use include 
           CLASS (good for variables comprising the SUBJECT=
           effects in your RANDOM statements), PARMS (to specify 
           starting values for the covariance parameters for the PROC 
           MIXED calls), and ESTIMATE (to compute estimates of linear 
           combinations of the fixed-effects parameters).  PROC MIXED 
           syntax rules apply throughout.

  weight=  provides code for computing a weight variable using SAS
           programming statements. These statements may reference
           auxiliary variables defined in the MODEL=
           specification (including the PREDV variable). Assign 
           the final value of the weight to the same variable 
           specified in a WEIGHT statement in the STMTS= option. 
           You should enclose the entire WEIGHT= block of code 
           with %str(),  e.g.
         
           weight=%str(
              <other SAS statements>
              _weight_= expression;
           ),
                      
           and then in STMTS= specify
           
           stmts=%str(
              <other SAS statements>
              weight _weight_;
           ),

  expand=  specifies the Taylor series expansion point. The default is 
           ZERO (Method 1 below), and EBLUP specifies the current 
           EBLUPs (Method 2 above). In addition to EXPAND=ZERO
           or EBLUP, syntax of the form EXPAND = 0 1 0 is allowed.
           Assuming there are 3 random effects the latter means
           that ZERO expansion for the first and third random effect and
           EBLUP expansion for the second random effect is used.
           EXPAND=ZERO is equivalent to EXPAND= 0 0 0. EXPAND=EBLUP is
           equivalent to EXPAND = 1 1 1. Similar feature called
           hybrid expansion is implemented in NONMEM.
           If you have no RANDOM statements in your STMTS= specification, 
           then EXPAND= has no effect.

  converge=specifies the convergence criterion for the macro. 
           The default is 1e-8.                                       

  maxit=   specifies the maximum number of iterations for the 
           macro to converge.  The default is 30.                      

  procopt= specifies options for the PROC MIXED statement.     

  nlinopt= specifies options for the PROC NLIN statement.

  nlinstmt=specifies statements to be included in the PROC NLIN call.

  switch=  specifies an iteration number to switch from EXPAND=ZERO
           to EXPAND=EBLUP.

  nlmem    points to a file containing a set of SAS macros, called NLMEM.
           NLMEM retains all the benefits of NLINMIX while allowing the
           systematic part of the model to be specified using IML syntax.   
           In particular it allows us to address advanced population 
           pharmacokinetics and pharmacodynamics models specified 
           by ordinary differential equations.
           NLMEM and examples can be downloaded from this web site.
                        
  append=  provides a means to keep data sets from every iteration.
           The syntax is one or more strings like the following:

              ds -> dsall 

           where ds is the name of a data set created during an
           iteration and dsall is the name of the new data set
           created by appending all of the different instances of
           ds throughout the iteration history.  The name ds must
           be _fit, _soln, _cov, _solnr, or a name that you specify
           for other tables using an ODS statement in your STMTS=
           code.

  outdata= specifies the name of the output working data set
           produced by %NLINMIX.  The default name is _NLINMIX.

  options= specifies %NLINMIX macro options: 

     noprint          suppresses all printing   

     notes            requests printing of SAS notes, date, and page
                      numbers during macro execution.  By default, 
                      the notes, date, and numbers are turned off
                      during macro execution and turned back on 
                      after completion.

     noprev           prevents use previous covariance parameter
                      estimates as starting values for the next
                      iteration                               

     printall         prints all PROC NLIN and MIXED          
                      steps; the final PROC MIXED step        
                      is printed by default                   

     printfirst       prints the first PROC NLIN and          
                      MIXED runs                              

     skipnlin         skips the initial PROC NLIN call        
DETAILS:
Available estimation methods are as follows, all of which are implemented via iterative calls to PROC MIXED using 
appropriately constructed pseudo data:
1.Expanding the nonlinear function about random effects parameters set equal to zero, which is similar 
  to but not the same as Sheiner and Beal's first-order method (Beal and Sheiner, 1982). This method is 
  the default for random effects specifications; that is, those using RANDOM statements in PROC MIXED.
2.Expanding the nonlinear function about random effects parameters set equal to their current empirical best 
  linear unbiased predictor (EBLUP), which is Lindstrom and Bates' approximate second-order method (Lindstrom 
  and Bates, 1990). The method is implemented using an initial call to PROC NLIN and then iterative calls 
  to PROC MIXED. This differs from Lindstrom and Bates' implementation, in which pseudo data are constructed 
  and iterative calls are made alternately to PROC MIXED and PROC NLIN. This macro's implementation requires 
  much less time and space for larger problems, and it works because solving the mixed-model equations in 
  PROC MIXED is equivalent to taking the first Gauss-Newton step in PROC NLIN (Wolfinger, 1993). Use EXPAND=EBLUP 
  to implement this method, which applies for RANDOM statement specifications in PROC MIXED. 
3.Iteratively fitting a covariance structure outside of the nonlinear function. This solves a type of second-order 
  generalized estimating equations (Prentice and Zhao, 1991). This method uses the REPEATED statement in PROC MIXED. 

The %NLINMIX macro displays an iteration history to the log (check this to verify convergence) and then displays the 
results of the final call to PROC MIXED. The fixed- and random-effect parameter estimates are prefixed by "d_" in 
the results. 

REFERENCES:
Beal, S.L. and Sheiner, L.B., eds. (1992), NONMEM User's Guide, University of California, San Francisco, NONMEM Project Group. 
Johansen, Søren (1984), Functional relations, random coefficients, and nonlinear regression with application to kinetic data, Berlin: Springer-Verlag Inc.

Lindstrom, M.J. and Bates, D.M. (1990), "Nonlinear Mixed Effects Models for Repeated Measures Data," Biometrics, 46, 673-687. 

Prentice, R.L. and Zhao, L.P. (1991), "Estimating equations for parameters in means and covariances of multivariate discrete and continuous responses," Biometrics, 47, 825-839. 

Wolfinger R.D. (1993), "Laplace's Approximation for Nonlinear Mixed Models," Biometrika, 80, 791-795. 

*/




 /*--------------------------------------------------------------*/
 /*                                                              */
 /*    %expand                                                   */
 /*    Expands argument.                                         */
 /*                                                              */
 /*--------------------------------------------------------------*/

%macro expand;
%let arg=ZERO;
%if (&argx)  %then %let arg=EBLUP;

%if %index(&expandu,&arg) & (&nu) %then %do;
 %let expandn=;
 %do i=1 %to &nu;
  %let expandn=&expandn &argx;
 %end;
%end;
%mend expand;

 /*--------------------------------------------------------------*/
 /*                                                              */
 /*    %init                                                     */
 /*    Sets the initial values for the iterations.               */
 /*                                                              */
 /*--------------------------------------------------------------*/

%macro init;

 /*---determine number of parameters---*/
%let another = 1;
%let nb = 0;
%let pos = 1;
%let prevpos = 1;
%let _error = 0;
%let fixed = ;
%let d_fixed = ;
%let d_fixedn = ;
%do %while(&another = 1);
   %let effect = %scan(&parms,&pos,' ' =);
   %if %length(&effect) %then %do;
      %let fixed = &fixed &effect;
      %let d_fixed = &d_fixed d_&effect;  
      %let d_fixedn = &d_fixedn der.&effect;  
      %let nb = %eval(&nb + 1);
      %let pos = %eval(&pos + 2);
   %end;
   %else %let another = 0;
%end;

/*---response and random effects---*/
%let another = 1;
%let nu = 0;
%let random = ;
%let d_random = ;
%let iv = 1;
%do %while (%length(%scan(&stmts,&iv,;)));
   %let stmt = %qscan(&stmts,&iv,%str(;));
   %let first = %qscan(&stmt,1);
   %if %index(%qupcase(&first),MODEL) %then %do;
      %let pseudoresp = %scan(&stmt,2,' ' =);
      %let i = %index(&pseudoresp,_);
      %let i = %eval(&i + 1);
      %let response = %substr(&pseudoresp,&i);
   %end;
   %else %if %index(%qupcase(&first),RANDOM) %then %do;
      %let i = %index(&stmt,/);
      %let ir = %index(%qupcase(&stmt),RANDOM);
      %let rndeff = %substr(&stmt,%eval(&ir+7),(%eval(&i-&ir-7)));
      %let ive = 1;
      %do %while (%length(%scan(&rndeff,&ive,' ')));
         %let d_effect = %scan(&rndeff,&ive,' ');
         %let effect = %substr(&d_effect,3);
         %let random = &random &effect;
         %let d_random = &d_random &d_effect;
         %let nu = %eval(&nu + 1);
         %let ive = %eval(&ive + 1);
      %end;
   %end;
   %let iv = %eval(&iv + 1);
%end;

%let expandu = %qupcase(&expand);

%if (&nu) %then %do;
  %let expandn=&expand;
  %let argx=0; %expand
  %let argx=1; %expand
  %let argx=0;
  %do i=1 %to &nu;
    %if (%scan(&expandu,&i) =1  ) %then %let argx=1;
  %end;
  %if (&argx) | %index(&expandu,EBLUP) %then %let expandu=EBLUP;
  %else %let expandu=ZERO;
%end;

%if not %index (&expandu,EBLUP) | (&switch > 0) %then   
   %let expandu = ZERO;

%if %index(&options,DEBUG) %then %do;
   %put model = &model;
   %put derivatives = &derivs;
   %put weight = &weight;
   %put fixed = &fixed;
   %put d_fixed = &d_fixed;
   %put random = &random;
   %put d_random = &d_random;
   %put options =&options;
   %put expand  =&expand;
   %put expandu =&expandu;
   %put expandn =&expandn;

   %if %length(&nlmem)>0 %then %do;
   %put subject  = &subject;
   %put next     = &next;
   %put imlnlin  = &imlnlin;
   %put imlnlinw = &imlnlinw;
   %put dtmplt   = &dtmplt;
   %put dbtmplt  = &dbtmplt;
   %put dutmplt  = &dutmplt;
   %end;
%end;


 /*---starting values for b and u---*/
data &outdata;
   set %unquote(&data);
   %if (&nb) %then %do;
      array _b{&nb} &fixed;
      %let idx = 1;
      %do i = 1 %to &nb;
         if _b{&i} =. then %scan(&parms,&idx,' ' =) = 
            %scan(&parms,%eval(&idx+1),' ' =);
         %let idx = %eval(&idx + 2);
      %end;
   %end;
   %if (&nu) %then %do;
      array _u{&nu} &random;
      %do i = 1 %to &nu;
         if _u{&i} =. then %scan(&random,&i,' ') = 0;
      %end;
   %end;
   _one = 1;
run;

 /*---grab all specified variables---*/

/*     xvar specifies list of time independent variables  */
/*     tvar specifies list of time dependent variables    */
/*     dtvar identifies all vars except xvar              */  
 
%let xvar=_one &subject &xvar;

proc contents data=&outdata (drop=&fixed &random &xvar)
         noprint  out=_contentsoutdata(keep=name);
run;
  
data _null_;
   set _contentsoutdata end=last;
   len = length(name)+1;
   lenc + len;
   if last then call symput('lenc',lenc+1);
run;

data _null_;
   set _contentsoutdata end=last;
   length dtvar $ &lenc;   
   retain dtvar '';
   dtvar = trim(dtvar) ||' '|| left(name);
   if last then call symput('dtvar',dtvar);
run;

%if %length(&tvar)=0 %then %let tvar=&dtvar;
%let dtallvar=&xvar &tvar;

%if %index(&options,DEBUG) & %length(&nlmem)>0  %then %do;
   %put next    = &next;
   %put read    = &read_all;
   %put subject = &subject;
   %put xvar    = &xvar;
   %put tvar    = &tvar;
%end;

%mend init;


 /*------------------------------------------------------*/
 /*                                                      */
 /*   %numder                                            */
 /*   numerical derivatives                              */
 /*                                                      */
 /*------------------------------------------------------*/

%macro numder;
   %if (&nb) %then %do;
      do _i = 1 to &nb;
         if _db{_i} = . then do;
           _b0 = _b{_i};
           _tol = &tol*(1+abs(_b0));
           _b{_i} = _b0 - _tol;
           &model
           _predl = predv;
           _b{_i} = _b0 + _tol;
           &model
           _predu = predv;
           _db{_i} = (_predu - _predl)/2/_tol; 
           _b{_i} = _b0;
         end;
      end;
   %end;
   %if (&nu) %then %do;
      do _i = 1 to &nu;
         if _du{_i} = . then do;
           _u0 = _u{_i};
           _tol = &tol*(1+abs(_u0));
           _u{_i} = _u0 - _tol;
           &model
           _predl = predv;
           _u{_i} = _u0 + _tol;
           &model
           _predu = predv;
           _du{_i} = (_predu - _predl)/2/_tol; 
           _u{_i} = _u0;
         end;
      end;
   %end;

   %if %index(&options,DEBUG) %then &model;

%mend numder;


 /*------------------------------------------------------*/
 /*                                                      */
 /*   %nlin                                              */
 /*   PROC NLIN call                                     */
 /*                                                      */
 /*------------------------------------------------------*/
%macro nlin;

%if (not %index(&options,NOPRINT)) & (&nu) %then %do;
   %put Calling PROC NLIN to initialize.;
%end;

proc nlin data=&outdata(keep=&dtallvar &random) &_printn_ 
   %unquote(&nlinopt);
   array _b{&nb} &fixed;
   array _db{&nb} &d_fixed;
   array _derb{&nb} &d_fixedn;
   %if (&nu) %then %do;
      array _u{&nu} &random;
      array _du{&nu} &d_random;
   %end;

   /*---set starting values---*/
   parms %unquote(&parms);

   /*---compute the nonlinear function and its derivatives---*/
   &modinit
   &model
   model %unquote(&response) = predv;
   &weight
   &derivs
   %numder
   do i = 1 to &nb;
      _derb{i} = _db{i};
   end;

   output out=&outdata parms=&fixed;
   %unquote(&nlinstmt);
   drop i;
run;

%if %index(&options,DEBUG) %then %do;
   %debug(&outdata, -8);
   %put Ignore warning message(s) listed above of the type:; 
   %put Variable X was not found on DATA file.;      
%end;

%mend nlin;


 /*----------------------------------------------------------*/
 /*                                                          */
 /*   %pseudoder                                             */
 /*   construct pseudo data and derivatives                  */
 /*                                                          */
 /*----------------------------------------------------------*/
%macro pseudoder;

data &outdata;
   set &outdata(keep=&dtallvar &fixed &random) end=_last;
   %if (&nb) %then %do;
      array _b{&nb} &fixed;
      array _db{&nb} &d_fixed;
   %end;
   %if (&nu) %then %do;
      array _u{&nu} &random;
      array _du{&nu} &d_random;
   %end;
   &modinit
   &model
   &pseudoresp = %unquote(&response) - predv;
   %if %index(&options,DEBUG) %then %do;
      _pseudoy = &pseudoresp;
   %end;
   &weight
   &derivs
   %numder
   if (&pseudoresp ne .) then do;
      %if (&nb) %then %do;
         do _i = 1 to &nb;
            &pseudoresp = &pseudoresp + _db{_i}*_b{_i};
         end;
      %end;
      %if (&nu) & (&expandu=EBLUP) %then %do;
         %do i = 1 %to &nu;
            %if (%scan(&expandn,&i)=1) %then
            &pseudoresp = &pseudoresp + _du{&i}*_u{&i};;
         %end;
      %end;
   end;
   if (_error_ = 1) then do;
      call symput('_error',left(_error_));
      stop;
   end;
   drop _i;
run;

%mend pseudoder;

 /*----------------------------------------------------------*/
 /*                                                          */
 /*   %mixed                                                 */
 /*   PROC MIXED step                                        */
 /*                                                          */
 /*----------------------------------------------------------*/
%macro mixed;

%let ncall = %eval(&ncall + 1);
%if not %index(&options,NOPRINT) %then
   %put %str(   )PROC MIXED call &ncall;

proc mixed data=&outdata %unquote(&procopt) ;
   %unquote(&stmts)
   %if (&nu) & (&ncall>0) & not %index(&options,NOPREV) & 
      not %index(&stmts,PARMS) %then
         %str(parms / pdata=_covsave;) ;
   ods output fitstatistics=_fit;
   %if (&nb) %then %do;
      ods output solutionf=_soln;
   %end;
   %if (&nu) %then %do;
      ods output covparms=_cov;
      %if (&nu) & (&expandu=EBLUP) %then %do;
         ods output solutionr=_solnr;
      %end;
   %end;
run;

%if %length(&append) %then %apploop(&appnd,append);

 /*---check for convergence---*/
%let there = 0;
data _null_;
   set _fit;
   call symput('there',1); 
run;
%if (&there = 0) %then %do;
   %if not %index(&options,NOPRINT) %then   
      %put PROC MIXED did not converge.;
   %let _error = 1;
%end;

%mend mixed;


 /*-----------------------------------------------------------*/
 /*                                                           */
 /*   %merge                                                  */
 /*   merge in new estimates of b and u                       */
 /*                                                           */
 /*-----------------------------------------------------------*/
%macro merge;

 /*---merge in b---*/
%if (&nb) %then %do;
   proc transpose data=_saveb out=_beta;
      var estimate;
   run;

   data _beta;
      set _beta;
      array _b{&nb} &fixed;
      %do i = 1 %to &nb;
         _b{&i} = col&i;
      %end;
      _one = 1;
      keep _one &fixed;
   run;
   
   data &outdata;
      merge &outdata(drop=&fixed) _beta;
      by _one;
   run;
%end;

 /*---merge in u---*/
%if (&nu) & (&expandu=EBLUP) %then %do;
   
   /*---loop through RANDOM statements---*/
   %let nui=0;
   %let iv = 1;
   %do %while (%length(%scan(&stmts,&iv,;)));

      %let stmt = %qscan(&stmts,&iv,%str(;));
      %let first = %qscan(&stmt,1);

      %if %index(%qupcase(&first),RANDOM) %then %do;

         /*---peel off pieces---*/
         %let i = %index(&stmt,/);
         %let ir = %index(%qupcase(&stmt),RANDOM);
         %let rndeff = %substr(&stmt,%eval(&ir+7),(%eval(&i-&ir-7)));
         %let rndopt = %substr(&stmt,(%eval(&i+1))); 
         %let i = %index(%qupcase(&rndopt),SUBJECT);
         %let rndsub = %substr(&rndopt,&i);
         %let i = %index(&rndsub,=);
         %let rndsub = %qscan(%substr(&rndsub,(%eval(&i+1))),1);
         %let subvar=;
         %let i=1;
         %do %while(%length( %scan(&rndsub,&i,%str( *())) ));
            %let subvar=&subvar %scan(&rndsub,&i,%str( *()));
            %let i=%eval(&i+1);
         %end;

         /*---loop through effects in this statement---*/
         %let ive = 1;
         %do %while (%length(%scan(&rndeff,&ive,' ')));

            %let d_effect = %scan(&rndeff,&ive,' ');
            %let effect = %substr(&d_effect,3);
            %let nui=%eval(&nui+1);
          %if %scan(&expandn,&nui)=1 %then %do;
            data _eblup;
               set _saveu;
               deff = "&d_effect";
               if (upcase(effect) = upcase(deff));
               /*---convert to numeric---*/
               &effect = estimate;
               keep &subvar &effect; 
            run;

            proc sort data=_eblup;
               by &subvar;
            run;

            proc sort data=&outdata;
               by &subvar;
            run;

            data &outdata;
               merge &outdata(drop=&effect) _eblup;
               by &subvar;
            run;
          %end;             
          %let ive = %eval(&ive + 1);
         %end;
      %end;
      %let iv = %eval(&iv + 1);
   %end;

%end;

%mend merge;


 /*-------------------------------------------------------*/
 /*                                                       */
 /*    %iterate                                           */
 /*    Iteration process                                  */
 /*                                                       */
 /*-------------------------------------------------------*/
%macro iterate;

 /*---initial data set for iterinfo---*/
data _beta;
   set &outdata(obs=1);
   %if (&nb) %then %do;
      keep &fixed;
   %end;
run;

 /*---initial macro variables---*/
%let crit = .;
%let conv = 0;
%let ni = 0;
%let ncall = -1;

 /*---iterate until convergence---*/
%do %while(&ni <= &maxit);

   %if (&ni = 0) and not %index(&options,NOPRINT) %then
      %put Iteratively calling PROC MIXED.;

   %if (&switch > 0) and (&ni = &switch) %then %do;
      %let expandu = EBLUP;
      %let ni = 0;
      %let switch = 0;
      %put Switching from EXPAND=ZERO to EXPAND=EBLUP;
   %end;

   /*---save estimates---*/
   %if (&ni ne 0) and (&nu) %then %do;
      data _covold;
         set _covsave;
         estold = estimate;
         keep estold;
      run;
   %end;
   %if (&ni ne 0) and (&nb) %then %do;
      data _solnold;
         set _saveb;
         estold = estimate;
         keep estold;
      run;
   %end;
 
   /*---set up pseudo data and compute first step---*/
   %pseudoder
   %if %index(&options,DEBUG) %then %debug(&outdata,&ni);
   %if (&_error = 1) %then %goto finish;
   %mixed
   %if (&_error = 1) %then %goto finish;

   %if (&nu) %then %do;
      data _covsave;
         set _cov;
      run;
   %end;

   /*---check for convergence---*/
   %if (&ni ne 0) %then %do;
      %let crit = 0;
      %if (&nu) %then %do;
         data _null_;
            merge _cov _covold end=last;
            retain cr &crit;
            crit = abs(estimate-estold)/
               max(abs(estold),max(abs(estimate),1));
            %if %index(&options,WORST) %then %do;
               if (crit > cr) then do;
                  call symput('worst',left(estold));
               end;
            %end;
            cr = max(cr,crit);
            if last then do;
               call symput('crit',left(cr));
            end;
         run;
      %end;
      %if (&nb) %then %do;
         data _null_;
            merge _soln _solnold end=last;
            retain cr &crit;
            crit = abs(estimate-estold)/
               max(abs(estold),max(abs(estimate),1));
            %if %index(&options,WORST) %then %do;
               if (crit > cr) then do;
                  call symput('worst',left(estold));
               end;
            %end;
            cr = max(cr,crit);
            if last then do;
               call symput('crit',left(cr));
            end;
         run;
      %end;
      data _null_;
         cr = &crit;
         if (cr < &converge) then call symput('conv',left(1));
      run;
   %end;
   %else %if %index(&options,PRINTFIRST) %then %do;
      ods exclude all;
   %end;
   %if not %index(&options,NOPRINT) %then %do;
      %put %str(   );
      %put iteration = &ni;
      %put convergence criterion = &crit;
      %getbc;
      %put &bstr &cstr;
      %if %index(&options,WORST) %then %do;
         %put worst = &worst;
      %end;
   %end;
   %if (&conv = 1) %then %do;
      %let maxit = -1;
   %end;
   %else %let ni = %eval(&ni + 1);

   /*---save step---*/
   %if (&nb) %then %do;
      data _saveb;
         set _soln;
      run;
   %end;
   %if (&nu) & (&expandu=EBLUP) %then %do;
      data _saveu;
         set _solnr;
      run;
   %end;
   %merge;

   /*---get rid of fitting data set---*/
   %if (&there = 1) %then %do;
      proc datasets lib=work nolist;
         delete _fit;
      quit;
   %end;
%end;

 /*---turn on printing and options---*/
%finish:
ods select all;
%let _printn_ = ;
%let niter = &ni;
%if not %index(&options,NOTES) %then %do;
   options notes date number;
%end;

%if not %index(&options,NOPRINT) %then %do;
   %if (&conv = 1) %then %do;
      %put NLINMIX convergence criteria met.;
      /*---compute final results---*/
      %pseudoder
      %if %index(&options,DEBUG) %then %debug(&outdata,&ni+0.1);
      %if (&expandu = ZERO) %then %let expandu = EBLUP;
      %mixed
   %end;
   %else %put NLINMIX did not converge.;
%end;

%mend iterate;



 /*------------------------------------------------------------*/
 /*                                                            */
 /*    %baseinfo                                               */
 /*    Print basic information about the macro                 */
 /*                                                            */
 /*------------------------------------------------------------*/
%macro baseinfo;

%put;
%put %str(                          The NLINMIX Macro);
%put;
%put %str(           Data Set                     : &data);
%put %str(           Response                     : &response);
%if (&nb) %then 
%put %str(           Fixed-Effect Parameters      : &fixed);
%if (&nu) %then
%put %str(           Random-Effect Parameters     : &random);
%if (&nu) %then
%put %str(           Expansion Point              : &expand);
%put;
%put;

%mend baseinfo;

 /*----------------------------------------------------------*/
 /*                                                          */
 /*    %getbc                                                */
 /*    load current estimate of b into macro variables       */
 /*                                                          */
 /*----------------------------------------------------------*/
%macro getbc;

%let bstr = ;
%let cstr = ;

%if (&nb) %then %do;
   data _beta;
      set _beta;
      %do i = 1 %to &nb;
         call symput("bb&i",left(%scan(&fixed,&i,' ')));
      %end;
   run;

   %do i = 1 %to &nb;
      %let bstr = &bstr %scan(&fixed,&i,' ')=&&bb&i;
   %end;
%end;

%if (&nu) %then %do;
   data _null_;
      set _cov nobs=count;
      call symput('ncov',left(put(count,8.)));
   run;

   data _null_;
      set _cov;
      %do i = 1 %to &ncov;
         if (_n_ = &i) then do;
            call symput("cc&i",left(estimate));
         end;
      %end;
   run;

   %do i = 1 %to &ncov;
      %let cstr = &cstr COVP&i=&&cc&i;
   %end;
%end;

%mend getbc;


/*---appending macros---*/
%macro appnd;
   %let tmp=&append;
   %let lentmp=%length(&tmp);
   %let i=%index (&tmp,->);
   %let line=%substr(&tmp,1,%eval(&i-1));
   %let appnd=%str(&line \);
   
   %next:
   %let tmp=%substr(&tmp,%eval(&i+2),%eval(&lentmp-&i-1));
   %let lentmp=%length(&tmp);
   %let i=%index(&tmp,->);
   
   %if not &i %then %goto fin;
   %let line=%substr(&tmp,1,%eval(&i-1));
   %let lenline=%length(&line);
   %let out=%scan(&line,1,%str( ));
   %let appnd=&appnd &out |;
   
   %if &i %then %do;
   %let lenout=%length(&out);
   %let in =%substr(&line,%eval(&lenout+1),%eval(&lenline-&lenout));
   %let appnd=&appnd &in \;
   %goto next;
   %end;
   %fin:
   %let appnd=&appnd &tmp;
%mend appnd;

%macro apploop(appnd,doappnd);
   %let i=0;
   %do %while (%length(%scan(&appnd,%eval(&i+1),|)));
      %let i=%eval(&i+1);
      %let tmp=%scan(&appnd,&i,|);
      %let in =%scan(&tmp,1,\); %* dsn with options;
      %let out=%scan(&tmp,2,\); %* dsn without options;
      %*put &i  &in  -> &out;

      %let in1 =%scan(&in,1,'('); %*dsn without options;
      %let out1=%scan(&out,1,'(');
      
      %let lbin=work;
      %let dtin=&in1;
      %if  %index(&in1,.) %then %do;
         %let lbin=%scan(&in1,1,.);
         %let dtin=%scan(&in1,2,.);
      %end;

      %let lbout=work;
      %let dtout=&out1;
      %if  %index(&out1,.) %then %do;
         %let lbout=%scan(&out1,1,.);
         %let dtout=%scan(&out1,2,.);
      %end;
      %&doappnd;
   %end;
%mend apploop;

%macro appdel;
   proc datasets lib=&lbout nolist;
      delete &dtout;
   quit;
%mend appdel;

%macro append;
   data _out;
      set  &in;
      _switch=&switch;
      _ni = &ni;
      _iter=_ni;
      if _switch=0 then _iter=_ni+&switchadd; 
      _call = &ncall+1;
   run;
   
   proc append base=&out force data=_out;
   run;
%mend append;

%macro debug(data,ni);
   data debug;
      set &data;
      _switch=&switch;
      _ni = &ni;
      _iter=_ni;
      if _switch=0 then _iter=_ni+&switchadd; 
   run;

   proc print data=debug(obs=30);
   run;

   proc append base=alldebug data=debug force;
   run;
%mend debug;


 /*------------------------------------------------------------*/
 /*                                                            */
 /*    %nlinmix()                                              */
 /*    the main macro                                          */
 /*                                                            */
 /*------------------------------------------------------------*/

%macro nlinmix_init;

   /*---default data set---*/
   %if %bquote(&data)= %then %let data=&syslast;

   %let options = %qupcase(&options);

   %let switchadd=&switch;
 

   /*---initialize---*/
   %if not %index(&options,NOTES) %then %do;
      options nonotes nodate nonumber;
   %end;
%mend nlinmix_init;


%macro nlinmix(data=,modinit=,model=,weight=,derivs=, tol=1e-5,
   parms=,stmts=,expand=zero,converge=1e-8,maxit=30,switch=0,
   append=,procopt=,nlinopt=,nlinstmt=,outdata=_nlinmix,options=,
   /*---NLMEM macro specific arguments---*/
   nlmem=, imlfun=,  globvar=, retain=,
   next=1, xvar=, tvar=, savevar=, dtmplt=, debug=,
   imlnlin= default_nlin default_objf default_initobjf
);

 /*---check for mandatories---*/
%if %bquote(&model)= %then %let missing = MODEL=;
%else %if %bquote(&stmts)= %then %let missing = STMTS=;
%else %let missing =;
%if %length(&missing) %then %do;
   %put ERROR: The NLINMIX &missing argument is not present.;
%end;
%else %do;

   /*---global variables---*/
   %global _printn_ _error;

   /*---local variables---*/

   %local nb nu no ni ncall response pseudoresp fixed d_fixed d_fixedn
      random d_random crit bstr cstr there appnd dtvar nlmemlocal
      dtallvar subject xvar tvar expandn expandu switchadd;

%if %length(&nlmem)=0 %then %do;
   
   %let tvar=; 
   %let xvar=;
   %let subject=;

   %nlinmix_init
   %init
%end;
%else %do;
  %local nlmem_local;
  *read_all _resdr iml_catalog  imlnlinw imlnlin_default
      imlstore_catalog imlload_catalog dbtmplt dutmplt;

  /* Include nlmem file with a set of NLMEM macros */
      %include &nlmem;
      %local &nlmemlocal;
      %nlinmix_init
      %nlmem_init
  %end;

   proc datasets nolist;
      delete alldebug;
   quit;

   %if %index(&options,DEBUG) %then %do;
   %pseudoder;
   %debug(&outdata,-9);
   %end;

   %if %length(&append) %then %do;
      %appnd;
      %apploop(&appnd,appdel);
   %end;

   %if %index(&options,PRINTALL) or %index(&options,PRINTFIRST) 
      %then %do;
      ods select all;
      %let _printn_ = ;
   %end;
   %else %do;
      ods exclude all;
      %let _printn_ = noprint;
   %end;

   /*---print basic macro information---*/
   %if not %index(&options,NOPRINT) %then %baseinfo;

   /*---run PROC NLIN to get initial estimates---*/
   %if (&nb) & not %index(&options,SKIPNLIN) %then %do;
      %if not (&nu) %then %let _printn_ = ;
      %nlin;
   %end;

   /*---iterate PROC MIXED calls until convergence---*/
   %iterate;

%end;

%mend nlinmix;

