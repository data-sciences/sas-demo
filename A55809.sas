 /*-------------------------------------------------------------------*/
 /*      Univariate and Multivariate General Linear Models:           */
 /*        Theory and Applications Using SAS(R) Software              */
 /*           by Neil H. Timm and Tammy A. Mieczkowski                */
 /*     Copyright(c) 1997 by SAS Institute Inc., Cary, NC, USA        */
 /*               SAS Publications order # 55809                      */
 /*                    ISBN 1-55544-987-5                             */
 /*-------------------------------------------------------------------*/
 /*                                                                   */
 /* This material is provided "as is" by SAS  Institute Inc.  There   */
 /* are no warranties, express or implied, as to merchantability or   */
 /* fitness for a particular purpose regarding the materials or code  */
 /* contained herein. The Institute is not responsible for errors     */
 /* in this  material as it now exists or will exist, nor does the    */
 /* Institute provide technical support for it.                       */
 /*                                                                   */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /*    Neil H. Timm, Ph.D.                                            */
 /*    Professor                                                      */
 /*    Department of Psychology in Education                          */
 /*    5C01 Forbes Quadrangle                                         */
 /*    Pittsburgh PA  15260                                           */
 /*                                                                   */
 /* or by email:                                                      */
 /* TIMM@vms.cis.pitt.edu                                             */
 /*                                                                   */
 /*-------------------------------------------------------------------*/

This file contains example code and data sets that are used in the                
book, Univariate and Multivariate General Linear Models: Theory and 
Applications Using SAS(R) Software by Neil H. Timm and Tammy A. Mieczkowski.
     
*************************************************************************
*************************************************************************

EXAMPLE CODE USED IN THIS BOOK

***************************************************     
/* The following code appears on page  8,         */    
/* where it is used to produce output 1.6.        */    
***************************************************     

/* Program 1_6.sas */
/* Program to create a multivariate normal data set */

options ls=80 ps=60 nodate nonumber;
filename app1 '1_6.dat';
title1 'Output 1.6: Generating a Multivariate Normal Data Set';

