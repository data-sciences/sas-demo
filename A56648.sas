 /*-------------------------------------------------------------------*/
 /* Multiple Comparisons and Multiple Tests Using the SAS(r) System   */
 /*          by Westfall, Tobias, Rom, Wolfinger, Hochberg            */
 /*       Copyright(c) 1999 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 56648                  */
 /*                        ISBN 1-58025-397-0                         */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS Institute Inc.  There    */
 /* are no warranties, expressed or implied, as to merchantability or */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this material as it now exists or will exist, nor does the     */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* Books by Users                                                    */
 /* Attn: Peter Westfall, et al.                                      */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Peter Westfall, et al.                           */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Date Last Updated: 1Jun00                                         */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /*                          NOTES                                    */
 /*-------------------------------------------------------------------*/                                                                   */
 /*                                                                   */ 
 /* 1. The %SimTests macro provides closed testing in a conservative  */
 /* but not alpha-exhaustive sense for the case of two-sided alter-   */
 /* natives.  For the case of one-sided alternatives, the tests are   */
 /* technically not closed at all, since the closure involves         */
 /* intersections of half-spaces and not point nulls.  Nevertheless,  */
 /* the method is powerful and still controls the FWE as discussed by */
 /* Westfall and Young (1993, p. 74).                                 */
 /*                                                                   */ 
 /* 2. In Version 8.1 of SAS, PROC MULTTEST will include adjusted     */
 /* p-values using Hommel's 1988 method.  It also will include        */
 /* p-values using Fisher closed tests.  Enhancements to the STRATA   */
 /* option have been included as well to make the unadjusted p-values */
 /* conform exactly with either Type II or Type III tests.            */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 
 /*-------------------------------------------------------------------*/
 /*                           UPDATES                                 */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /*  1. 12/99 Renumbered and relabeled the Programs on this web page  */
 /*  to correspond with the book.                                     */
 /*                                                                   */
 /*  2. 12/99 Updated the %SimTests macro as follows:                 */
 /*      i. Changed all SEAdjP values to 0 when reported as < 1E-8    */
 /*     ii. Fixed a bug that caused incorrect computations when there */
 /*         are pairwise collinear contrasts                          */
 /*                                                                   */
 /*  3. 12/99 changes made to Program 4.4.  The program as given in   */
 /*  the book and initially on the web page did not work.  The        */
 /*  as given on this web page works.                                 */
 /*                                                                   */
 /*  4. The %Williams macro was updated on Dec 7, 1999.  The original */ 
 /*  implementation used the isotonic regression estimate of the      */ 
 /*  control group mean rather then the sample mean as in Williams    */ 
 /*  (1972) second procedure which was found later by Marcus (1976)   */
 /*  to be superior in most cases. However, PROBMC employs the        */
 /*  critical points from the distribution that uses the sample mean  */
 /*  of the control group, therefore, a revision  to the %Williams    */
 /*  macro is indicated. We would like to thank Agnes Kovacs who has  */
 /*  brought up the issue.                                            */ 
 /*                                                                   */
 /*-------------------------------------------------------------------*/


 

/* Program 2.4: Bonferroni and Sidak Adjusted p-values Using the DATA Step */

data one;
   input test pval @@;
   bon_adjp = min(1,10*pval);
   sid_adjp = 1 - (1-pval)**10;
   datalines;
1 0.0911    2 0.8912
3 0.0001    4 0.5718
5 0.0132    6 0.9011
7 0.2012    8 0.0289
9 0.0498   10 0.0058
;
proc sort data=one out=one;
   by pval;
proc print data=one;
   run;



/* Program 2.5: Bonferroni and Sidak Adjusted p-values Using PROC MULTTEST */

data one; set one;
   rename pval=raw_p;
   drop bon_adjp sid_adjp;
proc multtest pdata=one bon sid out=outp;
proc sort data=outp out=outp;
   by raw_p;
proc print data=outp;
run;


/* Program 2.6: Conservative Simultaneous Confidence Intervals with Multivariate Data */

   data _null_;
      call symput('bonalpha',0.05/9           );
      call symput('sidalpha',1-(1-0.05)**(1/9));
   data HusbWive;
      input HusbQ1-HusbQ4 WifeQ1-WifeQ4 @@;
      DiffQ1 = HusbQ1-WifeQ1;
      DiffQ2 = HusbQ2-WifeQ2;
      DiffQ3 = HusbQ3-WifeQ3;
      DiffQ4 = HusbQ4-WifeQ4;
      DiffQAvg = sum(of HusbQ1-HusbQ4)/4 - sum(of WifeQ1-WifeQ4)/4;
      DiffComp = sum(of HusbQ1-HusbQ2)/2 - sum(of WifeQ1-WifeQ2)/2;
      DiffPass = sum(of HusbQ3-HusbQ4)/2 - sum(of WifeQ3-WifeQ4)/2;
      DiffFFP  = sum(of HusbQ1 HusbQ3)/2 - sum(of WifeQ1 WifeQ3)/2;
      DiffFFY  = sum(of HusbQ2 HusbQ4)/2 - sum(of WifeQ2 WifeQ4)/2;
    datalines;
   2 3 5 5   4 4 5 5      5 5 4 4   4 5 5 5      4 5 5 5   4 4 5 5
   4 3 4 4   4 5 5 5      3 3 5 5   4 4 5 5      3 3 4 5   3 3 4 4
   3 4 4 4   4 3 5 4      4 4 5 5   3 4 5 5      4 5 5 5   4 4 5 4
   4 4 3 3   3 4 4 4      4 4 5 5   4 5 5 5      5 5 4 4   5 5 5 5
   4 4 4 4   4 4 5 5      4 3 5 5   4 4 4 4      4 4 5 5   4 4 5 5
   3 3 4 5   3 4 4 4      4 5 4 4   5 5 5 5      5 5 5 5   4 5 4 4
   5 5 4 4   3 4 4 4      4 4 4 4   5 3 4 4      4 4 4 4   5 3 4 4
   4 4 4 4   4 5 4 4      3 4 5 5   2 5 5 5      5 3 5 5   3 4 5 5
   5 5 3 3   4 3 5 5      3 3 4 4   4 4 4 4      4 4 4 4   4 4 5 5
   3 3 5 5   3 4 4 4      4 4 3 3   4 4 5 4      4 4 5 5   4 4 5 5
   ;
   
   proc glm;
      model HusbQ1-HusbQ4 WifeQ1-WifeQ4 = / nouni;
      repeated Spouse 2, Question 4 identity;
      run;
   
   proc means alpha=0.05 n mean lclm uclm;
      title "Unadjusted Confidence Intervals";
      var DiffQ1-DiffQ4 DiffQAvg DiffComp DiffPass DiffFFP DiffFFY;
   proc means alpha=&sidalpha n mean lclm uclm;
      title "Simultaneous Sidak Intervals";
      var DiffQ1-DiffQ4 DiffQAvg DiffComp DiffPass DiffFFP DiffFFY;
   proc means alpha=&bonalpha n mean lclm uclm;
      title "Simultaneous Bonferroni Intervals";
      var DiffQ1-DiffQ4 DiffQAvg DiffComp DiffPass DiffFFP DiffFFY;
   run;
   

/* Program 2.7: Multiple Tests with Multivariate Data */

proc means data=HusbWive n mean std prt;
   title "Tests of Hypotheses With Husband/Wife Data";
   var DiffQ1-DiffQ4 DiffQAvg DiffComp DiffPass DiffFFP DiffFFY;
run;

 
/* Program 2.8: HOLM Adjusted p-values Using PROC MULTTEST */

data one; 
   set one;
   rename pval=raw_p;
   drop bon_adjp sid_adjp;
proc multtest pdata=one bon stepbon out=outp;
proc sort data=outp out=outp;
   by raw_p;
proc print data=outp;
run;

/* Program 2.9. Sidak-Holm Adjusted p-values Using PROC MULTTEST */

data one; set one;
   rename pval=raw_p;
   drop bon_adjp sid_adjp;
proc multtest pdata=one sid stepsid out=outp;
proc sort data=outp out=outp;
   by raw_p;
proc print data=outp;
run;


/* Program 2.10: Hochberg's Adjusted p-values Using PROC MULTTEST */

data one; set one;
   rename pval=raw_p;
   drop bon_adjp sid_adjp;
proc multtest pdata=one holm hoc out=outp;
proc sort data=outp out=outp;
   by raw_p;
proc print data=outp;
run;


/* Program 2.11: FDR-controlling p-values Using PROC MULTTEST */

data one; set one;
   rename pval=raw_p;
   drop bon_adjp sid_adjp;
proc multtest pdata=one hoc fdr out=outp;
proc sort data=outp out=outp;
   by raw_p;
proc print data=outp;
run;


/* Program 2.12: Adjusted p-values from Fixed-sequence Tests */

data a;
   input p @@;
   if (_N_ = 1) then pseq = 0;
   pseq = max(pseq,p);
   retain pseq;
   cards;
0.021
0.043
0.402
0.004
;
proc print data=a;
run;


/* Program 2.13: Schweder-Spjotvoll p-value Plot */

data one; set one;
proc sort out=pplot;
   by descending pval ;
run;
data pplot;  set pplot;
   q = 1-pval;
   order = _n_;
run;
goptions ftext=simplex hsize=5 in vsize=3.33 in;
axis1 style=1 width=2 major=(number=5) minor=none label=('q = 1-p');
axis2 style=1 width=2 major=(number=6)
   order=(0 2 4 6 8 10) minor=none label=('Order');
proc gplot data=pplot;
   title "SCHWEDER-SPJOTVOLL PLOT";
   plot order*q / vaxis=axis2 haxis=axis1 frame;
run;


/* Program 2.14:  Hochberg and Benjamini Graphical analysis of Multiple p-values */

%hochben(dataset=one, pv=pval);


/* Program 3.1: Studentized Range Critical Value */

data;
   qval = probmc("RANGE",.,.95,45,5);
   c_alpha = qval/sqrt(2);
run;
proc print; run;


/* Program 3.2: Simultaneous Intervals for Mean Differences */

data wloss;
   do diet = 'A','B','C','D','E';
      do i = 1 to 10;
         input wloss @@;
         output;
         end;
      end;
datalines;
12.4 10.7 11.9 11.0 12.4 12.3 13.0 12.5 11.2 13.1
 9.1 11.5 11.3  9.7 13.2 10.7 10.6 11.3 11.1 11.7
 8.5 11.6 10.2 10.9  9.0  9.6  9.9 11.3 10.5 11.2
 8.7  9.3  8.2  8.3  9.0  9.4  9.2 12.2  8.5  9.9
12.7 13.2 11.8 11.9 12.2 11.2 13.7 11.8 11.5 11.7
;
proc glm data=wloss;
   class diet;
   model wloss=diet;
   means diet/cldiff t bon tukey;
run;


/* Program 3.3: Graphical Presentation for Comparing Means: LINES */

proc glm data=wloss;
    class diet;
    model wloss=diet;
    means diet/lines tukey;
run;


/* Program 3.4: "Hand" Calculation of Adjusted p-values */

data;
   n=10; g=5; df=g*(n-1); 
   MeanA=12.05; MeanB=11.02; mse=0.993422;
   tab = (MeanA-MeanB)/(sqrt(mse)*sqrt(2/n));
   p = 2*(1-probt(abs(tab),df));
   adjp = 1-probmc('RANGE',sqrt(2)*abs(tab),.,df,g);
run;
proc print; var tab p adjp;
run;


/* Program 3.5: PROC GLM Calculation of Adjusted p-values */

proc glm data=wloss;
   class diet;
   model wloss=diet;
   lsmeans diet/pdiff adjust=tukey;
run;


/* Program 3.6:  Dunnett Critical Value (two-sided) */

data;
   c_alpha = probmc("DUNNETT2",.,.95,21,6);
run;
proc print; run;


/* Program 3.7: Simultaneous Two-sided Comparisons with a Control */

data tox;
   input g @;
   do j = 1 to 4;
      input gain @; output;
   end;
datalines;
0 97.76 102.56 96.08 125.12
1 91.28 129.20 90.80  72.32
2 67.28  85.76 95.60  73.28
3 80.24  64.88 64.88  78.56
4 96.08  98.24 77.84  95.36
5 57.68  89.84 98.48  92.72
6 68.72  85.28 68.72  74.24
;
proc glm data=tox;
   class g;
   model gain=g;
   means g/dunnett;
run;


/* Program 3.8: Dunnett Critical Value (one-sided) */

data;
   c_alpha = probmc("DUNNETT1",.,.95,21,6);
run;
proc print; run;


/* Program 3.9: Simultaneous One-sided Comparisons with a Control */

proc glm data=tox;
   class g;
   model gain=g;
   means g/dunnettl;
run;


/* Program 3.10:  Simultaneous Confidence Intervals for Means */

proc glm data=wloss;   
   class diet;
   model wloss=diet;
   means diet / clm smm sidak;
run;


/* Program 3.11:  Orthogonal Comparisons */

 data coupon;
   input discount purchase @@;
datalines;
0 32.39   10 98.47   15 71.62   20 60.85
0 38.32   10 74.80   15 59.92   20 46.45
0 35.66   10 52.97   15 75.37   20 68.49
0 74.24   10 46.72   15 77.04   20 63.83
0 63.05   10 76.81   15 72.84   20 75.38
0 66.53   10 69.01   15 52.53   20 70.60
0 46.36   10 53.77   15 80.47   20 52.23
0 41.90   10 54.21   15 72.55   20 57.14
0 44.94   10 83.14   15 78.94   20 60.17
0 41.09   10 49.00   15 64.00   20 60.46
;
run;
proc glm data=coupon;
   class discount;
   model purchase = discount;
   estimate "linear" discount   -3 -1  1  3;
   estimate "quad"   discount   -2  2  2 -2;
   estimate "cubic"  discount   -1  3 -3  1;
run;
data alevel;
   input FWE @@;
   qMM = probmc('maxmod',.,1-FWE,36,3);
   CER = 2*(1-probt(qMM,36));
   output;
datalines;
0.05 0.10
;
proc print data=alevel noobs;
   title1 "CER is the ALPHA level for orthogonal contrasts";
   title2 "that yields the corresponding FWE";
run;
title1; title2;


/* Program 4.1: Recovery Time Data Set */

data recover;
   input blanket$ minutes @@;
datalines;
b0 15 b0 13 b0 12 b0 16 b0 16 b0 17 b0 13 b0 13 b0 16 b0 17
b0 17 b0 19 b0 17 b0 15 b0 13 b0 12 b0 16 b0 10 b0 17 b0 12
b1 13 b1 16 b1  9
b2  5 b2  8 b2  9
b3 14 b3 16 b3 16 b3 12 b3  7 b3 12 b3 13 b3 13 b3  9 b3 16
b3 13 b3 18 b3 13 b3 12 b3 13
;


/* Program 4.2: Tukey-Kramer Simultaneous Intervals with Unbalanced ANOVA */

proc glm data=recover;
   class blanket;
   model minutes=blanket;
   means blanket/tukey;
run;

/* Program 4.3:  LINES option with unequal sample sizes */

proc glm data=recover;
   class blanket;
   model minutes=blanket;
   means blanket/tukey lines;
run;

/* Program 4.4:  Simulation of Correct Tukey-Kramer Critical Value */

data sim;
   array nsize{4} (20,3,3,15);
   do rep = 1 to 500;
      do i=1 to dim(nsize);
         do j=1 to nsize{i};
            y = rannor(121211);
            output;
         end;
      end;
   end;
run;

ods listing close;
ods output Diff=GDiffs;
proc glm data=sim;
   by rep;
   class i;
   model y=i;
   lsmeans i/ tdiff;
quit;
   ods listing;

proc transpose data=GDiffs out=t(where=(_label_ > RowName));
   by rep  RowName;
   var _1 _2 _3 _4;
data t;
    set t;
    abst = abs(COL1);
    keep rep abst;
proc means noprint data=t;
   var abst;
   by rep;
   output out=maxt max=maxt;
run;

   ods select Quantiles;
proc univariate;
   var maxt;
run;


/* Program 4.5: Simulation-Based Critical Value and Intervals */

proc glm data=recover;
   class blanket;
   model minutes=blanket;
   lsmeans blanket/cl adjust=simulate(seed=121211 report);
run;


/* Program 4.6: Tukey-Kramer Adjusted p-values in an Unbalanced ANOVA */

proc glm data=recover;
   class blanket;
   model minutes=blanket;
   lsmeans blanket/ pdiff cl adjust=tukey;
run;


/* Program 4.7: Getting Greater Simulation Accuracy Using the NSAMP= Option */

proc glm data=recover;
   class blanket;
   model minutes=blanket;
   lsmeans blanket/ pdiff cl adjust=simulate (NSAMP=4000000 seed=121211);
run;


/* Program 4.8: Dunnett's Exact Two-sided Critical Value for Unbalanced ANOVA */

data;
   n0=20; n1=3; n2=3; n3=15;
   lambda1 = sqrt(n1/(n0+n1));
   lambda2 = sqrt(n2/(n0+n2));
   lambda3 = sqrt(n3/(n0+n3));
   c_alpha = probmc('DUNNETT2',.,.95,37,3,lambda1,lambda2,lambda3);
   t3 = -1.66666667/0.88477275;
   adjp_3 = 1-probmc('DUNNETT2',abs(t3),.,37,3,lambda1,lambda2,lambda3);
run;


/* Program 4.9: Dunnett's Two-Sided Comparisons with Unbalanced Data */

proc glm data=recover;
   class blanket;
   model minutes = blanket;
   lsmeans blanket/pdiff cl adjust=dunnett;
run;


/* Program 4.10: Dunnett's Exact One-sided Critical Value for Unbalanced ANOVA */

data;
   n0=20; n1=3; n2=3; n3=15;
   lambda1 = sqrt(n1/(n0+n1));
   lambda2 = sqrt(n2/(n0+n2));
   lambda3 = sqrt(n3/(n0+n3));
   c_alpha = probmc('DUNNETT1',.,.90,37,3,lambda1,lambda2,lambda3);
   t3 = -1.66666667/0.88477275;
   adjp_3 = 1-probmc('DUNNETT1',-t3,.,37,3,lambda1,lambda2,lambda3);
run;
proc print; var c_alpha adjp_3; run;


/* Program 4.11: Dunnett's One-Sided Comparisons with Unbalanced Data */

proc glm data=recover;
   class blanket;
   model minutes = blanket;
   lsmeans blanket/pdiff=controll cl alpha=0.10;
run;


/* Program 5.1: Selling Prices of Homes */

data house;
   input location$ price sqfeet age @@;
datalines;
A 113.5 2374 4   A 119.9 2271 8   A 127.9 2088 5
A  92.5 1645 8   A 103.0 1814 6   A 142.1 2553 7
A 120.5 1921 9   A 105.5 1854 2   A 101.2 1536 9
A  94.7 1677 3   A 129.0 2342 5   A 108.7 1862 4
A  99.7 1894 7   A 112.0 1774 9   A 104.8 1476 8
A  86.1 1466 7   A 103.5 1800 8   A  93.0 1491 5
A  99.5 1749 8   A  98.1 1690 7   A 144.8 2741 5
A  96.3 1460 5   A  95.1 1614 6   A 125.8 2244 6
A 126.9 2165 6   A 104.7 1828 4   B  74.2 1503 6
B  69.9 1689 6   B  77.0 1638 2   B  67.0 1276 6
B  98.9 2101 9   B  81.2 1668 5   B  85.7 2123 4
B  99.8 2208 5   B  55.7 1273 8   B 120.1 2519 4
B 109.1 2303 6   B  82.4 1800 3   B 102.7 2336 8
B  92.0 2100 6   B  84.1 1697 4   C  90.8 1674 4
C  98.2 2307 7   C  94.6 2152 5   C  87.9 1948 9
D 102.5 2258 2   D  81.3 1965 6   D  86.1 1772 3
D  94.7 2385 1   D  64.7 1345 4   D  93.5 2220 8
D  80.1 1883 8   D  92.3 2012 6   D  80.6 1898 5
E 105.3 2362 7   E 106.3 2362 7   E  84.3 1963 9
E  76.6 1941 7   E  82.4 1975 5   E  98.8 2529 6
E  86.8 2079 5   E  88.5 2190 4   E  77.5 1897 5
E  86.9 1946 4
;


/* Program 5.2:  Simultaneous Confidence Intervals for Mean Differences in ANCOVA */

ods select LSMeanDiffCL;
proc glm data=house;
   class location;
   model price = location sqfeet age;
   lsmeans location / pdiff cl adjust=simulate(seed=12345 cvadjust);
run;


/* Program 5.3: Viewing Simulation Details when using adjust=simulate */

ods select SimDetails
           SimResults
           LSMeanDiffCL;
proc glm data=house;
   class location;
   model price = location sqfeet age;
   lsmeans location / pdiff cl adjust=simulate(seed=12345 report cvadjust);
run;


/* Program 5.4: Invocation of %SimIntervals using Direct Specification of 
%Estimates and %Contrasts */

%macro Estimates;
   EstPar = { 12.05 , 11.02 , 10.27 , 9.27 , 12.17 };
   Mse    = 0.9934;
   Cov    = Mse * I(5)/10 ;  /* sample size is 10 per group */
   df     = 45;
%mend;

%macro Contrasts;
   C = { 1 -1  0  0  0 ,
         1  0 -1  0  0 ,
         1  0  0 -1  0 ,
         1  0  0  0 -1 ,
         0  1 -1  0  0 ,
         0  1  0 -1  0 ,
         0  1  0  0 -1 ,
         0  0  1 -1  0 ,
         0  0  1  0 -1 ,
         0  0  0  1 -1 };
   C = C` ;                 /* transposed to coincide with notation in 5.2.2 */

   Clab = {"1-2", "1-3", "1-4", "1-5", 
                  "2-3", "2-4", "2-5", 
                         "3-4", "3-5",
                                "4-5" };  /* Contrast labels */
%mend;

%SimIntervals(nsamp=50000, seed=121211, conf=0.95, side=B);


/* Program 5.5: Invocation of %SimIntervals using %MakeGLMStats */

%MakeGLMStats(dataset=wloss, classvar=diet, yvar=wloss, model=diet);

%macro Contrasts;
   C = { 0   1 -1  0  0  0 ,
         0   1  0 -1  0  0 ,
         0   1  0  0 -1  0 ,
         0   1  0  0  0 -1 ,
         0   0  1 -1  0  0 ,
         0   0  1  0 -1  0 ,
         0   0  1  0  0 -1 ,
         0   0  0  1 -1  0 ,
         0   0  0  1  0 -1 ,
         0   0  0  0  1 -1 };
   C = C` ;                 /* transposed to coincide with notation in 5.2.2 */

   Clab = {"1-2", "1-3", "1-4", "1-5", 
                  "2-3", "2-4", "2-5", 
                         "3-4", "3-5",
                                "4-5" };  /* Contrast labels */
%mend;

%SimIntervals(nsamp=50000, seed=121211);


/* Program 5.6: Invocation of %SimIntervals using %MakeGLMStats 
to create %Contrasts and %Estimates */

%MakeGLMStats(dataset=wloss, classvar=diet, yvar=wloss, model=diet,
              contrasts=all(diet));

%SimIntervals(nsamp=50000, seed=121211);


/* Program 5.7: %SimIntervals Analysis for Comparing Covariate-Adjusted Means */

%MakeGLMStats(dataset=house, classvar=location, yvar=price, 
              model=location sqfeet age, contrasts=all(location));

%SimIntervals(seed=121211);


/* Program 5.8: Adjusted p-values from PROC GLM */

ods select DiffMat;
proc glm data=house;
   class location;
   model price = location sqfeet age;
   lsmeans location / pdiff cl adjust=simulate(seed=12345 nsamp=100000);
run;


/* Program 5.9: Rat Growth Data */

data ratgrwth;
   length trt $ 10;
   input trt$ W0-W4 @@;
datalines;
Control    46 70 102 131 153    Control    49 67  90 112 140
Control    49 67 100 129 164    Control    51 71  94 110 141
Control    52 77 111 144 185    Control    56 81 104 121 151
Control    57 82 110 139 169    Control    57 86 114 139 172
Control    60 93 123 146 177    Control    63 91 112 130 154
Thyroxin   52 70 105 138 171    Thyroxin   52 73  97 116 140
Thyroxin   54 71  90 110 138    Thyroxin   56 75 108 151 189
Thyroxin   57 72  97 120 144    Thyroxin   59 85 116 148 177
Thyroxin   59 85 121 156 191    Thiouracil 46 61  78  90 107
Thiouracil 51 75  92 100 119    Thiouracil 51 75 101 123 140
Thiouracil 53 79 100 106 133    Thiouracil 53 72  89 104 122
Thiouracil 56 78  95 103 108    Thiouracil 58 69  93 114 138
Thiouracil 59 80 101 111 122    Thiouracil 59 88 100 111 122
Thiouracil 61 86 109 120 129
;


/* Program 5.10: Covariate-Adjusted One-Sided Comparisons with a Control */

ods select LSMeans LSMeanDiffCL;
proc glm data=ratgrwth;
   class trt;
   model w4 = trt w0-w3;
   lsmeans trt /  pdiff=controll cl adjust=dunnett;
run;


/* Program 5.11: Using Hsu's Control-Variate Simulation Method for Reducing 
Monte Carlo Error */

ods select LSMeans LSMeanDiffCL;
proc glm data=ratgrwth;
   class trt;
   model w4 = trt w0-w3;
   lsmeans trt /  pdiff=controll cl adjust=simulate
      (cvadjust nsamp=100000 report seed=121211);
run;


/* Program 5.12: Multiple Comparisons at Fixed Covariate Levels */

data alz;
   input therapy age since score @@;
cards;
1 69  22 66  1 68 14  60  1 66 14 55  1 68 31 70  1 71  27 50
1 55  28 56  1 71 24  62  1 68 28 67  1 71 25 72  1 71  16 48
1 88 123 59  1 67 27  58  1 71 25 70  2 72 54 47  2 90 121 44
2 72  44 64  2 75 19  65  2 69 28 56  2 65 27 71  2 76  22 68
2 68  29 53  2 61 18  60  2 65 20 65  2 71 20 60  2 72  21 64
3 70  27 54  3 70 23  45  3 64 11 60  3 66 45 30  3 67  19 46
3 68  24 45  3 69 16  49  3 79 23 49  3 68 31 34  3 72  15 40
4 67  28 89  4 65 17 100  4 66 32 81  4 75 23 76  4 83  60 64
4 70  12 58  4 63 16  85  4 68 17 86  4 65 18 89  4 68  27 76
4 63  18 95  4 67 37  85  4 75 18 96  4 66 27 90  4 71  23 83
4 70  36 75  5 66 18  68  5 69 25 77  5 76 13 87  5 70   9 95
5 70  11 95  5 71 13  82
;
proc glm data=alz outstat=stat;
   ods select LSMeanDiffCL;
   class therapy;
   model score = therapy since age therapy*since;
   lsmeans therapy / pdiff cl adjust=simulate at since  = 10;
run;
proc glm data=alz outstat=stat;
   ods select LSMeanDiffCL;
   class therapy;
   model score = therapy since age therapy*since;
   lsmeans therapy / pdiff cl adjust=simulate at since  = 20;
run;


/* Program 6.1:  Litter weight data */

data litter;
   input dose weight gesttime number @@;
datalines;
  0 28.05 22.5 15    0 33.33 22.5 14    0 36.37 22.0 14
  0 35.52 22.0 13    0 36.77 21.5 15    0 29.60 23.0  5
  0 27.72 21.5 16    0 33.67 22.5 15    0 32.55 22.5 14
  0 32.78 21.5 15    0 31.05 22.0 12    0 33.40 22.5 15
  0 30.20 22.0 16    0 28.63 21.5  7    0 33.38 22.0 15
  0 33.43 22.0 13    0 29.63 21.5 14    0 33.08 22.0 15
  0 31.53 22.5 16    0 35.48 22.0  9    5 34.83 22.5 15
  5 26.33 22.5  7    5 24.28 22.5 15    5 38.63 23.0  9
  5 27.92 22.0 13    5 33.85 22.5 13    5 24.95 22.5 17
  5 33.20 22.5 15    5 36.03 22.5 12    5 26.80 22.0 13
  5 31.67 22.0 14    5 30.33 21.5 12    5 26.83 22.5 14
  5 32.18 22.0 13    5 33.77 22.5 16    5 21.30 21.5  9
  5 25.78 21.5 14    5 19.90 21.5 12    5 28.28 22.5 16
 50 31.28 22.0 16   50 35.80 21.5 16   50 27.97 21.5 14
 50 33.13 22.5 15   50 30.60 22.5 15   50 30.17 21.5 15
 50 27.07 21.5 14   50 32.02 22.0 17   50 36.72 22.5 13
 50 28.50 21.5 14   50 21.58 21.5 16   50 30.82 22.5 17
 50 30.55 22.0 14   50 27.63 22.0 14   50 22.97 22.0 12
 50 29.55 21.5 12   50 31.93 22.0 14   50 29.30 21.5 16
500 24.55 22.0  7  500 33.78 22.5 13  500 32.98 22.0 10
500 25.38 21.5 11  500 30.32 22.0 15  500 19.22 22.5 11
500 26.37 21.5 14  500 28.60 22.5  9  500 19.70 22.0 11
500 32.88 22.5 15  500 26.12 22.5 13  500 33.20 22.0 12
500 32.97 22.5 14  500 38.75 23.0 16  500 33.15 22.5 12
500 30.70 21.5 13  500 35.32 22.0 17
;


/* Program 6.2:  Estimation of Contrasts using PROC GLM */

proc glm data=litter;
   class dose;
   model weight = dose gesttime number;
   estimate 'cont-low ' dose 1    -1      0      0    ;
   estimate 'cont-mid ' dose 1     0     -1      0    ;
   estimate 'cont-high' dose 1     0      0     -1    ;
   estimate 'ordinal  ' dose 0.750 0.250 -0.250 -0.750;
   estimate 'arith    ' dose 0.384 0.370  0.246 -1.000;
   estimate 'log ord  ' dose 0.887 0.113 -0.339 -0.661;
run;


/* Program 6.3: Simultaneous Intervals for General Contrasts in an ANCOVA Model */

%MakeGLMStats(dataset  = litter,
              classvar = dose  ,
              yvar     = weight,
              model    = dose gesttime number);

%macro Contrasts;
   C = {0   1     -1      0      0     0 0,
        0   1      0     -1      0     0 0,
        0   1      0      0     -1     0 0,
        0   0.750  0.250 -0.250 -0.750 0 0,
        0   0.384  0.370  0.246 -1.000 0 0,
        0   0.887  0.113 -0.339 -0.661 0 0};
   C = C`;
   Clab = { "Control-Low" , "Control-Med"  , "Control-High",
            "Ordinal"  , "Arithmetic", "Log-Ordinal"};
%mend;

%SimIntervals(nsamp=100000,seed=121221,side=U);


/* Program 6.4: Overall F-test Significant but Pairwise Comparisons Insignificant */

data wlossnew;
   set wloss;
   wloss=wloss + 6*rannor(121211);   /* Random error added */
proc glm;
   class diet;
   model wloss=diet;
   means diet/cldiff tukey;
run;


/* Program 6.5: Scheffe Intervals */

proc glm data=wlossnew;
   class diet;
   model wloss=diet;
   means diet/cldiff scheffe;
run; 


/* Program 6.6: Multiple Contrasts, Where Some are Suggested by the Data */

data;
   fwe = 0.05;
   g   = 5;
   df  = 45;
   fcrit   = finv(1-fwe,g-1,df);
   c_alpha = sqrt((g-1)*fcrit);
   p_crit  = 2*(1 - probt(c_alpha, df));
   call symput ('scheffep',p_crit);
run;
proc glm data=wlossnew;
   title "Use &Scheffep to determine significance of contrasts";
   class diet;
   model wloss=diet;
   lsmeans diet/pdiff adjust=scheffe;
   estimate "c1" diet  1   1 -1 -1   0 /divisor=2;
   estimate "c2" diet -1  -1  1  0   1 /divisor=2;
   estimate "c3" diet  4  -1 -1 -1  -1 /divisor=4;
   estimate "c4" diet  2  -3  2 -3   2 /divisor=6;
   estimate "c5" diet  1  -1  0 -1   1 /divisor=2;
   estimate "c6" diet  2  -1  0 -2   1 /divisor=3;
run;


/* Program 6.7: Finding the Most Significant Contrast in ANCOVA */

%let classvar = location;
proc glm data=house;
   class location;
   model price = location sqfeet age;
   lsmeans location / out=stats cov;
proc iml;
   use stats;
   read all into alldata;
   read all var {&classvar} into classvar;
   read all var {LSMEAN} into ests;
   classvar = classvar`;
   ncall    = ncol(alldata);
   nclass   = nrow(ests);
   ncstart  = ncall-nclass+1;
   covs     = alldata[,ncstart:ncall];
   cont1    = j(nclass-1,1,1);
   cont2    = -i(nclass-1);
   cont     = cont1||cont2;
   nummat   = (cont*ests)*(ests`*cont`);
   denmat   = cont*covs*cont`;
   h        = half(denmat);
   evec     = eigvec(inv(h`)*nummat*inv(h));
   e1       = inv(h)*evec[,1];
   contrast = e1`*cont;
   contrast = contrast/sum((contrast>0)#contrast);
   print "Most Significant Contrast",
   contrast [label="&classvar" colname=classvar];
quit;


/* Program 6.8: Simultaneous Confidence Bounds for Regression Function */

%MakeGLMStats(dataset=house_a,
                 yvar=price,
                model=sqfeet);

%macro Contrasts;
   free c clab;
   do x = 1000 to 3000 by 200;
      c = c // (1 || x);
      clab = clab // x;
      end;
      c = c`;
%mend;

%SimIntervals(nsamp=50000,seed=121211);

data xvalues;
   do x = 1000 to 3000 by 200;
   output;
   end;
run;

data confplot;
   merge xvalues SimIntOut;
run;

goptions ftext=swissb hsize=4 in vsize=4 in;
axis1 style=1 width=2 major=(number=5) minor=none 
   label=('Square Feet');
axis2 style=1 width=2 major=(number=5) minor=none 
   label=('Price');

symbol1 w=1 c=black i=spline v=none;
symbol2 w=1 c=black i=spline v=none l=2;

proc gplot data=confplot;
      title;
     plot Estimate*x=1 (LowerCL UpperCL)*x=2/
        haxis=axis1 vaxis=axis2 frame overlay;
run;


/* Program 6.9:  Working-Hotelling Confidence Bounds for Regression Function */

%let conf=.95;
data housplt;
   set house_a end=eof;
   output;
   if eof then do;
      call symput('n',left(_n_));
      price=.;
      do sqfeet=1000 to 3000 by 200;
         output;
         end;
      end;
run;
proc reg data=housplt;
   model price = sqfeet;
   output out=ests p=pred stdp=se;
run;
data plot;
   set ests;
   if _n_ > &n;
   c_a = sqrt(2*finv(&conf,2,&n-2));
   lower = pred - c_a*se;
   upper = pred + c_a*se;
