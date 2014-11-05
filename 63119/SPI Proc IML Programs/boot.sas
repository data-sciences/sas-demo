libname SPI (SASUSER);                  /* location of data sets */
%let Have922OrGreater = 0;              /* set to 1 if you have SAS/IML 9.22, 9.3, ...*/

%macro LoadPre922Modules();
   %if ^&Have922OrGreater %then %do;
      %include SPImodules922;            /* read module definitions    */
   %end;
%mend;

/* extract random sample of movies for 2005-2007 */
data Sample;
   set SPI.Movies;
   if (ranuni(1)<0.25);
run;

proc iml;
   %include SPImodules;                  /* read module definitions    */
   %LoadPre922Modules();

   /* read in movies */
   use Sample;
   read all var {Budget} into x;
   close Sample;
   
   /* bootstrap method: the statistic to bootstrap is the mean */
   /* 1. Compute the statistic on the original data */
   Mean = x[:];                             /* sample mean             */

   /* 2. Resample B times from the data (with replacement) 
      to form B bootstrap samples. */
   call randseed(12345);
   B = 1000;
   n = nrow(x);
   EQUAL = .;
   xBoot = SampleWithReplace(x, B||n, EQUAL);

   /* 3. compute the statistic on each resample */   
   s = xBoot[,:];       

   /* 5. Compute standard errors and confidence intervals. */
   MeanBoot = s[:];                   /* a. mean of bootstrap dist     */
   StdErrBoot = sqrt(var(s));         /* b. std error                  */
   alpha = 0.05;
   prob = alpha/2 || 1-alpha/2;       /* lower/upper percentiles       */
   call qntl(CIBoot, s, prob);        /* c. quantiles of sampling dist */
   print MeanBoot StdErrBoot CIBoot;

   /* Compute traditional estimates for the sampling distribution of
      the mean by computing statistics of the original data */
   StdErr = sqrt(var(x)) / sqrt(n);   /* estimate SEM                  */
   t = quantile("T", prob, n-1);      /* percentiles of t distribution */
   CI = Mean + t * StdErr;            /* 95% confidence interval       */
   print Mean StdErr CI;


proc iml;
   %include SPImodules;                  /* read module definitions    */
   %LoadPre922Modules();

   /* compute bootstrap estimate for difference between means of two groups */
   use Sample where (MPAARating="PG-13");    /* read data from group 1 */
   read all var {Budget} into x1;
   use Sample where (MPAARating="R");        /* read data from group 2 */
   read all var {Budget} into x2;
   close Sample;
   
   /* 1. compute bootstrap distribution for difference between means   */
   call randseed(12345);
   B = 1000;
   n1 = nrow(x1);
   n2 = nrow(x2);
   EQUAL = .;
   Boot1 = SampleWithReplace(x1, B||n1, EQUAL);   /* resample B times  */
   Boot2 = SampleWithReplace(x2, B||n2, EQUAL);   /*   from each group */
   
   /* 2. difference between the B means computes for each resample     */
   s1 = Boot1[,:];                      /* means of B resample from x1 */
   s2 = Boot2[,:];                      /* means of B resample from x2 */
   s = s1 - s2;                         /* difference of means         */
   
   /* 3. Compute bootstrap estimate for 95% C.I. */
   alpha = 0.05;
   prob = alpha/2 || 1-alpha/2;
   call qntl(CIBoot, s, prob); 
   print CIBoot;



proc iml;
   /* Use the SURVEYSELECT procedure to generate bootstrap resamples */
   x = {A,B,C,D};
   create BootIn var {"x"};        
   append;
   close BootIn;

   /* use SURVEYSELECT to resample */
   N = nrow(x);
   B = 5;
   call symputx("N",N); call symputx("B",B);
quit;

   proc surveyselect data=BootIn out=BootSamp noprint
        seed   = 12345               /*  1 */
        method = urs                 /*  2 */
        n      = &N                  /*  3 */
        rep    = &B                  /*  4 */
        OUTHITS;                     /*  5 */
   run;
   proc print data=BootSamp; 
      var Replicate x;
   run;

   proc surveyselect data=BootIn out=BootSamp2 noprint
        seed   = 12345               /*  1 */
        method = urs                 /*  2 */
        n      = &N                  /*  3 */
        rep    = &B                  /*  4 */
        ;                            /*  5 */
   proc print data=BootSamp2; 
   run;


   /* use SURVEYSELECT to resample; use PROC to compute statistics */
%let DSName = Sample;                          /* 1 */
%let VarName = Budget;
%let B = 1000;
   
   /* generate bootstrap resamples */
   proc surveyselect data=&DSName out=BootSamp noprint
        seed=12345  method=urs  rep= &B
        rate   = 1;                            /* 3 */
   run;

   /* use procedure to compute statistic on each resample */
   proc means data=BootSamp noprint;           /* 4 */
      by Replicate;                            /*  a */
      freq NumberHits;                         /*  b */
      var &VarName;
      output out=BootDist mean=s;              /*  c */
   run;

   /* create histogram of bootstrap distribution */
   proc sgplot data=BootDist;
   Histogram s;
   run;

   /* compute principal component analysis of data */
%let DSName = Sample;
%let VarNames = Budget US_Gross Sex Violence Profanity;
   
   ods select NObsNVar EigenValues Eigenvectors;
   proc princomp data=&DSName;
      var &VarNames;
      ods output Eigenvalues=EigenValues;
   run;


   /* use SURVEYSELECT to resample; use PROC to compute statistics */
%let B = 1000;                       /* number of bootstrap samples */
   
   /* generate bootstrap resamples */
   proc surveyselect data=&DSName out=BootSamp noprint
        seed=12345 method=urs rate=1 rep=&B;
   run;
   
   /* Compute the statistic for each bootstrap sample */
   ods listing exclude all;
   proc princomp data=BootSamp;
      by   Replicate;
      freq NumberHits;
      var  &VarNames;
      ods output Eigenvalues=BootEVals(keep=Replicate Number Proportion);
   run;
   ods listing exclude none;