proc iml;
   seed=30195;
   z=normal(repeat(seed,50,4));
   u={10,20,30,40};
   s={3 1 0  0,
      1 4 0  0,
      0 0 1  4,
      0 0 4 20};
   a=root(s);
   uu=repeat(u`,50,1);
   y=(z*a) + uu;
   print y;

file app1;
   do i=1 to nrow(y);
      do j=1 to ncol(y);
        put (y[i,j]) 10.2 +2 @;
      end;
     put;
   end;
closefile app1;
quit;

***************************************************     
/* The following code appears on page  11,         */    
/* where it is used to produce output 1.7.1.       */    
***************************************************    

/* Program 1_7_1.sas */
/* Program to create Q-Q plot of data */

options ls=80 ps=60 nodate nonumber;
filename app1 '1_6.dat';
title1 'Output 1.7.1: Q-Q plot of 1.6 Data (y1)';

data ex171;
   infile app1;
   input y1-y4;
proc sort;
   by y1;
proc univariate noprint;
   var y1;
   output out=stats n=nobs mean=mean std=std;
data quantile;
   set ex171;
   if _n_=1 then set stats;
   i+1;
   p=(i - .5) / nobs;
   z=probit(p);
   normal = mean + z*std;
proc print;
proc corr;
   var y1 z;
run;

filename out '1_7_1.cgm';
goptions device=cgmmwwc gsfname=out gsfmode=replace
   colors=(black) hsize=5in vsize=4in;

proc gplot data=quantile;
   plot y1*z normal*z /overlay frame;
   symbol1 v=;
   symbol2 i=join v=none l=1;
run;

***************************************************     
/* The following code appears on page 13,          */    
/* where it is used to produce output 1.7.2.       */    
***************************************************    

/* Program 1_7_2.sas */
/* Program to create Q-Q plot of 1/(y1**2) Data */

options ls=80 ps=60 nodate nonumber;
filename app1 '1_6.dat';
title1 'Output 1.7.2: Q-Q Plot of 1/(y1**2)';

data ex172;
   infile app1;
   input y1-y4;
   ty1=1/(y1**2);
proc sort;
   by ty1;
proc univariate noprint;
   var ty1;
   output out=stats n=nobs mean=mean std=std;
data quantile;
   set ex172;
   if _n_=1 then set stats;
   i+1;
   p=(i - .5) / nobs;
   z=probit(p);
   normal = mean + z*std;
proc print;
proc corr;
   var ty1 z;
run;

filename out '1_7_2.cgm';
goptions device=cgmmwwc gsfname=out gsfmode=replace
     colors=(black) hsize=5in vsize=4in;

proc gplot data=quantile;
   plot ty1*z normal*z /overlay frame;
   symbol1 v=;
   symbol2 i=join v=none l=1;
run;

***************************************************     
/* The following code appears on page  15,         */    
/* where it is used to produce output 1.7.3.       */    
***************************************************    

/* Program 1_7_3.sas */
/* Program to create Q-Q plot of y1 data with Outlier */

options ls=80 ps=60 nodate nonumber;
filename app1 '1_6.dat';
title1 'Output 1.7.3: Q-Q plot of y1 data with an Outlier';

data ex173;
   infile app1;
   input y1-y4;
   if y1 ge 13.7 then y1 = 17;
proc sort;
   by y1;
proc univariate noprint;
   var y1;
   output out=stats n=nobs mean=mean std=std;
data quantile;
   set ex173;
   if _n_=1 then set stats;
   i+1;
   p=(i - .5) / nobs;
   z=probit(p);
   normal = mean + z*std;
proc print;
proc corr;
   var y1 z;
run;

filename out '1_7_3.cgm';
goptions device=cgmmwwc gsfname=out gsfmode=replace
   colors=(black) hsize=5in vsize=4in;

proc gplot data=quantile;
   plot y1*z normal*z /overlay frame;
   symbol1 v=;
   symbol2 i=join v=none l=1;
run;

***************************************************     
/* The following code appears on page  17,         */    
/* where it is used to produce output 1.7.4.       */    
***************************************************    

/* Program 1_7_4.sas                                */
/* Program to create Q-Q plot of a dataset          */
/* To run this program on your own dataset change   */
/* the name of the file in the file=_____statement  */
/* and the number of columns in the p=___ statement */

options ls=80 ps=60 nodate nonumber;

%let file = ycondx.dat;
%let p = 3;

  /* macro to expand the string of variables that are processed */
%macro expand(cols);
   %do j=1 %to &cols;
      v&j
   %end;
%mend expand;

  /* macro to perform Q-Q plotting of the variables    */
%macro qq(cols);
   %do i=1 %to &cols;
proc sort data=ex174;
   by v&i;
proc univariate noprint data=ex174;
   var v&i;
   output out=stats n=nobs mean=mean std=std;
data quantile;
   set ex174;
   if _n_=1 then set stats;
   k+1;
   pr=(k - .5) / nobs;
   z=probit(pr);
   normal = mean + z*std;
proc print data=quantile;
   title "Output 1.7.4: Q-Q plot, variable V&i, &file";
proc corr data=quantile;
   var v&i z;

filename out "1_7_4_&i'.cgm";
goptions device=cgmmwwc gsfname=out gsfmode=replace
   colors=(black) hsize=5in vsize=4in;

proc gplot data=quantile;
   title "Output 1.7.4: Q-Q plot, variable V&i, &file";
   plot v&i*z normal*z /overlay frame;
   symbol1 v=;
   symbol2 i=join v=none l=1;
run;
%end;
%mend qq;

data ex174;
   infile "&file";
   input %expand(&p);
proc print data=ex174;
   title "Output 1.7.4: &file";
%qq(&p);

***************************************************     
/* The following code appears on page  22,         */    
/* where it is used to produce output 1.8.1.       */    
***************************************************    

/* Program 1_8_1.sas                            */
/* Program to create Chi-Square Plot of Y Data  */
/* Data set from 1_6.sas is used, with a column */
/* of observation numbers added to the file     */

options ls=80 ps=60 nodate nonumber;
filename app1 '1_6.da2';
title1 'Output 1.8.1: Chi-Square Plot of the 1.6 Dataset';
                                                         
data ex181;
   infile app1;
   input tag $ y1 - y4;
   label tag = 'id'
      y1 = 'var1'
      y2 = 'var2'
      y3 = 'var3'
      y4 = 'var4';
   %let id=tag;
   %let var=y1 y2 y3 y4;
proc iml;
   reset;
   start dsquare;
      use _last_;
      read all var {&var} into y [colname=vars rowname=&id];
      n=nrow(y);
      p=ncol(y);
      r1=&id;
      print y;
      m=y[ :,];
      d=y - j(n,1) * m;
      s=d` * d / (n-1);
      dsq=vecdiag(d * inv(s) * d`);
      r=rank(dsq);
      val=dsq; dsq [r, ] = val;
      val=r1; &id [r] = val;
      z=((1:n)` - .5) / n;
      chisq = 2 * gaminv(z,p/2);
      result = dsq||chisq;
      cl={'dsq' 'chisq'};
      create dsquare from result [colname=cl rowname=&id];
      append from result [rowname=&id];
   finish;
run dsquare;
quit;
proc print data=dsquare;
   var tag dsq chisq;
run;

filename out '1_8_1.cgm';
goptions device=cgmmwwc gsfname=out gsfmode=replace
   colors=(black) hsize=5in vsize=4in;

proc gplot data=dsquare;
   plot dsq*chisq /frame;
   symbol1 v=;
run;

***************************************************     
/* The following code appears on page  24,         */    
/* where it is used to produce output 1.8.2.       */    
***************************************************  

/* Program 1_8_2.sas                 */
/* Program to create Chi-Square Plot */
/* of Residuals from Rhower data     */

options ls=80 ps=60 nodate nonumber;
filename rhower 'ycondx.da2';
title1 'Output 1.8.2: Chi-Square Plot of Residuals';

data ex182;
   infile rhower;
   input tag $ yc1-yc3;
   label tag = 'id'
      yc1 = 'var1'
      yc2 = 'var2'
      yc3 = 'var3';
   %let id=tag;
   %let var=yc1 yc2 yc3;
proc iml;
   reset;
   start dsquare;
      use _last_;
      read all var {&var} into y [colname=vars rowname=&id];
      n=nrow(y);
      p=ncol(y);
      r1=&id;
      print y;
      m=y[ :,];
      d=y - j(n,1) * m;
      s=d` * d / (n-1);
      dsq=vecdiag(d * inv(s) * d`);
      r=rank(dsq);
      val=dsq; dsq [r, ] = val;
      val=r1; &id [r] = val;
      z=((1:n)` - .5) / n;
      chisq = 2 * gaminv(z,p/2);
      result = dsq||chisq;
      cl={'dsq' 'chisq'};
      create dsquare from result [colname=cl rowname=&id];
      append from result [rowname=&id];
   finish;
   run dsquare;
   quit;
proc print data=dsquare;
   var tag dsq chisq;
run;

filename out '1_8_2.cgm';
goptions device=cgmmwwc gsfname=out gsfmode=replace
   colors=(black) hsize=5in vsize=4in;

proc gplot data=dsquare;
   plot dsq*chisq /frame;
   symbol1 v=;
run;  


***************************************************     
/* The following code appears on page  26,         */    
/* where it is used to produce output 1.9.1.       */    
***************************************************  

/* Program 1_9_1.sas */
/* Program to produce bivariate scatter plot of Rhower Data */

options ls=80 ps=60 nodate nonumber;
filename rhower '5_1.dat';
title 'Output 1.9.1: Bivariate Scatter Plots of Rhower Data';

data ex191;
   infile rhower;
   input y1-y3 x0-x5;
proc plot;
   plot y1*x1;
   plot y1*x2;
   plot y1*x3;
   plot y1*x4;
   plot y1*x5;
run;

***************************************************     
/* The following code appears on page  29,         */    
/* where it is used to produce output 1.9.2.       */    
***************************************************  

/* Program 1_9_2.sas */
/* Program to create 3-D Plots of bivariate normal distributions*/

options ls=80 ps=60 nodate nonumber;
title 'Output 1.9.2: Bivariate Normal Distribution';

title2 'with u=(0, 0), var(y1)=3, var(y2)=4, cov(y1,y2)=1, r=.289';
data bivar;
   vy1=3;
   vy2=4;
   r=.289;
   keep y1 y2 z;
   cons=1/(2*3.14159265*sqrt(vy1*vy2*(1-r*r)));
   do y1=-10 to 10 by .2;
      do y2=-10 to 10 by .2;
         zy1=y1/sqrt(vy1);
         zy2=y2/sqrt(vy2);
         d=((zy1**2)+(zy2**2)-2*r*zy1*zy2)/(1-r**2);
         z=cons*exp(-d/2);
         if z > .001 then output;
     end;
   end;
run;


filename out1 '1_9_2_1.cgm';
goptions device=cgmmwwc gsfname=out1 gsfmode=replace
   colors=(black) hsize=6in vsize=5in;

proc g3d data=bivar;
   plot y1*y2=z;
run;

/* A Second Plot*/

title2 'with u=(0, 0), var(y1)=3, var(y2)=20, cov=0, r=0';
data bivar2;
   vy1=3;
   vy2=20;
   r=0;
   keep y1 y2 z;
   cons=1/(2*3.14159265*sqrt(vy1*vy2*(1-r*r)));
   do y1=-10 to 10 by .2;
      do y2=-10 to 10 by .2;
         zy1=y1/sqrt(vy1);
         zy2=y2/sqrt(vy2);
         d=((zy1**2)+(zy2**2)-2*r*zy1*zy2)/(1-r**2);
         z=cons*exp(-d/2);
         if z > .001 then output;
      end;
   end;
run;


filename out2 '1_9_2_2.cgm';
goptions device=cgmmwwc gsfname=out2 gsfmode=replace
    colors=(black) hsize=6in vsize=5in;

proc g3d data=bivar2;
   plot y1*y2=z;
run;


***************************************************     
/* The following code appears on page  32,         */    
/* where it is used to produce output 1.10.        */    
*************************************************** 

/* Program 1_10.sas                                        */
/* Program to calculate Mardia's measure of multivariate   */
/* skewness and kurtosis                                   */

options ls=80 ps=60 nodate nonumber;
title 'Output 1.10: Mardias Multivariate Skewness & Kurtosis';

data Rhower;
   infile '5_1.dat';
   input y1-y3 x0-x5;
proc print data=Rhower;

proc iml;
   use Rhower;
   v={y1 y2 y3};
   w={x0 x1 x2 x3 x4 x5};
   read all var v into y;
   read all var w into x;
   beta=inv(x`*x)*x`*y;
   n=nrow(y);
   p=ncol(y);
   k=ncol(x);
   s=(y`*y-y`*x*beta)/(n-k);
   s_inv=inv(s);
   q=i(n)-x*(inv(x`*x)*x`);
   d=q*y*s_inv*y`*q;

   b1=(sum(d#d))/(n*n);
   b2=trace(d#d)/n;

   kappa1= n*b1/6;
   kappa2=(b2-p*(p+2))/sqrt(8*p*(p+2)/n);

   dfchi=p*(p+1)*(p+2)/6;

   pvalskew=1-probchi(kappa1,dfchi);
   pvalkurt=2*(1-probnorm(abs(kappa2)));

   print s; print s_inv;
   print b1; print kappa1; print pvalskew;
   print b2; print kappa2; print pvalkurt;
quit;

***************************************************     
/* The following code appears on page  34,         */    
/* where it is used to produce output 1.11.        */    
***************************************************  

/* Program 1_11.sas                                         */
/* Program to compute Box Cox Transformations               */
/* To run this program on your own dataset change           */
/* the name of the file in the file=____ statement          */
/* the number of rows in the n=____ statement and           */
/* the number of columns (variables) in the p=___ statement */

options ls=80 ps=60 nodate nonumber mprint;
%let file=c:\exp1_6.dat;
%let n=50;
%let p=1;

 /*macro to expand the string of variables that are processed */
%macro expand(cols);
   %do j=1 %to &cols;
      x&j
   %end;
%mend expand;

 /*macro to perform the Box-Cox transformation on the data matrix */
%macro loop(cols);
   %do i=1 %to &cols;
      proc iml;
         use matrix;
         read all var {x&i};
         in=i(&n);
         allh={-1.0, -0.9, -0.8, -0.7, -0.6, -0.5, -0.4, -0.3, -0.2, -0.1,
           0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3};
         one=j(&n,1,1);
         c=in-(one*(inv(one`*one))*one`);
         do k=1 to 23 by 1;
            h=allh[k,1];
            xh=x&i##h;
            hinv=1/h;
            vhinv=j(&n,1,hinv);
            y=(xh-one)#vhinv;
            my=(one`*y)/&n;
            ycy=y`*c*y;
            lnx=log(x&i);
            slnx=one`*lnx;
            ycyn=ycy/&n;
            if ycyn > 0 then lhp1=-(&n/2)*log(ycyn);
            else lhp1=.;
            lhp2=(h-1)*slnx;
            if ycyn > 0 then lh=lhp1+lhp2;
            else lh=.;
            lhs=lhs//lh;
         end;
         Lambda=allh||lhs;
         print, "Lambda and corresponding likelihood for variables x&i",
           lambda;
         call pgraf(lambda, '*', 'lambda', 'likelihood',
         "plot of lambda vs likelihood for variable x&i");
      quit;
  %end;
%mend loop;

 /*input the data and process the macro */
data matrix;
   infile "&file";
   input (%expand(&p)) (&p*:25.) ;
   title "Output 1.11: Box-Cox Transformation plots of &file";
proc print;
%loop(&p)
run;

***************************************************     
/* The following code appears on page  51,         */    
/* where it is used to produce output 2.6.         */    
***************************************************  

/* Program 2_6.sas                                                         */
/* Program to perform Multiple Linear Regression Analysis of homicide data */
/* Data from exercise 4, p 117, Kleinbaum, Kupper, Muller                  */

options ls=80 ps=60 nodate nonumber;
title 'Output 2.6: Multiple Linear Regression Analysis of Homicide data';

data reg;
   infile 'c:\2_6.dat';
   input city y x1 x2 x3;
   label  y='homicide rate'
         x1='population size'
         x2='percent low income'
         x3='unemployment rate';
proc print;
proc univariate;
   var y;
proc corr;
   var y x1 x2 x3;
proc reg;
   model y = x1 x2 x3 /vif;
proc reg;
   model y = x1 x2 x3 /partial selection = backward;
   model y = x2 x3 /vif r collin influence;
   paint student. ge 2 or student. le -2 /symbol = 'o';
   plot r.*x2 r.*x3 /hplots=2;
   plot r.*p. student.*p.;
run;

***************************************************     
/* The following code appears on page  59,         */    
/* where it is used to produce output 2.7.         */    
***************************************************  

/* Program 2_7.sas                                         */
/* Program to perform analysis of a One-Way Design with    */
/* Unequal n, using Full Rank model                        */

options ls=80 ps=60 nodate nonumber;
filename treat '2_7.dat';
title 'Output 2.7: One-Way Design with Unequal n, Full Rank Model';

data treat;
   infile treat;
   input treat y;
proc print;
proc glm;
   class treat;
   model y=treat /noint e xpx;
   contrast 'treatments'   treat 1 0 0 -1,
                            treat 0 1 0 -1,
                            treat 0 0 1 -1;
   estimate 'treat1-treat4' treat 1 0 0 -1;
   estimate 'treat2-treat4' treat 0 1 0 -1;
   estimate 'treat3-treat4' treat 0 0 1 -1;
run;
proc glm;
   class treat;
   model y=treat /noint e xpx;
   contrast 'treats123 vs 4' treat -1 -1 -1 3;
   estimate 'treats123 vs 4' treat -1 -1 -1 3;
run;

***************************************************     
/* The following code appears on page 63,          */    
/* where it is used to produce output 2.8.         */    
***************************************************  

/* Program 2_8.sas                                        */
/* Program to perform analysis of a nested design with    */
/* Unequal n, using Full Rank model                       */

options ls=80 ps=60 nodate nonumber;
filename nested 'c:\2_8.dat';
title 'Output 2.8: Nested Design with Unequal n, Full Rank Model';

data nest;
   infile nested;
   input a b y;
   label a='course'
         b='section';
proc print;
proc glm;
   class a b;
   model y = a b(a) /noint e;

   contrast 'ha_1' a 1 -1;
   estimate 'ha_1' a 1 -1 /e;

   contrast 'hb_1'        b(a) 1 -1  0  0  0;
   estimate 'hb_1vs2'     b(a) 1 -1  0  0  0 /e;

   contrast 'hb_2'        b(a) 0  0  1  0 -1,
                          b(a) 0  0  0  1 -1;
   estimate 'hb_1vs3'     b(a) 0  0  1  0 -1 /e;
   estimate 'hb_2vs3'     b(a) 0  0  0  1 -1 /e;

   contrast 'hb_1and2'    b(a) 1 -1  0  0  0,
                          b(a) 0  0  1  0 -1,
                          b(a) 0  0  0  1 -1;

proc glm;
   class a b;
   model y = a b(a);
run;

***************************************************     
/* The following code appears on page  69,         */    
/* where it is used to produce output 2.9.         */    
***************************************************  


/* Program 2_9.sas                                                     */
/* Program to perform analysis of covariance with different slopes and */
/* Unequal n, using Full Rank model                                    */
/* the one-way Unbalanced Intraclass covariance model                  */

options ls=80 ps=60 nodate nonumber;
filename ex29 'c:\2_9.dat';
title 'Output 2.9: One-way Unbalanced Intraclass covariance model';

data cov;
   infile ex29;
   input y a z a1 a2 a3 z1 z2 z3;
proc print;

/* Using the full rank model */
proc reg;
   model y = a1 a2 a3 z1 z2 z3 /noint;
   parallel: mtest z1-z2=0,
                   z1-z3=0 /print details;
run;

/* Using the less than full rank model */
proc glm;
   class a;
   model y=a z a*z /e xpx solution;
   lsmeans a /stderr pdiff cov;
run;

***************************************************     
/* The following code appears on page  79,         */    
/* where it is used to produce output 3.3.         */    
*************************************************** 

/* Program 3_3.sas                                */
/* Two-Way Factorial Design, Unequal Cell Freq    */
/* with and without interaction                   */
/* data from Timm and Carlson (1975, page 58)     */

options ls=80 ps=60 nodate nonumber;
title 'Output 3.3: 2-Way Factorial Design';

data two;
   infile 'c:\3_3.dat';
   input a b y1 x11 x12 x13 x14 x21 x22 x23 x24;
proc print data=two;
run;

proc reg;
   title2 'Unrestricted: 2-Way w/Interaction (univar)--Proc Reg';
   model y1 = x11 x12 x13 x14 x21 x22 x23 x24 /noint;
   AB: mtest x11-x12-x21+x22=0,
             x12-x13-x22+x23=0,
             x13-x14-x23+x24=0 /print details;
   A: mtest x11+x12+x13+x14-x21-x22-x23-x24=0 /print details;
   B: mtest x11+x21-x14-x24=0,
            x12+x22-x14-x24=0,
            x13+x23-x14-x24=0 /print details;
   wtA: mtest .1875*x11+.3125*x12+.1875*x13+.3125*x14-
              .2500*x21-.2500*x22-.2500*x23-.2500*x24=0 /print details;
   wtB: mtest .4286*x11+.5714*x21-.5556*x14-.4444*x24=0,
              .5556*x12+.4444*x22-.5556*x14-.4444*x24=0,
              .4286*x13+.5714*x23-.5556*x14-.4444*x24=0 /print details;
run;
proc glm;
   title2 'Unrestricted: 2-Way w/Interaction (univar)--Proc GLM';
   class a b;
   model y1 = a b a*b /ss1 ss2 ss3;
proc glm;
   class a b;
   model y1 = b a a*b /ss1 ss2 ss3;
run;
proc reg;
   title2 'Restricted: 2-Way w/o Interaction (univar)--Proc Reg';
   model y1 = x11 x12 x13 x14 x21 x22 x23 x24 /noint;
   restrict x11 - x12 - x21 + x22 = 0,
            x12 - x13 - x22 + x23 = 0,
            x13 - x14 - x23 + x24 = 0;
   A: mtest x11+x12+x13+x14-x21-x22-x23-x24=0 /print details;
   B: mtest x11+x21-x14-x24=0,
            x12+x22-x14-x24=0,
            x13+x23-x14-x24=0 /print details;
   wtA: mtest .1875*x11+.3125*x12+.1875*x13+.3125*x14-
              .2500*x21-.2500*x22-.2500*x23-.2500*x24=0 /print details;
   wtB: mtest .4286*x11+.5714*x21-.5556*x14-.4444*x24=0,
              .5556*x12+.4444*x22-.5556*x14-.4444*x24=0,
              .4286*x13+.5714*x23-.5556*x14-.4444*x24=0 /print details;
run;
proc glm;
   title2 'Restricted: 2-Way w/o Interaction (univar)--Proc GLM';
   class a b;
   model y1 = a b /ss1;
proc glm;
   class a b;
   model y1 = b a /ss1;
run;
 
***************************************************     
/* The following code appears on page  94,         */    
/* where it is used to produce output 3.4.         */    
*************************************************** 

/* Program 3_4.sas                      */
/* Latin Square Design, Full Rank Model */

options ls=80 ps=60 nodate nonumber;
title 'Output 3.4: Latin Square Design, Full Rank Model';

data Latin;
   infile 'c:\3_4.dat';
   input a b c y1 x112 x123 x131 x213 x221 x232 x311 x322 x333;
proc print data=latin;
run;

proc reg;
  model y1 = x112 x123 x131 x213 x221 x232 x311 x322 x333 /noint;
   restrict  x112 - x131 - x213 + x221 - x322 + x333 = 0,
            -x112 + x123 - x221 + x232 + x311 - x333 = 0;
   A: mtest  x112 + x123 + x131 - x311 - x322 - x333 = 0,
             x213 + x221 + x232 - x311 - x322 - x333 = 0 /print details;
   B: mtest  x112 - x131 + x213 - x232 + x311 - x333 = 0,
             x123 - x131 + x221 - x232 + x322 - x333 = 0 /print details;
   C: mtest -x123 + x131 - x213 + x221 + x311 - x333 = 0,
             x112 - x123 - x213 + x232 + x322 - x333 = 0 /print details;
run;

***************************************************     
/* The following code appears on page 102          */    
/* where it is used to produce output 3.5.1.       */    
***************************************************  

/* Program 3_5_1.sas                     */
/* Split-Plot (Two-Group Profile) Design */

options ls=80 ps=60 nodate nonumber;
title 'Output 3.5.1: Split-Plot Repeated Measures Design';

data split;
   infile 'c:\3_5_1.dat';
   input y x111 x121 x131 x112 x122 x132
           x211 x221 x231 x212 x222 x232
           x311 x321 x331 x312 x322 x332;
proc print data=split;
run;

/* Using full rank model */
proc reg;
   title2 'Full Rank Model';
   model y = x111 x121 x131 x112 x122 x132 x211 x221 x231 x212
             x222 x232 x311 x321 x331 x312 x322 x332 /noint;
   restrict x111 - x121 - x112 + x122 = 0,
            x121 - x131 - x122 + x132 = 0,
            x211 - x221 - x212 + x222 = 0,
            x221 - x231 - x222 + x232 = 0,
            x311 - x321 - x312 + x322 = 0,
            x321 - x331 - x322 + x332 = 0;
   A: mtest x111+x121+x131+x112+x122+x132-x211-x221-x231-x212-x222-x232=0,
            x211+x221+x231+x212+x222+x232-x311-x321-x331-x312-x322-x332=0
            /print details;
   B: mtest x111-x131+x112-x132+x211-x231+x212-x232+x311-x331+x312-x332=0,
            x121-x131+x122-x132+x221-x231+x222-x232+x321-x331+x322-x332=0
            /print details;
   AB: mtest x111-x121+x112-x122-x221+x231-x222+x232=0,
             x121-x131+x122-x132-x221+x231-x222+x232=0,
             x211-x221+x212-x222-x311+x321-x312+x322=0,
             x221-x231+x222-x232-x321+x331-x322+x332=0 /print details;
   AS: mtest x111+x121+x131-x112-x122-x132=0,
             x211+x221+x231-x212-x222-x232=0,
             x311+x321+x331-x312-x322-x332=0 /print details;
run;

/* Using less than full rank model */
data split2;
   input a b1 b2 b3;
   cards;
   1 3 4 3
   1 2 2 1
   2 3 7 7
   2 5 4 6
   3 3 4 6
   3 2 3 5
   ;
run;
proc glm;
   title2 'Less than Full Rank Model';
   class a;
   model b1 b2 b3 = a;
   repeated b 3 profile /nom summary;
run;

***************************************************     
/* The following code appears on page 109,         */    
/* where it is used to produce output 3_5_2.       */    
***************************************************  

/* Program 3_5_2.sas                                      */
/* Split-Plot (Two-Group Profile) Design, Full Rank Model */
/* Timm (1975, p244) data                                 */

options ls=80 ps=60 nodate nonumber;
title 'Output 3.5.2: Two Group Profile Analysis';

data splitb;
   infile 'c:\3_5_2.dat';
   input grp p1 p2 p3 p4 p5;
proc print data=splitb;
run;

proc glm;
   class grp;
   model p1 p2 p3 p4 p5 = grp;
   repeated position 5 profile /nom summary;
run;

***************************************************     
/* The following code appears on page 111,         */    
/* where it is used to produce output 3.5.3.       */    
***************************************************  

/* Program 3_5_3.sas              */
/* Tests of Covariance Structures */

options ls=80 ps=60 nodate nonumber mprint;
title 'Output 3.5.3: Tests of Covariance Structures';

data struct;
   infile 'c:\3_5_2.dat';
   input grp p1 p2 p3 p4 p5;
proc print data=struct;
run;

proc iml;
   use struct;
   read all var {p1 p2 p3 p4 p5} where (grp=1) into y1;
   read all var {p1 p2 p3 p4 p5} where (grp=2) into y2;
   g=2;
   n1=nrow(y1);
   n2=nrow(y2);
   n=n1+n2;
   p=ncol(y1);
   df1=n1-1;
   df2=n2-1;
   s1=(y1`*(i(n1)-(1/n1)*j(n1,n1))*y1)/df1;
   s2=(y2`*(i(n2)-(1/n2)*j(n2,n2))*y2)/df2;
   s=(1/(n-g))*(df1*s1+df2*s2);

   /* the hypothesis test matrix a` */
   ap={1  -1   0   0   0,
       0   1  -1   0   0,
       0   0   1  -1   0,
       0   0   0   1  -1};
   a=ap`;
   q=nrow(ap);
   call gsorth(as,t,lindep,a);
   asp=as`;
   as1a=as`*s1*as;
   as2a=as`*s2*as;
   asa=(1/(n-g))*(df1*as1a+df2*as2a);
   print "A` and A*`", ap asp;
   print s1 s2;
   print "Reduced Covariance Matrices", as1a as2a;
   print "Reduced Pooled Covaraince Matrix", asa;

   /* Step 1 : Test of Equality of the Reduced Covariance Matrices */
   m1=(n-g)*(log(det(asa)));
   m2=df1*(log(det(as1a)))+df2*(log(det(as2a)));
   m=m1-m2;
   print m;
   e1=(2*q*q+3*q-1)/(6*(q+1)*(g-1));
   e2=(1/df1)+(1/df2)-(1/(n-g));
   e=e1*e2;
   print e;
   xb=(1-e)*m;
   v1=(q*(q+1)*(g-1))/2;
   probxb=1-probchi(xb,v1);
   print "Test of Equality of Reduced Covariance Matrices", xb v1;
   print "Probability of Xb with df=v1", probxb;
   print "The above test works well for ni>20 and q<6 and g<6";
   eo1=(1/(df1*df1))+(1/(df2*df2))-(1/((n-g)*(n-g)));
   eo2=(q-1)*(q+2)/(6*g-6);
   eo=eo2*eo1;
   vo=(v1+2)/(eo-(e*e));
   fb=((1-e-(v1/vo))/v1)*m;
   probfb=1-probf(fb,v1,vo);
   print "Test of Equality of Reduced Covariance Matrices", fb v1 vo;
   print "Probability of Fb with df=v1,vo", probfb;
   print "The above test can be used for small ni and/or q and/or g >6";

   /* Step 2 : Test of Circularity */
   const=-( (n-1)-((2*q*q+q+2)/(6*q)) );
   lds=log(det(asa));
   qlt=q*(log((trace(asa))/q));
   print const lds qlt;
   xs=const*(lds-qlt);
   dfxs=((q*q+q)/2)-1;
   probxs=1-probchi(xs,dfxs);
   print "Tests of Circularity (Mauchly)", xs dfxs;
   print "Probability of Xs with df=dfxs", probxs;
   sasa=asa*asa;
   v=trace(sasa)/((trace(asa))*(trace(asa)));
   vs=((q*q*n)/2)*(v-(1/q));
   probvs=1-probchi(vs,dfxs);
   print "Test of Circularity (L.B.I.)", vs, dfxs;
   print "Probability of Vs with df=dfxs", probvs;
quit;
run;

***************************************************     
/* The following code appears on page 119,         */    
/* where it is used to produce output 3.6.1.       */    
***************************************************  

/* Program 3_6_1.sas                                  */
/* Program to perform ANCOVA with one covariate and   */
/* Unequal n, using Full Rank model                   */

options ls=80 ps=60 nodate nonumber;
filename examp4 'c:\2_9.dat';
title 'Output 3.6.1: ANCOVA, One Covariate, Unequal n';

data onecov;
   infile examp4;
   input y a z a1 a2 a3 z1 z2 z3;
proc print;
run;

/* Using the full rank model */
proc reg;
   title2 'Full Rank Model';
   model y = a1 a2 a3 z1 z2 z3 /noint;
   restrict  z1-z2=0,
             z1-z3=0;
   A: mtest a1-a3=0,
            a2-a3=0 /print details;
   REG: mtest z3=0 /print details;
run;

/* Using the less than full rank model */
proc glm;
   title2 'Less than Full Rank Model';
   class a;
   model y=a z /e xpx solution;
   lsmeans a /stderr pdiff cov;
run;

***************************************************     
/* The following code appears on page 124,         */    
/* where it is used to produce output 3.6.2.       */    
***************************************************  

/* Program 3_6_2.sas                                   */
/* Program to perform ANCOVA with two covariates and   */
/* Unequal n, using Full Rank model                    */

options ls=80 ps=60 nodate nonumber;
title 'Output 3.6.2: ANCOVA, Two Covariates, Unequal n';

data twocov;
   infile 'c:\3_6_2.dat';
   input y a z1 z2 a1 a2 a3 z11 z12 z13 z21 z22 z23;
proc print;
run;

/* Using the full rank model */
proc reg;
   title2 'Full Rank Model';
   model y = a1 a2 a3 z11 z12 z13 z21 z22 z23 /noint;
   parallel: mtest z11-z13=0,
                   z12-z13=0,
                   z21-z23=0,
                   z22-z23=0 /print details;
run;
proc reg;
   model y = a1 a2 a3 z11 z12 z13 z21 z22 z23 /noint;
   restrict  z11-z13=0,
             z12-z13=0,
             z21-z23=0,
             z22-z23=0;
   A: mtest a1-a2=0,
            a2-a3=0 /print details;
   REG: mtest z13=0,
              z23=0 /print details;
run;

/* Using the less than full rank model */
proc glm;
   title2 'Less than full rank model';
   class a;
   model y=a z1 z2 a*z1 a*z2 /e solution;
run;
proc glm;
   class a;
   model y=a z1 z2 /e xpx solution;
   lsmeans a /stderr pdiff cov;
run;

***************************************************     
/* The following code appears on page 143,         */    
/* where it is used to produce output 4.5.         */    
***************************************************  

/* Program 4_5.sas                                          */
/* WLSE for data with heteroscedasticity                    */
/* Data are from Neter, Wasserman, and Kutner, 1990, p. 421 */

options ls=78 ps=60 nodate nonumber;
title1 'Output 4.5: Data with Heteroscedasticity';

data heter;
   infile 'c:\4_5.dat';
   input age blpress;
   if age lt 30 then agegrp=1;
   else if age lt 40 then agegrp=2;
   else if age lt 50 then agegrp=3;
   else agegrp=4;
run;
proc sort;
   by agegrp;
run;
proc means mean std var n;
   var blpress;
   by agegrp;
run;

/* Ordinary Least Square Regression */
proc reg data=heter;
   title2 'Ordinary Least Squares Regression ';
   model blpress=age/ p cli;
   output out=resid1 r=olsresid;
run;

/* Plot of OLS residuals */
filename out1 'c:\4_5_1.cgm';
goptions device=cgmmwwc gsfname=out1 gsfmode=replace
   colors=(black) vsize=5in hsize=4in htitle=1;
proc gplot data=resid1;
   title1 'OLS Residuals';
   title2;
   plot olsresid*age /frame;
   symbol1 v=;
run;

/* Add weight vector to the SAS dataset */
data wlse;
   set heter;
   if agegrp=1 then w=(1/sqrt(24.9231));
   else if agegrp=2 then w=(1/sqrt(50.5256));
   else if agegrp=3 then w=(1/sqrt(96.3524));
   else if agegrp=4 then w=(1/sqrt(133.1410));
run;

/* Weighted Least Squares Regression */
proc reg data=wlse;
   title1 'Output 4.5: Data with Heteroscedasticity';
   title2 'Weighted Least Squares Regression ';
   model blpress=age/ p cli;
   weight w;
   output out=resid2 r=wlsresid;
run;
data resid3;
   set resid2;
   wwlsresi=w*wlsresid;
   label wwlsresi = 'weighted residual';
run;

/* Plot of weighted WLS residuals */
filename out2 'c:\4_5_2.cgm';
goptions device=cgmmwwc gsfname=out2 gsfmode=replace
   colors=(black) vsize=5in hsize=4in htitle=1;
proc gplot data=resid3;
   title1 'Weighted WLS Residuals';
   title2;
   plot wwlsresi*age /frame;
   symbol1 v=;
run;

***************************************************     
/* The following code appears on page 156,         */    
/* where it is used to produce output 4.7.2.       */    
***************************************************  

/* Program 4_7_2.sas                                     */
/* Data are from Marascuilo and McSweeney, 1977, p.174   */
/* Using PROC CATMOD to evaluate Marginal Homogeniety    */

options ls=78 ps=60 nodate nonumber;
title1 'Output 4.7.2: Test of Marginal Homogeniety';

/* Using PROC IML */
title2 'Using PROC IML';
proc iml;
   start cat1;

      /* Input variables and data */
      n=124;
      s=3;
      r=3;
      freq={50 9 10,
             2 6 29,
             0 0 18};
      print freq;

      /* Form proportions and shape p */
      prop=freq/n;
      p=shape(prop,r*s,1);
      print p;

      /* Construct Covariance matrix and test matrix */
      omega=(diag(p)-p*p`)/n;
      qr=2;
      A={0  1 1 -1 0 0 -1  0 0,
         0 -1 0  1 0 1 0  -1 0};
      S=A*Omega*A`;
      print S;
      InvS=Inv(S);
      print InvS;
      F=A*p;
      print F;

      /* Calculate Wald statistic and p-value */
      Q=F`*InvS*F; pv=1-probchi(Q,qr);
      print 'Chi-square Test of Marginal Homogeniety',Q, 'p-value',pv;
   finish cat1;
run cat1;
quit;
run;

/* Using PROC CATMOD */
data school;
   input t55 t65 count @@;
   cards;
   1 1 50 1 2 9 1 3 10
   2 1  2 2 2 6 2 3 29
   3 1  0 3 2 0 3 3 18
   ;
run;

proc catmod;
title2 'Using PROC CATMOD';
   weight count;
   response marginals;
   model t55*t65=_response_;
   repeated year 2;
run;

***************************************************     
/* The following code appears on page 162,         */    
/* where it is used to produce output 4.7.3.       */    
***************************************************  

/* Program 4_7_3.sas                      */
/* Data are from  Grizzle et al.,1969     */
/* Testing for Homogeniety of Proportions  */

options ls=78 ps=60 nodate nonumber;
title1 'Output 4.7.3: Testing Homogeniety of Proportions, One-Way ANOVA';

/* Using PROC IML */
title2 'Using PROC IML';
proc iml;
   start cat2;
      freq={23 7 2, 23 10 5, 20 13 5, 24 10 6,
            18 6 1, 18  6 2, 13 13 2,  9 15 2,
             8 6 3, 12  4 4, 11  6 2,  7  7 4,
            12 9 1, 15  3 2, 14  8 3, 13  6 4};
      s=nrow(freq);
      r=ncol(freq);
      wt={1 2 3};
      rowsum=freq[,+];
      prob=freq/(rowsum*repeat(1,1,r));
      p=shape(prob[,1:r],0,1);
      A=I(16)@(repeat(1,1,r)#wt);
      D=diag(rowsum);
      V=(diag(p)-p*p`)#(Inv(D)@repeat(1,r,r));
      S=A*V*A`;
      InvS=Inv(S);
      F=A*p; print F;
      X={1  1  0  0  1  0  0,
         1  1  0  0  0  1  0,
         1  1  0  0  0  0  1,
         1  1  0  0 -1 -1 -1,
         1  0  1  0  1  0  0,
         1  0  1  0  0  1  0,
         1  0  1  0  0  0  1,
         1  0  1  0 -1 -1 -1,
         1  0  0  1  1  0  0,
         1  0  0  1  0  1  0,
         1  0  0  1  0  0  1,
         1  0  0  1 -1 -1 -1,
         1 -1 -1 -1  1  0  0,
         1 -1 -1 -1  0  1  0,
         1 -1 -1 -1  0  0  1,
         1 -1 -1 -1 -1 -1 -1};
      Beta=Inv(X`*InvS*X)*X`*InvS*F; print Beta;
      Q=F`*InvS*F-Beta`*(X`*InvS*X)*Beta;
      dfq=9;
      pvq=1-probchi(Q,dfq);
      print 'Chi-square Test of Fit',Q,'p-value for fit',pvq;
      CT={ 0 0 0 0 1 0 0,
           0 0 0 0 0 1 0,
           0 0 0 0 0 0 1};
      dfct=3;
      CH={ 0 1 0 0 0 0 0,
           0 0 1 0 0 0 0,
           0 0 0 1 0 0 0};
      dfch=3;
      L={0 0 0 0 3 2 1};
      dfL=1;
      Wh=(CH*Beta)`*Inv(CH*Inv(X`*InvS*X)*CH`)*(CH*Beta);
      pvWh=1-probchi(Wh,dfch);
      Wt=(CT*Beta)`*Inv(CT*Inv(X`*InvS*X)*CT`)*(CT*Beta);
      pvWt=1-probchi(Wt,dfct);
      W=(L*Beta)`*Inv(L*Inv(X`*InvS*X)*L`)*(L*Beta);
      pvL=1-probchi(W,dfL);
      print 'Hosp Chi-Square Test',WH, 'p-value Hosp',pvWh,
            'Treat Chi-Square Test',WT,'p-value Treat',pvWt,
            'Linear Trend',W,'p-value Linear',pvL;
   finish cat2;
run cat2;
quit;
run;

/* Using PROC CATMOD */
data operate;
   input treat hosp $ severity $ wt @@;
   cards;
   1 a N 23 1 a S  7 1 a M 2
   1 b N 18 1 b S  6 1 b M 1
   1 c N  8 1 c S  6 1 c M 3
   1 d N 12 1 d S  9 1 d M 1
   2 a N 23 2 a S 10 2 a M 5
   2 b N 18 2 b S  6 2 b M 2
   2 c N 12 2 c S  4 2 c M 4
   2 d N 15 2 d S  3 2 d M 2
   3 a N 20 3 a S 13 3 a M 5
   3 b N 13 3 b S 13 3 b M 2
   3 c N 11 3 c S  6 3 c M 2
   3 d N 14 3 d S  8 3 d M 3
   4 a N 24 4 a S 10 4 a M 6
   4 b N  9 4 b S 15 4 b M 2
   4 c N  7 4 c S  7 4 c M 4
   4 d N 13 4 d S  6 4 d M 4
   ;
run;

proc catmod order=data;
   title2 'Using PROC CATMOD' ;
   weight wt;
   response 1 2 3;
   model severity = hosp treat/ freq oneway;
   contrast 'Linear Trend - Treatment' treat 3 2 1;
run;

***************************************************     
/* The following code appears on page 169,         */    
/* where it is used to produce output 4.7.4.       */    
***************************************************  

/* Program 4_7_4.sas        */
/* Testing for Independence */

options ls=78 ps=60 nodate nonumber;
title 'Output 4.7.4: Test of Independence ' ;

data independ;
   input office $ perform $ count @@;
   cards;
   Y Success 50  Y Usuccess 20
   N Success 10  N Usuccess 20
   ;
run;

proc catmod;
   weight count;
   model office*perform=_response_/ freq wls;
   loglin office perform;
run;


***************************************************     
/* The following code appears on page 191,         */    
/* where it is used to produce output 5.6.         */    
***************************************************  

/* Program 5_6.sas                          */
/* Rhower data from Timm(1975), pp.281, 345 */

options ls = 80 ps = 60 nodate nonumber;
title1 'Output 5.6: Multivariate Regression';

data rhower;
   infile 'c:\5_6.dat';
   input y1-y3 x0-x5;
proc print data=rhower;
run;

/* Calculations for Regression and Multivariate Cooks Distance */
proc iml;
   title2 'Using PROC IML, including Cooks Distance';
   use rhower;
   v={y1 y2 y3};
   w={x0 x1 x2 x3 x4 x5};
   read all var v into y;
   read all var w into x;
   beta=inv(x`*x)*x`*y;
   print 'Regression Coefficients' beta;
   n=nrow(y);
   p=ncol(y);
   k=ncol(x);
   S=(y`*y-y`*x*beta)/(n-k);
   print 'Estimated Covarianc Matrix' S;

   v=inv(k*s)@(x`*x);
   b=shape(beta`,p*k,1);
   m=n-1;
   x1=x[1:m,1:k];
   y1=y[1:m,1:p];
   beta1=inv(x1`*x1)*x1`*y1;
   b1=shape(beta1`,p*k,1);
   d1=(b-b1)`*v*(b-b1);
   obs=32;
   index=obs;
   do i=2 to 31;
      j=n-i;
      x2=x[1:j,1:k]; x1=x[j+2:n,1:k];
      x2=x2//x1;
      y2=y[1:j,1:p]; y1=y[j+2:n,1:p];
      y2=y2//y1;
      beta2=inv(x2`*x2)*x2`*y2;
      b2=shape(beta2`,p*k,1);
      d2=(b-b2)`*v*(b-b2);
      d1=d1//d2;
      obs=obs-1;
      index=index//obs;
   end;
   x1=x[2:n,1:k];
   y1=y[2:n,1:p];
   beta1=inv(x1`*x1)*x1`*y1;
   b1=shape (beta1`,p*k,1);
   d2=(b-b1)`*v*(b-b1);
   d1=d1//d2;
   obs=1;
   index=index//obs;
   D=index||d1;
   print 'Influence Obs # and Multivariate Cooks Distance', D;
quit;

/* Multivariate Regression using PROC REG */
proc reg data=rhower;
   title2 'Using PROC REG';

/* Full Model Analysis */
   model y1-y3 = x1-x5;
   Gammaa:mtest x1-x5/ print;   /* test that all coefficients equal zero */
   Gamma1:mtest x1;             /* test that x1 equals zero */
   Gamma2:mtest x2;             /* test that x2 equals zero */
   Gamma3:mtest x3;             /* test that x3 equals zero */
   Gamma4:mtest x4;             /* test that x4 equals zero */
   Gamma5:mtest x5;             /* test that x5 equals zero */
   Beta:mtest intercept,x1-x5;  /* test that int and all coeff are zero */

/* Reduced Model Analysis*/
   model y1-y3 = x2-x4;
   Gamma:mtest x2-x4;  /* test that gamma=0 for reduced model */
   Gamma2:mtest x2;
   Gamma3:mtest x3;
   Gamma4:mtest x4;
run;

/* Calculation of Multivariate Eta Squared for Full and Reduced Models */
proc iml;
   title2 'Multivariate Eta Squared for Full and Reduced Models';
   n=32;
   g1=6;
   g2=4;
   p=3;
   LmdaF=.81206193;
   LmdaR=.70761904;
   Full=1-n*LmdaF/(n-g1+LmdaF);
   Reduced=1-n*LmdaR/(n-g2+LmdaR);
   print 'Eta Squared full model' Full, 'Eta Squared reduced model' Reduced;
quit;

/* Multivariate Regression using PROC GLM and Full Rank Model */
proc glm data=rhower;
   title2 'Using PROC GLM';
   model y1-y3=x2-x4/ nouni;
   manova h=x2-x4/ printe printh;
run;

***************************************************     
/* The following code appears on page 208,         */    
/* where it is used to produce output 5.7.         */    
***************************************************  

/* Program 5_7.sas             */
/* Nonorthogonal MANOVA Design */

options ls=80 ps=60 nodate nonumber;
title1 'Output 5.7: Nonorthogonal Three Factor MANOVA';

data three;
   infile 'c:\5_7.dat';
   input a b c y1 y2;
proc print data=three;
run;

/* Unweighted MANOVA Analysis */
proc glm;
   title2 'Unweighted Analysis';
   class a b c;
   model y1 y2 = a b c a*b a*c b*c a*b*c/ ss3 e;
   contrast 'a1 vs a3' a 1 0 -1;
   estimate 'a1 vs a3' a 1 0 -1/ divisor=3 e;
   contrast 'c1 vs c2' c .5 -.5;
   estimate 'c1 vs c2' c .5 -.5/ e;
   lsmeans a b c a*b a*c b*c a*b*c;
   manova h=a|b|c;
run;

/* Full Rank Model for MANOVA Design */
proc glm;
   title2 'Full Rank Model with Unweighted Contrast';
   class a b c;
   model y1 y2 = a*b*c/ noint;
   contrast 'a*b at c1' a*b*c 1 0 -1 0  0 0 -1 0  1 0  0 0  0 0  0 0 0 0,
                        a*b*c 0 0  1 0 -1 0  0 0 -1 0  1 0  0 0  0 0 0 0,
                        a*b*c 0 0  0 0  0 0  1 0 -1 0  0 0 -1 0  1 0 0 0,
                        a*b*c 0 0  0 0  0 0  0 0  1 0 -1 0  0 0 -1 0 1 0/ e;
   manova h=a*b*c/ printe printh;
run;

/* Weighted MANOVA Analysis */
proc glm data=three;
   title2 'Weighted Analysis';
   class a b c;
   model y1 y2 = a b a*b c a*c b*c a*b*c/ ss1;
   means a b c a*b a*c b*c a*b*c;
   manova h=a a*b a*b*c;
run;

proc glm;
   class a b c;
   model y1 y2 = b a a*b c c*b c*a a*b*c/ ss1;
   manova h=b;
run;

proc glm;
   class a b c;
   model y1 y2 = c b b*c a a*c a*b a*b*c/ ss1;
   manova h= c c*b;
run;

proc glm;
   class a b c;
   model y1 y2 = a c a*c b a*b b*c a*b*c/ ss1;
   manova h=a*c;
run;

/* Cell Means Model for MANOVA Design            */
proc glm;
   title2 'Full Rank Model with Weighted Contrast';
   class a b c;
   model y1 y2 = a*b*c/ noint nouni;
   contrast 'a*b at c1'a*b*c 1 0 -1 0  0 0 -1 0  1 0  0 0  0 0  0 0 0 0,
                       a*b*c 0 0  1 0 -1 0  0 0 -1 0  1 0  0 0  0 0 0 0,
                       a*b*c 0 0  0 0  0 0  1 0 -1 0  0 0 -1 0  1 0 0 0,
                       a*b*c 0 0  0 0  0 0  0 0  1 0 -1 0  0 0 -1 0 1 0/ e;
   contrast 'a1 vs a3'a*b*c .2143 .1429 .1429 .2143 .1429 .1429 0 0 0 0 0 0
                           -.1333 -.0667 -.200 -.200 -.200 -.200/ e;
   contrast 'c1 vs c2'a*b*c .1429 -.1053 .0952  -.1579 .0952 -.1053 .0952
                           -.0526  .0476 -.1053 .1429 -.1053 .0952 -.0526
                            .1429 -.1579 .1429 -.1579/ e;
   manova h=a*b*c/printe printh;
run;

***************************************************     
/* The following code appears on page 219,         */    
/* where it is used to produce output 5.8.         */    
***************************************************  

/* Program 5_8.sas */
/* MANCOVA Designs */

options ls=80 ps=60 nodate nonumber;
title 'Output 5.8: Multivariate MANCOVA';

data mancova;
   infile 'c:\5_8.dat';
   input drugs $ apgar1 apgar2 x;
proc print;
run;

proc glm;
   title2 'Test of Parallelism';
   class drugs;
   model Apgar1 Apgar2 = drugs x drugs*x;
   manova h= drugs*x;
run;

proc glm;
   title2 'MANCOVA Tests';
   class drugs;
   model apgar1 apgar2 = drugs x/ solution;
   contrast '1 vs. 4' drugs 1 0 0 -1;
   manova h=drugs x;
   means drugs;
   lsmeans drugs/ stderr pdiff tdiff cov out=adjmeans;
run;

proc print data=adjmeans;
   title2 'Adjusted Means';
run;

***************************************************     
/* The following code appears on page 225,         */    
/* where it is used to produce output 5.9.         */    
***************************************************  

/* Program 5_9.sas                                 */
/* Data from Smith, Gnanadesikan and Hughes (1962) */
/* Stepdown Analysis--MANCOVA                      */

options ls=80 ps=60 nodate nonumber;
title1 'Output 5.9: Multivariate MANCOVA with Stepdown Analysis';

data mancova;
   infile 'c:\5_9.dat';
   input group $ y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 x1 x2;
proc print data=mancova;
run;

/* Test of Parallelism */
proc glm data=mancova;
   title2 'Test of Parallelism';
   class group;
   model y1-y11 = group x1 x2 group*x1 group*x2/ nouni ss3;
   manova h = group *x1 group*x2;
run;

/* MANCOVA Tests */
proc glm data=mancova;
   title2 'MANCOVA Tests';
   class group;
   model y1-y11 = x1 x2 group/ e nouni ss3;
   contrast 'Ov Mean' intercept 1/ e;
   manova h=group x1 x2/ printh;
   means group;
   lsmeans group/ stderr pdiff tdiff cov out=adjmeans;
run;

proc print data=adjmeans;
   title2 'Adjusted Means';
run;

/* Mancova stepdown analysis for additional information  */
proc glm data=mancova;
   class group;
   title2 'Test of Gamma 2.1';
   model y2 y3 y4 y6 y9-y11 = group y1 y5 y7 y8 x1 x2/ nouni ss3;
   manova h = group y1 y5 y7 y8 x1 x2;
run;

proc glm data=mancova;
   class group;
   title2 'Test of Gamma1';
   model y1 y5 y7 y8 = group x1 x2/ nouni ss3;
   manova h = group x1 x2;
run;

***************************************************     
/* The following code appears on page 231,         */    
/* where it is used to produce output 5.10.        */    
*************************************************** 
 
/* Program 5_10.sas               */
/* Data from Timm(1975, page 244) */
/* Repeated Measures Analysis     */

options ls=80 ps=60 nodate nonumber;
title1 'Output 5.10: Repeated Measurement Analysis';

data timm;
   infile 'c:\5_10.dat';
   input group y1 y2 y3 y4 y5;
proc print data=timm;
run;

proc glm;
   title2 'Multivariate Tests';
   class group;
   model y1-y5 = group/ intercept nouni;
   means group;
   manova h = group/ printe printh;  /*test of group diffs for means */
   manova h =_all_ m=(1 -1 0 0 0,
                      0 1 -1 0 0,
                      0 0 1 -1 0,
                      0 0 0 1 -1)
      prefix = diff/ printe printh;  /* test for parallel profiles */

proc glm;
   class group;
   model y1-y5= group/noint nouni;
   contrast 'Mult Cond' group 1 0,
                        group 0 1;
   manova m=(1 -1 0 0 0,
             0 1 -1 0 0,
             0 0 1 -1 0,
             0 0 0 1 -1)
      prefix = diff/ printe printh; /* test of condtions as vectors */
run;

proc glm;
   title2 'Tests given Parallelism of Profiles';
   class group;
   model y1 - y5 = group/ noint nouni;
   contrast 'Univ Gr' group 1 -1;
   manova m=(.2 .2 .2 .2 .2) prefix=Gr/
      printe printh;  /* test of group means given parallel profiles */
run;

/* Univariate Test given Parallelism and Sphericity */
proc glm;
   title2 'Univariate Test given Parallelism and Sphericity';
   class group;
   model y1 - y5 = group/ nouni;
   repeated cond 5 (1 2 3 4 5) profile/printm summary;
   manova h=group m=(1 -1  0  0  0,
                     0  1 -1  0  0,
                     0  0  1 -1  0,
                     0  0  0  1 -1) prefix = diff / printe printh;
run;

***************************************************     
/* The following code appears on page 243,         */    
/* where it is used to produce output 5.11.        */    
***************************************************  

/* Program 5_11.sas               */
/* Data from Timm(1975, page 454) */
/* Extended Linear Hypotheses     */

options ls=80 ps=60 nodate nonumber;
title1 'Output 5.11: Extended Linear Hypotheses';
                                                
data timm;
   infile 'c:\5_11.dat';
   input group y1 y2 y3 x1 x2 x3;
proc print data=timm;
run;

proc glm data=timm;
   title2 'Multivariate Test of Group--Using PROC GLM';
   class group;
   model y1-y3 = group/nouni;
   means group;
   manova h=group/printh printe;
run;

/* IML procedure for Extended Linear Hypothesis */
title2 'Multivariate Test of Group--Using PROC IML';
proc iml;
   use timm;
   a={x1 x2 x3};
   b={y1 y2 y3};
   read all var a into x;
   read all var b into y;
   beta=inv(x`*x)*x`*y;
   print beta;
   n=nrow(y);
   p=ncol(y);
   k=ncol(x);
   nu_h=2; u=3; nu_e=n-k; s0=min(nu_h,u);
   r=max(nu_h,u); alpha=.05;
   denr=(nu_e-r+nu_h);
   roy_2=(r/denr)*finv(1-alpha,r,denr);
   rvalue=sqrt(roy_2);
   m0=(abs(nu_h-u)-1)/2; n0=(nu_e-u-1)/2;
   num=s0**2*(2*m0+s0+1); dent=2*(s0*n0+1);df=s0*(2*m0+s0+1);
   t0_2=(num/dent)*finv(1-alpha,df,dent);
   tovalue=sqrt(t0_2);
   print s0 m0 n0;
   e=(y`*y-y`*x*beta);
   co={1 -1 0, 0 1 -1};
   ao=i(3);
   eo=ao`*e*ao;
   bo=co*beta*ao;
   wo=co*inv(x`*x)*co`;
   ho=bo`*inv(wo)*bo;
   print,"Overall Error Matrix", eo ,
         "Overall Hypothesis Test Matrix",ho;

   /* c`c=eo where c is upper triangle Cholesky matrix */
   c=root(eo);
   f=inv(c`)*ho*inv(c);
   eig=Eigval(round(f,.0001));
   vec=inv(c)*eigvec(round(f,.0001));
   print,"Eigenvalues & Eigenvectors of Overall Test of Ho (Groups)",
      eig vec;

   /* Extended Linear Hypothesis following Overall Group Test */
   m={1 .5, -.5 .5, -.5 -1};
   g=ao*m*co;
   print, "Extended Linear Hypothesis Test Matrix",m g;
   psi=m*bo;
   psi_hat=trace(psi);
   tr_psi=abs(psi_hat);
   h=m*wo*m`;
   einv=inv(eo);
   c=root(einv);
   f=inv(c`)*h*inv(c);
   xeig=Eigval(round(f,.0001));
   print, "Eigenvalues of Extended Linear Hypothesis", xeig;
   denrt=sum(sqrt(xeig));
   dentr=sqrt(sum(xeig));
   to_2=tr_psi/dent; print, "Extended To**2 Statistic", to_2;
   print, "Extended To**2 Critical Value", tovalue;
   root=tr_psi/denr; print, "Extended Largest Root Statistic", root;
   print, "Extended Largest Root Critical Value", rvalue;
   print psi_hat alpha;
   ru=psi_hat+rvalue*denrt;
   rl=psi_hat-rvalue*denrt;
   vu=psi_hat+tovalue*dentr;
   vl=psi_hat-tovalue*dentr;
   print 'Approximate Simultaneous Confidence Intervals';
   print 'Contrast Significant if interval does not contain zero';
   print 'Extended Root interval:  ('rl ',' ru ')';
   print 'Extended Trace interval: ('vl ',' vu ')';

   /* Multiple Extended Linear Hypothesis using To**2  */
   m1={1 0,0 0,0 0}; m2={0 0,1 0,0 0}; m3={0 0,0 1,0 0}; m4={0 0,0 0,0 1};
   print,"Multiple Extended Linear Hypothesis Test Matrices", m1,m2,m3,m4;

   g1=ao*m1*co; g2=ao*m2*co; g3=ao*m3*co; g4=ao*m4*co;
   t1=trace(m1*bo); t2=trace(m2*bo); t3=trace(m3*bo); t4=trace(m4*bo);
   tau=t1//t2//t3//t4;
   t11=trace(m1*wo*m1`*eo); t21=trace(m2*wo*m1`*eo);
   t22=trace(m2*wo*m2`*eo); t31=trace(m3*wo*m1`*eo);
   t32=trace(m3*wo*m2`*eo); t33=trace(m3*wo*m3`*eo);
   t41=trace(m4*wo*m1`*eo); t42=trace(m4*wo*m2`*eo);
   t43=trace(m4*wo*m3`*eo); t44=trace(m4*wo*m4`*eo);
   r1=t11||t21||t31||t41; r2=t21||t22||t32||t42;
   r3=t31||t32||t33||t43; r4=t41||t42||t43||t44;
   t=r1//r2//r3//r4;
   print tau,t;
   to_4=tau`*inv(t)*tau;
   print, "Extended Linear Hypothesis Criterion To**2 Squared", to_4;
   print, "Extended To**2 Critical Value", t0_2;
quit;

/* Multivariate test of Parallelism */
proc glm data=timm;
title2 'Multivariate Test of Parallelism--Using PROC GLM';
   class group;
   model y1-y3 = group/nouni;
   manova h = group m = ( 1 -1  0,
                          0  1 -1) prefix = diff/ printe printh;
run;

title2 'Multivariate Test of Parallelism--Using PROC IML';
proc iml;
   use timm;
   a={x1 x2 x3};
   b={y1 y2 y3};
   read all var a into x;
   read all var b into y;
   beta=inv(x`*x)*x`*y;
   n=nrow(y);
   p=ncol(y);
   k=ncol(x);
   nu_h=2; u=2; nu_e=n-k; s0=min(nu_h,u); r=max(nu_h,u); alpha=.05;
   denr=(nu_e-r+nu_h);
   roy_2=(r/denr)*finv(1-alpha,r,denr);
   rvalue=sqrt(roy_2);
   m0=(abs(nu_h-u)-1)/2; n0=(nu_e-u-1)/2;
   num=s0**2*(2*m0+s0+1); dent=2*(s0*n0+1); df=s0*(2*m0+s0+1);
   t0_2=(num/dent)*finv(1-alpha,df,dent);
   tovalue=sqrt(t0_2);
   print s0 m0 n0;
   e=(y`*y-y`*x*beta);
   co={1 -1 0, 0 1 -1};
   ao={1 0, -1 1, 0 -1};
   eo=ao`*e*ao;
   bo=co*beta *ao;
   wo=co*inv(x`*x)*co`;
   ho=bo`*inv(wo)*bo;
   c=root(eo);
   f=inv(c`)*ho*inv(c);
   eig=eigval(round(f,.0001));
   vec=inv(c)*eigvec(round(f,.0001));
   print,"Eigenvalues & Eigenvectors of Overall test of Ho (Parallelism)",
      eig vec;

   /* Extended Linear Hypothesis following overall Parallelism test */
   m={0 1,1 0};
   g=ao*m*co;
   print, "Extended Linear Hypothesis Test Matrix", m g;

   psi=m*bo;
   psi_hat=trace(psi);
   tr_psi=abs(psi_hat);
   h=m*wo*m`;
   einv=inv(eo);
   c=root(einv);
   f=inv(c`)*h*inv(c);
   xeig=eigval(round(f,.0001));
   print, "Eigenvalues of Extended Linear Hypothesis", xeig;

   to_2=tr_psi/sqrt(sum(xeig)); print, "Extended To**2 Statistic", to_2;
   print,"Extended To**2 Critical Value", tovalue;
   root=tr_psi/sum(sqrt(xeig)); print, "Extended Largest Root Statistic", root;
   print, "Extended Largest Root Critical Value", rvalue;

   print psi_hat alpha;
   ru=psi_hat+rvalue*sum(sqrt(xeig));
   rl=psi_hat-rvalue*sum(sqrt(xeig));
   vu=psi_hat+tovalue*sqrt(sum(xeig));
   vl=psi_hat-tovalue*sqrt(sum(xeig));
   print 'Approximate Simultaneous Confidence Intervals';
   print 'Contrast Significant if interval does not contain zero';
   print 'Extended Root  Interval: ('rl ',' ru ')';
   print 'Extended Trace Interval: ('vl '.' vu ')';
quit;

/* Multivariate test of Conditions as vectors  */
proc glm data=timm;
title2 'Multivariate Test of Conditions--Using PROC GLM';
   class group;
   model y1-y3 = group/noint nouni;
   contrast 'Mult Cond' group 1 0 0,
                        group 0 1 0,
                        group 0 0 1;
   manova m=(1 -1  0,
             0  1 -1) prefix = diff/ printe printh;
run;

title2 'Multivariate Test of Conditions--Using PROC IML';
proc iml;
   use timm;
   a={x1 x2 x3};
   b={y1 y2 y3};
   read all var a into x;
   read all var b into y;
   beta=inv(x`*x)*x`*y;
   n=nrow(y);
   p=ncol(y);
   k=ncol(x);
   nu_h=3; u=2; nu_e=n-k; s0=min(nu_h,u); r=max(nu_h,u); alpha=.05;
   denr=(nu_e-r+nu_h);
   roy_2=(r/denr)*finv(1-alpha,r,denr);
   rvalue=sqrt(roy_2);
   m0=(abs(nu_h-u)-1)/2; n0=(nu_e-u-1)/2;
   num=s0**2*(2*m0+s0+1); dent=2*(s0*n0+1); df=s0*(2*m0+s0+1);
   t0_2=(num/dent)*finv(1-alpha,df,dent);
   tovalue=sqrt(t0_2);
   print s0 m0 n0;
   e=(y`*y-y`*x*beta);
   co=i(3);
   ao={1 0, -1 1, 0 -1};
   eo=ao`*e*ao;
   bo=co*beta*ao;
   wo=co*inv(x`*x)*co`;
   ho=bo`*inv(wo)*bo;
   c=root(eo);
   f=inv(c`)*ho*inv(c);
   eig=eigval(round(f,.0001));
   vec=inv(c)*eigvec(round(f,.0001));
   print, "Eigenvalues & Eigenvectors of Overall test of Ho (Conditions)",
      eig vec;

   m={1 0 1, 0 1 1};
   g=ao*m*co;
   print, "Extended Linear Hypothesis Test Matrix", m g;

   psi=m*bo;
   psi_hat=trace(psi);
   tr_psi=abs(psi_hat);
   h=m*wo*m`;
   einv=inv(eo);
   c=root(eo);
   f=inv(c`)*h*inv(c);
   xeig=eigval(round(f,.0001));
   print, "Eigenvalues of Extended Linear Hypothesis", xeig;

   to_2=tr_psi/sqrt(sum(xeig)); print, "Extended To**2 Statistic", to_2;
   print, "Extended T0**2 Critical Value", tovalue;
   root= tr_psi/sum(sqrt(xeig)); print, "Extended Largest Root Statistic",
      root;
   print, "Extended Largest Root Critical Value", rvalue;

   print psi_hat alpha;
   ru=psi_hat+rvalue*sum(sqrt(xeig));
   rl=psi_hat-rvalue*sum(sqrt(xeig));
   vu=psi_hat+tovalue*sqrt(sum(xeig));
   vl=psi_hat-tovalue*sqrt(sum(xeig));
   print 'Approximate Simultaneous Confidence Intervals';
   print 'Contrast Significant if interval does not contain zero';
   print 'Extended Root  Interval: ('rl ',' ru ')';
   print 'Extended Trace Interval: ('vl ',' vu ')';
quit;

***************************************************     
/* The following code appears on page 253,         */    
/* where it is used to produce output 5.12.        */    
***************************************************  

/* Program 5_12.sas                                                 */
/* Data are from Timm(1975, p.264)                                  */
/* The SAS routine power.pro was supplied by Muller, La Vange       */
/* Ramey, and Ramey (1992) as shown in their JASA (1992) article    */
/* "Power calculations for general linear models including repeated */
/* measures applications", pp 1209-1226                             */

options ls=80 ps=60 nodate nonumber;
title 'Output 5.12: Power Analysis for MANOVA design';

proc iml symsize=1000;
   %include 'c:\power.pro';
   alpha = .01;
   c={1 -1};
   u=i(2);
   beta={20.38 -38.33, 0 0};
   sigma={307.08 280.83, 280.83 421.67};
   essencex={1 0, 1 0, 1 0, 1 0, 1 0,
             0 1, 0 1, 0 1, 0 1, 0 1};
   run power;
quit;

***************************************************     
/* The following code appears on page 263,         */    
/* where it is used to produce output 6.5.         */    
***************************************************  

/* Program 6_5.sas                                                  */
/* Example from Timm(1980b) and Boik(1988,1991) - Zullo Dental data */

options ls=80 ps=60 nodate nonumber;
title 'Output 6.5: Double Multivariate Linear Model';

data dmlm;
   infile 'c:\mmm.dat';
   input group y1 - y9;
proc print data=dmlm;
run;

proc glm;
   title2 ' Double Multivariate Model Analysis';
   class group;
   model y1 - y9 = group/ nouni;
   means group;
   manova  h=group/ printh printe;
run;

/* Multivariate test of Parallelism */
proc glm;
   class group;
   model y1 - y9 = group / nouni;
   contrast 'Parallel'
             group 1 -1;
   manova m=(.7071 0 -.7071 0 0 0 0 0 0,
             0 0 0 -.408 .816 -.408 0 0 0,
             0 0 0 0 0 0 .7071 0 -.7071,
             -.408 .816 -.408 0 0 0 0 0 0,
             0 0 0 .7071 0 -.7071 0 0 0,
             0 0 0 0 0 0 -.408 .816 -.408) prefix = parl/ printh printe;
run;

/* Multivariate test of Conditions as vectors */
proc glm;
   class group;
   model y1 - y9 = group/ noint nouni;
   contrast 'Mult Cond' group 1 0,
                        group 0 1;
   manova m=(1 -1 0 0 0 0 0 0 0,
             0 1 -1 0 0 0 0 0 0,
             0 0 0 1 -1 0 0 0 0,
             0 0 0 0 1 -1 0 0 0,
             0 0 0 0 0 0 1 -1 0,
             0 0 0 0 0 0 0 1 -1) prefix = diff/ printh printe;
run;

/* Multivariate test of Conditions given Parallelism */
proc glm;
   class group;
   model y1- y9 = group/noint nouni;
   contrast 'Cond|Parl' group .5 .5;
   manova m=(.7071 0 -.7071 0 0 0 0 0 0,
             0 0 0 -.408 .816 -.408 0 0 0,
             0 0 0 0 0 0 .7071 0 -.7071,
             -.408 .816 -.408 0 0 0 0 0 0,
             0 0 0 .7071 0 -.7071 0 0 0,
             0 0 0 0 0 0 -.408 .816 -.408) prefix=cond/ printh printe;
run;

proc glm;
   class group;
   model y1 - y9 = group/noint nouni;
   contrast 'Group|Parl' group 1 -1;
   manova m=(.577 .577 .577 0 0 0 0 0 0,
             0 0 0 .577 .577 .577 0 0 0,
             0 0 0 0 0 0 .577 .577 .577) prefix=ovall/ printh printe;

/* Multivariate Mixed Model Analysis */
data mix;
   infile 'c:\mixed.dat';
   input group subj cond y1 y2 y3;
proc print data=mix;
run;

proc glm;
   title2 'Multivaraiate Mixed Model Analysis';
   class group subj cond;
   model y1 - y3 = group subj(group) cond cond*group;
   random subj(group);
   contrast 'Group' group 1 -1/ e=subj(group);
   manova h = cond group*cond/ printh printe;
run;

/* Test for Multivariate Spericity and calculation of Epsilon for MMM*/

proc iml;
   title2 'Multivariate Sphericity Test';
   print 'Test of Multivariate Sphericity UsingChi-Square and Adjusted Chi-
          Square Statistics';
   e={  9.6944  7.3056  -6.7972 -4.4264 -0.6736   3.7255,
        7.3056  8.8889  -4.4583 -3.1915 -3.2396   2.9268,
       -6.7972 -4.4583  18.6156  2.5772  0.8837 -10.1363,
       -4.4264 -3.1915   2.5772  5.3981  1.4259  -1.8546,
       -0.6736 -3.2396   0.8837  1.4259 18.3704   -.7769,
        3.7255  2.9268 -10.1363 -1.8546 -0.7769   6.1274};
   print e;
   n=18;
   p=3;
   t=3;
   k=2;
   u=6;
   q=u/p;
   nu_e=n-k;
   nu_h=1;
   e11=e[1:3,1:3];print e11;
   e22=e[4:6,4:6];print e22;
   dn=(e11+e22)/2;
   b=eigval(dn); print b;
   a=eigval(e); print a;
   b=log(b);
   a=log(a);
   chi_2=n#(q#sum(b)-sum(a));
   df=p#(q-1)#(p#q+p+1)/2;
   pvalue=1-probchi(chi_2,df);
   print chi_2 df pvalue;
   c1=p/(12#q#nu_e#df);
   rho= 1-c1#(2#p##2#(q##4-1)+3#p#(q##3-1)-(q##2-1));
   ro_chi_2=(rho#nu_e/n)#chi_2; print rho;
   c2=1/(2#rho##2);
   c3=((p#q-1)#p#q#(p#q+1)#(p#q+2))/(24#nu_e##2);
   c4=((p-1)#p#(p+1)#(p+2))/(24#q##2#nu_e##2);
   c5=df#(1-rho)##2/2;
   omega=c2#(c3-c4-c5); print omega;
   p1=1-probchi(ro_chi_2,df);
   p2=1-probchi(ro_chi_2,df+4);
   cpvalue=(1-omega)#p1+omega#p2;
   print ro_chi_2 cpvalue;

   s=e/nu_e;
   s11=s[1:3,1:3]; s12=s[1:3,4:6];
   s21=s[4:6,1:3]; s22=s[4:6,4:6];
   enum=trace((s11+s22)*(s11+s22))+(trace(s11+s22))##2;
   eden=q#( trace(s11)##2+trace(s11*s11)+trace(s12)##2+trace(s12*s12)+
            trace(s21)##2+trace(s21*s21)+trace(s22)##2+trace(s22*s22));
   epsilon=enum/eden;

   nu_h=nu_h#q; nu_e=nu_e#q; s0=min(nu_h,p);
   Mnu_h=nu_h#epsilon; Mnu_e=nu_e#epsilon; ms0=min(mnu_h,p);
   m0=(abs(mnu_h-p)-1)/2; n0=(mnu_e-p-1)/2;

   denom=s0##2#(2#m0+ms0+1); numer=2#(ms0#n0+1);
   df1=ms0#(2#m0+ms0+1); df2=2#(ms0#n0+1);

   print 'Epsison adjusted F-Statistics for cond and group X cond MMM tests';
   print epsilon;
   f_cond = df2#13.75139851/(ms0#df1);
   f_gXc  = df2#0.19070696/(ms0#df1);

   print f_cond f_gXc df1 df2;

   p_cond=1-probf(f_cond,df1,df2);
   p_gXc=1-probf(f_gXc,df1,df2);

   print 'Epsilon adjusted pvalues for MMM tests using T0**2 Criterion';

   print p_cond p_gXc;
quit;

***************************************************     
/* The following code appears on page 305,         */    
/* where it is used to produce output 7.5.         */    
***************************************************  

/* Program 7_5.sas */

options ls=80 ps=60 nodate nonumber;
title1 'Output 7.5: Restricted Nonorthogonal 3 Factor MANOVA Design';

data three;
   infile 'c:\7_5.dat';
   input a b c y1 y2 u1 - u18;
proc print data=three;
run;

/* Using PROC REG */
proc reg;
   title2 'Analysis using PROC REG';
   model y1 y2 = u1 - u18/noint;
   restrict .3333*u1+.3333*u2+.3333*u3-.3333*u4-
            .3333*u5-.3333*u6-.3333*u7-.3333*u8-
            .3333*u9+.3333*u10+.3333*u11+.3333*u12=0,
            .3333*u7+.3333*u8+.3333*u9-.3333*u10-
            .3333*u11-.3333*u12-.3333*u13-.3333*u14-
            .3333*u15+.3333*u16+.3333*u17+.3333*u18=0,
            .3333*u1-.3333*u2-.3333*u4+.3333*u5+
            .3333*u7-.3333*u8-.3333*u10+.3333*u11+
            .3333*u13-.3333*u14-.3333*u16+.3333*u17=0,
            .3333*u2-.3333*u3-.3333*u5+.3333*u6+
            .3333*u8-.3333*u9-.3333*u11+.3333*u12+
            .3333*u14-.3333*u15-.3333*u17+.3333*u18,
            u1-u2-u4+u5-u7+u8+u10-u11=0,
            u2-u3-u5+u6-u8+u9+u11-u12=0,
            u7-u8-u10+u11-u13+u14+u16-u17=0,
            u8-u9-u11+u12-u14+u15+u17-u18=0;

   A: mtest u1+u2+u3+u4+u5+u6-u13-u14-u15-u16-u17-u18=0,
            u7+u8+u9+u10+u11+u12-u13-u14-u15-u16-u17-u18=0/print details;

   B: mtest u1-u3+u4-u6+u7-u9+u10-u12+u13-u15+u16-u18=0,
            u2-u3+u5-u6+u8-u9+u11-u12+u14-u15+u17-u18=0/print details;

   C: mtest u1+u2+u3-u4-u5-u6+u7+u8+u9-u10-u11-u12+u13+u14+u15-u16-u17-u18=0
      /print details;

   AB: mtest u1-u2+u4-u5-u7+u8-u10+u11=0,
             u2-u3+u5-u6-u8+u9-u11+u12=0,
             u7-u8+u10-u11-u13+u14-u16+u17=0,
             u8-u9+u11-u12-u14+u15-u17+u18=0/print details;
run;

/* Using PROC GLM */
proc glm;
title2 'Analysis using PROC GLM';
   class a b c;
   model y1 y2 = a b c a*b/ss3;
   lsmeans a b c a*b;
   manova h=a b c a*b/printe printh;
run;

***************************************************     
/* The following code appears on page 311,         */    
/* where it is used to produce output 7.6.         */    
***************************************************  

/*Program 7_6.sas */

options  ls=80 ps=60 nodate nonumber;
title1 'Output 7.6: Restricted Intra-class Covariance Design';

data intra;
   infile 'c:\7_6.dat';
   input a b y1 y2 u1-u6 z1-z6;
proc print data=intra;
run;

/* Testing Equality of intra-class regression coefficients  */
proc reg;
   title2 'Testing Equality of Inta-class Regression Coefficients';
   model y1 y2 = u1 - u6 z1 - z6/noint;
   Parallel: mtest z1-z6=0,
             z2-z6=0,
             z3-z6=0,
             z4-z6=0,
             z5-z6=0;
   Coin: mtest z1-z6=0,z2-z6=0,z3-z6=0,z4-z6=0,z5-z6=0,
               u1-u6=0,u2-u6=0,u3-u6=0,u4-z6=0,u5-u6=0;
run;

/* MANCOVA model with unweighted and weighted tests*/
proc reg;
   title2 'MANCOVA Analyis using PROC REG';
   model y1 y2= u1 - u6 z1 - z6/noint;
   restrict z1-z6=0,
            z2-z6=0,
            z3-z6=0,
            z4-z6=0,
            z5-z6=0;
   A: mtest u1+u2+u3-u4-u5-u6=0;
   B: mtest u1-u3+u4-u6=0,
            u2-u3+u5-u6=0;
   AB: mtest u1-u3-u4+u6=0,
             u2-u3-u5+u6=0;
   Reg: mtest z6=0;
   Awt: mtest .4167*u1+.3333*u2+.25*u3-.3*u4-.4*u5-.3*u6=0;
   Bwt: mtest .625*u1-.5*u3+.375*u4-.5*u6=0,
              .500*u2-.5*u3+.500*u5-.5*u6=0;
run;

/* MANOVA model with unweighted tests */
proc reg;
   title2 ' Restricted Unweighted MANOVA tests using PROC REG';
   model y1 y2= u1 - u6 z1 -z6/noint;
   restrict z1=z2=z3=z4=z5=z6=0;
   A: mtest u1+u2+u3-u4-u5-u6=0;
   B: mtest u1-u3+u4-u6=0,
            u2-u3+u5-u6=0;
   AB: mtest u1-u3-u4+u6=0,
            u2-u3-u5+u6=0;
run;

data mancova;
   infile 'c:\7_6a.dat';
   input a b y1 y2 z;
proc print data=mancova;
run;

/* Unweighted MANOVA Analysis using GLM */
proc glm;
   title2 'Unweighted MANOVA tests using PROC GLM';
   class a b;
   model y1 y2=a b a*b/ss3;
   lsmeans a b a*b;
   manova h= a b a*b/htype=3 etype=3;
run;

/* Unweighted MANCOVA Analysis using GLM */
proc glm;
   title2 'Unweighted MANCOVA tests using PROC GLM';
   class a b;
   model y1 y2=a b a*b z/ss3;
   manova h=a b a*b z/htype=3 etype=3;
run;

***************************************************     
/* The following code appears on page 320,         */    
/* where it is used to produce output 7.7.         */    
***************************************************  

/* Program 7_7.sas */
/* Growth Curve Analysis (Grizzle and Allen, 1969) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 7.7: Growth Curve Analysis - Grizzle and Allen Data';

data grizzle;
   infile'c:\7_7.dat';
   input group y1 y2 y3 y4 y5 y6 y7;
proc print data=grizzle;
run;

proc summary data=grizzle;
   class group;
   var y1 -y7;
   output out=new mean=mr1-mr7;
proc print data=new;
run;
data plot;
   set new;
   array mr(7) mr1-mr7;
   do time = 1 to 7;
      response = mr(time);
      output;
   end;
drop mr1-mr7;
run;
proc plot;
   title2 'Growth Curve Plots of Group Means';
   plot response*time=group;
run;

proc glm data=grizzle;
   title2 'Transformed Data Polynomials';
    class group;
    model y1 - y7 = group/nouni;
    repeated time polynomial/summary nom nou;
run;

proc iml;
   use grizzle;
   read all var {y1 y2 y3 y4 y5 y6 y7} into y;
   read all var {Group} into gr;             
   /* Create Orthogonal Polynomials of degree  q-1=6 */
   x={1 2 3 4 5 6 7};
   P_prime=orpol(x,6);
   Y0=Y*P_prime;
   print 'P prime matrix',P_prime;
   t=y0||gr;
   /* Create New Transformed data set */
   varnames={yt1 yt2 yt3 yt4 yt5 yt6 yt7 group};
   create trans from t (|colname=varnames|);
   append from t;
quit;
run;
proc print data=trans; run;

/* Test of model fit  */
proc glm data=trans;
   title2 'Test of Cubic Fit';
   model yt5 - yt7=/nouni;
   manova h=intercept;
run;
proc glm data=trans;
   title2 'Test of Quadratic Fit';
   model yt4 - yt7=/nouni;
   manova h=intercept;
run;

/* Using a Rao-Khatri MANCOVA model         */
/* Test for group differences (coincidence) */
proc glm data=trans;
   title2 'Test of Group Differences';
   class group;
   model yt1 - yt4 = group yt5 - yt7/nouni;
   manova h=group/printh printe;
run;
/*Test for Parallelism of Profiles */
proc glm data=Trans;
   title2 ' Test of Parallelism';
   class group;
   model yt1 - yt4 = group yt5 - yt7/noint nouni;
   contrast 'parallel' group 1 -1 0 0,
                       group 1 0 -1 0,
                       group 1 0 0 -1;
   manova m=(0 1 0 0,
             0 0 1 0,
             0 0 0 1) prefix = parll/printe printh;
run;

/* Estimate of matrix B and contrasts */
proc glm data=trans;
   title2 ' Estimate of Matrix B';
   class group;
   model yt1 - yt4 = group yt5 - yt7;
   estimate 'beta1' intercept 1 group 1 0 0 0;
   estimate 'beta2' intercept 1 group 0 1 0 0;
   estimate 'beta3' intercept 1 group 0 0 1 0;
   estimate 'beta4' intercept 1 group 0 0 0 1;
   estimate '1vs2'  group 1 -1 0 0;
   estimate '1vs3'  group 1 0 -1 0;
   estimate '1vs4'  group 1 0 0 -1;
run;

***************************************************     
/* The following code appears on page 332,         */    
/* where it is used to produce output 7.8.         */    
*************************************************** 
 
/* Program 7_8.sas                     */
/* Growth Curve Analysis (Timm, 1980a) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 7.8: Multiple Response Growth Curve Analysis- Zullo data';

data zullo;
   infile 'c:\mmm.dat';
   input group y1 - y9;
proc print data=zullo;
run;

data test;
   set zullo;
   array z{9} y1 - y9;
   k=1;
   do rvar = 1,2,3;
      do time = 1,2,3;
         grmeans = z{k};
         k=k+1;
         output;
      end;     
   end;
   keep rvar group time grmeans;
run;
proc summary nway;
   class group rvar time;
   var grmeans;
   output out=new mean=grmeans;
proc print data = new;
run;
proc plot;
   title2 'Plot of Means';
   plot grmeans*time=group;
run;

proc iml;
   use zullo;
   read all var {y1 y2 y3 y4 y5 y6 y7 y8 y9} into y;
   read all var {Group} into gr;
   /* Create Orthogonal Polynomials of degree  q-1=2 */
   x={1 2 3};
   P=orpol(x,2);
   print P;
   P_prime=block(P,P,P);
   Y0=Y*P_prime;
   t=y0||gr;
   /* Create New Transformed data set */
   varnames={yt1 yt2 yt3 yt4 yt5 yt6 yt7 yt8 yt9 group};
   create trans from t (|colname=varnames|);
   append from t;
quit;
proc print data=trans;
run;

/* Test model adequacy or fit */
proc glm data=trans;
   title2 'Test of Fit - Linear';
   model yt3 yt6 yt9=;
   manova h=intercept;
run;
proc glm data=trans;
   title2 'Test of Fit - Quadratic(1)/Linear(2)';
   model yt6 yt9=/nouni;
   manova h=intercept;
run;

/* Test of significance of Beta weights */
proc glm data=trans;
   title2 'Test of Quadratic Beta Weights';
   class group;
   model yt1 - yt9 = group/noint nouni;
   contrast 'order' group 1 0,
                    group 0 1;
   manova m=(0 0 1 0 0 0 0 0 0,
             0 0 0 0 0 1 0 0 0,
             0 0 0 0 0 0 0 0 1);
run;

/* Using a Rao-Khatri MANCOVA model                     */
/* Test for group differences (coincidence) p=q and q<p */
proc glm data=trans;
   title2 'Coincidence p=q';
   class group;
   model yt1 - yt9 = group/nouni;
   manova h=group/printh printe;
run;

proc glm data=trans;
   title2 'Coincidence q<p';
   class group;
   model yt1 yt2 yt3 yt4 yt5 yt7 yt8 = group yt6 yt9/nouni;
   manova h=group/printh printe;
run;

/*Test for Parallelism of Profiles p=q and q<p  */
proc glm data=trans;
   title2 'Parallelism p=q';
   class group;
   model yt1 -yt9 = group/noint nouni;
   contrast 'parl(p=q)' group 1 -1;
   manova m=(0 1 0 0 0 0 0 0 0,
             0 0 1 0 0 0 0 0 0,
             0 0 0 0 0 0 0 0 0,
             0 0 0 0 1 0 0 0 0,
             0 0 0 0 0 1 0 0 0,
             0 0 0 0 0 0 0 1 0,
             0 0 0 0 0 0 0 0 1) prefix = parll/printe printh;
run;

proc glm data = trans;
   title2 'Parallelism q<p';
   class group;
   model yt1 yt2 yt3 yt4 yt5 yt7 yt8 = group yt6 yt9/noint nouni;
   contrast 'parl(q<p)' group 1 -1;
   manova m=(0 1 0 0 0 0 0,
             0 0 1 0 0 0 0,
             0 0 0 0 1 0 0,
             0 0 0 0 0 0 1) prefix = parl/printe printh;
run;

/* Estimate of matrix B and contrasts p=q and q<p */
proc glm data=trans;
   title2 'Beta Matrix p=q';
   class group;
   model yt1-yt9 =group;
   estimate 'beta1' intercept 1 group 1 0;
   estimate 'beta2' intercept 1 group 0 1;
   estimate '1vs2'  group 1 -1;
run;

proc glm data=trans;
   title2 'Beta Matrix q<p';
   class group;
   model yt1 yt2 yt3 yt4 yt5 yt7 yt8 = group yt6 yt9;
   estimate 'beta1' intercept 1 group 1 0;
   estimate 'beta2' intercept 1 group 0 1;
   estimate '1vs2'  group 1 -1;
run;

***************************************************     
/* The following code appears on page 345.         */    
/* Output is not shown in order to save space.     */
/* Results are summarized on page 347.             */    
***************************************************  

/* Program 7_9.sas                     */
/* Growth Curve Analysis (Timm, 1980a) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 7.9: Single Growth Curve Analysis';

data zullo;
   infile 'c:\mmm.dat';
   input group y1 - y9;
run;

data test;
   set zullo;
   array z{9} y1 - y9;
   k=1;
   do rvar = 1,2,3;
      do time = 1,2,3;
         grmeans = z{k};
         k=k+1;
         output;
      end;
   end;
   keep rvar time grmeans;
run;
proc summary nway;
   class rvar time;
   var grmeans;
   output out=new mean=grmeans;
run;
proc print data = new;
proc plot;
   title2 'Plot of Variable Means';
   plot grmeans*time;
run;

proc iml;
   use zullo;
   read all var {y1 y2 y3 y4 y5 y6 y7 y8 y9} into y;
   /* Create Orthogonal Polynomials of degree  q-1=2 */
   x={1 2 3};
   P=orpol(x,2);
   print P;
   P_prime=block(P,P,P);
   y0=y*P_prime;
   /* Create New Transformed data set */
   varnames={yt1 yt2 yt3 yt4 yt5 yt6 yt7 yt8 yt9 group};
   create trans from y0 (|colname=varnames|);
   append from y0;
   proc print data=trans;
quit;
run;

/* Test model adequacy or fit */
proc glm data=trans;
   title2 'Test of Model Adequacy';
   model yt6 yt9=/nouni;
   manova h=intercept;
run;

/* Using a Rao-Khatri MANCOVA model               */
/* Estimate of the matrix B using reg p=q and q<p */
proc reg data=trans;
   title2 'Estimate of B using PROC REG';
   model yt1 - yt5 yt7 yt8=/P;
   model yt1 - yt5 yt7 yt8=yt6/P;
   model yt1 - yt5 yt7 yt8=yt9/P;
   model yt1 - yt5 yt7 yt8=yt6 yt9/P;
run;

/* Using a Rao-Khatri MANCOVA model               */
/* Estimate of the matrix B using glm p=q and q<p */
proc glm data=trans;
   title2 'Estimate of B p=q using PROC GLM';
   model yt1 - yt5 yt7 yt8 = ;
   estimate 'beta' intercept 1;
run;
proc glm data=trans;
   title2 'Estimate of B q<p with var ty9 using PROC GLM';
   model yt1 - yt5 yt7 yt8 = yt9;
   estimate 'beta' intercept 1;
run;
***************************************************     
/* The following code appears on page 367,         */
/* where it is used to produce output 8.7.         */    
***************************************************  

/* Program 8_7.sas                          */
/* GMANOVA - SUR (Elston and Grizzle, 1962) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 8.7: GMANOVA-SUR One Population Ramus Height Data';

data ramus;
   infile'c:\8_7.dat';
   input group y1 y2 y3 y4;
proc print data=ramus;
run;
proc summary data=ramus;
   class group;
   var y1 -y4;
   output out=new mean=mr1-mr4;
proc print data=new;
run;
data plot;
   set new;
   array mr(4) mr1-mr4;
   do time = 1 to 4;
      response = mr(time);
      output;
   end;
   drop mr1-mr4;
run;
proc plot;
   title2 'Plot of Ramus Heights';
    plot response*time=group;
run;

proc iml;
   use ramus;
   read all var {y1 y2 y3 y4} into y;
   read all var {Group} into x;
   y1=y[1:20,1:1]; y2=y[1:20,2:2]; y3=y[1:20,3:3];y4=y[1:20,4:4];
   vecy=y1//y2//y3//y4;
   n=nrow(x);
   k=ncol(x);
   xpx=x`*x;
   xpxi=inv(xpx);
   s=(y`*y-y`*x*xpxi*x`*y)/(n-k);
   si=inv(s);
   print s;
   /*Input Polynomials of degree  q-1=3 */
   P_prime={1 -3 1 -1, 1 -1 -1 3, 1 1 -1 -3,1 3 1 1};
   p=p_prime[1:4,1:2];
   /* Estimate of B using SUR model with 2sls  */
   beta=((inv(p`*si*p)*p`*si)@(xpxi*x`))*vecy;
   print 'Estimate of B using SUR estimate and PROC IML', beta;
   Y0=Y*P_prime*inv(p_prime`*p_prime);
   print 'P prime matrix',P_prime;
   t=y0||x;
   varnames={yt1 yt2 yt3 yt4 x};
   create trans from t (|colname=varnames|);
   append from t;
quit;
run;

/* Test linear model fit or adequacy  */
proc glm data=trans;
   title2 'Test of Linear Fit';
   model yt3 yt4=/nouni;
   manova h=intercept;
run;

/* Estimate of B using a Rao-Khatri MANCOVA model  */
proc glm data=trans;
   title2 'Estimate of B using PROC GLM';
   class x;
   model yt1 yt2 = x yt3 yt4;
   estimate 'beta' intercept 1 x 1;
run;

/* Estimate of B using syslin procedure */
proc syslin sur data=trans;
   title2 'Estimate of B using PROC SYSLIN';
   model yt1 = x yt3 yt4/noint;
   model yt2 = x yt3 yt4/noint;
run;

***************************************************     
/* The following code appears on page 373,         */
/* where it is used to produce output 8.8.         */    
*************************************************** 

/* Program 8_8.sas                                      */
/* GMANOVA/SUR Several Groups (Grizzle and Allen, 1969) */

options ls = 80 ps = 60 nodate nonumber;
title1 'Output 8.8: GMANOVA-SUR Several Population Dog Data';

data grizzle;
   infile'c:\8_8.dat';
   input group y1 y2 y3 y4 y5 y6 y7 x1 x2 x3 x4;
proc print data=grizzle;
run;
proc summary data=grizzle;
   class group;
   var y1 -y7;
   output out=new mean=mr1-mr7;
proc print data=new;
run;
proc glm data=grizzle;
   class group;
   model y1 - y7 = group/nouni;
run;

proc iml;
   use grizzle;
   read all var {y1 y2 y3 y4 y5 y6 y7} into y;
   read all var {Group} into gr;
   read all var {x1 x2 x3 x4} into x;
   /* Create Orthogonal Polynomials of degree  q-1=6 */
   z={1 2 3 4 5 6 7};
   P_prime=orpol(z,6);
   Y0=Y*P_prime;
   print 'P prime matrix',P_prime;
   t=y0||x||gr;
   /* Create New Transformed data set */
   varnames={yt1 yt2 yt3 yt4 yt5 yt6 yt7 x1 x2 x3 x4 group};
   create trans from t (|colname=varnames|);
   append from t;
quit;
proc print data=trans;
run;

/* Test model fit  */
proc glm data=trans;
   title2 ' Test of Model Fit';
   model yt5 - yt7=/nouni;
   manova h=intercept;
run;

/* Using a Rao-Khatri MANCOVA model         */
/* Test for group differences (coincidence) */
proc glm data=trans;
   class group;
   model yt1 - yt4 = group yt5 - yt7/nouni;
   manova h=group/printh printe;
run;

/* Estimate of the matrix B */
proc glm data=trans;
   title2 'Estimate of B using PROC GLM';
   class group;
   model yt1 - yt4 = group yt5 - yt7;
   estimate 'beta1' intercept 1 group 1 0 0 0;
   estimate 'beta2' intercept 1 group 0 1 0 0;
   estimate 'beta3' intercept 1 group 0 0 1 0;
   estimate 'beta4' intercept 1 group 0 0 0 1;

/* Estimate of B using syslin procedure */
proc syslin sur data=trans;
   title2 'Estimate of B using PROC SYSLIN';
   model yt1 = x1 x2 x3 x4 yt5 yt6 yt7/noint;
   model yt2 = x1 x2 x3 x4 yt5 yt6 yt7/noint;
   model yt3 = x1 x2 x3 x4 yt5 yt6 yt7/noint;
   model yt4 = x1 x2 x3 x4 yt5 yt6 yt7/noint;
   coin: test x1=x2=x3=x4/print;
run; 

***************************************************     
/* The following code appears on page 378,         */
/* where it is used to produce output 8.9.         */    
*************************************************** 

/* Program 8_9.sas           */
/* Seemingly Unrelated Regressions (Greene, 1993, p.445) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 8.9: SUR - Greene-Grunfeld Investment Data';

data greene;
   infile'c:\8_9.dat';
   input year gm_i gm_f gm_c ch_i ch_f ch_c
              ge_i ge_f ge_c we_i we_f we_c
              us_i us_f us_c;
   label gm_i='Gross Investment GM'
         gm_f='Market Value GM prior yr'
         gm_c='Stock Value GM prior yr'
         ch_i='Gross Investment CH'
         ch_f='Market Value CH prior yr'
         ch_c='Stock Value CH prior yr'
         ge_i='Gross Investment GE'
         ge_f='Market Value GE prior yr'
         ge_c='Stock Value GE prior yr'
         we_i='Gross Investment WE'
         we_f='Market Value WE prior yr'
         we_c='Stock Value WE prior yr'
         us_i='Gross Investment US'
         us_f='Market Value US prior yr'
         us_c='Stock Value US prior yr';
proc print data=Greene;
run;

/* GM=General Moters, Ch=Chrysler, GE=General Electric,  */
/* WE=Westinghouse, and US=U.S. Steel                    */

/* SYSLIN procedure with SUR option */
proc syslin sur;
title2 'Using PROC SYSLIN with SUR Option';
   gm: model gm_i=gm_f gm_c;
   ch: model ch_i=ch_f ch_c;
   ge: model ge_i=ge_f ge_c;
   we: model we_i=we_f we_c;
   us: model us_i=us_f us_c;
   coin: stest gm.intercept-us.intercept,ch.intercept-us.intercept,
         ge.intercept-us.intercept,we.intercept-us.intercept,
         gm.gm_f-us.us_f,ch.ch_f-us.us_f,ge.ge_f-us.us_f,we.we_f-us.us_f,
         gm.gm_c-us.us_c,ch.ch_c-us.us_c,ge.ge_c-us.us_c,we.we_c-us.us_c;
run;

/* SYSLIN procedure using FIML option */
proc syslin fiml;
   title2 'Using PROC SYSLIN with FIML Option';
   endogenous gm_i ch_i ge_i we_i us_i;
   instruments gm_f gm_c ch_f ch_c ge_f ge_c we_f we_c us_f us_c;
   gm: model gm_i=gm_f gm_c;
   ch: model ch_i=ch_f ch_c;
   ge: model ge_i=ge_f ge_c;
   we: model we_i=we_f we_c;
   us: model us_i=us_f us_c;
run;

***************************************************     
/* The following code appears on page 392,         */
/* where it is used to produce output 8.10.        */    
***************************************************  

/* Program 8_10.sas                      */
/* SUR Changing Covariates (Patel, 1986) */

options ls=80 ps=60 nodate nonumber;
title 'Output 8.10: SUR - 2-Period Crossover Design with Changing Covariate';

data patel;
   infile'c:\8_10.dat';
   input group x y1 z1 y2 z2 x1 x2;
proc print data=patel;
run;

proc summary data=patel;
   class x;
   var y1 z1 y2 z2;
   output out=new mean=y1 z1 y2 z2;
proc print data=new;
run;

proc syslin sur data=patel;
   title2 'Esimates using PROC SYSLIN';
   s1: model y1=x z1/covb;
   s2: model y2=x z2/covb;
run;

proc iml;
   title2 'Estimates using PROC IML';
   use patel;
   read all var {y1 z1 y2 z2} into y;
   read all var {x} into m;
   read all var {x1 x2} into d;
   n=nrow(y);
   y1=y[1:17,1:1];y2=y[1:17,3:3];
   yt=y1||y2;
   z1=y[1:17,2:2];z2=y[1:17,4:4];
   z=z1||z2;
   x1=d||z1;x2=d||z2;
   y11=y[1:8,1:1];  z11=y[1:8,2:2];  y12=y[1:8,3:3];  z12=y[1:8,4:4];
   y21=y[9:17,1:1]; z21=y[9:17,2:2]; y22=y[9:17,3:3]; z22=y[9:17,4:4];
   m1=m[1:8,1:1]; m2=m[9:17,1:1];
   p1=m1*inv(m1`*m1)*m1`; p2=m2*inv(m2`*m2)*m2`;
   s=i(4);
   s[1,1]=y11`*y11-y11`*p1*y11+y21`*y21-y21`*p2*y21;
   s[2,2]=z11`*z11-z11`*p1*z11+z21`*z21-z21`*p2*z21;
   s[3,3]=y12`*y12-y12`*p1*y12+y22`*y22-y22`*p2*y22;
   s[4,4]=z12`*z12-z12`*p1*z12+z22`*z22-z22`*p2*z22;
   s[1,2]=y11`*z11-y11`*p1*z11+y21`*z21-y21`*p2*z21;
   s[1,3]=y11`*y12-y11`*p1*y12+y21`*y22-y21`*p2*y22;
   s[1,4]=y11`*z12-y11`*p1*z12+y21`*z22-y21`*p2*z22;
   s[2,3]=z11`*y12-z11`*p1*y12+z21`*y22-z21`*p2*y22;
   s[2,4]=z11`*z12-z11`*p1*z12+z21`*z22-z21`*p2*z22;
   s[3,4]=y12`*z12-y12`*p1*z12+y22`*z22-y22`*p2*z22;
   do i=1 to 4;
      do j=1 to 4;
         s[j,i]=s[i,j];
      end;
   end;
   print 'SS and SP matrix of (y1,z1,y2,z2)',s;
    /* Input SUR estimates from SYLIN output */
   bhat={0.442258 .097582,.815344 -.052338};
   ghat={0.84504 0,0 1.115726};
   vhat=(yt-d*bhat-z*ghat)`*(yt-d*bhat-z*ghat);
   sigma=vhat/n;
   print 'Residual SS matrix',vhat;
   print 'Estimate of SUR Covariance Matrix using vhat/n',sigma;
   covehat=inv(inv(sigma)@(x1`*x2));
   print 'Asymptotic Covariance Matrix of Parameters',covehat;
   /* Hypothesis test matrices */
   ct={1 -1 0 0 0 0,0 0 0 -1 1 0}; dft=nrow(ct);
   cgamma={0 0 1 0 0 1}; dfgamma=nrow(cgamma);
   ctxp={1 -1 0 1 1 0}; dftp=nrow(ctxp);
   theta={0.442258 .815344 .84504 .097582 -.052338 1.115726};
   /*  Wald test of treatment */
   chi_t=(ct*theta`)`*inv(ct*covehat*ct`)*(ct*theta`);
   p_t=1-probchi(chi_t,dft);
   print chi_t dft p_t;
   /* Wald test of no covariates */
   chi_g=(cgamma*theta`)`*inv(cgamma*covehat*cgamma`)*(cgamma*theta`);
   p_g=1-probchi(chi_g,dfgamma);
   print chi_g dfgamma p_g;
   /* Wald test of no treatment x period interaction */
   chi_tp=(ctxp*theta`)`*inv(ctxp*covehat*ctxp`)*(ctxp*theta`);
   p_tp=1-probchi(chi_tp,dftp);
   print chi_tp dftp p_tp;
quit;
run;

***************************************************     
/* The following code appears on page 399,         */
/* where it is used to produce output 8.11.        */    
***************************************************  

/* Program 8_11.sas          */
/* SUR Winer(1971, page 806) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 8.11:SUR - Repeated Measures with Changing Covariates';

data winer;
   infile'c:\8_11.dat';
   input group x1 x2 z1 y1 z2 y2 gr1 gr2 gr3;
proc print data=winer;
run;
proc summary data=winer;
   class x1;
   var z1 y1 z2 y2;
   output out=new mean= z1 y1 z2 y2;
proc print data=new;
run;

proc syslin sur data=winer;
   title2 'Estimate of B using SUR';
   s1: model y1=x1 x2 z1/covb;
   s2: model y2=x1 x2 z2/covb;
proc iml;
   title2 'Using Proc IML';
   use winer;
   read all var {y1 z1 y2 z2} into y;
   read all var {gr1 gr2 gr3} into d;
   n=nrow(y);
   y1=y[1:9,1:1];y2=y[1:9,3:3];
   yt=y1||y2;
   z1=y[1:9,2:2];z2=y[1:9,4:4];
   z=z1||z2;
   x1=d||z1;x2=d||z2;
   /* Input SUR estimates from SYLIN output */
   bhat={6.324944 11.102363, 3.361562 5.913461, 5.287068 9.017636};
   ghat={0.890147 0,0 0.804161};
   vhat=(yt-d*bhat-z*ghat)`*(yt-d*bhat-z*ghat);
   sigma=vhat/n;
   print 'Residual SS matrix',vhat;
   print 'Estimate of SUR Covariance Matrix using vhat/n',sigma;
   covehat=inv(inv(sigma)@(x1`*x2));
   print 'Asymptotic Covariance Matrix of Parameters',covehat;
   /* Hypothesis test matrices */
   mt={1 0 -1 0 0  0  0 0,
       0 1 -1 0 0  0  0 0,
       0 0  0 0 1 -1  0 0,
       0 0  0 0 0  1 -1 0}; dfmt=nrow(mt);
   cgamma={0 0 0 1 0 0 0 -1}; dfgamma=nrow(cgamma);
   theta={6.324944 3.361562 5.287068 0.890147
         11.102363 5.913461 9.017636 0.804161};
   print theta;
   /*  Wald test of multivariate treatment */
   chi_mt=(mt*theta`)`*inv(mt*covehat*mt`)*(mt*theta`);
   p_mt=1-probchi(chi_mt,dfmt);
   print 'Multivariate test of intercepts',mt;
   print chi_mt dfmt p_mt;
   /* Wald test of equal covariates */
   print 'Equality of Covariates', cgamma;
   chi_g=(cgamma*theta`)`*inv(cgamma*covehat*cgamma`)*(cgamma*theta`);
   p_g=1-probchi(chi_g,dfgamma);
   print chi_g dfgamma p_g;
quit;
run;

***************************************************     
/* The following code appears on page 405,         */
/* where it is used to produce output 8.12.        */    
***************************************************  

/* Program 8_12.sas                              */
/* MANOVA-GMANOVA, Chinchilli and Elswick (1985) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 8.12: MANOVA-GMANOVA Model';

data chinels;
   infile'c:\8_12.dat';
   input group d1 d2 d3 d4 z1 y1 - y5;
proc print data=chinels;
run;
proc summary data=chinels;
   class group;
   var y1 - y5 z1;
   output out=new1 mean= y1 - y5 z1;
proc print data=new1;
run;
data plot;
   set new1;
   array mr(5) y1 - y5;
   do time = 1 to 5;
      response = mr(time);
      output;
   end;
   drop mr1 - mr5;
proc plot;
   plot response*time=group;
run;

proc glm data=chinels;
   model y1 - y5 = group/nouni;
   repeated time polynomial/summary nom nou;
run;

proc iml;
   use chinels;
   read all var {y1 y2 y3 y4 y5} into y;
   read all var {d1 d2 d3 d4} into x1;
   read all var {group} into gr;
   read all var {z1} into z;
   /* Create Orthogonal Polynomials of degree 9  */
   t={1 2 3 4 5};
   p_prime=orpol(t,4);
   y0=y*p_prime;
   new=y0||x1||gr||z;
   /*Create Transformed data set */
   varnames={yt1 yt2 yt3 yt4 yt5 d1 d2 d3 d4 group z};
   create trans from new (|colname=varnames|);
   append from new;
quit;
proc print data=trans;
run;

/*Test of fit, ignoring covariates */
proc glm data=trans;
   title2 'Test of Fit, Ignoring Covariate';
   model yt5=/nouni;
   manova h=intercept;
run;

/*Estimate of growth matrix B ignoring covariate */
proc glm data=trans;
   title2 'Estimate of B ignoring Covariate';
   class group;
   model yt1 yt2 = group yt3-yt5;
   estimate 'beta1' intercept 1 group 1 0 0 0;
   estimate 'beta2' intercept 1 group 0 1 0 0;
   estimate 'beta3' intercept 1 group 0 0 1 0;
   estimate 'beta4' intercept 1 group 0 0 0 1;
run;

/* Goodness-of-Fit Test of GMANOVA Model vs mixed GMANOVA-MANOVA */
/* using PROC IML */
proc iml;
   title2 'Test of Fit of GMANOVA vs GMANOVA-MANOVA, Using PROC IML';
   use trans;
   read all var {yt3 yt4 yt5} into y;
   read all var {z} into z;
   gam_str=inv(z`*z)*z`*y;print 'Gamma Star',gam_str;
   h=y`*z*inv(z`*z)*z`*y; print 'Hypothesis Matrix',h;
   e=y`*y-h;print 'Error Matrix',e;
   den=h+e;print 'H + E Matrix',den;
   lamda=det(e)/det(e+h);
   c=root(e);
   g=(inv(c`)*h*inv(c));
   values=eigval(round(g,.00001));
   print 'Eigenvalues',values;
   print 'Wilks Lamda',lamda;

/* Using PROC GLM */
proc glm data=trans;
   title2 'Test of GMANOVA vs GMANOVA-MANOVA, Using PROC GLM';
   model yt3 yt4 yt5 =z/noint;
   manova h=z/printe printh;
run;

/*Goodness-of-Fit test of mixed GMANOVA-MANOVA model vs MANOVA */
/* Using PROC IML */
proc iml;
   title2 'Test of GMANOVA-MANOVA vs MANOVA, Using PROC IML';
   use trans;
   read all var {yt3 yt4 yt5} into y;
   read all var {d1 d2 d3 d4 z} into x;
   read all var {z} into z;
   h=y`*x*inv(x`*x)*x`*y-y`*z*inv(z`*z)*z`*y;
   print 'Hypothesis Matrix ', h;
   e=y`*y-y`*x*inv(x`*x)*x`*y;
   print 'Error Matrix',e;
   den=h+e; print 'H + E Matrix',den;
   lamda=det(e)/det(e+h);
   c=root(e);
   g=(inv(c`)*h*inv(c));
   values=eigval(round(g,.0001));
   print 'Eigenvalues',values;
   print 'Wilks Lamda',lamda;
quit;
run;

/*Using PROC GLM */
proc glm data=trans;
   title2 'Test of GMANOVA-MANOVA vs MANOVA, Using PROC GLM';
   class group;
   model yt3 yt4 yt5 = group z/noint nouni;
   manova h=group/printe printh;
run;

/*Obtain mixed GMANOVA-MANOVA parameter estimates and Tests*/
proc iml;
   title2 'GMANOVA-MANOVA Parameter Estimates and Tests';
   use chinels;
   read all var {y1 y2 y3 y4 y5} into y;
   read all var {d1 d2 d3 d4}  into x1;
   read all var {d1 d2 d3 d4 z1} into x;
   read all var {z1} into z;
   use trans;
   read all var {yt1 yt2} into y0;
   read all var {yt3 yt4 yt5} into y0c;
   t={1 2 3 4 5};
   p_prime=orpol(t,4);
   p=p_prime[1:5,1:2];
   pc=p_prime[1:5,3:5];
   h1=p`; x2=p`;
   h2=pc`;
   n=nrow(y); m1=ncol(x1); m2=ncol(z); p=ncol(y); q=nrow(h1);
   print n m1 m2 p q;
   e1=y`*y-y`*x1*inv(x1`*x1)*x1`*y;
   w=i(5)-inv(e1)*x2`*inv(x2*inv(e1)*x2`)*x2;
   sigma1=(e1+w`*y`*x1*inv(x1`*x1)*x1`*y*w)/n;
   print 'ML estimate of sigma Gmanova Model',sigma1;
   sigma=sigma1-(w`*y`*z*inv(z`*z)*z`*y*w)/n;
   print 'ML estimate of sigma Gmanova-Manova Model', sigma;
   c=inv(x`*x);
   x11=c[1:4,1:4]; x12=c[1:4,5:5];
   x21=c[5:5,1:4]; x22=c[5:5,5:5];
   theta=(x11*x1`+x12*z`)*y*inv(e1)*x2`*inv(x2*inv(e1)*x2`);
   print 'Theta Hat Matrix',theta;
   gamma0=(x21*x1`+x22*z`)*y*inv(e1)*x2`*
          inv(x2*inv(e1)*x2`)*x2+inv(z`*z)*z`*y*w;
   print 'Gamma Zero Hat Matrix',gamma0;
   /*Begin test gamma0 equal to zero  */
   e=y`*y-y`*x*inv(x`*x)*x`*y;
   e1t=inv(x2*inv(e)*x2`);print e1t;
   e2=y`*y-y`*z*inv(z`*z)*z`*y;
   e2t=h2*e2*h2`;print e2t;
   eta=gamma0*inv(e)*x2`*inv(x2*inv(e)*x2`);
   r2=(x22+x21*x1`+x22*z`)*y*(inv(e)-inv(e)*x2`*inv(x2*inv(e)*x2`)*x2*inv
      (e))*y`*(x1*x12+z*x22);
   h1t=eta`*inv(r2)*eta;print h1t;
   h2t=(gamma0*h2`)`*(z`*z)*(gamma0*h2`);print h2t;
   lamda1=det(e1t)/(det(e1t+h1t)); lamda2=det(e2t)/(det(e2t+h2t));
   new1=n-m1-m2-p+q; g1=3; u1=q; v1=(u1-g1+1)/2;
   chi1=-(new1-v1)#log(lamda1); df1=u1#g1;
   new2=n-m2; g2=1; u2=p-q; v2=(u2-g2+1)/2;
   chi2=-(new2-v2)#log(lamda2); df2=u2#g2;
   print 'For test of gamma0', lamda1 chi1 df1;
   print                       lamda2 chi2 df2;
   pval1=1-probchi(chi1,df1);pval2=1-probchi(chi2,df2);k=m1+m2+p-q;
   rho1=1-(k-g1+v1)/n; gamma1=new1#(u1**2+g1**2-5)/(48#(rho1#n)**2);
   rho2=1-(m2-g2+v2)/n;gamma2=new2#(u2**2+g2**2-5)/(48#(rho2#n)**2);
   print rho1 rho2 gamma1 gamma2;
   pval1=(1-gamma1)#(1-probchi(chi1,df1))+gamma1#(1-probchi(chi1,df1+4));
   pval2=(1-gamma2)#(1-probchi(chi2,df2))+gamma2#(1-probchi(chi2,df2+4));
   pvalue=pval1+pval2;
   print 'p-value of test H2: gamma0=zero' pval1 pval2 pvalue;
   /*Begin test of Coincidence of profiles */
   c1={1 -1 0 0, 1 0 -1 0, 1 0 0 -1};
   a1=i(2);
   e=a1`*e1t*a1;
   r1=x11+(x11*x1`+x12*z`)*y0c*inv(y0c`*y0c-y0c`*x*inv(x`*x)*x`*y0c)*y0c`*
      (x1*x11+z*x21);
   h=(c1*theta*a1)`*inv(c1*r1*c1`)*(c1*theta*a1);
   lamda=det(e)/det(e+h);
   dfe=n-m1-m2-p+q; dfh=3; u=2;
   chi_2=-(dfe-(u-dfh+1)/2)#log(lamda); df=u#dfh; v1=(u+dfh+1)/2;
   print 'Test of Coincidence Wilks and Chi-square' lamda dfe dfh chi_2 df;
   new=u*dfh; rho=1-(k-dfh+v1)/n; omega=new#(u**2+dfh**2-5)/(48#(rho#n)**2);
   print rho omega;
   pval=(1-omega)#(1-probchi(chi_2,df))+omega#(1-probchi(chi_2,df+4));
   print 'p-value of test H1: Coincidence' pval;
quit;
run;

***************************************************     
/* The following code appears on page 416,         */
/* where it is used to produce output 8.13.        */    
***************************************************  

/* Program 8_13.sas              */
/* GMANOVA Model,  Hecker(1987)  */

options ls=80 ps=60 nodate nonumber;
title1 'Output 8.13: CGMANOVA Model';

data gman;
   infile'c:\8_13.dat';
   input group d1 d2 d3 d4 z1 y1 - y5;
run;

proc iml;
   use gman;
   read all var {y1 y2 y3 y4 y5} into y;
   read all var {d1 d2 d3 d4}  into x1;
   read all var {d1 d2 d3 d4 z1} into x;
   read all var {z1} into z;
   t={1 2 3 4 5};
   p_prime=orpol(t,4);
   p=p_prime[1:5,1:2];
   x2=p`;
   n=nrow(y);
   k=ncol(y);
   one=j(n,1,1);
   sigma=(y`*y-y`*one*inv(one`*one)*one`*y)/n;
   print 'Consistent Estimator of Covariance Matrix', sigma;
   d1=x1@x2`; d2=z@i(5);
   d=d1||d2;
   yc=shape(y,225,1,0);
   v=i(n)@inv(sigma);
   theta=inv(d`*v*d)*d`*inv((i(n)@sigma))*yc;
   print 'GLSE of Parameter Matrix', theta;
   /* Test of Coincidence  */
   c={1 0 0 0 0 0 -1  0 0 0 0 0 0,
      0 1 0 0 0 0  0 -1 0 0 0 0 0,
      0 0 1 0 0 0 -1  0 0 0 0 0 0,
      0 0 0 1 0 0  0 -1 0 0 0 0 0,
      0 0 0 0 1 0 -1  0 0 0 0 0 0,
      0 0 0 0 0 1  0 -1 0 0 0 0 0};
   w=(c*theta)`*inv(c*inv(d`*v*d)*c`)*(c*theta);
   df=6;
   pvalue=1-probchi(w,df);
   print 'Wald Statistic for Coincidence',w df pvalue;
   /* Test Gamma0 equals zero   */
   c={0 0 0 0 0 0 0 0 1 0 0 0 0,
      0 0 0 0 0 0 0 0 0 1 0 0 0,
      0 0 0 0 0 0 0 0 0 0 1 0 0,
      0 0 0 0 0 0 0 0 0 0 0 1 0,
      0 0 0 0 0 0 0 0 0 0 0 0 1};
   w=(c*theta)`*inv(c*inv(d`*v*d)*c`)*(c*theta);
   df=5;
   pvalue =1-probchi(w,df);
   print 'Wald Statistic for Gamma0=0',w df pvalue;
quit;
run;

***************************************************     
/* The following code appears on page 433,         */
/* where it is used to produce output 9.3.         */    
***************************************************  

/* Program 9_3.sas                                      */
/* Random Coefficient Model - Elston and Grizzle (1962) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 9.3: Random Coefficient Model One Population';

data ramus;
   infile 'c:\ramus.dat';
   input group y1 y2 y3 y4 boys;
   y=y1; age=8;   x=-3; output;
   y=y2; age=8.5; x=-1; output;
   y=y3; age=9;   x=1;  output;
   y=y4; age=9.5; x=3;  output;
proc print data=ramus;
   title2 'Original Ramus Height Data for Growth Curve Analysis';
run;
proc summary data=ramus;
   class boys;
   var y1-y4;
   output out=new mean=mr1-mr4;
proc print data=new;
   title2 'Reformated Ramus Height Data for PROC MIXED';
run;
data plot;
   set new;
   array mr(4) mr1-mr4;
   do time = 1 to 4;
      response= mr(time);
      output;
   end;
   drop mr1-mr4;
proc plot;
   title2 'Individual Profiles';
   plot response*time=boys;
run;
proc mixed data=ramus method=reml covtest ratio;
   title2 'Linear Growth with Random Slope and Variance Components';
   class boys;
   model y=x/s p;
   random boys/type=vc subject=boys;
   repeated /type=simple subject=boys r;
run;
proc mixed data=ramus method=reml covtest ratio;
   title2 'Linear Growth with Random Slope and Unknown Structure';
   class boys;
   model y=x/s p;
   repeated /type=un subject=boys r;
run;
proc mixed data=ramus method=reml covtest ratio;
   title2 'Linear Growth with Random Slope and Compound Symmetry Structure';
   class boys;
   model y=x/s p;
   repeated /type=cs subject=boys r;
run;
proc genmod data=ramus;
   title2 'Linear Growth and Homogeniety of Variance';
   class boys;
   model y=x/dist=normal link=identity lrci waldci obstats;
run;

***************************************************     
/* The following code appears on page 440,         */
/* where it is used to produce output 9.4.         */    
*************************************************** 

/* Program 9_4.sas                                          */
/* Random Coefficient Growth Curve (Grizzle and Allen,1969) */

options ls=80 ps=60 nodate nonumber;
title 'Output 9.4: Random Coefficient Model Several Populations';

data grizzle;
   infile 'c:\7_7.dat';
   input treat y1 y2 y3 y4 y5 y6 y7 dog;
   y=y1; time= 1; x1=-3; x2= 5; x3=-1; output;
   y=y2; time= 3; x1=-2; x2= 0; x3= 1; output;
   y=y3; time= 5; x1=-1; x2=-3; x3= 1; output;
   y=y4; time= 7; x1= 0; x2=-4; x3= 0; output;
   y=y5; time= 9; x1= 1; x2=-3; x3=-1; output;
   y=y6; time=11; x1= 2; x2= 0; x3=-1; output;
   y=y7; time=13; x1= 3; x2= 5; x3= 1; output;
   drop y1- y7;
proc print data=grizzle;
   title2 'Grizzle and Allan Dog Data';
run;
proc mixed data=Grizzle method=reml covtest ratio;
   title2 'Hierarchical Random Coefficient Growth Curve Model';
   class treat dog;
   model y=treat x1 x2 x3/s p;
   random intercept x1 x2 x3/type=un subject=dog g s;
   lsmeans treat;
run;
proc mixed data=grizzle method=reml covtest ratio;
   title2 'Growth Curve Model Unknown Structure';
   class treat dog;
   model y=treat x1 x2 x3/s p;
   repeated/type=un subject=dog r;
   lsmeans treat;
run;
proc mixed data=grizzle method=reml covtest ratio;
   title2 'Growth Curve Model Compound Symmetry';
   class treat dog;
   model y=treat x1 x2 x3/s p;
   repeated/type=cs subject=dog r;
   lsmeans treat;
run;
proc mixed data=grizzle method=reml covtest ratio;
   title2 'Growth Curve Model with Heterogeneous Compound Symmetry';
   class treat dog;
   model y=treat x1 x2 x3/noint s;
   repeated intercept diag/subject=dog group=treat;
   contrast 'group diff'
            treat 1 0 0 -1,
            treat 0 1 0 -1,
            treat 0 0 1 -1;
run;
 
***************************************************     
/* The following code appears on page 449,         */
/* where it is used to produce output 9.5.        */    
*************************************************** 

/* Program 9_5.sas                */
/* Data from Timm(1975, page 244) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 9.5: Analysis of Repeated Measurements Using PROC MIXED';

data timm;
   infile 'c:\9_5.dat';
   input group subj probe y;
proc print data=timm;
proc mixed covtest ratio;
   title2 'Compound Symmetry';
   class group subj probe;
   model y = group probe group*probe;
   repeated/type=cs subject=subj(group) r;
run;
proc mixed covtest ratio;
   title2 'Unknown Structure';
   class group subj probe;
   model y= group probe group*probe/ddfm=satterth;
   repeated/type=un subject=subj(group) r;
run; 

***************************************************     
/* The following code appears on page 453,         */
/* where it is used to produce output 9.6.         */    
*************************************************** 

/* Program 9_6.sas                                      */
/* Mixed Model - Winer(1971, page 806) and Patel (1986) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 9.6: Mixed Model Repeated Measures with Changing Covariates';

data winer;
   input person g b x y @@;
   cards;
   1 1 1  3  8 1 1 2  4 14
   2 1 1  5 11 2 1 2  9 18
   3 1 1 11 16 3 1 2 14 22
   4 2 1  2  6 4 2 2  1  8
   5 2 1  8 12 5 2 2  9 14
   6 2 1 10  9 6 2 2  9 10
   7 3 1  7 10 7 3 2  4 10
   8 3 1  8 14 8 3 2 10 18
   9 3 1  9 15 9 3 2 12 22
   ;

proc print data=winer;
proc mixed data=winer method=ml covtest ratio;
   title2 'Variance Components';
   class person g b;
   model y =  g b g*b x;
   random person/type=vc subject=person;
   repeated/type=simple subject=person r;
run;
proc mixed data=winer method=ml covtest ratio;
   title2 'Unknown Covariance Matrix';
   class person g b;
   model y = g b g*b x;
   repeated/type=un subject=person r;
run;
proc mixed data=winer method=ml covtest ratio;
   title2 'Compound Symmetry';
   class person g b;
   model y = g*b x/noint s;
   contrast 'G'  g*b 1 1 0 0 -1 -1,
                 g*b 0 0 1 1 -1 -1;
   contrast 'B'  g*b 1 -1 1 -1 1 -1;
   contrast 'BG' g*b 1 -1 -1 1 0 0,
                 g*b 0  0  1 -1 -1 1;
   repeated/type=cs subject=person r;
run;
proc glm;
   title2 'Mixed Model Compound Symmetry';
   class person g b;
   model y= g person(g) b g*b x;
   test  h=g e=person(g);
run;

data patel;
   infile'c:\patel.dat';
   input treat person period y z1 z2;
proc print data=patel;
   title2 'Patel data';
proc mixed data=patel method=ml covtest ratio;
   class treat person period;
   model y=treat*period z1 z2/noint s;
   contrast 'treat' treat*period 1 1 -1 -1;
   estimate 'treat(delta)' treat*period 1 1 -1 -1;
   contrast 'inter' treat*period 1 -1 -1 1;
   repeated /type=un subject=person r;
run; 

***************************************************     
/* The following code appears on page 463,         */
/* where it is used to produce output 9.7.         */    
*************************************************** 

/* Program 9_7.sas                          */
/* ANOVA data HLM Model (Raudenbush,1993)   */

options ls=80 ps=60 nodate nonumber;
title1 'Output 9.7: HLM Examples';

data hlm1;
   infile 'c:\hlm.dat';
   input treat y;
proc print data=hlm1;
   title2 'HLM One-Way ANOVA';
run;
proc mixed data=hlm1 method=reml covtest ratio;
   class treat;
   model y=/s;
   random intercept/type=vc subject= treat g;
run;

data hlm2;
   infile 'c:\hlmnest.dat';
   input method classes y;
proc print data=hlm2;
   title2 'HLM Nested Two-Factor ANOVA';
proc mixed data=hlm2 method=reml covtest ratio;
   class method classes;
   model y = method/noint s;
   random classes/type=vc subject=method g;
   estimate 'overall mean' method .5 .5;
   estimate 'contrast diff method' method 1 -1;
run;

data hlm3;
   infile 'c:\hlmcross.dat';
   input practice tutor y;
proc print data=hlm3;
   title2 ' HLM Crossed Two-Factor Mixed MANOVA';
proc mixed data=hlm3 method=reml covtest ratio;
   class tutor;
   model y = practice/ s;
   random intercept practice/ type=un subject=tutor;
run;

data hlm4;
   infile 'c:\hlmsplit.dat';
   input person y1 y2 y3 y4;
   y=y1; dur=1; x1=-1.5; x2= .5; x3= -.5; output;
   y=y2; dur=2; x1= -.5; x2=-.5; x3= 1.5; output;
   y=y3; dur=3; x1=  .5; x2=-.5; x3=-1.5; output;
   y=y4; dur=4; x1= 1.5; x2= .5; x3=  .5; output;
proc print data=hlm4;
   title2 'HLM Repeated Measures';
proc mixed data=hlm4 method=reml covtest ratio;
   class person;
   model y= x1 x2 x3 / s;
   repeated /type=cs subject=person r;
   contrast 'duration' x1 1, x2 1 x3 1;
run; 

***************************************************     
/* The following code appears on page 475,         */
/* where it is used to produce output 9.8.         */    
*************************************************** 
/* Program 9_8.sas               */
/* HLM Manual Byrk et al. (1988) */

options ls=80 ps=60 nodate nonumber;
title 'Output 9.8: HLM Manual Rat Data';

data hlm5;
   infile 'c:\hlmrat.dat';
   input rat y1 y2 y3 y4 y5 z;
         y=y1;week=0;x=-2;output;
         y=y2;week=1;x=-1;output;
         y=y3;week=2;x= 0;output;
         y=y4;week=3;x= 1;output;
         y=y5;week=4;x= 2;output;
proc print data=hlm5;
   title2 'Random Coefficient Model Unknown Covariance Structure';
run;
proc mixed data=hlm5 method=reml covtest ratio;
   class rat;
   model y=x z/s p;
   random intercept x/type=un subject=rat g s;
   repeated /type=simple subject=rat r;
   make 'solutionr' out=eblups;
run;

data extract;
   set eblups;
   retain constant;
   if _effect_='INTERCEPT' then constant=_est_;
      else do;
         slope=_est_; output;
      end;
   keep slope constant;
run;
data raw;
   infile 'c:\hlmrat.dat';
   input rat y1 y2 y3 y4 y5 z;
data new;
   merge raw extract;
proc print data=new;
   title2 'Rat Data and Random Model Estimates';
run;
proc plot data=new;
   plot slope*z / hpos=30 vpos=25;
proc reg data=new;
   title2 'Slope Regression Analysis';
   model slope=z/stb;
run;
proc mixed data=hlm5 method=reml covtest ratio;
   title2 'Covariance Structure Compound symmetry';
   class rat;
   model y = x z/s;
   random int x/type=cs subject=rat g;
   repeated /type=simple subject=rat;
run;
proc mixed data=hlm5 method=reml covtest ratio;
   title2 'Variance Components Model';
   class rat;
   model y = x z/s;
   random int x/type=vc subject=rat g;
   repeated /type=simple subject=rat;
run; 

***************************************************     
/* The following code appears on page 493,         */
/* where it is used to produce output 10.4.        */    
*************************************************** 

/* Program 10_4.sas                                     */
/* Repeated Measures Missing Data (Cole & Grizzle,1966) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 10.4: Repeated Measures Analysis with Missing Data';

data cole;
   infile 'c:\10_4.dat';
   missing m;
   input dog drug y1 y2 y3 y4;
   y=log(y1); time= 1; output;
   y=log(y2); time= 2; output;
   y=log(y3); time= 3; output;
   y=log(y4); time= 4; output;
proc print data=cole;
run;
proc mixed data=Cole method=ml scoring;
   title2 'Mixed Model Missing Data Compound Symmetry';
   class drug time dog;
   model y=drug time drug*time/s;
   repeated/type=cs subject=dog r;
run;
proc mixed data=cole method=ml scoring;
   title2 'Mixed Model Missing Data Unstructured Covariance Matrix';
   class drug time dog;
   model y=drug time drug*time/s;
   repeated/type=un subject=dog r;
run;
data cole;
   infile 'c:\10_4.dat';
   missing m;
   input dog drug y1 y2 y3 y4;
   y1=log(y1);
   y2=log(y2);
   y3=log(y3);
   y4=log(y4);
proc print data=cole;
run;

proc glm;
   title2 ' MANOVA with Listwise Deletion ';
   class drug;
   model y1-y4=drug/intercept nouni;
   means drug;
   /*Multivariate test of group differences for mean vectors */
   manova h = drug/printe printh;
   /*Multivariate test of Conditions given Parallel Profiles */
   /*Multivariate test of Parallelism (Drug x Trial Interaction) */
   manova h =_all_ m=(1 -1  0  0,
                     0  1 -1  0,
                     0  0  1 -1) prefix = diff/printe printh;
   /*Test of group differences given Parallelism */
   contrast 'Drug Diff' drug 1 0 0 -1,
                        drug 0 1 0 -1,
                        drug 0 0 1 -1;
   manova m=(1 1 1 1 ) prefix=Drug/printe printh;
run;

data cole;
   title2 '';
   infile 'c:\10_4.mea';
   input dog drug y1 y2 y3 y4;
   y1=log(y1);
   y2=log(y2);
   y3=log(y3);
   y4=log(y4);
proc print data=cole;
run;

proc glm;
   title2 'MANOVA with Mean Substitution';
   class drug;
   model y1-y4=drug/intercept nouni;
   means drug;
   /*Multivariate test of group differences for mean vectors */
   manova h = drug/printe printh;
   /*Multivariate test of Conditions given Parallel Profiles */
   /*Multivariate test of Parallelism (Drug x Trial Interaction) */
   manova h =_all_ m=(1 -1  0  0,
                      0  1 -1  0,
                      0  0  1 -1) prefix = diff/printe printh;
   /*Test of group differences given Parallelism */
   contrast 'Drug Diff' drug 1 0 0 -1,
                       drug 0 1 0 -1,
                       drug 0 0 1 -1;
  manova m=(1 1 1 1 ) prefix=Drug/printe printh;
run;

proc glm;
   title2 'MANOVA Analysis by Cole and Grizzle with mean substitution';
   class drug;
   model y2-y4=drug/intercept nouni;
   /*Multivariate tests performed by Cole and Grizzle */
   /*Multivariate test of Conditions given Parallel Profiles */
   /*Multivariate test of Parallelism (Drug x Trial Interaction) */
   manova h =_all_ m=(1  0 -1,
                      0  1 -1) prefix = diff/printe printh;
   /*Test of group differences given Parallelism */
   contrast 'Drug Diff' drug 1 0 0 -1,
                        drug 0 1 0 -1,
                        drug 0 0 1 -1;
   manova m=(1 1 1 ) prefix=Drug/printe printh;
run;


***************************************************     
/* The following code appears on page 502,         */
/* where it is used to produce output 10.5.        */    
***************************************************

/* Program 10_5.sas                                 */
/* Mixed Model - Winer(1971, page 806) Missing Data */

options ls=80 ps=60 nodate nonumber;
title1 'Output 10.5: Repeated Measures w/changing covariates, Missing Data';

data winer;
   missing m;
   input person a b x y @@;
   cards;
   1 1 1  3  m 1 1 2  4 14
   2 1 1  5 11 2 1 2  9 18
   3 1 1  m  m 3 1 2 14 22
   4 m 1  2  6 4 m 2  1  8
   5 2 1  8 12 5 2 2  9 14
   6 2 1 10  9 6 2 2  9 10
   7 3 1  7 10 7 3 2  4 10
   8 3 1  8  m 8 3 2 10  m
   9 3 1  9 15 9 3 2 12 22
   ;
proc print data=winer;
   title2 'Winer Data';
run;

proc mixed data=winer method=ml scoring;
   title2 'Compound Symmetry';
   class person a b;
   model y = a b a*b x/p;
   repeated/type=cs subject=person r;
run;

proc mixed data=winer method=ml scoring;
   title2 'Unknown Structure';
   class person a b;
   model y = a b a*b x;
   repeated /type=un subject=person r;
run; 

***************************************************     
/* The following code appears on page 506,         */
/* where it is used to produce output 10.6.        */    
*************************************************** 

/* Program 10_6.sas                                          */
/* Random Coefficient - Lindsey(1993, page 222) Missing Data */

options ls=80 ps=60 nodate nonumber;
title1 'Output 10.6: Random Coefficient Model with Missing Data';

data lindsey;
   missing m;
   infile 'c:\10_6.dat';
   input group y1  y2  y3  y4  y5  y6  y7  y8  y9 y10 y11 y12 y13 y14 y15
         y16 y17 y18 y19 y20 y21 y22 y23 y24 y25 y26 y27 y28 y29 y30
         aircraft;
   y=y1 ; fail= 1; output; y=y2 ; fail= 2; output; y=y3 ; fail= 3; output;
   y=y4 ; fail= 4; output; y=y5 ; fail= 5; output; y=y6 ; fail= 6; output;
   y=y7 ; fail= 7; output; y=y8 ; fail= 8; output; y=y9 ; fail= 9; output;
   y=y10; fail=10; output; y=y11; fail=11; output; y=y12; fail=12; output;
   y=y13; fail=13; output; y=y14; fail=14; output; y=y15; fail=15; output;
   y=y16; fail=16; output; y=y17; fail=17; output; y=y18; fail=18; output;
   y=y19; fail=19; output; y=y20; fail=20; output; y=y21; fail=21; output;
   y=y22; fail=22; output; y=y23; fail=23; output; y=y24; fail=24; output;
   y=y25; fail=25; output; y=y26; fail=26; output; y=y27; fail=28; output;
   y=y28; fail=28; output; y=y29; fail=29; output; y=y30; fail=30; output;
proc summary data=lindsey;
   class aircraft;
   var y1-y30;
   output out=new mean=mr1-mr30;
run;
proc print data=new;
   data plot;
   set new;
   array mr(30) mr1-mr30;
   do failures = 1 to 30;
      hours = mr(failures);
      output;
   end;
   drop mr1-mr30;
proc plot;
   plot hours*failures=aircraft;
run;
proc mixed data=lindsey;
   title2 'Random Intercept and Slope';
   class aircraft;
   model y = fail / s p;
   random int fail/type=un subject=aircraft s;
run;

***************************************************     
/* The following code appears on page 513,         */
/* where it is used to produce output 10.7.        */    
*************************************************** 

/* Program 10_7.sas                                           */
/* Growth Curve Analysis/Mixed Model (Grizzle and Allen,1969) */

options ls=80 ps=60 nodate nonumber;
title1 'Output 10.7:  Growth Curve Analyis - Missing Data';

data klein;
   missing m;
   infile 'c:\10_7.dat';
   input treat y1 y2 y3 y4 y5 y6 y7 dog;
   y=y1; time= 1; x1=-3; x2= 5; x3=-1; output;
   y=y2; time= 3; x1=-2; x2= 0; x3= 1; output;
   y=y3; time= 5; x1=-1; x2=-3; x3= 1; output;
   y=y4; time= 7; x1= 0; x2=-4; x3= 0; output;
   y=y5; time= 9; x1= 1; x2=-3; x3=-1; output;
   y=y6; time=11; x1= 2; x2= 0; x3=-1; output;
   y=y7; time=13; x1= 3; x2= 5; x3= 1; output;
   drop y1- y7;
proc print data=klein;
run;
proc mixed data=klein method=reml;
   title2 'Using PROC MIXED, Unknown Covariance Structure';
   class treat dog;
   model y=treat x1 x2 x3/ s p;
   repeated/type=un subject=dog r;
   lsmeans treat;
run;
proc mixed data=klein method=reml;
   title2 'Using PROC MIXED, Random Coefficients';
   class treat dog;
   model y=treat x1 x2 x3/s p;
   random int x1 x2 x3/type=un subject=dog g s;
run;
data klein1;
   infile 'c:\10_7.da1';
   input pattern y1 y2 y3 y4 y5 y6 y7 dog x1 x2 x3 x4;
proc print data=klein1;
   title2 'Missing Pattern 1';
run;
data klein2;
   infile 'c:\10_7.da2';
   input pattern y2 y3 y4 y5 y6 y7 dog x1 x2 x3 x4;
proc print data=klein2;
   title2 'Missing Pattern 2';
run;
data klein3;
   infile 'c:\10_7.da3';
   input pattern y4 y5 y6 y7 dog x1 x2 x3 x4;
proc print data=klein3;
   title2 'Misssing Pattern 3';
run;
data kleinf;
   infile 'c:\7_7.dat';
   input group y1 y2 y3 y4 y5 y6 y7 dog x1 x2 x3 x4;
run;
data klein0;
   infile 'c:\10_7.da4';
   input pattern y1 y2 y3 y4 y5 y6 y7 dog x1 x2 x3 x4;
run;
proc iml;
   use klein1;
   read all var {y1 y2 y3 y4 y5 y6 y7} into y_1;
   read all var {x1 x2 x3 x4} into x_1;
   use klein2;
   read all var {y2 y3 y4 y5 y6 y7} into y_2;
   read all var {x1 x2 x3 x4} into x_2;
   use klein3;
   read all var {y4 y5 y6 y7} into y_3;
   read all var {x1 x2 x3 x4} into x_3;
   use kleinf;
   read all var {y1 y2 y3 y4 y5 y6 y7} into y;
   read all var {x1 x2 x3 x4 } into x;
   use klein0;
   read all var {y1 y2 y3 y4 y5 y6 y7} into y0;
   a1=i(7);
   zero=shape({0},1,6,0);
   zero3=shape({0},3,4,0);
   a2=zero//i(6);
   a3=zero3//i(4);
   print a1 a2 a3;
   n1=nrow(y_1);n2=nrow(y_2);n3=nrow(y_3);
   n=n1+n2+n3;
   k=ncol(x);
   /*Begin calculation of S */
   sall = (y`*y-y`*x*inv(x`*x)*x`*y)/(n-k);
   print 'Complete Data 36 Obs Estimate of S', sall;
   sc = (y_1`*y_1-y_1`*x_1*inv(x_1`*x_1)*x_1`*y_1)/(n1-k);
   print 'Listwise Deletion Estimate of S',sc;
   t2=y0[1:26,2:7];
   d2=x_1//x_2;s2_=(t2`*t2-t2`*d2*inv(d2`*d2)*d2`*t2)/(n1+n2-k);
   t3=y0[1:36,4:7];d3=x_1//x_2//x_3;
   st_=(t3`*t3-t3`*d3*inv(d3`*d3)*d3`*t3)/(n-k);
   s1=sc[1,];
   s2=sc[2,1]||s2_[1,];
   s3=sc[3,1]||s2_[2,];
   s4=sc[4,1]||s2_[3,1]||s2_[3,2]||st_[1,];
   s5=sc[5,1]||s2_[4,1]||s2_[4,2]||st_[2,];
   s6=sc[6,1]||s2_[5,1]||s2_[5,2]||st_[3,];
   s7=sc[7,1]||s2_[6,1]||s2_[6,2]||st_[4,];
   s=s1//s2//s3//s4//s5//s6//s7;
   print 'Consistent Estimate of S (Formula 10.6)', s;
   call eigen(val,vec,s);
   print 'Eigenvalues of S', val;
   do i=1 to 7;
      if val[i] < 0 then val[i]=0;
   end;
   sm=vec*diag(val)*vec`;
   print 'Smoothed Estimate of S', sm;
   v=eigval(sm);
   print 'Eigenvalues of Smoothed Estimate',v;
   /* Matrix of Orthogonal Polynomials of degree  q-1=6 */
   p={ 1  1  1  1  1  1  1,
      -3 -2 -1  0  1  2  3,
       5  0 -3 -4 -3  0  5,
      -1  1  1  0 -1 -1  1};
   q=p*p`;
   print 'scalar matrix p*p`',q;
   /* Begin calculations of beta hat  */
   beta=inv(x`*x)*x`*y*inv(sall)*p`*inv(p*inv(sall)*p`);
   betat_f=beta*q;
   betaga=shape(beta`,16,1);
   print 'Beta based on 36 observations',beta;
   print 'Grizzle and Allen Beta = beta*(pp`)',betat_f;
   d=a1`*p`@x_1//a2`*p`@x_2//a3`*p`@x_3;
   block1=(a1`*sc*a1)@i(n1);
   block2=(a2`*sc*a2)@i(n2);block3=(a3`*sc*a3)@i(n3);
   sigma=block(block1,block2,block3);
   ivsigcm=inv(sigma);
   vecy1=shape(y_1`,98,1);vecy2=shape(y_2`,72,1);vecy3=shape(y_3`,40,1);
   vecy=vecy1//vecy2//vecy3;
   betacm=inv(d`*ivsigcm*d)*d`*ivsigcm*vecy;
   beta=shape(betacm,4,4)`;
   betat_sc=beta*q;
   print 'Beta based on 14 complete obs to estimate sigma',beta;
   print betat_sc;
   block1=(a1`*sm*a1)@i(n1);block2=(a2`*sm*a2)@i(n2);block3=(a3`*sm*a3)@i(n3);
   sigma=block(block1,block2,block3);
   ivsigsm=ginv(sigma);
   betasm=ginv(d`*ivsigsm*d)*d`*ivsigsm*vecy;
   beta=shape(betasm,4,4)`;
   betat_sm=beta*q;
   print 'Beta based on smoothed estimate of sigma',beta;
   print betat_sm;
   /* Tests of homogeniety using Wald Statistics */
   c={1  0  0 -1,
      1  0 -1  0,
      1 -1  0  0,
      0  1 -1  0,
      0  1  0 -1,
      0  0  1 -1};
   ch={0 0 0,
       0 0 0,
       0 0 0,
       0 0 0,
       0 0 0,
       0 0 0};
   sga=sall@i(n);
   ivga=inv(sga);
   ga=p`@x;
   do i= 1 to 6;
      ch[i,1]=((i(4)@c[i,])*betaga)`*inv((i(4)@c[i,])*ginv(ga`*ivga*ga)*
               (i(4)@c[i,])`)*((i(4)@c[i,])*betaga);
      ch[i,2]=((i(4)@c[i,])*betacm)`*inv((i(4)@c[i,])*ginv(d`*ivsigcm*d)*
               (i(4)@c[i,])`)*((i(4)@c[i,])*betacm);
      ch[i,3]=((i(4)@c[i,])*betasm)`*inv((i(4)@c[i,])*ginv(d`*ivsigsm*d)*
               (i(4)@c[i,])`)*((i(4)@c[i,])*betasm);
   end;
   print 'GA | Complete | Smoothed // Wald Statistics',ch;
quit;
run;


DATA SETS USED IN THIS BOOK


***************************************************
/* The following data set is mentioned on page 8,  */ 
/* and it is given in full on page 551.            */
***************************************************

     10.28       18.52       29.67       35.68
     11.93       20.28       28.91       36.05
      8.22       17.40       28.72       35.26
      8.41       21.69       32.14       49.37
     10.03       19.21       31.13       41.66
     12.85       20.34       29.29       41.66
      7.78       19.42       30.00       34.77
     10.55       17.68       31.29       44.35
     10.11       21.41       29.36       35.77
     12.25       21.00       30.64       44.32
      8.71       23.28       30.08       40.91
     12.09       18.06       30.29       41.08
      9.79       19.77       32.69       49.96
     11.62       19.02       28.22       32.90
      8.99       20.10       29.68       39.86
     10.86       20.55       31.15       45.87
     12.48       19.62       29.90       38.51
     11.40       22.78       28.02       31.07
     11.82       22.57       29.52       36.43
     11.32       20.38       29.37       35.64
     11.38       21.33       31.80       44.31
     13.77       20.98       30.34       38.94
      9.59       22.25       29.88       41.84
      8.63       16.50       29.92       40.95
     11.30       20.35       29.29       34.36
     12.30       18.54       29.17       36.57
     13.02       22.29       28.36       35.73
      8.88       19.95       30.73       44.40
     12.23       20.37       30.00       43.40
      8.53       18.09       32.77       51.09
      8.80       20.95       29.45       34.25
      8.38       19.97       29.94       41.71
      9.53       20.03       29.63       39.88
     11.23       19.16       29.18       38.21
     10.41       21.65       31.75       49.20
     12.10       21.76       29.17       38.06
     12.23       19.13       29.88       36.57
      9.66       21.85       29.61       37.62
      9.80       23.86       29.01       38.49
      9.14       18.08       28.81       36.37
     11.26       22.40       29.81       39.23
      7.86       21.51       30.53       40.45
      8.90       18.46       30.58       43.88
      7.89       21.19       28.03       34.53
     11.68       23.64       30.19       40.51
      9.73       20.97       28.91       38.07
     11.67       23.01       28.67       30.68
      8.00       20.60       29.81       39.06
     10.13       19.09       29.05       34.42
     11.75       20.74       30.44       43.67


***************************************************
/* The following data sets are mentioned on page 17, */ 
/* and they are  given in full on page 552 and 553.  */
***************************************************
/* YCONDX.DAT                                        */

    -13.41       -1.69      -35.92
     -2.67       -1.48      -17.86
    -14.65       -2.36        9.33
      1.44        1.42       14.29
     -2.98       -2.83        6.70
      2.07       -1.24        1.68
     14.64       -1.57       12.55
     16.40       -0.55      -25.70
    -18.26       -4.02      -36.80
     -1.65        0.94       -2.17
      4.30       -2.30      -15.92
     16.22        3.43        1.96
      5.13        0.35      -30.57
     -9.69        2.05      -42.17
     -1.45        0.68        0.23
     10.70       -0.29       -2.00
    -22.32       -2.16      -14.51
      6.33       -1.16       -2.23
    -12.14       -2.84      -18.02
      8.14        0.95       37.33
      4.35        5.09       40.15
      6.12        1.86       18.23
     -5.67        3.75       31.52
    -10.09       -2.38        1.94
     19.99        4.52      -23.17
      2.71       -2.11        5.41
      9.77       -1.86      -22.15
      7.19       -1.38       12.93
    -16.24        1.38        8.56
     14.37        2.28       32.56
     -7.86        0.06       52.93
    -10.78        3.42        0.88

/* RHOWERX.DAT                          */
     0 10  8 21 22
  7  3 21 28 21
  7  9 17 31 30
  6 11 16 27 25
 20  7 21 28 16
  4 11 18 32 29
  6  7 17 26 23
  5  2 11 22 23
  3  5 14 24 20
 16 12 16 27 30
  5  3 17 25 24
  2 11 10 26 22
  1  4 14 25 19
 11  5 18 27 22
  0  0  3 16 11
  5  8 11 12 15
  1  6 10 28 23
  1  9 12 30 18
  0 13 13 19 16
  4  6 14 27 19
  4  5 16 21 24
  1  6 15 23 28
  5  8 14 25 24
  4  5 11 16 22
  5  7 17 26 15
  0  4  8 16 14
  4 17 21 27 31
  5  8 20 28 26
  4  7 19 20 13
  4  7 10 23 19
  2  6 14 25 17
  5 10 18 27 26

***************************************************
/* The following data set is mentioned on page 34, */ 
/* and it is given in full on page 555.            */
***************************************************

  29063.57   109948374    7.688E12  3.13745E15
 151698.83   639330658  3.59716E12   4.5204E15
   3698.38  36153566.3  2.97585E12  2.06639E15
   4473.25  2639650670  9.09157E13  2.75238E21
  22789.77   219431766  3.31827E13  1.24294E18
 381699.28   680293917  5.26881E12  1.24085E18
   2386.98   272272420  1.06898E13  1.26209E15
  38226.50  47620446.7  3.86329E13  1.81999E19
  24487.89  1978553084  5.61984E12  3.44175E15
 208847.22  1323591048  2.02428E13  1.77812E19
   6082.12  1.28429E10  1.16325E13  5.82571E17
 177373.85  69777905.0   1.4218E13   6.9397E17
  17846.14   386076979  1.57865E14  4.96912E21
 111387.69   181529398  1.81096E12  1.94953E14
   8053.79   538067666  7.77228E12  2.04295E17
  52212.82   844135796  3.37144E13  8.33475E19
 264210.87   333050675  9.68268E12   5.3014E16
  89527.14  7811492215  1.47279E12  3.11403E13
 136181.37  6330352253  6.64021E12  6.61607E15
  82360.05   712229707  5.71764E12  3.02188E15
  87709.27  1832088839  6.45971E13  1.76004E19
 957392.80  1291412236   1.4943E13  8.14021E16
  14595.46  4596179859  9.48909E12  1.47864E18
   5590.57  14605103.6  9.87909E12  6.10812E17
  81208.83   686241359  5.23758E12  8.33754E14
 220662.85   113219893  4.65734E12  7.62086E15
 451228.04  4785761881  2.08206E12  3.28838E15
   7171.21   462169873  2.20985E13  1.91908E19
 204031.97   705102243  1.07293E13  7.02601E18
   5078.52  71946674.6  1.69833E14  1.54363E22
   6667.42  1249255107  6.18937E12  7.50411E14
   4376.54   470402526  1.01103E13  1.30612E18
  13820.96   498845302  7.39943E12  2.08882E17
  75634.08   210453368  4.68517E12  3.92988E16
  33116.29  2536035144  6.17005E13  2.32425E21
 180406.47  2815286421  4.65206E12  3.37879E16
 204440.99   203950861  9.45947E12   7.6079E15
  15697.88  3093101752  7.24266E12   2.1737E16
  18038.71  2.30064E10  3.98162E12  5.20012E16
   9306.02  71478360.5  3.26074E12  6.25036E15
  77575.93  5326619194  8.84626E12  1.09189E17
   2583.53  2201603388  1.80931E13  3.69987E17
   7311.21   103904810   1.9024E13  1.13447E19
   2659.12  1589597149  1.49174E12  9.87601E14
 118760.90  1.84723E10  1.28903E13  3.90247E17
  16748.52  1278438566   3.6101E12  3.40684E16
 116633.26  9800527332  2.83381E12  2.11976E13
   2973.87   884117021  8.83769E12  9.15975E16
  25203.74   196034406   4.1469E12  8.91546E14
 126357.47  1012309139  1.66282E13   9.2314E18


***************************************************
/* The following data set is mentioned on page 51, */ 
/* and it is given in full on page 556.            */
***************************************************

 1 11.2  587 16.5 6.2
 2 13.4  643 20.5 6.4
 3 40.7  635 26.3 9.3
 4 5.3   692 16.5 5.3
 5 24.8 1248 19.2 7.3
 6 12.7  643 16.5 5.9
 7 20.9 1964 20.2 6.4
 8 35.7 1531 21.3 7.6
 9  8.7  713 17.2 4.9
10  9.6  749 14.3 6.4
11 14.5 7895 18.1 6.0
12 26.9  762 23.1 7.4
13 15.7 2793 19.1 5.8
14 36.2  741 24.7 8.6
15 18.1  625 18.6 6.5
16 28.9  854 24.9 8.3
17 14.9  716 17.9 6.7
18 25.8  921 22.4 8.6
19 21.7  595 20.2 8.4
20 25.7 3353 16.9 6.7

***************************************************
/* The following data set is mentioned on page 59, */ 
/* and it is given in full on page 557.            */
***************************************************

1  3
1  2
1  4
1  3
1  1
1  5
2  7
2  8
2  4
2 10
2  6
3  3
3  2
3  1
3  2
3  4
3  2
3  3
3  1
4 10
4 12
4  8
4  5
4 12
4 10
4  9

***************************************************
/* The following data set is mentioned on page 63, */ 
/* and it is given in full on page 557.            */
***************************************************

1 1  5
1 2  8
1 2 10
1 2  9
2 3  8
2 3 10
2 4  6
2 4  2
2 4  1
2 4  3
2 5  3
2 5  7

***************************************************
/* The following data set is mentioned on page 69, */ 
/* and it is given in full on page 558.           */
***************************************************

3 1 6 1 0 0 6 0 0
2 1 6 1 0 0 6 0 0
3 1 5 1 0 0 5 0 0
3 1 4 1 0 0 4 0 0
4 1 3 1 0 0 3 0 0
5 1 3 1 0 0 3 0 0
5 1 2 1 0 0 2 0 0
6 1 2 1 0 0 2 0 0
5 2 5 0 1 0 0 5 0
6 2 5 0 1 0 0 5 0
8 2 3 0 1 0 0 3 0
8 2 2 0 1 0 0 2 0
7 2 1 0 1 0 0 1 0
9 2 1 0 1 0 0 1 0
5 3 4 0 0 1 0 0 4
7 3 1 0 0 1 0 0 1
8 3 1 0 0 1 0 0 1
7 3 2 0 0 1 0 0 2

***************************************************
/* The following data set is mentioned on page 79, */ 
/* and it is given in full on page 558.            */
***************************************************

1 1  3 1 0 0 0 0 0 0 0
1 1  6 1 0 0 0 0 0 0 0
1 1  3 1 0 0 0 0 0 0 0
1 2  3 0 1 0 0 0 0 0 0
1 2  4 0 1 0 0 0 0 0 0
1 2  5 0 1 0 0 0 0 0 0
1 2  4 0 1 0 0 0 0 0 0
1 2  3 0 1 0 0 0 0 0 0
1 3  7 0 0 1 0 0 0 0 0
1 3  8 0 0 1 0 0 0 0 0
1 3  7 0 0 1 0 0 0 0 0
1 4  6 0 0 0 1 0 0 0 0
1 4  7 0 0 0 1 0 0 0 0
1 4  8 0 0 0 1 0 0 0 0
1 4  9 0 0 0 1 0 0 0 0
1 4  8 0 0 0 1 0 0 0 0
2 1  1 0 0 0 0 1 0 0 0
2 1  2 0 0 0 0 1 0 0 0
2 1  2 0 0 0 0 1 0 0 0
2 1  2 0 0 0 0 1 0 0 0
2 2  2 0 0 0 0 0 1 0 0
2 2  3 0 0 0 0 0 1 0 0
2 2  4 0 0 0 0 0 1 0 0
2 2  3 0 0 0 0 0 1 0 0
2 3  5 0 0 0 0 0 0 1 0
2 3  6 0 0 0 0 0 0 1 0
2 3  5 0 0 0 0 0 0 1 0
2 3  6 0 0 0 0 0 0 1 0
2 4 10 0 0 0 0 0 0 0 1
2 4 10 0 0 0 0 0 0 0 1
2 4  9 0 0 0 0 0 0 0 1
2 4 11 0 0 0 0 0 0 0 1

***************************************************
/* The following data set is mentioned on page 94, */ 
/* and it is given in full on page 559.            */
***************************************************

1 1 2  7 1 0 0 0 0 0 0 0 0
1 2 3  5 0 1 0 0 0 0 0 0 0
1 3 1  4 0 0 1 0 0 0 0 0 0
2 1 3  5 0 0 0 1 0 0 0 0 0
2 2 1  6 0 0 0 0 1 0 0 0 0
2 3 2 11 0 0 0 0 0 1 0 0 0
3 1 1  8 0 0 0 0 0 0 1 0 0
3 2 2  8 0 0 0 0 0 0 0 1 0
3 3 3  9 0 0 0 0 0 0 0 0 1

***************************************************
/* The following data set is mentioned on page 102,*/ 
/* and it is given in full on page 559.            */
***************************************************

3 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
4 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
3 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
2 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
2 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
3 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
7 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0
7 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0
5 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
4 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
6 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0
3 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
4 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0
3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1

***************************************************
/* The following data set is mentioned on page 109,*/ 
/* and it is given in full on page 560.            */
**************************************************

1 20 21 42 32 32
1 67 29 56 39 41
1 37 25 28 31 34
1 42 38 36 19 35
1 57 32 21 30 29
1 39 38 54 31 28
1 43 20 46 42 31
1 35 34 43 35 42
1 41 23 51 27 30
1 39 24 35 26 32
2 47 25 36 21 27
2 53 32 48 46 54
2 38 33 42 48 49
2 60 41 67 53 50
2 37 35 45 34 46
2 59 37 52 36 52
2 67 33 61 31 50
2 43 27 36 33 32
2 64 53 62 40 43
2 41 34 47 37 46

***************************************************
/* The following data set is mentioned on page 124,*/ 
/* and it is given in full on page 560.            */
**************************************************

3 1 6 2 1 0 0 6 0 0 2 0 0
2 1 6 2 1 0 0 6 0 0 2 0 0
3 1 5 2 1 0 0 5 0 0 2 0 0
3 1 4 4 1 0 0 4 0 0 4 0 0
4 1 3 5 1 0 0 3 0 0 5 0 0
5 1 3 5 1 0 0 3 0 0 5 0 0
5 1 2 6 1 0 0 2 0 0 6 0 0
6 1 2 5 1 0 0 2 0 0 5 0 0
5 2 5 2 0 1 0 0 5 0 0 2 0
6 2 5 1 0 1 0 0 5 0 0 1 0
8 2 3 2 0 1 0 0 3 0 0 2 0
8 2 2 7 0 1 0 0 2 0 0 7 0
7 2 1 8 0 1 0 0 1 0 0 8 0
9 2 1 7 0 1 0 0 1 0 0 7 0
5 3 4 3 0 0 1 0 0 4 0 0 3
7 3 1 1 0 0 1 0 0 1 0 0 1
8 3 1 6 0 0 1 0 0 1 0 0 6
7 3 2 6 0 0 1 0 0 2 0 0 6

***************************************************
/* The following data set is mentioned on page 143,*/ 
/* and it is given in full on page 561.            */
**************************************************

27 73
21 66
22 63
26 79
25 68
28 67
24 75
25 71
23 70
20 65
29 79
24 72
20 70
38 91
32 76
33 69
31 66
34 73
37 78
38 87
33 76
35 79
30 73
37 68
31 80
39 75
46 89
49 101
40 70
42 72
43 80
46 83
43 75
49 80
40 90
48 70
42 85
44 71
46 80
47 96
45 92
55 76
54 71
57 99
52 86
53 79
56 92
52 85
57 109
50 71
59 90
50 91
52 100
58 80

***************************************************
/* The following data set is mentioned on page 191,*/ 
/* and it is given in full on page 562.            */
**************************************************

 68 15 24  1  0 10  8 21 22
 82 11  8  1  7  3 21 28 21
 82 13 88  1  7  9 17 31 30
 91 18 82  1  6 11 16 27 25
 82 13 90  1 20  7 21 28 16
100 15 77  1  4 11 18 32 29
100 13 58  1  6  7 17 26 23
 96 12 14  1  5  2 11 22 23
 63 10  1  1  3  5 14 24 20
 91 18 98  1 16 12 16 27 30
 87 10  8  1  5  3 17 25 24
105 21 88  1  2 11 10 26 22
 87 14  4  1  1  4 14 25 19
 76 16 14  1 11  5 18 27 22
 66 14 38  1  0  0  3 16 11
 74 15  4  1  5  8 11 12 15
 68 13 64  1  1  6 10 28 23
 98 16 88  1  1  9 12 30 18
 63 15 14  1  0 13 13 19 16
 94 16 99  1  4  6 14 27 19
 82 18 50  1  4  5 16 21 24
 89 15 36  1  1  6 15 23 28
 80 19 88  1  5  8 14 25 24
 61 11 14  1  4  5 11 16 22
102 20 24  1  5  7 17 26 15
 71 12 24  1  0  4  8 16 14
102 16 24  1  4 17 21 27 31
 96 13 50  1  5  8 20 28 26
 55 16  8  1  4  7 19 20 13
 96 18 98  1  4  7 10 23 19
 74 15 98  1  2  6 14 25 17
 78 19 50  1  5 10 18 27 26

***************************************************
/* The following data set is mentioned on page 208,*/ 
/* and it is given in full on page 563.            */
**************************************************

1 1 1 1 22
1 1 1 2 21
1 1 1 3 14
1 1 2 3 31
1 1 2 4 25
1 2 1 3 31
1 2 1 4 41
1 2 2 4 66
1 2 2 5 55
1 2 2 6 61
1 3 1 1 11
1 3 1 2 21
1 3 2 1 41
1 3 2 2 21
2 1 1 3 31
2 1 1 5 66
2 1 2 2 45
2 2 1 2 21
2 2 2 2 21
2 2 2 3 31
2 3 1 4 41
2 3 1 5 47
2 3 1 6 61
2 3 2 4 41
2 3 2 5 55
3 1 1 2 21
3 1 1 3 31
3 1 2 1 66
3 2 1 4 41
3 2 1 5 51
3 2 1 6 61
3 2 2 2 47
3 2 2 3 35
3 2 2 4 41
3 3 1 1 18
3 3 1 2 21
3 3 1 3 31
3 3 2 5 57
3 3 2 6 64
3 3 2 7 77

***************************************************
/* The following data set is mentioned on page 220,*/ 
/* and it is given in full on page 564.            */
**************************************************

G1  3  6 42
G1  6  3 57
G1  3  3 33
G1  3  3 47
G1  1  2 32
G1  2  1 35
G1  2  2 33
G1  2  2 39
G2  4  5 47
G2  5  4 49
G2  4  3 42
G2  3  4 41
G2  2  3 38
G2  3  2 43
G2  4  3 48
G2  3  4 45
G3  7  8 61
G3  8  7 65
G3  7  6 64
G3  6  7 56
G3  5  6 52
G3  6  5 58
G3  5  6 53
G3  6  5 54
G4  7  6 65
G4  8  9 74
G4  9  8 80
G4  8 10 73
G4 10 10 85
G4 10  9 82
G4  9 11 78
G4 11  9 89

***************************************************
/* The following data set is mentioned on page 225,*/ 
/* and it is given in full on page 564.            */
**************************************************

G1 5.7 4.67 17.6 1.50 .104 1.50 1.88  5.15 8.40  7.5 .14 205 24
G1 5.5 4.67 13.4 1.65 .245 1.32 2.24  5.75 4.50  7.1 .11 160 32
G1 6.6 2.70 20.3 0.90 .097 0.89 1.28  4.35 1.20  2.3 .10 480 17
G1 5.7 3.49 22.3 1.75 .174 1.50 2.24  7.55 2.75  4.0 .12 230 30
G1 5.6 3.49 20.5 1.40 .210 1.19 2.00  8.50 3.30  2.0 .12 235 30
G1 6.0 3.49 18.5 1.20 .275 1.03 1.84 10.25 2.00  2.0 .12 215 27
G1 5.3 4.84 12.1 1.90 .170 1.87 2.40  5.95 2.60 16.8 .14 215 25
G1 5.4 4.84 12.0 1.65 .164 1.68 3.00  6.30 2.72 14.5 .14 190 30
G1 5.4 4.84 10.1 2.30 .275 2.08 2.68  5.45 2.40  0.9 .20 190 28
G1 5.6 4.48 14.7 2.35 .210 2.55 3.00  3.75 7.00  2.0 .21 175 24
G1 5.6 4.48 14.8 2.35 .050 1.32 2.84  5.10 4.00  0.4 .12 145 26
G1 5.6 4.48 14.4 2.50 .143 2.38 2.84  4.05 8.00  3.8 .18 155 27
G2 5.2 3.48 18.1 1.50 .153 1.20 2.60  9.00 2.35 14.5 .13 220 31
G2 5.2 3.48 19.7 1.65 .203 1.73 1.88  5.30 2.52 12.5 .20 300 23
G2 5.6 3.48 16.9 1.40 .074 1.15 1.72  9.85 2.45  8.0 .07 305 32
G2 5.8 2.63 23.7 1.65 .155 1.58 1.60  3.60 3.75  4.9 .10 275 20
G2 6.0 2.63 19.2 0.90 .155 0.96 1.20  4.05 3.30  0.2 .10 405 18
G2 5.3 2.63 18.0 1.60 .129 1.68 2.00  4.40 3.00  3.6 .18 210 23
G2 5.4 4.46 14.8 2.45 .245 2.15 3.12  7.15 1.81 12.0 .13 170 31
G2 5.6 4.46 15.6 1.65 .422 1.42 2.56  7.25 1.92  5.2 .15 235 28
G2 5.3 2.80 16.2 1.65 .063 1.62 2.04  5.30 3.90 10.2 .12 185 21
G2 5.4 2.80 14.1 1.25 .042 1.62 1.84  3.10 4.10  8.5 .30 255 20
G2 5.5 2.80 17.5 1.05 .030 1.56 1.48  2.40 2.10  9.6 .20 265 15
G2 5.4 2.57 14.1 2.70 .194 2.77 2.56  4.25 2.60  6.9 .17 305 26
G2 5.4 2.57 19.1 1.60 .139 1.59 1.88  5.80 2.30  4.7 .16 440 24
G2 5.2 2.57 22.5 0.85 .046 1.65 1.20  1.55 1.50  3.5 .21 430 16
G3 5.5 1.26 17.0 0.70 .094 0.97 1.24  4.55 2.90  1.9 .12 350 18
G3 5.9 1.26 12.5 0.80 .039 0.80 0.64  2.65 0.72  0.7 .13 475 10
G3 5.6 2.52 21.5 1.80 .142 1.77 2.60  6.50 2.48  8.3 .17 195 33
G3 5.6 2.52 22.2 1.05 .080 1.17 1.48  4.85 2.20  9.3 .14 375 25
G3 5.3 2.52 13.0 2.20 .215 1.85 3.48  8.75 2.40 13.0 .11 160 35
G3 5.6 3.24 13.0 3.55 .166 3.18 3.48  5.20 3.50 18.3 .22 240 33
G3 5.5 3.24 10.9 3.30 .111 2.79 3.04  4.75 2.52 10.5 .21 205 31
G3 5.6 3.24 12.0 3.65 .180 2.40 3.00  5.85 3.00 14.5 .21 270 34
G3 5.4 1.56 22.8 0.55 .069 1.00 1.14  2.85 2.90  3.3 .15 475 16
G4 5.3 1.56 16.5 2.05 .222 1.49 2.40  6.55 3.90  6.3 .11 430 31
G4 5.2 1.56 18.4 1.05 .267 1.17 1.36  6.60 2.00  4.9 .11 490 28
G4 5.8 4.12 12.5 5.90 .093 3.80 3.84  2.90 3.00 22.5 .24 105 32
G4 5.7 4.12  8.7 4.25 .147 3.62 5.32  3.00 3.55 19.5 .20 115 25
G4 5.5 2.14  9.4 3.85 .217 3.36 5.52  3.40 5.20  1.3 .31 097 28
G4 5.4 2.14 15.0 2.45 .418 2.38 2.40  5.40 1.81 20.0 .17 325 27
G4 5.4 2.14 12.9 1.70 .323 1.74 2.48  4.45 1.88  1.0 .15 310 23
G4 4.9 2.03 12.1 1.80 .205 2.00 2.24  4.30 3.70  5.0 .19 245 25
G4 5.0 2.03 13.2 3.65 .348 1.95 2.12  5.00 1.80  3.0 .15 170 26
G4 4.9 2.03 11.5 2.25 .320 2.25 3.12  3.40 2.50  5.1 .18 220 34

***************************************************
/* The following data set is mentioned on page 231,*/ 
/* and it is given in full on page 565.            */
**************************************************

1 20 21 42 32 32
1 67 29 56 39 41
1 37 25 28 31 34
1 42 38 36 19 35
1 57 32 21 30 29
1 39 38 54 31 28
1 43 20 46 42 31
1 35 34 43 35 42
1 41 23 51 27 30
1 39 24 35 26 32
2 47 25 36 21 27
2 53 32 48 46 54
2 38 33 42 48 49
2 60 41 67 53 50
2 37 35 45 34 46
2 59 37 52 36 52
2 67 33 61 31 50
2 43 27 36 33 32
2 64 53 62 40 43
2 41 34 47 37 46

***************************************************
/* The following data set is mentioned on page 243,*/ 
/* and it is given in full on page 566.            */
**************************************************

1  2  4  7 1 0 0
1  2  6 10 1 0 0
1  3  7 10 1 0 0
1  7  9 11 1 0 0
1  6  9 12 1 0 0
2  5  6 10 0 1 0
2  4  5 10 0 1 0
2  7  8 11 0 1 0
2  8  9 11 0 1 0
2 11 12 13 0 1 0
3  3  4  7 0 0 1
3  3  6  9 0 0 1
3  4  7  9 0 0 1
3  8  8 10 0 0 1
3  7 10 10 0 0 1

***************************************************
/* The following data sets are mentioned on page 263 */ 
/* and 264 and they are given in full on page 566.             */
**************************************************
/* MMM.DAT                                         */

1 117.0 117.5 118.5 59.0 59.0 60.0 10.5 16.5 16.5
1 109.0 110.5 111.0 60.0 61.5 61.5 30.5 30.5 30.5
1 117.0 120.0 120.5 60.0 61.5 62.0 23.5 23.5 23.5
1 122.0 126.0 127.0 67.5 70.5 71.5 33.0 32.0 32.5
1 116.0 118.5 119.5 61.5 62.5 63.5 24.5 24.5 24.5
1 123.0 126.0 127.0 65.5 61.5 67.5 22.0 22.0 22.0
1 130.5 132.0 134.5 68.5 69.5 71.0 33.0 32.5 32.0
1 126.5 128.5 130.5 69.0 71.0 73.0 20.0 20.0 20.0
1 113.0 116.5 118.0 58.0 59.0 60.5 25.0 25.0 24.5
2 128.0 129.0 131.5 67.0 67.5 69.0 24.0 24.0 24.0
2 116.5 120.0 121.5 63.5 65.0 66.0 28.5 29.5 29.5
2 121.5 125.5 127.0 64.5 67.5 69.0 26.5 27.0 27.0
2 109.5 112.0 114.0 54.0 55.5 57.0 18.0 18.5 19.0
2 133.0 136.0 137.5 72.0 73.5 75.5 34.5 34.5 34.5
2 120.0 124.5 126.0 62.5 65.0 66.0 26.0 26.0 26.0
2 129.5 133.5 134.5 65.0 68.0 69.0 18.5 18.5 18.5
2 122.0 124.0 125.5 64.5 65.5 66.0 18.5 18.5 18.5
2 125.0 127.0 128.0 65.5 66.5 67.0 21.5 21.5 21.6

/* MIXED.DAT                                         */

1 1 1 117.0 59.0 10.5
1 1 2 117.5 59.0 16.5
1 1 3 118.5 60.0 16.5
1 2 1 109.0 60.0 30.5
1 2 2 110.5 61.5 30.5
1 2 3 111.0 61.5 30.5
1 3 1 117.0 60.0 23.5
1 3 2 120.0 61.5 23.5
1 3 3 120.5 62.0 23.5
1 4 1 122.0 67.5 33.0
1 4 2 126.0 70.5 32.0
1 4 3 127.0 71.5 32.5
1 5 1 116.0 61.5 24.5
1 5 2 118.5 62.5 24.5
1 5 3 119.5 63.5 24.5
1 6 1 123.0 65.5 22.0
1 6 2 126.0 61.5 22.0
1 6 3 127.0 67.5 22.0
1 7 1 130.5 68.5 33.0
1 7 2 132.0 69.5 32.5
1 7 3 134.5 71.0 32.0
1 8 1 126.5 69.0 20.0
1 8 2 128.5 71.0 20.0
1 8 3 130.5 73.0 20.0
1 9 1 113.0 58.0 25.0
1 9 2 116.5 59.0 25.0
1 9 3 118.0 60.5 24.5
2 1 1 128.0 67.0 24.0
2 1 2 129.0 67.5 24.0
2 1 3 131.5 69.0 24.0
2 2 1 116.5 63.5 28.5
2 2 2 120.0 65.0 29.5
2 2 3 121.5 66.0 29.5
2 3 1 121.5 64.5 26.5
2 3 2 125.5 67.5 27.0
2 3 3 127.0 69.0 27.0
2 4 1 109.5 54.0 18.0
2 4 2 112.0 55.5 18.5
2 4 3 114.0 57.0 19.0
2 5 1 133.0 72.0 34.5
2 5 2 136.0 73.5 34.5
2 5 3 137.5 75.5 34.5
2 6 1 120.0 62.5 26.0
2 6 2 124.5 65.0 26.0
2 6 3 126.0 66.0 26.0
2 7 1 129.5 65.0 18.5
2 7 2 133.5 68.0 18.5
2 7 3 134.5 69.0 18.5
2 8 1 122.0 64.5 18.5
2 8 2 124.0 65.5 18.5
2 8 3 125.5 66.0 18.5
2 9 1 125.0 65.5 21.5
2 9 2 127.0 66.5 21.5
2 9 3 128.0 67.0 21.6

***************************************************
/* The following data set is mentioned on page 305,*/ 
/* and it is given in full on page 568.            */
**************************************************

1 1 1 1 22 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 1 1 2 21 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 1 1 3 14 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 2 1 3 31 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 2 1 4 25 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 3 1 1 31 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 3 1 2 41 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 1 2 3 66 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 1 2 4 55 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
1 2 2 4 61 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
1 2 2 5 11 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
1 2 2 6 21 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
1 3 2 1 41 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
1 3 2 2 21 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
2 1 1 3 31 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
2 1 1 5 66 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
2 2 1 2 45 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0
2 3 1 4 21 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0
2 3 1 5 21 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0
2 3 1 6 31 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0
2 1 2 2 41 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
2 2 2 2 47 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
2 2 2 3 61 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
2 3 2 4 41 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0
2 3 2 5 55 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0
3 1 1 2 21 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
3 1 1 3 31 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
3 2 1 4 66 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
3 2 1 5 41 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
3 2 1 6 51 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
3 3 1 1 61 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
3 3 1 2 47 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
3 3 1 3 35 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
3 1 2 1 41 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0
3 2 2 2 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
3 2 2 3 21 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
3 2 2 4 31 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
3 3 2 5 57 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
3 3 2 6 64 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
3 3 2 7 77 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1

***************************************************
/* The following data sets are mentioned on page 312,*/ 
/* and they are given in full on pages 568 and 569.     */
**************************************************  
/* 7_6.DAT                                           */
                              
1 1 2 22 1 0 0 0 0 0 1 0 0 0 0 0
1 1 2 21 1 0 0 0 0 0 2 0 0 0 0 0
1 1 3 14 1 0 0 0 0 0 4 0 0 0 0 0
1 1 3 25 1 0 0 0 0 0 4 0 0 0 0 0
1 1 4 31 1 0 0 0 0 0 5 0 0 0 0 0
1 2 3 31 0 1 0 0 0 0 0 3 0 0 0 0
1 2 4 25 0 1 0 0 0 0 0 5 0 0 0 0
1 2 5 30 0 1 0 0 0 0 0 6 0 0 0 0
1 2 5 31 0 1 0 0 0 0 0 5 0 0 0 0
1 3 5 31 0 0 1 0 0 0 0 0 6 0 0 0
1 3 6 41 0 0 1 0 0 0 0 0 5 0 0 0
1 3 8 50 0 0 1 0 0 0 0 0 6 0 0 0
2 1 3 31 0 0 0 1 0 0 0 0 0 2 0 0
2 1 5 66 0 0 0 1 0 0 0 0 0 4 0 0
2 1 5 45 0 0 0 1 0 0 0 0 0 3 0 0
2 2 5 45 0 0 0 0 1 0 0 0 0 0 5 0
2 2 6 34 0 0 0 0 1 0 0 0 0 0 8 0
2 2 6 31 0 0 0 0 1 0 0 0 0 0 4 0
2 2 7 30 0 0 0 0 1 0 0 0 0 0 6 0
2 3 3 21 0 0 0 0 0 1 0 0 0 0 0 3
2 3 4 21 0 0 0 0 0 1 0 0 0 0 0 3
2 3 4 31 0 0 0 0 0 1 0 0 0 0 0 4

/* 7_6A.DAT                                         */

1 1 2 22 1
1 1 2 21 2
1 1 3 14 4
1 1 3 25 4
1 1 4 31 5
1 2 3 31 3
1 2 4 25 5
1 2 5 30 6
1 2 5 31 5
1 3 5 31 6
1 3 6 41 5
1 3 8 50 6
2 1 3 31 2
2 1 5 66 4
2 1 5 45 3
2 2 5 45 5
2 2 6 34 8
2 2 6 31 4
2 2 7 30 6
2 3 3 21 3
2 3 4 21 3
2 3 4 31 4

***************************************************
/* The following data set is mentioned on page 320,*/ 
/* and it is given in full on page 569.            */
**************************************************  

1 4.0 4.0 4.1 3.6 3.6 3.8 3.1  1 1 0 0 0
1 4.2 4.3 4.7 4.7 4.8 5.0 5.2  2 1 0 0 0
1 4.3 4.2 4.3 4.3 4.5 5.8 5.4  3 1 0 0 0
1 4.2 4.4 4.6 4.9 5.3 5.6 4.9  4 1 0 0 0
1 4.6 4.4 5.3 5.6 5.9 5.9 5.3  5 1 0 0 0
1 3.1 3.6 4.9 5.2 5.3 4.2 4.1  6 1 0 0 0
1 3.7 3.9 3.9 4.8 5.2 5.4 4.2  7 1 0 0 0
1 4.3 4.2 4.4 5.2 5.6 5.4 4.7  8 1 0 0 0
1 4.6 4.6 4.4 4.6 5.4 5.9 5.6  9 1 0 0 0
2 3.4 3.4 3.5 3.1 3.1 3.7 3.3 10 0 1 0 0
2 3.0 3.2 3.0 3.0 3.1 3.2 3.1 11 0 1 0 0
2 3.0 3.1 3.2 3.0 3.3 3.0 3.0 12 0 1 0 0
2 3.1 3.2 3.2 3.2 3.3 3.1 3.1 13 0 1 0 0
2 3.8 3.9 4.0 3.9 3.5 3.5 3.4 14 0 1 0 0
2 3.0 3.6 3.2 3.1 3.0 3.0 3.0 15 0 1 0 0
2 3.3 3.3 3.3 3.4 3.6 3.1 3.1 16 0 1 0 0
2 4.2 4.0 4.2 4.1 4.2 4.0 4.0 17 0 1 0 0
2 4.1 4.2 4.3 4.3 4.2 4.0 4.2 18 0 1 0 0
2 4.5 4.4 4.3 4.5 4.3 4.4 4.4 19 0 1 0 0
3 3.2 3.3 3.8 3.8 4.4 4.2 4.0 20 0 0 1 0
3 3.3 3.4 3.4 3.7 3.7 3.6 3.7 21 0 0 1 0
3 3.1 3.3 3.2 3.1 3.2 3.1 3.1 22 0 0 1 0
3 3.6 3.4 3.5 4.6 4.9 5.2 4.4 23 0 0 1 0
3 4.5 4.5 5.4 5.7 4.9 4.0 4.0 24 0 0 1 0
3 3.7 4.0 4.4 4.2 4.6 4.8 5.4 25 0 0 1 0
3 3.5 3.9 5.8 5.4 4.9 5.3 5.6 26 0 0 1 0
3 3.9 4.0 4.1 5.0 5.4 4.4 3.9 27 0 0 1 0
4 3.1 3.5 3.5 3.2 3.0 3.0 3.2 28 0 0 0 1
4 3.3 3.2 3.6 3.7 3.7 4.2 4.4 29 0 0 0 1
4 3.5 3.9 4.7 4.3 3.9 3.4 3.5 30 0 0 0 1
4 3.4 3.4 3.5 3.3 3.4 3.2 3.4 31 0 0 0 1
4 3.7 3.8 4.2 4.3 3.6 3.8 3.7 32 0 0 0 1
4 4.0 4.6 4.8 4.9 5.4 5.6 4.8 33 0 0 0 1
4 4.2 3.9 4.5 4.7 3.9 3.8 3.7 34 0 0 0 1
4 4.1 4.1 3.7 4.0 4.1 4.6 4.7 35 0 0 0 1
4 3.5 3.6 3.6 4.2 4.8 4.9 5.0 36 0 0 0 1

***************************************************
/* The following data set is mentioned on page 367,*/ 
/* and it is given in full on page 570.            */
**************************************************  

1 47.8 48.8 49.0 49.7  1
1 46.4 47.3 47.7 48.4  2
1 46.3 46.8 47.8 48.5  3
1 45.1 45.3 46.1 47.2  4
1 47.6 48.5 48.9 49.3  5
1 52.5 53.2 53.3 53.7  6
1 51.2 53.0 54.3 54.5  7
1 49.8 50.0 50.3 52.7  8
1 48.1 50.8 52.3 54.4  9
1 45.0 47.0 47.3 48.3 10
1 51.2 51.4 51.6 51.9 11
1 48.5 49.2 53.0 55.5 12
1 52.1 52.8 53.7 55.0 13
1 48.2 48.9 49.3 49.8 14
1 49.6 50.4 51.2 51.8 15
1 50.7 51.7 52.7 53.3 16
1 47.2 47.7 48.4 49.5 17
1 53.3 54.6 55.1 55.3 18
1 46.2 47.5 48.1 48.4 19
1 46.3 47.6 51.3 51.8 20

***************************************************
/* The following data set is mentioned on page 373,*/ 
/* and it is given in full on page 571.            */
**************************************************  

1 4.0 4.0 4.1 3.6 3.6 3.8 3.1 1 0 0 0
1 4.2 4.3 3.7 3.7 4.8 5.0 5.2 1 0 0 0
1 4.3 4.2 4.3 4.3 4.5 5.8 5.4 1 0 0 0
1 4.2 4.4 4.6 4.9 5.3 5.6 4.9 1 0 0 0
1 4.6 4.4 5.3 5.6 5.9 5.9 5.3 1 0 0 0
1 3.1 3.6 4.9 5.2 5.3 4.2 4.1 1 0 0 0
1 3.7 3.9 3.9 4.8 5.2 5.4 4.2 1 0 0 0
1 4.3 4.2 4.4 5.2 5.6 5.4 4.7 1 0 0 0
1 4.6 4.6 4.4 4.6 5.4 5.9 5.6 1 0 0 0
2 3.4 3.4 3.5 3.1 3.1 3.7 3.3 0 1 0 0
2 3.0 3.2 3.0 3.0 3.1 3.2 3.1 0 1 0 0
2 3.0 3.1 3.2 3.0 3.3 3.0 3.0 0 1 0 0
2 3.1 3.2 3.2 3.2 3.3 3.1 3.1 0 1 0 0
2 3.8 3.9 4.0 2.9 3.5 3.5 3.4 0 1 0 0
2 3.0 3.6 3.2 3.1 3.0 3.0 3.0 0 1 0 0
2 3.3 3.3 3.3 3.4 3.6 3.1 3.1 0 1 0 0
2 4.2 4.0 4.2 4.1 4.2 4.0 4.0 0 1 0 0
2 4.1 4.2 4.3 4.3 4.2 4.0 4.2 0 1 0 0
2 4.5 4.4 4.3 4.5 5.3 4.4 4.4 0 1 0 0
3 3.2 3.3 3.8 3.8 4.4 4.2 3.7 0 0 1 0
3 3.3 3.4 3.4 3.7 3.7 3.6 3.7 0 0 1 0
3 3.1 3.3 3.2 3.1 3.2 3.1 3.1 0 0 1 0
3 3.6 3.4 3.5 4.6 4.9 5.2 4.4 0 0 1 0
3 4.5 4.5 5.4 5.7 4.9 4.0 4.0 0 0 1 0
3 3.7 4.0 4.4 4.2 4.6 4.8 5.4 0 0 1 0
3 3.5 3.9 5.8 5.4 4.9 5.3 5.6 0 0 1 0
3 3.9 4.0 4.1 5.0 5.4 4.4 3.9 0 0 1 0
4 3.1 3.5 3.5 3.2 3.0 3.0 3.2 0 0 0 1
4 3.3 3.2 3.6 3.7 3.7 4.2 4.4 0 0 0 1
4 3.5 3.9 4.7 4.3 3.9 3.4 3.5 0 0 0 1
4 3.4 3.4 3.5 3.3 3.4 3.2 3.4 0 0 0 1
4 3.7 3.8 4.2 4.3 3.6 3.8 3.7 0 0 0 1
4 4.0 4.6 4.8 4.9 5.4 5.6 4.8 0 0 0 1
4 4.2 3.9 4.5 4.7 3.9 3.8 3.7 0 0 0 1
4 4.1 4.1 3.7 4.0 4.1 4.6 4.7 0 0 0 1
4 3.5 3.6 3.6 4.2 4.8 4.9 5.0 0 0 0 1

***************************************************
/* The following data set is mentioned on page 378,*/ 
/* and it is given in full on page 571.            */
**************************************************  

 1935  317.6 3078.5    2.8  40.29  417.5  10.5  33.1 1170.6  97.8 12.93  191.5
  1.8  209.9 1362.4   53.8
 1936  391.8 4661.7   52.6  72.76  837.8  10.2  45.0 2015.8 104.4 25.90  516.0
  0.8  355.3 1807.1   50.5
 1937  410.6 5387.1  156.9  66.26  883.9  34.7  77.2 2803.3 118.0 35.05  729.0
  7.4  469.9 2676.3  118.1
 1938  257.7 2792.2  209.2  51.60  437.9  51.8  44.6 2039.7 156.2 22.89  560.4
 18.1  262.3 1801.9  260.2
 1939  330.8 4313.2  203.4  52.41  679.7  64.3  48.1 2256.2 172.6 18.84  519.9
 23.5  230.4 1957.3  312.7
 1940  461.2 4643.9  207.2  69.41  727.8  67.1  74.4 2132.2 186.6 28.57  628.5
 26.5  261.6 2202.9  254.2
 1941  512.0 4551.2  255.2  68.35  643.6  75.2 113.0 1834.1 220.9 48.51  537.1
 36.2  472.8 2380.5  261.4
 1942  448.0 3244.1  303.7  46.80  410.9  71.4  91.9 1588.0 287.8 43.34  561.2
 60.8  445.6 2168.6  298.7
 1943  499.6 4053.7  264.1  47.40  588.4  67.1  61.3 1749.4 319.9 37.02  617.2
 84.4  361.6 1985.1  301.8
 1944  547.5 4379.3  201.6  59.57  698.4  60.5  56.8 1687.2 321.3 37.81  626.7
 91.2  288.2 1813.9  279.1
 1945  561.2 4840.9  265.0  88.78  846.4  54.6  93.6 2007.7 319.6 39.27  737.2
 92.4  258.7 1850.2  213.8
 1946  688.1 4900.9  402.2  74.12  893.8  84.8 159.9 2208.3 346.0 53.46  760.5
 86.0  420.3 2067.7  232.6
 1947  568.9 3526.5  761.5  62.68  579.0  96.8 147.2 1656.7 456.4 55.56  581.4
111.1  420.5 1796.7  264.8
 1948  529.2 3254.7  922.4  89.36  694.6 110.2 146.3 1604.4 543.4 49.56  662.3
130.6  494.5 1625.8  306.9
 1949  555.1 3700.2 1020.1  78.98  590.3 147.4  98.3 1431.8 618.3 32.04  583.8
141.8  405.1 1667.0  351.1
 1950  642.9 3755.6 1099.0 100.66  693.5 163.2  93.5 1610.5 647.4 32.24  635.2
136.7  418.8 1677.4  357.8
 1951  755.9 4833.0 1207.7 160.62  809.0 203.5 135.2 1819.4 671.3 54.38  723.8
129.7  588.2 2289.5  342.1
 1952  891.2 4924.9 1430.5 145.00  727.0 290.6 157.3 2079.7 726.1 71.78  864.1
145.5  645.2 2159.4  444.2
 1953 1304.4 6241.7 1777.3 174.93 1001.5 346.1 179.5 2371.6 800.3 90.08 1193.5
174.8  641.0 2031.3  623.6
 1954 1486.7 5593.6 2226.3 172.49  703.2 414.9 189.6 2759.9 888.9 68.60 1188.9
213.5  459.3 2115.5  669.7

***************************************************
/* The following data set is mentioned on page 392,*/ 
/* and it is given in full on page 572.            */
**************************************************  

1  1 1.28 1.09 1.33 1.24 1 0
1  1 1.60 1.38 2.21 1.90 1 0
1  1 2.46 2.27 2.43 2.19 1 0
1  1 1.41 1.34 1.81 1.47 1 0
1  1 1.40 1.31 0.85 0.85 1 0
1  1 1.12 0.96 1.20 1.12 1 0
1  1 0.90 0.66 0.90 0.78 1 0
1  1 2.41 1.69 2.79 1.90 1 0
1 -1 3.06 1.74 1.38 1.54 0 1
1 -1 2.68 2.41 2.10 2.13 0 1
1 -1 2.60 3.05 2.32 2.18 0 1
1 -1 1.48 1.20 1.30 1.41 0 1
1 -1 2.08 1.70 2.34 2.21 0 1
1 -1 2.72 1.89 2.48 2.05 0 1
1 -1 1.94 0.89 1.11 0.72 0 1
1 -1 3.35 2.41 3.23 2.83 0 1
1 -1 1.16 0.96 1.25 1.01 0 1

***************************************************
/* The following data set is mentioned on page 399,*/ 
/* and it is given in full on page 573.            */
**************************************************  

1  1  0  3  8  4 14 1 0 0
1  1  0  5 11  9 18 1 0 0
1  1  0 11 16 14 22 1 0 0
1  0  1  2  6  1  8 0 1 0
1  0  1  8 12  9 14 0 1 0
1  0  1 10  9  9 10 0 1 0
1 -1 -1  7 10  4 10 0 0 1
1 -1 -1  8 14 10 18 0 0 1
1 -1 -1  9 15 12 22 0 0 1


***************************************************
/* The following data set is mentioned on page 404,*/ 
/* and it is given in full on page 573.            */
**************************************************  

1 1 0 0 0 191 223 242 248 266 274 272 279 286 287 286 1
1 1 0 0 0  64  72  81  66  92 114 126 123 134 148 140 1
1 1 0 0 0 206 172 214 239 265 265 262 274 258 288 289 1
1 1 0 0 0 155 171 191 203 219 237 237 220 252 260 245 1
1 1 0 0 0  85 138 204 213 224 247 246 259 255 374 284 1
1 1 0 0 0  15  22  24  24  38  41  46  62  62  79  74 1
2 0 1 0 0  53  53 102 104 105 125 122 150  93 127 132 1
2 0 1 0 0  33  45  50  54  44  47  45  61  50  60  52 1
2 0 1 0 0  16  47  45  34  37  61  51  28  43  40  45 1
2 0 1 0 0 121 167 188 209 224 229 230 269 264 249 268 1
2 0 1 0 0 179 193 206 210 221 234 224 255 246 225 229 1
2 0 1 0 0 114  91 154 152 155 174 196 207 208 229 173 1
2 0 1 0 0  92 115 133 136 148 159 146 180 148 168 169 1
2 0 1 0 0  84  32  97  86  47  87 103 124 110 162 187 1
2 0 1 0 0  30  38  37  40  48  61  64  65  83  91  90 1
2 0 1 0 0  51  66 131 148 181 172 195 170 158 203 215 1
2 0 1 0 0 188 210 221 251 256 268 260 281 286 290 296 1
2 0 1 0 0 137 167 172 212 168 213 190 196 211 213 224 1
2 0 1 0 0 108  23  18  30  29  40  57  37  47  56  55 1
2 0 1 0 0 205 234 260 269 274 282 282 290 298 304 308 1
3 0 0 1 0 181 206 199 237 219 237 232 251 247 254 250 1
3 0 0 1 0 178 208 222 237 255 253 254 276 254 267 275 1
3 0 0 1 0 190 224 224 261 249 291 293 294 295 299 305 1
3 0 0 1 0 127 119 149 196 203 211 207 241 220 188 219 1
3 0 0 1 0  94 144 169 164 182 189 188 164 181 142 152 1
3 0 0 1 0 148 170 202 181 184 186 207 184 195 168 163 1
3 0 0 1 0  99  93 122 145 130 167 153 165 144 156 167 1
3 0 0 1 0 207 237 243 281 273 281 279 294 307 305 305 1
3 0 0 1 0 188 208 235 249 265 271 263 272 285 283 290 1
3 0 0 1 0 140 187 199 205 231 227 228 246 245 263 262 1
3 0 0 1 0 109  95 102  96 135 335 111 146 131 162 171 1
3 0 0 1 0  69  46  67  28  43  55  55  77  73  76  76 1
3 0 0 1 0  69  95 137  99  95 108 129 134 133 131  91 1
3 0 0 1 0  51  59  76 101  72  72 107  91 128 120 133 1
3 0 0 1 0 156 186 198 201 205 210 217 217 219 223 229 1
4 0 0 0 1 201 202 229 232 224 237 217 268 244 275 246 1
4 0 0 0 1 113 126 159 157 137 160 162 171 167 165 185 1
4 0 0 0 1  86  54  75  75  71 130 157 142 173 174 156 1
4 0 0 0 1 115 158 168 175 188 164 184 195 194 206 212 1
4 0 0 0 1 183 175 217 235 241 251 229 241 233 233 275 1
4 0 0 0 1 131 147 183 181 206 215 197 207 226 244 240 1
4 0 0 0 1  71 105 107  92 101 103  78  87  57  70  71 1
4 0 0 0 1 172 213 263 260 276 273 267 286 283 290 298 1
4 0 0 0 1 224 258 248 257 257 267 260 279 299 289 300 1
4 0 0 0 1 246 257 269 280 289 291 306 301 295 312 311 1

***************************************************
/* The following data set is mentioned on page 416,*/ 
/* and it is given in full on page 574.            */
**************************************************  

1 1 0 0 0 191 223 242 248 266 274 272 279 286 287 286 1
1 1 0 0 0  64  72  81  66  92 114 126 123 134 148 140 1
1 1 0 0 0 206 172 214 239 265 265 262 274 258 288 289 1
1 1 0 0 0 155 171 191 203 219 237 237 220 252 260 245 1
1 1 0 0 0  85 138 204 213 224 247 246 259 255 374 284 1
1 1 0 0 0  15  22  24  24  38  41  46  62  62  79  74 1
2 0 1 0 0  53  53 102 104 105 125 122 150  93 127 132 1
2 0 1 0 0  33  45  50  54  44  47  45  61  50  60  52 1
2 0 1 0 0  16  47  45  34  37  61  51  28  43  40  45 1
2 0 1 0 0 121 167 188 209 224 229 230 269 264 249 268 1
2 0 1 0 0 179 193 206 210 221 234 224 255 246 225 229 1
2 0 1 0 0 114  91 154 152 155 174 196 207 208 229 173 1
2 0 1 0 0  92 115 133 136 148 159 146 180 148 168 169 1
2 0 1 0 0  84  32  97  86  47  87 103 124 110 162 187 1
2 0 1 0 0  30  38  37  40  48  61  64  65  83  91  90 1
2 0 1 0 0  51  66 131 148 181 172 195 170 158 203 215 1
2 0 1 0 0 188 210 221 251 256 268 260 281 286 290 296 1
2 0 1 0 0 137 167 172 212 168 213 190 196 211 213 224 1
2 0 1 0 0 108  23  18  30  29  40  57  37  47  56  55 1
2 0 1 0 0 205 234 260 269 274 282 282 290 298 304 308 1
3 0 0 1 0 181 206 199 237 219 237 232 251 247 254 250 1
3 0 0 1 0 178 208 222 237 255 253 254 276 254 267 275 1
3 0 0 1 0 190 224 224 261 249 291 293 294 295 299 305 1
3 0 0 1 0 127 119 149 196 203 211 207 241 220 188 219 1
3 0 0 1 0  94 144 169 164 182 189 188 164 181 142 152 1
3 0 0 1 0 148 170 202 181 184 186 207 184 195 168 163 1
3 0 0 1 0  99  93 122 145 130 167 153 165 144 156 167 1
3 0 0 1 0 207 237 243 281 273 281 279 294 307 305 305 1
3 0 0 1 0 188 208 235 249 265 271 263 272 285 283 290 1
3 0 0 1 0 140 187 199 205 231 227 228 246 245 263 262 1
3 0 0 1 0 109  95 102  96 135 335 111 146 131 162 171 1
3 0 0 1 0  69  46  67  28  43  55  55  77  73  76  76 1
3 0 0 1 0  69  95 137  99  95 108 129 134 133 131  91 1
3 0 0 1 0  51  59  76 101  72  72 107  91 128 120 133 1
3 0 0 1 0 156 186 198 201 205 210 217 217 219 223 229 1
4 0 0 0 1 201 202 229 232 224 237 217 268 244 275 246 1
4 0 0 0 1 113 126 159 157 137 160 162 171 167 165 185 1
4 0 0 0 1  86  54  75  75  71 130 157 142 173 174 156 1
4 0 0 0 1 115 158 168 175 188 164 184 195 194 206 212 1
4 0 0 0 1 183 175 217 235 241 251 229 241 233 233 275 1
4 0 0 0 1 131 147 183 181 206 215 197 207 226 244 240 1
4 0 0 0 1  71 105 107  92 101 103  78  87  57  70  71 1
4 0 0 0 1 172 213 263 260 276 273 267 286 283 290 298 1
4 0 0 0 1 224 258 248 257 257 267 260 279 299 289 300 1
4 0 0 0 1 246 257 269 280 289 291 306 301 295 312 311 1

***************************************************
/* The following data set is mentioned on page 433,*/ 
/* and it is given in full on page 575.            */
**************************************************  

1 47.8 48.8 49.0 49.7  1
1 46.4 47.3 47.7 48.4  2
1 46.3 46.8 47.8 48.5  3
1 45.1 45.3 46.1 47.2  4
1 47.6 48.5 48.9 49.3  5
1 52.5 53.2 53.3 53.7  6
1 51.2 53.0 54.3 54.5  7
1 49.8 50.0 50.3 52.7  8
1 48.1 50.8 52.3 54.4  9
1 45.0 47.0 47.3 48.3 10
1 51.2 51.4 51.6 51.9 11
1 48.5 49.2 53.0 55.5 12
1 52.1 52.8 53.7 55.0 13
1 48.2 48.9 49.3 49.8 14
1 49.6 50.4 51.2 51.8 15
1 50.7 51.7 52.7 53.3 16
1 47.2 47.7 48.4 49.5 17
1 53.3 54.6 55.1 55.3 18
1 46.2 47.5 48.1 48.4 19
1 46.3 47.6 51.3 51.8 20

***************************************************
/* The following data set is mentioned on page 450,*/ 
/* and it is given in full on page 575.            */
**************************************************  

1  1 1 20
1  1 2 21
1  1 3 42
1  1 4 32
1  1 5 32
1  2 1 67
1  2 2 29
1  2 3 56
1  2 4 39
1  2 5 41
1  3 1 37
1  3 2 25
1  3 3 28
1  3 4 31
1  3 5 34
1  4 1 42
1  4 2 38
1  4 3 36
1  4 4 19
1  4 5 35
1  5 1 57
1  5 2 32
1  5 3 21
1  5 4 30
1  5 5 29
1  6 1 39
1  6 2 38
1  6 3 54
1  6 4 31
1  6 5 28
1  7 1 43
1  7 2 20
1  7 3 46
1  7 4 42
1  7 5 31
1  8 1 35
1  8 2 34
1  8 3 43
1  8 4 35
1  8 5 42
1  9 1 41
1  9 2 23
1  9 3 51
1  9 4 27
1  9 5 30
1 10 1 39
1 10 2 24
1 10 3 35
1 10 4 26
1 10 5 32
2 11 1 47
2 11 2 25
2 11 3 36
2 11 4 21
2 11 5 27
2 12 1 53
2 12 2 32
2 12 3 48
2 12 4 46
2 12 5 54
2 13 1 38
2 13 2 33
2 13 3 42
2 13 4 48
2 13 5 49
2 14 1 60
2 14 2 41
2 14 3 67
2 14 4 53
2 14 5 50
2 15 1 37
2 15 2 35
2 15 3 45
2 15 4 34
2 15 5 46
2 16 1 59
2 16 2 37
2 16 3 52
2 16 4 36
2 16 5 52
2 17 1 67
2 17 2 33
2 17 3 61
2 17 4 31
2 17 5 50
2 18 1 43
2 18 2 27
2 18 3 36
2 18 4 33
2 18 5 32
2 19 1 64
2 19 2 53
2 19 3 62
2 19 4 40
2 19 5 43
2 20 1 41
2 20 2 34
2 20 3 47
2 20 4 37
2 20 5 46


***************************************************
/* The following data set is mentioned on page 454,*/ 
/* and it is given in full on page 577.            */
**************************************************  

1  1 1 1.28 1.09 0
1  1 2 1.33 0 1.24
1  2 1 1.60 1.38 0
1  2 2 2.21 0 1.90
1  3 1 2.46 2.27 0
1  3 2 2.43 0 2.19
1  4 1 1.41 1.34 0
1  4 2 1.81 0 1.47
1  5 1 1.40 1.31 0
1  5 2 0.85 0 0.85
1  6 1 1.12 0.96 0
1  6 2 1.20 0 1.12
1  7 1 0.90 0.66 0
1  7 2 0.90 0 0.78
1  8 1 2.41 1.69 0
1  8 2 2.79 0 1.90
2  9 1 3.06 1.74 0
2  9 2 1.38 0 1.54
2  10 1 2.68 2.41 0
2  10 2 2.10 0 2.13
2  11 1 2.60 3.05 0
2  11 2 2.32 0 2.18
2  12 1 1.48 1.20 0
2  12 2 1.30 0 1.41
2  13 1 2.08 1.70 0
2  13 2 2.34 0 2.21
2  14 1 2.72 1.89 0
2  14 2 2.48 0 2.05
2  15 1 1.94 0.89 0
2  15 2 1.11 0 0.72
2  16 1 3.35 2.41 0
2  16 2 3.23 0 2.83
2  17 1 1.16 0.96 0
2  17 2 1.25 0 1.01

***************************************************
/* The following data sets are mentioned on pages  */
/* 463 and 464, and they are given in full on      */
/* pages 578.579, and 580.                         */
**************************************************  
/* HLM.DAT                                         */

1 0
1 1
1 3
1 1
1 1
1 2
1 2
1 1
1 1
1 2
2 2
2 3
2 4
2 2
2 1
2 1
2 2
2 2
2 3
2 4
3 2
3 3
3 4
3 4
3 2
3 1
3 2
3 3
3 2
3 2
4 2
4 4
4 5
4 3
4 2
4 1
4 3
4 3
4 2
4 4
5 1
5 0
5 2
5 1
5 1
5 2
5 1
5 0
5 1
5 3

/* HLMNEST.DAT                                         */

1 1  3
1 1  6
1 1  3
1 1  3
1 2  1
1 2  2
1 2  2
1 2  2
1 3  5
1 3  6
1 3  5
1 3  6
1 4  2
1 4  3
1 4  4
1 4  3
2 5  7
2 5  8
2 5  7
2 5  6
2 6  4
2 6  5
2 6  4
2 6  3
2 7  7
2 7  8
2 7  9
2 7  8
2 8 10
2 8 10
2 8  9
2 8 11

/* HLMCROSS.DAT                                         */

1  1  65
1  1  70
1  2  70
1  2  78
1  3  62
1  3  66
1  4  56
1  4  64
1  5  62
1  5  70
1  6  45
1  6  48
1  7  56
1  7  69
1  8  82
1  8  86
1  9  53
1  9  54
1 10  82
1 10  88
-1 1 140
-1 1 155
-1 2 159
-1 2 163
-1 3 163
-1 3 181
-1 4 139
-1 4 142
-1 5 127
-1 5 138
-1 6 141
-1 6 146
-1 7 130
-1 7 138
-1 8 139
-1 8 144
-1 9 128
-1 9 130
-1 10 156
-1 10 165

/* HLMSPLIT.DAT                                         */

1 3 4 7  7
2 6 5 8  8
3 3 4 7  9
4 3 3 6  8
5 1 2 5 10
6 2 3 6 10
7 2 4 5  9
8 2 3 6 11


***************************************************
/* The following data set is mentioned on page 475, */ 
/* and it is given in full on page 580.             */
**************************************************  

 1 61 72 118 130 176 170
 2 65 85 129 148 174 194
 3 57 68 130 143 201 187
 4 46 74 116 124 157 156
 5 47 85 103 117 148 155
 6 43 58 109 133 152 150
 7 53 62  82 112 156 138
 8 72 96 117 129 154 154
 9 53 54  87 120 138 149
10 72 98 114 144 177 167

***************************************************
/* The following data set is mentioned on page 493 ,*/ 
/* and it is given in full on page 581.            */
**************************************************  

 1 1 .04  .20  .10  .08
 2 1 .02  .06  .02  .02
 3 1 .07 1.40  .48  .24
 4 1 .17  .57  .35  .24
 5 2 .10  .09  .13  .14
 6 2 .12  .11  .10  m
 7 2 .07  .07  .07  .07
 8 2 .05  .07  .06  .07
 9 3 .03  .62  .31  .22
10 3 .03 1.05  .73  .60
11 3 .07  .83 1.07  .80
12 3 .09 3.13 2.06 1.23
13 4 .10  .09  .09  .08
14 4 .08  .09  .09  .10
15 4 .13  .10  .12  .12
16 4 .06  .05  .05  .05

***************************************************
/* The following data set is mentioned on page 506,*/ 
/* and it is given in full on page 581.            */
**************************************************  

1 194  209  250  279  312  493    m    m    m    m    m    m    m    m    m
    m    m    m    m    m    m    m    m    m    m    m    m    m    m    m
01
1  413  427  485  522  622  687  696  865 1312 1496 1532 1733 1851 1855 1916
1934 1952 2019 2076 2138 2145 2167 2201    m    m    m    m    m    m    m
02
1   90  100  160  346  407  456  470  494  550  570  649  733  777  836  865
983  1008 1164 1476 1550 1576 1620 1643 1708 1835 2043 2113 2214 2422    m
03
1   74  131  179  208  710  722  792  813  842 1228 1287 1314 1467 1493 1819
m    m    m    m    m    m    m    m    m    m    m    m    m    m    m
04
1   55  375  440  544  764 1003 1050 1296 1472 1654 1687 1702 1806 1841    m
m    m    m    m    m    m    m    m    m    m    m    m    m    m    m
05
1   23   284  371  378  498  512  574  621  846  917 1163 1184 1226 1246 1251
1263 1383  1394 1397 1411 1482 1493 1507 1518 1564 1624 1625 1640 1692 1787
06
1   97   148  159  163  304  322  464  532  609  689  690  706  812 1018 1100
1154 1185  1401 1447 1558 1597 1660 1678 1869 1887 2050 2074    m    m    m
07
1   50    94  196  268  290  329  332  347  544  732  811  899  946  950  995
991 1013  1152 1362 1572 1669 1699 1722 1735 1749    m    m    m    m    m
08
1  359   368  380  650 1253 1256 1360 1362 1800    m    m    m    m    m    m
m    m     m    m    m    m    m    m    m    m    m    m    m    m    m
09
1   50   304  309  592  627  639    m    m    m    m    m    m    m    m    m
m    m     m    m    m    m    m    m    m    m    m    m    m    m    m
10
1  130   623    m    m    m    m    m    m    m    m    m    m    m    m    m
m    m     m    m    m    m    m    m    m    m    m    m    m    m    m
11
1  487   505  605  612  710  715  800  891  934 1164 1167 1297    m    m    m
m    m     m    m    m    m    m    m    m    m    m    m    m    m    m
12
1  102   311  325  382  436  468  535  595  737  889  916 1146 1376 1422 1476
m    m     m    m    m    m    m    m    m    m    m    m    m    m    m
13
***************************************************
/* The following data sets are mentioned on pages 513   */
/* and 514, and they are given in full on page 582, 583 */
/* and 584.                                             */
**************************************************  

/* 10_7.dat                                        */

1 4.0 4.0 4.1 3.6 3.6 3.8 3.1  1 1 0 0 0
1   m 4.3 4.7 4.7 4.8 5.0 5.2  2 1 0 0 0
1   m   m 4.3 4.3 4.5 5.8 5.4  3 1 0 0 0
1 4.2 4.4 4.6 4.9 5.3 5.6 4.9  4 1 0 0 0
1   m 4.4 5.3 5.6 5.9 5.9 5.3  5 1 0 0 0
1   m   m 4.9 5.2 5.3 4.2 4.1  6 1 0 0 0
1 3.7 3.9 3.9 4.8 5.2 5.4 4.2  7 1 0 0 0
1   m   m 4.4 5.2 5.6 5.4 4.7  8 1 0 0 0
1   m 4.6 4.4 4.6 5.4 5.9 5.6  9 1 0 0 0
2 3.4 3.4 3.5 3.1 3.1 3.7 3.3 10 0 1 0 0
2 3.0 3.2 3.0 3.0 3.1 3.2 3.1 11 0 1 0 0
2   m 3.1 3.2 3.0 3.3 3.0 3.0 12 0 1 0 0
2   m   m 3.2 3.2 3.3 3.1 3.1 13 0 1 0 0
2 3.8 3.9 4.0 3.9 3.5 3.5 3.4 14 0 1 0 0
2   m   m 3.2 3.1 3.0 3.0 3.0 15 0 1 0 0
2   m 3.3 3.3 3.4 3.6 3.1 3.1 16 0 1 0 0
2 4.2 4.0 4.2 4.1 4.2 4.0 4.0 17 0 1 0 0
2 4.1 4.2 4.3 4.3 4.2 4.0 4.2 18 0 1 0 0
2   m 4.4 4.3 4.5 4.3 4.4 4.4 19 0 1 0 0
3   m 3.3 3.8 3.8 4.4 4.2 4.0 20 0 0 1 0
3   m   m 3.4 3.7 3.7 3.6 3.7 21 0 0 1 0
3 3.1 3.3 3.2 3.1 3.2 3.1 3.1 22 0 0 1 0
3   m 3.4 3.5 4.6 4.9 5.2 4.4 23 0 0 1 0
3   m   m 5.4 5.7 4.9 4.0 4.0 24 0 0 1 0
3   m 4.0 4.4 4.2 4.6 4.8 5.4 25 0 0 1 0
3 3.5 3.9 5.8 5.4 4.9 5.3 5.6 26 0 0 1 0
3   m   m 4.1 5.0 5.4 4.4 3.9 27 0 0 1 0
4   m 3.5 3.5 3.2 3.0 3.0 3.2 28 0 0 0 1
4   m 3.2 3.6 3.7 3.7 4.2 4.4 29 0 0 0 1
4   m   m 4.7 4.3 3.9 3.4 3.5 30 0 0 0 1
4 3.4 3.4 3.5 3.3 3.4 3.2 3.4 31 0 0 0 1
4   m   m 4.2 4.3 3.6 3.8 3.7 32 0 0 0 1
4 4.0 4.6 4.8 4.9 5.4 5.6 4.8 33 0 0 0 1
4   m 3.9 4.5 4.7 3.9 3.8 3.7 34 0 0 0 1
4 4.1 4.1 3.7 4.0 4.1 4.6 4.7 35 0 0 0 1
4 3.5 3.6 3.6 4.2 4.8 4.9 5.0 36 0 0 0 1

                                       
/* 10_7.DA1 
                           */
1 4.0 4.0 4.1 3.6 3.6 3.8 3.1  1 1 0 0 0
1 4.2 4.4 4.6 4.9 5.3 5.6 4.9  4 1 0 0 0
1 3.7 3.9 3.9 4.8 5.2 5.4 4.2  7 1 0 0 0
1 3.4 3.4 3.5 3.1 3.1 3.7 3.3 10 0 1 0 0
1 3.0 3.2 3.0 3.0 3.1 3.2 3.1 11 0 1 0 0
1 3.8 3.9 4.0 3.9 3.5 3.5 3.4 14 0 1 0 0
1 4.2 4.0 4.2 4.1 4.2 4.0 4.0 17 0 1 0 0
1 4.1 4.2 4.3 4.3 4.2 4.0 4.2 18 0 1 0 0
1 3.1 3.3 3.2 3.1 3.2 3.1 3.1 22 0 0 1 0
1 3.5 3.9 5.8 5.4 4.9 5.3 5.6 26 0 0 1 0
1 3.4 3.4 3.5 3.3 3.4 3.2 3.4 31 0 0 0 1
1 4.0 4.6 4.8 4.9 5.4 5.6 4.8 33 0 0 0 1
1 4.1 4.1 3.7 4.0 4.1 4.6 4.7 35 0 0 0 1
1 3.5 3.6 3.6 4.2 4.8 4.9 5.0 36 0 0 0 1


/* 10_7.DA2                            */

2 4.3 4.7 4.7 4.8 5.0 5.2  2 1 0 0 0
2 4.4 5.3 5.6 5.9 5.9 5.3  5 1 0 0 0
2 4.6 4.4 4.6 5.4 5.9 5.6  9 1 0 0 0
2 3.1 3.2 3.0 3.3 3.0 3.0 12 0 1 0 0
2 3.3 3.3 3.4 3.6 3.1 3.1 16 0 1 0 0
2 4.4 4.3 4.5 4.3 4.4 4.4 19 0 1 0 0
2 3.3 3.8 3.8 4.4 4.2 4.0 20 0 0 1 0
2 3.4 3.5 4.6 4.9 5.2 4.4 23 0 0 1 0
2 4.0 4.4 4.2 4.6 4.8 5.4 25 0 0 1 0
2 3.5 3.5 3.2 3.0 3.0 3.2 28 0 0 0 1
2 3.2 3.6 3.7 3.7 4.2 4.4 29 0 0 0 1
2 3.9 4.5 4.7 3.9 3.8 3.7 34 0 0 0 1
                                       

/* 10_7.DA3                            */

3 4.3 4.5 5.8 5.4  3 1 0 0 0
3 5.2 5.3 4.2 4.1  6 1 0 0 0
3 5.2 5.6 5.4 4.7  8 1 0 0 0
3 3.2 3.3 3.1 3.1 13 0 1 0 0
3 3.1 3.0 3.0 3.0 15 0 1 0 0
3 3.7 3.7 3.6 3.7 21 0 0 1 0
3 5.7 4.9 4.0 4.0 24 0 0 1 0
3 5.0 5.4 4.4 3.9 27 0 0 1 0
3 4.3 3.9 3.4 3.5 30 0 0 0 1
3 4.3 3.6 3.8 3.7 32 0 0 0 1

/* 10_7.DA4                            */

1 4.0 4.0 4.1 3.6 3.6 3.8 3.1  1 1 0 0 0
1 4.2 4.4 4.6 4.9 5.3 5.6 4.9  4 1 0 0 0
1 3.7 3.9 3.9 4.8 5.2 5.4 4.2  7 1 0 0 0
1 3.4 3.4 3.5 3.1 3.1 3.7 3.3 10 0 1 0 0
1 3.0 3.2 3.0 3.0 3.1 3.2 3.1 11 0 1 0 0
1 3.8 3.9 4.0 3.9 3.5 3.5 3.4 14 0 1 0 0
1 4.2 4.0 4.2 4.1 4.2 4.0 4.0 17 0 1 0 0
1 4.1 4.2 4.3 4.3 4.2 4.0 4.2 18 0 1 0 0
1 3.1 3.3 3.2 3.1 3.2 3.1 3.1 22 0 0 1 0
1 3.5 3.9 5.8 5.4 4.9 5.3 5.6 26 0 0 1 0
1 3.4 3.4 3.5 3.3 3.4 3.2 3.4 31 0 0 0 1
1 4.0 4.6 4.8 4.9 5.4 5.6 4.8 33 0 0 0 1
1 4.1 4.1 3.7 4.0 4.1 4.6 4.7 35 0 0 0 1
1 3.5 3.6 3.6 4.2 4.8 4.9 5.0 36 0 0 0 1
2 0.0 4.3 4.7 4.7 4.8 5.0 5.2  2 1 0 0 0
2 0.0 4.4 5.3 5.6 5.9 5.9 5.3  5 1 0 0 0
2 0.0 4.6 4.4 4.6 5.4 5.9 5.6  9 1 0 0 0
2 0.0 3.1 3.2 3.0 3.3 3.0 3.0 12 0 1 0 0
2 0.0 3.3 3.3 3.4 3.6 3.1 3.1 16 0 1 0 0
2 0.0 4.4 4.3 4.5 4.3 4.4 4.4 19 0 1 0 0
2 0.0 3.3 3.8 3.8 4.4 4.2 4.0 20 0 0 1 0
2 0.0 3.4 3.5 4.6 4.9 5.2 4.4 23 0 0 1 0
2 0.0 4.0 4.4 4.2 4.6 4.8 5.4 25 0 0 1 0
2 0.0 3.5 3.5 3.2 3.0 3.0 3.2 28 0 0 0 1
2 0.0 3.2 3.6 3.7 3.7 4.2 4.4 29 0 0 0 1
2 0.0 3.9 4.5 4.7 3.9 3.8 3.7 34 0 0 0 1
3 0.0 0.0 0.0 4.3 4.5 5.8 5.4  3 1 0 0 0
3 0.0 0.0 0.0 5.2 5.3 4.2 4.1  6 1 0 0 0
3 0.0 0.0 0.0 5.2 5.6 5.4 4.7  8 1 0 0 0
3 0.0 0.0 0.0 3.2 3.3 3.1 3.1 13 0 1 0 0
3 0.0 0.0 0.0 3.1 3.0 3.0 3.0 15 0 1 0 0
3 0.0 0.0 0.0 3.7 3.7 3.6 3.7 21 0 0 1 0
3 0.0 0.0 0.0 5.7 4.9 4.0 4.0 24 0 0 1 0
3 0.0 0.0 0.0 5.0 5.4 4.4 3.9 27 0 0 1 0
3 0.0 0.0 0.0 4.3 3.9 3.4 3.5 30 0 0 0 1
3 0.0 0.0 0.0 4.3 3.6 3.8 3.7 32 0 0 0 1

****************************************************
/* The following POWER.PRO program is mentioned on */
/* pages 253 - 254, and it is given in full on     */
/* pages 523 - 550.                                */
****************************************************  





*                        November 1, 1992                            *;
**********************************************************************;
*23456789A123456789B123456789C123456789D123456789E123456789F123456789G;
**********************************************************************;
*  This SAS code, used inside PROC IML via an INCLUDE statement,     *;
*  performs a power analysis of multivariate linear hypotheses       *;
*  of the form C*B*U - THETA0 = 0. The associated model is Y=X*B+E.  *;
*  Users must enter PROC IML to create the following matrices.       *;
*                                                                    *;
*  Note: Vectors may be entered as rows or columns.                  *;
*                                                                    *;
*  A) REQUIRED MATRICES                                              *;
*                                                                    *;
*    (1) ESSENCEX, the essence design matrix.  Users unfamiliar with *;
*        this matrix may simply enter the full design matrix and     *;
*        specify that REPN below be equal to 1.                      *;
*    (2) SIGMA, the hypothesized covariance matrix                   *;
*    (3) BETA, the matrix of hypothesized regression coefficients    *;
*    (4) C, "between" subject contrast for pre-multiplying BETA      *;
*                                                                    *;
*  WARNING:  ESSENCEX, C, and U must be full rank.                   *;
*            U`*SIGMA*U must besymmetric and positive definite.      *;
*            For univariate repeated measures,                       *;
*            U should be proportional to an orthonormal matrix.      *;
*                                                                    *;
*  B) OPTIONAL MATRICES                                              *;
*    (1) REPN, (vector), the # of times each row of ESSENCEX is      *;
*        duplicated. Default of {1}.                                 *;
*    (2) U, "within" subject contrast for post-multiplying BETA      *;
*        Default of I(p), where p=NCOL(BETA).                        *;
*    (3) THETA0, the matrix of constants to be subtracted from       *;
*        C*BETA*U (CBU). Default matrix of zeroes.                   *;
*    (4) ALPHA,  (vector), the Type I error rate (test size).        *;
*        Default of .05.                                             *;
*    (5) SIGSCAL, (vector), multipliers of SIGMA.                    *;
*        Default of {1}.                                             *;
*    (6) RHOSCAL, (vector), multipliers of RHO (correlation matrix)  *;
*        computed internally from SIGMA).                            *;
*        Default of {1}.                                             *;
*    (7) BETASCAL, (vector), multipliers of BETA.                    *;
*        Default of {1}.                                             *;
*    (8) ROUND, (scalar) # of places to which power values will      *;
*        be rounded. Default of 3.                                   *;
*    (9) TOLERANC, (scalar)  value not tolerated, numeric zero,      *;
*        used for checking singularity, division problems, etc.      *;
*        singularity. Default of 1E-12.                              *;
*   (10) OPT_ON                                                      *;
*        OPT_OFF, (vectors), users can specify the options they wish *;
*        to turn on or off. The possible options are as follows:     *;
*                                                                    *;
*          a) Power calculations                  Default            *;
*             HLT, Hotelling-Lawley trace           off              *;
*             PBT, Pillai-Bartlett trace            off              *;
*             WLK, Wilk's Lambda                    on               *;
*             UNI, uncorrected univariate                            *;
*                  repeated measures                off              *;
*             UNIGG, Geisser-Greenhouse             on               *;
*             UNIHF, Huynh-Feldt                    off              *;
*            *COLLAPSE, special case                on               *;
*                                                                    *;
*            *With rank(U)=1 powers of all tests coincide.           *;
*             The COLLAPSE option produces one column of power       *;
*             calculations labeled "POWER" instead of separate       *;
*             columns for WLK, HLT, UNI, etc.                        *;
*                                                                    *;
*             With rank(C)=1 and rank(U)>1, powers of all 3          *;
*             multivariate statistics (WLK HLT PBT) coincide.        *;
*             The COLLAPSE option produces one column for all 3.     *;
*             UNI, UNIGG, and UNIHF powers calculated if requested.  *;
*                                                                    *;
*             NONCEN_N, multiply noncentrality by                    *;
*                       N/(N-rk(X)) if min(rk(C),rk(U))>1            *;
*                       for multivariate tests                       *;
*                       (O'Brien & Shieh, 1992)     off              *;
*                                                                    *;
*           b) Print/options for output power matrix (SAS dataset)   *;
*              TOTAL_N,  total number observations  on               *;
*              SIGSCAL,  multiplier for SIGMA       on               *;
*              RHOSCAL,  multiplier for RHO         on               *;
*              BETASCAL, multiplier for BETA        on               *;
*              ALPHA,    size of test               on               *;
*              CASE,     row # of matrix            on               *;
*              MAXRHOSQ, max canonical rho squared  off              *;
*                                                                    *;
*           c) Print options - additional matrices                   *;
*              BETA, beta matrix                    on               *;
*              SIGMA, variance-covariance matrix    on               *;
*              RHO, correlation matrix              on               *;
*              C, "between" subjects contrast       on               *;
*              U, "within" subject contrast         on               *;
*              THETA0, constant to compare to CBU   on, if  ^= 0     *;
*              CBETAU, value of initial C*BETA*U    on               *;
*              RANKX, rank of X                     off              *;
*              RANKC, rank of C                     off              *;
*              RANKU, rank of U                     off              *;
*                                                                    *;
*           d) Power data options                                    *;
*              NOPRINT, printed output suppressed   off              *;
*              DS , request output SAS dataset      off              *;
*                                                                    *;
*           e) WARN, allows warning messages        on               *;
*              to print.                                             *;
*                                                                    *;
*                                                                    *;
*    (11) DSNAME, (1 row, 2-3 cols), name of output SAS data file.   *;
*         Default WORK.PWRDT###.                                     *;
*                                                                    *;
* C) SAS DATA FILE                                                   *;
*                                                                    *;
*   If the DS option is selected, the output data file will contain  *;
*   all options requested in a) and b). The user can name the data   *;
*   file by defining the matrix DSNAME= { libref dataset }. For      *;
*   example, if DSNAME = {IN1 MYDATA}, the output data file will be  *;
*   called IN1.MYDATA. IN1 refers to a library defined by a DD       *;
*   statement or a LIBNAME statement.                                *;
*                                                                    *;
*   When using a library other than WORK as the default, define      *;
*   DSNAME = {libref dataset defaultlib};                            *;
*                                                                    *;
*   If DSNAME is not defined or if the "dataset" already exists in   *;
*   the library specified by "libref", a default file name is used.  *;
*   The default file names are numbered and of the form PWRDT###     *;
*   (where ### is a number). The program scans the library for the   *;
*   largest numbered data file and assigns the next number to the new*;
*   data file. The maximum ### is 999.If PWRDT999 exists no more data*;
*   files can be created.                                            *;
*                                                                    *;
*   NOTE: The program uses the name _PWRDTMP as an intermediate      *;
*   dataset. If this dataset already exists in the specified library *;
*   no datasets can be created.                                      *;
*                                                                    *;
**********************************************************************;

                  *****MODULE DEFINITIONS*****;

**NOTE: The modules used by the MAIN CODE are defined first.       ***;

***********************************************************************
*                      _INPTCHK                                       *
*                                                                     *
*  This module performs a number of checks on the user-supplied data. *
**********************************************************************;

START _INPTCHK(CHECKER,_R, _A, _B, _S)
      GLOBAL (ESSENCEX, BETA, SIGMA, C, U, THETA0, TOLERANC, SIGSCAL);

   *_______________________________________________________________*
    INPUTS
    1) User or program supplied -GLOBAL
       ESSENCEX, the essence design matrix.
       SIGMA, the hypothesized variance-covariance matrix
       BETA, the matrix of hypothesized regression coefficients
       U, the matrix post-multiplying BETA
       C, the matrix pre-multiplying BETA
       THETA0, the matrix of constants to be subtracted from CBU
       TOLERANC, value not tolerated, numeric zero
       SIGSCAL, vector of scaling values for covariance matrix

    2) Program supplied
       _R, rank of design matrix, X
       _A, rank of "between" subject contrast matrix, C
       _B, rank of "within" subject contrast matrix, U
       _S, minimum of _A and _B
    OUTPUTS
       CHECKER=0 if no error, 1 if error present
   *_______________________________________________________________*;


   CHECKER = 0;
   IF MIN(VECDIAG(SIGMA))<=TOLERANC THEN DO;
      CHECKER=1;
      PRINT "At least one variance <=TOLERANC. Check SIGMA.";
      PRINT SIGMA;
      END;
   IF (NROW(U) ^= NROW(SIGMA)) THEN DO;
      CHECKER = 1;
      PRINT "Number of rows U not equal to number of rows of SIGMA.";
      PRINT U,,,,, SIGMA;
      END;
   IF (NCOL(C) ^= NROW(BETA)) THEN DO;
      CHECKER = 1;
      PRINT "# of columns of C not equal to number of rows of BETA.";
      PRINT C,,,,, BETA;
      END;
   IF (NCOL(BETA) ^= NROW(U)) THEN DO;
      CHECKER = 1;
      PRINT "# of columns of BETA not equal to number of rows of U.";
      PRINT BETA,,,,, U;
      END;
   IF (_R ^= NROW(BETA)) THEN DO;
      CHECKER = 1;
      PRINT "# of columns of X not equal to number of rows of BETA.";
      PRINT ESSENCEX,,,,, BETA;
      END;
   IF (_A > NCOL(C)) THEN DO;
      CHECKER = 1;
      PRINT "# of rows of C greater than number of columns of C.";
      PRINT C;
      END;
   IF (_B > NROW(U)) THEN DO;
      CHECKER = 1;
      PRINT "# of columns of U greater than number of rows of U.";
      PRINT U;
      END;
   IF (NROW(THETA0) > 0) THEN IF (NROW(THETA0) ^= _A) THEN DO;
      CHECKER = 1;
      PRINT "The THETA0 matrix does not conform to CBU.";
      PRINT THETA0;
      PRINT "#Rows of CBU = " _A;
      END;
   IF (NROW(THETA0) > 0) THEN IF (NCOL(THETA0) ^= _B) THEN DO;
      CHECKER = 1;
      PRINT "The THETA0 matrix does not conform to CBU.";
      PRINT THETA0;
      PRINT "#Cols of CBU = " _B;
      END;
   IF MIN(SIGSCAL)<=TOLERANC THEN DO;
      CHECKER = 1;
      PRINT "smallest value in SIGSCAL <= TOLERANC (too small)";
      PRINT SIGSCAL TOLERANC;
      END;