run;
goptions ftext=swissb hsize=4 in vsize=4 in;
axis1 style=1 width=2 major=(number=5) minor=none 
   label=('Square Feet');
axis2 style=1 width=2 major=(number=5) minor=none 
   label=('Price');
Symbol1 W=1 C=Black I=Spline V=None;
Symbol2 W=1 C=Black I=Spline V=None L=2;
proc gplot data=plot;
      title;
     plot pred*sqfeet=1 (lower upper)*sqfeet=2/
        haxis=axis1 vaxis=axis2 frame overlay;
run;


/* Program 6.10: Patient Satisfaction Data */

data pat_sat;
   input age severe anxiety satisf @@;
   cards;
50 51 2.3 48  36 46 2.3 57  40 48 2.2 66  41 44 1.8 70
28 43 1.8 89  49 54 2.9 36  42 50 2.2 46  45 48 2.4 54
52 62 2.9 26  29 50 2.1 77  29 48 2.4 89  43 53 2.4 67
38 55 2.2 47  34 51 2.3 51  53 54 2.2 57  36 49 2.0 66
33 56 2.5 79  29 46 1.9 88  33 49 2.1 60  55 51 2.4 49
29 52 2.3 77  44 58 2.9 52  43 50 2.3 60
;


/* Program 6.11: Confidence Bounds for a Partial Function */

%MakeGLMStats(dataset  = pat_sat,
              yvar     = satisf,
              model    = age severe anxiety);

%macro Contrasts;
   free c clab;
   do x = 45 to 60 by 1;
      c = c // (1 || 39.6 || x || 2.30);
      clab = clab // x;
      end;
      c = c`;
%mend;

%SimIntervals(nsamp=100000,seed=121221);

data xvalues;
   do x = 45 to 60 by 1;
   output;
   end; run;
data confplot;
   merge xvalues SimIntOut; run;

goptions ftext=swissb hsize=4 in vsize=4 in;
axis1 style=1 width=2 major=(number=6) minor=none
   label=('Illness Severity');
axis2 style=1 width=2 major=(number=6) minor=none
   label=('Satisfaction');
Symbol1 W=1 C=Black I=Spline V=None;
Symbol2 W=1 C=Black I=Spline V=None L=2;

proc gplot data=confplot;
      title;
     plot estimate*x=1 (lowercl uppercl)*x=2/
        haxis=axis1 vaxis=axis2 frame overlay;
run;


/* Program 6.12: Tire Wear Data

data tire;
   input make$ mph cost @@;
datalines;
A 10  9.8  A 20 12.5  A 20 14.2  A 30 14.9  A 40 19.0
A 40 16.5  A 50 20.9  A 60 22.4  A 60 24.1  A 70 25.8
B 10 15.0  B 20 14.5  B 20 16.1  B 30 16.5  B 40 16.4
B 40 19.1  B 50 20.9  B 60 22.3  B 60 19.8  B 70 21.4
;
run;


/* Program 6.13:  Simultaneous Confidence Bounds for Difference of Regression Functions */

%MakeGLMStats(dataset  = tire ,
              classvar = make ,
              yvar     = cost ,
              model    = make mph make*mph);

%macro Contrasts;
   free c clab;
   do x = 10 to 70 by 5;
      c = c // (0 || 1 || -1 || 0 || x || -x);
      clab = clab // x ;
   end;
   c = c`;
%mend;

%SimIntervals(nsamp=100000, seed=121211);

data xvalues;
   do x = 10 to 70 by 5;
   output;
   end;
run;

data confplot;
   merge xvalues SimIntOut;
run;

goptions ftext=swissb hsize=5 in vsize=4 in;
axis1 style=1 width=2 major=(number=7) minor=none
   label=('Miles Per Hour');
axis2 style=1 width=2 major=(number=5) minor=none
   label=('CostA-CostB');
symbol1 w=1 c=black i=spline v=none;
symbol2 w=1 c=black i=spline v=none l=2;
proc gplot data=confplot;
   title;
   plot estimate*x=1 (lowercl uppercl)*x=2/
      haxis=axis1 vaxis=axis2 frame overlay vref=0;
run;


/* Program 6.14: Finding the Critical Value for Comparing Two Regression Lines 
Using the Continuous Method (Constrained Optimization) */

options nonotes;
%let nsamp    = 100000;   /* Number of simulations */
%let seed     = 121021;
%let dataset  = tire;
%let yvar     = cost;
%let classvar = make;   /* Must be a two-level variable */
%let xvar     = mph;
%let lowerX   = 10;
%let upperX   = 70;
%let conf     = 0.95;
%let npoints  = 100;     /* Number of points to plot on the graph */

proc iml;
   use &dataset;
   read all var {&yvar} into Y;
   read all var {&xvar} into X1;
   read all var {&classvar} into X2;
   D = design(X2)[,1];
   DX = D#X1;
   n = nrow(X1);
   one = j(n,1,1);
   X = one||X1||D||DX;
   XPXI   = INV(X`*X);
   XPXIXP = XPXI*X`;
   b = XPXIXP*Y;
   df = n-ncol(X);
   mse = (Y`-b`*X`)*(Y-X*b)/df;
   lowerX = &lowerX;  upperX = &upperX;
   xbar = x1[+,]/n;
   optn={1 0};
   bc = lowerX//UpperX;
   maxt=j(&nsamp,1,0);
   inc = (UpperX-LowerX)/&npoints;

start tstat(x0) global(n,XPXI,bstar,msestar );
     c0 = {0}||{0}||{1}||x0;
     est = c0*bstar;
     t = est/sqrt(msestar*c0*XPXI*c0`);
     t = abs(t);
     return(t);
finish;

do isim = 1 to &nsamp;
   Ystar = rannor(j(n,1,&seed));
   bstar = xpxixp*Ystar;
   msestar = (Ystar`-bstar`*X`)*(Ystar-X*bstar)/df;
   call nlpqn(rc,xmax,"tstat",xbar,optn,bc,,,,,);
   mx = tstat(xmax);
   maxt[isim] = mx;
end;

   temp = maxt;
   maxt[rank(maxt),] = temp;
   critindx = round(&nsamp*&conf,1);
   sim_crit = maxt[critindx];
   wh_crit  = sqrt(2*finv(&conf,2,df));
   t_crit   = tinv(1-(1-&conf)/2,df);
   print "The simulation-based, Working-Hotelling, and t critical values are";
   print  sim_crit wh_crit t_crit;


/* Program 7.1: Simulation of ANOVA Data */

data a;
   array mu{5} (10,5,5,0,0);
   do a = 1 to dim(mu);
      do i = 1 to 10;
         y = mu{a} + 6*rannor(12345);
         output;
         end;
      end;
   run;

proc glm data=a;
   class a;
   model y = a;
   means a / tukey cldiff;
   ods select CLDiffs;
   run;


/* Program 7.2: Using the %IndividualPower Macro to Calculate Power Analytically 
for All Pairwise Comparisons */

%IndividualPower(
   MCP = RANGE, /* RANGE, DUNNETT2, DUNNETT1, OR MAXMOD           */
   g   = 5,     /* number of groups (exclude control for DUNNETT) */
   d   = 4,     /* meaningful mean difference                     */
   s   = 3      /* estimate (guess) of standard deviation         */
   );


/* Program 7.3: Using the %IndividualPower Macro to Calculate Power 
Analytically for Dunnett's Two-sided Comparisons with a Control */

%IndividualPower(MCP=DUNNETT2,g=6,d=5,s=3.5);


/* Program 7.4:  Simulating Combined Power Measures for all Pairwise Comparisons */

%SimPower(TrueMeans=(10, 5, 5, 0, 0),s=5,n=10,seed=12345);


/* Program 7.5:  Evaluating Directional FWE When There Are No Null Effects */

%SimPower(TrueMeans = (-.1, -.2, .1, .05),
          s         = 500                ,  
          n         = 2                  , 
          nrep      = 4000               ,
          seed      = 12345              );


/* Program 7.6:  Simulating combined power of two-sided comparisons with a control */

%SimPower(TrueMeans=(10, 5, 5, 0, 0),s=5,n=10,seed=12345,method=DUNNETT);


/* Program 7.7:  Simulating Combined Power of One-sided Comparisons with a Control */

%SimPower(TrueMeans=(10, 5, 5, 0, 0),s=5,n=10,seed=12345,method=DUNNETTL);


/* Program 7.8:  Plotting Simulated Complete Power of Two-sided Comparisons with a Control */

%PlotSimPower(TrueMeans=(10,5,5,0,0),s=5,seed=12345,method=Dunnett);


/* Program 8.1: Tukey-Welch (REGWQ) Comparisons for Balanced ANOVA */

data Cholesterol;
do trt = 'A','B','C','D','E';
   do i = 1 to 10;
      input response @@;
      output;
   end;
end;
datalines;
 3.8612 10.3868  5.9059  3.0609  7.7204  2.7139  4.9243  2.3039  7.5301  9.4123
10.3993  8.6027 13.6320  3.5054  7.7703  8.6266  9.2274  6.3159 15.8258  8.3443
13.9621 13.9606 13.9176  8.0534 11.0432 12.3692 10.3921  9.0286 12.8416 18.1794
16.9819 15.4576 19.9793 14.7389 13.5850 10.8648 17.5897  8.8194 17.9635 17.6316
21.5119 27.2445 20.5199 15.7707 22.8850 23.9527 21.5925 18.3058 20.3851 17.3071
;
proc glm data=Cholesterol;
   class trt;
   model response=trt;
   means trt/regwq;
run;


/* Program 8.2:  Power Calculation for the REGWQ Method */

%SimPower(TrueMeans=(10, 5, 5, 0, 0),s=5,n=10,seed=12345,
           method=REGWQ);


/* Program 8.3: The Begun and Gabriel Method} */

%beggab(dataset=Cholesterol,groups=trt,response=response);


/* Program 8.4:  Closed Testing Using Fisher's Combination Test */

data fishcomb;
input p1 p2 p3;
   t123= -2*(log(p1) + log(p2) + log(p3));
   p123= 1-probchi(t123,6);
   t12 = -2*(log(p1) + log(p2));
   p12=  1-probchi(t12,4);
   t13 = -2*(log(p1) + log(p3));
   p13= 1-probchi(t13,4);
   t23 = -2*(log(p2) + log(p3));
   p23= 1-probchi(t23,4);
datalines;
0.076 0.081 0.0201
;
run;
proc print;
   var p123 p12 p13 p23 p1 p2 p3;
run;


/* Program 8.5: Step-down Dunnett Critical Points */

data;
   do i=1 to 6;
      c_i =-probmc("DUNNETT1",.,.95,21,i);
      diff_i=c_i*(210.0048*2/4)**0.5;
      output;
   end;
proc print; run;


/* Program 8.6: Dose-Response Contrasts for the Analysis of Angina Drug Data */

data angina;
do dose = 0 to 4;    
   do i = 1 to 10;
      input response @@;
      output;
   end;
end;
datalines;
12.03 19.06 14.24 11.17 16.19 10.80 13.18 10.35 15.99 18.01
17.54 15.48 21.26  9.63 14.53 15.51 16.20 12.86 23.78 15.18
18.97 18.96 18.92 13.51 16.27 17.49 15.67 14.41 17.93 22.86
20.60 19.19 23.38 18.52 17.45 14.93 21.16 13.03 21.51 21.20
25.29 32.32 24.08 18.25 26.98 28.29 25.39 21.36 23.91 20.14
;
proc glm data=angina;
   class dose;
   model response=dose;
   contrast 'all doses      '  dose -2 -1 0 1 2; 
   contrast 'next to highest'  dose -3 -1 1 3 0;
   contrast 'middle dose    '  dose -1  0 1 0 0;
   contrast 'low dose       '  dose -1  1 0 0 0;
run;


/* Program 8.7: Rom-Costello-Connell Closed Dose-Response Testing */

%rcc(DataSet  = angina   ,
     Groups   = dose     ,
     Response = Response ,
     FWE      = 0.05     );


/* Program 8.8:  Williams' Test on Heart Rate Data */

data hr;
do trt = 1 to 5;
      do j = 1 to 12;
         input response @@;
         output;
         end;
      end;
cards;
     5 7 10  3 -6 10 11 13 -2 -4 5  8
    -3 -5 7 6 -8 -5 7 2 -4 -5 -1 3
    -1 6 -2 -3 5 6 -1 -5 5 7 0 -2
     12 8 0 -3 7 9 2 -2 5 2 -1 10
     5 11 9 9 7 0 10 11 14 9 8  10
;

%macro Williams(dataset=,trt=,response=);


/* Program 8.9:  Logically Constrained Tests on Cholesterol Reduction Data */

%macro Contrasts;
   C =  {-1 1 0 0 0, -1  0 1 0 0, -1  0  0 1 0, -1  0  0  0 1 ,
                      0 -1 1 0 0,  0 -1  0 1 0,  0 -1  0  0 1 ,
                                   0  0 -1 1 0,  0  0 -1  0 1 ,
                                                 0  0  0 -1 1 };
   C=C`;
   clab =     {"2-1", "3-1", "4-1", "5-1",
                      "3-2", "4-2", "5-2",
                             "4-3", "5-3",
                                    "5-4"};
%mend;

%macro Estimates;
   mse = 10.41668;
   df = 45;
   EstPar = {20.948 , 15.361 , 12.375 , 9.225 , 5.782  };
   cov = mse*(1/10)*I(5);
%mend;

%SimTests(seed=121211, type=LOGICAL);


/* Program 8.10: Simplifying the %Contrasts Macro for Pairwise Comparisons */

%macro Contrasts;
   g = 5;
   free c clab;
   do i = 1 to g-1;
      do j = i+1 to g;
         c    = c    // ((1:g)=i) - ((1:g)=j);
         clab = clab // (     trim(left(char(i,5)))
                         +'-'+trim(left(char(j,5))));
      end;
   end;
   c=c`;
%mend;


/* Program 8.11: Analysis of More General Contrasts using %SimTests */

%macro Contrasts;
   C =  {-1  1  0 0 0, -1  0 1 0 0,  0 -1  1 0 0,
         -1 -1 -1 3 0,
         -1 -1 -1 0 3 };

   C=C`;
   clab =   {"2-1"     , "3-1", "3-2",
             "D-test"  ,
             "E-test"  };
%mend;

%macro Estimates;
   mse = 10.41668;
   df = 45;
   EstPar = {20.948 , 15.361 , 12.375 , 9.225 , 5.782  };
   cov = mse*(1/10)*I(5);
%mend;

%SimTests(seed=121211, type=LOGICAL, nsamp=50000);


/* Program 8.12:  Multiple Tests with General Contrasts and Correlations */

proc glm data=litter outstat=stat;
   class dose;
   model weight = dose gesttime number;
   lsmeans dose/out=ests cov;
run;

%macro Estimates;
   use ests;
   read all var {lsmean} into EstPar;
   read all var {cov1 cov2 cov3 cov4} into Cov;
   use stat(where=(_TYPE_='ERROR'));
   read all var {df} into df;
%mend;

%macro Contrasts;
   c = { 1     -1      0      0     ,
         1      0     -1      0     ,
         1      0      0     -1     ,
         0.750  0.250 -0.250 -0.750 , 
         0.384  0.370  0.246 -1.000 ,
         0.887  0.113 -0.339 -0.661 };
   c=c`;
   clab = { "cont-low " ,
            "cont-mid " ,
            "cont-high" ,
            "ordinal  " ,
            "arith    " ,
            "log ord  " };   
%mend;

%SimTests(nsamp=50000,seed=121211,type=LOGICAL,side=U);


/* Program 9.1: Industrial Waste Output */

data waste;
   do temp = 1 to 3;
      do envir = 1 to 5;
         do rep=1 to 2;
         input waste @@;
         output;
         end;
      end;
   end;
datalines;
7.09 5.90  7.94 9.15 9.23 9.85  5.43  7.73  9.43 6.90
7.01 5.82  6.18 7.19 7.86 6.33  8.49  8.67  9.62 9.07
7.78 7.73 10.39 8.78 9.27 8.90 12.17 10.95 13.07 9.76
;
run;


/* Program 9.2: Multiple Comparisons of Main Effects in Balanced ANOVA */

proc glm data=waste;
   class envir temp;
   model waste = envir temp envir*temp;
   lsmeans temp envir/pdiff cl adjust=tukey;
run;


/* Program 9.3: Simultaneous Tests of Both Sets of Main Effects Contrasts */

%MakeGLMStats(dataset  = waste      ,
              classvar = envir temp ,
              yvar     = waste      ,
              model    = envir*temp );

%macro Contrasts;
   C = {0  1  1  1 -1 -1 -1  0  0  0  0  0  0  0  0  0 ,
        0  1  1  1  0  0  0 -1 -1 -1  0  0  0  0  0  0 ,
        0  1  1  1  0  0  0  0  0  0 -1 -1 -1  0  0  0 ,
        0  1  1  1  0  0  0  0  0  0  0  0  0 -1 -1 -1 ,
        0  0  0  0  1  1  1 -1 -1 -1  0  0  0  0  0  0 ,
        0  0  0  0  1  1  1  0  0  0 -1 -1 -1  0  0  0 ,
        0  0  0  0  1  1  1  0  0  0  0  0  0 -1 -1 -1 ,
        0  0  0  0  0  0  0  1  1  1 -1 -1 -1  0  0  0 ,
        0  0  0  0  0  0  0  1  1  1  0  0  0 -1 -1 -1 ,
        0  0  0  0  0  0  0  0  0  0  1  1  1 -1 -1 -1 };
   C=C/3;
   C1 = {0  1 -1  0  1 -1  0  1 -1  0  1 -1  0  1 -1  0 ,
         0  1  0 -1  1  0 -1  1  0 -1  1  0 -1  1  0 -1 ,
         0  0  1 -1  0  1 -1  0  1 -1  0  1 -1  0  1 -1 };
   C1 = C1/5;
   C = C//C1;
   C=C`;
   Clab = {"e1-e2","e1-e3","e1-e4","e1-e5",
                   "e2-e3","e2-e4","e2-e5",
                           "e3-e4","e3-e5",
                                   "e4-e5",
           "t1-t2","t1-t3",
                   "t2-t3"};
%mend;

%SimTests(seed=121211, type=LOGICAL);


/* Program 9.4:  Simultaneous Confidence Intervals for Interaction Contrasts */

%MakeGLMStats(dataset  = waste      ,
              classvar = envir temp ,
              yvar     = waste      ,
              model    = envir*temp );

%let a=5;   /* Levels of first CLASS variable */
%let b=3;   /* Levels or second CLASS variable */

%macro Contrasts;
   start tlc(n); return(trim(left(char(n,20)))); finish;

   idi=(1:&a);
   idj=(1:&b);
   free C clab;
   do i1=1 to &a-1; do i2=i1+1 to &a;
      do j1=1 to &b-1; do j2=j1+1 to &b;
         C    = C    // (0 || ( ((idi=i1) - (idi=i2))
                               @((idj=j1) - (idj=j2))));
         clab = clab //   "("+tlc(i1)+tlc(j1)+"-"+tlc(i1)+tlc(j2)+")"
                        +"-("+tlc(i2)+tlc(j1)+"-"+tlc(i2)+tlc(j2)+")";
      end; end;
   end; end;
   C=C`;
%mend;

%SimIntervals(nsamp=100000,seed=12345);


/* Program 9.5: Multiple Comparisons With One Observation Per Cell */

data waste1;
   set waste;
   if rep=1; run;
proc glm;
   class envir temp;
   model waste = envir temp;
   means envir temp/regwq lines;
   ods select MCLinesInfo MCLines;
run;


/* Program 9.6: Comparisons With One Observation Per Cell: Global Family */

%MakeGLMStats(dataset  = waste1     ,
              classvar = envir temp ,
              yvar     = waste      ,
              model    = envir temp );

%macro Contrasts;
   C = {0   1 -1  0  0  0     0  0  0 ,
        0   1  0 -1  0  0     0  0  0 ,
        0   1  0  0 -1  0     0  0  0 ,
        0   1  0  0  0 -1     0  0  0 ,
        0   0  1 -1  0  0     0  0  0 ,
        0   0  1  0 -1  0     0  0  0 ,
        0   0  1  0  0 -1     0  0  0 ,
        0   0  0  1 -1  0     0  0  0 ,
        0   0  0  1  0 -1     0  0  0 ,
        0   0  0  0  1 -1     0  0  0 ,
        0   0  0  0  0  0     1 -1  0 ,
        0   0  0  0  0  0     1  0 -1 ,
        0   0  0  0  0  0     0  1 -1 };
   C=C`;
   Clab = {"e1-e2","e1-e3","e1-e4","e1-e5",
                   "e2-e3","e2-e4","e2-e5",
                           "e3-e4","e3-e5",
                                   "e4-e5",
           "t1-t2","t1-t3",
                   "t2-t3"};
%mend;

%SimTests(seed=121211, type=LOGICAL);


/* Program 9.7:  Drug Study Data: Comparisons of LS-Means
with Unbalanced Data */

data drug;
   input drug disease @;
   do i=1 to 6;
      input response @;
      output;
      end;
cards;
1 1 42 44 36 13 19 22
1 2 33  . 26  . 33 21
1 3 31 -3  . 25 25 24
2 1 28  . 23 34 42 13
2 2  . 34 33 31  . 36
2 3  3 26 28 32  4 16
3 1  .  .  1 29  . 19
3 2  . 11  9  7  1 -6
3 3 21  1  .  9  3  .
4 1 24  .  9 22 -2 15
4 2 27 12 12 -5 16 15
4 3 22  7 25  5 12  .
;
proc glm;
   class drug disease;
   model response = drug disease drug*disease/ss3;
   lsmeans drug/ pdiff cl adjust=simulate(seed=121211 acc=.001);
   ods select  OverallANOVA ModelANOVA LSMeanDiffCL;
run;


/* Program 9.8: BIBD Data for Detergents */

data detergent;
   do detergent=1 to 5;
      do block =1 to 10;
      input plates @@;
      output;
      end;
   end;
datalines;
27 28 30 31 29 30  .  .  .  .
26 26 29  .  . .  30 21 26  .
30  .  . 34 32 .  34 31  . 33
 . 29  . 33  . 34 31  . 33 31
 .  . 26  . 24 25  . 23 24 26
;


/* Program 9.9: Simultaneous Confidence Intervals for Treatment Differences */

proc glm data=detergent;
   class block detergent;
   model plates = block detergent;
   lsmeans detergent/pdiff cl adjust=simulate
      (acc=.001 report seed=121211);
run;


/* Program 9.10: Step-down Comparisons of BIBD Means */

%MakeGLMStats(dataset   = detergent       ,
              classvar  = block detergent ,
              yvar      = plates          ,
              model     = block detergent ,
              contrasts = all(detergent)  );

%SimTests(nsamp=100000,seed=121211,type=LOGICAL);


/* Program 9.11:  Weight Gain in Pigs */

data pigs;
   do pen = 1 to 5;
      do feed = 1 to 3;
         do sex = 'M','F';
            input gain initial @@;
            output;
         end;
      end;
   end;
datalines;
 9.52 38  9.94 48   8.51 39 10.00 48   9.11 48  9.75 48
 8.21 35  9.48 32   9.95 38  9.24 32   8.50 37  8.66 28
 9.32 41  9.32 35   8.43 46  9.34 41   8.90 42  7.63 33
10.56 48 10.90 46   8.86 40  9.68 46   9.51 42 10.37 50
10.42 43  8.82 32   9.20 40  9.67 37   8.76 40  8.57 30
;


/* Program 9.12:  Simultaneous Intervals in a Three-Factor ANCOVA
with Interaction */

%MakeGLMStats(dataset  = pigs,
              classvar = pen feed sex,
              yvar     = gain,
              model    = pen feed sex feed*sex initial);

%macro Contrasts;
Cfeed = {0   0 0 0 0 0   2 -2  0   0  0   1  1 -1 -1  0  0   0 ,
         0   0 0 0 0 0   2  0 -2   0  0   1  1  0  0 -1 -1   0 ,
         0   0 0 0 0 0   0  2 -2   0  0   0  0  1  1 -1 -1   0 };
Cfeed = Cfeed/2;
Csex  = {0   0 0 0 0 0   0  0  0   3 -3   1 -1  1 -1  1 -1   0 };
Csex = Csex/3;
Cinit = {0   0 0 0 0 0   0  0  0   0  0   0  0  0  0  0  0   1 };
C = Cfeed//Csex//Cinit;
C=C`;
Clab = {"Feed1-Feed2","Feed1-Feed3","Feed2-Feed3","F-M","Init"};
%mend;

%SimIntervals(nsamp=50000,seed=121211);


/* Program 9.13: Simultaneous Tests in a Three-Factor ANCOVA
with Interaction */

%SimTests(nsamp=50000, seed=121211, type=LOGICAL);


/* Program 9.14: Frequency Tabulation of Respiratory Health Data */

data respiratory;
   input  T$ Age R0-R4 @@;
   Score = (R1 + 2*R2 + 3*R3 + 4*R4)/10;
   if (T = 'A')  then Treatment  = 'Active ';
   else               Treatment  = 'Placebo'; drop T;
   if (Age > 30) then AgeGroup   = 'Older  ';
   else               AgeGroup   = 'Younger';
   if (R0 > 2)   then InitHealth = 'Good';
   else               InitHealth = 'Poor';
datalines;
A 32 1 2 2 4 2  A 47 2 2 3 4 4  A 11 4 4 4 4 2  A 14 2 3 3 3 2
A 15 0 2 3 3 3  A 20 3 3 2 3 1  A 22 1 2 2 2 3  A 22 2 1 3 4 4
A 23 3 3 4 4 3  A 23 2 3 4 4 4  A 25 2 3 3 2 3  A 26 1 2 2 3 2
A 26 2 2 2 2 2  A 26 2 4 1 4 2  A 28 1 2 2 1 2  A 28 0 0 1 2 1
A 30 3 3 4 4 2  A 30 3 4 4 4 3  A 31 1 2 3 1 1  A 31 3 3 4 4 4
A 31 0 2 3 2 1  A 32 3 4 4 3 3  A 34 1 1 2 1 1  A 46 4 3 4 3 4
A 48 2 3 2 0 2  A 50 2 2 2 2 2  A 57 3 3 4 3 4  P 13 4 4 4 4 4
P 31 2 1 0 2 2  P 35 1 0 0 0 0  P 36 2 3 3 2 2  P 45 2 2 2 2 1
P 13 3 4 4 4 4  P 14 2 2 1 2 3  P 15 2 2 3 3 2  P 19 2 3 3 0 0
P 20 4 4 4 4 4  P 23 3 3 1 1 1  P 23 4 4 2 4 4  P 24 3 4 4 4 3
P 25 1 1 2 2 2  P 26 2 4 2 4 3  P 26 1 2 1 2 2  P 27 1 2 2 1 2
P 27 3 3 4 3 3  P 23 2 1 1 1 1  P 28 2 0 0 0 0  P 30 1 0 0 0 0
P 37 1 0 0 0 0  P 37 3 2 3 3 2  P 43 2 3 2 4 4  P 43 1 1 1 3 2
P 44 3 4 3 4 2  P 46 2 2 2 2 2  P 49 2 2 2 2 2  P 63 2 2 2 2 2
A 37 1 3 4 4 4  A 39 2 3 4 4 4  A 60 4 4 3 3 4  A 63 4 4 4 4 4
A 13 4 4 4 4 4  A 14 1 4 4 4 4  A 19 3 3 2 3 3  A 20 2 4 4 4 3
A 20 2 1 1 0 0  A 21 3 3 4 4 4  A 24 4 4 4 4 4  A 25 3 4 3 3 1
A 25 3 4 4 3 3  A 25 2 2 4 4 4  A 26 2 3 4 4 4  A 28 2 3 2 2 1
A 31 4 4 4 4 4  A 34 2 4 4 2 4  A 35 4 4 4 4 4  A 37 4 3 2 2 4
A 41 3 4 4 3 4  A 43 3 3 4 4 2  A 52 1 2 1 2 2  A 55 4 4 4 4 4
A 55 2 2 3 3 1  A 58 4 4 4 4 4  A 68 2 3 3 3 4  P 31 3 4 4 4 4
P 32 3 2 2 3 4  P 36 3 3 2 1 3  P 38 1 2 0 0 0  P 39 1 2 1 1 2
P 39 3 2 3 0 0  P 44 3 4 4 4 4  P 47 2 3 3 2 3  P 48 2 2 1 0 0
P 48 2 2 2 2 2  P 51 3 4 2 4 4  P 58 1 4 2 2 0  P 11 3 4 4 4 4
P 14 2 1 2 3 2  P 15 3 2 2 3 3  P 15 4 3 3 3 4  P 19 4 2 2 3 3
P 20 3 2 4 4 4  P 20 1 4 4 4 4  P 33 3 3 3 2 3  P 36 2 4 3 3 4
P 38 4 3 0 0 0  P 42 3 2 2 2 2  P 43 2 1 0 0 0  P 45 3 4 2 1 2
P 48 4 4 0 0 0  P 52 2 3 4 3 4  P 66 3 3 3 4 4
;
proc freq;
   tables Treatment*AgeGroup*InitHealth / nocum list;
run;


/* Program 9.15: Multiple Tests for Treatment Efficacy in
Subgroups */

%MakeGLMStats(dataset  = respiratory                   ,
              classvar = Treatment AgeGroup InitHealth ,
              yvar     = Score                         ,
              model    = Treatment*AgeGroup*InitHealth );

%macro Contrasts;
   CA  = { 0 13 13 11 17  0  0  0  0 }; CA = CA/sum(CA);
   CP  = { 0  0  0  0  0 14 19 12 12 }; CP = CP/sum(CP);
   C1  = CA - CP;

   CAO = { 0 13 13  0  0  0  0  0  0 }; CAO = CAO/sum(CAO);
   CPO = { 0  0  0  0  0 14 19  0  0 }; CPO = CPO/sum(CPO);
   C2  = CAO - CPO;

   CAY = { 0  0  0 11 17  0  0  0  0 }; CAY = CAY/sum(CAY);
   CPY = { 0  0  0  0  0  0  0 12 12 }; CPY = CPY/sum(CPY);
   C3  = CAY - CPY;

   CAG = { 0 13  0 11  0  0  0  0  0 }; CAG = CAG/sum(CAG);
   CPG = { 0  0  0  0  0 14  0 12  0 }; CPG = CPG/sum(CPG);
   C4 =  CAG - CPG;

   CAP = { 0  0 13  0 17  0  0  0  0 }; CAP = CAP/sum(CAP);
   CPP = { 0  0  0  0  0  0 19  0 12 }; CPP = CPP/sum(CPP);
   C5 =  CAP - CPP;

   C6 =  { 0  1  0  0  0 -1  0  0  0 };
   C7 =  { 0  0  1  0  0  0 -1  0  0 };
   C8 =  { 0  0  0  1  0  0  0 -1  0 };
   C9 =  { 0  0  0  0  1  0  0  0 -1 };

   C = C1//C2//C3//C4//C5//C6//C7//C8//C9;
   C = C`;

   Clab = {"Overall","Older","Younger","Good","Poor",
           "OldGood","OldPoor","YoungGood","YoungPoor"};
%mend;

%SimTests(nsamp=50000, seed=121211, type=LOGICAL, side=U);


/* Program 9.16:  Multiple F tests in a Multifactorial ANOVA */

data wine;
  input Purchase CustomerType light music handle examine @@;
  datalines;
0 4 0 0 0  0  0 4 0 0 0  0  0 3 0 0 0  0  0 3 0 0 0 16
0 3 0 0 1  1  0 4 0 0 0  1  1 3 0 0 3 11  0 4 0 0 0  0
0 3 0 0 0  0  0 3 0 0 2  8  0 4 0 0 0  0  0 3 0 0 0  2
0 3 0 0 0  2  0 3 0 0 0  0  0 3 0 0 0  0  0 . 0 1 0  3
0 3 0 1 0  0  0 3 0 1 5  8  0 3 0 1 0  1  0 4 0 1 0  2
0 3 0 1 0  0  0 . 0 1 0  0  0 4 0 1 0  0  0 4 0 1 1  3
0 4 0 1 0  1  1 3 0 1 2  2  0 3 0 1 1  2  0 3 0 1 0  2
0 1 0 1 0  0  0 4 0 1 2  2  0 3 1 1 1  2  0 4 1 1 0  0
3 1 1 1 9 11  0 3 1 1 0  0  0 3 1 1 0  3  1 4 1 1 0  0
0 3 1 1 5  8  0 . 1 1 1  1  0 4 1 1 3  7  0 3 1 1 0  0
0 3 1 1 0  0  0 2 1 0 0  2  0 3 1 0 0  0  0 1 1 0 0  4
0 4 1 0 0  0  0 4 1 0 12 21 0 3 1 0 1  1  0 3 0 0 0  1
0 3 0 0 1  0  0 3 0 0 1  1  0 3 0 0 3  8  0 3 0 0 0  8
0 1 0 0 1  1  0 4 0 0 0  0  0 3 0 0 0  4  1 4 0 0 1  2
0 3 0 0 1  4  1 3 0 0 1  6  0 4 0 1 0  0  0 2 0 1 0  0
0 4 0 1 0  2  0 3 0 1 0  0  0 4 0 1 0  2  0 3 0 1 2  4
0 3 0 1 0  0  0 3 0 1 0  0  0 4 0 1 0  2  0 3 0 1 0  0
1 1 0 1 1  2  0 3 0 1 0  2  0 3 0 1 0  0  0 3 0 1 1  1
0 4 0 1 0  8  0 4 0 1 0  0  0 4 1 0 0  7  0 3 1 0 0  2
0 4 1 0 1  4  0 4 1 0 2  5  0 4 1 0 0  2  0 3 1 0 1  2
0 4 1 0 0  2  0 3 1 0 2  6  0 4 1 0 1  2  0 3 1 0 0  0
0 3 0 1 0  4  0 4 0 1 0  3  0 4 0 1 1  7  0 3 0 1 0  1
0 2 0 1 4  7  0 3 0 1 2  2  0 . 0 1 0  0  0 3 0 1 1  7
0 4 0 1 1 11  0 4 0 1 3 13  0 1 1 0 0  2  0 3 1 0 1  6
0 3 1 0 3  4  0 3 1 0 5  3  0 3 1 0 2 10  0 4 1 0 6  7
0 3 1 0 4  3  0 3 0 0 3 12  0 4 0 0 0  1  1 3 0 0 0  2
0 3 0 0 3  5  0 4 0 0 3  3  2 3 0 0 1  3  0 3 0 0 4  6
0 3 0 0 0  1  0 1 0 0 1  4  1 3 0 0 0  5  0 3 0 0 3  8
0 3 1 1 0  0  0 3 1 1 0  3  0 3 1 1 1  7  0 3 1 1 0 14
0 3 1 1 0 14  0 . 1 1 0  6  6 3 1 1 6  6  0 4 1 1 3  3
0 4 1 1 1  3  0 3 1 1 0  3  0 3 1 1 0  2  1 4 0 0 0  1
0 3 0 0 0  0  0 3 0 0 0 11  0 4 0 0 0  1  0 4 0 0 0  4
0 4 1 1 1  4  0 1 1 1 0  4  0 3 1 1 0  0  1 3 1 1 0  0
1 3 1 1 1 15  0 3 1 1 0  7  0 4 1 1 1  3  0 4 1 1 0  5
0 3 1 1 0  4  0 4 1 1 0  2  0 4 1 1 5 12  0 4 1 1 2  8
0 4 1 1 1  1  0 3 0 1 0  3  0 3 0 1 0  1  1 1 0 1 3  5
0 1 0 1 1 10  0 4 0 1 0  3  0 4 0 1 0  3  0 3 0 1 0  0
0 4 0 1 0  6  0 3 0 1 0  5  0 3 0 1 0  0  0 4 1 0 0  3
0 3 1 0 1  5  0 3 1 0 1  1  2 3 1 0 13 6  0 3 1 0 0  2
0 3 1 0 0  2  0 3 1 0 0  4  0 3 1 0 0  4  1 3 1 0 0  2
0 3 1 0 4  8  0 4 1 0 2  6  0 4 1 1 0  5  0 4 1 1 0  1
0 3 1 1 1 11  0 4 1 1 13 9  0 3 1 1 0  2  0 4 1 1 0  3
0 4 1 1 0  2
;
proc glm data=wine;
   class CustomerType light music;
   model purchase = CustomerType light music
      CustomerType*light CustomerType*music light*music
      CustomerType*light*music handle examine/SS3;