FINISH;  *_INPTCHK;

*********************************************************************;
*                   _OPTCHK                                          *
*                                                                   *
* Check to see if selected options are valid requests.              *
*********************************************************************;

START _OPTCHK(CHECKER,
             _PG1LABL, _PWRLABL, _PRTLABL, _DATLABL,_WRNLABL,_NONLABL,
             _OPT_ON, _OPT_OFF);

   *_______________________________________________________________*
    INPUTS
    1) Program supplied
       _PG1LABL, (column) options for printing matrices
       _PWRLABL, (column) options for power calculations
       _PRTLABL, (column) options for output power matrix
       _DATLABL, (column) options for power data output
       _WRNLABL, (column) options for turning on warning messages
       _OPT_ON, (column) selected options to turn on
       _OPT_OFF, (column) selected options to turn off
    OUTPUTS
       CHECKER=0 if no error, 1 if error present
   *_______________________________________________________________*;

   CHECKER=0;
   IF (( NROW(_OPT_ON) > 0) | (NROW(_OPT_OFF) > 0 )) THEN DO;
     _SELECT = _PG1LABL //_PWRLABL //_PRTLABL//_DATLABL//_WRNLABL
                                                       //_NONLABL;
     _OPT    = _OPT_ON // _OPT_OFF;
     _ERR = SETDIF(_OPT,_SELECT);
     IF NROW(_ERR) ^= 0 THEN DO;
       PRINT _ERR ":Invalid options requested in OPT_ON or OPT_OFF.";
       CHECKER=1;
       END;
   END;

FINISH;  *_OPTCHK;

***********************************************************************
*                            _SNGRCHK                                 *
*                                                                     *
*This module checks matrices for singularity. Use for the following:  *
*             - ESSENCEX`*ESSENCEX                                    *
*             - U`*SIGMA*U                                            *
*             - C*INV(X`X)*C`                                         *
**********************************************************************;


START _SNGRCHK
             (matrix,name)      GLOBAL (TOLERANC);
   *_______________________________________________________________*
    INPUTS
      matrix, matrix which will be checked
      name, label to identify the matrix

      TOLERANC,  value not tolerated, numeric zero (global)

    OUTPUTS
       _error, =1 if matrix is not symmetric or positive definite
   *_______________________________________________________________*;

   _error=0;

   IF ALL(MATRIX=.) THEN DO;
      _error=1;
      NOTE0_1 = { " (labeled MATRIX below) ",
                  " is all missing values."};
      PRINT name NOTE0_1 , matrix;
      RETURN(_error);
      END;

    _MAXVAL=MAX(ABS(MATRIX));

   IF _MAXVAL<=TOLERANC THEN DO;
      _error=1;
      NOTE0_2= { " (labeled MATRIX below) ",
                " has max(abs(all elements)) <= TOLERANC."};
      PRINT name NOTE0_2 , matrix;
      RETURN(_error);
      END;

   _NMATRIX=MATRIX / _MAXVAL;

   ** SQRT IN NEXT LINE DUE TO NUMERICAL INACCURACY IN SSCP
      CALCULATION WITH SOME DATA VIA SWEEP;

   IF MAX(ABS(_NMATRIX-_NMATRIX`))>=SQRT(TOLERANC) THEN DO;
      _error=1;
      NOTE1 = { " (labeled MATRIX below) ",
                " is not symmetric, within sqrt(TOLERANC)."};
      PRINT name NOTE1 , matrix;
      RETURN(_error);
      END;

      _EVALS=EIGVAL(_NMATRIX);

   IF MIN(_EVALS) <= SQRT(TOLERANC) THEN DO;
      _error=1;
      NOTE2={" (labeled MATRIX below) ",
             " is not positive definite. This may",
             " happen due to programming error or rounding",
             " error of nearly LTFR matrix. Perhaps can fix",
             " by usual scaling/centering techniques.",
             " This version disallows LTFR designs.",
             " Eigenvalues/max(abs(original matrix)) are:" };
      PRINT name NOTE2 , _EVALS;
      NOTE2_1={" is the max(abs(original matrix))"} ;
      PRINT _MAXVAL ;
      RETURN(_error);
      END;

RETURN(_error);
FINISH; * _SNGRCHK;


***********************************************************************
*                            _SIZECHK                                 *
*                                                                     *
*This module checks matrices for having more than one column          *
*                                                                     *
**********************************************************************;

START _SIZECHK
             (matrix,name);
   *_______________________________________________________________*
    INPUTS
      matrix, matrix which will be checked
      name, label to identify the matrix

      OUTPUTS
       _error, =1 if matrix has more than one column
   *_______________________________________________________________*;

   _error=0;

   IF NCOL(matrix)>1 THEN DO;
      _error=1;
      NOTE2_2 = { " (labeled MATRIX below) ",
                  " has more than one row and more than one column.",
                  "MATRIX is the transpose of your input." };
      PRINT name NOTE2_2 , matrix ;
      RETURN(_error);
      END;

RETURN(_error);
FINISH; * _SIZECHK;

***********************************************************************
*                            _TYPECHK                                 *
*                                                                     *
*This module verifies that matrix is of required type,                *
* either character or numeric,                                        *
*                                                                     *
**********************************************************************;

START _TYPECHK
             (matrix,name,target);
   *_______________________________________________________________*
    INPUTS
      matrix, matrix which will be checked
      name, label to identify the matrix
      target, one character, "N" (numeric) or "C" (character)
    OUTPUTS
       _error, =1 if matrix has more than one column
   *_______________________________________________________________*;

   _error=0;

   IF target="N" THEN DO;
                      IF TYPE(matrix)^=target THEN DO;
                                                   _error=1;
             NOTE2_3={" (labeled MATRIX below) must be numeric."};
                                     PRINT name NOTE2_3 , matrix ;
                                                   RETURN(_error);
                                                   END;
                      END;

  IF target="C" THEN DO;
                      IF TYPE(matrix)^=target THEN DO;
                                                   _error=1;
             NOTE2_3={" (labeled MATRIX below) must be character"};
                                     PRINT name NOTE2_3 , matrix ;
                                                   RETURN(_error);
                                                   END;
                      END;

RETURN(_error);
FINISH; * _TYPECHK;


*********************************************************************
*                             _SETOPT                               *
*                                                                   *
*    This module sets the options requested by the user.            *
*                                                                   *
*THIS MODULE MUST BE CALLED FOR EACH OF THESE LABEL MATRICES:       *
*                                                                   *
*  _PG1LABL= { BETA SIGMA RHO C U THETA0 RANKX RANKC RANKU CBETAU}` *
*  _PWRLABL= { HLT PBT WLK UNI UNIHF UNIGG COLLAPSE}`               *
*  _PRTLABL= { ALPHA SIGSCAL RHOSCAL BETASCAL TOTAL_N MAXRHOSQ}`    *
*  _DATLABL= { NOPRINT DS }`                                        *
*  _WRNLABL= { WARN }`                                              *
*********************************************************************;

START _SETOPT(newoptn,
             labels,_OPT_ON,_OPT_OFF);

   *_______________________________________________________________*
   INPUTS
   1) Program supplied
      newoptn, column of on/off switches (0 or 1) for options
      labels, column of option names which label newoptn
      _OPT_ON, column of requested options to turn on
      _OPT_OFF, column of requested options to turn off

   OUTPUTS
     newoptn, column of switches with requested options turned on/off
   *_______________________________________________________________*;
  DO i=1 TO NROW(_OPT_ON);
  newoptn= newoptn <> (LABELS=_OPT_ON(|i,1|));
  END;

  DO i=1 to nrow(_OPT_OFF);
  newoptn= newoptn # (LABELS^=_OPT_OFF(|i,1|));
  END;
FINISH; *_SETOPT;

***********************************************************************
**                             _PROBF                                 *
**                                                                    *
**  The module _PROBF screens the arguments to the PROBF function in  *
**  order to determine whether they will result in a missing value    *
**  being returned by the PROBF function due to power too near 1.     *
**  If this is the case, the PROBF function is by-passed.             *
**  PROBF function arguments are assessed with a normal approximation *
**  to a noncentral F-distribution (Johnson and Kotz, v2, 1970, p195).*
**  Additional problem in 6.04 exists with fractional df,             *
**  that was fixed with 6.06 (and assume beyond).                     *
**  Not surprisingly, normal approximation can be much less accurate  *
**  than standard function.  However, try to invoke normal approx     *
**  only when power>.99.  This may fail.  Statistical inaccuracy      *
**  in the approximations larger than numerical error.  Also, in      *
**  study planning this more than adequate accuracy.                  *
**********************************************************************;

START _PROBF
      (_FCRIT, _DF1, _DF2, _LAMBDA);

   *_______________________________________________________________*
   INPUTS
   1) Program supplied
      _FCRIT, critical value of F distribution if Ho true, size=_ALPHA
      _DF1, numerator (hypothesis) degrees of freedom
      _DF2, denominator (error) degrees of freedom
      _LAMBDA, noncentrality parameter

   OUTPUTS
      PROB, approximate probability that variable distributed
            F(_DF1,_DF2,_LAMBDA) will take a value <= _FCRIT
   *_______________________________________________________________* ;

   P1 = 1/3;
   P2 = -2;
   P3 = 1/2;
   P4 = 2/3;

   ARG1 = ((_DF1*_FCRIT)/(_DF1+_LAMBDA));
   ARG2 = (2/9)*(_DF1 + (2*_LAMBDA))*((_DF1 + _LAMBDA)##P2);
   ARG3 = (2/9)*(1/_DF2);

   NUMZ = (ARG1##P1) - (ARG3*(ARG1##P1)) - (1 - ARG2);
   DENZ = ( (ARG2 + ARG3*(ARG1##P4)) )##P3;
   ZSCORE = NUMZ/DENZ;
   * For debugging-- PRINT , ZSCORE _DF1 _DF2 _LAMBDA ;
   IF (_LAMBDA>0)&(ZSCORE<-4.) THEN PROB=0;
      ELSE PROB = PROBF(_FCRIT,_DF1,_DF2,_LAMBDA);
   RETURN(PROB);
   FINISH; *_PROBF;

***********************************************************************
**                             _HLTMOD                                *
**                                                                    *
**  The module _HLTMOD calculates a power for Hotelling-Lawley trace  *
**  based on the F approx. method.  _HLT is the Hotelling-Lawley      *
**  trace statistic, _DF1 and _DF2 are the hypothesis and error       *
**  degrees of freedom, _LAMBDA is the noncentrality parameter, and   *
**  _FCRIT is the critical value from the F distribution.             *
**********************************************************************;
START _HLTMOD(_PWR,_LBL,
              _A,_B,_S,_N,_R,_EVAL,_ALPHA,_NONCENN);
   *_______________________________________________________________*
   INPUTS
   1) Program supplied
      _A, rank of C matrix
      _B, rank of U matrix
      _S, minimum of _A and _B
      _N, total N
      _R, rank of X
      _EVAL, eigenvalues for H*INV(E)
      _ALPHA, size of test
      _NONCENN, =1 if multiply H*inv(E) eval's by (_N-_R)#_N
                and replace _DF2 with _N#_S in noncentrality
                for _S>1, per proposal by O'Brien & Shieh, 1992
   OUTPUTS
      _PWR, power for Hotelling-Lawley trace
      _LBL, label for output
   *_______________________________________________________________*;
   _DF1 = _A#_B;
   _DF2 = _S#(_N-_R-_B-1) + 2;
   IF (_DF2 <= 0) | (_EVAL(|1,1|) = .) THEN _PWR = . ;
                ELSE DO;
      IF (_NONCENN=1) | (_S=1) THEN EVALT=_EVAL#(_N-_R)/_N;
                               ELSE EVALT=_EVAL;
      _HLT = EVALT(|+,|);
      IF (_NONCENN=1) | (_S=1) THEN _LAMBDA = (_N#_S)#(_HLT/_S);
                               ELSE _LAMBDA = (_DF2 )#(_HLT/_S);
      _FCRIT = FINV(1-_ALPHA, _DF1, _DF2);
      _PWR = 1-_PROBF(_FCRIT, _DF1, _DF2, _LAMBDA);
      END;
   _LBL = {"HLT_PWR"};
  FINISH; *_HLTMOD;

***********************************************************************
**                                _PBTMOD                             *
**                                                                    *
**  The module _PBTMOD calculates a power for Pillai-Bartlett trace   *
**  based on the F approx. method.  _V is the PBT statistic,          *
**  _DF1 and _DF2 are the hypothesis and error degrees of freedom,    *
**  _LAMBDA is the noncentrality parameter, and _FCRIT is the         *
**  critical value from the F distribution.                           *
**********************************************************************;

START _PBTMOD(_PWR,_LBL,
             _A,_B,_S,_N,_R,_EVAL,_ALPHA,_NONCENN) GLOBAL(TOLERANC);
   *_______________________________________________________________*
   INPUTS
   1) Program supplied
      _A, rank of C matrix
      _B, rank of U matrix
      _S, minimum of _A and _B
      _N, total N
      _R, rank of X
      _EVAL, eigenvalues for H*INV(E)
      _ALPHA, size of test
      TOLERANC,  value not tolerated, numeric zero (global)
      _NONCENN, =1 if multiply H*inv(E) eval's by (_N-_R)#_N
                 and replace _DF2 with _N#_S in noncentrality
                   for _S>1, per proposal by O'Brien & Shieh, 1992
   OUTPUTS
      _PWR, power for Pillai-Bartlett trace
      _LBL, label for output
   *_______________________________________________________________* ;
   _DF1 = _A#_B;
   _DF2 = _S#(_N-_R+_S-_B);
   IF (_DF2 <= 0) | (_EVAL(|1,1|) = .) THEN _PWR = .;
      ELSE DO;
      IF (_NONCENN=1) | (_S=1) THEN EVALT=_EVAL#(_N-_R)/_N;
                               ELSE EVALT=_EVAL;
      _V = SUM(EVALT/(J(_S,1,1) + EVALT));
      IF (_S-_V) <= TOLERANC THEN _PWR=.;
         ELSE DO;
         IF (_NONCENN=1) | (_S=1) THEN _LAMBDA =(_N#_S)#_V/(_S-_V);
                                  ELSE _LAMBDA =(_DF2 )#_V/(_S-_V);
         _FCRIT = FINV(1-_ALPHA, _DF1, _DF2, 0);
         _PWR=1-_PROBF(_FCRIT, _DF1, _DF2, _LAMBDA);
         END;
      END;
   _LBL = {"PBT_PWR"};
   FINISH; *_PBTMOD;

***********************************************************************
**                                _WLKMOD                             *
**                                                                    *
**  The module _WLKMOD calculates a power for Wilk's Lambda based  on *
**  the F approx. method.  _W is the Wilks` Lambda statistic, _DF1    *
**  and _DF2 are the hypothesis and error degrees of freedom, _LAMBDA *
**  is the noncentrality parameter, and _FCRIT is the critical value  *
**  from the F distribution.  _RM, _RS, _R1, and _TEMP are inter-     *
**  mediate variables.                                                *
**********************************************************************;

START _WLKMOD(_PWR,_LBL,
              _A,_B,_S,_N,_R,_EVAL,_ALPHA,_NONCENN);
   *_______________________________________________________________*
   INPUTS
   1) Program supplied
      _A, rank of C matrix
      _B, rank of U matrix
      _S, minimum of _A and _B
      _N, total N
      _R, rank of X
      _EVAL, eigenvalues for H*INV(E)
      _ALPHA, size of test
      _NONCENN, =1 if multiply H*inv(E) eval's by (_N-_R)#_N
              and replace _DF2 with _N#_RS in noncentrality
                for _S>1, per proposal by O'Brien & Shieh, 1992
   OUTPUTS
      _PWR, power for Wilk's Lambda
      _LBL, label for output
   *_______________________________________________________________* ;
   _DF1 = _A # _B;
   IF _EVAL(|1,1|) = . THEN _W= . ;
      ELSE DO;
      IF (_NONCENN=1) | (_S=1) THEN EVALT=_EVAL#(_N-_R)/_N;
                               ELSE EVALT=_EVAL;
      _W = EXP(SUM(-LOG(J(_S,1,1) + EVALT)));
      END;
   IF _S = 1 THEN DO;
      _DF2 = _N-_R-_B+1;
      _RS=1;
      _TEMPW=_W;
      END;
     ELSE DO;
       _RM = _N-_R-(_B-_A+1)/2;
       _RS =SQRT( (_A#_A#_B#_B - {4})/(_A#_A + _B#_B - {5}) );
       _R1 = (_B#_A - {2})/4;
       IF _W=. THEN _TEMPW=.;
              ELSE _TEMPW = _W##(1/_RS);
       _DF2 = (_RM#_RS) - 2#_R1;
       END;
  IF _TEMPW=. THEN _LAMBDA=.;
     ELSE DO;
     IF (_S=1) | (_NONCENN=1) THEN _LAMBDA=(_N#_RS)#(1-_TEMPW)/_TEMPW;
                              ELSE _LAMBDA=(_DF2  )#(1-_TEMPW)/_TEMPW;
     END;
  IF (_DF2 <= 0) | (_W=.) | (_LAMBDA=.) THEN _PWR = .;
     ELSE DO;
     _FCRIT = FINV(1-_ALPHA,_DF1,_DF2,0);
     _PWR = 1-_PROBF(_FCRIT,_DF1,_DF2,_LAMBDA);
     END;

  _LBL = {"WLK_PWR"};
  FINISH; * _WLKMOD;

************************************************************************
*                             _SPECIAL                                 *
*                                                                      *
* The following module performs 2 disparate tasks. For _B=1 (UNIVARIATE*
* TEST), the powers are calculated more efficiently. For _A=1 (SPECIAL *
* MULTIVARIATE CASE), exact multivariate powers are calculated.        *
* Powers for the univariate statistics require separate treatment.     *
* _DF1 & _DF2 are the hypothesis and error degrees of freedom,         *
* _LAMBDA is the noncentrality parameter, and _FCRIT is the critical   *
* value from the F distribution.                                       *
**********************************************************************;

START _SPECIAL(_PWR,_LBL,
               _A,_B,_S,_N,_R,_EVAL,_ALPHA);
   *_______________________________________________________________*
   INPUTS
   1) Program supplied
      _A, rank of C matrix
      _B, rank of U matrix
      _S, minimum of _A and _B
      _N, total N
      _R, rank of X
      _EVAL, eigenvalues for H*INV(E)
      _ALPHA, size of test

   OUTPUTS
      _PWR, power for special case when rank(CBU)=1
      _LBL, label for output
   *_______________________________________________________________* ;

   _DF1=_A#_B;
   _DF2 = _N-_R-_B+1;
   IF (_DF2 <= 0) | (_EVAL(|1,1|)=.) THEN _PWR = .;
                ELSE  DO;
                      _LAMBDA=_EVAL(|1,1|)#(_N-_R);
                      _FCRIT = FINV(1-_ALPHA,_DF1,_DF2);
                      _PWR = 1-_PROBF(_FCRIT,_DF1,_DF2,_LAMBDA);
                      END;

   _LBL = {"POWER"};

FINISH; *_SPECIAL;


************************************************************************
*                            _UNIMOD                                   *
*                                                                      *
* Univariate STEP 1:                                                   *
* This module produces matrices required for Geisser-Greenhouse,       *
* Huynh-Feldt or uncorrected repeated measures power calculations. It  *
* is the first step. Program uses approximations of expected values of *
* epsilon estimates due to Muller (1985), based on theorem of Fujikoshi*
* (1978). Program requires that U be orthonormal.                      *
***********************************************************************;
START _UNIMOD(_D, _MTP, _EPS, _DEIGVAL,_SLAM1, _SLAM2, _SLAM3,
              _USIGMAU,_B)  GLOBAL(TOLERANC);

   *_______________________________________________________________*
    INPUTS
    _USIGMAU = U`*(SIGMA#_SIGSCAL)*U
        _B, rank of U

    TOLERANC, value not tolerated, numeric zero (global)

    OUTPUTS
       _D, number of distinct eigenvalues
       _MTP, multiplicities of eigenvalues
       _EPS, epsilon calculated from U`*SIGMA*U
       _DEIGVAL, first eigenvalue
       _SLAM1, sum of eigenvalues squared
       _SLAM2, sum of squared eigenvalues
       _SLAM3, sum of eigenvalues
   *_______________________________________________________________* ;

*Get eigenvalues of covariance matrix associated with _E. This is NOT
the USUAL sigma. This cov matrix is that of (Y-YHAT)*U, not of (Y-YHAT).
The covariance matrix is normalized to minimize numerical problems ;

 _ESIG = _USIGMAU / ( TRACE(_USIGMAU) );
 _SEIGVAL=EIGVAL(_ESIG);
 _SLAM1 = SUM( _SEIGVAL)##2;
 _SLAM2 = SSQ( _SEIGVAL);
 _SLAM3 = SUM( _SEIGVAL);
 _EPS =  _SLAM1 / (_B # _SLAM2);

*Decide which eigenvalues are distinct;
 _D      =  1;        *Ends as number of distinct eigenvalues;
 _MTP    =  1;        *Ends as vector of multiplicities of eignvals;
 _DEIGVAL=_SEIGVAL(| 1 , 1|);
 DO _I =  2 TO _B;
    IF ( _DEIGVAL(|_D,1|) - _SEIGVAL(|_I,1|) ) > TOLERANC THEN DO;
       _D = _D +  1;
       _DEIGVAL = _DEIGVAL // _SEIGVAL(| _I , 1|);
       _MTP = _MTP // {1};
       END;
    ELSE _MTP(|_D,1|)=_MTP(|_D,1|) + 1;
    END;
FINISH; *_UNIMOD;

***********************************************************************
*                          _GGEXEPS                                   *
*                                                                     *
* Univariate, GG STEP 2:                                              *
*Compute approximate expected value of Geisser-Greenhouse estimate    *
*          _FK = 1st deriv of FNCT of eigenvalues                     *
*          _FKK= 2nd deriv of FNCT of eigenvalues                     *
*          For GG FNCT is epsilon caret                               *
**********************************************************************;

START _GGEXEPS
              (_B, _N, _R, _D,
              _MTP, _EPS, _DEIGVAL,
              _SLAM1, _SLAM2, _SLAM3);
   *_______________________________________________________________*
    INPUTS
    1) Program supplied
       _B, rank of U
       _N, total number of observations
       _R, rank of X
       _D, number of distinct eigenvalues
       _MTP, multiplicities of eigenvalues
       _EPS, epsilon calculated from U`*SIGMA*U
       _DEIGVAL, first eigenvalue
       _SLAM1, sum of eigenvalues squared
       _SLAM2, sum of squared eigenvalues
       _SLAM3, sum of eigenvalues

    OUTPUTS
       _EXEPS, expected value of epsilon estimator
   *_______________________________________________________________* ;

_FK = J(_D, 1, 1) #  2 # _SLAM3 / ( _SLAM2 # _B ) - (  2 ) # _DEIGVAL
      # _SLAM1 / ( _B # _SLAM2 ##  2 );
 _C0 = (  1 ) - _SLAM1 / _SLAM2;
 _C1 =  -4 # _SLAM3 / _SLAM2;
 _C2 =  4 # _SLAM1 / _SLAM2 ##  2;

 _FKK = _C0 # J( _D ,  1 ,  1) + _C1 # _DEIGVAL + _C2 # _DEIGVAL ##  2;
 _FKK =  2 # _FKK / ( _B # _SLAM2 );

 _T1 = _FKK # ( _DEIGVAL ##  2 ) # _MTP;
 _SUM1 = SUM( _T1);

 IF _D =  1 THEN _SUM2 =  0;
 ELSE DO;
    _T2 = _FK # _DEIGVAL # _MTP;
    _T3 = _DEIGVAL # _MTP;
    _TM1 = _T2 * _T3`;
    _T4 = _DEIGVAL * J(  1 , _D ,  1);
    _TM2 = _T4 - _T4`;
    _TM2INV = 1/( _TM2 + I( _D)) - I( _D);
    _TM3 = _TM1 # _TM2INV;
    _SUM2 = SUM( _TM3);
    END;

_EXEPS = _EPS + (_SUM1 + _SUM2)/(_N - _R);
RETURN (_EXEPS);
FINISH; *GG;



***********************************************************************
*                          _HFEXEPS                                   *
*                                                                     *
* Univariate, HF STEP 2:                                              *
*Compute approximate expected value of Huynh-Feldt estimate           *
*          _FK = 1st deriv of FNCT of eigenvalues                     *
*          _FKK= 2nd deriv of FNCT of eigenvalues                     *
*          For HF, FNCT is epsilon tilde                              *
**********************************************************************;
START _HFEXEPS
              (_B, _N, _R, _D,
              _MTP, _EPS, _DEIGVAL,
              _SLAM1, _SLAM2, _SLAM3);
   *_______________________________________________________________*
    INPUTS
    1) Program supplied
       _B, rank of U
       _N, total number of observations
       _R, rank of X
       _D, number of distinct eigenvalues
       _MTP, multiplicities of eigenvalues
       _EPS, epsilon calculated from U`*SIGMA*U
       _DEIGVAL, first eigenvalue
       _SLAM1, sum of eigenvalues squared
       _SLAM2, sum of squared eigenvalues
       _SLAM3, sum of eigenvalues

    OUTPUTS
       _EXEPS, expected value of epsilon estimator
   *_______________________________________________________________* ;
* Compute approximate expected value of Huynh-Feldt estimate;
 _H1 = _N # _SLAM1 - (  2 ) # _SLAM2;
 _H2 = ( _N - _R ) # _SLAM2 - _SLAM1;
 _DERH1 = J( _D ,  1 ,  2 # _N # _SLAM3) -  4 # _DEIGVAL;
 _DERH2 =  2 # (_N - _R ) # _DEIGVAL - J( _D , 1 , 2 # SQRT( _SLAM1));
 _FK = _DERH1 - _H1 # _DERH2 / _H2;
 _FK = _FK / ( _B # _H2 );
 _DER2H1 = J( _D ,  1 ,  2 # _N - (  4 ));
 _DER2H2 = J( _D ,  1 ,  2 # ( _N - _R ) - (  2 ));
 _FKK =- _DERH1#_DERH2 / _H2+_DER2H1 - _DERH1#_DERH2 / _H2 +  2 #_H1#(
         _DERH2 ##  2 ) / _H2 ##  2 - _H1 # _DER2H2 / _H2;
 _FKK = _FKK / ( _H2 # _B );

 _T1 = _FKK # ( _DEIGVAL ##  2 ) # _MTP;
 _SUM1 = SUM( _T1);

 IF _D =  1 THEN _SUM2 =  0;
 ELSE DO;
    _T2 = _FK # _DEIGVAL # _MTP;
    _T3 = _DEIGVAL # _MTP;
    _TM1 = _T2 * _T3`;
    _T4 = _DEIGVAL * J(  1 , _D ,  1);
    _TM2 = _T4 - _T4`;
    _TM2INV = 1/( _TM2 + I( _D)) - I( _D);
    _TM3 = _TM1 # _TM2INV;
    _SUM2 = SUM( _TM3);
    END;

_EXEPS = _H1/(_B # _H2) + (_SUM1 + _SUM2) / (_N - _R);
RETURN (_EXEPS);
FINISH; *_HFEXEPS;

********************************************************************
*                        _LASTUNI                                  *
*                                                                  *
* Univariate STEP 3                                                *
* Final step for univariate repeated measures power calculations   *
********************************************************************;

START _LASTUNI (_PWR, _LBL,
                _EXEPS, _H, _E, _A, _B, _R, _N,
                _EPS, ppp, _ALPHA, FIRSTUNI);

   *_______________________________________________________________*
    INPUTS
    1) Program supplied
       _EXEPS, expected value epsilon estimator
       _H, hypothesis sum of squares
       _E, error sum of squares
       _A, rank of C
       _B, rank of U
       _N, total number of observations
       _R, rank of X
       _EPS, epsilon calculated from U`*SIGMA*U
       ppp, indicates selected power calculation
       _ALPHA, size of test
       FIRSTUNI, indicates first requested univariate statistic

   OUTPUTS
      _PWR, power for selected power calculation
      _LBL, label for output
   *_______________________________________________________________*;
IF _EXEPS > 1                      THEN _EXEPS =  1;
IF (_EXEPS < (1/_B)) & (_EXEPS^=.) THEN _EXEPS =  1/_B ;

IF (_N-_R)<=0 THEN _EPOWR=.;
              ELSE DO;
  *Compute noncentrality approximation;
  _MSH = TRACE( _H) / ( _A # _B );
  _MSE = TRACE( _E) / ( _B # ( _N - _R ) );
  _FALT = _MSH / _MSE;
  _LEPS = _A # _B # _EPS # _FALT;
  *Compute power approximation;
  _FCRIT= FINV(1 - _ALPHA , _B # _A # _EXEPS , _B # (_N -_R ) # _EXEPS);
  _EPOWR = 1 - _PROBF(_FCRIT, _B # _A # _EPS, _B#(_N -_R )#_EPS ,_LEPS);
  END;
_PWR = _EXEPS||_EPOWR;

IF ppp=4 THEN DO;
  _PWR = _EPS||_EPOWR;
  _LBL = {"EPSILON" "UNI_PWR"};
  END;
IF ppp=5 THEN DO;
  IF FIRSTUNI=5 THEN DO;
     _PWR = _EPS||_PWR;
     _LBL = { "EPSILON" "HF_EXEPS" "HF_PWR"};
     END;
  ELSE DO;
     _LBL = {"HF_EXEPS" "HF_PWR"};
     END;
  END;
IF ppp=6 THEN DO;
  IF FIRSTUNI=6 THEN DO;
     _PWR = _EPS||_PWR;
     _LBL = { "EPSILON" "GG_EXEPS" "GG_PWR"};
     END;
  ELSE DO;
     _LBL = {"GG_EXEPS" "GG_PWR"};
     END;
  END;
FINISH; *_LASTUNI;

***********************************************************************
*                        _SASDS                                       *
*                                                                     *
* Creates SAS dataset if requested.                                   *
**********************************************************************;

START _SASDS
            (_HOLDPOW, _HOLDNM, DSNAME);
   *_______________________________________________________________*
    INPUTS
    1) User supplied (or program default)
       DSNAME, { "libref"  "dataset name" "default library" }
       The "default library" is optional. If omitted WORK
       is used. Default {WORK DODFAULT}.

    2) Program supplied
       _HOLDPOW, matrix of power values and optional output.
       _HOLDNM, matrix of variable names for the SAS dataset.
   *_______________________________________________________________* ;

IF NCOL(DSNAME)=2 THEN _DSNAME=DSNAME||{WORK};
IF NCOL(DSNAME)=3 THEN _DSNAME = DSNAME;

LIB = _DSNAME(|1,1|);
DATASET = _DSNAME(|1,2|);
DEFAULT = _DSNAME(|1,3|);

* Reset default library to libref;
RESET NONAME DEFLIB = LIB;

LISTDS = DATASETS(LIB);
ENDIT=0;
NUMDS = NROW(LISTDS);

*Check to see if _PWRDTMP or user-specified DATASET already exists *;
IF NUMDS > 0 THEN
DO i=1 TO NUMDS;
  IF LISTDS(|i,1|) = "_PWRDTMP" THEN DO;
    ENDIT=1;
    NOTE1 = { "The program uses an intermediate dataset called",
              "_PWRDTMP. This dataset already exists in the",
              "requested library. New datasets cannot be created."};
    PRINT NOTE1;
    END;
  IF LISTDS(|i,1|) = DATASET THEN DO;
    NOTE2 = { " already exists. The default PWRDT### will",
              " be created instead. (See below)       " };
    PRINT DATASET NOTE2;
    DATASET = "DODFAULT";
  END;
END;

* Set default dataset name if required *;
NEWNUM=0;
IF DATASET= "DODFAULT" THEN NEWNUM=1;

IF DATASET = "DODFAULT" & NUMDS > 0 THEN DO;
    DO j=1 TO NUMDS;
    *Are any PWRDT### datasets in the library ?**;
    IF SUBSTR(LISTDS(|j,1|),1,5) = "PWRDT" THEN
       LISTPDS = LISTPDS//LISTDS(|j,1|);
    END;

  *What numbers do PWRDT### datasets have? Set number for new DS.**;
  IF NROW(LISTPDS) > 0 THEN DO;
    PDSNUMS = NUM(SUBSTR(LISTPDS,6,3));
    MAXNUM = MAX(PDSNUMS);
    NEWNUM = MAXNUM + 1;
    END;

  *Maximum number of PWRDT### datasets is 999.**;
  IF NEWNUM >999 THEN DO;
    ENDIT =1;
    NOTE3 = {" There are already 999 PWRDT### datasets.",
             " No more can be created."};
    PRINT NOTE3;
    END;
  END;

* New default name**;
IF (DATASET = "DODFAULT" & (1 <= NEWNUM <= 999) & ENDIT^=1) THEN
   DATASET = COMPRESS(CONCAT("PWRDT",CHAR(NEWNUM)));

* Create intermediate dataset called _PWRDTMP **;
IF ENDIT ^= 1 THEN DO;
  CREATE _PWRDTMP VAR _HOLDNM;
  APPEND FROM _HOLDPOW;
  CLOSE _PWRDTMP;

  *Change name of intermediate dataset to user specified or default*;
  CALL RENAME(LIB,"_PWRDTMP",DATASET);
  NAMED = COMPRESS(CONCAT(LIB,".",DATASET));
  PRINT "The dataset WORK._PWRDTMP has been renamed to " NAMED;
  END;

* Reset to original default library;
RESET NAME DEFLIB = DEFAULT;

FINISH; *_SASDS;

***********************************************************************
**                              MAIN CODE                             *
**********************************************************************;

 START _POWER (_HOLDPOW, _HOLDNM,_POWCHK)
       GLOBAL (ESSENCEX, SIGMA, BETA, U, C, THETA0,
               REPN, BETASCAL, SIGSCAL, RHOSCAL, ALPHA,
               ROUND, TOLERANC, OPT_ON, OPT_OFF, DSNAME);

   *_______________________________________________________________*
    INPUTS
    1) User supplied - required - GLOBAL
       ESSENCEX, the essence design matrix.  Users unfamiliar with
          this matrix may simply enter the full design matrix and
          specify that REPN below be equal to 1.
       SIGMA, the hypothesized variance-covariance matrix
       BETA, the matrix of hypothesized regression coefficients
       U, "within" subject contrast
       C, "between" subject contrast
    2) User supplied - optional (program defaults supplied) - GLOBAL
       THETA0, the matrix of constants to be subtracted from CBU
       REPN, (vector), the # of times each row of ESSENCEX is
          duplicated
       BETASCAL, (vector) multipliers for BETA
       SIGSCAL, (vector) multipliers for SIGMA
       RHOSCAL, (vector) multipliers for RHO
       ALPHA, (vector) Type I error rates
       ROUND, (scalar) # of places to round power calculations
       TOLERANC, (scalar) value not tolerated, numeric zero,
       used for checking singularity.
       OPT_ON, (column) selected options to turn on
       OPT_OFF, (column) selected options to turn off
       DSNAME, (row) name of output dataset

    OUTPUTS
      _HOLDPOW, matrix of power calculations
      _HOLDNM, column labels for _HOLDPOW
      _POWCHK = 0 if no warnings or errors detetected,
              = 1 if mild warning, e.g. _N-_R <=5 (poor approxmtns),
              = 2 if any missing values included in _HOLDPOW, and
              = 3 if input error or computational problem required
                     program termination
   *_______________________________________________________________*;


*A: INITIAL SETUP  **;
*A.0.1) Insure everthing printed by power software goes to output file;
RESET NOLOG;
*A.0.2) Initialize return code;
_POWCHK=0;
*A.0.3) Initialize warnings about powers rounding to 1;
_RNDCHK=0; *

*A.1) Check for required input matrices, and that they are numeric *;
IF (NROW(C)=0)       |
   (NROW(BETA)=0)    |
   (NROW(SIGMA)=0)   |
   (NROW(ESSENCEX)=0) THEN DO;
         NOTE1={"One or more of the following four required matrices",
                "has not been supplied:  SIGMA, BETA, C, ESSENCEX.  "};
         PRINT NOTE1;
         GO TO ENDOFPGM;
         END;

IF (_TYPECHK(C       ,"C"       ,"N")+
    _TYPECHK(BETA    ,"BETA"    ,"N")+
    _TYPECHK(SIGMA   ,"SIGMA"   ,"N")+
    _TYPECHK(ESSENCEX,"ESSENCEX","N")) > 0 THEN GO TO ENDOFPGM;

*A.1.4) Insure that U and THETA0 are numeric, if they exist;
IF NROW(U)>0 THEN IF _TYPECHK(U,"U","N")^=0 THEN GO TO ENDOFPGM;

IF NROW(THETA0)>0 THEN
   IF _TYPECHK(THETA0,"THETA0","N")^=0 THEN GO TO ENDOFPGM;

*A.1.5) Delete previous versions of _HOLDPOW and _HOLDNM;
IF NROW(_HOLDPOW)>0 THEN FREE _HOLDPOW;
IF NROW(_HOLDNM) >0 THEN FREE _HOLDNM;