run;


/* Program 10.1: Multiple Comparisons with Nonconstant
Variance */

data wloss;
   do diet = 'A','B','C','D','E';
      do i = 1 to 10;
         input wloss @@;
         output;
         end;
      end;
cards;
12.4 10.7 11.9 11.0 12.4 12.3 13.0 12.5 11.2 13.1
 9.1 11.5 11.3  9.7 13.2 10.7 10.6 11.3 11.1 11.7
 8.5 11.6 10.2 10.9  9.0  9.6  9.9 11.3 10.5 11.2
 8.7  9.3  8.2  8.3  9.0  9.4  9.2 12.2  8.5  9.9
12.7 13.2 11.8 11.9 12.2 11.2 13.7 11.8 11.5 11.7
;

proc mixed data=wloss;
   class diet;
   model wloss=diet/ddfm=satterth;
   repeated /group=diet;
   lsmeans diet/ adjust=simulate(seed=121211) cl;
   ods select tests3;
   ods output diffs=diffs;
run;

proc print data=diffs noobs;
   title "Multiple Heteroscedastic Comparisons";
   var  diet _diet Estimate StdErr DF tValue Probt Adjp AdjLow AdjUpp;
run;


/* Program 10.2: Logically Constrained Step-Down Tests in
Heteroscedastic ANOVA */

%MakeGLMStats(dataset   = wloss,
              classvar  = diet ,
              yvar      = wloss,
              model     = diet ,
              contrasts = all(diet));

ods output Tests3   =Tests3
           SolutionF=SolutionF
           CovB     =CovB    ;
proc mixed data=wloss;
   class diet;
   model wloss = diet/ddfm=satterth solution covb;
   repeated/group=diet;
run;

%macro Estimates;
   use Tests3;    read all var {DenDf}         into df;
   use CovB;      read all var ("Col1":"Col6") into cov;
   use SolutionF; read all var {Estimate}      into EstPar;
%mend;

%SimTests(seed=121211, type=LOGICAL);


/* Program 10.3: Logically Constrained Step-Down Tests in Homoscedastic ANOVA */

%MakeGLMStats(dataset   = wloss,
              classvar  = diet,
              yvar      = wloss,
              model     = diet,
              contrasts = all(diet));

%SimTests(seed=121211, type=LOGICAL);


/* Program 10.4:  Multiple Comparisons in the Random Block RCBD */

data waste;
   do temp = 1 to 3;
      do envir = 1 to 5;
         do rep=1 to 2;
         input waste @@;
         output;
         end;
      end;
   end;
datalines;
7.09 5.90  7.94 9.15 9.23 9.85  5.43  7.73  9.43 6.90
7.01 5.82  6.18 7.19 7.86 6.33  8.49  8.67  9.62 9.07
7.78 7.73 10.39 8.78 9.27 8.90 12.17 10.95 13.07 9.76
;
data waste1;
   set waste;
   if rep=1;
run;

proc mixed data=waste1;
   class envir temp;
   model waste = temp/ddfm=satterth;
   random envir;
   lsmeans temp/cl adjust=tukey;
   ods output diffs=diffs;
run;

proc print data=diffs noobs;
   title "Multiple Comparisons in Random Block Model";
   var temp _temp Estimate StdErr df AdjLow AdjUpp;
run;


/* Program 10.5: Multiple Comparisons with Random Block Levels: Incomplete Blocks */

data detergent;
   do detergent=1 to 5;
      do block =1 to 10;
      input plates @@;
      output;
      end;
   end;
datalines;
27 28 30 31 29 30  .  .  .  .
26 26 29  .  . .  30 21 26  .
30  .  . 34 32 .  34 31  . 33
 . 29  . 33  . 34 31  . 33 31
 .  . 26  . 24 25  . 23 24 26
;

proc mixed data=detergent;
   class block detergent;
   model plates = detergent/ddfm=satterth;
   random block;
   lsmeans detergent/cl adjust=simulate(seed=121211);
   ods output diffs=diffs;
run;

proc print data=diffs noobs;
   title "Multiple Comparisons in Random Block Model - Incomplete Blocks";
   var detergent _detergent Estimate StdErr df AdjLow AdjUpp;
run;


/* Program 10.6: Multiple Comparisons in Random Block Model with Interaction */

proc mixed data=waste;
   class envir temp;
   model waste = temp/ddfm=satterth;
   random envir envir*temp;
   lsmeans temp/cl adjust=tukey;
   ods output diffs=diffs;
run;

proc print data=diffs noobs;
   title "Multiple Comparisons in Random Block Model with Interaction";
   var temp _temp Estimate StdErr df AdjLow AdjUpp;
run;


/* Program 10.7: Comparison of Repeated Measures Means */

data Halothane;
   do Dog =1 to 19;
      do Treatment = 'HA','LA','HP','LP';
      input Rate @@;
      output;
      end;
   end;
datalines;
426 609 556 600   253 236 392 395   359 433 349 357
432 431 522 600   405 426 513 513   324 438 507 539
310 312 410 456   326 326 350 504   375 447 547 548
286 286 403 422   349 382 473 497   429 410 488 547
348 377 447 514   412 473 472 446   347 326 455 468
434 458 637 524   364 367 432 469   420 395 508 531
397 556 645 625
;
proc mixed data=Halothane;
   class Dog Treatment;
   model Rate = Treatment / ddfm=satterth;
   repeated / type=un subject=Dog;
   lsmeans Treatment / adjust=simulate(nsamp=200000 seed=121211) cl pdiff;
   ods output Diffs=Diffs;
run;

proc print data=Diffs noobs;
   title "Multiple Comparisons in Repeated Measures Model";
   var Treatment _Treatment Estimate StdErr df AdjLow AdjUpp;
run;


/* Program 10.8: Logically Constrained Step-Down Tests with 
Repeated Measures Data */

proc mixed data=Halothane;
   class Dog Treatment;
   model Rate = Treatment / ddfm=satterth;
   repeated / type=un subject=Dog;
   lsmeans Treatment / cov;
   ods output LSmeans = LSmeans;
   ods output Tests3  = Tests3;
run;

%macro Contrasts;
   C = {  1  -1   0   0 ,
          1   0  -1   0 ,
          1   0   0  -1 ,
          0   1  -1   0 ,
          0   1   0  -1 ,
          0   0   1  -1 ,
        -.5 -.5  .5  .5 ,
         .5 -.5  .5 -.5 ,
          1  -1  -1   1 };
   C = C` ;

   Clab = {"HA-HP","HA-LA","HA-LP",
                   "HP-LA","HP-LP",
                           "LA-LP",
           "Halo"                 ,
           "CO2"                  ,
           "Interaction"          };  /* Contrast labels */
%mend;

%macro Estimates;
   use tests3;
   read all var {DenDf} into df;
   use lsmeans;
   read all var {Cov1 Cov2 Cov3 Cov4} into cov;
   read all var {Estimate} into EstPar;
%mend;

%SimTests(nsamp=40000, seed=121211, type=LOGICAL);


/* Program 10.9:  Multiple Comparisons of Multiple Outcomes
in the MANOVA Framework */

data MultipleEndpoints;
   Treatment = 'Placebo';
   do Subject = 1 to 54;
      do Endpoint = 1 to 4; input y @@; output; 
      end;
   end;
   Treatment = 'Drug';
   do Subject = 54+1 to 54+57;
      do Endpoint = 1 to 4; input y @@; output; 
      end;
   end;
datalines;
4 3 3 5  5 0 1 7  1 0 1 9  4 0 3 5  3 0 2 9  4 1 2 6  2 0 4 6
2 2 5 5  3 0 1 7  2 0 1 9  4 6 5 5  2 0 2 8  2 7 1 7  1 2 2 9
4 0 3 7  3 0 1 6  3 0 1 6  4 1 4 6  6 0 4 7  3 0 1 8  3 0 1 9
2 1 2 7  6 2 3 5  3 0 4 7  3 0 1 9  2 0 1 9  6 9 6 3  4 9 2 6
2 0 1 7  1 0 1 9  4 0 4 7  3 1 4 6  3 0 3 7  1 0 1 8  6 7 5 4
4 6 2 5  6 19 7 5 6 3 6 6  3 0 5 6  2 4 2 8  1 0 1 8  4 21 5 5
2 0 2 9  4 7 3 5  3 1 2 8  3 3 3 8  4 3 4 6  1 0 1 10 1 0 2 9
3 0 4 5  3 1 1 6  3 4 4 6  5 8 5 5  5 1 5 4  1 0 4 8  1 0 1 10
1 0 1 9  2 1 2 7  4 1 2 5  5 0 5 6  1 4 5 6  5 6 4 6  2 0 2 9
2 2 2 5  1 0 1 10 3 2 3 6  5 4 6 6  2 1 2 8  2 1 2 6  2 1 1 8
3 0 3 9  3 1 2 6  1 0 2 9  1 0 1 9  3 0 3 9  1 0 1 10 1 0 1 9
1 0 1 10 2 0 4 7  5 1 2 6  4 0 5 7  4 0 4 6  2 1 3 6  2 1 1 6
4 0 4 6  1 0 1 8  1 0 2 9  4 1 3 6  4 3 4 5  4 2 5 5  1 0 1 10
3 0 2 8  4 2 2 8  3 0 2 9  1 0 1 10 1 0 1 9  2 0 2 9  2 1 2 8
3 0 3 8  2 4 2 6  2 1 1 9  2 2 2 9  4 0 1 4  3 3 1 8  4 4 3 6
2 0 1 10 4 2 3 6  1 0 1 8  2 0 2 8  5 1 5 5  4 0 4 6
;
proc mixed data=MultipleEndpoints;
   title "Two-Sample Multivariate Mean Comparisons";
   class Endpoint Treatment Subject;
   model y = Treatment*Endpoint / ddfm=satterth;
   repeated / type=un subject=Subject;
   lsmeans Treatment*Endpoint / cov;
   contrast 'F test' Treatment*Endpoint 1 -1  0  0  0  0  0  0 ,
                     Treatment*Endpoint 0  0  1 -1  0  0  0  0 ,
                     Treatment*Endpoint 0  0  0  0  1 -1  0  0 ,
                     Treatment*Endpoint 0  0  0  0  0  0  1 -1 ;
   ods output LSmeans   = LSmeans;
   ods output Contrasts = Contrasts;
run;

%macro Contrasts;
   C = { 1 -1  0  0  0  0  0  0 ,
         0  0  1 -1  0  0  0  0 ,
         0  0  0  0  1 -1  0  0 ,
         0  0  0  0  0  0  1 -1 };
   C = C` ;

   Clab = {"Endpoint 1", "Endpoint 2", "Endpoint 3", "Endpoint 4"};
%mend;

%macro Estimates;
   use Contrasts; read all var {DenDf} into df;
   use LSmeans;
   read all var {Cov1 Cov2 Cov3 Cov4 Cov5 Cov6 Cov7 Cov8} into cov;
   read all var {Estimate} into EstPar;
%mend;

%SimTests(seed=121211, nsamp=100000);


/* Program 10.10: Multiple Comparisons of Means in MANCOVA */

data Obesity;
   input Group $ Creatinine Chloride Volume @@;
   Subject = _n_;
   datalines;
LU 17.6  5.15 205  LU 13.4  5.75 160  LU 20.3  4.35 480
LU 22.3  7.55 230  LU 20.5  8.50 235  LU 18.5 10.25 215
LU 12.1  5.95 215  LU 12.0  6.30 190  LU 10.1  5.45 190
LU 14.7  3.75 175  LU 14.8  5.10 145  LU 14.4  4.05 155
HU 18.1  9.00 220  HU 19.7  5.30 300  HU 16.9  9.85 305
HU 23.7  3.60 275  HU 19.2  4.05 405  HU 18.0  4.40 210
HU 14.8  7.15 170  HU 15.6  7.25 235  HU 16.2  5.30 185
HU 14.1  3.10 255  HU 17.5  2.40 265  HU 14.1  4.25 305
HU 19.1  5.80 440  HU 22.5  1.55 430  LO 17.0  4.55 350
LO 12.5  2.65 475  LO 21.5  6.50 195  LO 22.2  4.85 375
LO 13.0  8.75 160  LO 13.0  5.20 240  LO 10.9  4.75 205
LO 12.0  5.85 270  LO 22.8  2.85 475  LO 16.5  6.55 430
LO 18.4  6.60 490  HO 12.5  2.90 105  HO  8.7  3.00 115
HO  9.4  3.40  97  HO 15.0  5.40 325  HO 12.9  4.45 310
HO 12.1  4.30 245  HO 13.2  5.00 170  HO 11.5  3.40 220
;

data ObesityU;  /* Change multivariate data format to MIXED data format */
   set Obesity;
   Compound = 'Creatinine'; Amount = Creatinine; output;
   Compound = 'Chloride'  ; Amount = Chloride;   output;
   keep Subject Group Compound Amount Volume;
run;

proc mixed data=ObesityU order=data;
   class Group Compound Subject;
   model Amount = Group*Compound Volume*Compound / ddfm=satterth s;
   repeated / type=un subject = Subject;
   lsmeans Group*Compound / cov;
   contrast 'F test' Group*Compound 1  0 -1  0  0  0  0  0 ,
                     Group*Compound 1  0  0  0 -1  0  0  0 ,
                     Group*Compound 1  0  0  0  0  0 -1  0 ,
                     Group*Compound 0  1  0 -1  0  0  0  0 ,
                     Group*Compound 0  1  0  0  0 -1  0  0 ,
                     Group*Compound 0  1  0  0  0  0  0 -1 ;
   ods output LSmeans   = LSmeans;
   ods output Contrasts = Contrasts;
run;

%macro Contrasts;
   C = { 1  0 -1  0  0  0  0  0 ,
         1  0  0  0 -1  0  0  0 ,
         1  0  0  0  0  0 -1  0 ,
         0  0  1  0 -1  0  0  0 ,
         0  0  1  0  0  0 -1  0 ,
         0  0  0  0  1  0 -1  0 ,
         0  1  0 -1  0  0  0  0 ,
         0  1  0  0  0 -1  0  0 ,
         0  1  0  0  0  0  0 -1 ,
         0  0  0  1  0 -1  0  0 ,
         0  0  0  1  0  0  0 -1 ,
         0  0  0  0  0  1  0 -1 };

   C = C` ;

   Clab = {"Creatine,LU-HU","Creatine,LU-LO","Creatine,LU-HO",
                            "Creatine,HU-LO","Creatine,HU-HO",
                                             "Creatine,LO-HO",
           "Chloride,LU-HU","Chloride,LU-LO","Chloride,LU-HO",
                            "Chloride,HU-LO","Chloride,HU-HO",
                                             "Chloride,LO-HO"};
%mend;

%macro Estimates;
   use Contrasts; read all var {DenDf} into df;
   use LSmeans;
   read all var {Cov1 Cov2 Cov3 Cov4 Cov5 Cov6 Cov7 Cov8} into cov;
   read all var {Estimate} into EstPar;
%mend;

%SimIntervals(seed=121211, nsamp=50000);


/* Program 10.11: Global Tests of 'Sliced' Effects */

data heart;
   do drug = 'ax23', 'bww9', 'ctrl';
      do person = 1 to 8;
         do time = 't1', 't2', 't3', 't4'; 
         input hr @@;
         output;
         end;
      end;
   end;
datalines;
72 86 81 77  78 83 88 81  71 82 81 75  72 83 83 69
66 79 77 66  74 83 84 77  62 73 78 70  69 75 76 70
85 86 83 80  82 86 80 84  71 78 70 75  83 88 79 81
86 85 76 76  85 82 83 80  79 83 80 81  83 84 78 81
69 73 72 74  66 62 67 73  84 90 88 87  80 81 77 72
72 72 69 70  65 62 65 61  75 69 69 68  71 70 65 63
;
proc mixed data=heart;
   class time drug person;
   model hr = time*drug / ddfm=satterth;
   repeated time / type=un subject=person(drug);
   lsmeans time*drug / slice=time;

run;


/* Program 10.12: Multiple Comparisons of 'Sliced' Effects */

proc mixed data=heart;
   class time drug person;
   model hr = time*drug / ddfm=satterth;
   repeated / type=un subject = person(drug);
   lsmeans time*drug / cov;
   contrast 'F test' time*drug  1 -1  0   0  0  0   0  0  0   0  0  0 ,
                     time*drug  1  0 -1   0  0  0   0  0  0   0  0  0 ,
                     time*drug  0  0  0   1 -1  0   0  0  0   0  0  0 ,
                     time*drug  0  0  0   1  0 -1   0  0  0   0  0  0 ,
                     time*drug  0  0  0   0  0  0   1 -1  0   0  0  0 ,
                     time*drug  0  0  0   0  0  0   1  0 -1   0  0  0 ,
                     time*drug  0  0  0   0  0  0   0  0  0   1 -1  0 ,
                     time*drug  0  0  0   0  0  0   0  0  0   1  0 -1 ;
   ods output LSmeans   = LSmeans;
   ods output Contrasts = Contrasts;
run;

%macro Contrasts;
   C = { 1 -1  0   0  0  0   0  0  0   0  0  0 ,
         1  0 -1   0  0  0   0  0  0   0  0  0 ,
         0  1 -1   0  0  0   0  0  0   0  0  0 ,
         0  0  0   1 -1  0   0  0  0   0  0  0 ,
         0  0  0   1  0 -1   0  0  0   0  0  0 ,
         0  0  0   0  1 -1   0  0  0   0  0  0 ,
         0  0  0   0  0  0   1 -1  0   0  0  0 ,
         0  0  0   0  0  0   1  0 -1   0  0  0 ,
         0  0  0   0  0  0   0  1 -1   0  0  0 ,
         0  0  0   0  0  0   0  0  0   1 -1  0 ,
         0  0  0   0  0  0   0  0  0   1  0 -1 ,
         0  0  0   0  0  0   0  0  0   0  1 -1 };
   C = C` ;
   Clab = {"Time1, a-b","Time1, a-c","Time1, b-c",
           "Time2, a-b","Time2, a-c","Time2, b-c",
           "Time3, a-b","Time3, a-c","Time3, b-c",
           "Time4, a-b","Time4, a-c","Time4, b-c"};
%mend;

%macro Estimates;
   use Contrasts; read all var {DenDf} into df;
   use LSmeans;
   read all var {Cov1 Cov2 Cov3 Cov4 Cov5 Cov6 Cov7 Cov8 Cov9
                      Cov10 Cov11 Cov12} into cov;
   read all var {Estimate} into EstPar;
%mend;

%SimTests(seed=121211, nsamp=50000);


/* Program 11.1: Bootstrap Multiple Comparisons of Means in
the ANOVA */

proc multtest data=wloss bootstrap seed=121211 n=50000;
   class diet;
   test mean(wloss);
   contrast "A-B"  1 -1  0  0  0 ;
   contrast "A-C"  1  0 -1  0  0 ;
   contrast "A-D"  1  0  0 -1  0 ;
   contrast "A-E"  1  0  0  0 -1 ;
   contrast "B-C"  0  1 -1  0  0 ;
   contrast "B-D"  0  1  0 -1  0 ;
   contrast "B-E"  0  1  0  0 -1 ;
   contrast "C-D"  0  0  1 -1  0 ;
   contrast "C-E"  0  0  1  0 -1 ;
   contrast "D-E"  0  0  0  1 -1 ;
   ods select continuous pValues;
run;


/* Program 11.2:  Bootstrap Two-Sample t-Test Using PROC MULTTEST */

data wlossBE;
   set wloss;
   if diet="B" or diet="E"; run;

proc multtest data=wlossBE bootstrap n=100000;
   class diet;
   test(mean);
   contrast "B-E" 1 -1;
run;


/* Program 11.3: Two-Sample Permutation Test and Rank
Test Using PROC MULTTEST */

proc multtest data=wlossBE permutation;
   title "Permutation Test using Raw Data";
   class diet;
   test mean(wloss);
   contrast "B-E" 1 -1;
   ods select continuous pValues;
run;

proc rank data=wlossBE;
   var wloss;
   ranks wlossranks;
run;

proc multtest data=wlossBE permutation;
   title "Permutation Test using Ranks";
   class diet;
   test mean(wlossranks);
   contrast "B-E" 1 -1;
   ods select continuous pValues;
run;


/* Program 11.4: Pairwise Comparisons using the
Global Permutation Distribution */

proc multtest data=wloss permutation seed=121211 n=50000;
   class diet;
   test mean(wloss);
   contrast "A-B"  1 -1  0  0  0 ;
   contrast "A-C"  1  0 -1  0  0 ;
   contrast "A-D"  1  0  0 -1  0 ;
   contrast "A-E"  1  0  0  0 -1 ;
   contrast "B-C"  0  1 -1  0  0 ;
   contrast "B-D"  0  1  0 -1  0 ;
   contrast "B-E"  0  1  0  0 -1 ;
   contrast "C-D"  0  0  1 -1  0 ;
   contrast "C-E"  0  0  1  0 -1 ;
   contrast "D-E"  0  0  0  1 -1 ;
   ods select pValues;
run;


/* Program 11.5: Testing Multiple Endpoints in Clinical Trials
Using PROC MULTTEST */

proc multtest data=multiple_endp_mv stepboot n=100000 seed=121211;
   class tx;
   test mean(y1-y4);
   contrast "t vs c" -1 1;
run;


/* Program 11.6: Inferences over Multiple Variables
and Subgroup Contrasts} */

data respiratory1;
   set respiratory;
   treat_x_age=compress(Treatment||'_'||AgeGroup,' ');
   score_control = score-r0;
run;
proc sort data=respiratory1 out=respiratory2;
   by treat_x_age; run;
proc multtest data=respiratory2 stepboot n=100000 seed=121211;
   class treat_x_age;
   test mean(score score_control/upper);
   contrast "Active-Placebo"         1 1 -1 -1 ;
   contrast "Active-Placebo, Old"    1 0 -1  0 ;
   contrast "Active-Placebo, Young"  0 1 0  -1 ;
run;


/* Program 12.1: Multiple Two-Sample Binary Data Tests */

data Adverse; keep Group AE1-AE28;
   array AE{28};
   length Group $ 9;

   input Group nTotal nNone;
   do i = 1 to dim(AE); AE{i} = 0; end;
   do iobs = 1 to nNone; output; end;
   do iobs = 1 to nTotal-nNone;
      input nAE @@;
      do i = 1 to dim(AE); AE{i} = 0; end;
      do i = 1 to nAE; input iAE @@; AE{iAE} = 1; end;
      output;
      end;
   datalines;
Control   80 46
4 2 3 17 28    2 18 28        2 2 28         3 4 22 28
3 1 3 28       2 1 28         4 2 3 11 28    2 2 28     
3 12 27 28     2 1 28         3 2 19 28      3 1 9 28
2 14 28        2 7 28         2 4 28         2 4 28       
2 2 28         2 3 28         4 1 4 9 28     3 1 26 28    
2 1 28         3 5 12 28      2 2 28         2 4 28                   
3 5 13 28      2 16 28        2 9 28         3 1 2 28     
2 24 28        2 2 28         2 7 28         2 7 28                     
2 25 28        5 3 14 19 21 28
Treatment 80 44
2 23 28        2 1 28         3 1 4 28       2 2 28       
2 1 28         4 1 3 6 28     4 1 5 8 28     3 1 21 28 
3 1 10 28      3 3 8 28       5 1 2 3 10 28  3 2 15 28                
2 1 28         3 2 6 28       4 1 5 9 28     3 1 5 28
3 1 15 28      2 7 28         2 7 28         3 1 8 28
3 1 6 28       3 1 3 28       3 1 6 28       3 2 8 28
3 1 4 28       3 1 2 28       3 1 20 28      3 1 4 28
3 1 2 28       2 1 28         4 1 5 16 28    3 2 8 28     
2 1 28         4 1 4 5 28     2 3 28         2 3 28
;

proc multtest data=Adverse stepperm seed=121211;
   class Group;
   test fisher(AE1-AE28/upper);
   contrast "Treatment-Control" -1 1;
   ods output Discrete=Discrete;
   ods output pValues=pValues;
run;

proc sort data=Discrete out=Discrete; by Variable;
proc sort data=pValues  out=pValues ; by Variable;
data both; merge Discrete pValues;    by Variable;
   run;

proc sort data=both out=both;
   by Raw;
data best5; set both; if _n_<=10;
   run;

proc print noobs data=best5;
   title "Counts and Percentages for the Most Significant AEs";
   var Variable Group count NumObs Percent;
run;

proc print noobs
   data=best5(where =(Group              ='Control')
              rename=(Raw                =RawPValue
                      StepdownPermutation=AdjustedPValue));
   title "Fisher Exact (Raw) and Multivariate Permutation-Adjusted p-Values";
   var Variable RawPValue AdjustedPValue;
run;


/* Program 12.2:  Multiple Cochran-Armitage Permutation Tests, with Permutation
Distribution Output */

proc multtest data=Adverse outperm=permdists;
   class Group;
   test ca(AE1-AE28/upper permutation=100);
   contrast "Treatment-Control" -1 1;
   ods output pValues=pValues;
run;

proc sort data=pValues out=pValues;
   by Raw;
proc print noobs data=pValues(obs=5 rename=(Raw = ExactCAPValue));
   title "Exact Permutation pValues for CA Tests";
run;

proc print noobs data=permdists;
   where (_var_="AE6");
   title "Permutation Distribution of CA test for AE6";
run;


/* Program 12.3:  Discrete Bonferroni-Based Multiple Tests Using Binary Data */

proc multtest data=Adverse stepbon;
   class Group;
   test ca(AE1-AE28/upper permutation=100);
   contrast "Treatment-Control" -1 1;
   ods output pValues=pValues;
run;

proc sort data=pValues out=pValues;
   by Raw;
proc print data=pValues(obs=5 rename=(Raw=ExactCAPValue));
   title "Exact Raw pValues and Discrete Bonferroni Adjustments";
   var variable ExactCAPValue StepdownBonferroni;
run;


/* Program 12.4:  All Binary Pairwise Comparisons Using the Global Permutation 
Distribution: Example 1 */

data rabbits;
   input died freq Penicillin$ @@;
datalines;
0  0 1/8   1 11 1/8
0  3 1/4   1  9 1/4
0  8 1/2   1  4 1/2
0 11  1    1  1  1
0  7  4    1  0  4
;
proc multtest order=data stepperm;
   class Penicillin;
   freq freq;
   test fisher(died);
   contrast "1/8 vs 1/4" -1  1  0  0  0 ;
   contrast "1/8 vs 1/2" -1  0  1  0  0 ;
   contrast "1/8 vs 1"   -1  0  0  1  0 ;
   contrast "1/8 vs 4"   -1  0  0  0  1 ;
   contrast "1/4 vs 1/2"  0 -1  1  0  0 ;
   contrast "1/4 vs 1"    0 -1  0  1  0 ;
   contrast "1/4 vs 4"    0 -1  0  0  1 ;
   contrast "1/2 vs 1"    0  0 -1  1  0 ;
   contrast "1/2 vs 4"    0  0 -1  0  1 ;
   contrast "1 vs 4"      0  0  0 -1  1 ;
   ods select Discrete pValues;
run;


/* Program 12.5:  All Binary Pairwise Comparisons Using the Global 
Permutation Distribution: Example 2 */

data trouble;
   input b f g;
datalines;
0  2000 1
0   1 2
1   3 2
0   3 3
1   1 3
;
proc multtest data=trouble stepperm n=1000;
   class g;
   freq f;
   test fisher(b);
   contrast "1 vs 2"  1 -1  0 ;
   contrast "1 vs 3"  1  0 -1 ;
   contrast "2 vs 3"  0  1 -1 ;
run;


/* Program 12.6: A ``Workaround" for the Subset Pivotality 
Problem: Discrete Bonferroni Method for Pairwise Binary Comparisons */

data Test1vs2; set trouble(where=(g in (1,2)));
   Test1vs2 = b; DummyGroup = (g=2);
data Test1vs3; set trouble(where=(g in (1,3)));
   Test1vs3 = b; DummyGroup = (g=3);
data Test2vs3; set trouble(where=(g in (2,3)));
   Test2vs3 = b; DummyGroup = (g=3);
data TroubleNoMore; set Test1vs2 Test1vs3 Test2vs3;
run;

proc multtest data=TroubleNoMore stepbon;
   class DummyGroup;
   freq f;
   test ca(Test1vs2 Test1vs3 Test2vs3/permutation=10);
   contrast "Pairwise Test" -1 1;
run;


/* Program 12.7: Toxicity Data and Incorrect Comparisons
Against Control */

data Toxicity;
   do Group='Hist','Curr','Low','High';
      do Outcome=0 to 1;
         input Freq @@;
         output;
         end;
      end;
datalines;
326 4
 49 1
 42 7
 44 4
;
proc multtest data=Toxicity order=data stepperm seed=121211;
   class Group;
   freq Freq;
   test fisher(Outcome/lower);
   contrast "Hist vs Curr" -1  1  0  0 ;
   contrast "Low  vs Curr"  0  1 -1  0 ;
   contrast "High vs Curr"  0  1  0 -1 ;
run;


/* Program 12.8:  Adjunct Program Used for Closed Pairwise Testing */

proc multtest data=Toxicity(where=(Group ^= "High"))
              order=data seed=121211 permutation;
   title "Hist=Curr=Low";
   class Group;
   freq Freq;
   test fisher(Outcome/lower);
   contrast "Hist vs Curr" -1  1  0;
   contrast "Low  vs Curr"  0  1 -1;
   ods select pValues;
run;
proc multtest data=Toxicity(where=(Group ^= "Low"))
              order=data seed=121211 permutation;
   title "Hist=Curr=High";
   class Group;
   freq Freq;
   test fisher(Outcome/lower);
   contrast "Hist vs Curr"  -1  1  0;
   contrast "High vs Curr"   0  1 -1;
   ods select pValues;
run;
proc multtest data=Toxicity(where=(Group ^= "Hist"))
              order=data seed=121211 permutation;
   title "Curr=Low=High";
   class Group;
   freq Freq;
   test fisher(outcome/lower);
   contrast "Low  vs Curr"   1 -1  0;
   contrast "High vs Curr"   1  0 -1;
   ods select pValues;
run;


/* Program 12.9: Closed Testing of Pairwise vs. Control with Binary Data Using 
Discrete Bonferroni */

data HistVsCurr; set Toxicity(where=(Group in ('Hist','Curr')));
   HistVsCurr = Outcome;  DummyGroup = (Group='Hist');
data Low_VsCurr; set Toxicity(where=(Group in ('Low', 'Curr')));
   Low_VsCurr = Outcome;  DummyGroup = (Group='Low');
data HighVsCurr; set Toxicity(where=(Group in ('High','Curr')));
   HighVsCurr = Outcome;  DummyGroup = (Group='High');
data TrickToxicity; set HistVsCurr Low_VsCurr HighVsCurr;
   run;

proc multtest data=TrickToxicity stepbon;
   title "Complete Null";
   class DummyGroup;
   freq Freq;
   test ca(HistVsCurr Low_VsCurr HighVsCurr/lower permutation=20);
   contrast "PairTest" 1 -1;
   ods select pValues;
run;

proc multtest data=TrickToxicity stepbon;
   title "HistVsCurrLow";
   class DummyGroup;
   freq Freq;
   test ca(HistVsCurr Low_VsCurr/lower permutation=20);
   contrast "PairTest" 1 -1;
   ods select pValues;
run;

proc multtest data=TrickToxicity stepbon;
   title "HistVsCurrHigh";
   class DummyGroup;
   freq Freq;
   test ca(HistVsCurr HighVsCurr/lower permutation=20);
   contrast "PairTest" 1 -1;
   ods select pValues;
run;

proc multtest data=TrickToxicity stepbon;
   title "CurrLowHigh ";
   class DummyGroup;
   freq Freq;
   test ca(Low_VsCurr HighVsCurr/lower permutation=20);
   contrast "PairTest" 1 -1;
   ods select pValues;
run;


/* Program 12.10: Improving the Power of Binary Tests */

data fungal;
   input ep1 ep2 ep3 treat1 treat2;
datalines;
 1      0      0        1         2
 0      1      0        1         2
 0      0      1        0         2
 1      1      0        0         0
 1      0      1        1         2
 0      1      1        0         1
 1      1      1        57       61
 0      0      0        10        0
 ;

data par; 
   nep=3; 
   nt=2; 
run;
%romex(2, fungal, par);


/* Program 12.11: Joint Test of Endpoint 1 and Endpoint 3 */

proc sort data=fungal out=fungal;
   by ep1 ep3;
proc summary data=fungal;
   by ep1 ep3;
   var treat1 treat2;
   output out=fungal13 sum=treat1 treat2;
run;

data par; nep=2; nt=2; run;
%romex(2, fungal13, par);


/* Program 12.12: Monte Carlo Calculation of P(H0) */

data par; nep=3; nt=2;
data mcn; n_sample=1000; seed=1235;
run;
%rommc(2, fungal, par, mcn);


/* Program 12.13: Analysis of Fungal Data using PROC MULTTEST */

data fungal_mult; set fungal;
   Freq = treat1; Treatment = 1; if (Freq) then output;
   Freq = treat2; Treatment = 2; if (Freq) then output;
run;

proc multtest data=fungal_mult stepperm n=100000 seed=121211;
   class Treatment;
   freq Freq;
   test fisher(ep1-ep3/upper);
   contrast "New-Old" -1 1;
   ods select pValues;
run;


/* Program 12.14:  Comparing Multiple Contrasts for Multiple Binary Variables */

data Doctors;
   keep Doctor HDeath MI_EKG RFB Infect Neuro Pulm RenFail;
   array AE{7} HDeath MI_EKG RFB Infect Neuro Pulm RenFail;
   input Doctor nTotal nNone @@;
   do i = 1 to dim(AE); AE{i} = 0; end;
   do iobs = 1 to nNone; output; end;
   do iobs = 1 to nTotal-nNone;
      input nAE @@;
      do i = 1 to dim(AE); AE{i} = 0; end;
      do i = 1 to nAE; input iAE @@; AE{iAE} = 1; end;
      output;
      end;
   datalines;
1 38 32   1 7   1 2   2 2 6   1 1     1 1       3 1 5 6   
2 26 20   1 6   1 6   1 6     2 3 6   3 2 5 6   2 2 3   
3 36 32   1 3   1 3   1 3     1 2                       
4 52 45   1 7   1 5   1 2     2 2 5   2 1 3     2 1 2
          5 1 2 3 4 7
5 43 36   1 7   1 5   1 5     1 5     1 2       1 2
          1 2
6 30 26   1 6   1 6   1 4     1 1                       
;

proc multtest data=Doctors stepbon stepperm seed=121211 n=50000;
   class Doctor;
   test ca(HDeath MI_EKG RFB Infect Neuro Pulm RenFail/lower permutation=50);
   contrast "1 vs rest" -5  1  1  1  1  1 ;
   contrast "2 vs rest"  1 -5  1  1  1  1 ;
   contrast "3 vs rest"  1  1 -5  1  1  1 ;
   contrast "4 vs rest"  1  1  1 -5  1  1 ;
   contrast "5 vs rest"  1  1  1  1 -5  1 ;
   contrast "6 vs rest"  1  1  1  1  1 -5 ;
   ods output pValues=pValues;
proc sort data=pValues out=pValsort;
   by raw;
data top5;
   set pValsort;
   if _n_ <= 5;
proc print noobs data=top5;
run;


/* Program 12.15: Multiple Peto Mortality-Prevalence Carcinogenicity Tests, Using Discrete Distributions and Discrete Bonferroni Multiplicity Adjustments */

data Carcenogenicity;
   keep TGroup Day Tumor1-Tumor44;
   array Tumor{44};
   input TGroup nTotal @@;
   do iobs = 1 to nTotal;
      input Day nTumor @@;
      do i = 1 to dim(Tumor); Tumor{i} = 0; end;
      do i = 1 to nTumor; 
         input iTumor Tumori @@;
         Tumor{iTumor} = Tumori;
         end;
      output;
      end;
   datalines;
1 60
729 0                    729 1 7 1                    564 0
675 1 10 1               598 1 22 2                   613 2 5 1  10 1
729 1 21 1               729 2 1 1  36 1              505 1 5 2
689 1 44 2               704 0                        682 1 5 2
697 2 10 1  34 1         729 1 10 1                   556 0
729 2 10 1  14 1         617 0                        661 1 5 1
112 1 42 2               729 2 10 1  27 1             729 1 10 1
729 3 10 1  20 1  25 1   465 0                        729 1 25 1
729 0                    588 0                        729 1 5 1
595 0                    532 2 10 1  38 1             620 1 5 2
680 1 5 2                561 0                        578 2 6 1  10 1
682 2 5 1  8 2           729 0                        713 1 10 1
729 1 5 1                541 1 5 1                    689 1 32 1
729 1 6 1                729 1 10 1                   638 0
693 1 9 1                729 1 26 1                   729 2 15 1  21 1
729 1 42 1               729 1 33 1                   729 0
602 3 10 1  14 1  42 2   556 3 5 1  10 1  11 2        576 0
729 0                    623 0                        729 1 1 1
639 1 10 1               638 0                        729 2 10 1  34 1
729 0                    729 1 6 1                    575 0
2 60
732 1 10 1               415 0                        732 1 10 1
732 0                    576 0                        581 1 5 2
634 2 5 1  10 1          595 0                        667 1 5 1
618 3 1 1  10 1  42 2    732 1 10 1                   586 0
640 1 9 1                493 0                        426 1 5 2
419 1 10 1               658 1 10 1                   661 1 10 1
689 1 19 2               643 0                        697 0
648 1 10 1               706 0                        566 0
732 1 6 1                451 1 27 1                   568 1 42 2
686 3 5 1  18 2  31 1    508 1 10 1                   732 0
508 0                    662 0                        732 0
217 1 12 2               732 2 5 1  10 1              485 0
644 1 10 1               732 2 5 1  10 1              683 1 6 1
678 1 10 1               732 4 1 1  5 1  9 1  10 1    556 2 5 2  10 1
732 1 13 1               732 1 6 1                    581 0
536 0                    732 1 10 1                   732 1 6 1
544 0                    591 1 5 2                    615 0
290 1 42 2               732 1 10 1                   732 1 9 1
732 1 1 1                446 2 1 1  10 1              473 0
667 1 10 1               531 0                        683 3 5 1  10 1  27 1
3 60
562 2 5 1  10 1          590 0                        514 1 5 2
543 0                    543 1 10 1                   731 0
641 2 10 1  28 1         731 2 5 1  29 1              588 0
580 0                    645 2 10 1  40 2             633 1 10 1
674 0                    718 2 2 1  5 1               578 2 4 2  25 1
644 3 5 2  10 1  31 1    679 0                        596 1 5 2
702 1 5 1                731 2 10 1  25 1             651 0
402 0                    569 1 10 1                   600 1 10 1
711 0                    702 1 10 1                   731 0
731 2 3 1  10 1          599 0                        576 1 10 1
470 0                    729 1 10 1                   548 1 9 1
729 1 10 1               710 2 5 1  42 2              613 1 43 2
731 1 10 1               616 0                        731 2 10 1  25 1
724 1 10 1               570 1 39 1                   731 1 5 1
731 2 1 1  41 1          708 2 5 1  10 1              534 1 10 1
497 0                    718 0                        652 2 10 1  30 1
727 1 5 2                573 0                        663 0
731 0                    510 1 10 1                   579 1 10 1
686 1 5 1                693 1 10 1                   731 2 10 1  24 1
731 0                    731 0                        573 0
4 60
700 3 1 1  10 1  11 2    475 0                        566 1 10 1
617 2 10 1  37 1         476 0                        542 1 10 1
581 0                    655 0                        446 2 10 1  35 1
547 2 5 1  10 1          719 2 10 1  36 1             678 1 10 1
603 2 5 1  10 1          683 1 8 1                    543 1 10 1
730 2 1 1  10 1          624 1 10 1                   449 1 10 1
639 0                    475 0                        609 1 10 1
511 0                    696 1 10 1                   556 1 10 1
620 1 5 2                392 1 10 1                   661 1 32 1
676 1 10 1               556 1 16 1                   605 0
496 0                    532 1 5 2                    505 0
482 0                    591 0                        556 1 10 1
730 1 10 1               635 0                        669 0
730 2 10 1  42 1         568 1 10 1                   702 1 17 2
618 0                    630 3 10 1  14 1  23 1       730 2 6 1  10 1
730 0                    519 0                        382 0
633 1 10 1               451 0                        576 0
549 1 10 1               610 1 23 2                   654 1 10 1
524 2 10 1  42 2         669 2 5 1  10 1              593 1 10 1
730 0                    659 2 1 1  10 1               24 0
;

data Carcenogenicity; set Carcenogenicity;
   select;
      when (Day <= 365) Stratum = 1;
      when (Day <= 455) Stratum = 2;
      when (Day <= 546) Stratum = 3;
      when (Day <= 637) Stratum = 4;
      when (Day <= 730) Stratum = 5;
      otherwise         Stratum = 6;
      end;
run;

ods listing close;
proc multtest data=Carcenogenicity stepbon;
   class TGroup;
   strata Stratum;
   test peto(Tumor1-Tumor44/upper time=day permutation=10 continuity=.5);
   contrast "Dose trend" 0 1 2 3;
   ods output pValues = pValues;
run;
ods listing;

proc sort data=pValues out=pvalsort; by raw;
data top5; set pvalsort; if _n_ <= 5;
proc print data=top5 noobs;
   run;


/* Program 12.16: Multiple Binary Comparisons Using 
Freeman-Tukey Tests */

proc multtest data=Toxicity order=data stepboot seed=121211;
   class Group;
   freq Freq;
   test ft(Outcome/lower);
   contrast "Hist vs Curr" -1  1  0  0 ;
   contrast "Low  vs Curr"  0  1 -1  0 ;
   contrast "High vs Curr"  0  1  0 -1 ;
run;


/* Program 12.17:  Mixing Continuous and Discrete Variables */

data Adverse; set Adverse;
   TotalAdverse = sum(of AE1-AE27);
proc multtest data=Adverse stepperm seed=121211;
   class Group;
   test mean  (TotalAdverse/upper)
        fisher(ae1-ae28    /upper);
   contrast "Treatment-Control" -1 1;
   ods output pValues=pValues;
run;

proc sort data=pValues out=pValues; by raw;
data Top5; set pValues; if _n_ <= 5;
proc print noobs data=Top5;
run;


/* Program 12.18:  Corresponding PROC MULTTEST and PROC LIFETEST */

title1 'Lifetimes of Rats';

data DMBA_LIFETEST;
   input Group Days @@;
   Censored = (Days < 0);
   Days = abs(Days);
datalines;
1 143  1 164  1 188  1 188  1 190  1 192  1 206
1 209  1 213  1 216  1 220  1 227  1 230  1 234
1 246  1 265  1 304  1 -216  1 -244
2 142  2 156  2 163  2 198  2 205  2 232  2 232
2 233  2 233  2 233  2 233  2 239  2 240  2 261
2 280  2 280  2 296  2 296  2 323  2 -204  2 -344
;

proc lifetest data=DMBA_LIFETEST;
   title2 "Comparisons of Survival Curves via the LIFETEST Procedure";
   time Days*Censored(1);
   strata Group;
   ods select HomTests;
run;


title2 'Logrank Test via the MULTTEST Procedure';
data DMBA_MULTTEST; set DMBA_LIFETEST;
   t = 2*(1-Censored);
run;

proc multtest data=DMBA_MULTTEST;
   title3 "Asymptotic Analysis";
   class Group;
   test peto(t/time=Days);
   ods select pValues;
run;
proc multtest data=DMBA_MULTTEST;
   title3 "Permutation Analysis";
   class Group;
   test peto(t/time=Days permutation=10);
   ods select pValues;
run;


/* Program 13.1 Bayesian Sample for an Incomplete Block Design */


data detergent;
   do detergent=1 to 5;
      do block =1 to 10;
         input plates @@;
         output;
      end;
   end;
   datalines;
27 28 30 31 29 30  .  .  .  .
26 26 29  .  . .  30 21 26  .
30  .  . 34 32 .  34 31  . 33
 . 29  . 33  . 34 31  . 33 31
 .  . 26  . 24 25  . 23 24 26
run;

proc mixed data=detergent;
   class block detergent;
   model plates = detergent;
   random block;
   lsmeans detergent / cl adjust=simulate(seed=121211);
   prior / out=sample seed=1283470 nsample=10000;   
run;


/* Program 13.2: Calculating Average Differences in Losses */

%let k = 100;
data s;
   set sample;
   array lsm[5] lsm1-lsm5;
   array Loss[5,5] Loss1-Loss25;
   do i = 1 to 5;
      do j = 1 to 5; 
         delta = lsm[i] - lsm[j];
         if (delta > 0) then Loss[i,j] =    delta;
         else                Loss[i,j] = &k*delta;
      end;
   end;
run;

proc means data=s mean noprint;
   var Loss1-Loss25;
   output out=o mean=mean1-mean25;
run;

data o1;
   set o;
   array mean[5,5] mean1-mean25;
   do i = 1 to 5;
      do j = 1 to 5; 
         if (i ne j) then do;
            LossDiff = mean[i,j];
            output;
         end;
      end;
   end;
   keep i j LossDiff;
proc print noobs;
run;


/* Program 13.3: Probabilities of Meaningful Differences */

data s1; set sample;
   array lsm[5];
   array M[5,5];
   do i=1 to 4; do j=i+1 to 5;
      M[i,j] = (abs(lsm[i] - lsm[j]) > 2);
      end; end;
proc summary data=s1;
   var M:;
   output out=s2(where=(_STAT_='MEAN'));
proc iml;
   use s2; read all var ("M1":"M25") into M;
   title "Probabilities of Meaningful Differences";
   print (shape(M,5,5)) [rowname=("1":"5") colname=("1":"5")];


/* Program 13.4: Multiple Bayes Tests of Point Null Hypotheses */

data MultipleEndpoints;
   Treatment = 'Placebo';
   do Subject = 1 to 54;
      input Endpoint1-Endpoint4 @@;
      output; 
   end;
   Treatment = 'Drug';
   do Subject = 54+1 to 54+57;
      input Endpoint1-Endpoint4 @@;
      output; 
   end;
datalines;
4 3 3 5  5 0 1 7  1 0 1 9  4 0 3 5  3 0 2 9  4 1 2 6  2 0 4 6
2 2 5 5  3 0 1 7  2 0 1 9  4 6 5 5  2 0 2 8  2 7 1 7  1 2 2 9
4 0 3 7  3 0 1 6  3 0 1 6  4 1 4 6  6 0 4 7  3 0 1 8  3 0 1 9
2 1 2 7  6 2 3 5  3 0 4 7  3 0 1 9  2 0 1 9  6 9 6 3  4 9 2 6
2 0 1 7  1 0 1 9  4 0 4 7  3 1 4 6  3 0 3 7  1 0 1 8  6 7 5 4
4 6 2 5  6 19 7 5 6 3 6 6  3 0 5 6  2 4 2 8  1 0 1 8  4 21 5 5
2 0 2 9  4 7 3 5  3 1 2 8  3 3 3 8  4 3 4 6  1 0 1 10 1 0 2 9
3 0 4 5  3 1 1 6  3 4 4 6  5 8 5 5  5 1 5 4  1 0 4 8  1 0 1 10
1 0 1 9  2 1 2 7  4 1 2 5  5 0 5 6  1 4 5 6  5 6 4 6  2 0 2 9
2 2 2 5  1 0 1 10 3 2 3 6  5 4 6 6  2 1 2 8  2 1 2 6  2 1 1 8
3 0 3 9  3 1 2 6  1 0 2 9  1 0 1 9  3 0 3 9  1 0 1 10 1 0 1 9
1 0 1 10 2 0 4 7  5 1 2 6  4 0 5 7  4 0 4 6  2 1 3 6  2 1 1 6
4 0 4 6  1 0 1 8  1 0 2 9  4 1 3 6  4 3 4 5  4 2 5 5  1 0 1 10
3 0 2 8  4 2 2 8  3 0 2 9  1 0 1 10 1 0 1 9  2 0 2 9  2 1 2 8
3 0 3 8  2 4 2 6  2 1 1 9  2 2 2 9  4 0 1 4  3 3 1 8  4 4 3 6
2 0 1 10 4 2 3 6  1 0 1 8  2 0 2 8  5 1 5 5  4 0 4 6
;

data multend1;
   set MultipleEndpoints;
   Endpoint4 = -Endpoint4;
run;

ods listing close;
proc glm data=multend1;
   class Treatment;
   model Endpoint1-Endpoint4 = Treatment;
   estimate "Treatment vs Control" Treatment -1 1;
   manova h=Treatment / printe;
   ods output Estimates  =Estimates 
              PartialCorr=PartialCorr;
run;
ods listing;

%macro Estimates;
   use Estimates;
   read all var {tValue}                  into EstPar;
   use PartialCorr;
   read all var ("Endpoint1":"Endpoint4") into cov;
%mend;

%BayesTests(rho=.5,Pi0  =.5);


/* Program 13.5: Evaluating Sensitivity to 
Priors-Recalibrating the Joint Prior */

%BayesTests(rho=.5,PiAll=.5);


/* Program 14.1:  Multiple Comparisons in Logistic Regression */

data uti;
   format diagnosis $13.;
   do Diagnosis = "complicated", "uncomplicated";
      do treatment = "A", "B", "C";
         input cured total @@;
         AminusC = (treatment="A");
         BminusC = (treatment="B");
         CompminusUnComp = (Diagnosis="complicated");
         output;
         end;
      end;
datalines;
78 106  101 112  68 114   40 45  54 59  34 40
;
proc logistic data=uti outest=stats covout;
   model cured/total = AminusC BminusC CompminusUnComp;
run;

%macro Contrasts;
   C = { 0  1  0  0 ,
         0  0  1  0 ,
         0  1 -1  0 ,
         0  0  0  1 };
    C = C`;
    Clab = {"trt(A-C)" ,
            "trt(B-C)" ,
            "trt(A-B)" ,
            "Diag(Comp-UnComp)" };
%mend;

%macro estimates;
   use stats(where=(_TYPE_='PARMS'));
   read all var {INTERCEPT  AminusC BminusC CompminusUnComp} into EstPar;
   EstPar = EstPar`;
   use stats (where=(_TYPE_='COV'));
   read all var {INTERCEPT AminusC BminusC CompminusUnComp} into Cov;
   df = 0;
%mend;

%SimIntervals(seed=121211, nsamp=100000);


/* Program 14.2: MCB Analysis of Water Filters */

data Filter;
   do Brand = 1 to 7;
      do i = 1 to 3;
         input NColony @@;
         output;
         end;
      end;
   cards;
 69 122  95
118 154 102
171 132 182
122 119   .
204 225 190
140 130 127
170 165   .
;

%MCB(Filter,NColony,Brand);


/* Program 14.3:  Finding the Most Significant Linear Combination with Multivariate Data */

ods select Spouse_Question.Canonical.CanCoefficients;
proc glm data=husbwive;
   model HusbQ1-HusbQ4 WifeQ1-WifeQ4 = / nouni;
   repeated Spouse 2, Question 4 identity/canonical;
run;


/* Program 14.4:  Confidence Interval and Test for Most Significant Linear Combination */


data _null_;
   tcrit = sqrt(4*(30-1)*finv(1-0.05,4,30-4)/(30-4));
   alpha = 2*(1-probt(tcrit,29));
   call symput('alpha',alpha); run;
data one;
    set HusbWive;
    maxdiff =  -0.26708818*DiffQ1 + 0.63289897*DiffQ2
               +2.65384153*DiffQ3 - 1.77626607*DiffQ4;
proc means alpha=&alpha n mean lclm uclm prt;
   title "Interval and Test for max Diff, Alpha=&alpha";
   var maxdiff;
run;



/* Macros used in "Multiple Comparisons and Multiple Tests Ssing the SAS(R) System," */ 
/* by Westfall, Tobias, Rom, Wolfinger, and Hochberg, SAS Books By Users series. */



/* The %Rom macro */

/* This macro computes multiplicity adjustments usings Rom's (1990) method. */


/*---------------------------------------------------------------*/
/* Name:      Rom                                                */
/* Title:     Rom Step-Up procedure                              */
/* Author:    Dror Rom, rom@prosof.com                           */
/* Reference: Rom, D.M. (1990). A sequentially rejective test    */
/*              procedure based on a modified Bonferroni         */
/*              inequality. Biometrika, 77, 663--665.            */
/* Release:   Version 6.11                                       */
/*---------------------------------------------------------------*/
/* Input:                                                        */
/*                                                               */
/*   DATASET=   the SAS data set containing the data to be       */
/*              analyzed (required)                              */
/*                                                               */
/*   PV=        the p-values (required)                          */
/*                                                               */
/*   FWE=       the level of significance for comparisons        */
/*              among the means.  The default is 0.05.           */
/*                                                               */
/* Output:                                                       */
/*                                                               */
/*   The output dataset contains one observation for each        */
/*   P-value in the dataset.  The output dataset contains the    */
/*   following variables:                                        */
/*                                                               */
/*       i    - The index of the ordered P-value                 */
/*                                                               */
/*    CRIT    - The critical value                               */
/*                                                               */
/*  PVALUE    - The P-value                                      */
/*                                                               */
/*   ADJP     - The adjusted P-value                             */
/*                                                               */
/*    DEC     - The decision on the corresponding hypothesis     */ 
/*---------------------------------------------------------------*/

%MACRO ROM(dataset=,pv=,FWE=0.05);
data a;
set &dataset;
p=&pv;
keep p;
proc sort;
by descending p;
proc means noprint data=a;
var p;
output out=b n=N;
proc transpose data=a prefix=pv out=a;
data adjp;merge b a;
array critv{200};
array pv{200};
minim=1;
do z=1 to n;
w=0;
converge='false';
do while ((converge='false')or(w<=6));
  w=w+1;
  if (w=1) then do;
   if (z=1) then alpha=pv(z);
   else if (z=2) then alpha=2*pv(2);
   else alpha=(-1+(1+4*z*pv(z))**0.5)/2;
  end;
  else do;
  if abs(alpha-adjp)<=0.0001 then converge='true';
    alpha=adjp;
   end;
critv(2)=alpha;
critv(1)=alpha/2;
critv(n)=alpha;
critv(n-1)=alpha/2;
do i=3 to n;
 m=n-i+1;
 do j=1 to i-1;
  critv(i+1-j)=critv(i-j);
 end;
 critv(1)=0;
 do j=1 to i-2;
*** calculates n choose m *****;
 c=1;
 k=j;
 jj=i-j;
 do ii=1 to k;
  jj=jj+1;
  c=c*jj/ii;
 end;
 comb=c;
  critv(1)=critv(1)+critv(i)**j-comb*critv(i-j)**(i-j);
 end;
 critv(1)=(critv(1)+critv(i)**(i-1))/i;
end;
adjp=alpha*pv[z]/critv[n-z+1];
end;
minim=min(adjp,minim);
adjp=minim;
output;
end;
data adjp;set adjp;i=_N_;keep adjp i;
data critp;merge b a;
array critv{200};
alpha=&fwe;
critv(2)=alpha;
critv(1)=alpha/2;
critv(n)=alpha;
critv(n-1)=alpha/2;
do i=3 to n;
 m=n-i+1;
 do j=1 to i-1;
  critv(i+1-j)=critv(i-j);
 end;
 critv(1)=0;
 do j=1 to i-2;
*** calculates n choose m *****;
 c=1;
 k=j;
 jj=i-j;
 do ii=1 to k;
  jj=jj+1;
  c=c*jj/ii;
 end;
 comb=c;
  critv(1)=critv(1)+critv(i)**j-comb*critv(i-j)**(i-j);
 end;
 critv(1)=(critv(1)+critv(i)**(i-1))/i;
end;

data c;
merge a b critp;
array pv{200};
array critv{200};
alpha=&fwe;
dec='retain';
do i=1 to n;
crit=critv(n+1-i);
pvalue=pv(i);
if(pv(i)<=crit)then dec='reject';

output;
end;
run;
data c;set c;i=_N_;
title1 ' ';
TITLE2 'ROM STEP-UP PROCEDURE';
title3 ' ';
DATA _NULL_;
FILE PRINT;
merge c adjp END=EOF;by i;
IF _N_=1 THEN DO;
PUT @8 'I' @12 'CRITICAL VALUE' @30 'P-VALUE' @45 'ADJUSTED P'
@60 'DECISION';
PUT @5 65*'-';
END;
put @8 i @12 crit f7.6 @30 pvalue @45 adjp f7.6 @60 dec;
if EOF=1 then do;
PUT @5 65*'-';
put @8 'ALPHA=' @16 alpha;
end;
RUN;
%MEND ROM;



/* The %HochBen Macro                                            */
/*                                                               */
/* This macro performs multiplicity adjustments using Hochberg   */
/* and Benjamini's (1990) graphical method.                      */

/*---------------------------------------------------------------*/
/* Name:      HochBen                                            */
/* Title:     Hochberg and Benjamini graphical analysis of       */
/*            multiple P-values                                  */
/* Author:    Dror Rom, rom@prosof.com                           */
/* Reference: Hochberg, Y., and Benjamini, Y. (1990). More       */
/*              Powerful Procedures for Multiple Significance    */
/*              Testing. Statistics in Medicine, 9, 811-818.     */
/* Release:   Version 6.11                                       */
/*---------------------------------------------------------------*/
/* Input:                                                        */
/*                                                               */
/*   DATASET=   the SAS data set containing the data to be       */
/*              analyzed (required)                              */
/*                                                               */
/*   PV=        the p-values (required)                          */
/*                                                               */
/*   FWE=       the level of significance for comparisons        */
/*              among the means.  The default is 0.05.           */
/*                                                               */
/* Output:                                                       */
/*                                                               */
/*   The output dataset contains one observation for each        */
/*   P-value in the dataset.  The output dataset contains the    */
/*   following variables:                                        */
/*                                                               */
/*       i    - The index of the ordered P-value                 */
/*                                                               */
/*    CRIT    - The critical value                               */
/*                                                               */
/*  PVALUE    - The P-value                                      */
/*                                                               */
/*   ADJP     - The adjusted P-value                             */
/*                                                               */
/*    DEC     - The decision on the corresponding hypothesis     */ 
/*                                                               */
/*   NHAT     - The estimated number of true hypotheses          */
/*---------------------------------------------------------------*/

%MACRO HOCHBEN(dataset=,pv=,FWE=0.05);
data a;
set &dataset;
p=&pv;
q=1-p;
proc sort;
by q;
data b;
set a;
i=_N_;
slope=q/i;
nhat=1/slope-1;
title1 ' ';
title2 'HOCHBERG & BENJAMINI GRAPHICAL ANALYSIS OF MULTIPLE P-VALUES';
proc sort;
by p;
data c;
set b;
lags=lag1(slope);
data c;
set c;
diff=slope-lags;
if (diff='.') or(diff>=0) then diff='.';
else diff=0;
data d;
set c;
if (diff=0);
ii=1;
data d;
set d;
by diff;
if first.diff;
keep nhat q i ii;

data c1;set c;if(diff='.');
data c1;set c1;by diff;if last.diff;ii=1;
keep nhat q i ii;
run;
data d;set c1 d;by ii;if last.ii;
keep nhat q i;
data d1;
set d;
i=nhat+1;
q=1;
keep i q;
data d3;
set d;
i=nhat;
drop q;
do j=0,10;
qqq=j/10;
output;
end;
data d2;
q=0;
i=0;
data d1;
set d1 d2 d;
qq=q;
keep qq i;
data c;
set c;
drop nhat;
proc sort;
by i;
data e;
merge c d;
by i;
data f;
set e d1 d3;
symbol1 v=PLUS i=none;
symbol2 v=none i=join;
symbol3 v=none i=join;
title1 ' ';
title2 'HOCHBERG & BENJAMINI GRAPHICAL ANALYSIS OF MULTIPLE P-VALUES';
title3 'PLOT of 1-PVALUES VS. THEIR ORDER';
goptions colors=(black) cback=white;
label q='q';
proc gplot data=f;
plot q*i=1 qq*i=2 qqq*i=3/overlay frame;
run;
data a;set a;keep p;
proc sort;
by p;
proc means noprint;
var p;
output out=b n=N;
data b;set b;
data c1;set f;
nhat=round(nhat);
if not(nhat='.');
data c2;merge b c1;if not(n='.');
alpha=&fwe;
keep n alpha nhat;
proc transpose data=a prefix=pv out=a;
run;
data c;
merge a c2;
data c;set c;
array pv{200};
dec='reject';

do i=1 to n;
crit1=alpha/(n+1-i);
if (nhat=0)then crit2=alpha;
                  else crit2=alpha/nhat;
crit=max(crit1,crit2);
if(nhat<1)then adjp=pv(i);
 else adjp=max(min((n+1-i)*pv(i),nhat*pv(i),1),adjp);
pvalue=pv(i);
if((pv(i)<=crit)
    and(dec='reject'))then dec='reject';
else dec='retain';
output;
end;
run;
title1 ' ';
title2 'HOCHBERG & BENJAMINI GRAPHICAL ANALYSIS OF MULTIPLE P-VALUES';
title3 ' ';
title4 'CRITICAL VALUES ADJUSTED BY ESTIMATED NUMBER OF TRUE HYPOTHESES';
title5 ' ';
DATA _NULL_;
FILE PRINT;
SET c END=EOF;
I=_N_;
IF _N_=1 THEN DO;
PUT @8 'I' @12 'CRITICAL VALUE' @30 'P-VALUE' @45 'ADJUSTED P'
@60 'DECISION';
PUT @5 65*'-';
END;
put @8 i @12 crit f7.6 @30 pvalue @45 adjp f7.6 @60 dec;
if EOF=1 then do;
PUT @5 65*'-';
put @8 'ALPHA=' @16 alpha;
put @8 'ESTIMATED NUMBER OF TRUE HYPOTHESES:' @56 nhat;
end;
RUN;
%MEND HOCHBEN;



/* The %SimIntervals Macro */

/* This macro computes simultaneous confidence intervals for a general */
/* collection of linear functions of parameters, using Edwards and Berry */
/* (1987). */


/*--------------------------------------------------------------*/
/* Name:      SimIntervals                                      */
/* Title:     Simultaneous Confidence Intervals for General     */
/*            Linear Functions                                  */
/* Author:    Randy Tobias, sasrdt@sas.com,                     */
/* Reference: Edwards and Berry (1987). The efficiency of       */
/*            simulation-based multiple comparisons.            */
/*            Biometrics 43, 913-928.                           */
/* Release:   Version 7.01                                      */
/*--------------------------------------------------------------*/
/* Inputs:                                                      */
/*                                                              */
/*      NSAMP =  simulation size, with 20000 as default         */
/*                                                              */
/*      SEED  =  random number seed, with 0 (clock time)        */
/*               as default                                     */
/*                                                              */
/*      CONF  =  desired confidence level, with 0.95 as default */
/*                                                              */
/*      SIDE  = U, L or B, for upper-tailed, lower-tailed       */
/*              or two-tailed, respectively. SIDE=B is default. */
/*                                                              */
/*  Additionally, %SimIntervals requires two further macros to  */
/*  be defined that use SAS/IML to construct the estimates and  */
/*  the contrasts of interest.  In particular, make sure the    */
/*  following two macros are defined before invoking            */
/*  %SimIntervals:                                              */
/*                                                              */
/*     %Estimate: Uses SAS/IML code to define                   */
/*        EstPar - (column) vector of estimated parameters      */
/*        Cov    - covariance matrix for the for the estimates  */
/*        df     - error degrees of freedom; set to 0 for       */
/*                 asymptotic analysis                          */
/*                                                              */
/*     %Contrasts: Uses SAS/IML code to define                  */
/*        C      - matrix whose columns define the contrasts of */
/*                 interest between the parameters              */
/*        CLab   - (column) character vector whose elements     */
/*                 label the respective contrasts in C          */
/*                                                              */
/*  You can either define these macros directly, or use the     */
/*  %MakeGLMStats macro to define them.                         */
/*                                                              */
/*--------------------------------------------------------------*/
/* Output:                                                      */
/*   The output is a dataset with one observation for each      */
/*   contrast and the following variables:                      */
/*                                                              */
/*     Contrast - contrast label                                */
/*     Estimate - contrast estimated value                      */
/*     StdErr   - standard error of estimate                    */
/*     tValue   - normalized estimate, Estimate/StdErr          */
/*     RawP     - non-multiplicity-adjusted p-value             */
/*     OneP     - one-step multiplicity-adjusted p-value        */
/*     LowerCL  - multiplicity-adjusted lower confidence limit  */
/*     UpperCL  - multiplicity-adjusted upper confidence limit  */
/*                                                              */
/*   This dataset is also displayed as a formatted table, using */
/*   the ODS system.                                            */
/*--------------------------------------------------------------*/

%macro SimIntervals(nsamp   = 20000,
                    seed    =     0,
                    conf    =  0.95,
                    side    =     B,
                    options =      );
%global ANORM quant;

options nonotes;

proc iml;
   %Estimates;
   if (df <= 0) then call symput('ANORM','1');
   else              call symput('ANORM','0');
   %Contrasts;

   Cov = C`*Cov*C;
   D   = diag(1/sqrt(vecdiag(Cov)));
   R   = D*Cov*D;

   evec = eigvec(R);
   eval = eigval(R) <> 0;
   U = (diag(sqrt(eval))*evec`)`;
   dimU = sum(eval > 1e-8);

   U    = U[,1:dimU];

   ests = C`*EstPar;
   ses  = sqrt(vecdiag(Cov));
   tvals = ests/ses;
   %if       (&side = B) %then %do;
      if df>0 then rawp = 2*(1-probt(abs(tvals),df));
         else rawp = 2*(1-probnorm(abs(tvals)));
      %end;
   %else %if (&side = L) %then %do;
      if df>0 then rawp =      probt(    tvals ,df) ;
      else rawp = probnorm( tvals);
      %end;
   %else                       %do;
      if df>0 then rawp =    1-probt(    tvals ,df) ;
      else rawp = 1-probnorm(tvals);
      %end;

   adjp = j(ncol(C),1,0);
   maxt=j(&nsamp,1,0);
   do isim = 1 to &nsamp;
      Z = U*rannor(j(dimU,1,&seed));
      if df>0 then do;
         V = cinv(ranuni(&seed),df);
         tvalstar = Z / sqrt(V/df);
         end;
      else do; tvalstar = Z; end;
      %if (&side = B) %then %do; mx = max(abs(tvalstar)); %end;
      %else                 %do; mx = max(    tvalstar ); %end;
      maxt[isim] = mx;

      %if       (&side = B) %then %do; adjp = adjp + (mx>abs(tvals)); %end;
      %else %if (&side = L) %then %do; adjp = adjp + (mx>   -tvals ); %end;
      %else                       %do; adjp = adjp + (mx>    tvals ); %end;
      end;
   adjp = adjp/&nsamp;

   confindx = round(&nsamp*&conf,1);
   sorttemp = maxt;
   maxt[rank(maxt),] = sorttemp;
   c_alpha = maxt[confindx];

   start tlc(n,d); return(trim(left(char(n,d)))); finish;

   %if (&side = B) %then %do;
      LowerCL = ests - c_alpha*ses;
      UpperCL = ests + c_alpha*ses;
      %end;
   %else %if (&side = L) %then %do;
      LowerCL = j(ncol(C),1,.M);
      UpperCL = ests + c_alpha*ses;
      %end;
   %else %do;
      LowerCL = ests - c_alpha*ses;
      UpperCL = j(ncol(C),1,.I);
      %end;

   create SimIntOut
      var {"Estimate" "StdErr" "tValue" "RawP"
           "OneP" "LowerCL" "UpperCL"};
   data = ests || ses || tvals || rawp || adjp || LowerCL || UpperCL;
   append from data;
   call symput('confpct',tlc(100*&conf,4));
   call symput('quant'  ,tlc(c_alpha  ,8));

   create labels from clab; append from clab;

data SimIntOut; merge labels(rename=(COL1=Contrast)) SimIntOut; run;

%if (^%index(%upcase(&options),NOPRINT)) %then %do;

proc template;
delete MCBook.SimIntervals;
define table MCBook.SimIntervals;
   column Contrast Estimate StdErr tValue RawP OneP LowerCL UpperCL;

   define header h1;
      text "Estimated &confpct% Quantile = &quant";
      spill_margin;
%if (^&ANORM) %then %do;
      space=1;
%end;
      end;

%if (&ANORM) %then %do;
   define header h2;
      text "Asymptotic Normal Approximations";
      space=1;
      end;