*A.2) Define default matrices;

IF NROW(U)=0 THEN DO;
  U= I(NCOL(BETA));
  HITLIST = HITLIST// { U };
  END;
IF NROW(REPN)=0 THEN DO;
  REPN= 1;
  HITLIST = HITLIST// {REPN};
  END;
IF NROW(THETA0)=0 THEN DO;
  THETA0=J(NROW(C),NCOL(U),0);
  HITLIST = HITLIST// { THETA0 };
  END;
IF NCOL(SIGSCAL)=0 THEN DO;
  SIGSCAL= { 1 };
  HITLIST = HITLIST// {SIGSCAL};
  END;
IF NCOL(RHOSCAL)=0 THEN DO;
  RHOSCAL= { 1 };
  HITLIST = HITLIST// {RHOSCAL};
  END;
IF NCOL(BETASCAL)=0 THEN DO;
  BETASCAL= { 1 };
  HITLIST = HITLIST// {BETASCAL};
  END;
IF NROW(ALPHA) = 0 THEN DO;
  ALPHA= {.05};
  HITLIST = HITLIST// {ALPHA};
  END;
IF NROW(ROUND)=0 THEN DO;
  ROUND=3;
  HITLIST = HITLIST// {ROUND};
  END;
IF NROW(TOLERANC)=0 THEN DO;
  TOLERANC = 1E-12;
  HITLIST = HITLIST// {TOLERANC};
  END;