%end;

   define column Contrast;
      header="Contrast";
      end;
   define column Estimate;
      header="Estimate"       format=D8. space=1;
      translate _val_ = ._ into '';
      end;
   define column StdErr;
      header="Standard Error" format=D8. space=1;
      translate _val_ = ._ into '';
      end;
   define column tValue;
      header="#t Value"       format=7.2;
      translate _val_ = .I into '  Infty',
         _val_ = .M into ' -Infty',
         _val_ = ._ into '';
      end;

   %if (&side = B) %then %do;
      define header ProbtHead;
         text " Pr > |t| ";
         start=RawP end=OneP just=c expand='-';
         end;
      %end;
   %else %if (&side = L) %then %do;
      define header ProbtHead;
         text " Pr < t ";
         start=RawP end=OneP just=c expand='-';
         end;
      %end;
   %else %do;
      define header ProbtHead;
         text " Pr > t ";
         start=RawP end=OneP just=c expand='-';
         end;
      %end;

   define column RawP;
      space=1 glue=10
      parent=Common.PValue header="Raw";
      translate _val_ = ._ into '';
      end;
   define column OneP;
      parent=Common.PValue header="Adjusted";
      translate _val_ = ._ into '';
      end;

   define header CLHead;
      text "&confpct% Confidence Interval";
      start=LowerCL end=UpperCL just=c;
      end;
   define LowerCL;
      translate _val_ = .M into '  -Infty';
      space=1 glue=10 format=D8. print_headers=off;
      end;
   define UpperCL;
      format=D8. print_headers=off;
      translate _val_ = .I into '   Infty';
      end;

   end;
run;

data _null_; set SimIntOut;
   file print ods=(template='MCBook.SimIntervals');
   put _ods_;
   run;

%end;

options notes;

%mend;



/* The %MakeGLMStats Macro */

/* This macro creates the %Estimates and %Contrasts */
/* macros that are needed for %SimIntervals and %SimTests. */


/*--------------------------------------------------------------*/
/* Name:      MakeGLMStats                                      */
/* Title:     Macro to create %Estimates and %Contrasts macros  */
/*            needed for %SimIntervals and %SimTests            */
/* Author:    Randy Tobias, sasrdt@sas.com                      */
/* Release:   Version 7.01                                      */
/*--------------------------------------------------------------*/
/* Inputs:                                                      */
/*                                                              */
/*    DATASET = Data set to be analyzed (required)              */
/*                                                              */
/*   CLASSVAR = Listing of classification variables. If absent, */
/*              no classification variables are assumed         */
/*                                                              */
/*      YVAR  = response variable (required)                    */
/*                                                              */
/*     MODEL  = GLM model specification (required)              */
/*                                                              */
/*  CONTRASTS = CONTROL(effect), ALL(effect), or USER. This     */
/*              creates the %Contrasts macro unless you specify */
/*              USER (the default), in which case you create    */
/*              the %Contrasts macro yourself                   */
/*                                                              */
/*--------------------------------------------------------------*/
/* Output:  This macro creates the %Estimates macro needed for  */
/* the %SimIntervals and %SimTests macros.  Additionally, if    */
/* you specify CONTRASTS = ALL or CONTROL, it also creates the  */
/* %Contrasts macro.  There is no other output.                 */
/*--------------------------------------------------------------*/

%macro MakeGLMStats(dataset= , classvar= , yvar= , model= , contrasts=USER);
   %global nx yvar1 nlev icntl;

   options nonotes;

   %let yvar1 = &yvar;
   proc glmmod data=&dataset noprint outparm=parm outdesign=design;
      %if (%length(&classvar)) %then %do;
      class &classvar;
      %end;
      model &yvar = &model;
   data _null_; set parm; call symput('nx',_n_);
      run;

   %macro Estimates;
      use design;
      read all var ("col1":"col&nx") into X;
      read all var ("&yvar1")        into Y;
      XpXi   = ginv(X`*X);
      rankX  = trace(XpXi*(X`*X));
      n      = nrow(X);
      df     = n-rankX;
      EstPar = XpXi*X`*Y;
      mse    = ssq(Y-X*EstPar)/df;
      Cov    = mse*XpXi;
   %mend;

   %let ctype = %upcase(%scan(&contrasts,1));
   %if (&ctype ^= USER) %then %do;
      %let effect = %scan(&contrasts,2);
      %if (&ctype = CONTROL) %then %do;
         %let icntl = %scan(&contrasts,3);
         %end;
      %end;

   %if (&ctype ^= USER) %then %do;
      ods listing close;
      ods output LSMeanCoef=LSMeanCoef;
      proc glm data=&dataset;
         %if (%length(&classvar)) %then %do;
          class &classvar;
          %end;
          model &yvar = &model;
          lsmeans &effect / e;
      quit;
      ods listing;
      proc transpose data=LSMeanCoef out=temp;
         var Row:;
      data _null_; set temp;
         call symput('nlev',_n_);
      run;
      %end;

   %if (&ctype = ALL) %then %do;
      %macro Contrasts; %global nlev;
         use LSMeanCoef; read all var ("Row1":"Row&nlev") into L;
         free C clab;
         do i = 1 to ncol(L)-1;
            do j = i+1 to ncol(L);
               C    = C    // L[,i]` - L[,j]`;
               clab = clab // (     trim(left(char(i,5)))
                               +'-'+trim(left(char(j,5))));
               end;
            end;
         C = C`;
         %mend;
      %end;
   %if (&ctype = CONTROL) %then %do;
      %macro Contrasts; %global icntl;
         use LSMeanCoef; read all var ("Row1":"Row&nlev") into L;
         free C clab;
         j = &icntl;
         do i = 1 to ncol(L);
            if (i ^= j) then do;
               C    = C    // L[,i]` - L[,j]`;
               clab = clab // (     trim(left(char(i,5)))
                               +'-'+trim(left(char(j,5))));
               end;
            end;
         C = C`;
         %mend;
      %end;
   options notes;
%mend;


/* The %IndividualPower Macro */

/* This macro computes power for various multiple comparisons tests */
/* using the ``Individual Power" definition. */


/*--------------------------------------------------------------*/
/* Name:      IndividualPower                                   */
/* Title:     Macro to evaluate individual power of multiple    */
/*            comparisons                                       */
/* Author:    Randy Tobias, sasrdt@sas.com                      */
/* Release:   Version 7.01                                      */
/*--------------------------------------------------------------*/
/* Inputs:                                                      */
/*                                                              */
/*        MCP = RANGE, DUNNETT2, DUNNETT1, or MAXMOD (required) */
/*                                                              */
/*          G = Number of groups (excluding control for         */
/*              DUNNETT2 and DUNNETT1; required)                */
/*                                                              */
/*          D = Meaningful mean difference (required)           */
/*                                                              */
/*          S = Standard deviation (required)                   */
/*                                                              */
/*        FWE = Desired Familywise Error (0.05 default)         */
/*                                                              */
/*     TARGET = Target power level (0.80 default)               */
/*                                                              */
/*--------------------------------------------------------------*/
/* Output:  This macro plots individual power for a variety of  */
/* Multiple comparisons methods, and plots it as a function of  */
/* n, the within-group sample size                              */
/*--------------------------------------------------------------*/

%macro IndividualPower(mcp=,g=,d=,s=,FWE=0.05,target=0.80);
%let mcp = %upcase(&mcp);
options nonotes;
data power;
   keep C_a N NCP DF Power;
   label N="Group size, N";

   ntarget = 1;
   nactual = .;
   dtarget = 1000;

   do N=2 to 1000 until (Power>.99);
      %if (&mcp = MAXMOD) %then %do; ncp = sqrt(N  )*(&d/&s); %end;
      %else                     %do; ncp = sqrt(N/2)*(&d/&s); %end;

      %if (   (&mcp = DUNNETT1)
           or (&mcp = DUNNETT2)) %then %do; df = (&g+1)*(N-1); %end;
      %else                            %do; df = (&g  )*(N-1); %end;

      conf = 1-&fwe;

      %if (&mcp = RANGE) %then %do;
         c_a = probmc("&mcp",.,conf,df,&g)/sqrt(2);
         %end;
      %else %do;
         c_a = probmc("&mcp",.,conf,df,&g);
         %end;

      %if (&mcp = DUNNETT1) %then %do;
         Power = 1-probt(c_a     ,df,ncp   );
         %end;
      %else %do;
         Power = 1-probf(c_a**2,1,df,ncp**2);
         %end;

      if (abs(Power - &target) < dtarget) then do;
         ntarget = N;
         nactual = Power;
         dtarget = abs(Power - &target);
         end;
      output;
   end;
   call symput('ntarget',trim(left(ntarget)));
   call symput('nactual',trim(left(nactual)));
run;


data target;
   length xsys ysys position $ 1;
   retain xsys ysys hsys color;
   xsys = '2'; ysys = '2'; color = 'black';
   x = 0       ; y = &nactual; function = 'MOVE ';                 output;
   x = &ntarget; y = &nactual; function = 'DRAW '; line=1; size=1; output;
   x = &ntarget; y = 0;        function = 'DRAW '; line=1; size=1; output;
   x = &ntarget+2; y = &nactual/2; function = 'LABEL';
   style = 'swissb';
   text  = "Power(N=&ntarget)";
   position = '0';
   output;
   x = &ntarget+2; y = &nactual/2-0.12; function = 'LABEL';
   style = 'swissb';
   text  = "  = "||put(&nactual,pvalue6.);
   position = '0';
   output;

goptions ftext=swissb vsize=6 in hsize=6 in;
axis1 style=1 width=2 minor=none order=0 to 1 by 0.2;
axis2 style=1 width=2 minor=none;
symbol1 i=join;
proc gplot data=power annotate=target;
   title2 "Power for detecting an individual difference of &d";
   title3 "Using the &mcp method with FWE=&FWE";
   title4 "With &g groups and standard deviation = &s";
   plot power*n=1 / vaxis=axis1 haxis=axis2 frame;
run;
quit;
title2;
title3;
title4;
options notes;
%mend;



/* The %SimPower Macro */

/* This macro computes several versions of power for multiple comparisons */
/* procedures, in addition to FWE and directional FWE. */


/*--------------------------------------------------------------*/
/* Name:      SimPower                                          */
/* Title:     Macro to simulate power of multiple comparisons   */
/*            using various definitions                         */
/* Author:    Randy Tobias, sasrdt@sas.com                      */
/* Release:   Version 7.01                                      */
/*--------------------------------------------------------------*/
/* Inputs:                                                      */
/*                                                              */
/*      METHOD = TUKEY, DUNNETT, DUNNETTL, DUNNETTU, or REGWQ   */
/*               (TUKEY is the default)                         */
/*                                                              */
/*        NREP = number of Monte Carlo samples (1000 default)   */
/*                                                              */
/*           N = A Listing of within-group sample sizes         */
/*               or a single common sample size (no default)    */
/*                                                              */
/*          S = Standard deviation (required)                   */
/*                                                              */
/*        FWE = Desired Familywise Error (0.05 default)         */
/*                                                              */
/*  TRUEMEANS = A listing of the true group means (no default)  */
/*                                                              */
/*       SEED = Seed value for random numbers (0 default)       */
/*                                                              */
/*--------------------------------------------------------------*/
/* Output:  This macro simulates multiple power, using the      */
/* complete, minimal, and proportional definitions.  It also    */
/* simulates FWE (ordinary and directional), for a variety      */
/* of MCPs. The results are presented in a formatted table.     */
/*--------------------------------------------------------------*/

options ls=76 nodate generic;

/*
/  Use the binomial estimation options in PROC FREQ to compute
/  confidence limits for the Complete and Minimal power, which are
/  proportions; and use PROC MEANS to compute confidence limits for
/  the proportional power.
/---------------------------------------------------------------------*/
%macro EstBin(Input,Var,Output,Label);
proc freq  data=&Input noprint;
   table &Var / measures bin out=Freq;
   output out=&Output bin;
data _null_; set Freq;
   if (_N_ = 1) then call symput('First',&Var);
data &Output; set &Output;
   keep Quantity Estimate LowerCL UpperCL;
   Quantity = &Label;
   Estimate = _BIN_;
   LowerCL  = L_BIN; label LowerCL = "Lower 95% CL";
   UpperCL  = U_BIN; label UpperCL = "Upper 95% CL";
   if (&First = 0) then do;
      Estimate = 1 - Estimate;
      temp = LowerCL; LowerCL = UpperCL; UpperCL = temp;
      LowerCL = 1 - LowerCL;
      UpperCL = 1 - UpperCL;
      end;
run;
%mend;


%macro SimPower(method=TUKEY,nrep=1000,n=,s=,FWE=0.05,TrueMeans=
=,seed=0);

%let method = %upcase(&method);

/*
/  Determine the number of groups from the true means.
/---------------------------------------------------------------------*/
%let g = 1;
%do %while(%length(%bquote(%scan(%bquote(&TrueMeans),&g,%bquote(',')))));
   %let g = %eval(&g+1);
   %end;
%let g=%eval(&g-1);

options nonotes;

/*
/  Create &nrep random normal data sets using the true means.
/---------------------------------------------------------------------*/
%if ("%substr(&n,1,1)" = "(") %then %do;
   data a;
      array mu{&g} &TrueMeans;
      array _n{&g} &n;
      do rep = 1 to &nrep;
         do a = 1 to dim(mu);
            do i = 1 to _n{a};
               y = mu{a} + &s*rannor(&seed);
               output;
               end;
            end;
          end;
   run;
   %end;
%else %do;
   data a;
      array mu{&g} &TrueMeans;
      do rep = 1 to &nrep;
         do a = 1 to dim(mu);
            do i = 1 to &n;
               y = mu{a} + &s*rannor(&seed);
               output;
               end;
            end;
          end;
   run;
   %end;

/*
/  Analyze the random data sets.  For the methods that return pairwise
/  results, we put the confidence limits in the CLDiffs dataset; for
/  REGWQ we assemble all the LINES results in the MCLines dataset.
/---------------------------------------------------------------------*/
ods listing close;
%if (&method = REGWQ) %then %do;
   ods output MCLines(match_all=mv)=MCLines;
   %end;
%else %do;
   ods output CLDiffs=CLDiffs;
   %end;
proc glm data=a;
   by rep;
   class a;
   model y = a / nouni;
   means a / alpha=&fwe &method
   %if (&method ^= REGWQ) %then cldiff;
   ;
   quit;
ods listing;


%if (&method = REGWQ) %then %do;

/*
/  Combine the MCLines# datasets, putting all the Lines info into a
/  single L variable.
/---------------------------------------------------------------------*/
data temp; set &mv;
data MCLines; set temp(drop=Effect Dependent Method N);
   length _Name_ $ 8;
   array Line{26};
   where (Mean ^= ._);
   L = '                          ';
   do i = 1 to 26; substr(L,i,1) = Line{i}; end;
   _Name_ = trim(left('Level' || trim(left(Level))));
run;

/*
/  Turn the results from REGWQ into a data set that has a variable
/  "Correct" with the number of correctly rejected hypotheses
/  for each random data set.  Each of the three combined definitions
/  of power can be computed from this number.
/---------------------------------------------------------------------*/
proc sort data=MCLines out=MCLines;
   by rep Level;
proc transpose data=MCLines out=Lines;
   by rep;
   var L;
proc transpose data=MCLines out=Means prefix=Mn;
   by rep;
   var Mean;
data True; merge Lines Means;
   array Level{&g};
   array eq{&g,&g};
   array mu{&g} &TrueMeans;
   array Mn{&g};

   if (_n_ = 1) then do;
      ndiff = 0;
      nsame = 0;
      do a1=1 to &g-1; do a2 = a1+1 to &g;
         if (mu{a1} ^= mu{a2}) then ndiff = ndiff + 1;
         if (mu{a1}  = mu{a2}) then nsame = nsame + 1;
         end; end;
      retain ndiff nsame;
      end;

   do i = 1 to &g;
      do j = i+1 to &g;
         eq{i,j} = 0;
         do k = 1 to 26;
            lik = substr(Level{i},k,1);
            ljk = substr(Level{j},k,1);
            if ((lik ^= ' ') & (ljk ^= ' ') & (lik = ljk)) then eq{i,j} = 1;
            end;
         end;
      end;

   CorrectA = 0;
   Correct0 = 0;
   DirectionalError = 0;
   do i = 1 to &g-1;
      do j = i+1 to &g;
         if    ((mu{i} ^= mu{j}) & (^eq{i,j})) then CorrectA = CorrectA + 1;
         if    ((mu{i}  = mu{j}) &   eq{i,j} ) then Correct0 = Correct0 + 1;
         if (  ((mu{i}  = mu{j}) &  ^eq{i,j} )
             | ((mu{i}  < mu{j}) & (^eq{i,j}) & (Mn{i} > Mn{j}))
             | ((mu{i}  > mu{j}) & (^eq{i,j}) & (Mn{i} < Mn{j}))) then
            DirectionalError = 1;
         end;
      end;
   %end;
%else %do;
/*
/  Turn the results from the tests into a data set that has a
/  variable "Correct" with the number of correctly rejected hypotheses
/  for each random data set.  Each of the three combined definitions
/  of power can be computed from this number.
/---------------------------------------------------------------------*/
proc transpose data=CLDiffs out=Sig  prefix=Reject;
   var Significance;
   by rep;
proc transpose data=CLDiffs out=Comp prefix=Comp;
   var Comparison;
   by rep;
proc transpose data=CLDiffs out=Diff prefix=Diff;
   var Difference;
   by rep;
   run;

%if       (&method = TUKEY)    %then %let npair = %eval(&g*(&g-1));
%else %if (&method = DUNNETT)  %then %let npair = %eval(    &g-1 );
%else %if (&method = DUNNETTU) %then %let npair = %eval(    &g-1 );
%else %if (&method = DUNNETTL) %then %let npair = %eval(    &g-1 );

data True; merge Sig(keep=Reject:) Comp(keep=Comp:) Diff(keep=Diff:);
   array mu{&g} &TrueMeans;
   array Comp{&npair};
   array Reject{&npair};
   array Diff{&npair};

   if (_n_ = 1) then do;
      ndiff = 0;
      nsame = 0;
      %if (&method = TUKEY) %then %do;
         do a1=1 to &g; do a2 = 1 to &g; if (a1 ^= a2) then do;
            if (mu{a1} ^= mu{a2}) then ndiff = ndiff + 1;
            if (mu{a1}  = mu{a2}) then nsame = nsame + 1;
            end; end; end;
         %end;
      %else %if (&method = DUNNETT) %then %do;
         do a2 = 2 to &g;
            if (mu{1} ^= mu{a2}) then ndiff = ndiff + 1;
            if (mu{1}  = mu{a2}) then nsame = nsame + 1;
            end;
         %end;
      %else %if (&method = DUNNETTL) %then %do;
         do a2 = 2 to &g;
            if (mu{a2} - mu{1} <  0) then ndiff = ndiff + 1;
            if (mu{a2} - mu{1} >= 0) then nsame = nsame + 1;
            end;
         %end;
      %else %if (&method = DUNNETTU) %then %do;
         do a2 = 2 to &g;
            if (mu{a2} - mu{1} >  0) then ndiff = ndiff + 1;
            if (mu{a2} - mu{1} <= 0) then nsame = nsame + 1;
            end;
         %end;
      retain ndiff nsame;
/*
      put "For G=&g and TrueMeans=&TrueMeans, NDiff=" ndiff;
*/
      end;

   CorrectA = 0;
   Correct0 = 0;
   DirectionalError = 0;
   do i = 1 to dim(Reject);
      a1 = 1*scan(Comp{i},1,' ');
      a2 = 1*scan(Comp{i},3,' ');

      if ((mu{a1} ^= mu{a2}) & Reject{i}) then CorrectA = CorrectA + 1;

      %if (&method = DUNNETTL) %then %do;
         if ((mu{a1} - mu{a2} >= 0) & ^Reject{i}) then Correct0 = Correct0 +
1;
         if ((mu{a1} - mu{a2} >= 0) &  Reject{i}) then DirectionalError = 1;
         %end;
      %else %if (&method = DUNNETTU) %then %do;
         if ((mu{a1} - mu{a2} <= 0) & ^Reject{i}) then Correct0 = Correct0 +
1;
         if ((mu{a1} - mu{a2} <= 0) &  Reject{i}) then DirectionalError = 1;
         %end;
      %else %do;
         if (   (mu{a1} = mu{a2}) & ^Reject{i}                 ) then
            Correct0 = Correct0 + 1;
         if (  ((mu{a1} = mu{a2}) &  Reject{i}                )
             | ((mu{a1} < mu{a2}) &  Reject{i} & (Diff{i} > 0))
             | ((mu{a1} > mu{a2}) &  Reject{i} & (Diff{i} < 0))) then
            DirectionalError = 1;
         %end;
      end;

%end;

   call symput('ndiff',trim(left(put(ndiff,20.))));
   call symput('nsame',trim(left(put(nsame,20.))));
   if (ndiff) then do;
      CompletePower     = CorrectA=ndiff;
      MinimalPower      = CorrectA>0    ;
      ProportionalPower = CorrectA/ndiff;
      end;

   if (nsame) then do;
      TrueFWE = 1 - (Correct0=nsame);
      end;

run;


data Sim; if (0); run;

%if (&ndiff) %then %do;
   %EstBin(True,CompletePower,CompletePower,'Complete Power    ');
   data Sim; set Sim CompletePower;
   run;

   %EstBin(True,MinimalPower,MinimalPower,'Minimal Power     ');
   data Sim; set Sim MinimalPower;
   run;

   proc means data=True noprint;
      var ProportionalPower;
      output out=ProportionalPower(keep=Estimate LowerCL UpperCL)
             mean=Estimate lclm=LowerCL uclm=UpperCL;
   data ProportionalPower; set ProportionalPower;
      keep Quantity Estimate LowerCL UpperCL;
      Quantity = 'Proportional Power';
   data Sim; set Sim ProportionalPower;
   run;
   %end;

%if (&nsame) %then %do;
   %EstBin(True,TrueFWE,TrueFWE,'True FWE          ');
   data Sim; set Sim TrueFWE;
   run;
   %end;

%EstBin(True,DirectionalError,DirectionalError,'Directional FWE   ');
data Sim; set Sim DirectionalError;
   run;

data Sim; set Sim;
   CI = "(" || put(LowerCL,5.3) || ',' || put(UpperCL,5.3) || ")";
   label CI = "---95% CI----";
run;
options ls=76 nodate generic;
proc print data=Sim noobs label;
   var Quantity Estimate CI;
   title1 "Method=&method, Nominal FWE=&FWE, nrep=&nrep, Seed=&seed";
   title2 "True means = &TrueMeans, n=&n, s=&s";
   run;
title1;
title2;

options notes;
%mend;




/* The %PlotSimPower Macro */

/* This macro computes power using various definitions, for various */
/* sample sizes, and plots the results. */


/*--------------------------------------------------------------*/
/* Name:      PlotSimPower                                      */
/* Title:     Macro to plot the simulated power of multiple     */
/*            comparisons procedures                            */
/* Author:    Randy Tobias, sasrdt@sas.com                      */
/* Release:   Version 7.01                                      */
/*--------------------------------------------------------------*/
/* Inputs:                                                      */
/*                                                              */
/*      METHOD = TUKEY, DUNNETT, DUNNETTL, DUNNETTU, or REGWQ   */
/*               (TUKEY is the default)                         */
/*                                                              */
/*        NREP = number of Monte Carlo samples (100 default)    */
/*                                                              */
/*          S = Standard deviation (required)                   */
/*                                                              */
/*        FWE = Desired Familywise Error (0.05 default)         */
/*                                                              */
/*  TRUEMEANS = A listing of the true group means (no default)  */
/*                                                              */
/*       SEED = Seed for random numbers (0 default)             */
/*                                                              */
/*       STOP = type/maxpower, specifies the type of power      */
/*              whether COMPLETE, MINIMAL, or PROPORTIONAL,     */
/*              and the maximum power to stop simulation.       */
/*              The default is COMPLETE/0.9                     */
/*                                                              */
/*     TARGET = desired power level (default 0.8)               */
/*                                                              */
/*--------------------------------------------------------------*/
/* Output: A graph of the power function, indicating the n for  */ 
/* which the target power is acheived.                          */
/*                                                              */
/*--------------------------------------------------------------*/

%macro PlotSimPower(method    =        TUKEY,
                    nrep      =          100,
                    s         =             ,
                    FWE       =         0.05,
                    TrueMeans =             ,
                    seed      =            0,
                    stop      = Complete/0.9,
                    target    =          0.8);


   %let StopType  = %scan(&stop,1,'/');
   %let StopValue = %scan(&stop,2,'/');

   data plot; if (0); run;
   %do n = 2 %to 100;
      %SimPower(TrueMeans = &TrueMeans,
                s         =         &s,
                n         =         &n,
                nrep      =      &nrep,
                method    =    &method,
                seed      =      &seed);
      data Sim; set Sim(where=(scan(Quantity,1)="%scan(&stop,1,'/')"));
         n = &n;
         put "For N=&n, &StopType power = " Estimate;
         if (LowerCL >= &StopValue) then call symput('n','1001');
      data plot; set plot Sim;
      %end;

data probit;
   set plot;
   Estimate = round(100*Estimate);
   c=100;
   sqrtn = sqrt(n);
   call symput('MaxN',trim(left(put(n,best20.))));
proc probit data=probit outest=ests noprint;
   model Estimate/c=sqrtn;
data _null_; set ests;
   call symput('IParm',trim(left(put(Intercept,best20.))));
   call symput('NParm',trim(left(put(sqrtn    ,best20.))));
   run;
%put IParm=&IParm;
%put NParm=&NParm;
data plot; set plot;
   EPower = probnorm(&IParm + sqrt(n)*&NParm);
   label EPower="Power";
   run;

data target;
   length xsys ysys position $ 1;
   retain hsys color;

   sqrtn   = (probit(&target) - &IParm)/&NParm;
   ntarget = int(sqrtn*sqrtn + 1);
   actual  = probnorm(&IParm + sqrt(ntarget)*&NParm);

   color = 'black';
   xsys = '1'    ; ysys = '2'   ;
   x    = 0      ; y    = actual; function = 'MOVE ';                 output;
   xsys = '2'    ; ysys = '2'   ;
   x    = ntarget; y    = actual; function = 'DRAW '; line=1; size=1; output;
   xsys = '2'    ; ysys = '1'   ;
   x    = ntarget; y    = 0     ; function = 'DRAW '; line=1; size=1; output;

   xsys = '2';               ysys = '2';
   x    = (&MaxN+ntarget)/2; y    = actual/2; function = 'LABEL';
   style = 'swissb';
   text  = "Power(N="||trim(left(put(ntarget,best6.)))||")";
   position = '0';
   output;

   xsys = '2';               ysys = '2';
   x    = (&MaxN+ntarget)/2; y = actual/2-0.1; function = 'LABEL';
   style = 'swissb';
   text  = "  = "||put(actual,5.3);
   position = '0';
   output;

goptions ftext=swissb vsize=6 in hsize=6 in;
axis1 style=1 width=2 minor=none;
axis2 style=1 width=2 minor=none;
symbol1 color=BLACK i=join;
symbol2 color=BLACK i=none v=dot height=0.5;
proc gplot data=plot(where=(scan(Quantity,1)="&StopType")) annotate=target;
   title2 "&StopType power using the &method method with FWE=&FWE";
   title4 "With true means &TrueMeans and standard deviation = &s";
   plot EPower*n=1 Estimate*n=2 / vaxis=axis1 haxis=axis2 frame overlay;
run;
quit;
title2;
title3;
title4;

%mend;



/* The %BegGab Macro */

/* This macro performs multiple comparisons using the Begun and Gabriel */
/* (1981) method. */


/*--------------------------------------------------------------*/
/* Name:      BegGab                                            */
/* Title:     Begun and Gabriel Closed Testing Procedure        */
/* Author:    Dror Rom, rom@prosof.com                          */
/* Reference: Begun, J., and Gabriel, K. R. (1981). Closure of  */
/*              the Newman-Keuls multiple comparisons procedure.*/
/*              Journal of the American Statistical Association,*/
/*              76, 241-245.                                    */
/* Release:   Version 6.11                                      */
/*--------------------------------------------------------------*/
/* Input:                                                       */
/*                                                              */
/*   DATASET=   the SAS data set containing the data to be      */
/*              analyzed (required)                             */
/*                                                              */
/*   GROUPS=    the grouping variable (required)                */
/*                                                              */
/*   RESPONSE=  the response variable (required)                */
/*                                                              */
/*   FWE=       the level of significance for comparisons       */
/*              among the means.  The default is 0.05.          */
/*                                                              */
/* Output:                                                      */
/*                                                              */
/*   The output dataset contains one observation for each       */
/*   pairwise comparison in the dataset.  The output dataset    */
/*   contains the following variables:                          */
/*                                                              */
/*     GRi    - The index of a (smaller) mean being compared    */
/*                                                              */
/*     Grj    - The index of a (larger) mean being compared     */
/*                                                              */
/*     PVALUE - The P-value for the comparison                  */
/*                                                              */
/*     DECISION - Reject or Retain the corresponding hypothesis */
/*--------------------------------------------------------------*/

%macro BegGab(dataset=,groups=,response=,FWE=0.05);
options nonotes;
proc sort data=&dataset;
by &groups;
proc means data=&dataset noprint;
   var &response;
   by &groups;
   output out=bg mean=mean std=sd n=n;
proc print;
var trt mean sd n;
data bg;set bg;
samps=n;drop n;
proc sort;
by mean;
proc means noprint;
var samps;
output out=b n=m;
data a;set b;
call symput('m',m);
run;

%let mm=%eval(&m*&m);
%let m=%eval(&m);

data a;set bg;
i=_N_;
grp=trt;
trt=i;
m=&m;
array t(&m);
array gr(&m) $;
t(i)=trt;
gr(i)=grp;
array meanss(&m);
meanss(i)=mean;
array stds(&m);
stds(i)=sd;
array samp(&m);
samp(i)=samps;
array p(&m,&m);
retain meanss1-meanss&m;
retain stds1-stds&m;
retain samp1-samp&m;
retain p1-p&mm;
retain t1-t&m;
retain gr1-gr&m;
 df=0;
 mse=0;
 do i=1 to m;
  mse=mse+stds(i)**2*(samp(i)-1);
  df=df+samp(i)-1;
 end;
 mse=mse/df;
 do i= 1 to (m-1);
   do j= (i+1) to m;
     msamp=0;
     do k=i to j;
     msamp=msamp+samp(k);
     end;
     msamp=msamp/(j-i+1);
     tr=j-i+1;
     if (tr>2) then do;
       tval=abs((meanss(j)-meanss(i)))/
            ((mse/2)*((1/samp(i))+(1/samp(j))))**0.5;
       if not(tval='.')then
       p(i,j)=1-probmc('RANGE',tval,.,df,tr);
     end;
     else do;
       tval=abs((meanss(j)-meanss(i)))/
            (mse*((1/(samp(i)))+(1/(samp(j)))))**0.5;      
       if not(tval='.')then
       p(i,j)=2*(1-probt(tval,df));
     end;
   end;
 end;
run;

data a;set a;by j;if last.j;
data a;set a;
  j=m;
  array p{&m,&m};
  array g{&m};
  array dec{&m,&m} $;
  do i= 1 to m;
   g(i)=0;
  end;
  do i=1 to (m-1);
     do j=(i+1) to m;
      dec(i,j)='.';
     end;
  end;

 do i=1 to (m-1);
  do j=(i+1) to m;
   if(not(dec(i,j)='Retain'))then
    do;
    if p(i,j)>&FWE then
                          do;
                           dec(i,j)='Retain';
                            do k=i to (j-1);
                             do l=(k+1) to j;
                               dec(k,l)='Retain';
                             end;
                            end;

                          end;
    else
    if (p(i,j)<=(&FWE*(j-i+1)/m))then dec(i,j)='Reject';

    else
    if (0.05>=p(i,j)>(&FWE*(j-i+1))/m)then
         do;
              if
               (((i>2)and(p(1,(i-1))<=(&FWE*(i-1))/m))
                         and
           ((j<(m-1))and(p((j+1),m)<=(&FWE*(m-j))/m)))
                            then do;
                                   dec(i,j)='Reject';
                                   do k=1 to (i-2);
                                    do l=(k+1) to (i-1);
                                      if(p(k,l)>(&FWE*(l-k+1)/m)) then
                                         dec(i,j)='Retain';
                                    end;
                                   end;
                                   do k=(j+1) to (m-1);
                                    do l=(k+1) to m;
                                      if(p(k,l)>(&FWE*(l-k+1)/m)) then
                                         dec(i,j)='Retain';
                                    end;
                                   end;

                                 end;

               if
                (((i>2)and(p(1,(i-1))<=(&FWE*(i-1))/m))
                         and
                     ((j>=(m-1))))
                        then do;
                               dec(i,j)='Reject';
                               do k=1 to (i-2);
                                    do l=(k+1) to (i-1);
                                      if(p(k,l)>(&FWE*(l-k+1)/m)) then
                                         dec(i,j)='Retain';
                                    end;
                                   end;
                               end;
               if
                     (((i<=2))
                         and
           ((j<(m-1))and(p((j+1),m)<=(&FWE*(m-j))/m)))
                        then do;
                               dec(i,j)='Reject';
                               do k=(j+1) to (m-1);
                                    do l=(k+1) to m;
                                      if(p(k,l)>(&FWE*(l-k+1)/m)) then
                                         dec(i,j)='Retain';
                                    end;
                                   end;
                               end;

             if((i<=2)and(j>=(m-1)))then dec(i,j)='Reject';

            if(not(dec(i,j)='Reject'))then
                            do k=i to (j-1);
                             do l=(k+1) to j;
                               dec(k,l)='Retain';
                             end;
                            end;
         end;
     end;
   end;
 end;
run;
data a1;set a;
  array t{&m};
  array p{&m,&m};
  array dec{&m,&m} $;
  array gr(&m) $;

 do i=1 to m;
  do j=1 to m;
   ti=t(i);
   tj=t(j);
   gri=gr(i);
   grj=gr(j);
   decision=dec(i,j);
   pvalue=p(i,j);
   if not(pvalue='.')then output;
  end;
 end;

title1 ' ';
title2 'Begun-Gabriel Closed Testing Procedure';
title3 "Based on the Range Statistic, FWE=&FWE";
TITLE4 ' ';
DATA _NULL_;
FILE PRINT;
set a1 end=eof;
IF _N_=1 THEN DO;
PUT @20 't_i' @26 '-' @30 't_j' @37 'P-VALUE' @48 'DECISION';
PUT @20 36*'-';
END;
if pvalue>=0.0001 then put @20 gri @26 '-' @30 grj @37 pvalue 6.4 @48 
   decision;
else put  @20 gri @26 '-' @30 grj @37 '<.0001' @48 decision;
if EOF=1 then do;
PUT @20 36*'-';
end;
RUN;

data b;set a;
 array dec(&m,&m) $;
 array g(&m);
 array gr(&m) $;
 do i=1 to (m-1);
  do j=(i+1) to m;
   if((dec(i,j)='Reject'))then g(j)=g(j)+1;
  end;
 end;
data b1;set b;
array g(&m);
array gr(&m) $;
 do j=1 to m;

   if(j=1)then hfb=0;
   else
     hfb=g(j);
   output;
 end;
data c;set b;
 array dec(&m,&m) $;
 array g(&m);
 do i=1 to (m-1);
  do j=(i+1) to m;
         if((dec(i,j)='Retain'))then do l=i to j;
                                     g(l)=g(j);
                                     end;
         end;
        end;
data c1;set c;
array g(&m);
array gr(&m) $;
 do j=1 to m;
   tj=gr(j);
   if(j=1)then hfa=0;
   else
     hfa=g(j);
   output;
 end;

data d;merge b1 c1;by j;
keep hfa hfb j tj;
goptions colors=(black) cback=white;
proc gplot;
label tj='Treatment';
title1 ' ';
title2 'Begun-Gabriel Closed Testing Procedure';
title3 "Based on the Range Statistic, FWE=&FWE";
title4 'Schematic Plot of Significant Differences';
title5 ' ';
symbol1 i=join value=dot;
symbol2 i=join value=dot;
axis1 label=(angle=90 rotate=0 'Response') value=none major=none
minor=none;
axis2 minor=none;
plot (hfa hfb)*tj/vaxis=axis1 haxis=axis2 overlay frame;
run;

options notes;
%MEND BEGGAB;



/* The %RCC Macro */

/* This macro performs closed dose-response tests using the Rom, */
/* Costello, and Connell (1994) method. */


/*--------------------------------------------------------------*/
/* Name:      RCC                                               */
/* Title:     Rom, Costello, and Connell Closed Testing         */
/*            Procedure for Dose Response analysis              */
/* Author:    Dror Rom, rom@prosof.com                          */
/* Reference: Rom, D. M., Costello, R. and Connell, L. (1994).  */
/*             On closed test procedures for dose response      */
/*             analysis. Statistics in Medicine, 13, 1583-1596. */
/* Release:   Version 6.11                                      */
/*--------------------------------------------------------------*/
/* Input:                                                       */
/*                                                              */
/*   DATASET=   the SAS data set containing the data to be      */
/*              analyzed (required)                             */
/*                                                              */
/*   GROUPS=    the grouping variable (required)                */
/*                                                              */
/*   RESPONSE=  the response variable (required)                */
/*                                                              */
/*   FWE=       the level of significance for comparisons       */
/*              among the means.  The default is 0.05.          */
/*                                                              */
/* Output:                                                      */
/*                                                              */
/*   The output dataset contains one observation for each       */
/*   trend test among successive means.  The output dataset     */
/*   contains the following variables:                          */
/*                                                              */
/*     Di    - The index of a (smaller) dose being compared     */
/*                                                              */
/*     Dj    - The index of a (larger) dose being compared      */
/*                                                              */
/*     PVALUE - The P-value for the comparison                  */
/*                                                              */
/*     DECISION - Reject or Retain the corresponding hypothesis */
/*--------------------------------------------------------------*/
%MACRO rcc(dataset=,groups=,response=,FWE=0.05);
proc means data=&dataset noprint;
var &response;
by &groups;
output out=rcc n=samps std=sd mean=mean;
data meanss;set rcc;
proc sort;
by &groups;
proc means noprint;
var samps;
output out=b n=m;
data a;set b;
call symput('m',m);
run;

%let mm=%eval(&m*&m);
%let m=%eval(&m);

data a;set meanss;
i=_N_;
m=&m;
array d(&m);
d(i)=&groups;
array meanss(&m);
meanss(i)=mean;
array stds(&m);
stds(i)=sd;
array samp(&m);
samp(i)=samps;
array p(&m,&m);
retain meanss1-meanss&m;
retain stds1-stds&m;
retain samp1-samp&m;
retain p1-p&mm;
retain d1-d&m;
 df=0;
 mse=0;
 do i=1 to m;
  mse=mse+stds(i)**2*(samp(i)-1);
  df=df+samp(i)-1;
 end;
 mse=mse/df;
 do i= 1 to (m-1);
   do j= (i+1) to m;
    expec=0;
    do k=i to j;
      expec=expec+k;
    end;
    expec=expec/(j-i+1);
    num=0;
    den=0;
    do k=i to j;
       num=num+(k-expec)*meanss(k);
       den=den+(k-expec)**2/samp(k);
    end;
    t=num/(mse*den)**0.5;
    p(i,j)=1-probt(t,df);
   end;
 end;
run;

data a;set a;by j;if last.j;
data a;set a;
alpha=0.05;
  j=m;
  array p{&m,&m};
  array g{&m};
  array dec{&m,&m} $;
  do i= 1 to m;
   g(i)=0;
  end;
  do i=1 to (m-1);
     do j=(i+1) to m;
      dec(i,j)='.';
     end;
  end;

 do i=1 to (m-1);
  do j=(i+1) to m;
   if(not(dec(i,j)='Retain'))then
    do;
    if p(i,j)>alpha then
                          do;
                           dec(i,j)='Retain';
                            do k=i to (j-1);
                             do l=(k+1) to j;
                               dec(k,l)='Retain';
                             end;
                            end;

                          end;
    else
    if (p(i,j)<=(alpha*(j-i+1)/m))then dec(i,j)='Reject';

    else
    if (0.05>=p(i,j)>(alpha*(j-i+1))/m)then
         do;
              if
               (((i>2)and(p(1,(i-1))<=(alpha*(i-1))/m))
                         and
           ((j<(m-1))and(p((j+1),m)<=(alpha*(m-j))/m)))
                            then do;
                                   dec(i,j)='Reject';
                                   do k=1 to (i-2);
                                    do l=(k+1) to (i-1);
                                      if(p(k,l)>(alpha*(l-k+1)/m)) then
                                         dec(i,j)='Retain';
                                    end;
                                   end;
                                   do k=(j+1) to (m-1);
                                    do l=(k+1) to m;
                                      if(p(k,l)>(alpha*(l-k+1)/m)) then
                                         dec(i,j)='Retain';
                                    end;
                                   end;

                                 end;

               if
                (((i>2)and(p(1,(i-1))<=(alpha*(i-1))/m))
                         and
                     ((j>=(m-1))))
                        then do;
                               dec(i,j)='Reject';
                               do k=1 to (i-2);
                                    do l=(k+1) to (i-1);
                                      if(p(k,l)>(alpha*(l-k+1)/m)) then
                                         dec(i,j)='Retain';
                                    end;
                                   end;
                               end;
               if
                     (((i<=2))
                         and
           ((j<(m-1))and(p((j+1),m)<=(alpha*(m-j))/m)))
                        then do;
                               dec(i,j)='Reject';
                               do k=(j+1) to (m-1);
                                    do l=(k+1) to m;
                                      if(p(k,l)>(alpha*(l-k+1)/m)) then
                                         dec(i,j)='Retain';
                                    end;
                                   end;
                               end;

             if((i<=2)and(j>=(m-1)))then dec(i,j)='Reject';

            if(not(dec(i,j)='Reject'))then
                            do k=i to (j-1);
                             do l=(k+1) to j;
                               dec(k,l)='Retain';
                             end;
                            end;
         end;
     end;
   end;
 end;
data a1;set a;
  array d{&m};
  array p{&m,&m};
  array dec{&m,&m} $;
 do i=1 to m;
  do j=1 to m;
   di=d(i);
   dj=d(j);
   decision=dec(i,j);
   pvalue=p(i,j);
   if not(pvalue='.')then output;
  end;
 end;

title1 ' ';
title2 'ROM-COSTELLO-CONNELL CLOSED TESTING PROCEDURE';
title3 'FOR UPPER-TAILED';
TITLE4 'DOSE RESPONSE ANALYSIS';
title5 ' ';
DATA _NULL_;
FILE PRINT;
set a1 end=eof;
IF _N_=1 THEN DO;
PUT @15 'd_i' @21 '-' @25 'd_j' @32 'P-VALUE' @43 'DECISION';
PUT @15 36*'-';
END;
if pvalue>=0.0001 then put @15 di @21 '-' @25 dj @32 pvalue 6.4 @43 decision;
else put @15 di @21 '-' @25 dj @32 '<.0001' @43 decision;
if EOF=1 then do;
PUT @15 36*'-';
put @15 'ALPHA=' @23 alpha;
end;
RUN;

data b;set a;
 array dec(&m,&m) $;
 array g(&m);
 do i=1 to (m-1);
  do j=(i+1) to m;
   if((dec(i,j)='Reject'))then g(j)=g(j)+1;
  end;
 end;
data b1;set b;
array g(&m);
 do j=1 to m;

   if(j=1)then hfb=0;
   else
     hfb=g(j);
   output;
 end;
data c;set b;
 array dec(&m,&m) $;
 array g(&m);
 do i=1 to (m-1);
  do j=(i+1) to m;
         if((dec(i,j)='Retain'))then do l=i to j;
                                     g(l)=g(j);
                                     end;
         end;
        end;
data c1;set c;
array g(&m);
array d(&m);
 do j=1 to m;
   dj=d(j);
   if(j=1)then hfa=0;
   else
     hfa=g(j);
   output;
 end;

data d;merge b1 c1;by j;
keep hfa hfb j dj;
goptions colors=(black) cback=white;
proc gplot;
label dj='TREATMENT';
title1 ' ';
title2 'ROM-COSTELLO-CONNELL CLOSED TESTING PROCEDURE';
title3 ' ';
title4 'SCHEMATIC PLOT OF THE DOSE RESPONSE';
title5 ' ';
symbol1 i=join value=dot;
symbol2 i=join value=dot;
axis1 label=(angle=90 rotate=0 'Response') value=none major=none minor=none;
axis2 minor=none;
plot (hfa hfb)*dj/vaxis=axis1 haxis=axis2 overlay frame;
run;
%MEND rcc;




/* The %Williams Macro */

/* This macro performs a step-down test for the ``Minimal Effective Dose" */
/* using Williams (1971, 1972) method. */


/*---------------------------------------------------------------*/
/* Name:      Williams                                           */
/* Title:     Williams step-down test for minimal effective dose */
/* Author:    Dror Rom, rom@prosof.com                           */
/* Reference: Williams, D. A. (1971). A test for difference      */
/*              between treatment means when several dose levels */
/*              are compared with a zero dose level.             */
/*              Biometrics, 27, 103-117.                         */
/*            Williams, D. A. (1972). The comparison of several  */
/*              dose levels with a zero dose control.            */
/*              Biometrics, 28, 519-531                          */
/* Release:   Version 6.12                                       */
/*---------------------------------------------------------------*/
/* Input:                                                        */
/*                                                               */
/*   DATASET=   the SAS data set containing the data to be       */
/*              analyzed (required)                              */
/*                                                               */
/*   TRT=       the grouping variable (required)                 */
/*                                                               */
/*   RESPONSE=  the response variable (required)                 */
/*                                                               */
/*                                                               */
/* Output:                                                       */
/*                                                               */
/*   The output dataset contains one observation for each        */
/*   pairwise comparison in the dataset.  The output dataset     */
/*   contains the following variables:                           */
/*                                                               */
/*      i    - The index of a dose being compared with the       */
/*             control (zero dose)                               */
/*                                                               */
/*     M1    - The mean of the control                           */
/*                                                               */
/*     M     - The mean of the dose being compared with the      */
/*             control                                           */
/*                                                               */
/*     W     - The Williams statistics for the dose being        */
/*             compared with the control                         */
/*                                                               */
/*     PV    - P-value for the comparison                        */
/*---------------------------------------------------------------*/


%macro Williams(dataset=,trt=,response=);

options nonotes;

************************ Get Stats *****************;
proc glm data=&dataset noprint outstat=stat;
class &trt;
model &response=&trt;
run;
data stat;set stat;
keep _source_ mse ss df;
if _source_='ERROR';
mse=ss/df;

proc means data=&dataset noprint;
var &response;
by &trt;
output out=means mean=mean n=samp;

data means;set means;
proc means noprint;
var samp;
output out=a n=m;
data a;set a;
keep m;

data b;merge a stat;
d=df;
e=mse;
call symput('m',m);
run;
data b;set b;
%let m=%eval(&m);

proc sort;
by m;
data c;set means;
m=&m;

array means(&m);
array samps(&m);

means(&trt)=mean;
samps(&trt)=samp;
retain means1-means&m;
retain samps1-samps&m;
data c;set c;if &trt=m;
data d;merge c b;
array means(&m);
array samps(&m);
array will(&m);
                        *************** Pool adjacent violators **********;
control=means(1);
do j=1 to m-1;
if (means(j)>means(j+1)) then
 do;
  emean=means(j+1);
  l=0;
  do k=j to 1 by -1;
   l=l+1;
   if emean<means(k) then do;
                            emean=emean*l/(l+1)+means(k)/(l+1);
                                do r=k to j+1;
                                  means(r)=emean;
                                end;
                         end;
  end;
 end;
do k=2 to m;
will(k)=(means(k)-control)/(mse*((1/(samps(1))+(1/(samps(k))))))**0.5;
end;
end;
                        *************** Get P-values **********;
data williams;
set d;
array means(&m);
array will(&m);
array p(&m);
do i=2 to m;
p(i)=1-probmc("williams",will(i),.,df,i-1);*** P-values are based on number of doses ***;
end;

data williams;set williams;
format means1-means&m f4.3 will2-will&m f4.3 p2-p&m f5.4;
proc print;
var means1-means&m will2-will&m p2-p&m;
run;
options notes;
%MEND Williams;



/* The %SimTests Macro */

/* This macro performs closed multiple tests for general functions */
/* parameters, incorporating logical constraints and correlations using */
/* Westfall's (1997) method. */


/*--------------------------------------------------------------*/
/* Name:      SimTests                                          */
/* Title:     Simultaneous Hypothesis Tests for General Linear  */
/*            Functions, using Correlations and Constraints     */
/* Author:    Peter Westfall, westfall@ttu.edu                  */
/* Reference: Westfall, P.H. (1997). Multiple testing of        */
/*            general contrasts using logical constraints and   */
/*            correlations.  JASA 92, 299-306                   */
/* Release:   Version 7.01                                      */
/*--------------------------------------------------------------*/
/* Inputs:                                                      */
/*                                                              */
/*      NSAMP =  simulation size, with 20000 as default         */
/*                                                              */
/*      SEED  =  random number seed, with 0 (clock time)        */
/*               as default                                     */
/*                                                              */
/*      SIDE  = U, L or B, for upper-tailed, lower-tailed       */
/*              or two-tailed, respectively. SIDE=B is default. */
/*                                                              */
/*      TYPE  = LOGICAL or FREE, for logically constrained or   */
/*              unconstrained tests, respectively. TYPE=FREE    */
/*              is the default.                                 */
/*                                                              */
/*  Additionally, %SimTests requires two further macros to be   */
/*  defined that use SAS/IML to construct the estimates and     */
/*  the contrasts of interest.  In particular, make sure the    */
/*  following two macros are defined before invoking            */
/*  %SimTests:                                                  */
/*                                                              */
/*     %Estimate: Uses SAS/IML code to define                   */
/*        EstPar - (column) vector of estimated parameters      */
/*        Cov    - covariance matrix for the for the estimates  */
/*        df     - error degrees of freedom; set to 0 for       */
/*                 asymptotic analysis                          */
/*                                                              */
/*     %Contrasts: Uses SAS/IML code to define                  */
/*        C      - matrix whose columns define the contrasts of */
/*                 interest between the parameters              */
/*        CLab   - (column) character vector whose elements     */
/*                 label the respective contrasts in C          */
/*                                                              */
/*  You can either define these macros directly, or use the     */
/*  %MakeGLMStats macro to define them.                         */
/*                                                              */
/*--------------------------------------------------------------*/
/* Output:                                                      */
/*   The primary output is a dataset with one observation for   */
/*   each contrast and the following variables:                 */
/*                                                              */
/*     Contrast - contrast label                                */
/*     Estimate - contrast estimated value                      */
/*     StdErr   - standard error of estimate                    */
/*     tValue   - normalized estimate, Estimate/StdErr          */
/*     RawP     - non-multiplicity-adjusted p-value             */
/*     BonP     - Bonferroni multiplicity-adjusted p-value      */
/*     BonMult  - corresponding Bonferroni multiplier           */
/*     AdjP     - stepwise multiplicity-adjusted p-value        */
/*     SEAdjP   - standard error for AdjP                       */
/*                                                              */
/*   This dataset is also displayed as a formatted table, using */
/*   the ODS system.                                            */
/*                                                              */
/*  This macro also produces a data set called SUBSETS that has */
/*  has a variable STEPJ indicating the particular (ordered)    */
/*  hypothesis being considered; as well as variables           */
/*  (TEST1--TESTk) identifying the particular subset hypotheses */
/*  that contain the hypothesis indicated by the STEPJ variable,*/
/*  that do not contradict falsehood of the previous hypotheses.*/
/*  The order of the TEST1--TESTk variables is from most to     */
/*  least significant.                                          */
/*--------------------------------------------------------------*/

%macro SimTests(nsamp   = 20000  ,
                seed    = 0      ,
                side    = B      ,
                type    = FREE   ,
                options =        );
%global ANORM;

options nonotes;

proc iml;
%Estimates;
if (df <= 0) then call symput('ANORM','1');
else              call symput('ANORM','0');
%Contrasts;
C = C`;
side="&side";
type="&type";
if side = "U" then C=-C;