IF NROW(DSNAME)=0 THEN DO;
  DSNAME = {WORK DODFAULT WORK};
  HITLIST = HITLIST// {DSNAME};
  END;

*A.3) Create column vectors from user inputs;
  *Check that have only vectors or scalars, not matrices;
  *Check type (character or numeric);
  *Check for valid values;
  CHECKSUM=0;

  IF NCOL(REPN)>1 THEN _REPN = REPN`;
                  ELSE _REPN = REPN;
  CHECKSUM=CHECKSUM+_SIZECHK(_REPN,"REPN")
                   +_TYPECHK(_REPN,"REPN","N");

  IF NCOL(SIGSCAL)>1 THEN _SIGSCAL = SIGSCAL`;
                     ELSE _SIGSCAL = SIGSCAL;
  CHECKSUM=CHECKSUM+_SIZECHK(_SIGSCAL,"SIGSCAL")
                   +_TYPECHK(_SIGSCAL,"SIGSCAL","N");

  IF NCOL(RHOSCAL)>1 THEN _RHOSCAL = RHOSCAL`;
                     ELSE _RHOSCAL = RHOSCAL;
  CHECKSUM=CHECKSUM+_SIZECHK(_RHOSCAL,"RHOSCAL")
                 +_TYPECHK(_RHOSCAL,"RHOSCAL","N");

  IF NCOL(BETASCAL)>1 THEN _BETASCL = BETASCAL`;
                      ELSE _BETASCL = BETASCAL;
  CHECKSUM=CHECKSUM+_SIZECHK(_BETASCL,"BETASCAL")
                   +_TYPECHK(_BETASCL,"BETASCAL","N");

  IF NCOL(ALPHA)>1 THEN ALPHAV = ALPHA`;
                   ELSE ALPHAV = ALPHA;
  CHECKSUM=CHECKSUM+_SIZECHK(ALPHAV,"ALPHA")
                   +_TYPECHK(ALPHAV,"ALPHA","N");

  IF NROW(OPT_ON)>0 THEN DO;
     IF NCOL(OPT_ON)>1 THEN _OPT_ON = OPT_ON`;
                       ELSE _OPT_ON = OPT_ON ;
            CHECKSUM=CHECKSUM+_SIZECHK(_OPT_ON,"OPT_ON")
                             +_TYPECHK(_OPT_ON,"OPT_ON","C");
            END;

  IF NROW(OPT_OFF)>0 THEN DO;
     IF NCOL(OPT_OFF)>1 THEN _OPT_OFF = OPT_OFF`;
                        ELSE _OPT_OFF = OPT_OFF ;
      CHECKSUM=CHECKSUM+_SIZECHK(_OPT_OFF,"OPT_OFF")
                       +_TYPECHK(_OPT_OFF,"OPT_OFF","C");
           END;

IF CHECKSUM>0 THEN GO TO FREE_END;

*A.4) Define default options;

IF ANY(THETA0)=1 THEN _PG1=     {1 1 1 1 1  1 0 0 0 1}`;
                 ELSE _PG1=     {1 1 1 1 1  0 0 0 0 1}`;
_PG1LABL= { BETA SIGMA RHO C U THETA0 RANKX RANKC RANKU CBETAU}`;