EstCont = C*EstPar;
CovCont = C*Cov*C`;
SECont = sqrt(vecdiag(CovCont));
tvals = EstCont/SECont;
if side = "B" then do;
   tvals = -abs(tvals);
   if df=0 then pvals = 2*probnorm(tvals);
      else pvals = 2*probt(tvals,df);
   end;
else do;
   if df=0 then pvals=probnorm(tvals);
      else pvals = probt(tvals,df);
   end;

k = nrow(c);
nests = nrow(EstPar);
call symput('k',char(k));
call symput('g',char(nests));
r  = rank(Pvals`);
ir = r;
ir[,r] = 1:nrow(PVals);
origord  = ir`         ;
cord     = c      [ir,];
clabord  = clab   [ir,];
tvalsord = tvals  [ir,];
pvalsord = pvals  [ir,];
ccord    = CovCont[ir,ir];
crrccord = inv(sqrt(diag(ccord)))*ccord*inv(sqrt(diag(ccord)));
ct = t(cord);

start ztrail;
   ii=1;
   zz=kk;
   do while(mod(zz,2)=0);
      ii=ii+1;
      zz=zz/2;
      end;
finish;

if type = "LOGICAL" then do;
do iout  = 1 to k-2;
   limit = 2**(k-iout-1);
   in=J(k-iout-1,1,0);
   zero =J(k,1,0);
   in1 =zero;
   y = ct[,1:iout];

   do kk=1 to limit;
      if kk=limit then in=j(k-iout-1,1,0);
      else do;
         run ztrail;
         in[ii,]=^in[ii,];
         end;

      locbin  = j(iout, 1, 0) // {1} // in;
      loc1 = loc(locbin);
      x = ct[,loc1];

      res = y - x*ginv(x`*x)*x`*y;
      ssemat = vecdiag(res`*res);

      if ssemat > .00000001 then do;
         if in1=0 then in1 = locbin;
         else do;
            check = in1 - repeat(locbin, 1, ncol(in1));
            diff = check[<>,] - check[><,];
            if min(diff) = 2 then  in1 = in1||locbin;
            else do;
               mindx = diff[,>:<];
               if check[+,mindx]=-1 then in1[,mindx] = locbin;
               end;
            end;
         end;
      end;
   in1  = in1`;
   ncont = nrow(in1);
   in1 = j(ncont,1,iout+1)||in1;
   if iout = 1 then inbig = in1;
   else inbig = inbig//in1;
   end;
end;

big = j(1,k+1,1)//inbig;
lastset = j(1,1,k)||j(1,k-1,0)||{1};
big = big//lastset;
stepj = big[,1];
if type="FREE" then do;
   stepj = 1:k;
   stepj = stepj`;
end;
SubsetK = big[,2:ncol(big)];
if type="FREE" then do;
   m = j(1,k,1);
   do i = 2 to k;
      r = j(1,i-1,0)||j(1,k-i+1,1);
      m= m//r;
   end;
SubsetK = m;
end;


subsets = subsetk||stepj;
create subsets var (("t1":"t&k")||"StepJ");
append from subsets;
nbig = nrow(big);
if type="LOGICAL" then des = design(big[,1]);
   else des=design(stepj);
if type="LOGICAL" then contonly = big[,2:k+1];
   else contonly = subsetk;
tcmpr = des*tvalsord;
h = root(crrccord);
if type="FREE" then nbig=k;
count = j(nbig,1,0);
countc = count;
countc2 = count;

contonly = ((contonly + des)  > 0);