_POWR=    { 0 0 1   0 0 1   1 }`;
_PWRLABL= { HLT PBT WLK   UNI UNIHF UNIGG   COLLAPSE }`;

_PRT=     { 1   1 1 1   1 0 1}`;
_PRTLABL= {ALPHA   SIGSCAL RHOSCAL BETASCAL   TOTAL_N MAXRHOSQ CASE}`;

_DAT=     { 0 0 }`;
_DATLABL= { NOPRINT DS }`;

_WARN=    { 1 }`;
_WRNLABL= { WARN }`;

_NONCENN= { 0 }`;
_NONLABL= { NONCEN_N }`;

*A.5) Define necessary parameters;

_R = NCOL(ESSENCEX);              ** _R IS THE RANK OF THE X MATRIX;
_A = NROW(C);                     ** _A IS THE RANK OF THE C MATRIX;
_B = NCOL(U);                     ** _B IS THE RANK OF THE U MATRIX;
_S = MIN(_A,_B);                  ** _S IS MIN OF RANK(C) AND RANK(U);
_P = NCOL(BETA);                  ** _P IS # OF RESPONSE VARIABLES;

*A.6) Set round off units after checking ROUND *;
IF _TYPECHK(ROUND,"ROUND","N")^=0 THEN GO TO FREE_END;

IF MAX(NCOL(ROUND),NROW(ROUND))>1 THEN DO;
   PRINT "ROUND cannot be a matrix. " ,
         "Must have only one column or only one row." ,, ROUND ;
   GO TO FREE_END;
   END;
IF (ROUND < 1) | (ROUND > 15) THEN DO;
   PRINT "User-specified ROUND < 1 OR ROUND >15";
   GO TO FREE_END;
   END;
ROUNDOFF = 1/10**ROUND;

*A.7) Check TOLERANC;
IF _TYPECHK(TOLERANC,"TOLERANCE","N")^=0 THEN DO;
    GO TO FREE_END;
   END;
IF TOLERANC <=0 THEN DO;
   PRINT "User-specified TOLERANC <= zero.";
   GO TO FREE_END;
   END;

*A.8) Check REPN;
IF MIN(REPN)<=TOLERANC THEN DO;
   PRINT "All REPN values must be > TOLERANC > zero." , REPN;
   GO TO FREE_END;
   END;

*A.9) Check SIGSCAL;
IF MIN(_SIGSCAL)<=TOLERANC THEN DO;
   *Can only get here if user supplies invalid SIGSCAL;
   PRINT "All SIGSCAL values must be > TOLERANC > zero." , SIGSCAL;
   GO TO FREE_END;
   END;

*A.10) Check ALPHA;
IF (MIN(ALPHAV)<=TOLERANC) | (MAX(ALPHAV)>=1) THEN DO;
   *Can only get here if user supplies invalid ALPHA;
   PRINT "All ALPHA values must be > TOLERANC > zero." ,
         "and < 1.00" , ALPHA;
   GO TO FREE_END;
   END;

*A.11) Check DSNAME;
IF (NROW(DSNAME)>1) | (NCOL(DSNAME)>3) THEN DO;
   PRINT "DSNAME must have only 1 row and 2 or 3 columns." , DSNAME;
   GO TO FREE_END;
   END;
IF TYPE(DSNAME)="N" THEN DO;
   PRINT "DSNAME must be character, not numeric." , DSNAME;
   GO TO FREE_END;
   END;


*A.12) Check for old versions of SAS;
IF (&SYSVER < 6.06) & (_WARN=1) THEN DO;
  NOTE1_3 = {"WARNING:                                       ",
             "You are using SAS version &SYSVER.  Fractional ",
             "error degrees of freedom may induce errors in  ",
             "the _PROBF module of this program. This problem",
             "has been corrected in SAS version 6.06.        "};
  PRINT NOTE1_3;
  END;

*B: CHECKS ON INPUT DATA **;

CALL _INPTCHK(CHECKER, _R, _A, _B, _S);
IF CHECKER=1 THEN GO TO FREE_END;

CALL _OPTCHK(CHECKER,
            _PG1LABL, _PWRLABL, _PRTLABL, _DATLABL,_WRNLABL,_NONLABL,
            _OPT_ON, _OPT_OFF);
IF CHECKER=1 THEN GO TO FREE_END;

*C: DEFINE NECESSARY MATRICES AND DO CHECKS **;

SD = DIAG(SQRT(VECDIAG(SIGMA)));
_RHO_ = INV(SD)*SIGMA*INV(SD);    ** Correlation matrix to be printed;
CBETAU= C*BETA*U;                 ** To be printed                   ;

*C.1) Check for errors;
_TEMPXX= ESSENCEX`*ESSENCEX;
_NAME={"X`X"};
E1= _SNGRCHK(_TEMPXX,_NAME);

*_INVXX= INV(_TEMPXX);
_INVXX= SOLVE(_TEMPXX,I(NROW(_TEMPXX)));
FREE _TEMPXX;

_M = C*_INVXX*C`;
_NAME={"C(INV(X`X))C`"};
E2= _SNGRCHK(_M,_NAME);

*C.2) Terminate program if errors detected;
IF (E1=1) | (E2=1) THEN GO TO FREE_END;

*D: SET NEW OPTIONS **;

*D.1) Set user selected options;
IF ((NROW(_OPT_ON) > 0) | (NROW(_OPT_OFF) > 0)) THEN DO;
   CALL _SETOPT(_POWR,_PWRLABL,_OPT_ON,_OPT_OFF);
   CALL _SETOPT(_PRT,_PRTLABL,_OPT_ON,_OPT_OFF);
   CALL _SETOPT(_PG1,_PG1LABL,_OPT_ON,_OPT_OFF);
   CALL _SETOPT(_DAT,_DATLABL,_OPT_ON,_OPT_OFF);
   CALL _SETOPT(_WARN,_WRNLABL,_OPT_ON,_OPT_OFF);
   CALL _SETOPT(_NONCENN,_NONLABL,_OPT_ON,_OPT_OFF);
   END;

*D.2) Insure that at least one test statistic chosen;
IF ANY(_POWR)^=1 THEN DO;
   PRINT "OPT_OFF combined with defaults implies " ,
         "no power calculation for any statistic." ,
         OPT_OFF ;
   _POWCHK=3;
   GO TO FREE_END;
   END;

*D.3) Identify special cases;
IF _POWR(|7,1|)=1 THEN DO; *if COLLAPSE is on;
   IF _S>1 THEN DO;
      IF _POWCHK=0 THEN _POWCHK=1;
      _POWR(|7,1|)=0;
      IF _WARN=1 THEN
      PRINT "Rank(C*BETA*U) >1, so COLLAPSE option ignored." ;
      END;
   IF _S=1 THEN DO;
      IF _B=1 THEN _POWR={ 0 0 0 0 0 0 1 }`;
      IF _B>1 THEN DO;
         _POWR(|1,1|)=0;
         _POWR(|2,1|)=0;
         _POWR(|3,1|)=0;
         END;
      END;
   END;

*E) MORE CHECKS ON MATRICES **;

*E.1) Check for scalar SIGMA *;
IF (NCOL(SIGMA)=1) & (_WARN=1) THEN DO;
  NOTE1_5={"WARNING:                               " ,
           "SIGMA is a scalar. For this program,   " ,
           "a scalar SIGMA must equal the variance," ,
           "NOT the standard deviation.            " };

 PRINT NOTE1_5;
  END;

*E.2) CHECK FOR ORTHONORMAL U;
* Only needed for univariate repeated measures;
IF ( _POWR(|4,1|)=1 | _POWR(|5,1|)=1 |_POWR(|6,1|)=1 ) THEN DO;
  _UPUSCA_ = U` * U;
  IF _UPUSCA_(|1 ,1|) ^= 0 THEN _UPUSCA_ = _UPUSCA_ / _UPUSCA_(|1 ,1|);
  _UDIF_ = ABS( _UPUSCA_ - I(_B));
  IF MAX( _UDIF_) > SQRT( TOLERANC) THEN DO;
   NOTE2 =
   {"U is not proportional to an orthonormal matrix. Problem is",
    "probably due to a programming error or numerical inaccuracy.",
    "If using ORPOL, suggest centering and/or scaling values",
    "Inner product is not K#I(NCOL(U)). For a nonzero constant K,",
    "inner product scaled so (1,1) element is 1.00 (unless = 0) is:"};
    PRINT NOTE2;
    PRINT _UPUSCA_;
    PRINT "Univariate repeated test not valid.";
    GO TO FREE_END;
    END;
  END;

*F) LOOP TO SELECT ALPHA, BETA, SIGMA, N, AND COMPUTE POWER**;

  *F.1) select alpha;
  DO a=1 TO NROW(ALPHAV);
  _ALPHA = ALPHAV(|a,1|);

    *F.2) select sigma;
    DO s=1 TO NROW(_SIGSCAL);
    _SIGSCL= _SIGSCAL(|s,1|);

    * Compute initial sigscaled covariance matrix *;
    _ISIGMA = SIGMA#_SIGSCL;
    * Compute initial rho from initial sigscaled covariance matrix *;
    V_I=VECDIAG(_ISIGMA);
    IF MIN(V_I)<=TOLERANC THEN DO;
      NOTE2_5={"Covariance matrix has variance <= TOLERANC (too small)",
                 "with current SIGSCAL element = "};
      PRINT NOTE2_5 _SIGSCL ,,, SIGMA;
      GO TO FREE_END;
      END;
    STDEV=SQRT(V_I);
    STDINV=DIAG(J(_P,1,1)/(STDEV));
    _IRHO = STDINV*_ISIGMA*STDINV;

      *F.3) create new rhos *;
      DO r=1 TO NROW(_RHOSCAL);
      _RHOSCL = _RHOSCAL(|r,1|);
      _RHOJUNK = (_IRHO #_RHOSCL);  * Diagonal elements not =1;
      _RHO_OFF = _RHOJUNK - DIAG(VECDIAG(_RHOJUNK)); * Off-diagonals;
      _RHO_OFF = (_RHO_OFF + _RHO_OFF`)/2;    *To insure symmetry;

      IF MAX(ABS(_RHO_OFF))>1 THEN DO;
        NOTE3={"For the current values of SIGSCAL and RHOSCAL",
               "there is a correlation with an absolute value>1."};
        PRINT NOTE3;
        PRINT "SIGSCAL= " _SIGSCL;
        PRINT "RHOSCAL= " _RHOSCL;
        GO TO FREE_END;
        END;

      IF MAX(ABS(_RHO_OFF))=1 THEN DO;
        _POWCHK=1;
        NOTE4={"WARNING:                                     ",
               "For the current values of SIGSCAL and RHOSCAL",
               "there is a correlation with an absolute value=1."};
        IF _WARN=1 THEN PRINT NOTE4              ,,
                            "SIGSCAL= " _SIGSCL ,,
                            "RHOSCAL= " _RHOSCL ;
        END;

      _RHO = _RHO_OFF + I(_P);

      * Create new sigma from rho *;
      STDEVM=DIAG(STDEV);
      _NEWSIGM = STDEVM*_RHO*STDEVM;

      _SIGSTAR= U`*_NEWSIGM*U;
      _USIGMAU= (_SIGSTAR + _SIGSTAR`)/2;   *To insure symmetry;
      _NAME = {"U`*SIGMA*U"};
      E3 = _SNGRCHK(_USIGMAU,_NAME);
      IF E3=1 THEN GO TO FREE_END;

        *F.4) Select Beta;
        DO b=1 TO NROW(_BETASCL);
        _BETSCL = _BETASCL(|b,1|);
        _NEWBETA= BETA#_BETSCL;
        _THETA  = C*_NEWBETA*U ;
        _ESSH = (_THETA-THETA0)`*SOLVE(_M,I(NROW(_M)))*(_THETA-THETA0);
        *     = (_THETA-THETA0)`*        INV(_M)      *(_THETA-THETA0);

        *F.5) Select N;
          DO i=1 TO NROW(_REPN);
          _N = _REPN(|i,1|)#NROW(ESSENCEX);

          _E = _USIGMAU#(_N-_R);
          _H = _REPN(|i,1|)#_ESSH;

          *F.6) Eigenvalues for H*INV(E);
          _EPS=.;
          IF (_N - _R) <= 0 THEN DO;
                                 _EVAL=J(_S,1,.);
                                 _RHOSQ=J(_S,1,.);
                                 _RHOSQ1=.;
                                 _D=1;
                                 _MTP=_B;
                                *_EPS=.;
                                 _DEIGVAL=.;
                                 _SLAM1=.; _SLAM2=.; _SLAM3=.;
                                 END;
            ELSE DO;
            _FINV = (SOLVE(HALF(_E),I(NROW(_E))))`; * = INV(HALF(_E))`;
            _HEIORTH = _FINV*_H*_FINV`;
            _HEIORTH=(_HEIORTH + _HEIORTH`)/2;  *Insure symmetry;
            _EVAL = EIGVAL(_HEIORTH);
            _EVAL=_EVAL(|1:_S,1|);        *At most _S nonzero;
            _EVAL=_EVAL#(_EVAL>TOLERANC); *Set evals<tolerance to zero;

            *Make vector of squared generalized canonical correlations;
            IF ( _S=1) | (_NONCENN=1) THEN EVALT=_EVAL#(_N-_R)/_N;
                                      ELSE EVALT=_EVAL;
            _RHOSQ = EVALT(|*,1|)/(J(_S,1,1)+EVALT(|*,1|));
            _RHOSQ = ROUND(_RHOSQ,ROUNDOFF);
            _RHOSQ1=_RHOSQ(|1,1|);  *Largest;
            END;
          *F.7) Start requested power calculations **;

          *F.7.a) Start univariate repeated measures power calcs;
          IF (_POWR(|4,1|)=1|_POWR(|5,1|)=1|_POWR(|6,1|)=1) THEN DO;
            CALL _UNIMOD(_D,_MTP,_EPS,_DEIGVAL,
                               _SLAM1,_SLAM2,_SLAM3,
                               _USIGMAU,_B);
            *Find first requested univariate statistic.;
            *Needed for creating epsilon;
            IF NROW(FIRSTUNI)= 0 & _POWR(|4,1|)=1 THEN FIRSTUNI=4;
            IF NROW(FIRSTUNI)= 0 & _POWR(|5,1|)=1 THEN FIRSTUNI=5;
            IF NROW(FIRSTUNI)= 0 & _POWR(|6,1|)=1 THEN FIRSTUNI=6;
            END;

          *F.7.b) Select requested power calculations;

          p = _POWR`;
          PSELECTN = (LOC(p))`;
            DO pp=1 TO NROW(PSELECTN);
            ppp = PSELECTN(|pp,1|);
            IF ppp=1 THEN CALL _HLTMOD(_PWR,_LBL,
                                  _A,_B,_S,_N,_R,_EVAL,_ALPHA,_NONCENN);
            IF ppp=2 THEN CALL _PBTMOD(_PWR,_LBL,
                                  _A,_B,_S,_N,_R,_EVAL,_ALPHA,_NONCENN);
            IF ppp=3 THEN CALL _WLKMOD(_PWR,_LBL,
                                  _A,_B,_S,_N,_R,_EVAL,_ALPHA,_NONCENN);
            IF ppp=4 THEN DO;
                          _EXEPS=1;
                          CALL _LASTUNI(_PWR,_LBL,
                                       _EXEPS,_H,_E,_A,_B,_R,_N,
                                       _EPS,ppp,_ALPHA,FIRSTUNI);
                          END;
            IF ppp=5 THEN DO;
                          IF (_N-_R) <= 0 THEN _EXEPS=.;
                             ELSE _EXEPS=_HFEXEPS(_B,_N,_R,_D,
                                                 _MTP,_EPS,_DEIGVAL,
                                                 _SLAM1,_SLAM2,_SLAM3);
                          CALL _LASTUNI(_PWR,_LBL,
                                       _EXEPS,_H,_E,_A,_B,_R,_N,
                                       _EPS,ppp,_ALPHA,FIRSTUNI);
                          END;
            IF ppp=6 THEN DO;
                          IF (_N-_R) <= 0 THEN _EXEPS=.;
                             ELSE _EXEPS=_GGEXEPS(_B,_N,_R,_D,
                                                 _MTP,_EPS,_DEIGVAL,
                                                 _SLAM1,_SLAM2,_SLAM3);
                          CALL _LASTUNI(_PWR,_LBL,
                                       _EXEPS,_H,_E,_A,_B,_R,_N,
                                       _EPS,ppp,_ALPHA,FIRSTUNI);
                          END;
             IF ppp=7 THEN CALL _SPECIAL(_PWR,_LBL,
                                        _A,_B,_S,_N,_R,_EVAL,_ALPHA);

             *F.7.c) Put all requested power calculations in a row;
             IF NCOL(_OUT)=0 THEN DO;
               *Set maximum possible output for power table;
               *then delete unrequested options;
               _OUT = _ALPHA||_SIGSCL||_RHOSCL||_BETSCL||_N||_RHOSQ1;
               _HOLDNM = {"ALPHA" "SIGSCAL" "RHOSCAL" "BETASCAL"
                          "TOTAL_N" "MAXRHOSQ"};
                 DO xx= 6 to 1 by -1;
                 IF _PRT(|xx,1|)^=1 THEN DO;
                                    _OUT = REMOVE(_OUT,xx);
                                    _HOLDNM = REMOVE(_HOLDNM,xx);
                                    END;
                 END;
               END;

              _PWR = ROUND(_PWR,ROUNDOFF);
              IF _PWR(|1,NCOL(_PWR)|)=1 THEN _RNDCHK=1;
              _OUT=   _OUT||_PWR;
              _HOLDNM= _HOLDNM||_LBL;
            FREE _PWR _LBL;
            END; *power calculation selection;

          *F.7.d) Create stack of calculations;
          IF NROW(_HOLDPOW)=0 THEN _HOLDPOW=_OUT;
                              ELSE _HOLDPOW= _HOLDPOW//_OUT;
          FREE  _OUT;

          *F.8) Check for sufficient sample size;
          IF ((_N -_R)<=5) THEN DO;
            IF (_B>1) &     (_POWR(|4  ,1|) =1) & (_EPS^=1)
                                          THEN _POWCHK=1; *UNI;
            IF (_S>1) & (ANY(_POWR(|5:6,1|))=1)
                                          THEN _POWCHK=1; *UNIHF UNIGG;
            IF (_S>1) & (ANY(_POWR(|1:3,1|))=1)
                                          THEN _POWCHK=1; *HLT PBT WLK;
            END;
          END; *N;
        END; *beta;
      END; *rho;
    END; *sigma;
  END; *alpha;

*G) WARNINGS FROM LOOP ;
IF ANY(_HOLDPOW=.) THEN _POWCHK=2;
IF _WARN=1 THEN DO; *Print only if WARN is on;
  IF _POWCHK>0 THEN PRINT ,,
               "WARNING:                                    " ,
               "If (_N-_R) <= 5, then power approximations  " ,
               "approximations may be very inaccurate,      " ,
               "especially Huynh-Feldt.  Consult the manual." ;
  IF _POWCHK=2 THEN PRINT ,,
          "WARNING:                                              " ,
          "When error degrees of freedom are <= 0, _HOLDPOW will " ,
          "have missing values for some requested powers.        " ,
          "Hence numeric operations on _HOLDPOW may cause errors." ;
  END;

*H) PRINTED OUTPUT;

*H.1) Print requested matrices;
IF (_DAT(|1,1|)=0) & ANY(_PG1) THEN DO;
  PRINT /;
  IF _PG1(| 1,1|) = 1 THEN PRINT , BETA;
  IF _PG1(| 2,1|) = 1 THEN PRINT , SIGMA;
  IF _PG1(| 3,1|) = 1 THEN PRINT , _RHO_;
  IF _PG1(| 4,1|) = 1 THEN PRINT , C;
  IF _PG1(| 5,1|) = 1 THEN PRINT , U;
  IF _PG1(| 6,1|) = 1 THEN PRINT , THETA0;
  IF _PG1(| 7,1|) = 1 THEN PRINT , "RANK OF X = " _R;
  IF _PG1(| 8,1|) = 1 THEN PRINT , "RANK OF C = " _A;
  IF _PG1(| 9,1|) = 1 THEN PRINT , "RANK OF U = " _B;
  IF _PG1(|10,1|) = 1 THEN PRINT , "C*BETA*U = " CBETAU;
  END;

*H.2) Print power calculations;
  IF ( _RNDCHK>0) & (_WARN=1) THEN PRINT ,,
               "WARNING:                                " ,
               "One or more power values rounded to 1.  " ,
               "For example, with ROUND=3,              " ,
               "power=1 should be reported as power>.999" ;
CASETOTL=NROW(_HOLDPOW);
IF _PRT(|7,1|)=1 THEN DO;
  CASE = (1:CASETOTL)`;
  _HOLDPOW = CASE || _HOLDPOW;
  _HOLDNM = "CASE" || _HOLDNM;
  END;
IF _DAT(|1,1|) = 0 THEN DO;
  IF CASETOTL <= 40 THEN PRINT / _HOLDPOW(|COLNAME=_HOLDNM|);
    ELSE DO;
    BRKPT= DO(36,CASETOTL,36);
    IF MAX(BRKPT) ^= CASETOTL THEN BRKPT= BRKPT||CASETOTL;
    START= 1;
      DO i=1 TO NCOL(BRKPT);
      STP=BRKPT(|1,i|);
      HOLDPOW = _HOLDPOW(|START:STP,|);
      PRINT / HOLDPOW(|COLNAME=_HOLDNM|);
      START= STP + 1;
      FREE HOLDPOW;
      END;
    END;
  END;

*H.3) Create SAS dataset if option was requested;
IF _DAT(|2,1|)=1 THEN CALL _SASDS(_HOLDPOW,_HOLDNM,DSNAME);

*I) FREE MATRICES ON THE HITLIST **;

GO TO FREE_ALL;
FREE_END: ; *Branching target for ending with major error;
_POWCHK=3;

FREE_ALL: ; *Branching target for no major error;
  DO I = 1 TO NROW(HITLIST);
  K=HITLIST(|I,|);
  IF K = { THETA0 } THEN FREE THETA0;
  ELSE IF K = { U } THEN FREE U;
  ELSE IF K = {REPN} THEN FREE REPN;
  ELSE IF K = {SIGSCAL} THEN FREE SIGSCAL;
  ELSE IF K = {RHOSCAL} THEN FREE RHOSCAL;
  ELSE IF K = {BETASCAL} THEN FREE BETASCAL;
  ELSE IF K = {ALPHA} THEN FREE ALPHA;
  ELSE IF K = {ROUND} THEN FREE ROUND;
  ELSE IF K = {TOLERANC} THEN FREE TOLERANC;
  ELSE IF K = {DSNAME} THEN FREE DSNAME;
  END;
IF _POWCHK<3 THEN GO TO ALL_DONE;

ENDOFPGM: ; *Branching target for ending with major error;
IF _POWCHK=0 THEN _POWCHK=3; *If jumped directly to ENDOFPGM;
PRINT ,, "PROGRAM TERMINATED WITH ONE OR MORE MAJOR ERRORS." ,
         "PROGRAM TERMINATED WITH ONE OR MORE MAJOR ERRORS." ,
         "PROGRAM TERMINATED WITH ONE OR MORE MAJOR ERRORS." ;

ALL_DONE: ; *Branching target for ending with no or minor errors;
FINISH; *_POWER;


***********************************************************************;
*                         POWER                                      *;
*                                                                    *;
* Define POWER command.                                              *;
* User will only have to type RUN POWER. The input matrices will not *;
* have to be listed in the RUN statement.                            *;
**********************************************************************;

START POWER;
CALL _POWER (_HOLDPOW,_HOLDNM,_POWCHK);

FINISH; *POWER;