if type="LOGICAL" then totals =  contonly[,+];
   else do; totals=k:1; totals=totals`; end;
if side = "B" then do;
    if df = 0 then bon = 2*(probnorm(tcmpr))#totals;
       else bon = 2*(probt(tcmpr,df))#totals;
       end;
   else do;
      if df = 0 then bon = (probnorm(tcmpr))#totals;
      else bon = (probt(tcmpr,df))#totals;
      end;

if &nsamp>0 then do;
file log;
do isim = 1 to &nsamp;
   if mod(isim,5000) = 0 then put isim;
   z = h`*rannor(j(k,1,&seed));
   if df=0 then s=1; else do;
      chi = 2*rangam(&seed,df/2);
      s = sqrt(chi/df);
      end;
   t = z/s;
   if side = "B" then t = -abs(t);
   try = (contonly#(j(nbig,1,1)*t`));
   try1 = (10000*(try=0)) + try;
   maxind =    (try1[,><] <= tcmpr);

   sumind = (try1 < ((tcmpr)*j(1,ncol(try),1)))[,+];
   countc = countc + sumind;
   countc2 = countc2 + sumind##2;
   count = count +  maxind;
end;

smpl = count/&nsamp;
cv = bon + smpl - countc/&nsamp;
avec = countc/&nsamp;
avec2 = countc2/&nsamp;
varx = smpl#(j(nrow(smpl),1,1)-smpl);
varz = avec2 - avec##2 + smpl - smpl##2 -2*avec#(j(nrow(smpl),1,1)-smpl);
covzx = (avec-smpl)#(j(nrow(smpl),1,1)-smpl);
a1 = varz+covzx;
a2 = varx+covzx;
atot = a1+a2;
atot = (atot=0) + atot;
a1 = a1/atot;
a2 = a2/atot;
atot = a1+a2;
a2 = a2+(atot=0);
gls = a1#smpl + a2#cv;

stdgls = sqrt(abs((a1##2#varx + a2##2#varz -2*a1#a2#covzx)/&nsamp));
stdsmpl = sqrt(varx/&nsamp);
stdcv = sqrt(abs(varz/&nsamp));
glsbig = des#(gls*j(1,k,1));
glsp = glsbig[<>,];
glsin = glsbig[<:>,];

stdgls = stdgls[glsin,];
glsptry = glsp`;
smplbig = des#(smpl*j(1,k,1));
smplp = smplbig[<>,];
smplin = smplbig[<:>,];
stdsmpl = stdsmpl[smplin,];
cvbig = des#(cv*j(1,k,1));
cvp = cvbig[<>,];
cvin = cvbig[<:>,];
stdcv = stdcv[cvin,];

do i = 2 to k;
   if smplp[1,i] < smplp[1,i-1] then do;
      smplp[1,i] = smplp[1,i-1];
      stdsmpl[i,1] = stdsmpl[i-1,1];
      end;
   if cvp[1,i] < cvp[1,i-1] then do;
      cvp[1,i] = cvp[1,i-1];
      stdcv[i,1] = stdcv[i-1,1];
      end;
   if glsp[1,i] < glsp[1,i-1] then do;
      glsp[1,i] = glsp[1,i-1];
      stdgls[i,1] = stdgls[i-1,1];
      end;
end;

adjpsmpl = smplp`;
adjpcv = cvp`;
adjpgls = glsp`;
adjp=adjpgls;
SEAdjp = stdgls#(stdgls>.00000001);
end;

bonbig = des#(bon*j(1,k,1));
bonp = bonbig[<>,];
bonmult = bonp`/pvalsord;

do i = 2 to k;
   if bonp[1,i] < bonp[1,i-1] then bonp[1,i] = bonp[1,i-1];
   end;

rawp = pvalsord;
estimate = EstCont[ir,];
if side ="U" then estimate=-estimate;
stderr = SECont[ir,];
contrast = cord;
if side = "U" then contrast=-contrast;
adjpbon = bonp`;
adjpbon = (adjpbon<1)#adjpbon +(adjpbon>=1);

if &nsamp>0 then do;
   outres =   origord
            ||contrast
            ||estimate
            ||stderr
            ||rawp
            ||bonmult
            ||adjpbon
            ||adjp
            ||SEAdjp;
   create SimTestOut var (    "OrigOrd"
                         ||("Est1":"Est&g")
                         ||"Estimate"
                         ||"StdErr"
                         ||"RawP"
                         ||"BonMult"
                         ||"BonP"
                         ||"AdjP"
                         ||"SEAdjP");
   append from outres;
   end;
else do;
   outres =   origord
            ||contrast
            ||estimate
            ||stderr
            ||rawp
            ||bonmult
            ||adjpbon;
   create SimTestOut var (    "OrigOrd"
                         ||("Est1":"Est&g")
                         ||"Estimate"
                         ||"StdErr"
                         ||"RawP"
                         ||"BonMult"
                         ||"BonP");
   append from outres;
   end;

create labels from clabord; append from clabord;

data SimTestOut; merge SimTestOut labels;
   rename col1=Contrast;
proc sort data=SimTestOut out=SimTestOut; by origord;
data SimTestOut; set SimTestOut; drop origord;
   run;

%if (^%index(%upcase(&options),NOPRINT)) %then %do;

proc template;
delete MCBook.SimTests;
define table MCBook.SimTests;
   column Contrast Estimate StdErr RawP BonP AdjP SEAdjP;

   define header h1;
      spill_margin;
%if (%upcase(&type) = LOGICAL) %then %do;
      text "Logically Constrained (Restricted Combinations) Step-Down Tests";
   %end;
%else %do;
      text "Unconstrained (Free Combinations) Step-Down Tests";
   %end;
%if (^&ANORM) %then %do;
      space=1;
%end;
      end;
%if (&ANORM) %then %do;
   define header h2;
      text "Asymptotic Normal Approximations";
      space=1;
      end;
%end;

   define column Contrast;
      header="Contrast";
      end;
   define column Estimate;
      header="Estimate"       format=D8. space=1;
      translate _val_ = ._ into '';
      end;
   define column StdErr;
      header="Standard Error" format=D8.;
      translate _val_ = ._ into '';
      end;

   %if (&nsamp) %then %let LastPValCol = AdjP;
   %else              %let LastPValCol = BonP;

   %if (&side = B) %then %do;
      define header ProbtHead;
         text " Pr > |t| ";
         start=Rawp end=&LastPValCol just=c expand='-';
         end;
      %end;
   %else %if (&side = L) %then %do;
      define header ProbtHead;
         text " Pr < t ";
         start=Rawp end=&LastPValCol just=c expand='-';
         end;
      %end;
   %else %do;
      define header ProbtHead;
         text " Pr > t ";
         start=Rawp end=&LastPValCol just=c expand='-';
         end;
      %end;

   define column RawP;
      space=1 glue=10
      parent=Common.PValue header="Raw";
      translate _val_ = ._ into '';
      end;
   define column BonP;
      space=1 glue=10
      parent=Common.PValue header="Bon";
      translate _val_ = ._ into '';
      end;
   define column AdjP;
      parent=Common.PValue header="Adj";
      translate _val_ = ._ into '';
      end;

   define column SEAdjP;
      header="SE(AdjP)" format=d8.;
      translate _val_ = ._ into '';
      end;

   end;
run;

data _null_; set SimTestOut;
   file print ods=(template='MCBook.SimTests');
   put _ods_;
   run;

%end;

options notes;

%mend;




/* The %RomEx Macro */

/* This macro computes exact discrete tests using Rom's (1992) method. */


/*---------------------------------------------------------------*/
/* Name:      RomEx                                              */
/* Title:     Rom exact discrete multiple comparison procedure   */
/* Author:    Chung-Kuei Chang, prosof@prosof.com                */
/* Reference: Rom, D. M. (1992). Strengthening some common       */
/*              multiple test procedures for discrete data.      */
/*              Statistics in Medicine, 11, 511-514.             */
/* Release:   Version 6.11                                       */
/*---------------------------------------------------------------*/
/* Input:                                                        */
/*                                                               */
/*   The following arguments are required and must be in this    */
/*   order.                                                      */
/*                                                               */
/*     - the tail of the test 1-lower, 2-upper, 3-two-sided      */
/*     - the SAS data set containing the data to be analyzed     */
/*     - the SAS data set containing the number of endpoints and */
/*       number of treatments.                                   */  
/*                                                               */
/* Output:                                                       */
/*                                                               */
/*   The output dataset contains one observation for each        */
/*   P-value in the dataset.  The output dataset contains the    */
/*   following variables:                                        */
/*                                                               */
/*         i    - The index of the ordered P-value               */
/*                                                               */
/*  ENDPOINT    - The index of the corresponding endpoint        */
/*                                                               */
/*   P_VALUE    - The Fisher Exact P-value for the endpoint      */
/*                                                               */
/*      ADJP    - The P-value for the global null hypothesis     */
/*---------------------------------------------------------------*/

%MACRO ROMEX(TAIL, dsdat, dspar);
%let con=1e-10;
%GLOBAL ADJP;
DATA PAR;
 SET &DSPAR;
 DIGNEP=INT(LOG10(NEP))+1;
 DIGNT=INT(LOG10(NT))+1;
 CALL SYMPUT('DIGNEP',DIGNEP);
 CALL SYMPUT('DIGNT',DIGNT);
proc print;
run;
RUN;

DATA PAR;
 KEEP NEP NT;
 SET PAR;
 LENGTH TT $&DIGNEP. TG $&DIGNT.;
 TT=NEP;
 TG=NT;
 CALL SYMPUT('TT',TT);
 CALL SYMPUT('TG',TG);
TITLE 'DATA = MULTCOMP.PAR';
RUN;
DATA DISMULEP;
 N=_N_;
 SET &DSDAT END=EOF;
 IF EOF=1 THEN DO;
    CALL SYMPUT('NC', N);
               END;
proc print;
RUN;
title1 'MULTIPLE ENDPOINTS DATA';
title2 ' ';
proc print data=dismulep;
id ep1;
VAR EP2-EP&TT TREAT1-TREAT&TG;
run;

PROC TRANSPOSE DATA=DISMULEP OUT=TEMP1;
 BY N;
 VAR EP1-EP&TT TREAT1-TREAT&TG;
*PROC PRINT;
TITLE 'TEMP1';
RUN;

DATA TEMP1;
 SET TEMP1;
 DROP _NAME_ N;
RUN;

PROC TRANSPOSE DATA=TEMP1 OUT=TEMP2 PREFIX=TAO;
 VAR COL1;
*PROC PRINT DATA=TEMP2;
TITLE 'TEMP2';
RUN;

 %LET NCOLO=%EVAL(&TT+&TG);
 %LET NROW=&NC;
 %LET NCOL=&TG;
 %LET TOT=%EVAL(&NC*&NCOLO);
DATA ZPZ(KEEP=P_VALUE  ENDPOINT);
SET TEMP2;
ARRAY P(&TT);
ARRAY POBS(&TT);
 ARRAY TAO(&NROW,&NCOLO);
 ARRAY Q(&NROW, &NCOL);
 ARRAY MINM(&NROW, &NCOL);
 ARRAY C(&NCOL);
 ARRAY R(&NROW);
 ARRAY NN(&TT,2,&TG);
ARRAY    BR{&NCOL};
ARRAY    BC{&NROW};
ARRAY CY{&NROW,&NCOL   };
ARRAY RY{&NROW,&NCOL   };
ARRAY SR(2);
ARRAY SRY(2,&TG);
ARRAY SMINM(&TG);
%MACRO SMTABLE(B);
 DO SJ=&B TO &K;
  IF SJ>1 THEN DO;
   DO SJI=1 TO 2;
    SRY(SJI,SJ)=SRY(SJI,SJ-1)+NN(I,SJI,SJ-1);
   END;
               END;
  MMR=SR(1)-SRY(1,SJ);
  NN(I,1,SJ)=MIN(MMR,C(SJ));
  NN(I,2,SJ)=C(SJ)-NN(I,1,SJ);
  MMR2=SR(2)-SRY(2,SJ);
  MMC=C(SJ)-MMR2;
  SMINM(SJ)=MAX(0,MMC);
 END;
%MEND SMTABLE;

%MACRO SPROB;
 SPP=SFIX;
 DO SI=1 TO 2;
 DO SJ=1 TO &K;
  DO SS=2 TO NN(I,SI,SJ);
   SPP=SPP-LOG(SS);
  END;
 END;
 END;
 SPP=EXP(SPP);
%MEND SPROB;

%MACRO TWOXK(K);
 SR(1)=0;
 SR(2)=0;
 STOTAL=TOTAL;
 DO II=1 TO 2;
  DO J=1 TO &K;
   SR(II)=SR(II)+NN(I,II,J);
  END;
 END;

STOBS=0;
EXPMAR=0;
DO K=2 TO &K;
 STOBS=STOBS+(K-1)*NN(I,1,K);
 EXPMAR=EXPMAR+(K-1)*SR(1)*C(K);
END;
EXPMAR=EXPMAR/TOTAL;
DISOBS=ABS(STOBS-EXPMAR);
SFIX=0;
DO J=1 TO 2;
 DO S=2 TO SR(J);
  SFIX=SFIX+LOG(S);
 END;
END;
DO K=1 TO &K;
 DO S=2 TO C(K);
  SFIX=SFIX+LOG(S);
 END;
END;
DO S=2 TO STOTAL;
 SFIX=SFIX-LOG(S);
END;

SRY(1,1)=0;
SRY(2,1)=0;
P_VALUE=0;
%SMTABLE(1)
* N_TABLE=0;
DO UNTIL (NN(I,1,1)<SMINM(1));
DO UNTIL (NN(I,1,&K-1)<SMINM(&K-1));
STPRO=0;
DO SI=2 TO &K;
 STPRO=STPRO+(SI-1)*NN(I,1,SI);
END;
DISPRO=ABS(STPRO-EXPMAR);
%IF &TAIL=1 %THEN %DO;
    IF STPRO-STOBS<&con THEN DO;  %END;
%ELSE %IF &TAIL=2 %THEN %DO;
    IF STPRO-STOBS>-&con THEN DO;  %END;
%ELSE %IF &TAIL=3 %THEN %DO;
    IF DISPRO-DISOBS>-&con THEN DO;  %END;
 %SPROB
 P_VALUE=P_VALUE+SPP;
                                                 END;
 NN(I,1,&K-1)=NN(I,1,&K-1)-1;
 NN(I,2,&K-1)=NN(I,2,&K-1)+1;
 NN(I,1,&K)=NN(I,1,&K)+1;
 NN(I,2,&K)=NN(I,2,&K)-1;
END;***************FOR DO UNTIL;
IF &K>2 THEN DO;
U=(&K-1);
DO UNTIL (NN(I,1,1)<SMINM(1) OR NN(I,1,U)>=SMINM(U));
 U=U-1;
 NN(I,1,U)=NN(I,1,U)-1;
 IF NN(I,1,U)>=SMINM(U) THEN DO;
  NN(I,2,U)=NN(I,2,U)+1;
  U=U+1;
  %SMTABLE(U)
                             END;
END;
END;
END;******************* FOR THE DO UNTIL REPLACING SSTART;
%MEND TWOXK;

  DO I=1 TO &NROW; R(I)=0;END;
  DO J=1 TO &NCOL; C(J)=0;END;
TOTAL=0;
    DO I=1 TO &NROW;
    DO J=1 TO &NCOLO;
    IF J>&TT THEN DO;
     Q(I,J-&TT)=TAO(I,J);
     R(I)=R(I)+TAO(I,J);
     C(J-&TT)=C(J-&TT)+TAO(I,J);
     TOTAL=TOTAL+TAO(I,J);
                  END;
    END;
    END;

  BR(&NCOL)=0;
  BC(&NROW)=0;
    DO I=(&NCOL-1) TO 1 BY -1;
      BR(I)=BR(I+1)+C(I+1);
    END;
    DO I=(&NROW-1) TO 1 BY -1;
      BC(I)=BC(I+1)+R(I+1);
    END;

 DO I=1 TO &TT;
  DO J=1 TO &TG;
   NN(I,1,J)=0;
   DO K=1 TO &NC;
    IF TAO(K,I)=1 THEN NN(I,1,J)=NN(I,1,J)+Q(K,J);
   END;
   NN(I,2,J)=C(J)-NN(I,1,J);
  END;
  %TWOXK(&TG)
  ENDPOINT=I;
  OUTPUT ZPZ;
 IF I=1 THEN POBS(I)=P_VALUE;
 ELSE DO;
   LE=0;
   DO B=1 TO (I-1);
     IF P_VALUE-POBS(B)<&con THEN DO;
        DO CC=(I-1) TO B BY -1;
           POBS(CC+1)=POBS(CC);
        END;
     POBS(B)=P_VALUE;
     LE=1;
     GOTO ORDER;
                                                            END;
   END;
ORDER: ;
   IF LE=0 THEN POBS(I)=P_VALUE;
      END;
 END;

 FIX=0;
 DO I=1 TO &NROW;
DO S=2 TO R(I);  FIX=FIX+LOG(S);  END;
 END;
 DO J=1 TO &NCOL;
DO S=2 TO C(J);  FIX=FIX+LOG(S);  END;
 END;
DO S=1 TO TOTAL;
 FIX=FIX-LOG(S);
END;
DO S=1 TO &NROW; RY(S,1)=0;END;
DO S=1 TO &NCOL; CY(1,S)=0;END;

%MACRO MTABLE(A,B);
   DO II=&A TO &NROW;
   DO JJ=1 TO &NCOL;
    IF (II>&A OR JJ>=&B) THEN DO;
    IF (JJ=&NCOL AND II<&NROW) THEN DO;
       Q(II,JJ)=R(II)-RY(II,&NCOL-1)-Q(II,&NCOL-1);
      IF II>1 THEN CY(II,JJ)=CY(II-1,JJ)+Q(II-1,JJ);
                                    END;
    IF II=&NROW THEN DO;
       IF JJ<&NCOL THEN Q(II,JJ)=C(JJ)-CY(II-1,JJ)-Q(II-1,JJ); ELSE DO;
        LAST=R(&NROW);
        DO S=1 TO (&NCOL-1);
          LAST=LAST-Q(&NROW,S);
        END;
          Q(&NROW,&NCOL)=LAST;                                     END;
                     END;
    IF (II<&NROW AND JJ<&NCOL) THEN DO;
     IF II>1 THEN CY(II,JJ)=CY(II-1,JJ)+Q(II-1,JJ);
     IF JJ>1 THEN RY(II,JJ)=RY(II,JJ-1)+Q(II,JJ-1);
                  MMR=R(II)-RY(II,JJ);
                  MMC=C(JJ)-CY(II,JJ);
                Q(II,JJ)=MIN(MMR,MMC);
        MXR=MMR-BR(JJ);
       IF II>1 THEN DO;
        DO L=(JJ+1) TO &NCOL;
         MXR=MXR+CY(II-1,L)+Q(II-1,L);
        END;        END;
        MXC=MMC-BC(II);
        MINM(II,JJ)=MAX(0,MXR,MXC);
                                    END;
                              END;
   END;
   END;
%MEND MTABLE;
%MACRO PROB;
 PP=FIX;
  DO II=1 TO &NROW;
  DO J=1 TO &NCOL;
DO S=2 TO Q(II,J);  PP=PP-LOG(S);  END;
  END;
  END;
     PP=EXP(PP);
%MEND PROB;

%MTABLE(1,1)
P_ONESID=0; N_TABLE=0;
N_TABLE=N_TABLE+1;
START: ;
DO UNTIL (Q(&NROW-1,&NCOL-1)<MINM(&NROW-1,&NCOL-1));
 DO I=1 TO &TT;
  DO J=1 TO &TG;
   NN(I,1,J)=0;
   DO K=1 TO &NC;
    IF TAO(K,I)=1 THEN NN(I,1,J)=NN(I,1,J)+Q(K,J);
   END;
   NN(I,2,J)=C(J)-NN(I,1,J);
  END;
  %TWOXK(&TG)
 IF P_VALUE-POBS(1)<-&con THEN DO;
    P(1)=P_VALUE;
    GOTO CALP;
                                                          END;

ELSE DO;
 IF I=1 THEN P(I)=P_VALUE;
 ELSE DO;
   LE=0;
   DO B=1 TO (I-1);
     IF P_VALUE-P(B)<&con THEN DO;
        DO CC=(I-1) TO B BY -1;
           P(CC+1)=P(CC);
        END;
      P(B)=P_VALUE;
      LE=1;
      GOTO ORDER2;
                                                         END;
   END;
   IF LE=0 THEN P(I)=P_VALUE;
ORDER2: ;
      END;

 IF P(1)-POBS(1)<-&con THEN GOTO CALP;
ELSE IF I<&TT THEN DO;
 IF P(1)-POBS(1)>&con THEN GOTO NEXTI;
 ELSE IF ABS(P(1)-POBS(1))<&con THEN DO;
           DO B=2 TO I;
      IF P(B)-POBS(B)>&con THEN GOTO NEXTI;
      ELSE IF P(B)-POBS(B)<-&con THEN GOTO CALP;
      ELSE IF (ABS(P(B)-POBS(B))<&con AND I<&TT)
              THEN GOTO NEXTI;
      ELSE IF (ABS(P(B)-POBS(B))<&con AND I=&TT)
              THEN GOTO CALP;
           END;
                                                              END;
                   END;
ELSE IF I=&TT THEN DO;
 IF P(1)-POBS(1)>&con THEN GOTO SKIP;
 ELSE IF ABS(P(1)-POBS(1))<&con THEN DO;
           DO B=2 TO I;
      IF P(B)-POBS(B)>&con THEN GOTO SKIP;
      ELSE IF P(B)-POBS(B)<-&con THEN GOTO CALP;
      ELSE IF (ABS(P(B)-POBS(B))<&con AND B<&TT)
              THEN GOTO NEXTB;
      ELSE IF (ABS(P(B)-POBS(B))<&con AND B=&TT)
              THEN GOTO CALP;
           NEXTB: ;
           END;
                                                              END;
                   END;
     END;
NEXTI: ;
END;
 GOTO SKIP;
 CALP: ;
  %PROB
 P_ONESID=P_ONESID+PP;
SKIP:;
Q(&NROW-1,&NCOL-1)=Q(&NROW-1,&NCOL-1)-1;
Q(&NROW-1,&NCOL)=Q(&NROW-1,&NCOL)+1;
Q(&NROW,&NCOL-1)=Q(&NROW,&NCOL-1)+1;
Q(&NROW,&NCOL)=Q(&NROW,&NCOL)-1;
END;
 DO I=&NROW-1 TO 1 BY -1;
 DO J=&NCOL-1 TO 1 BY -1;
   IF (I<&NROW-1 OR J<&NCOL-1) THEN DO;
  Q(I,J)=Q(I,J)-1;
  IF Q(1,1)<MINM(1,1) THEN GOTO FINISH;
  IF Q(I,J)>=MINM(I,J) THEN DO;
    J=J+1;
    %MTABLE(I,J)
    GOTO START;
                             END;
                                     END;
 END;
 END;
FINISH: ;
CALL SYMPUT('ADJP', P_ONESID);
RUN;

PROC SORT DATA=ZPZ OUT=ZPZ;
 BY P_VALUE;
RUN;

TITLE1 ' ';
title2 'ROM DISCRETE MULTIPLE ENDPOINTS ANALYSIS';
title3 ' ';
title4 ' ';
title5 ' ';
DATA _NULL_;
 FILE PRINT;
 SET ZPZ END=EOF;
 ADJP=&ADJP;
 I=_N_;
 IF _N_=1 THEN DO;
  PUT @18 'I'  @28 'ENDPOINT'           @57 'P-VALUE*';
  PUT @15 51*'-';
               END;
  PUT @18  I   @24 ENDPOINT 8.                @55 P_VALUE 8.4;
 IF EOF=1 THEN DO;
  PUT @15 51*'-';
  PUT @18  'EXACT ADJUSTED P-VALUE' @55 ADJP 8.4;
  PUT ///;
%IF &TAIL=1 %THEN %DO;
  PUT @18 '*: P-VALUE FOR LOWER-TAILED TREND';   %END;
%ELSE %IF &TAIL=2 %THEN %DO;
  PUT @18 '*: P-VALUE FOR UPPER-TAILED TREND';   %END;
%IF &TAIL=3 %THEN %DO;
  PUT @18 '*: P-VALUE FOR TWO-TAILED TREND';   %END;

               END;
 RUN;
%MEND ROMEX;



/* The %RomMC Macro */

/* This macro simulates discrete tests using Rom's (1992) method. */


/*---------------------------------------------------------------*/
/* Name:      RomMc                                              */
/* Title:     Rom Monte-Carlo discrete multiple comparison       */
/*            procedure                                          */
/* Author:    Chung-Kuei Chang, prosof@prosof.com                */
/* Reference: Rom, D. M. (1992). Strengthening some common       */
/*              multiple test procedures for discrete data.      */
/*              Statistics in Medicine, 11, 511-514.             */
/* Release:   Version 6.11                                       */
/*---------------------------------------------------------------*/
/* Input:                                                        */
/*                                                               */
/*   The following arguments are must be in this order.          */
/*                                                               */
/*     - the tail of the test 1-lower, 2-upper, 3-two-sided      */
/*     - the SAS data set containing the data to be analyzed     */
/*     - the SAS data set containing the number of endpoints and */
/*       number of treatments.                                   */
/*     - the SAS data set containing the number of Monte-Carlo   */
/*       samples.                                                */  
/*                                                               */
/* Output:                                                       */
/*                                                               */
/*   The output dataset contains one observation for each        */
/*   P-value in the dataset.  The output dataset contains the    */
/*   following variables:                                        */
/*                                                               */
/*         i    - The index of the ordered P-value               */
/*                                                               */
/*  ENDPOINT    - The index of the corresponding endpoint        */
/*                                                               */
/*   P_VALUE    - The Fisher Exact P-value for the endpoint      */
/*                                                               */
/*      ADJP    - The P-value for the global null hypothesis     */
/*                                                               */
/*       L95    - The lower limit of the confidence interval for */
/*                  the P-value                                  */
/*                                                               */
/*       U95    - The upper limit of the confidence interval for */
/*                  the P-value                                  */
/*---------------------------------------------------------------*/

%MACRO ROMMC(TAIL, dsdat, dspar, dsnmc);
%let con=1e-10;
%GLOBAL ADJP MM L95 U95;
%MACRO ZSCORE(K);
 SR(1)=0; ******************* SUM OF THE ELEMENTS IN THE FIRST ROW;
 SR(2)=0; ******************* SUM OF THE ELEMENTS IN THE SECOND ROW;
          ******************* C(J) IS THE JTH COLUMN SUM;
 STOTAL=TOTAL;
 DO II=1 TO 2;
  DO J=1 TO &K;
   SR(II)=SR(II)+NN(I,II,J);
  END;
 END;
TOBS=0;
EXPMAR=0;
UR2=SR(1);
U2=(SR(1)**2)/TOTAL;
VC2=0;
V2=0;
DO K=2 TO &K;
 TOBS=TOBS+(K-1)*NN(I,1,K);
 EXPMAR=EXPMAR + SR(1)*C(K-1)*(K-1);
 VC2=VC2+(K-1)**2*C(K);
 V2=V2+(K-1)*C(K);
END;
EXPMAR=EXPMAR/TOTAL;
V2=V2**2/TOTAL;
VAR=(UR2-U2)*(VC2-V2)/(TOTAL-1);
IF VAR>0 THEN DO;
Z=(TOBS-EXPMAR)/VAR**0.5;
PVAL=PROBNORM(Z);
%IF &TAIL=1 %THEN %DO; PZ=PVAL;  %END;
%ELSE %IF &TAIL=2 %THEN %DO; PZ=1-PVAL; %END;
%ELSE %IF &TAIL=3 %THEN %DO; PZ=2*MIN(PVAL,1-PVAL); %END;
P_VALUE=PZ;
              END;
ELSE PZ=1;
%MEND ZSCORE;

DATA N_SAMPLE;
 SET &DSNMC;
 IF SEED=. THEN SEED=0;
CALL SYMPUT('MM',N_SAMPLE);
CALL SYMPUT('SEED',SEED);
RUN;

DATA PAR;
 SET &DSPAR;
 DIGNEP=INT(LOG10(NEP))+1;
 DIGNT=INT(LOG10(NT))+1;
 CALL SYMPUT('DIGNEP',DIGNEP);
 CALL SYMPUT('DIGNT',DIGNT);
RUN;

DATA PAR;
 KEEP NEP NT;
 SET PAR;
 LENGTH TT $&DIGNEP. TG $&DIGNT.;
 TT=NEP;
 TG=NT;
 CALL SYMPUT('TT',TT);
 CALL SYMPUT('TG',TG);
TITLE 'DATA = MULTCOMP.PAR';
RUN;
DATA DISMULEP;
 SET &DSDAT END=EOF;
 N=_N_;
 IF EOF=1 THEN DO;
    CALL SYMPUT('NC', N);
               END;
RUN;

PROC TRANSPOSE DATA=DISMULEP OUT=TEMP1;
 BY N;
 VAR EP1-EP&TT TREAT1-TREAT&TG;
TITLE 'TEMP1';
RUN;

DATA TEMP1;
 SET TEMP1;
 DROP _NAME_ N;
RUN;
title1 'MULTIPLE ENDPOINTS DATA';
title2 ' ';
proc print data=dismulep;
id ep1;
 VAR EP2-EP&TT TREAT1-TREAT&TG;
 run;
PROC TRANSPOSE DATA=DISMULEP OUT=TEMP1;
 BY N;
 VAR EP1-EP&TT TREAT1-TREAT&TG;
RUN;

PROC TRANSPOSE DATA=TEMP1 OUT=TEMP2 PREFIX=TAO;
 VAR COL1;
RUN;

 %LET NCOLO=%EVAL(&TT+&TG);
 %LET NROW=&NC;
 %LET NCOL=&TG;
 %LET TOT=%EVAL(&NC*&NCOLO);

DATA TEMP2;
 SET TEMP2;
 ARRAY TAO(&NROW,&NCOLO);
 ARRAY Q(&NROW, &NCOL);
 ARRAY C(&NCOL);
 ARRAY R(&NROW);
  DO I=1 TO &NROW; R(I)=0;END;
  DO J=1 TO &NCOL; C(J)=0;END;
TOTAL=0;
    DO I=1 TO &NROW;
    DO J=1 TO &NCOLO;
    IF J>&TT THEN DO;
     Q(I,J-&TT)=TAO(I,J);
     R(I)=R(I)+TAO(I,J);
     C(J-&TT)=C(J-&TT)+TAO(I,J);
     TOTAL=TOTAL+TAO(I,J);
                  END;
    END;
    END;
CALL SYMPUT('N',TOTAL);
RUN;


DATA ZPZ(KEEP= P_VALUE ENDPOINT);
SET TEMP2;
TRIAL=&MM;

%MACRO SMTABLE(B);
 DO SJ=&B TO &K;
  IF SJ>1 THEN DO;
   DO SJI=1 TO 2;
    SRY(SJI,SJ)=SRY(SJI,SJ-1)+NN(I,SJI,SJ-1);
   END;
               END;
  MMR=SR(1)-SRY(1,SJ);
  NN(I,1,SJ)=MIN(MMR,C(SJ));
  NN(I,2,SJ)=C(SJ)-NN(I,1,SJ);
  MMR2=SR(2)-SRY(2,SJ);
  MMC=C(SJ)-MMR2;
  SMINM(SJ)=MAX(0,MMC);
 END;
%MEND SMTABLE;

%MACRO SPROB;
 SPP=SFIX;
 DO SI=1 TO 2;
 DO SJ=1 TO &K;
  DO SS=2 TO NN(I,SI,SJ);
   SPP=SPP-LOG(SS);
  END;
 END;
 END;
 SPP=EXP(SPP);
%MEND SPROB;


 ARRAY TAO(&NROW,&NCOLO);
 ARRAY Q(&NROW, &NCOL);
 ARRAY MINM(&NROW, &NCOL);
 ARRAY C(&NCOL);
 ARRAY R(&NROW);
 ARRAY NN(&TT,2,&TG);
ARRAY    BR{&NCOL};
ARRAY    BC{&NROW};
ARRAY SR(2);
ARRAY SRY(2,&TG);
ARRAY SMINM(&TG);

ARRAY P(&TT);
ARRAY POBS(&TT);
ARRAY CY{&NROW,&NCOL   };
***CY(I,J)=Q(1,J)+Q(2,J)+...+Q(I-1,J);
ARRAY RY{&NROW,&NCOL   };
***RY(I,J)=Q(I,1)+Q(I,2)+...+Q(I,J-1);

ARRAY acumr(&NROW);
ARRAY acumc(&NCOL);
      acumr(1)=R(1);
      acumc(1)=C(1);
DO I=2 TO &NROW;
  acumr(I)=acumr(I-1)+R(I);
END;
DO I=2 TO &NCOL;
  acumc(I)=acumc(I-1)+C(I);
END;

  BR(&NCOL)=0;
  BC(&NROW)=0;
    DO I=(&NCOL-1) TO 1 BY -1;
      BR(I)=BR(I+1)+C(I+1);
    END;
    DO I=(&NROW-1) TO 1 BY -1;
      BC(I)=BC(I+1)+R(I+1);
    END;
 DO I=1 TO &TT;
  DO J=1 TO &TG;
   NN(I,1,J)=0;
   DO K=1 TO &NC;
    IF TAO(K,I)=1 THEN NN(I,1,J)=NN(I,1,J)+Q(K,J);
   END;
   NN(I,2,J)=C(J)-NN(I,1,J);
  END;
/* %TWOXK(&TG)  */
%ZSCORE(&TG)
ENDPOINT=I;
OUTPUT ZPZ;
 IF I=1 THEN POBS(I)=P_VALUE;
 ELSE DO;
   LE=0;
   DO B=1 TO (I-1);
     IF P_VALUE-POBS(B)<&con THEN DO;
        DO CC=(I-1) TO B BY -1;
           POBS(CC+1)=POBS(CC);
        END;
     POBS(B)=P_VALUE;
     LE=1;
     GOTO ORDER;
                                                            END;
   END;
ORDER: ;
   IF LE=0 THEN POBS(I)=P_VALUE;
      END;
 END;

ADJP=0;
N_TABLE=0;
ARRAY XX(&N);
ARRAY YY(&N);
DO KL=1 TO &MM;
DO I=1 TO &N;
  XX(I)=I;
END;
DO I=1 TO &N;
 RR=0;
  YY(I)=XX(INT((&N+1-I)*RANUNI(&SEED)+1));
 J=0;
 DO UNTIL (RR>0);
  J=J+1;
  IF XX(J)=YY(I) THEN RR=J;
  END;
  DO J=RR TO (&N-I);
   XX(J)=XX(J+1);
  END;
END;
DO I=1 TO &NROW;
 IF I=1 THEN RMIN=0;ELSE RMIN=acumr(I-1);
 RMAX=acumr(I)+1;
 DO J=1 TO &NCOL;
  Q(I,J)=0;
  IF J=1 THEN CMIN=1;ELSE CMIN=acumc(J-1)+1;
  CMAX=acumc(J);
  DO KK=CMIN TO CMAX;
   IF RMIN<YY(KK)<RMAX THEN Q(I,J)=Q(I,J)+1;
  END;
 END;
END;

EQUAL='NO ';
   DO I=1 TO &TT;
     DO J=1 TO &TG;
        NN(I,1,J)=0;
        DO K=1 TO &NC;
           IF TAO(K,I)=1 THEN NN(I,1,J)=NN(I,1,J)+Q(K,J);
        END;
        NN(I,2,J)=C(J)-NN(I,1,J);
     END;
/*     %TWOXK(&TG)    */
%ZSCORE(&TG)
  IF I=1 THEN P(1)=P_VALUE;
 IF P_VALUE-POBS(1)<-&con THEN DO;
    P(1)=P_VALUE;
    ADJP=ADJP+1;
    GOTO NEXTKL;                           END;
 ELSE IF ABS(P_VALUE-POBS(1))<&con THEN DO;
EQUAL='YES';
     IF &TT=1 THEN DO; ADJP=ADJP+1; GOTO NEXTKL; END;
     ELSE IF &TT>1 AND I>1 THEN DO;
          DO CC=(I-1) TO 1 BY -1;
             P(CC+1)=P(CC);
          END;
          P(1)=P_VALUE;
          DO CC=2 TO I;
           IF P(CC)-POBS(CC)<-&con
            OR (ABS(P(CC)-POBS(CC))<&con AND CC=&TT)
                THEN DO; ADJP=ADJP+1; GOTO NEXTKL; END;
           ELSE IF P(CC)-POBS(CC)>&con THEN GOTO NEXTI;
          END;
                                  END;
                                                          END;
 ELSE IF P_VALUE-POBS(1)>&con THEN DO;
      IF &TT=1 THEN GOTO NEXTI;
      ELSE IF &TT>1 AND I>1 THEN DO;
   LE=0;
   DO B=1 TO (I-1);
     IF P_VALUE-P(B)<&con THEN DO;
        DO CC=(I-1) TO B BY -1;
           P(CC+1)=P(CC);
        END;
      P(B)=P_VALUE;
      LE=1; ********THE P_VALUE IS LESS THAN ONE OF THE PREVIOUS ONES.;
      GOTO ORDER2;
                                                       END;
                                   END;
   END;
   IF LE=0 THEN P(I)=P_VALUE;
ORDER2: ;
     IF EQUAL='YES' THEN DO;
          DO CC=1 TO I;
           IF P(CC)-POBS(CC)<-&con
            OR (ABS(P(CC)-POBS(CC))<&con AND CC=&TT)
                THEN DO; ADJP=ADJP+1; GOTO NEXTKL; END;
           ELSE IF P(CC)-POBS(CC)>&con THEN GOTO NEXTI;
          END;
                         END;
                                                           END;
NEXTI: ;
END;  ************************* END FOR I;
NEXTKL: ;
END;  ************************* END FOR KL;
ADJP=ADJP/&MM;
L95=MAX(0,ADJP-PROBIT(.975)*(ADJP*(1-ADJP)/&MM)**.5);
U95=MIN(1,ADJP+PROBIT(.975)*(ADJP*(1-ADJP)/&MM)**.5);
CALL SYMPUT('ADJP', ADJP);
CALL SYMPUT('L95', L95);
CALL SYMPUT('U95', U95);
RUN;

PROC SORT DATA=ZPZ OUT=ZPZ;
 BY P_VALUE;
*PROC PRINT;
RUN;

title1 ' ' ;
TITLE2 'ROM DISCRETE MULTIPLE ENDPOINTS ANALYSIS';
title3 ' ';
TITLE4 ' ';
title5 ' ';
DATA _NULL_;
 FILE PRINT;
 SET ZPZ END=EOF;
 ADJP=&ADJP;
 L95=&L95;
 U95=&U95;
 I=_N_;
 MM=&MM;
 IF _N_=1 THEN DO;
  PUT @18 'I'  @28 'ENDPOINT'           @57 'P-VALUE*';
  PUT @15 51*'-';
               END;
  PUT @18  I   @24 ENDPOINT 8.                @55 P_VALUE 8.4;
 IF EOF=1 THEN DO;
  PUT @15 51*'-';
  PUT @18  'MONTE CARLO GLOBAL P-VALUE' @55 ADJP 8.4;
  PUT @18  '95% CONFIDENCE INTERVAL'
            @54 '(' @55 L95 8.4  @63 ',' @63 U95 8.4 @72 ')';
  PUT @18  'NUMBER OF SAMPLES' @50 MM 8.;
  PUT //;
%IF &TAIL=1 %THEN %DO;
  PUT @18 '*: ASYMPTOTIC P-VALUE FOR LOWER-TAILED TREND'; %END;
%ELSE %IF &TAIL=2 %THEN %DO;
  PUT @18 '*: ASYMPTOTIC P-VALUE FOR UPPER-TAILED TREND'; %END;
%ELSE %IF &TAIL=3 %THEN %DO;
  PUT @18 '*: ASYMPTOTIC P-VALUE FOR TWO-TAILED TREND';   %END;
               END;
RUN;
%MEND ROMMC;


/* The %BayesIntervals Macro */

/* This macro computes Bayesian simultaneous confidence intervals. */


/*---------------------------------------------------------------*/
/* Name:      BayesIntervals                                     */
/* Title:     Bayesian simultaneous intervals based on           */
/*            percentiles                                        */
/* Author:    Russell D. Wolfinger, sasrdw@sas.com               */
/* Release:   Version 6 or later                                 */
/*---------------------------------------------------------------*/
/* Inputs:                                                       */
/*                                                               */
/*    data=   data set representing a sample from the            */
/*            posterior distribution (required)                  */
/*                                                               */
/*    vars=   the variables in the data set for which to compute */
/*            simultaneous intervals (required)                  */
/*                                                               */
/*    alpha=  the joint significance level, default=0.05         */
/*                                                               */
/*    tail=   the tail type of the intervals, must be L, U, or   */
/*            2, default=2                                       */
/*                                                               */
/*    maxit=  maximum number of iterations in the search,        */
/*            default=50                                         */
/*                                                               */
/*    tol=    convergence tolerance, default=0.001               */
/*                                                               */
/* Output:                                                       */
/*                                                               */
/*    The macro begins by computing the joint coverage of the    */
/*    naive unadjusted alpha-level intervals, computed as        */
/*    percentiles across the sample.  It then decreases alpha    */
/*    using a bisection search until the joint coverage comes    */
/*    within the tol= value of alpha.  A history of this search  */
/*    is printed and then the simultaneous intervals.            */  
/*                                                               */
/*---------------------------------------------------------------*/

%macro BayesIntervals(data=,vars=,alpha=.05,tail=2,maxit=50,tol=0.001);

 options nonotes;
 %if %bquote(&data)= %then %let data=&syslast;

 /*---do bisection search to find adjusted alpha---*/
 %let lowera = 0;
 data _null_;
    uppera = &alpha * 2;
    call symput('uppera',uppera);
 run;
 %let iter = 0;

 %put %str(        )The BayesIntervals Macro;
 %put;
 %put Iteration    Alpha          Coverage;

 %do %while(&iter < &maxit);

    /*---compute quantiles---*/
    data _null_;
       alf = (&lowera + &uppera)/2;
       %if (&tail = 2) %then %do;
          lowerp = 100 * alf/2;
          upperp = 100*(1 - alf/2);
       %end;
       %else %if (&tail = L) %then %do;
          lowerp = 100 * alf;
          upperp = 100;
       %end;
       %else %do;
          lowerp = 0;
          upperp = 100*(1 - alf);
       %end;
       call symput('alf',left(alf));
       call symput('lowerp',left(lowerp));
       call symput('upperp',left(upperp));
    run;
  
    proc univariate data=&data pctldef=1 noprint;
       var &vars;
       output pctlpts=&lowerp,&upperp pctlpre=&vars pctlname=l u out=p;
    run;
  
    proc transpose data=p out=pt;
    run;
  
    /*---load limits and variable names into macro variables---*/
    data _null_;
       set pt nobs=count end=last;
       retain i 0;
       if (mod(_n_,2)=1) then do;
          i = i + 1;
          mname = "v" || left(put(i,8.));      
          len = length(_NAME_);
          vname = substr(_NAME_,1,len-1);
          call symput(mname,left(vname));
          mname = "lv" || left(put(i,8.));      
          call symput(mname,left(put(COL1,best8.)));
       end;
       else do;
          mname = "uv" || left(put(i,8.));      
          call symput(mname,left(put(COL1,best8.)));
       end;
       if last then do;
          call symput('nvar',left(put(count/2,8.)));
       end;
    run;
  
    /*---pass through data and determine simultaneous coverage---*/
    data _null_;
       set &data nobs=no end=last;
       retain count 0;
       bad = 0;
       %do i = 1 %to &nvar;
          if (&&v&i < &&lv&i) or (&&v&i > &&uv&i) then bad = 1;
       %end;
       if (bad = 0) then count = count + 1;
       if last then do;
          coverage = count / no;
          target = 1 - &alpha;
          if (abs(coverage - target) < &tol) then conv = 1;
          else do;
             conv = 0;
             alf = &alf;
             if (coverage < target) then do;
                call symput('uppera',left(alf));
             end;
             else do;
                call symput('lowera',left(alf));
             end;
          end;
          call symput('conv',left(conv));
          call symput('coverage',left(coverage));
       end;
    run;

    %let iter = %eval(&iter+1);
    %put  %str(   ) &iter %str(      ) &alf %str(  ) &coverage;
    %if (&conv=1) %then %let iter=&maxit;

 %end;

 options notes;
 %if (&conv=1) %then %do;
    data BayesIntervals;
       %do i = 1 %to &nvar;
          _NAME_ = "&&v&i";
          Lower = &&lv&i;
          Upper = &&uv&i;
          output;
       %end;
    run;
    proc print data=BayesIntervals;
    run;
 %end;
 %else %do;
    %put Did not converge;
 %end;

%mend BayesIntervals;




/* The %BayesTests Macro */

/* This macro computes Bayesian posterior probabilities for a set of */
/* free-combination tests, using Gonen and Westfall's (1998) method. */


/*---------------------------------------------------------------*/
/* Name:      BayesTests                                         */
/* Title:     Multiple tests of hypotheses using Bayesian        */
/*            posterior probabilities                            */
/* Author:    Peter H. Westfall, westfall@ttu.edu,               */
/* Reference: Gonen, M. and Westfall, P.H. (1998).  Bayesian     */
/* multiple testing for multiple endpoints in clinical trials.   */
/* Proceedings of the American Statistical Association,          */
/* Biopharmaceutical Subsection.                                 */
/* Release:   Version 7.01                                       */
/*---------------------------------------------------------------*/
/* Inputs:                                                       */
/*                                                               */
/*   MEANMUZ = The mean vector of the prior distribution for the */
/*             noncentrality parameters of the test statistics,  */
/*             given that they are nonzero. Default is 2.5 2.5.  */
/*                                                               */
/*  SIGMAMUZ = The variance of the prior distribution of the     */
/*             noncentrality parameters (assumed constant),      */
/*             given that the noncentrality parameters are       */
/*             nonzero.  The default is 2.0.                     */
/*                                                               */
/*    You must specify two out of three of the following         */
/*    parameters.  The third will be calculated from the         */
/*    two that you specify.                                      */
/*                                                               */
/*       RHO = The prior correlation (assumed constant) of the   */
/*             prior distribution of the noncentrality           */
/*             parameters (assumed constant), given that the     */
/*             noncentrality parameters are nonzero;  AND ALSO   */
/*             the tetrachoric correlation of the binary         */
/*             outcomes (Hi true, Hj true).                      */
/*                                                               */
/*     Piall = The prior probability that all null hypotheses    */
/*             are true.                                         */
/*                                                               */
/*       Pi0 = The probability that an individual hypothesis     */
/*             is true (assumed identical for all hypotheses)    */
/*                                                               */
/*  Additionally, %BayesTests requires a further macro to be    */
/*  defined that uses SAS/IML to construct the estimates and    */
/*  their covariance, as follows:                               */
/*                                                              */
/*     %Estimate: Uses SAS/IML code to define                   */
/*        EstPar - (column) vector of estimated parameters      */
/*        Cov    - covariance matrix for the for the estimates  */
/*                                                              */
/*  You can either define this macro directly, or use the       */
/*  %MakeGLMStats macro to define it.                           */
/*                                                               */
/* Output:                                                       */
/*                                                               */
/*   The output shows the values of Pi0, PiAll, and Rho (two of  */
/*   which were input and the third calculated.)                 */
/*   The formatted output contains the following variables:      */
/*                                                               */
/* Z Statistic  - The values of the test statistics defined in   */
/*                the %Estimates macro                           */
/*                                                               */
/*  Prior Mean                                                   */
/*  Effect Size - The prior mean of the noncentrality parameter  */
/*                (meanmuz)                                      */
/*                                                               */
/*  Prior Std Dev                                                */
/*  Effect Size - The prior std dev of the noncentrality         */
/*                parameter (sqrt(sigmamuz))                     */
/*                                                               */
/*  Posterior                                                    */
/*  Probability - The probability that the null hypothesis is    */
/*                true, given the data (and the prior inputs)    */
/*                                                               */
/*    Cov1-Covk - The correlation matrix of the test statistics, */
/*                from the %Estimates macro                      */
/*                                                               */
/*---------------------------------------------------------------*/

%macro BayesTests(
              meanmuz  = j(1,k,2.5) ,
              sigmamuz = 2.0        ,
              rho      =            ,
              Piall    =            ,
              Pi0      =            );

proc iml;

%Estimates;
zsample = EstPar`;
sigma   = cov;

%if &rho   ^= %then %let flag1 = 1; %else %let flag1 = 0;
%if &piall ^= %then %let flag2 = 1; %else %let flag2 = 0;
%if &pi0   ^= %then %let flag3 = 1; %else %let flag3 = 0;

%if %eval(&flag1+&flag2+&flag3) ^= 2 %then %do;
   print "Please specify exactly two of the three inputs: rho, PIall, pi0";
   print "The other will be implied by the two you specify";
%end;

k = ncol(zsample);
mu = &meanmuz;
sig2 = &sigmamuz;
pstd = j(k,1,sqrt(sig2));
if ssq(sigma-sigma`)>.0000001 then print "Warning: Asymmetric Cov Matrix";
in = j(1,k,0);

START FUN(Z) GLOBAL(K1,K2,Z0,RHO);
   V1 = SQRT(RHO);
   V2 = SQRT(1-RHO);
   V3 = Z0-V1*Z;
   V4 = PROBNORM(V3/V2);
   V5 = 1 - V4;
   V6 = (1/SQRT(2*3.14159265))*EXP(-(Z**2)/2);
   IF K1 = 0 THEN V = (V4**K2)*V6;
      ELSE IF K2 = 0 THEN V = (V5**K1)*V6;
         ELSE V = (V4**K2)*(V5**K1)*V6;
RETURN(V);
FINISH FUN;

START JPROB(PROB,IN,CRIT,CORR) GLOBAL(K1,K2,Z0,RHO) ;
   Z0 = CRIT;
   RHO = CORR;
   K1 = SUM(IN);
   K2 = NCOL(IN) - K1;
   A   = {.M .P};
   CALL QUAD(PROB,"FUN",A);
FINISH JPROB;

start mnorm(x, mu, sig);
   p = nrow(sig);
   log1 = -(p/2)*log(2*3.14159265);
   log2 = -.5*log(det(sig));
   log3 = -.5*(x-mu)`*inv(sig)*(x-mu);
   log = log1 +log2 + log3;
   f = exp(log);
   return (f);
finish mnorm;

%if &Pi0  = %then %do;
   Piall = &Piall;
   corr   = &rho;
clower = probit(Piall);
cupper = probit(Piall**(1/K));
   CALL JPROB(PROBl,IN,Clower,CORR);
   CALL JPROB(PROBu,IN,Cupper,CORR);
do t = 1 to 50;
   cchk = (clower+cupper)/2;
   call  JPROB(PROBchk,IN,Cchk,CORR);
   if cupper-clower <.0000001 then do;
      Pi0 = probnorm(cchk);
      t=51;
      end;
   if probchk < PIall then clower = cchk;
      else cupper=cchk;
   end;
   crit=cchk;
   call symput('Pi0',char(Pi0));
%end;

%if &rho = %then %do;
   Piall = &Piall;
   Pi0   = &Pi0;
   crit=probit(Pi0);
pilower = pi0**k;
piupper = pi0;

*print "critical value is " crit;
if Piall <= pilower then print "error: PIAll is too low
         or Pi is too high";
if Piall >= piupper then print "error: PIAll is too high
         or Pi is too low";
   Corrl = 0;
   Corru = .999;
   if (Piall > pilower) & (Piall < piupper) then
      do t = 1 to 50;
      corrchk = (corrl+corru)/2;
      call  JPROB(PROBchk,IN,crit,CORRchk);
      if corru-corrl <.0000001 then do;
      corr = corrchk;
              t=51;
              end;
      if probchk < PIAll then corrl = corrchk;
            else corru=corrchk;
       end;
      call symput('Rho',char(corr));
%end;


%if &Piall = %then %do;
   corr =  &rho;
   Pi0   = &Pi0;
   crit=probit(Pi0);
   CALL JPROB(Piall,IN,CRIT,CORR);
   call symput('Piall',char(Piall));
%end;

priprob = j(k,1,Pi0);
call symput('k',char(k));

sumnum = j(k,1,0);
rho1=corr;
sumdenom = 0;
%do ii = 1 %to &k;
   do i&ii = 0 to 1; %end;
   in = i1
%do ii = 2 %to &k;
     ||i&ii %end; ;
      call jprob(prob,in,crit,rho1);
      mean = in#mu;
      cov = sig2*(rho1*in`*in + (1-rho1)*diag(in)) + sigma  ;
      f = mnorm(zsample`, mean` , cov);
%do ii = 1 %to &k;
     if i&ii = 0 then sumnum[&ii] = sumnum[&ii] + prob*f; %end;
 sumdenom = sumdenom + prob*f;
%do ii = 1 %to &k;
   end; %end;
postprob =sumnum/sumdenom;

bf = (postprob/(1-postprob))#((1-priprob)/priprob);



 todata = zsample`||mu`||pstd||postprob||sigma;

 create imlout from todata;
 append from todata;

 quit;

proc print data=imlout noobs label;
    title  "Prior Probability on Individual Nulls is &Pi0";
    title2 "Prior Probability on Joint Null is &Piall";
    title3 "Prior Correlation Between Nulls is &Rho";
        label col1 = 'Z Statistic'
              col2 = 'Prior Mean Effect Size'
              col3 = 'Prior StdDev Effect Size'
              col4 = 'Posterior Probability'
              %do ii = 1 %to &k; %let ii1 = %eval(&ii+4); col&ii1 = Cov&ii %end; ;
run ;
quit;

%mend;



/* The %MCB Macro */

/* This macro computes confidence intervals for Hsu's (1984, 1996) */
/* multiple comparisons with the best. */


/*--------------------------------------------------------------*/
/* Name:      MCB                                               */
/* Title:     Multiple Comparisons with the Best                */
/* Author:    Randy Tobias, sasrdt@sas.com                      */
/* Reference: Hsu, Jason C. (1996).  _Multiple_Comparisons:_    */
/*               _Theory_and_methods_, Chapman & Hall, NY.      */
/* Release:   Version 7.01                                      */
/*--------------------------------------------------------------*/
/* Input:                                                       */
/*                                                              */
/*   The following arguments are required.  They must be the    */
/*   first three arguments and they must be in this order.  Do  */
/*   not use keywords for these arguments.                      */
/*                                                              */
/*     - the SAS data set containing the data to be analyzed    */
/*     - the response variable                                  */
/*     - the grouping variable                                  */
/*                                                              */
/*   The following additional arguments may be listed in any    */
/*   order, separated by commas:                                */
/*                                                              */
/*     MODEL=   a linear model for the response, specified      */
/*              using the effects syntax of GLM.  The default   */
/*              is a one-way model in the required grouping     */
/*              variable.                                       */
/*                                                              */
/*     CLASS=   classification variables involved in the        */
/*              linear model.  The default is the required      */
/*              grouping variable.                              */
/*                                                              */
/*     ALPHA=   the level of significance for comparisons       */
/*              among the means.  The default is 0.05.          */
/*                                                              */
/*     OUT=     the name of the output dataset containing the   */
/*              MCB analysis.  The default is MCBOUT.           */
/*                                                              */
/*     OPTIONS= a string containing either of the following     */
/*              options                                         */
/*                                                              */
/*                NOPRINT - suppresses printed output of        */
/*                          results                             */
/*                NOCLEAN - suppresses deletion of temporary    */
/*                          datasets                            */
/*                                                              */
/* Output:                                                      */
/*                                                              */
/*   The output dataset contains one observation for each       */
/*   group in the dataset.  The output data set contains the    */
/*   following variables:                                       */
/*                                                              */
/*     LEVEL  - formatted value of this group                   */
/*                                                              */
/*     LSMEAN - sample mean response within this group          */
/*                                                              */
/*     SE     - standard error of the sample mean for this      */
/*              group                                           */
/*                                                              */
/*     CLLO   - lower confidence limit for the difference       */
/*              between the population mean of this group and   */
/*              the best population mean                        */
/*                                                              */
/*     CLHI   - upper confidence limit for the difference       */
/*              between the population mean of this group and   */
/*              the best population mean                        */
/*                                                              */
/*     RVAL   - the smallest alpha level at which the           */
/*              population mean of this group can be rejected   */
/*              as the best, for all groups but the one with    */
/*              the best sample mean                            */
/*                                                              */
/*     SVAL   - the smallest alpha level at which the           */
/*              population mean of this group can be selected   */
/*              as the best treatment, for the group with the   */
/*              best sample mean                                */
/*--------------------------------------------------------------*/

%macro mcb(data,
           resp ,
           mean,
           model   = &mean,
           class   = &mean,
           alpha   = 0.05 ,
           out     = mcbout ,
           options =      );

 /*
/  Retrieve options.
/---------------------------------------------------------------------*/
   %let print = 1;
   %let clean = 1;
   %let iopt = 1;
   %do %while(%length(%scan(&options,&iopt)));
      %if       (%upcase(%scan(&options,&iopt)) = NOPRINT) %then
         %let print = 0;
      %else %if (%upcase(%scan(&options,&iopt)) = NOCLEAN) %then
         %let clean = 0;
      %else
         %put Warning: Unrecognized option %scan(&options,&iopt).;
      %let iopt = %eval(&iopt + 1);
      %end;

 /*
/  Count number of variables in grouping effect.
/---------------------------------------------------------------------*/
   %let ivar = 1;
   %do %while(%length(%scan(&mean,&ivar,*)));
      %let var&ivar = %upcase(%scan(&mean,&ivar,*));
      %let ivar = %eval(&ivar + 1);
      %end;
   %let nvar = %eval(&ivar - 1);

 /*
/  Compute ANOVA and LSMEANS
/---------------------------------------------------------------------*/
   ods listing close;
   proc mixed data=&data;
      class &class;
      model &resp = &model;
      lsmeans &mean;
      make 'LSMeans' out=&out;
   run;
   ods listing;
   data &out; set &out; orig_n = _n_;
   proc sort data=&out out=&out; by &mean;
   run;

 /*
/  Retrieve the levels of the classification variable.
/---------------------------------------------------------------------*/
   data &out; set &out;
      drop tvalue probt;
      length level $ 20;

      level = '';
      %do ivar = 1 %to &nvar;
         level = trim(left(level)) || ' ' || trim(left(&&var&ivar));
         %end;
      call symput('nlev',trim(left(_n_)));
      call symput('lev'||trim(left(_n_)),level);
      run;

 /*
/  Now, perform Dunnett's comparison-with-control test with each
/  level as the control.
/---------------------------------------------------------------------*/
   ods listing close;
   proc mixed data=&data;
      class &class;
      model &resp = &model / dfm=sat;
      %do ilev = 1 %to &nlev;
         %let control =;
         %do ivar = 1 %to &nvar;
            %let control = &control "%scan(&&lev&ilev,&ivar)";
            %end;
         lsmeans &mean / diff=controlu(&control) cl alpha=&alpha
                               adjust=dunnett;
         %end;
      make 'Diffs' out=_mcb;
   run;
   ods listing;
   data _mcb; set _mcb;
      length level1 $ 20 level2 $ 20;

      level1 = '';
      level2 = '';
      %do ivar = 1 %to &nvar;
         %let v1 = &&var&ivar;
         %let v2 = _&&var&ivar;
         %if (%length(&v2) > 8) %then
            %let var2 = %substr(&v2,1,8);
         level1 = trim(left(level1)) || ' ' || trim(left(&v1));
         level2 = trim(left(level2)) || ' ' || trim(left(&v2));
         %end;
   run;

 /*
/  Sort results by first and second level, respectively.
/---------------------------------------------------------------------*/
   proc sort data=_mcb out=_tmcb1; by level1 level2;
   proc transpose data=_tmcb1 out=_tmcb1 prefix=lo; by level1; var adjlow;
   data _tmcb1; set _tmcb1; ilev = _n_;
   proc sort data=_mcb out=_tmcb2; by level2 level1;
   proc transpose data=_tmcb2 out=_tmcb2 prefix=lo; by level2; var adjlow;
   data _tmcb2; set _tmcb2; ilev = _n_;
   run;

 /*
/  From Hsu (1996), p. 94:
/     Di+ = +( min_{j!=i} m_i - m_j + d^i*s*sqrt(1/n_i + 1/n_j))^+
/         = +(-max_{j!=i} m_j - m_i - d^i*s*sqrt(1/n_i + 1/n_j))^+
/     G = {i : min_{j!=i} m_i - m_j + d^i*s*sqrt(1/n_i + 1/n_j) > 0}
/     Di- = 0                                                if G = {i}
/         = min_{j!=i} m_i - m_j + d^j*s*sqrt(1/n_i + 1/n_j) otherwise
/---------------------------------------------------------------------*/
   data clhi; set _tmcb2; keep level2 clhi ilev;
      rename level2=level;
      clhi = -max(of lo1-lo%eval(&nlev-1));
      if (clhi < 0) then clhi = 0;
   data _g; set clhi; if (clhi > 0);
   run;

   %let ng = 0;
   %let g  = 0;
   data _null_; set _g;
      call symput('ng',_n_ );
      call symput('g' ,ilev);
   run;

   data cllo; set _tmcb1; keep level1 cllo ilev;
      rename level1=level;
      if ((&ng = 1) & (&g = ilev)) then cllo = 0;
      else                              cllo = min(of lo1-lo%eval(&nlev-1));
   run;

   data cl; merge cllo clhi;
      by level;
   data &out; merge &out cl;
      drop df ilev;
   run;

 /*
/  Compute RVAL and SVAL.  RVAL is just the p-value for Dunnett's
/  test for all means except the best, and SVAL is the maximum RVAL.
/---------------------------------------------------------------------*/
   data _slev; set &out; _i_ = _n_;
   proc sort data=_slev out=_slev; by descending estimate;
   %let ibest = 0;
   data _null_; set _slev;
      if (_n_ = 1) then call symput('ibest',_i_);
   proc sort data=_mcb out=_pval; by level2 adjp;
   proc transpose data=_pval out=_pval prefix=p; by level2; var adjp;
   data _pval; set _pval; keep level2 rval;
      rename level2=level;
      if (_n_ = &ibest) then rval = .;
      else                   rval = p1;
   proc sort data=_pval out=_spval; by descending rval;
   data _null_; set _spval; if (_n_ = 1) then call symput('sval',rval);
   data _pval; set _pval;
      if (_n_ = &ibest) then sval = &sval;
   data &out; merge &out _pval; by level; drop level;
   proc sort data=&out out=&out; by orig_n;
   data &out; set &out; drop orig_n;
   run;

 /*
/  Print and clean up.
/---------------------------------------------------------------------*/
   %if (&print) %then %do;
      proc print uniform data=&out noobs;
      run;
      %end;

   %if (&clean) %then %do;
      proc datasets library=work nolist;
         delete cllo clhi cl _slev _spval _pval _mcb _tmcb1 _tmcb2 _g;
      run;
      %end;

%mend;








/*--------------------------------------------------------------*/
/* Name:      MCW                                               */
/* Title:     Multiple Comparisons with the Worst               */
/* Author:    Randy Tobias, sasrdt@sas.com                      */
/* Reference: Hsu, Jason C. (1996).  _Multiple_Comparisons:_    */
/*               _Theory_and_methods_, Chapman & Hall, NY.      */
/* Release:   Version 7.01                                      */
/*--------------------------------------------------------------*/
/* Input:                                                       */
/*                                                              */
/*   The following arguments are required.  They must be the    */
/*   first three arguments and they must be in this order.  Do  */
/*   not use keywords for these arguments.                      */
/*                                                              */
/*     - the SAS data set containing the data to be analyzed    */
/*     - the response variable                                  */
/*     - the grouping variable                                  */
/*                                                              */
/*   The following additional arguments may be listed in any    */
/*   order, separated by commas:                                */
/*                                                              */
/*     MODEL=   a linear model for the response, specified      */
/*              using the effects syntax of GLM.  The default   */
/*              is a one-way model in the required grouping     */
/*              variable.                                       */
/*                                                              */
/*     CLASS=   classification variables involved in the        */
/*              linear model.  The default is the required      */
/*              grouping variable.                              */
/*                                                              */
/*     ALPHA=   the level of significance for comparisons       */
/*              among the means.  The default is 0.05.          */
/*                                                              */
/*     OUT=     the name of the output dataset containing the   */
/*              MCB analysis.  The default is MCBOUT.           */
/*                                                              */
/*     OPTIONS= a string containing either of the following     */
/*              options                                         */
/*                                                              */
/*                NOPRINT - suppresses printed output of        */
/*                          results                             */
/*                NOCLEAN - suppresses deletion of temporary    */
/*                          datasets                            */
/*                                                              */
/* Output:                                                      */
/*                                                              */
/*   The output dataset contains one observation for each       */
/*   group in the dataset.  The output data set contains the    */
/*   following variables:                                       */
/*                                                              */
/*     LEVEL  - formatted value of this group                   */
/*                                                              */
/*     LSMEAN - sample mean response within this group          */
/*                                                              */
/*     SE     - standard error of the sample mean for this      */
/*              group                                           */
/*                                                              */
/*     CLLO   - lower confidence limit for the difference       */
/*              between the population mean of this group and   */
/*              the worst population mean                       */
/*                                                              */
/*     CLHI   - upper confidence limit for the difference       */
/*              between the population mean of this group and   */
/*              the worst population mean                       */
/*                                                              */
/*     RVAL   - the smallest alpha level at which the           */
/*              population mean of this group can be rejected   */
/*              as the worst, for all groups but the one with   */
/*              the worst sample mean                           */
/*                                                              */
/*     SVAL   - the smallest alpha level at which the           */
/*              population mean of this group can be selected   */
/*              as the worst treatment, for the group with the  */
/*              worst sample mean                               */
/*--------------------------------------------------------------*/

%macro mcw(data,
           resp ,
           mean,
           model   = &mean,
           class   = &mean,
           alpha   = 0.05 ,
           out     = mcbout ,
           options =      );

 /*
/  Retrieve options.
/---------------------------------------------------------------------*/
   %let print = 1;
   %let clean = 1;
   %let iopt = 1;
   %do %while(%length(%scan(&options,&iopt)));
      %if       (%upcase(%scan(&options,&iopt)) = NOPRINT) %then
         %let print = 0;
      %else %if (%upcase(%scan(&options,&iopt)) = NOCLEAN) %then
         %let clean = 0;
      %else
         %put Warning: Unrecognized option %scan(&options,&iopt).;
      %let iopt = %eval(&iopt + 1);
      %end;

 /*
/  Copy the dataset but reverse the sign of the response, so that
/  the worst is the maximum response.
/---------------------------------------------------------------------*/
   data _tmpds; set &data; &resp = -&resp; run;

   %mcb(_tmpds,
        &resp ,
        &mean ,
        model   = &model  ,
        class   = &class  ,
        alpha   = &alpha  ,
        out     = &out    ,
        options = &options);

 /*
/  Reverse the sign of the results, so that the worst is again the
/  minimum response.
/---------------------------------------------------------------------*/
   data &out; set &out;
      rename cllo=cllo;
      rename clhi=clhi;
      estimate = -estimate;
      tvalue = -tvalue;
      _temp = -cllo; cllo = -clhi; clhi = _temp; drop _temp;
   run;

 /*
/  Print and clean up.
/---------------------------------------------------------------------*/
   %if (&print) %then %do;
      proc print uniform data=&out noobs;
      run;
      %end;

   %if (&clean) %then %do;
      proc datasets library=work nolist;
         delete _tmpds;
      run;
      %end;

%mend;






/*--------------------------------------------------------------*/
/* Name:      UMCB                                              */
/* Title:     Unconstrained Multiple Comparisons with the Best  */
/* Author:    Randy Tobias, sasrdt@sas.com                      */
/* Reference: Hsu, Jason C. (1996).  _Multiple_Comparisons:_    */
/*               _Theory_and_methods_, Chapman & Hall, NY.      */
/* Release:   Version 7.01                                      */
/*--------------------------------------------------------------*/
/* Input:                                                       */
/*                                                              */
/*   The following arguments are required.  They must be the    */
/*   first three arguments and they must be in this order.  Do  */
/*   not use keywords for these arguments.                      */
/*                                                              */
/*     - the SAS data set containing the data to be analyzed    */
/*     - the response variable                                  */
/*     - the grouping variable                                  */
/*                                                              */
/*   The following additional arguments may be listed in any    */
/*   order, separated by commas:                                */
/*                                                              */
/*     MODEL=   a linear model for the response, specified      */
/*              using the effects syntax of GLM.  The default   */
/*              is a one-way model in the required grouping     */
/*              variable.                                       */
/*                                                              */
/*     CLASS=   classification variables involved in the        */
/*              linear model.  The default is the required      */
/*              grouping variable.                              */
/*                                                              */
/*     ALPHA=   the level of significance for comparisons       */
/*              among the means.  The default is 0.05.          */
/*                                                              */
/*     OUT=     the name of the output dataset containing the   */
/*              MCB analysis.  The default is MCBOUT.           */
/*                                                              */
/*     OPTIONS= a string containing either of the following     */
/*              options                                         */
/*                                                              */
/*                NOPRINT - suppresses printed output of        */
/*                          results                             */
/*                NOCLEAN - suppresses deletion of temporary    */
/*                          datasets                            */
/*                                                              */
/* Output:                                                      */
/*                                                              */
/*   The output dataset contains one observation for each       */
/*   group in the dataset.  The output data set contains the    */
/*   following variables:                                       */
/*                                                              */
/*     LEVEL  - formatted value of this group                   */
/*                                                              */
/*     LSMEAN - sample mean response within this group          */
/*                                                              */
/*     SE     - standard error of the sample mean for this      */
/*              group                                           */
/*                                                              */
/*     CLLO   - lower confidence limit for the difference       */
/*              between the population mean of this group and   */
/*              the best population mean                        */
/*                                                              */
/*     CLHI   - upper confidence limit for the difference       */
/*              between the population mean of this group and   */
/*              the best population mean                        */
/*--------------------------------------------------------------*/
%macro umcb(data,
           resp ,
           mean,
           model   = &mean,
           class   = &mean,
           alpha   = 0.05 ,
           out     = mcbout ,
           method  = EH   ,
           options =      );

 /*
/  Retrieve options.
/---------------------------------------------------------------------*/
   %let print = 1;
   %let clean = 1;
   %let iopt = 1;
   %do %while(%length(%scan(&options,&iopt)));
      %if       (%upcase(%scan(&options,&iopt)) = NOPRINT) %then
         %let print = 0;
      %else %if (%upcase(%scan(&options,&iopt)) = NOCLEAN) %then
         %let clean = 0;
      %else
         %put Warning: Unrecognized option %scan(&options,&iopt).;
      %let iopt = %eval(&iopt + 1);
      %end;

 /*
/  Count number of variables in grouping effect.
/---------------------------------------------------------------------*/
   %let ivar = 1;
   %do %while(%length(%scan(&mean,&ivar,*)));
      %let var&ivar = %upcase(%scan(&mean,&ivar,*));
      %let ivar = %eval(&ivar + 1);
      %end;
   %let nvar = %eval(&ivar - 1);

 /*
/  Compute ANOVA and LSMEANS
/---------------------------------------------------------------------*/
   ods listing close;
   proc mixed data=&data;
      class &class;
      model &resp = &model;
      lsmeans &mean;
      make 'LSMeans' out=&out;
   run;
   ods listing;
   data &out; set &out; orig_n = _n_;
   proc sort data=&out out=&out; by &mean;
   run;

 /*
/  Retrieve the levels of the classification variable.
/---------------------------------------------------------------------*/
   data &out; set &out;
      drop tvalue probt;
      length level $ 20;

      level = '';
      %do ivar = 1 %to &nvar;
         level = trim(left(level)) || ' ' || trim(left(&&var&ivar));
         %end;
      call symput('nlev',trim(left(_n_)));
      call symput('lev'||trim(left(_n_)),level);
      run;

   %if (%upcase(&method) = TK) %then %do;
      ods listing close;
      proc mixed data=&data;
         class &class;
         model &resp = &model;
         lsmeans &mean / diff=all cl alpha=&alpha adjust=tukey;
         make 'Diffs'   out=_mcb;
      run;
      ods listing;
      proc sort data=_mcb out=_mcb;
         by &mean _&mean;
      run;

 /*
/  Add reverse differences.
/---------------------------------------------------------------------*/
      data _mcb; set _mcb; keep level1 level2 adjlow adjupp adjp;
         length level1 $ 20 level2 $ 20;

         level1 = '';
         level2 = '';
         %do ivar = 1 %to &nvar;
            %let v1 = &&var&ivar;
            %let v2 = _&&var&ivar;
            %if (%length(&v2) > 8) %then
               %let var2 = %substr(&v2,1,8);
            level1 = trim(left(level1)) || ' ' || trim(left(&v1));
            level2 = trim(left(level2)) || ' ' || trim(left(&v2));
            %end;
         output;
         _tmplev = level1; level1 = level2; level2 = _tmplev;
         _tmpcl  = -adjlow; adjlow = -adjupp; adjupp = _tmpcl;
         output;
      run;

 /*
/  Confidence limits are the minimum lower and upper CL's for each
/  level.
/---------------------------------------------------------------------*/
      proc sort data=_mcb out=_mcb; by level1 level2;
      proc transpose data=_mcb out=cllo prefix=lo; by level1; var adjlow;
      proc transpose data=_mcb out=clhi prefix=hi; by level1; var adjupp;
      data cllo; set cllo;
         rename level1=level;
         cllo = min(of lo1-lo%eval(&nlev-1));
      data clhi; set clhi;
         rename level1=level;
         clhi = min(of hi1-hi%eval(&nlev-1));
      data cl; merge cllo(keep=level cllo) clhi(keep=level clhi);
      run;

      data &out; merge &out cl; drop level;
      run;

      %if (&clean) %then %do;
         proc datasets library=work nolist;
            delete _mcb cllo clhi cl;
            run;
         %end;
      %end;
   %else %do;

 /*
/  Now, perform Dunnett's comparison-with-control test with each
/  level as the control.
/---------------------------------------------------------------------*/
      ods listing close;
      proc mixed data=&data;
         class &class;
         model &resp = &model / dfm=sat;
         %do ilev = 1 %to &nlev;
            %let control =;
            %do ivar = 1 %to &nvar;
               %let control = &control "%scan(&&lev&ilev,&ivar)";
               %end;
            lsmeans &mean / diff=control(&control) cl alpha=&alpha
                                  adjust=dunnett;
            %end;
         make 'Diffs' out=_mcb;
      run;
      ods listing;
      data _mcb; set _mcb;
         length level1 $ 20 level2 $ 20;

         level1 = '';
         level2 = '';
         %do ivar = 1 %to &nvar;
            %let v1 = &&var&ivar;
            %let v2 = _&&var&ivar;
            %if (%length(&v2) > 8) %then
               %let var2 = %substr(&v2,1,8);
            level1 = trim(left(level1)) || ' ' || trim(left(&v1));
            level2 = trim(left(level2)) || ' ' || trim(left(&v2));
            %end;
      proc sort data=_mcb out=_mcb; by level2 level1;
      data cl; keep cllo clhi;
         array m{&nlev,&nlev}; /* m[i1]-m[i2] - |d|^i2*s[i1,i2] */
         array p{&nlev,&nlev}; /* m[i1]-m[i2] + |d|^i2*s[i1,i2] */
         array s{&nlev};
         array l{&nlev};
         array u{&nlev};

         do i = 1 to &nlev; do j = 1 to &nlev;
            m[i,j] = .; p[i,j] = .;
            end; end;
         do obs = 1 to %eval(&nlev*(&nlev-1));
            set _mcb point=obs;

            j  = mod((obs-1),%eval(&nlev-1)) + 1;
            i2 = int((obs-1)/%eval(&nlev-1)) + 1;
            if (j < i2) then i1 = j;
            else             i1 = j + 1;

            m[i1,i2] = adjlow;
            p[i1,i2] = adjupp;
            end;

 /*
/  From Hsu (1996), p. 120:
/     S = {i : min_{j!=i}   m_i - m_j + |d|^i*s[i,j] > 0}
/       = {i : min_{j!=i} -(m_j - m_i - |d|^i*s[i,j]) > 0}
/       = {i : min_{j!=i} -m[j,i] > 0}
/---------------------------------------------------------------------*/
         ns = 0;
         do i = 1 to &nlev;
            minmmji = 1e12;
            do j = 1 to &nlev; if (j ^= i) then do;
               if (-m[j,i] < minmmji) then minmmji = -m[j,i];
               end; end;
            s[i] = (minmmji > 0);
            ns = ns + s[i];
            end;

 /*
/  From Hsu (1996), p. 115:
/     Lij = (i ^= j) * (m_i - m_j + |d|^j*s[i,j])
/         = (i ^= j) * p[i,j]
/     Li  = min_{j in S} Lij
/
/     Uij = (i ^= j) * -(m_i - m_j + |d|^j*s[i,j])^-
/         = (i ^= j) * min(0,p[i,j])
/     Ui  = max_{j in S} Uij
         put "Edwards-Hsu intervals";
         do i = 1 to &nlev;

            li = 1e12;
            do j = 1 to &nlev; if (s[j]) then do;
               if (i = j) then lij = 0;
               else            lij = m[i,j];
               if (lij < li) then li = lij;
               end; end;

            ui = -1e12;
            do j = 1 to &nlev; if (s[j]) then do;
               if (i = j) then uij = 0;
               else            uij = min(0,p[i,j]);
               if (uij > ui) then ui = uij;
               end; end;

            put li 7.3 " < mu" i 1. " - max_j muj < " ui 7.3;
            end;
/---------------------------------------------------------------------*/

 /*
/  From Hsu (1996), p. 120:
/     If S = {i} then
/        Li* = (min_{j!=i}   m_i - m_j - |d|^i*s[i,j] )^+
/            = (min_{j!=i} -(m_j - m_i + |d|^i*s[i,j]))^+
/            = (min_{j!=i} -p[j,i])^+
/     Otherwise
/        Li* = min_{j in S,j!=i} m_i - m_j - |d|^j*s[i,j]
/            = min_{j in S,j!=i} m[i,j]
/---------------------------------------------------------------------*/
         do i = 1 to &nlev;
            if ((ns = 1) & s[i]) then do;
               minmpji = 1e12;
               do j = 1 to &nlev; if (j ^= i) then do;
                  if (-p[j,i] < minmpji) then minmpji = -p[j,i];
                  end; end;
               l[i] = max(0,minmpji);
               end;
            else do;
               minpmij = 1e12;
               do j = 1 to &nlev; if (s[j] & (j ^= i)) then do;
                  if (m[i,j] < minpmij) then minpmij = m[i,j];
                  end; end;
               l[i] = minpmij;
               end;
            end;

 /*
/  From Hsu (1996), p. 120:
/     If i in S then
/        Ui* = min_{j!=i}   m_i - m_j + |d|^i*s[i,j]
/            = min_{j!=i} -(m_j - m_i - |d|^i*s[i,j])
/            = min_{j!=i} -m[j,i]
/     Otherwise
/        Ui* = -(max_{j in S,} m_i - m_j + |d|^j*s[i,j])^-
/            = -(max_{j in S,} p[i,j])^-
/---------------------------------------------------------------------*/
         do i = 1 to &nlev;
            if (s[i]) then do;
               minmmji = 1e12;
               do j = 1 to &nlev; if (j ^= i) then do;
                  if (-m[j,i] < minmmji) then minmmji = -m[j,i];
                  end; end;
               u[i] = minmmji;
               end;
            else do;
               minppij = -1e12;
               do j = 1 to &nlev; if (s[j]) then do;
                  if (p[i,j] > minppij) then minppij = p[i,j];
                  end; end;
               u[i] = minppij;
               end;
            end;

         do i = 1 to &nlev;
            cllo = l{i}; clhi = u{i};
            output;
            end;

         stop;
      data &out; merge &out cl; drop level;
      run;

      %if (&clean) %then %do;
         proc datasets library=work nolist;
            delete _mcb cl;
            run;
         %end;

      %end;

   proc sort data=&out out=&out; by orig_n;
   data &out; set &out; drop orig_n;
   run;

 /*
/  Print and clean up.
/---------------------------------------------------------------------*/
   %if (&print) %then %do;
      proc print uniform data=&out noobs;
      run;
      %end;

%mend;









/*--------------------------------------------------------------*/
/* Name:      UMCW                                              */
/* Title:     Unconstrained Multiple Comparisons with the Worst */
/* Author:    Randy Tobias, sasrdt@sas.com                      */
/* Reference: Hsu, Jason C. (1996).  _Multiple_Comparisons:_    */
/*               _Theory_and_methods_, Chapman & Hall, NY.      */
/* Release:   Version 7.01                                      */
/*--------------------------------------------------------------*/
/* Input:                                                       */
/*                                                              */
/*   The following arguments are required.  They must be the    */
/*   first three arguments and they must be in this order.  Do  */
/*   not use keywords for these arguments.                      */
/*                                                              */
/*     - the SAS data set containing the data to be analyzed    */
/*     - the response variable                                  */
/*     - the grouping variable                                  */
/*                                                              */
/*   The following additional arguments may be listed in any    */
/*   order, separated by commas:                                */
/*                                                              */
/*     MODEL=   a linear model for the response, specified      */
/*              using the effects syntax of GLM.  The default   */
/*              is a one-way model in the required grouping     */
/*              variable.                                       */
/*                                                              */
/*     CLASS=   classification variables involved in the        */
/*              linear model.  The default is the required      */
/*              grouping variable.                              */
/*                                                              */
/*     ALPHA=   the level of significance for comparisons       */
/*              among the means.  The default is 0.05.          */
/*                                                              */
/*     OUT=     the name of the output dataset containing the   */
/*              MCB analysis.  The default is MCBOUT.           */
/*                                                              */
/*     OPTIONS= a string containing either of the following     */
/*              options                                         */
/*                                                              */
/*                NOPRINT - suppresses printed output of        */
/*                          results                             */
/*                NOCLEAN - suppresses deletion of temporary    */
/*                          datasets                            */
/*                                                              */
/* Output:                                                      */
/*                                                              */
/*   The output dataset contains one observation for each       */
/*   group in the dataset.  The output data set contains the    */
/*   following variables:                                       */
/*                                                              */
/*     LEVEL  - formatted value of this group                   */
/*                                                              */
/*     LSMEAN - sample mean response within this group          */
/*                                                              */
/*     SE     - standard error of the sample mean for this      */
/*              group                                           */
/*                                                              */
/*     CLLO   - lower confidence limit for the difference       */
/*              between the population mean of this group and   */
/*              the worst population mean                       */
/*                                                              */
/*     CLHI   - upper confidence limit for the difference       */
/*              between the population mean of this group and   */
/*              the worst population mean                       */
/*--------------------------------------------------------------*/
%macro umcw(data,
            resp ,
            mean,
            model   = &mean ,
            class   = &mean ,
            alpha   = 0.05  ,
            out     = mcbout,
            method  = EH    ,
            options =       );

 /*
/  Retrieve options.
/---------------------------------------------------------------------*/
   %let print = 1;
   %let clean = 1;
   %let iopt = 1;
   %do %while(%length(%scan(&options,&iopt)));
      %if       (%upcase(%scan(&options,&iopt)) = NOPRINT) %then
         %let print = 0;
      %else %if (%upcase(%scan(&options,&iopt)) = NOCLEAN) %then
         %let clean = 0;
      %else
         %put Warning: Unrecognized option %scan(&options,&iopt).;
      %let iopt = %eval(&iopt + 1);
      %end;

 /*
/  Copy the dataset but reverse the sign of the response, so that
/  the worst is the maximum response.
/---------------------------------------------------------------------*/
   data _tmpds; set &data; &resp = -&resp; run;

   %umcb(_tmpds,
         &resp ,
         &mean ,
         model   = &model  ,
         class   = &class  ,
         alpha   = &alpha  ,
         out     = &out    ,
         method  = &method ,
         options = &options);

 /*
/  Reverse the sign of the results, so that the worst is again the
/  minimum response.
/---------------------------------------------------------------------*/
   data &out; set &out;
      rename cllo=cllo;
      rename clhi=clhi;
      estimate = -estimate;
      tvalue = -tvalue;
      _temp = -cllo; cllo = -clhi; clhi = _temp; drop _temp;
   run;

 /*
/  Print and clean up.
/---------------------------------------------------------------------*/
   %if (&print) %then %do;
      proc print uniform data=&out noobs;
      run;
      %end;

   %if (&clean) %then %do;
      proc datasets library=work nolist;
         delete _tmpds;
      run;
      %end;

%mend;




