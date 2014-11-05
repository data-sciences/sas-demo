/*                                                                         */
/*     Integrating Results through Meta-Analytic Review Using SAS Software */
/*     Authors:  Morgan C. Wang and Brad J. Bushman                        */
/*     Publication code:  55810                                            */
/*                                                                         */

2.1 (pgs. 28) Table 2.1

 1  86 F  1052   .29
 2  88 F   738   .00
 3  60 F   871   .24
 4 183 F   576   .21
 5  37 F   818   .15
 6 101 F   800   .10
 7 300 F   909   .07
 8 248 F   684   .00
 9  30 F   694  -.16
10  89 F   458   .00
11 182 F   936   .08
12 161 F   456   .21
13 296 F   446   .33
14  55 F   783   .26
15 114 F   465   .19
16 173 F   436   .03
17 249 F   660   .11
18  98 F  1086  -.03
19 189 F  1310   .00
20  84 M  1313   .03



2.2 (pgs. 30) Example 2.1

data ex21;
   infile "d:\metabook\ch2\dataset\bone.dat";
   input studyid n sex $ calcium r;
   z = 0.5*log((1+r)/(1-r));
   wt = n - 3;
   wtz = wt * z;
run;
proc print noobs;
   title;
run;



2.3 (pgs. 31) Example 2.2

data ex22;
   input studyid n sex $ calcium r;
   z = 0.5*log((1+r)/(1-r));
   wt = n-3;
   wtz = wt * z;
cards;
 1  86 F  1052   .29
 2  88 F   738   .00
 3  60 F   871   .24
 4 183 F   576   .21
 5  37 F   818   .15
 6 101 F   800   .10
 7 300 F   909   .07
 8 248 F   684   .00
 9  30 F   694  -.16
10  89 F   458   .00
11 182 F   936   .08
12 161 F   456   .21
13 296 F   446   .33
14  55 F   783   .26
15 114 F   465   .19
16 173 F   436   .03
17 249 F   660   .11
18  98 F  1086  -.03
19 189 F  1310   .00
20  84 M  1313   .03
run;



2.4 (pgs 33) Example 2.3

data ex23;
   set ex213;
   zplus = wtzsum / wtsum;
   rplus = (exp(2*zplus)-1)/(1 + exp(2*zplus));
run;
proc print;
run;



2.5 (pgs. 35) Example 2.5

data ex25;
   set ex22;
   rename z=estimate;
run;
proc print;
run;


2.6 (pgs. 40) Example 2.8

options nocenter pagesize=54 linesize=80 pageno=1;
libname ch2 "d:\metabook\ch2\dataset";
data ch2.ex28;
   set ex22;
   type = 4;
   ne = 0.5 * n;
   nc = n - ne;
   rename z = estimate;
%wavgmeta(ch2.ex28,ch2.ex28out,4,.95);
proc format;
   value efftype 0 = "Glass' Delta"
                 1 = "Cohen's d   "
                 2 = "Hedges' g   "
                 3 = "Hedges' gu  "
                 4 = "Correlation ";

proc print data=ch2.ex28out noobs;
   title;
   var type estimate lower upper;
   format type efftype. estimate lower upper 5.3;
run;



2.7 (pgs. 42) Example 2.9

libname ch2 "d:\metabook\ch2\dataset";
goptions reset=goptions gsfname=fig201
   gsfmode=replace  gunit=pct;
data temp;
   set ch2.ex27;
   sz = z / sqrt(1/(n-3));
%ciqqplot(temp,ch2graph,fig201,sz);
quit;



2.8 (pgs. 43) Example 2.10

libname ch2 "d:\metabook\ch2\dataset";
filename fig202 "c:\tmp\fig202.cgm";
goptions reset=goptions device=cgmmwwc gsfname=fig202
   gsfmode=replace ftext=hwcgm005 gunit=pct;
data temp;
   set ch2.ex27;
   sz = z / sqrt(1/(n-3));
%ciqqplot(temp,ch2graph,fig202,sz);
quit;



2.9 (pgs. 46) Example 2.12

data ex212;
   infile "d:\metabook\ch2\dataset\bone.dat";;
   input studyid n sex $ calcium r;
   z = 1/2*log((1+r)/(1-r));
   wt = n-3;
   wtz = wt*z;
run;
proc print noobs;
   title;
   var studyid n sex calcium r;
run;




2.10 (pgs. 52) Example 2.16

proc format;
   value $sexfmt "M" = "Males" "F" = "Females";
data ex16;
   infile "d:\metabook\ch2\dataset\bone.dat";
   input studyid n sex $ calcium r;
   format sex $sexfmt.;
run;
proc print;
run;



2.11 (pgs. 54) Example 2.17

options nodate nocenter pagesize=54 linesize=128 pageno=1;
libname ch2 "d:\metabook\ch2\dataset";
data ch2.ex217;
   set ch2.ex27;
   std = sqrt(1 / (n-3));
   lower = z + probit(0.025)*std;
   upper = z + probit(0.975)*std;
   lower = (exp(2*lower)-1)/(exp(2*lower)+1);
   upper = (exp(2*upper)-1)/(exp(2*upper)+1);
proc sort data=ch2.ex217;
   by r;
proc timeplot data=ch2.ex217;
   title;
   plot lower="[" r="*" upper="]"/
      overlay hiloc ref=0 refchar="0";
   id studyid;
run;


2.12 (pgs. 56) Example 2.18

/*  side-by-side box plots;                   */
options nodate pagesize=54 linesize=80 nocenter pageno=1;
libname ch2 "d:\research\metabook\ch3\dataset";
data fig201;
   set ex22;
   if (_n_ > 10) then sex="M";
   label z="Effect Size Estimate";
   label sex="Gender";
proc sort data=fig201;
   by sex;
filename fig201 "d:\tmp\fig201.cgm";
goptions reset=goptions device=cgmmwwc gsfname=fig201
   gsfmode=replace ftext=hwcgm005 gunit=pct;
proc shewhart data=fig201 gout=fig201 graphics;
   boxchart z*sex / boxstyle=schematic
                        idsymbol=dot
                        vref=0
                        haxis=axis1
                        nolegend
                        hoffset=5
                        nolimits
                        boxwidth=30
                        stddevs;
axis1 value = ("Male" "Female");
run;
quit;


3.1 (pgs. 98) Appendix 3.1

libname ch3 'd:\metabook\ch3\dataset';
options nodate nocenter pagesize=54 linesize=132 pageno=1;
proc sort data=ch3.cohen83;
   by effect;
proc timeplot data=ch3.cohen83;
   plot lower="[" effect="*" upper="]" /
      overlay hiloc ref=0 refchar="0";
   id study;
   title;
run;



3.2 (pgs. 98) Appendix 3.2

%macro findxy(dataname,xx,yy);
proc univariate data=&dataname noprint;
   var &xx &yy;
   output out=outa min = minxx minyy max = maxxx maxyy;
proc print data=outa;
run;
%mend findxy;



3.3 (pgs. 99-100) Appendix 3.3

%macro funnelin;
   %window FINDAT
      #5 @4 "Input name of SAS data set" @31 indat 15
         attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FXVAR
      #5 @4 "Input name of variable on x-axis" @37 xvar 8
         attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FXMIN
      #5 @4 "Input minimum value of X variable" @38 xmin 8
         attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FXMAX
      #5 @4 "Input maximum value of X variable" @38 xmax 8
         attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FXBY
      #5 @4 "Input value of BY in ORDER statement of X variable"
         @55 xby 8 attr=underline
      #11 @4 "Example: Approximately equal to (XMAX-XMIN)/6"
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FYVAR
      #5 @4 "Input name of variable on y-axis" @37 YVAR 8
         attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FYMIN
      #5 @4 "Input minimum value of Y variable" @38 YMIN
         8 attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FYMAX
      #5 @4 "Input maximum value of Y variable" @38 YMAX 8
         attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FYBY
      #5 @4 "Input value of BY in ORDER statement of Y variable"
         @55 YBY 8 attr=underline
      #11 @4 "Example: Approximately equal to (YMAX-YMIN)/6"
      #17 @29 "Press" @35 "ENTER"  @41 "to continue.";
   %window FXLABEL
      #5 @4 "Input LABEL on x-axis:"
      #8 @4 XLAB 30 attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FYLABEL
      #5 @4 "Input LABEL on y-axis:"
      #8 @4 YLAB 30 attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FGDIR
      #5 @4 "Input directory name for Graph Out File"
      #8 @4 GDIR 30 attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %window FGHOUT
      #5 @4 "Input name of graphical output file"
      #8 @4 GHOUT 30 attr=underline
      #17 @29 "Press" @35 "ENTER" @41 "to continue.";
   %display FINDAT;
   %display FXVAR;
   %display FXLABEL;
   %display FXMIN;
   %display FXMAX;
   %display FXBY;
   %display FYVAR;
   %display FYMIN;
   %display FYMAX;
   %display FYBY;
   %display FYLABEL;
   %display FGDIR;
   %display FGHOUT;
%mend funnelin;



3.4 (pgs. 101) Appendix 3.4

%macro funnel(indat,xvar,xlab,xmin,xmax,xby,yvar,ylab,ymin,ymax,yby
   ,gdir,ghout);
%funnelin;
filename &ghout "&gdir\&ghout..cgm";
goptions reset=goptions device=cgmmwwc gsfname=&ghout gsfmode=replace
   ftext=hwcgm005 gunit=pct;
proc gplot data=&indat gout=ch3graph;
   PLOT &YVAR * &XVAR = 1 / VAXIS = AXIS1 VMINOR = 0
                           HAXIS = AXIS2 HMINOR = 0
                           NAME = "&GHOUT"
                           FRAME;
   symbol1 v=dot c=black height=1.5 i=none;
   symbol2 v=star c=black height=1.5 i=none;
   axis1 order=(&ymin to &ymax by &yby) value=(h=4)
      offset=(2) label=(h=4 a=90 r=0 &ylab) width=2;
   axis2 order=(&xmin to &xmax by &xby) length=80
      offset=(2) label=(h=4 &xlab) value=(h=4) width=2;
run;
quit;
%mend funnel;



3.5 (pgs. 102-104) Appendix 3.5

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname gdevice0 "c:\tmp";
/********************************************************/
/*  FIG302: Funnel plot for simulation data set data302 */
/********************************************************/
filename fig302 "c:\tmp\fig302.cgm";
/********************************************************/
/* Data302: A simulated data set for Fig302             */
/* (1) For half of the samples in each study, the       */
/*     populations for the experimental                 */
/*     and control groups are assumed to have normal    */
/*     distributions with mean 0 and variance 1         */
/* (2) For the other half of the samples in each study  */
/*     the populations for the experimental and control */
/*     groups are assumed to have normal distributions  */
/*     with mean 0.8 and variance 1                     */
/* (3) Both groups have same sample sizes.              */
/* (4) Hedges' g effect-size estimate is used           */
/********************************************************/
data temp;
   input group ne;
   seed=int(time());
   do study = 1 to 10;
      do i = 1 to ne;
         x=rannor(seed);
         output;
      end;
   end;
   keep group study ne x;
CARDS;
1       10
2       20
3       30
4       40
5       50
6       60
proc sort data=temp;
   by group study;
proc means data=temp noprint;
   var x ne;
   by group study;
   output out=tmpouta mean=mx ne std=stdx;
data temp;
   input group nc;
   seed=int(time());
   do study = 1 to 10;
      do i = 1 to nc;
         y=rannor(seed);
         output;
      end;
   end;
   keep group study nc y;
CARDS;
1       10
2       20
3       30
4       40
5       50
6       60
proc sort data=temp;
   by group study;
proc means data=temp noprint;
   var y nc;
   by group study;
   output out=tmpoutb mean=my nc std=stdy;
data data302a;
   merge tmpouta tmpoutb;
   effect = (mx-my)/sqrt(((ne-1)*stdx*stdx
            +(nc-1)*stdy*stdy)/(ne+nc-2));
   vareff = (ne+nc)/(ne*nc)+(effect*effect)/(2*(ne+nc-2));
   stdeff = effect / sqrt(vareff);
   sample = int(((sqrt(ne)+sqrt(nc))/2)
            *((sqrt(ne)+sqrt(nc))/2));
   pop=1;
   keep effect sample pop stdeff;
data temp;
   input group ne;
   seed=int(time());
   do study = 1 to 10;
      do i = 1 to ne;
         x=rannor(seed)+0.8;
         output;
      end;
   end;
   keep group study ne x;
CARDS;
1       10
2       20
3       30
4       40
5       50
6       60
proc sort data=temp;
   by group study;
proc means data=temp noprint;
   var x ne;
   by group study;
   output out=tmpouta mean=mx ne std=stdx;
data temp;
   input group nc;
   seed=int(time());
   do study = 1 to 10;
      do i = 1 to nc;
         y=rannor(seed);
         output;
      end;
   end;
   keep group study nc y;
CARDS;
1       10
2       20
3       30
4       40
5       50
6       60
proc sort data=temp;
   by group study;
proc means data=temp noprint;
   var y nc;
   by group study;
   output out=tmpoutb mean=my nc std=stdy;
data data302b;
   merge tmpouta tmpoutb;
   effect = (mx-my)/sqrt(((ne-1)*stdx*stdx
            +(nc-1)*stdy*stdy)/(ne+nc-2));
   vareff = (ne+nc)/(ne*nc) + (effect*effect)/(2*(ne+nc-2));
   stdeff = effect / sqrt(vareff);
   sample = int(((sqrt(ne)+sqrt(nc))/2)
            *((sqrt(ne)+sqrt(nc))/2));
   pop=2;
   keep effect sample pop stdeff;
data data302;
   set data302a data302b;
run;
%findxy(data302,effect,sample);
goptions reset=goptions device=cgmmwwc gsfname=fig302
   gsfmode=replace ftext=hwcgm005 gunit=pct;
proc sort data=data302;
   by pop;
legend1 label=none frame down=1 across=2
        value=(h=4 "Population I" "Population II");
proc gplot data=ch3.data302 gout=ch3graph;
   plot sample * effect = pop
      / vaxis = axis1 vminor = 0
        haxis = axis2 hminor = 0
        name = 'fig302'
        legend = legend1
        frame;
   symbol1 v=dot c=black height=1.5 i=none;
   symbol2 v=circle c=black height=1.5 i=none;
   axis1 order=(10 to 60 by 10) offset=(2)
      label=(h=4 a=90 r=0 "Total Sample Size") value=(h=4)
      width=2;
   axis2 order=(-1.2 to 1.8 by 0.6) length=80 offset=(2)
      label=(h=4 "Effect Size Estimate") value=(h=4)
      width=2;
run;
quit;



3.6 (pgs. 76) Data for figure 3.5


/*  fig305:  Data for Figure 3.5: DEVINE AND COOK (1983) *************** */
DATA CH3.FIG305;
   INPUT TYPE $ SIZE EFFECT;
      CARDS;
        D   40   0.57
        J   17   0.42
        J   18   0.35
        D   10   0.08
        D   10   -0.15
        D   10   -0.23
        J   7    0.88
        J   7    0.56
        J   13   1.27
        J   12   0.69
        J   14   0.62
        J   14   0.46
        J   14   0.19
        J   10   1.36
        J   9    1.36
        J   8    1.26
        J   11   1.38
        J   13   1.00
        J   8    0.59
        J   9    0.32
        J   10   0.59
        J   11   0.16
        J   12   0.70
        D   18   -0.2
        D   18   -0.08
        D   30   0.39
        D   30   0.29
        D   18   0.58
        D   18   0.80
        D   17   0.74
        J   37   0.04
        D   13   0.40
        J   19   0.30
        J   90   -0.02
        J   25   0.48
        D   8    1.10
        J   158  0.42
        D   70   0.77
        D   30   0.52
        D   9    1.08
        D   9    0.27
        D   40   0.12
        D   37   0.34
        D   39   0.21
        D   20   -0.21
        J   20   0.63
        J   30   0.28
        J   107  0.25
        J   22   0.20
        J   17   0.46
        J   18   0.37
        J   31   0.52
        J   14   0.78
        J   51   0.54
        ;


3.7 (pgs. 105) Appendix 3.6

GOPTIONS RESET=GOPTIONS DEVICE=CGMMWWC GSFNAME=FIG310 GSFMODE=REPLACE
         FTEXT=HWCGM005 GUNIT=PCT;
%MACRO CIQQPLOT(AA,BB,CC,DD);
PROC SORT DATA=&AA; BY &DD;
PROC UNIVARIATE NOPRINT DATA=&AA;
  VAR &DD;
  OUTPUT OUT=STATS N=NOBS MEAN=MEAN STD=STD MEDIAN=MEDIAN QRANGE=HSPR;
DATA QUANTILE;
  SET &AA;
  IF _N_ = 1 THEN SET STATS;
  P = (_N_ - 0.5)/NOBS;
  Z = PROBIT(P);
  SIGMA = HSPR / 1.349;
  NORMAL = MEDIAN + Z * SIGMA;
  SE = (SIGMA/((1/SQRT(8*ATAN(1)))*EXP(-(0.5*Z*Z))))*SQRT(P*(1-P)/NOBS);
  LOWER = NORMAL - 2 * SE;
  UPPER = NORMAL + 2 * SE;
  KEEP LOWER UPPER NORMAL &DD Z;
proc print;
PROC GPLOT DATA=QUANTILE GOUT=&BB;
  PLOT &dd * Z = 1
       NORMAL * Z = 2
       LOWER  * Z = 3
       UPPER  * Z = 3
        / OVERLAY
          VAXIS = AXIS1 VMINOR = 0
          HAXIS = AXIS2 HMINOR = 0
          NAME = '&CC'
          FRAME;
  SYMBOL1 V=DOT HEIGHT=1.5 I=NONE COLOR=BLACK;
  SYMBOL2 V=NONE I=JOINT L=3 COLOR=BLACK;
  SYMBOL3 V=NONE I=JOINT L=20 COLOR=BLACK;
  AXIS1 OFFSET=(2) LABEL=(H=3.5 A=90 R=0 "Standardize Effect Size")
        VALUE=(H=3) ORDER = (-3.5 TO 3.5 BY 1.0) WIDTH=2;
  AXIS2 LENGTH=80 LABEL=(H=3.5 "Normal Quantile")
      OFFSET=(2) VALUE=(H=3) WIDTH=2;
RUN;
Quit;
%MEND CIQQPLOT;



3.8 (pgs. 89) Output 3.2

options nodate pagesize=54 linesize=80 nocenter pageno=1;
libname ch3 "d:\metabook\ch3\dataset";
proc univariate data=ch3.cohen83 plot;
   var effect;
run;


3.9 (pgs. 89) Data for Figure 3.15

/*  parallel box plots; including four different types of comparisons */
LIBNAME CH3 "d:\METABOOK\CH3\DATASET";
OPTIONS NODATE NOCENTER PAGESIZE=56 LINESIZE=80 PAGENO=1;
DATA CH3.BAC90;
  INPUT TYPE EFFECT NE NC;
  NN = INT(0.5*(NE+NC));
CARDS;
1       0.710   12      12
1       0.500   20      20
1       0.990   20      10
1       0.310   24      24
1       0.380   24      24
1       0.485   24      24
1       0.590   113     36
1       0.560   10      10
1      -0.235   24      24
1       0.390   12      12
1      -0.620   10      10
1       0.360   11      11
1       1.020   20      20
1      -0.140   12      12
1      -0.500   12      12
1      -1.070   16      15
1       0.680   10      10
1       1.810   9       9
1       0.155   16      16
1      -0.180   10      10
1      -0.300   10      10
1      -0.190   25      25
1       0.620   24      24
1       0.800   15      15
1      -0.170   12      12
1       0.040   22      23
1       0.600   57      57
1       0.590   24      24
2       0.960   20      20
2       0.150   16      16
2       0.170   8       8
2       0.940   20      20
2       0.710   12      12
2       0.610   20      20
2       0.990   20      10
2       0.090   24      24
2       0.240   24      24
2       0.540   12      12
2       0.060   24      24
2       0.930   10      10
2       1.100   10      11
2       1.520   4       4
2       1.590   11      11
2       1.520   10      10
2       0.570   10      10
2       0.900   20      20
2       0.660   20      20
2      -0.240   24      24
2       0.220   12      12
2       0.140   20      20
2       0.020   10      10
2       0.730   24      24
2       0.530   11      11
2       0.170   32      32
2       0.525   24      24
2      -0.340   12      12
2      -0.090   12      12
2       0.080   16      19
2       0.850   10      10
2       0.650   20      20
2       1.050   20      20
2       0.430   36      36
2       2.470   9       7
2       0.000   16      16
2       0.840   10      10
2       1.460   9       9
2       0.140   25      25
2       0.710   30      30
2       0.910   20      20
2       0.880   30      30
2       0.650   22      23
2       0.650   6       6
2       0.140   4       4
2       1.700   4       4
2       0.740   24      24
2       0.660   20      20
2       1.130   8       8
3       0.710   12      12
3       0.150   24      24
3       0.450   10      10
3       0.030   24      24
3       0.06    12      12
3      -1.23    10      10
3      -0.03    11      11
3      -0.40    12      12
3      -0.36    12      12
3      -0.47    12      15
3       0.71    12      9
3       0.42    16      16
3      -0.27    25      25
4       0.210   24      24
4       0.140   24      24
4       0.455   24      24
4      -0.820   10      10
4       1.030   20      20
4       0.010   24      24
4       0.220   12      12
4      -0.600   10      10
4      -0.170   11      11
4      -0.510   12      12
4      -0.660   12      12
4      -1.050   19      15
4      -0.470   7       9
4       0.135   16      16
4      -0.330   25      25
4      -0.540   22      23
;
PROC PRINT DATA=CH3.BAC90;
TITLE;
RUN;





3.10 (pgs. 92) Figure 3.15

/*  side-by-side box plots;                   */
options nodate pagesize=54 linesize=80 nocenter pageno=1;
libname ch3 "d:\research\metabook\ch3\dataset";
data fig315;
   set ch3.bac90;
   label effect="Effect Size Estimate";
   label type="Type of Comparison";
proc sort data=fig315;
   by type;
filename fig315 "d:\tmp\fig315.cgm";
goptions reset=goptions device=cgmmwwc gsfname=fig315
   gsfmode=replace ftext=hwcgm005 gunit=pct;
proc shewhart data=fig315 gout=fig315 graphics;
   boxchart effect*type / boxstyle=schematic
                        idsymbol=dot
                        vref=0
                        haxis=axis1
                        nolegend
                        hoffset=5
                        nolimits
                        stddevs;
axis1 value =
   ("Alcohol vs Control" "Alcohol vs Placebo"
   "Antiplacebo vs Control" "Placebo vs Control");
run;
quit;



3.11 (pgs. 94-95) Figure 3.16

/*  side-by-side box plots;               */
/*  including individual comparison types */
/*  and all four types combined           */
options nodate pagesize=54 linesize=80 nocenter pageno=1;
libname ch3 "d:\research\metabook\ch3\dataset";
data fig316;
   set ch3.bac90;
   output;         /* individual comparison types */
   type = 0;
   output;         /* all comparison types combined */
   label effect="Effect Size Estimate";
   label type="Type of Comparison";
proc sort data=fig316;
   by type;
filename fig316 "d:\tmp\fig316.cgm";
goptions reset=goptions device=cgmmwwc gsfname=fig316
   gsfmode=replace ftext=hwcgm005 gunit=pct;
proc shewhart data=fig316 gout=fig316 graphics;
   boxchart effect*type / boxstyle=schematic
                        idsymbol=dot
                        vref=0
                        haxis=axis1
                        nolegend
                        hoffset=5
                        nolimits
                        stddevs;
axis1 value =
   ("All Types" "Alcohol vs Control" "Alcohol vs Placebo"
   "Antiplacebo vs Control" "Placebo vs Control");
run;
quit;




4.1 (pgs. 135-136) Appendix 4.1

%macro compodds(indata,outdata);
/********************************************************/
/*  INDATA:                                             */
/*     N11: Sample frequency  for cell (1,1)            */
/*     N12: Sample frequency  for cell (1,2)            */
/*     N21: Sample frequency  for cell (2,1)            */
/*     N22: Sample frequency  for cell (2,2)            */
/*                                                      */
/*  OUTDATA:                                            */
/*     TYPE:                                            */
/*        TYPE=1:       Log odds ratio                  */
/*        TYPE=2:       Odds ratio                      */
/*        TYPE=3:       Amended log odds ratio          */
/*        TYPE=4:       Amended odds ratio              */
/*     ESTIAMTE: Sample estimate for given TYPE         */
/*     LOWER:  Lower bound for 95% confidence interval  */
/*     UPPER:  Upper bound for 95% confidence interval  */
/*     VARIANCE:                                        */
/********************************************************/
data &outdata; set &indata;
   if (n11 = 0 or n12 = 0 or n21 = 0 or n22 = 0) then do;
      odds = .;
      logodds = .;
      variance = .;
      std = .;
      end;
   else do;
      odds = (n11*n22)/(n12*n21);
      variance = 1/n11+1/n12+1/n21+1/n22;
      logodds = log(odds);
      std = sqrt(variance);
   end;
   type = 1;
   estimate = logodds;
   lower = logodds + probit(0.025) * std;
   upper = logodds + probit(0.975) * std;
   output;
   type = 2;
   estimate = odds;
   lower = exp(lower);
   upper = exp(upper);
   variance = .;
   output;
   odds = (n11+.5)*(n22+.5)/((n12+.5)*(n21+.5));
   variance = 1/(n11+.5)+1/(n12+.5)+1/(n21+.5)+1/(n22+.5);
   std = sqrt(variance);
   type = 3;
   estimate = log(odds);
   lower = estimate + probit(.025)*std;
   upper = estimate + probit(.975)*std;
   output;
   type = 4;
   estimate = odds;
   lower = exp(lower);
   upper = exp(upper);
   variance = .;
   output;
   keep type estimate lower upper variance;
%mend compodds;



4.2 (pgs. 114) Example 4.1

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch4 "d:\metabook\ch4\dataset";
data ch4.ex41;
   input n11 n12 n21 n22;
cards;
121 721 73 771
;
%compodds(ch4.ex41,ch4.ex41out)
proc format;
  value aa 1 = "Log odds ratio        "
           2 = "Odds ratio            "
           3 = "Amended log odds ratio"
           4 = "Amended odds ratio    ";
proc print data=ch4.ex41out noobs;
   title;
   var type estimate lower upper;
   format type aa. estimate lower upper 5.3;
run;



4.3 (pgs. 118) Table 4.4

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch4 "d:\metabook\ch4\dataset";
data ch4.ex42;
   input studyid $ 1-39 n11 n12 n21 n22;
cards;
Abelin et al. (1989)                    36       64      22       77
Abelin et al. (1989)                    22       34      11       45
Buchremer et al. (1898)                 29       13      22       21
Daughton et al. (1991)                  19       36       7       45
Daughton et al. (1991)                  20       31       7       45
Elan Pharmaceutical Research Corp.      45      110      22      142
Elan Pharmaceutical Research Corp.      48       91      30      107
Fiore et al. (1994)                     21       36      11       44
Hurt et al., (1994)                     56       64      24       96
Imperial Cancer Research Fund (1993)   121      721      73      771
Mulligan et al., (1990)                 19       21       6       34
Rusell et al., (1993)                   70      330      15      185
Sachs et al. (1993)                     46       67      17       90
Tonnesen et al., (1991)                 43      102       7      137
Transdermal Nicotine Study Group, 1991  61       60      29       95
Transdermal Nicotine Study Group, 1991  37       91      11      118
Weisman et al., 1993                    23       55       7       73
;
run;
proc print;  run;



4.4 (pgs. 137) Appendix 4.2


%macro wavgodds(indata,outdata,intype,level);
/********************************************************/
/*  INDATA: The output data set from SAS MACRO COMPODDS */
/*  INTYPE: Type of log odds ratio to be combined       */
/*    INTYPE = 1 for combining log odds ratio           */
/*    INTYPE = 3 for combining amended log              */
/*         odds ratio because some studies have zero    */
/*         frequencies in one or more cells             */
/*  LEVEL: Level of confidence for the confidence       */
/*         interval of the combined weighted average    */
/*                                                      */
/*  OUTDATA:                                            */
/*      The output data file contains five variables.   */
/*                                                      */
/*      (1) TYPE: The type of effect size               */
/*          TYPE can have value 1 (log odds ratio) and  */
/*          2 (odds ratio) if INTYPE = 1.               */
/*          TYPE can have value 3 (amended log odds     */
/*          ratio) and 4 (amended odds ratio) if        */
/*          INTYPE = 3.                                 */
/*      (2) ESTIMATE:  Combined estimate for the        */
/*          given effect size TYPE.                     */
/*      (3) LOWER: Lower bound for confidence interval  */
/*      (4) UPPER: Upper bound for confidence interval  */
/*      (5) LEVEL: Level of confidence for the          */
/*      confidence interval.                            */
/********************************************************/
data;
   set &indata;
   if type = &intype;
   weight = 1 / variance;
   wlodds = estimate * weight;
   keep wlodds weight;
proc means noprint;
   var wlodds weight;
   output out = &outdata sum=swlodds sweight;
data &outdata;
   set &outdata;
   type = &intype;
   estimate = swlodds / sweight;
   level=&level;
   variance = 1 / sweight;
   lower = estimate + probit(.5-.5*&level) * sqrt(variance);
   upper = estimate + probit(.5+.5*&level) * sqrt(variance);
   output;
   type = &intype+1;
   estimate = exp(estimate);
   lower = exp(lower);
   upper = exp(upper);
   output;
   keep type estimate level lower upper;
%mend wavgodds;



4.5 (pgs. 119) Example 4.2

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch4 "d:\metabook\ch4\dataset";
%compodds(ch4.ex42,ch4.ex42out1);
%wavgodds(ch4.ex42out1,ch4.wavgodds,1,0.95);
proc format;
  value aa 1 = "Log Odds Ratio        "
           2 = "Odds Ratio            "
           3 = "Amended Log Odds ratio"
           4 = "Amended Odds Ratio    ";
proc print data=ch4.wavgodds noobs;
   title;
   format type aa. estimate level lower upper 5.3;
run;



4.5 (pgs. 138-139) Appendix 4.3

options nodate nocenter pagesize=54 linesize=80 pageno=1;
%macro homeodds(indata,outdata,type,initial);
data; set &indata;
/*******************************************************/
/* Compute the chi-square test statistics for the      */
/* homogeneity of common odds ratio based on Breslow   */
/* and Day (1980)                                      */
/*                                                     */
/* INPUT DATA:                                         */
/*   Cell frequencies for each study:                  */
/*      N11, N12, N21, and N22.                        */
/*                                                     */
/* OUTPUT DATA:                                        */
/*   The chi-square test statistics with k-1 degrees of*/
/*   freedom, where k is the number of studies in the  */
/*   meta-analysis.                                    */
/*                                                     */
/* TYPE:                                               */
/*   TYPE=2 if no studies have zero cell frequencies   */
/*   TYPE=4 if some studies have zero cell frequencies */
/*                                                     */
/* INITIAL:                                            */
/*   Initial value to start the Newton iteration.  The */
/*   weighted average common odds ratio can be used as */
/*   the initial value.                                */
/*******************************************************/
   if (&type=4) then do;
      n11=n11+.5;
      n12=n12+.5;
      n21=n21+.5;
      n22=n22+.5;
   end;
   oddmle=&initial;
   df = 1;
   m1=n11+n22;
   m2=n12+n21;
   xold=n11;
   xnew=(n11+n12)*(n11+n21)/(n11+n12+n21+n22);
/*******************************************************/
/*   Estimate the cell frequencies based on the Newton */
/*   method                                            */
/*******************************************************/
   do until (abs(xold-xnew) < .1e-5);
      xold = xnew;
      fold = ((1-oddmle)*xnew-(m1+oddmle*m2))*xnew
             +(n11*n22-n12*n21*oddmle);
      pfold = 2*(1-oddmle)*xnew-(m1+oddmle*m2);
      xnew = xold - fold / pfold;
   end;
   varstat=1/(1/(n11-xnew)+1/(n12+xnew)+1/(n21+xnew)+1/(n22-xnew));
   chisq = (xnew*xnew)/varstat;
   keep df chisq;
proc means noprint;
   var df chisq;
   output out=&outdata sum = df chisq;
data &outdata;
   set &outdata;
   df = df -1;
   pvalue = 1-probchi(chisq,df);
   keep df chisq pvalue;
run;
%mend homeodds;


4.7 (pgs. 120) Example 4.3

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch4 "d:\metabook\ch4\dataset";
%homeodds(ch4.ex42,ch4.ex42out4,2,2.66);
proc print data=ch4.ex42out4 noobs;
   format df 3.0 chisq pvalue 5.3;
   title;
run;



4.8 (pgs. 123) Data for Example 4.4

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch4 "d:\metabook\ch4\dataset";
data ch4.ex44;
   input studyid $ 1-29 n11 n12 n21 n22  outcome $ 54-65 site $ 67-77;
cards;
Crowe et al. (1979)             8      12   2      18 MVP         University
Kantor et al. (1980)            8      17   2      21 MVP         Anxiety
Venkatesh et al. (1980)         5      16   1      19 MVP         University
Szmuilowicz & Flannery (1980)  13      18  44      82 Panic       Unspecified
Kane et al. (1981)              5       2  60      31 Panic       Unspecified
Uretsky (1982)                  4      25  45     808 Panic       Private
Hartman et al. (1982)           1       2  32      68 Panic       University
Pecorelli (1984)                2       3   0      25 Panic       Inpatient
Shear et al. (1984)             2      23   0      25 MVP         Anxiety
Chan et al. (1984)              0      15   0       4 MVP         Psychiatric
Bass & Wade (1984)              0      17   0      29 MVP         Inpatient
Bowen et al. (1985)             0       0  16      14 Panic       Inpatient
Dunner (1985)                  14      10   7      16 Panic       University
Nesse et al. (1985)             7      13   0       3 MVP         Anxiety
Dager et al. (1986)             8      16   3      17 MVP         Anxiety
Mazza et al. (1986)             0       0  48      49 Panic       University
Devereux et al. (1986)          8       5  73     167 Panic       Family
Dager et al. (1987)            17      12   2       7 MVP         Psychiatric
Wulsin et al. (1988)            0       8   2      39 Unspecified Chest Pain
Taylor (1988)                   0      12   0      12 MVP         Unknown
Gorman et al.                  14      22   4      18 MVP         Unknown
;
run;
proc print;
run;



4.9 (pgs. 140-141) Appendix 4.4

%macro mhodds(indata,outdata,level);
/********************************************************/
/* Compute the odds ratio for each study                */
/* (1) Compute Mantel-Haenszel odds ratio and log odds  */
/*     ratio.                                           */
/* (2) Compute the large sample variance estimator based*/
/*     on Robins, Breslow, and Greenland (1986) and     */
/*     Robins, Greenland, and Breslow (1986)            */
/*                                                      */
/* INPUT DATA:                                          */
/*     N11, N12, N21, N22: Cell frequencies for each    */
/*     study.                                           */
/*     LEVEL: Level of confidence for the confidence    */
/*     interval                                         */
/*                                                      */
/* OUTPUT DATA:                                         */
/*     TYPE:    5 = Log of Mantel-Haneszel odds ratio   */
/*                  estimate                            */
/*              6 = Mantel-Haneszel odds ratio estimate */
/*                                                      */
/*     ESTIMATE: Mantel-Haneszel estimate for the given */
/*               type                                   */
/*     LOWER:    Lower bound of confidence interval     */
/*     UPPER:    Upper bound of confidence interval     */
/********************************************************/
data;
   set &indata;
   ntt=n11+n12+n21+n22;
   aa=n11*n22/ntt;
   bb=(n11+n22)/ntt;
   cc=n12*n21/ntt;
   dd=(n12+n21)/ntt;
   ab=aa*bb;
   bc=bb*cc;
   ad=aa*dd;
   cd=cc*dd;
proc means noprint;
   var aa bb cc dd ab bc ad cd;
   output out=&outdata
          sum=saa sbb scc sdd sab sbc sad scd;
data &outdata;
   set &outdata;
   type=6;
   estimate=saa/scc;
   level=&level;
   variance=(sab+(saa/scc)*(sbc+sad+(saa/scc)*scd))
            /(2*saa*saa);
   lower=estimate+probit(.5-.5*level)*sqrt(variance);
   upper=estimate+probit(.5+.5*level)*sqrt(variance);
   output;
   type=5;
   estimate=log(saa/scc);
   lower=log(lower);
   upper=log(upper);
   variance=.;
   output;
   keep type estimate level variance lower upper;
%mend mhodds;



4.10 (pgs. 124) Example 4.4

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch4 "d:\metabook\ch4\dataset";
%mhodds(ch4.ex44,ch4.mhodds,.95);
proc format;
   value bb 5="Log odds ratio (MH)"
            6="Odds ratio (MH)    ";
proc print data=ch4.mhodds noobs;
   var type estimate lower upper;
   format type bb. estimate lower upper 5.3;
run;



4.11 (pgs. 126) Data for Example 4.5

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch4 "d:\metabook\ch4\dataset";
data ch4.ex45;
   input ptype wtrt wwear female meanage meanciga;
cards;
24     12      8      40.2      41.6      27.5
24      9      6      26.8      24.0      23.0
24      7      1      50.4      35.3      29.3
16      4      0      53.2      41.8      32.9
24      4      0      53.2      41.8      32.9
24      6      0      58.4      41.3      30.8
24      8      0      64.5      41.3      29.3
24      6      2      67.9      43.6      30.3
24      8      0      53.8      43.2      28.6
24      12      8      55.1      43.7      24.4
24      6      0      52.5      36.9      25.1
16      18      6      61.2      39.5      23.5
16      18      6      59.1      47.6      28.0
16      16      4      70.0      45.2      21.5
24      12      6      60.3      43.3      31.2
24      12      6      62.7      43.1      30.5
24      6      2      56.6      41.8      41.8
;
run;
data ch4.ex45a;
   merge ch4.ex42 ch4.ex45;
   id = _n_;
proc sort data=ch4.ex45a;
   by ptype wtrt wwear female meanage meanciga;
data ch4.ex45b;
   set ch4.ex45a;
   nicotine = "yes";
   quit = "yes";
   count=n11;
   output;
   nicotine = "yes";
   quit = "no ";
   count=n12;
   output;
   nicotine = "no ";
   quit = "yes";
   count=n21;
   output;
   nicotine = "no ";
   quit = "no ";
   count=n22;
   output;
   keep studyid id nicotine quit count ptype wtrt wwear female meanage meanciga;
run;



4.12 (pgs. 142) Appendix 4.5 and SAS code for Output 4.5

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch4 "d:\metabook\ch4\dataset";
proc catmod data=ch4.ex45b;
   weight count;
   direct ptype wtrt wwear female meanage meanciga;
   response joint / out=pred1;
   model quit = nicotine ptype wtrt wwear female meanage meanciga
                         / noparm noresponse pred=freq;
data temp;  set pred1;
   keep nicotine _obs_ _pred_ _sample_ _number_;
data a1;  set temp;
   if nicotine="yes";
   prob1 = _pred_;
   keep prob1;
data a2; set temp;
   if nicotine="no ";
   prob2 = _pred_;
   keep _sample_ prob2;
data temp;
   merge a2 a1;
data ch4.ex45out1;
   merge ch4.ex45a temp;
   total=n11+n12;
   pn11=total*(1-prob1);
   pn12=total-pn11;
   total=n21+n22;
   pn21=total*(1-prob2);
   pn22=total-pn21;
   keep studyid id pn11 pn12 pn21 pn22;
proc sort data=ch4.ex45out1;
   by id;
proc print data=ch4.ex45out1 noobs;
   var studyid pn11 pn12 pn21 pn22;
   format pn11 pn12 pn21 pn22 5.1;
   title;
run;


4.13 (pgs. 127-129) SAS code for Output 4.6 and 4.7

options nodate nocenter pageno=1 pagesize=54 linesize=80;
libname ch4 "d:\metabook\ch4\dataset";
data temp;
   set ch4.ex45out1;
   rename pn11=n11 pn12=n12 pn21=n21 pn22=n22;
%compodds(temp,tempout);
%wavgodds(tempout,ch4.ex45out2,1,.95);
proc format;
  value aa 1 = "Log Odds Ratio        "
           2 = "Odds Ratio            "
           3 = "Amended Log Odds ratio"
           4 = "Amended Odds Ratio    ";
proc print data=ch4.ex45out2 noobs;
   title;
   format type aa. estimate level lower upper 5.3;
%homeodds(temp,ch4.ex45test,2,2.76);
proc print data=ch4.ex45test noobs;
   format df 3.0 chisq pvalue 5.3;
   title;
run;


4.14 (pgs. 130) SAS code for Example 4.6

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch4 "d:\metabook\ch4\dataset";
data temp;
   set ch4.ex44;
   if (outcome = "MVP        ");
%compodds(temp,step1);
%wavgodds(step1,step2,3,.95);
%homeodds(temp,step3,4,3.26);
proc print data=step3;
%mhodds(temp,ch4.mvpodds,.95);
proc format;
   value bb 5="Log odds ratio (MH)"
            6="Odds ratio (MH)    ";
proc print data=ch4.mvpodds noobs;
   var type estimate level lower upper;
   format type bb. estimate level lower upper 6.3;
run;
data temp;
   set ch4.ex44;
   if (outcome = "Panic      ");
%compodds(temp,step1);
%wavgodds(step1,step2,3,.95);
%homeodds(temp,step3,4,2.16);
proc print data=step3;
%mhodds(temp,ch4.panodds,.95);
proc print data=ch4.panodds noobs;
   var type estimate level lower upper;
   format type bb. estimate level lower upper 5.3;
run;




5.1 (pgs. 167-168) Appendix 5.3

%macro compeff(indata,outdata);
/*****************************************************/
/*  INDATA:  Input data set name                     */
/*  OUTDATA:  Output data set name                   */
/*                                                   */
/*  NE:  Experimental group sample size              */
/*  NC:  Control group sample size                   */
/*  ME:  Experimental group sample mean              */
/*  MC:  Control group sample mean                   */
/*  SE:  Experimental group standard deviation       */
/*  SC:  Control group standard deviation            */
/*                                                   */
/* OUTPUT DATA:                                      */
/*  TYPE:  0 = Glass' delta                          */
/*         1 = Cohen's d                             */
/*         2 = Hedges' g                             */
/*         3 = Hedges' gu                            */
/*         4 = Point biserial correlation rpb        */
/*  ESTIMATE:  Effect-size estimate                  */
/*  STD:  Estimated standard deviation for           */
/*        effect-size estimate                       */
/*  LOWER:  Lower bound of 95% confidence interval   */
/*  UPPER:  Upper bound of 95% confidence interval   */
/*****************************************************/
data &outdata;  set &indata;
   dfd = ne+nc;
   dfg = dfd-2;
/*****************************************************/
/*  Compute Glass's delta                            */
/*****************************************************/
   del = (me-mc)/sc;
   vdel = dfd/(ne*nc)+(del*del)/(2*nc-2);
   sdel = sqrt(vdel);
/*****************************************************/
/*  Compute Cohen's d                                */
/*****************************************************/
   sm = sqrt(((ne-1)*(se*se)+(nc-1)*(sc*sc))/dfd);
   dd = (me-mc)/sm;
   vdd = dfd/(ne*nc)+0.5*dd*dd/dfg;
   sdd = sqrt(vdd);
/*****************************************************/
/*  Compute Hedges' g                                */
/*****************************************************/
   sp = sqrt(((ne-1)*(se*se)+(nc-1)*(sc*sc))/dfg);
   gg = (me-mc)/sp;
   vgg = dfd/(ne*nc)+0.5*gg*gg/dfg;
   sgg = sqrt(vgg);
/*****************************************************/
/*  Compute Hedges' gu                               */
/*****************************************************/
   corrf=exp(lgamma(0.5*dfg)-lgamma(0.5*(dfg-1))
      -log(sqrt(0.5*dfg)));
   gu = gg * corrf;
   vgu = dfd/(ne*nc)+0.5*gu*gu/dfd;
   sgu = sqrt(vgu);
/*****************************************************/
/*  Compute point-biserial correlation rpb           */
/*****************************************************/
   rpb = sqrt((ne*nc*dd*dd)/(ne*nc*dd*dd+dfd*dfd));
   zrpb = 0.5*log((1+rpb)/(1-rpb));
   vzrpb = 1 / (dfd-3);
   szrpb = sqrt(vzrpb);
   type = 0;
   estimate = del;
   std = sdel;
   lower = del + probit(0.025) * sdel;
   upper = del + probit(0.975) * sdel;
   output;
   type = 1;
   estimate = dd;
   std = sdd;
   lower = dd + probit(0.025) * sdd;
   upper = dd + probit(0.975) * sdd;
   output;
   type = 2;
   estimate = gg;
   std = sgg;
   lower = gg + probit(0.025) * sgg;
   upper = gg + probit(0.975) * sgg;
   output;
   type = 3;
   estimate = gu;
   std = sgu;
   lower = gu + probit(0.025) * sgu;
   upper = gu + probit(0.975) * sgu;
   output;
   type = 4;
   estimate = rpb;
   std = szrpb;
   lower = zrpb + probit(0.025) * szrpb;
   upper = zrpb + probit(0.975) * szrpb;
   lower = (exp(2*lower)-1)/(exp(2*lower)+1);
   upper = (exp(2*upper)-1)/(exp(2*upper)+1);
   output;
   keep ne nc me mc se sc type estimate lower upper;
%mend compeff;



5.2 (pgs. 151) Example 5.1 and Output 5.1

options nocenter nodate pagesize=54 linesize=80 pageno=1;
libname ch5 "d:\metabook\ch5\dataset";
data ch5.ex51;
   input ne nc me mc se sc;
cards;
44 22 1.81 1.05 2.56 1.11
%compeff(ch5.ex51,ex51out);
data ex51out;
   set ex51out;
   if (type > 1);
proc format;
  value aa 0 = "Glass' Delta   "
           1 = "Cohen's d      "
           2 = "Hedges' g      "
           3 = "Hedges' gu     "
           4 = "rpb            ";
proc print data=ex51out noobs;
   var type estimate lower upper;
   title;
   format type aa. estimate 5.3 lower upper 6.4;
run;




5.3 (pgs. 171-176) Appendix 5.5

%macro covtefst(indata,outdata);
/*********************************************************/
/*  INDATA: Input data set name                          */
/*  OUTDATA: Output data set name                        */
/*********************************************************/
data &outdata;
   set &indata;
/*********************************************************/
/*  INPUT DATA:                                          */
/*   ESTYPE: Type of effect-size estimate or statistic   */
/*         ESTYPE = 1 for Cohen's d                      */
/*         ESTYPE = 2 for Hedges' g                      */
/*         ESTYPE = 3 for Hedges' gu                     */
/*         ESTYPE = 4 for Point-biserial correlation rpb */
/*         ESTYPE = 5 for t statistic                    */
/*         ESTYPE = 6 for F statistic                    */
/*                                                       */
/*     NE:  Experimental group sample size               */
/*     NC:  Control group sample size                    */
/*     STAT: STAT is effect-size estimate if STYPE = 0   */
/*           STAT is t statistic if STYPE = 1            */
/*           STAT is F statistic if STYPE = 2            */
/*                                                       */
/*  OUTPUT DATA:                                         */
/*     NE:  Experimental group sample size               */
/*     NC:  Control group sample size                    */
/*     TYPE: 1 = Cohen's d                               */
/*              2 = GG: Hedges' g                        */
/*              3 = GU: Hedges' gu                       */
/*              4 = Point-biserial correlation rpb       */
/*              5 = t statistic                          */
/*              6 = F statistic                          */
/*     ESTIMATE: Effect-size estimate                    */
/*     LOWER:    Lower bound for 95% confidence interval */
/*     UPPER:    Upper bound for 95% confidence interval */
/*********************************************************/
   dfd=nc+ne;
   dfg=nc+ne-2;
   corrf=exp(lgamma(0.5*dfg)-lgamma(0.5*(dfg-1))
      -log(sqrt(0.5*dfg)));
   select (estype);
   when (1) do;
/*********************************************************/
/*  Converting Cohen's d to Hedges' g, Hedges' gu,       */
/*  rpb, t statistic, and F statistic                    */
/*********************************************************/
      dd=stat;
      gg=sqrt(dfg/dfd)*dd;
      gu=corrf*gg;
      rpb=sqrt((nc*ne*dd*dd)/(nc*ne*dd*dd+dfd*dfd));
      tstat = gg * sqrt(ne * nc / dfd);
      fstat = tstat * tstat;
   end;
   when (2) do;
/*********************************************************/
/*  Converting Hedges' g to Cohen's d, Hedges' gu,       */
/*  rpb, t statistic, and F statistic                    */
/*********************************************************/
      gg=stat;
      dd=gg*sqrt(dfd/dfg);
      gu=corrf*gg;
      rpb=sqrt((ne*nc*dd*dd)/(ne*nc*dd*dd+dfd*dfd));
      tstat = gg * sqrt(ne * nc / dfd);
      fstat = tstat * tstat;
   end;
   when (3) do;
/*********************************************************/
/*  Converting Hedges' gu to Cohen's d, Hedges' g,       */
/*  rpb,  t statistic, and F statistic                   */
/*********************************************************/
      gu=stat;
      gg=gu/corrf;
      dd=gg*sqrt(dfd/dfg);
      rpb=sqrt((ne*nc*dd*dd)/(ne*nc*dd*dd+dfd*dfd));
      tstat = gg * sqrt(ne * nc / dfd);
      fstat = tstat * tstat;
   end;
   when (4) do;
/*********************************************************/
/*  Converting rpb to Cohen's d, Hedges' g, Hedges' gu,  */
/*   t statistic, and F statistic                        */
/*********************************************************/
      rpb=stat;
      dd=(dfd*rpb)/sqrt(nc*ne*(1-rpb*rpb));
      gg=dd*sqrt(dfg/dfd);
      gu=gg*corrf;
      tstat = gg * sqrt(ne * nc / dfd);
      fstat = tstat * tstat;
   end;
/*********************************************************/
/*  Converting Test Statistics                           */
/*********************************************************/
   when (5) do;
      tstat = stat;
      fstat = tstat * tstat;
      dd = tstat * dfd / sqrt(ne*nc*dfg);
      gg=sqrt(dfg/dfd)*dd;
      gu=corrf*gg;
      rpb=sqrt((nc*ne*dd*dd)/(nc*ne*dd*dd+dfd*dfd));
   end;
/*********************************************************/
/*  Converting Test Statistics                           */
/*********************************************************/
   when (6) do;
      fstat = stat;
      tstat = sqrt(fstat);
      dd = tstat * dfd / sqrt(ne*nc*dfg);
      gg=sqrt(dfg/dfd)*dd;
      gu=corrf*gg;
      rpb=sqrt((nc*ne*dd*dd)/(nc*ne*dd*dd+dfd*dfd));
   end;
   otherwise put "estype can only be 1, 2, 3, 4, 5, 6";
   end;
   vdd = dfd/(nc*ne) + (dd * dd) / (2 * dfg);
   vgg = dfd/(nc*ne) + (gg * gg) / (2 * dfg);
   vgu = dfd/(nc*ne) + (gu * gu) / (2 * dfd);
   zrpb = 0.5 * log((1+rpb)/(1-rpb));
   vzrpb = 1 / (dfd - 3);
   type = 1;
   estimate = dd;
   std = sqrt(vdd);
   lower = dd + probit(0.025) * std;
   upper = dd + probit(0.975) * std;
   output;
   type = 2;
   estimate = gg;
   std = sqrt(vgg);
   lower = gg + probit(0.025) * std;
   upper = gg + probit(0.975) * std;
   output;
   type = 3;
   estimate = gu;
   std = sqrt(vgu);
   lower = gu + probit(0.025) * std;
   upper = gu + probit(0.975) * std;
   output;
   type = 4;
   estimate = rpb;
   std = sqrt(vzrpb);
   lower = zrpb + probit(0.025) * std;
   upper = zrpb + probit(0.975) * std;
   lower = (exp(2*lower)-1)/(exp(2*lower)+1);
   upper = (exp(2*upper)-1)/(exp(2*upper)+1);
   output;
   type = 5;
   estimate = tstat;
   lower = .;
   upper = .;
   output;
   type = 6;
   estimate = fstat;
   std = . ;
   lower = .;
   upper = .;
   keep type estimate std lower upper ne nc;
run;
%mend covtefst;



5.4 (pgs. 153-154) Example 5.2 and Output 5.2

options nodate nocenter pagesize=54 linesize=80 pageno=1;
data ex52;
   input estype ne nc stat;
cards;
5 74 91 3.36
%covtefst(ex52,ex52out);
proc format;
  value aa 2 = "Hedges' g "
           3 = "Hedges' gu"
           4 = "rpb       ";
data ex52out;
   set ex52out;
   if (2 <= type <= 4);
proc print data=ex52out noobs;
   var type estimate lower upper;
   title;
   format type aa. estimate 5.3 lower upper 6.4;
run;



5.5 (pgs. 157) Data for Example 5.3

options nodate nocenter linesize=80 pagesize=54 pageno=1;
libname ch5 "d:\metabook\ch5\dataset";
data a1;
   input me se ne mc sc nc;
cards;
1.96      0.548      30      1.78      0.548      30
13.05      11.38      20      4.00      11.38      10
1.81      2.56      44      1.05      1.11      22
4.19      2.87      16      2.59      2.87      16
0.30      0.158      32      0.25      0.158      32
%compeff(a1,a2);
data a2;
   set a2;
   estype = 3;
   stat = estimate;
   if (type = 3);
   keep estype ne nc stat;
data a1;
   input estype nc ne stat;
cards;
2  14   14   -.34
2  48   48   -.17
2  26   26   -.07
6  17   34   7.18
6  18.5 18.5 4.13
5   5    5   1.04
data ch5.ex53;
   set a2 a1;
run;


5.6 (pgs. 156-159) Example 5.3 and Output 5.3

options nodate nocenter linesize=80 pagesize=54 pageno=1;
libname ch5 "d:\metabook\ch5\dataset";
%covtefst(ch5.ex53,temp);
%wavgmeta(temp,combine1,2,0.95);
%covtefst(ch5.ex53,temp);
%wavgmeta(temp,combine2,3,0.95);
%covtefst(ch5.ex53,temp);
%wavgmeta(temp,combine3,4,0.95);
proc format;
   value aa 2 = "Hedges' g+ "
            3 = "Hedges' gu+"
            4 = "rpb+       ";
data ex53out;
   set combine1 combine2 combine3;
   keep type estimate lower upper;
proc print data=ex53out noobs;
   title;
   format type aa. estimate 5.3 lower upper 5.3;
run;



5.7 (pgs. 161) Data for Example 5.4

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch5 "d:\metabook\ch5\dataset";
data ch5.ex54;
   input nn stat;
   estype = 4;
   ne = int(0.5*nn);
   nc = nn - ne;
   keep estype ne nc stat;
cards;
86      .29
88      .00
60      .24
183      .21
37      .15
101      .10
300      .07
248      .00
30      -.16
89      .00
182      .08
161      .21
296      .33
55      .26
114      .19
173      .03
249      .11
98      -.03
189      .00
84      .03
run;



5.8 (pgs. 161-162) Example 5.4 and Output 5.4

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch5 "d:\metabook\ch5\DATASET";
%covtefst(ch5.ex54,temp);
%wavgmeta(temp,ex54out,4,0.95);
proc format;
   value aa 7 = "Fisher's Z+   "
            4 = "Correlation r+";
data ex54out; set ex54out;
   output;
   type = 7;
   estimate = 0.5*log((1+estimate)/(1-estimate));
   lower = 0.5*log((1+lower)/(1-lower));
   upper = 0.5*log((1+upper)/(1-upper));
   output;
proc print data=ex54out noobs;
   var type estimate lower upper;
   format type aa. estimate lower upper 5.3;
   title;
run;




6.1 (pgs. 185) Data for Example 6.1 and Table 6.1

options nocenter nodate pagesize=54 linesize=80 pageno=1;
libname ch6 "d:\metabook\ch6\dataset";
/***************************************************************/
/*  Example 6.1:  Find the vote-counting estimate for the      */
/*                standardized mean differences based on the   */
/*                proportion of positive results               */
/***************************************************************/
data ch6.ex61;
   input ne nc sig effect;
cards;
 19      19      1      1.028
 24      24      1      0.903
 24      24      1      0.552
 24      24      1      0.328
 12      12      1      0.193
 24      24      0     -0.036
 24      24      0     -0.332
 15      15      0     -0.540
 12      12      0     -0.660
 16      16      1         .
 12      12      1         .
 10      10      1         .
 10      10      0         .
;
run;


6.2 (pgs. 197) Appendix 6.1

options nocenter nodate pagesize=54 linesize=80 pageno=1;
libname ch6 "d:\metabook\ch6\dataset";
proc iml;
/*************************************************************/
/*  Compute the probability of the vote-counting estimate    */
/*  with the large sample approximation method               */
/*************************************************************/
   start votecdf1(alpha,size,rho,votecdf);
   if (alpha = 0.5) then do;
     tem = -sqrt(size)*rho/(1-rho*rho);
     if (tem > 7.941) then tem=7.941;
     else if (tem < -8.222) then tem=-8.222;
     votecdf = 1 - probnorm(tem);
   end;
   else do;
      malpha = alpha * 2;
      cst = 0.5*size-1;
      can = sqrt(1 - betainv(malpha,cst,0.5));
      tem = (can-sqrt(size)*rho)/(1-rho*rho);
      if (tem > 7.941) then tem=7.941;
      else if (tem < -8.222) then tem=-8.222;
      votecdf = 1 - probnorm(tem);
   end;
   finish votecdf1;
   reset storage=ch6.imlrout;
   store module=(votecdf1);
run;
quit;



6.3 (pgs. 198-200) Appendix 6.2

options nocenter nodate pagesize=54 linesize=80 pageno=1;
libname ch6 "d:\metabook\ch6\dataset";
/********************************************************/
/* Purpose:                                             */
/* Vote-Counting Methods for Obtaining a Confidence     */
/* Interval for the Population Standardized Mean        */
/* Difference                                           */
/* Input Information:                                   */
/* NE: The experimental group sample size               */
/* NC: The control group sample size                    */
/* SIG: SIG=1 if the effect-size estimate for the study */
/*      is significantly different from zero at         */
/*      level = ALPHA                                   */
/*      SIG=0 otherwise                                 */
/* EFFECT: Any effect-size estimate for studies that    */
/*        provide enough information to compute it.     */
/*     For studies with missing effect-size estimates,  */
/*     EFFECT = . (for a missing value).                */
/* ALPHA: The level of significance for each study      */
/*        under review                                  */
/* LEVEL: The confidence level. of the confidence       */
/*        interval                                      */
/* Output Information:                                  */
/*    Output File Name: VOTEAOUT                        */
/*    Variable Name:                                    */
/*    DELTA: Effect-size estimate based on              */
/*           vote-counting methods                      */
/*    VDELTA: Corresponding variance for the            */
/*           effect-size estimate                       */
/*    LOWER: Lower bound for the confidence interval    */
/*    UPPER: Upper bound for the confidence interval    */
/*    LEVEL: The confidence level. of the confidence    */
/*           interval                                   */
/********************************************************/
proc iml;
   start votea(ne,nc,sig,effect,alpha,level);
/********************************************************/
/*  Initialize some constants                           */
/*  DF: Degrees of freedom for each study               */
/*  SVC: Square root of the harmonic mean for the       */
/*       sample sizes                                   */
/*  TT: Upper quantile for each study                   */
/********************************************************/
   df=ne+nc-2;
   svc=sqrt(ne#nc/(ne+nc));
   tt=j(nrow(ne),1,0);
   if (alpha < 0.5) then do;
      tt=betainv(0.9,0.5,0.5#df);
      tt=sqrt((tt#df)/(1-tt));
   end;
/********************************************************/
/*  Start the iteration to find the effect-size         */
/*      estimate                                        */
/*  DELTA: Effect-size estimate based on vote-count     */
/*  VDELTA: Variance for the effect-size estimate       */
/********************************************************/
   again=j(5,1,0);
   again[5,1]=max(effect);
   again[1,1]=min(effect);
   again[3,1]=0.5*(again[1,1]+again[5,1]);
   again[2,1]=0.5*(again[1,1]+again[3,1]);
   again[4,1]=0.5*(again[3,1]+again[5,1]);
   abserr=1;
   k=1;
   xx=j(5,1,0);
   yy=j(nrow(ne),1,0);
   do while (abserr > 2d-5 & k <= 30);
      large = 1;
      do I = 1 to 5;
         xx[i,1] = 0;
      do j = 1 to nrow(ne);
         delta = again[i,1] * svc[j,1];
         res = 1 - probt(tt[j,1],df[j,1],delta);
         xx[i,1] = xx[i,1] + (sig[j,1]*log(res)+
                   (1-sig[j,1])*log(1-res));
      end;
      if (i > 1) then do;
         if (xx[i,1] > xx[i-1,1]) then large=i;
      end;
   end;
   again[1,1] = again[large-1,1];
   again[5,1] = again[large+1,1];
   again[3,1] = again[large,1];
   again[4,1] = 0.5 * (again[3,1]+again[5,1]);
   again[2,1] = 0.5 * (again[1,1]+again[3,1]);
   k=k+1;
   abserr=abs(again[5,1]-again[1,1]);
   end;
DELTA=again[3,1];
/********************************************************/
/*  Find the maximum likelihood estimate for the        */
/*  variance of the vote-count estimate for the         */
/*  effect-size                                         */
/********************************************************/
vdelta=0;
do I = 1 to nrow(ne);
   res=svc[I,1]*delta;
   tt[i,1]=probnorm(res);
   yy[i,1]=(svc[i,1]/sqrt(8*atan(1)))*exp(res*res*(-0.5));
   vdelta=vdelta+yy[i,1]*yy[i,1]/(tt[i,1]*(1-tt[i,1]));
   end;
vdelta=1/vdelta;
/********************************************************/
/*  Compute the confidence interval for the population  */
/*  standardized mean difference                        */
/*  LOWER: Lower bound for confidence interval          */
/*  UPPER: Upper bound for confidence interval          */
/*  LEVEL: The confidence level of the confidence       */
/*         interval                                     */
/*  DELTA: Effect-size estimate based on vote-count     */
/*  VDELTA: Variance for the effect-size estimate       */
/********************************************************/
   estimate=delta;
   varest=vdelta;
   delta=j(nrow(level),1,0);
   vdelta=j(nrow(level),1,0);
   lower=j(nrow(level),1,0);
   upper=j(nrow(level),1,0);
   do i = 1 to nrow(level);
      lbound=estimate
             +probit(0.5*(1-level[i,1]))*sqrt(varest);
      ubound=estimate
             +probit(0.5*(1+level[i,1]))*sqrt(varest);
      delta[i,1]=estimate;
      vdelta[i,1]=varest;
      lower[i,1]=lbound;
      upper[i,1]=ubound;
   end;
   create voteaout var{level delta vdelta lower upper};
   append;
   close voteaout;
   finish votea;
   reset storage=ch6.imlrout;
   store module=(votea);
run;
quit;


6.4 (pgs. 201-203) Appendix 6.3

options nocenter nodate pagesize=54 linesize=80 pageno=1;
libname ch6 "d:\metabook\ch6\dataset";
/********************************************************/
/* Purpose: Vote-Counting Methods for Obtaining a       */
/*          Confidence Interval for the Pearson Product */
/*          Correlation Coefficient                     */
/*                                                      */
/* Input Information:                                   */
/* NN: Total sample size                                */
/* SIG: SIG = 1 if the correlation for the study is     */
/*              significantly different from zero at    */
/*              level = ALPHA                           */
/*      SIG = 0 otherwise                               */
/* RR: Correlation for studies that provided this       */
/*     information.  RR sets to the maximum value for   */
/*     half of the studies that did not provide this    */
/*     information                                      */
/*     RR sets to minimum value for another half of the */
/*     studies that did not provide this information.   */
/* ALPHA: The level of significance for each study      */
/*     under review                                     */
/* LEVEL: The confidence level for the combined         */
/*     confidence interval                              */
/*                                                      */
/* Output Information:                                  */
/* Print Output:                                        */
/* (1) RHO: Effect-size estimate based on vote-count    */
/* (2) VRHO: Variance for the effect-size estimate      */
/* (3) LOWER: Lower bound for confidence interval       */
/* (4) UPPER: Upper bound for confidence interval       */
/* (5) LEVEL: Confidence level for the combined         */
/*            interval                                  */
/********************************************************/
proc iml;
   start voteb(nn,sig,rr,alpha,level);
/********************************************************/
/*  Start the iteration to find the effect-size         */
/*  estimate                                            */
/*  RHO: Effect-size estimate based on vote-counting    */
/*       method                                         */
/*  VRHO: Variance for the effect-size estimate         */
/********************************************************/
   again=j(5,1,0);
   again[5,1]=max(rr);
   again[1,1]=min(rr);
   again[3,1]=0.5*(again[1,1]+again[5,1]);
   again[2,1]=0.5*(again[1,1]+again[3,1]);
   again[4,1]=0.5*(again[3,1]+again[5,1]);
   abserr=1;
   kk=1;
   xx=j(5,1,0);
   dd=j(nrow(nn),1,0);
   pp=j(nrow(nn),1,0);
   do while ((abserr > 2d-5) & (kk < 50));
      large = 1;
      do i = 1 to 5;
         rho=again[i,1];
         xx[i,1] = 0;
         do j = 1 to nrow(nn);
            size=nn[j,1];
            run votecdf1(alpha,size,rho,votecdf);
            xx[i,1]=xx[i,1]+sig[j,1]*log(votecdf)+
                 (1-sig[j,1])*(log(1-votecdf));
         end;
         if (i > 1) then do;
            if (xx[i,1] > xx[i-1,1]) then large = I;
         end;
      end;
   again[1,1] = again[large-1,1];
   again[5,1] = again[large+1,1];
   again[3,1] = 0.5*(again[1,1]+again[5,1]);
   again[2,1] = 0.5*(again[1,1]+again[3,1]);
   again[4,1] = 0.5*(again[3,1]+again[5,1]);
   kk=kk+1;
   abserr=abs(again[5,1]-again[1,1]);
   end;
/********************************************************/
/*  Compute the confidence interval for the Pearson     */
/*      Product correlation:                            */
/*  LOWER: Lower bound for confidence interval          */
/*  UPPER: Upper bound for confidence interval          */
/*  LEVEL: Confidence level for the combined interval   */
/*  RHO: Effect-size estimate                           */
/*  VRHO: Variance for the effect-size estimate         */
/********************************************************/
esrho=again[3,1];
vesrho=0;
tt3=8*atan(1);
rho=esrho;
do i = 1 to nrow(nn);
   size=nn[I,1];
   run votecdf1(alpha,size,rho,votecdf);
   pp[i,1]=votecdf;
   tt1=(1+esrho*esrho)/(1-esrho*esrho)##2;
   tt2=exp(-0.5*(nn[i,1]*esrho*esrho)/(1-esrho*esrho)**2);
   dd[i,1]=sqrt(nn[i,1]/tt3)*tt1*tt2;
   vesrho=vesrho+dd[i,1]*dd[i,1]/(pp[i,1]*(1-pp[i,1]));
   end;
   vesrho=1/vesrho;
   estimate=esrho;
   varest=vesrho;
   rho=j(nrow(level),1,0);
   vrho=j(nrow(level),1,0);
   lower = estimate + probit((1-level)*0.5)*sqrt(varest);
   upper = estimate + probit((1+level)*0.5)*sqrt(varest);
   do i = 1 to nrow(level);
      rho[i,1]=estimate;
      vrho[I,1]=varest;
   end;
   create votebout var{LEVEL RHO VRHO LOWER UPPER};
   append;
   close votebout;
   finish voteb;
   reset storage=ch6.imlrout;
   store module=(voteb);
run;
quit;


6.5 (pgs. 204) Appendix 6.4

libname ch6 "d:\metabook\ch6\dataset";
%macro voterun(indata,index,alpha,level);
proc iml;
   reset nolog;
   reset storage=ch6.imlrout;
   alpha=&alpha;
   level=&level;
   if (upcase(&index)="MEAN") then do;
      load module=(votea);
      use &indata;
      read all;
      run votea(ne,nc,sig,effect,alpha,level);
      end;
   else if (upcase(&index)="CORR") then do;
      load module=(voteb votecdf1);
      use &indata;
      read all;
      run voteb(nn,sig,rr,alpha,level);
      end;
run;
quit;
%mend voterun;


6.6 (pgs. 187) Example 6.1 and Output 6.1

options nocenter nodate pagesize=54 linesize=80 pageno=1;
libname ch6 "d:\metabook\ch6\dataset";
%voterun(ch6.ex61,"Mean",0.5,0.90);
data result;
   set voteaout;
%voterun(ch6.ex61,"Mean",0.5,0.95);
data result;
   set result voteaout;
%voterun(ch6.ex61,"Mean",0.5,0.99);
data result;
   set result voteaout;
proc print data=result round noobs;
   format level 3.2 delta vdelta lower upper 5.3;
   title;
run;


6.7 (pgs. 188-189) Example 6.2 and Output 6.2

options nocenter nodate pagesize=54 linesize=80 pageno=1;
libname ch6 "d:\metabook\ch6\dataset";
%voterun(ch6.ex62,"Mean",0.05,0.90);
data result;
   set voteaout;
%voterun(ch6.ex62,"Mean",0.05,0.95);
data result;
   set result voteaout;
%voterun(ch6.ex62,"Mean",0.05,0.99);
data result;
   set result voteaout;
proc print data=result round noobs;
   format level 3.2 delta vdelta lower upper 5.3;
   title;
run;


6.8 (pgs. 191) Data for Example 6.3 and Table 6.2

options nocenter nodate pagesize=54 linesize=80 pageno=1;
libname aa "d:\metabook\ch6\dataset";
/***************************************************************/
/*  Example 6.3:  Find the vote-counting estimate for the      */
/*                population correlation coefficient based on  */
/*                the proportion of positive results           */
/***************************************************************/
data aa.ex63;
   input nn sig rr;
cards;
 294   1   .240
  60   1   .240
 578   1   .123
 459   1   .069
 241   0   -.050
 866   0   -.062
 493   0   -.130
 212   0   -.162
 272   0   -.210
 147   0   -.260
 481   0   -.342
  99   0   -.346
1127   1       .
 312   1       .
  99   1       .
 432   1       .
 637   1       .
 909   1       .
 580   0       .
 544   0       .
 501   0       .
 402   0       .
 266   0       .
 205   0       .
 197   0       .
 195   0       .
 152   0       .
 105   0       .
 111   0       .
 114   0       .
 129   0       .
 206   0       .
 466   0       .
 513   0       .
 602   0       .
 964   0       .
;
run;



6.9 (pgs. 190-193) Example 6.3 and Output 6.3

options nocenter nodate pagesize=54 linesize=80 pageno=1;
libname ch6 "d:\metabook\ch6\dataset";
/***************************************************************/
/*  Example 6.3:  Find the vote-counting estimate for the      */
/*                population correlation coefficient based on  */
/*                the proportion of positive results           */
/***************************************************************/
%voterun(ch6.ex63,"corr",0.5,0.90);
data result;
   set votebout;
%voterun(ch6.ex63,"corr",0.5,0.95);
data result;
   set result votebout;
%voterun(ch6.ex63,"corr",0.5,0.99);
data result;
   set result votebout;
proc print data=result round noobs;
   format level 3.2 rho vrho lower upper 6.4;
run;



6.10 (pgs. 193-194) Example 6.4 and Output 6.4

options nocenter nodate pagesize=54 linesize=80 pageno=1;
libname ch6 "d:\metabook\ch6\dataset";
%voterun(ch6.ex64,"corr",0.05,0.90);
data result;
   set votebout;
%voterun(ch6.ex64,"corr",0.05,0.95);
data result;
   set result votebout;
%voterun(ch6.ex64,"corr",0.05,0.99);
data result;
   set result votebout;
proc print data=result round noobs;
   format level 3.2 rho vrho lower upper 6.4;
run;




7.1 (pgs. 217-218) Appendix 7.1, Example 7.1, and Table 7.1

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch7 "d:\metabook\ch7\dataset";
libname ch6 "d:\metabook\ch6\dataset";
/*******************************************************/
/*  Meta-analysis for studies that reported enough     */
/*  information to calculate effect-size estimates     */
/*******************************************************/
%covtefst(ch7.ex71a,temp);
%wavgmeta(temp,combine1,3,0.95);
data combine1;
   set combine1;
   method = "Effect-size (gu)";
   study = 9;
   variance = stdwavg * stdwavg;
   keep method study estimate variance lower upper;
run;
/*******************************************************/
/*  Meta-analysis for studies that only reported       */
/*  information about the direction of the results     */
/*******************************************************/

/* VOTERUN MACRO is defined in Appendix 6.4 */

%voterun(ch7.ex71b,"Mean",0.5,0.95);
data combine2;
   set voteaout;
   method = "Vote-count (DIR)";
   study = 4;
   estimate = delta;
   variance = vdelta;
   keep method study estimate variance lower upper;
data temp;
   set combine1 combine2;
   eff = estimate / variance;
   veff = 1 / variance;
   keep eff veff;
proc means data = temp noprint;
   var eff veff;
   output out = tempout sum = s1 s2;
/********************************************************/
/* The combined procedure                               */
/********************************************************/
data combine3;
   set tempout;
   method = "Combined        ";
   study = 13;
   estimate = s1 / s2;
   variance = 1 / s2;
   lower = estimate + probit(0.025) * sqrt(variance);
   upper = estimate + probit(0.975) * sqrt(variance);
   keep method study estimate variance lower upper;
data result; set combine3 combine1 combine2;
proc print data = result noobs;
   var method study estimate lower upper;
   title;
   format estimate 5.3 lower upper 5.3;
run;



7.2 (pgs. 219-220) Appendix 7.2

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname aa "d:\metabook\ch6\dataset";
proc iml;
   start maxcorr(nn,rr,level);
/*********************************************************/
/*  Input Variables:                                     */
/*     NN: Study sample size                             */
/*     RR: Sample correlation coefficient                */
/*     LEVEL: Confidence level of the confidence interval*/
/*                                                       */
/*  Output Variables:                                    */
/*     ESTIMATE: Maximum likelihood effect-size estimate */
/*     VARIANCE: Maximum likelihood variance estimate    */
/*     LOWER: Lower bound for the confidence interval    */
/*     UPPER: Upper bound for the confidence interval    */
/*     LEVEL: Confidence level of the confidence interval*/
/*********************************************************/
/*********************************************************/
/*      Compute the initial value for Newton iteration   */
/*********************************************************/
   xold = 0.5*(max(rr)+min(rr));
/*********************************************************/
/*      Newton iteration to compute the maximum          */
/*      likelihood effect-size estimate                  */
/*********************************************************/
   abserr=1;
   k=1;
   do while ((abserr > 1d-5) & (k < 30));
      fold=0;
      fpold=0;
      do I = 1 to nrow(nn);
         fold=fold+(nn[I,1]*(rr[I,1]-xold))/(1-rr[I,1]*xold);
         fpold=fpold+nn[I,1]*(rr[I,1]*rr[I,1]-1)/
            ((1-rr[I,1]*xold)*(1-rr[I,1]*xold));
      end;
      xnew = xold - fold / fpold;
      abserr = abs(xnew-xold);
      k = k + 1;
      xold = xnew;
   end;
   estimate = xnew;
   variance = (1-xnew*xnew)*(1-xnew*xnew)/sum(nn);
   lower = xnew + probit(0.5*level)*sqrt(variance);
   upper = xnew + probit(1-0.5*level)*sqrt(variance);
   create mcorrout var {estimate variance lower upper};
   append;
   close mcorrout;
   finish maxcorr;
   reset storage=aa.imlrout;
   store module=(maxcorr);
run;
quit;


7.3 (pgs. 221-222) Appendix 7.3, Example 7.2, and Output 7.2

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname aa "d:\metabook\ch6\dataset";
libname ch7 "d:\metabook\ch7\dataset";
/*******************************************************/
/*  Meta-analysis for studies that reported enough     */
/*  information to calculate Pearson product-moment    */
/*  correlations                                       */
/*******************************************************/
proc iml;
   reset nolog;
   reset storage=aa.imlrout;
   load module=(maxcorr);
   use ch7.data72a;
   read all;
   level=0.05;
   run maxcorr(nn,rr,level);
run;
data combine1;
   method="MLE             ";
   study = 12;
   set mcorrout;
/********************************************************/
/*  Meta-analysis for studies that only reported the    */
/*  significance and direction of sample correlations   */
/********************************************************/
%voterun(ch7.data72b,"corr",0.05,0.95);
data combine2;
   method="Vote-count (SIG)";
   study=9;
   set votebout;
   estimate = rho;
   variance = vrho;
   keep method study estimate variance lower upper;
/*******************************************************/
/*  Meta-analysis for studies that only reported the   */
/*  direction of sample correlations                   */
/*******************************************************/
%voterun(ch7.data72c,"corr",0.50,0.95);
data combine3;
   method="Vote-count (DIR)";
   study=15;
   set votebout;
   estimate = rho;
   variance = vrho;
   keep method study estimate variance lower upper;
   set votebout;
/********************************************************/
/* The combined procedure                               */
/********************************************************/
data temp;
   set combine1 combine2 combine3;
   eff = estimate / variance;
   veff = 1 / variance;
   keep eff veff;
proc means data = temp noprint;
   var eff veff;
   output out = tempout sum = s1 s2;
data combine4;
   set tempout;
   method="Combined        ";
   study=36;
   estimate = s1 / s2;
   variance = 1 / s2;
   lower = estimate + probit(0.025) * sqrt(variance);
   upper = estimate + probit(0.975) * sqrt(variance);
   keep method study estimate variance lower upper;
data result; set combine4 combine1 combine2 combine3;
proc print data = result noobs;
   var method study estimate lower upper;
   title;
   format estimate 5.3 lower upper 5.3;
run;




8.1 (pgs. 234) Data for Example 8.1, Table 8.3

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
data ch8.ex81;
  input study aggr nne gne vne nnc gnc vnc;
cards;
 1      1      40      0.98      0.11      40      0.78      0.11
 2      2      10      0.87      0.44      10      0.15      0.40
 3      1     100      0.78      0.04     100     -0.58      0.04
 4      1      20      0.64      0.21      20      0.37      0.20
 5      2     120      0.53      0.03      60      0.08      0.07
 6      1      40      0.52      0.10      40      0.63      0.11
 7      1      40      0.46      0.10      40      0.52      0.10
 8      1     240      0.42      0.19     240     -0.16      0.03
 9      2      96      0.38      0.04      96      0.48      0.04
10      2      25      0.30      0.16      25     -0.15      0.16
11      1     194      0.28      0.02     194      0.49      0.02
12      1      12      0.21      0.33      12      0.15      0.34
13      1      40      0.19      0.10      40      0.07      0.10
14      1      10      0.00      0.40      10      0.00      0.40
15      2      80      0.00      0.05      80      0.00      0.05
16      2      34      0.00      0.12      34      0.00      0.12
17      2      40      0.00      0.10      40      0.00      0.10
18      2      40      0.00      0.10      40      0.00      0.10
19      2      39     -0.02      0.10      39      2.03      0.15
20      1      12     -0.02      0.33      12      0.08      0.34
21      1      12     -0.03      0.33      12      0.02      0.34
22      1      20     -0.09      0.20      20      1.13      0.23
23      1      12     -0.10      0.33      12      0.60      0.35
24      1      10     -0.11      0.40      10      2.31      0.67
25      3      60     -0.29      0.07      60     -0.02      0.07
26      2      72     -0.44      0.08      72      0.39      0.04
27      1      28     -0.67      0.20      27      0.40      0.15
28      3      40     -0.69      0.10      40     -0.10      0.10
29      2      20     -0.84      0.22      20      0.71      0.21
30      2      8      -1.19      0.59       8      0.61      0.52
31      1      10     -1.20      0.47      10      1.87      0.58
32      2      14     -2.52      1.65      14      0.31      0.29
proc print;
data ch8.ex81;
   set ch8.ex81;
   eff=gne;
   veff=vne;
   prov = 1;
   output;
   eff=gnc;
   veff=vnc;
   prov = 2;
   output;
   keep study aggr prov eff veff;
proc print data=ch8.ex81 noobs;
   title;
run;


8.2 (pgs. 266-267) Appendix 8.1

%macro within(indata,outdata,eff,veff,ftname,nlevels);
/********************************************************/
/*   INDATA:  Input data file name                      */
/*   Input data file contains three variables:          */
/*     (1) EFF: Effect-size estimate                    */
/*     (2) VEFF: The estimated variance for the         */
/*              effect-size estimate                    */
/*     (3) ftname:  Name of the factor included in      */
/*             the model                                */
/*   NLEVELS:  The number of levels of the factor       */
/*            FTNAME.  For example, if the model        */
/*            contains two categorical variables, A and */
/*            B, where A has three levels and B has two */
/*            levels, the number of levels is 6 (2*3).  */
/*            In this example, one needs to create an   */
/*            artificial variable, FTNAME, that has six */
/*            levels.                                         */
/*   OUTDATA: The output data file name.                */
/*     The output data file contains the information in */
/*     the fixed-effects ANOVA table                    */
/********************************************************/
data tempin;
   set &indata;
   weight = 1 / &veff;
data fate;
%do i = 1 %to &nlevels;
data in&i;
   set tempin;
   if (&ftname = &i);
proc glm data=in&i noprint outstat=temp&i;
   class &ftname;
   model &eff = &ftname;
   weight weight;
quit;
%end;
%do i = 1 %to &nlevels;
   data fate;
      set fate temp&i;
%end;
proc glm data=tempin noprint outstat=out1;
   class &varlist1;
   model &eff = &varlist2;
   weight weight;
data out0 out2;
   set out1;
   if (_type_ = "SS1  ") then output out0;
   if (_type_ ^= "SS3  ") then output out2;
   keep df ss;
data out3;
   set out1 fate;
   if (_type_ = "ERROR");
   keep df ss;
proc means data=out2 noprint;
   var df ss;
   output out=out4 sum=df ss;
data &outdata;
   source = _n_;
   set out0 out3 out4;
   qstat=ss;
   pvalue = 1 - probchi(qstat,df);
   keep source qstat df pvalue;
%mend within;



8.3 (pgs. 235) Output 8.1

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\metabook\ch8\dataset";
%let varlist1 = aggr;
%let varlist2 = aggr;
%within(ch8.ex81,ch8.ex81outa,eff,veff,aggr,3);
proc format;
   value aa  1 = "Between Groups       "
         2 = "Within Groups        "
         3 = "  Within (Physical)  "
         4 = "  Within (Evaluation)"
         5 = "  Within (Money Loss)"
         6 = "Corrected Total      ";
proc print data=ch8.ex81outa noobs;
   title;
   format source aa. qstat pvalue 7.3;
run;


8.4 (pgs. 268) Appendix 8.2

%macro wavgeff(indata,outdata,level);
/********************************************************/
/*  INDATA:  The input data set name                    */
/*    The macro assumes that the:                       */
/*       (1) variable name for the effect-size estimate */
/*    is EFF                                            */
/*    Note that EFF can be any of the following effect  */
/*    size estimators: Hedges' g, Hedges' gu, Cohen's d, */
/*    point-biseral correlation, or Fisher's z.         */
/*       (2) variable name for the corresponding        */
/*    variance is VEFF                                  */
/*                                                      */
/*  OUTDATA: The output data file name                  */
/*  The output data file contains four variables        */
/*                                                      */
/*      (1) ESTIMATE:  Combined estimate for the effect */
/*              size                                    */
/*      (2) LOWER: Lower bound for confidence interval  */
/*      (3) UPPER: Upper bound for confidence interval  */
/*      (4) LEVEL: Level of confidence for the          */
/*      confidence interval.                            */
/*                                                      */
/*    LEVEL:  Level of the confidence of the confidence */
/*            interval                                  */
/********************************************************/
data;
   set &indata;
   weight = 1 / veff;
   keep eff veff weight &varlist;
proc sort;
   by &varlist;
proc means noprint;
   var eff;
   weight weight;
   by &varlist;
   output out=&outdata mean=meff sumwgt=invvar;
run;
data &outdata;
   set &outdata;
   estimate = meff;
   level=&level;
   variance = 1 / invvar;
   std = sqrt(1/invvar);
   lower = estimate + probit(.5-.5*level)*std;
   upper = estimate + probit(.5+.5*level)*std;
   keep &varlist estimate variance level lower upper;
run;
%mend wavgeff;


8.5 (pgs. 236) Output 8.2

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\metabook\ch8\dataset";
data temp;
   set ch8.ex81;
   output;
   aggr = 4;
   output;
%let varlist = aggr;
%wavgeff(temp,ch8.ex81outb,.95);
proc format;
   value aa 1 = "Physical  "
            2 = "Evaluation"
            3 = "Money Loss"
            4 = "Over All  ";
proc print data=ch8.ex81outb noobs;
   var aggr estimate level lower upper;
   format aggr aa. estimate level lower upper 6.3;
run;

8.6 (pgs. 269-270) Appendix 8.3

%macro fixconst(indata,outdata,coeff,kind,level);
/********************************************************/
/*   Input parameters:                                  */
/*   INDATA: Input data file name that contains the     */
/*     effect-size estimate and its corresponding       */
/*     variance                                         */
/*   OUTDATA: Output data file name                     */
/*   COEFF:  Input data file for contrast if KIND is 3  */
/*           COEFF is empty if KIND is 1 or 2           */
/*   KIND: Type of comparison                           */
/*       KIND = 1:  Bonferroni                          */
/*       KIND = 2:  Schefee                             */
/*       KIND = 3:  A priori or planned comparison      */
/*   LEVEL: The level of confidence for the confidence  */
/*     interval                                         */
/*                                                      */
/*   The output data file contains the following        */
/*      variables:                                      */
/*   TYPE: Type of comparison                           */
/*   CONTRAST: Contrast estimator                       */
/*   LEVEL:  Level of confidence for the confidence     */
/*           interval                                   */
/*   LOWER:  Lower bound of the confidence interval     */
/*   UPPER:  Upper bound of the confidence interval     */
/********************************************************/
proc iml;
   reset nolog;
   reset storage=ch8.imlrout;
   use &indata;
   read all var{&varlist} into y;
   if (&kind =3) then do;
      use &coeff;
      read all var _num_ into x;
   end;
   start compute;
   n=nrow(y);
   if (&kind ^= 3) then do;
      x = j(n#(n-1)/2,n,0);
      k = 1;
      do i = 1 to n-1;
         do j = i+1 to n;
            x[k,j]=-1;
            x[k,i]=1;
            k=k+1;
         end;
      end;
   end;
   type=j(nrow(x),1,0);
   do i = 1 to nrow(x);
      type[i]=i;
   end;
   if (&kind = 1) then div=nrow(x);
   else if (&kind = 2) then div=min(nrow(x),n-1);
   else if (&kind = 3) then div=1;
   contrast = x*y[,1];
   tt = ((x##2)*y[,2])##.5;
   level = j(nrow(x),1,&level);
   lower = contrast+probit((1-level)/(2#div))#tt;
   upper = contrast+probit(1-(1-level)/(2#div))#tt;
   create &outdata var{type contrast level lower upper};
   append;
   close &outdata;
   finish compute;
   run compute;
reset storage=ch8.imlrout;
store module=(compute);
run;
quit;
%mend fixconst;


8.7 (pgs. 240-242) Output 8.3, Output 8.4, and Output 8.5

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\metabook\ch8\dataset";
data coeff;
data tmpin;
   set ch8.ex81outb;
   if (aggr ^= 4);
%let varlist = estimate variance;
%fixconst(tmpin,tmpout,coeff,1,0.95)
proc format;
   value aa 1 = "Physical vs. Evaluation  "
            2 = "Physical vs. Money Loss  "
            3 = "Evaluation vs. Money Loss";
proc print data=tmpout noobs;
   title;
   format type aa. contrast level lower upper 7.3;
quit;
data coeff;
%fixconst(tmpin,tmpout,coeff,2,0.95)
proc format;
   value aa 1 = "Physical vs. Evaluation  "
            2 = "Physical vs. Money Loss  "
            3 = "Evaluation vs. Money Loss";
proc print data=tmpout noobs;
   title;
   format type aa. contrast level lower upper 7.3;
quit;
data coeff;
   input c1 c2 c3;
cards;
0.5   0.5   -1
;
%fixconst(tmpin,tmpout,coeff,3,0.95)
proc format;
   value aa 1 = "Planned Comparison";
proc print data=tmpout noobs;
   format type aa. contrast level lower upper 7.3;
quit;



8.8 (pgs. 248-249) Example 8.3 and Output 8.6

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\metabook\ch8\dataset";
data ch8.ex83;
   set ch8.ex81;
   if (aggr = 1) then trt=aggr+prov-1;
   else if (aggr = 2) then trt=aggr+prov;
   else if (aggr = 3) then trt=aggr+prov+1;
%let varlist1 = aggr prov;
%let varlist2 = aggr prov aggr*prov;
%within(ch8.ex83,ch8.ex83out,eff,veff,trt,6);
proc format;
   value aa  1 = "Aggression               "
             2 = "Provocation              "
             3 = "Aggression*Provocation   "
             4 = "Within                   "
             5 = "  Physical and Provoked  "
             6 = "  Physical and Neutral   "
             7 = "  Evaluation and Provoked"
             8 = "  Evaluation and Neutral "
             9 = "  Money Loss and Provoked"
            10 = "  Money Loss and Neutral "
            11 = "Corrected Total          ";
proc print data=ch8.ex83out noobs;
   title;
   format source aa. qstat pvalue 7.3;
quit;



8.9 (pgs. 251-252) Data for Example 8.4 and Table 8.7

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\metabook\ch8\dataset";
data ch8.ex84;
   input study nn rr group reality paradigm interact;
   eff=.5*(log(1+rr)-log(1-rr));
   veff=1/(nn-3);
   drop study nn rr;
cards;
 1       48      .645      5      1      1      0
 2       40      .392      3      0      0      1
 3       40      .316      3      0      0      1
 4       40      .478      3      0      0      1
 5      431      .140      8.8    1      1      1
 6       86      .086      3.9    0      1      1
 7      183      .680      6      1      1      1
 8      200      .320      8.8    1      1      0
 9       32      .018      4      0      0      1
10      281      .188      6.2    1      1      1
11      130      .400     10      1      1      1
12       93     -.170     10.3    0      1      1
13       93      .326      3.5    0      1      1
14      275      .158     12      1      1      1
15       72      .316      4      0      1      1
16      231      .100     11      1      1      1
17      370      .040     11.21   1      1      0
18       72      .770      6      1      1      1
19      259      .194     10      1      1      1
20       41      .098      6.5    1      1      0
21      178      .300      5      1      1      1
22      702      .051     13      1      1      1
23       16      .290      4      0      1      1
24      450      .180      5      1      1      1
25       64      .370      4      0      0      1
26       64      .497      4      0      0      1
27       64     -.172      4      0      0      1
28       62      .431      4      0      0      1
29       62      .125      4      0      0      1
30       64      .101      4      0      0      1
31      110      .157      5.5    0      1      1
32      278      .470      8.7    1      1      1
33       71      .762      5      1      1      1
34      495      .190      9      1      1      1
35      147      .469      7      1      1      1
36       53      .201      3      1      1      0
37      135      .063      5      1      1      1
38      112      .120      6.2    1      1      1
39       68      .440      3.8    0      1      1
40       40      .212      5      0      1      1
41       80      .490      5.5    1      1      1
42      263      .178      8.2    1      1      0
43       90      .415      5      0      0      0
44      100      .200     20      1      1      1
45       86      .075      4      0      1      1
46       69     -.040      8.8    1      1      1
47      125      .049      5      0      1      1
48      176      .560      5      1      1      1
49      133     -.039      3.2    0      1      1
50      345      .320      3      1      1      1
51       66      .440      3      1      1      1
52      132      .811     11      1      1      1
53       83      .409      4.6    1      1      0
54      162      .320      4.5    0      1      1
55       28      .417      3      0      0      0
56       26      .052      3      0      0      0
57       28      .307      3      0      0      0
58       28      .134      3      0      0      0
59       28      .250      3      0      0      0
60       26      .362      3      0      0      0
61       64      .270      4      0      0      1
62       64      .101      4      0      0      1
63       68      .190      4      0      0      1
64       68     -.095      4      0      0      1
65       68      .088      4      0      0      1
66       64      .176      4      0      0      1
;
run;




8.10 (pgs. 271-272) Appendix 8.4

%macro fixreg(indata,outdata,level,eff,veff);
/********************************************************/
/*   Input Variables:                                   */
/*     INDATA:  Input data file name                    */
/*     The input data file contains only the regression */
/*     parameters, the effect-size estimates, and       */
/*     the estimated effect-size variances              */
/*     OUTDATA: Outdata file name                       */
/*     LEVEL: The level of confidence for the confidence*/
/*             interval                                 */
/*     EFF: Variable name for the effect-size estimate */
/*     VEFF: Variable name for the estimated effect-size*/
/*          variance                                    */
/*                                                      */
/*   Variables in output data file:                     */
/*      PARAM: 1=Interception                           */
/*             2=The first variable in the model        */
/*             3=The second variable in the model       */
/*             p+1= The pth variable in the model       */
/*      ESTIMATE: The regression coefficient estimates  */
/*      LEVEL: Level of confidence for the regression   */
/*             coefficient confidence intervals         */
/*      LOWER: Lower bound of the confidence interval   */
/*      UPPER: Upper bound of the confidence interval   */
/********************************************************/
data temp;
   set &indata;
   weight=1/&veff;
   drop &veff;
proc iml;
   reset nolog;
   reset storage=ch8.imlrout;
   use temp;
   start fixpara;
   read all var _num_ into dd;
   read all var {eff} into y;
   read all var {weight} into weight;
   one=j(nrow(dd),1,1);
   x=(one || dd[,1:ncol(dd)-2]);
   w=diag(weight);
   v=inv(w);
   ri=inv(sqrt(v));
   ys=ri*y;
   xs=ri*x;
   xspxs=xs`*xs;
   xspys=xs`*ys;
   b=inv(xspxs)*xspys;        /* regression coefficients */
   yhat=x*b;                  /* predicted values */
   resid=y-yhat;              /* residuals */
   sse=(ys-xs*b)`*(ys-xs*b);  /* residual sum of squares */
   dfe=nrow(x)-ncol(x);       /* error degrees of freedom */
   mse = sse / dfe;           /* residual mean squares */
   ncx=ncol(x);
   stdb=sqrt(vecdiag(inv(xspxs)));
   level=repeat(&level,ncx);
   lower=b+probit(.5-.5#level)#stdb;
   upper=b+probit(.5+.5#level)#stdb;
                              /* confidence interval for */
                              /* regression coefficients */
/******************************************************/
/*  Creat output data file                            */
/******************************************************/
   param=(1:ncx)`;
   estimate=b;
   create fixout1 var{param estimate level lower upper};
   append;
   close fixout1;
   finish fixpara;
   run fixpara;
   reset storage=ch8.imlrout;
   store module=(fixpara);
run;
quit;
data &outdata;
   set fixout1;
run;
%mend fixreg;



8.11 (pgs. 253-254) Output 8.7

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\metabook\ch8\dataset";
%fixreg(ch8.ex84,ch8.ex84out,.95,eff,veff);
proc format;
   value aa 1 = "Intercept"
            2 = "Group    "
            3 = "Reality  "
            4 = "Paradigm "
            5 = "Interact ";
proc print data=ch8.ex84out noobs;
   title;
   format param aa. estimate lower upper 6.3;
run;



8.12 (pgs. 256-257) Example 8.5 and Output 8.8

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\metabook\ch8\dataset";
data  bb;
   set ch8.ex84;
   weight = 1 / veff;
proc glm data=bb noprint outstat=aa;
   weight weight;
   model eff = group reality paradigm interact;
data cc dd;
   set aa;
   qstat=ss;
   if (_type_ = "ERROR") then output dd;
   if (_type_ = "SS1  ") then output cc;
   keep df qstat;
proc means data=cc noprint;
   var df qstat;
   output out=bb sum=df qstat;
data ch8.ex85out;
   source = _n_;
   set bb cc dd;
   pvalue=1-probchi(qstat,df);
   keep source df qstat pvalue;
proc format;
   value aa 1 = "Model     "
            2 = "  Group   "
            3 = "  Reality "
            4 = "  Paradigm"
            5 = "  Interact"
            6 = "Error     ";
proc print noobs;
   title;
   format source aa. qstat pvalue 8.4;
quit;



8.13 (pgs. 258) Example 8.5 and Output 8.9

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\metabook\ch8\dataset";
data aa bb;
   set ch8.ex85out;
   if (source = 4 or source = 5) then output aa;
   if (source > 3) then output bb;
   keep df qstat;
proc means data=aa;
   var df qstat;
   output out=cc sum=df qstat;
proc means data=bb;
   var df qstat;
   output out=dd sum=df qstat;
data;
   source=_n_;
   set cc dd;
   pvalue=1-probchi(qstat,df);
   keep source df qstat pvalue;
proc format;
   value aa 1 = "QCHANGE"
            2 = "QERROR ";
proc print noobs;
   title;
   format source aa. qstat pvalue 7.3;
run;



8.14 (pgs. 259-260) Example 8.5 and Output 8.10

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\metabook\ch8\dataset";
data  bb;
   set ch8.ex84;
   weight = 1 / veff;
proc glm data=bb noprint outstat=aa;
   weight weight;
   model eff = group reality;
data cc dd;
   set aa;
   qstat=ss;
   if (_type_ = "ERROR") then output dd;
   if (_type_ = "SS1  ") then output cc;
   keep df qstat;
proc means data=cc noprint;
   var df qstat;
   output out=bb sum=df qstat;
data ch8.ex85out3;
   source = _n_;
   set bb cc dd;
   pvalue=1-probchi(qstat,df);
   keep source df qstat pvalue;
proc format;
   value aa 1 = "Model    "
            2 = "  Group  "
            3 = "  Reality"
            4 = "Error    ";
proc print noobs;
   title;
   format source aa. qstat pvalue 8.4;
quit;



8.15 (pgs. 261-262) Example 8.6 and Output 8.11

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\metabook\ch8\dataset";
data;
   set ch8.ex84;
   weight = 1 / veff;
proc glm noprint outstat=aa;
   weight weight;
   model eff = group reality paradigm interact;
data;
   set aa;
   if (_type_ ~= "SS3  ");
proc means noprint;
   var ss;
   output out=bb sum=ssct;
data ch8.ex86;
   set aa;
   source=_n_-5;
   if (_type_ = "SS3  ");
   keep source ss;
data;
   set ch8.ex86;
   if (_n_ = 1) then set bb;
   vif = 1 / (1-ss/ssct);
   keep source vif;
proc format;
   value aa 1 = "Group   "
            2 = "Reality "
            3 = "Paradigm"
            4 = "Interact";
proc print noobs;
   format source aa. vif 5.3;
   title;
quit;






9.1 (pgs. 278-279) Example 9.1 and Output 9.1

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
data temp;
   set ch8.ex81;
   weight = 1 /veff;
proc glm data=temp noprint outstat=ch9.ex91out;
   class aggr;
   model eff=aggr;
   weight weight;
data ch9.ex91out;
   source="Error";
   set ch9.ex91out;
   if (_type_ = "ERROR");
   qstat=ss;
   pvalue=1-probchi(qstat,df);
   keep source qstat df pvalue;
proc print data=ch9.ex91out noobs;
   title;
   format qstat pvalue 8.4;
run;


9.2 (pgs. 280-281) Example 9.2 and Output 9.2

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
/* the following data steps are used to create a dummy  */
/* random effect variable call "OBSNUM"                 */
data temp;
   set ch8.ex81;
   obsnum=_n_;
/* The following data steps are used to create a        */
/* diagonal covariance matrix with the estimated        */
/* variance as the diagonal elements                    */
data gdatain;
   set temp;
   col=_n_;
   row=_n_;
   value=veff;
   keep col row value;
/* Estimating the random effect variance                */
proc mixed data=temp alpha=0.05 method=reml cl;
   class aggr obsnum;
   model eff = aggr;
   random obsnum/gdata=gdatain;
   make "covparms" out=ch9.ex92out;
/* Producing the OUTPUT                                 */
data ch9.ex92out;
   set ch9.ex92out;
   method="REML";
   estimate=est;
   level=1-alpha;
   keep method level upper lower estimate;
proc print data=ch9.ex92out noobs;
   title;
   format level 4.2 estimate upper lower 6.3;
run;


9.3 (pgs. 282) Example 9.3 and Output 9.3

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
data temp;
   set ch8.ex81;
   if (_n_ =1) then set ch9.ex92out;
   veff = veff + estimate;
%let vlist1 = aggr;
%let vlist2 = aggr;
%within(temp,ch9.ex93outa,eff,veff,aggr,3);
proc format;
   value aa  1 = "Between Groups       "
         2 = "Within Groups        "
         3 = "  Within (Physical)  "
         4 = "  Within (Evaluation)"
         5 = "  Within (Money Loss)"
         6 = "Corrected Total      ";
proc print data=ch9.ex93outa noobs;
   title;
   format source aa. qstat pvalue 7.3;
run;



9.4 (pgs. 23-284) Example 9.3 and Output 9.4

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
data temp;
   set ch8.ex81;
   if (_n_ = 1) then set ch9.ex92out;
   veff = veff + estimate;
   output;
   aggr = 4;
   output;
%let varlist = aggr;
%wavgeff(temp,ch9.ex93outb,.95);
proc format;
   value aa 1 = "Physical  "
            2 = "Evaluation"
            3 = "Money Loss"
            4 = "Over All  ";
proc print data=ch9.ex93outb noobs;
   var aggr estimate level lower upper;
   title;
   format aggr aa. estimate level lower upper 6.3;
run;
data temp;
   set ch8.ex81;
   if (_n_ = 1) then set ch9.ex92out2;
   veff = veff + lower;
   output;
   aggr = 4;
   output;
%let varlist = aggr;
%wavgeff(temp,ch9.ex93outc,.95);
proc print noobs;
   var aggr estimate level lower upper;
   format aggr aa. estimate level lower upper 6.3;
run;
data temp;
   set ch8.ex81;
   if (_n_ = 1) then set ch9.ex92out2;
   veff = veff + upper;
   output;
   aggr = 4;
   output;
%let varlist = aggr;
%wavgeff(temp,ch9.ex93outd,.95);
proc print noobs;
   var aggr estimate level lower upper;
   format aggr aa. estimate level lower upper 6.3;
run;



9.5 (pgs. 285) Example 9.4 and Output 9.5

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch9 "d:\research\metabook\ch9\dataset";
data tmpin;
   set ch9.ex93outb;
   if (aggr ^= 4);
%let varlist = estimate variance;
data coeff;
   input c1 c2 c3;
cards;
0.5   0.5   -1
;
%fixconst(tmpin,tmpout,coeff,3,0.95)
proc format;
   value aa 1 = "Planned Comparison";
proc print data=tmpout noobs;
   format type aa. contrast level lower upper 7.3;
quit;



9.6 (pgs. 287-288) Example 9.5 and Output 9.6

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
data;
   set ch8.ex81;
   weight = 1 / veff;
proc glm noprint outstat=ch9.ex95out;
   class aggr prov;
   model eff=aggr prov aggr*prov;
   weight weight;
data ch9.ex95out;
   source="Error";
   set ch9.ex95out;
   if (_type_ = "ERROR");
   qstat=ss;
   pvalue=1-probchi(qstat,df);
   keep source qstat df pvalue;
proc print data=ch9.ex95out noobs;
   title;
   format qstat pvalue 8.4;
run;



9.7 (pgs. 288-289) Example 9.6 and Output 9.7

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
data temp;
   set ch8.ex81;
   obsnum=_n_;
data gdatain;
   set temp;
   col=_n_;
   row=_n_;
   value=veff;
   keep col row value;
proc mixed data=temp alpha=0.05 method=reml cl;
   class aggr prov obsnum;
   model eff = aggr prov;
   random obsnum/gdata=gdatain;
   make "covparms" out=ch9.ex96out;
data ch9.ex96out;
   set ch9.ex96out;
   method="REML";
   estimate=est;
   level=1-alpha;
   keep method level upper lower estimate;
proc print data=ch9.ex96out noobs;
   title;
   format level 4.2 estimate upper lower 6.3;
run;



9.8 (pgs. 290-291) Example 9.7 and Output 9.8

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
data temp;
   set ch8.ex81;
   if (_n_ = 1) then set ch9.ex96out;
   veff = veff + estimate;
   if (aggr = 1) then trt=aggr+prov-1;
   else if (aggr = 2) then trt=aggr+prov;
   else if (aggr = 3) then trt=aggr+prov+1;
proc print data=temp;
%let varlist1 = aggr prov;
%let varlist2 = aggr prov aggr*prov;
%within(temp,ch9.ex97out,eff,veff,trt,6);
proc format;
   value aa  1 = "Aggression               "
             2 = "Provocation              "
             3 = "Aggression*Provocation   "
             4 = "Within                   "
             5 = "  Physical and Provoked  "
             6 = "  Physical and Neutral   "
             7 = "  Evaluation and Provoked"
             8 = "  Evaluation and Neutral "
             9 = "  Money Loss and Provoked"
            10 = "  Money Loss and Neutral "
            11 = "Corrected Total          ";
proc print data=ch9.ex97out noobs;
   title;
   format source aa. qstat pvalue 7.3;
quit;



9.9 (pgs. 292-293) Example 9.8 and Output 9.9

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
data temp;
   set ch8.ex84;
   weight = 1 / veff;
proc glm data=temp noprint outstat=ch9.ex98out;
   weight weight;
   model eff = group reality paradigm interact;
data ch9.ex98out;
   source = "Error";
   set ch9.ex98out;
   if (_type_ = "ERROR");
   qstat=ss;
   pvalue=1-probchi(qstat,df);
   keep source df qstat pvalue;
proc print data=ch9.ex98out noobs;
   title;
   format qstat pvalue 8.4;
quit;



9.10 (pgs. 293-294) Example 9.9 and Output 9.10

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
data temp;
   set ch8.ex84;
   obsnum=_n_;
data gdatain;
   set temp;
   col=_n_;
   row=_n_;
   value=veff;
   keep col row value;
proc mixed data=temp alpha=0.05 method=reml cl;
   class group reality paradigm interact obsnum;
   model eff = group reality paradigm interact;
   random obsnum/gdata=gdatain;
   make "covparms" out=ch9.ex99out;
data ch9.ex99out;
   set ch9.ex99out;
   method="REML";
   estimate=est;
   level=1-alpha;
   keep method level upper lower estimate;
proc print data=ch9.ex99out noobs;
   title;
   format level 4.2 estimate upper lower 6.3;
run;



9.11 (pgs. 295-296) Example 9.10 and Output 9.11

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch9 "d:\research\metabook\ch9\dataset";
libname ch8 "d:\research\metabook\ch8\dataset";
data temp;
   set ch8.ex84;
   if (_n_ = 1) then set ch9.ex99out;
   veff = veff + estimate;
   keep group reality paradigm interact eff veff;
%fixreg(temp,ch9.ex910out,.95,eff,veff);
proc format;
   value aa 1 = "Intercept"
            2 = "Group    "
            3 = "Reality  "
            4 = "Paradigm "
            5 = "Interact ";
proc print data=ch9.ex910out noobs;
   title;
   format param aa. estimate lower upper 6.3;
run;



9.12 (pgs. 296-298) Example 9.11 and Output 9.12

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
data temp;
   set ch8.ex84;
   if (_n_ = 1) then set ch9.ex99out2;
   weight = 1 / (veff+estimate);
proc glm data=temp noprint outstat=aa;
   weight weight;
   model eff = reality group paradigm interact;
data cc dd;
   set aa;
   qstat=ss;
   if (_type_ = "SS1  " and (_source_  = "PARADIGM"
      or _source_ = "INTERACT")) then output cc;
   if ((_type_ = "SS1  " and (_source_  = "PARADIGM" or
      _source_ = "INTERACT")) or _type_ = "ERROR") then output dd;
   keep df qstat;
proc means data=cc noprint;
   var df qstat;
   output out=aa sum=df qstat;
proc means data=dd noprint;
   var df qstat;
   output out=bb sum=df qstat;
data ch9.ex911out;
   source=_n_;
   set aa bb;
   pvalue=1-probchi(qstat,df);
   keep source df qstat pvalue;
proc format;
   value aa 1 = "QCHANGE"
            2 = "QERROR ";
proc print data=ch9.ex911out noobs;
   title;
   format source aa. qstat pvalue 7.3;
run;



9.13 (pgs. 298-299) Example 9.11 and Output 9.13

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch9 "d:\research\metabook\ch9\dataset";
libname ch8 "d:\research\metabook\ch8\dataset";
data temp;
   set ch8.ex84;
   if (_n_ = 1) then set ch9.ex99out;
   veff = veff + estimate;
   keep group reality eff veff;
%fixreg(temp,ch9.ex912out,.95,eff,veff);
proc format;
   value aa 1 = "Intercept"
            2 = "Group    "
            3 = "Reality  ";
proc print data=ch9.ex912out noobs;
   title;
   format param aa. estimate lower upper 6.3;
run;



9.14 (pgs. 300-301) Example 9.12 and Output 9.14

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch8 "d:\research\metabook\ch8\dataset";
libname ch9 "d:\research\metabook\ch9\dataset";
data temp;
   set ch8.ex84;
   if (_n_ = 1) then set ch9.ex99out2;
   weight = 1 / (veff+estimate);
proc glm data=temp noprint outstat=aa;
   weight weight;
   model eff = reality group paradigm interact;
data temp;
   set aa;
   if (_type_ ^= "SS3  ");
proc means data=temp noprint;
   var ss;
   output out=bb sum=ssct;
data ch9.ex912;
   set aa;
   source=_n_-5;
   if (_type_ = "SS3  ");
   keep source ss;
data temp;
   set ch9.ex912;
   if (_n_ = 1) then set bb;
   vif = 1 / (1-ss/ssct);
   keep source vif;
proc format;
   value aa 1 = "Reality "
            2 = "Group   "
            3 = "Paradigm"
            4 = "Interact";
proc print data=temp noobs;
   format source aa. vif 5.3;
   title;
quit;



10.1 (pgs. 309) Table 10.2 and Example 10.1

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch10 "d:\metabook\ch10\dataset";
data ch10.ex101;
 input studyid $ 1-25  nc mc sc ne1 me1 se1 ne2 me2 se2 ne3 me3 se3;
cards;
George & Marlatt, 1986       8    2.41    0.78    8    2.57    0.69    8    3.17    0.61    8    2.86    0.77
Gustafson, 1986             10    2.48    1.60   10    1.23    1.40   10    3.68    2.68   10    3.22    2.30
Gustafson, 1991             15    2.93    3.20   15    1.50    2.76    .     .        .    15    2.73    2.52
Lang et al., 1975           12    3.59    1.59   12    5.00    2.32   12    3.80    2.53   12    5.06    2.65
Pihl & Zacchi, 1986         16    2.48    0.58   16    2.78    0.79    .     .        .    16    2.37    0.74
Ratliff, 1984                6    2.40    0.94    6    2.70    1.04    6    2.60    1.06    6    3.00    0.92
Zeichner & Pihl, 1979       24    1.78    0.48   24    1.98    0.42    .      .       .    24    4.24    0.21
Zeichner & Pihl, 1980       24    1.68    0.26   24    2.01    0.41    .      .       .    24    4.19    0.16
run;



10.2 (pgs. 324-325) Appendix 10.1

%macro mtfmax(indata,outdata);
/********************************************************/
/*  INDATA: Input data file name                        */
/*                                                      */
/*  NELIST:  List of experimental group sample sizes    */
/*  SELIST:  List of experimental group standard        */
/*              deviations                              */
/*  NCLIST:  Control group sample size                  */
/*  SCLIST:  Control group standard deviation           */
/*                                                      */
/*  OUTDATA:  Output data file name                     */
/*    Output data file contains five variables:         */
/*    STUDYID:  Study identification number             */
/*    FMAX:  Fmax statistic                             */
/*    NUMERDF:  Numerator degrees of freedom for Fmax   */
/*           statistic                                  */
/*    DENOMDF:  Denominator degrees of freedom for Fmax */
/*           statistic                                  */
/*    PVALUE:  p-value for Fmax statistic               */
/********************************************************/
proc iml;
   reset nolog;
   reset storage=ch10.imlrout;
   use &indata;
   read all var {&nelist} into nee;
   read all var {&nclist} into ncc;
   read all var {&selist} into see;
   read all var {&sclist} into scc;
   ncc = repeat(ncc,1,ncol(nee));
   scc = repeat(scc,1,ncol(see));
   nrowcc=nrow(ncc);
   studyid = (1:nrow(ncc))`;
/********************************************************/
/*  Compute the F Test Statistics                       */
/********************************************************/
   start compute;
   vee = see # see;
   vc = scc # scc;
   fvalue = vee / vc;
   df1 = nee-1;
   df2 = ncc-1;
   tmp=(nee = .);
   do i = 1 to ncol(fvalue);
      do j = 1 to nrow(fvalue);
         if ((fvalue[j,i] < 1) & (fvalue[j,i] ^= .)) then
         do;
            fvalue[j,i]=1/fvalue[j,i];
            df1[j,i]=ncc[j,i]-1;
            df2[j,i]=nee[j,i]-1;
         end;
         if (tmp[j,i]) then df2[j,i]=.;
      end;
   end;
/********************************************************/
/*  Compute FMAX                                        */
/********************************************************/
   fmax=j(nrow(fvalue),1,0);
   do j = 1 to nrow(fvalue);
      fmax[j]=max(fvalue[j,]);
   end;
   index=j(nrow(fvalue),1,0);
   do i = 1 to nrow(fvalue);
      do j = 1 to ncol(fvalue);
      if(fmax[i]=fvalue[i,j]) then
         do;
         index[i]=(i-1)*ncol(fvalue)+j;
         end;
      end;
   end;
   numerdf = df1[index];
   denomdf = df2[index];
   pvalue = 1 - probf(fmax,numerdf,denomdf);
/********************************************************/
/*  Produce the Output                                  */
/********************************************************/
   create &outdata var{studyid fmax numerdf denomdf pvalue};
   append;
   close &outdata;
   finish compute;
   run compute;
reset storage=ch10.imlrout;
store module=(compute);
run;
quit;
%mend mtfmax;


10.3 (pgs. 310) Output 10.1 and Example 10.1

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch10 "d:\metabook\ch10\dataset";
%let nelist = ne1 ne2 ne3;
%let nclist = nc;
%let selist = se1 se2 se3;
%let sclist = sc;
%mtfmax(ch10.ex101,ch10.ex101out);
proc format;
   value aa 1 = "Giancola & Zeichner, 1995"
         2 = "Gustafson, 1986          "
         3 = "Gustafson, 1991          "
         4 = "Lang et al., 1975        "
         5 = "Pihl & Zacchi, 1986      "
         6 = "Ratliff, 1984            "
         7 = "Zeichner & Pihl, 1979    "
         8 = "Zeichner & Pihl, 1980    ";
proc print data=ch10.ex101out noobs;
   title;
   format studyid aa. fmax pvalue 6.3;
run;



10.4 (pgs. 326-330) Appendix 10.2

%macro multrt(indata,method);
/********************************************************/
/*  INDATA:  Input data set                             */
/*                                                      */
/*  NELIST:  List of experimental group sample sizes    */
/*  MELIST:  List of experimental group means           */
/*  SELIST:  List of experimental group standard        */
/*           deviations                                 */
/*  NCLIST: Control group sample size                   */
/*  MCLIST: Control group mean                          */
/*  SCLIST: Control group standard deviation            */
/*  METHOD:                                             */
/*    METHOD = 1: Control group variance                */
/*    METHOD = 2: Pooled variance                       */
/*                                                      */
/*  Output Data Files                                   */
/*    (1) DDOUT:  Response vector for the model         */
/*    (2) XXOUT:  Model matrix                          */
/*    (3) VAROUT: Model variance-covariance matrix      */
/*    (4) BB:  Effect-size estimate                     */
/*        SOURCE: SOURCE = k for the kth treatment      */
/*        EFFECT: Effect-size estimate for each         */
/*                treatment                             */
/*        LOWER: Lower bound of 95% confidence          */
/*                interval for each treatment           */
/*        UPPER: Upper bound of 95% confidence          */
/*                interval for each treatment           */
/*    (5) COVBBOUT:  Variance-covariance matrix for     */
/*                each treatment                        */
/*    (6) QERROR:  Q statistic for the hypothesis       */
/*                that all effect-sizes are equal       */
/*        SOURCE:  SOURCE = 1 for QERROR                */
/*        QSTAT:  Q statistic                           */
/*        DF:     Degrees of freedom for Q statistic    */
/*        PVALUE:  p-value for Q statistic              */
/********************************************************/
proc iml;
   reset nolog;
   reset storage=ch10.imlrout;
   use &indata;
   read all var {&nelist} into nee;
   read all var {&melist} into mee;
   read all var {&selist} into see;
   read all var {&nclist &mclist &sclist};
   tmp1=j(nrow(mee),ncol(mee),0);
/********************************************************/
/*  Compute the effect-size for each treatment and      */
/*  study                                               */
/********************************************************/
   if (&method = 2) then do;
      sp = j(nrow(nee),1,0);
      np = j(nrow(nee),1,0);
      do i = 1 to nrow(nee);
       do j = 1 to ncol(nee);
        if (nee[i,j] ^= .) then do;
          np[i]=np[i]+nee[i,j]-1;
          sp[i]=sp[i]+see[i,j]*see[i,j]*(nee[i,j]-1);
        end;
       end;
       np[i] = nc[i]+np[i]-1;
       sp[i] = sp[i]+sc[i]*sc[i]*(nc[i]-1);
       sp[i] = sp[i]/np[i];
      end;
     end;

     do j = 1 to ncol(mee);
       if (&method = 1) then
          tmp1[,j] = (mee[,j]-mc) / sc;
       if (&method = 2) then
          tmp1[,j] = (mee[,j]-mc) / sp;
     end;
/********************************************************/
/* Compute the estimated large-sample covariance for    */
/* each study                                           */
/********************************************************/
   vdd=j(ncol(mee)*nrow(mee),ncol(mee),.);
   do k = 1 to nrow(mee);
      do i = 1 to ncol(mee);
         do j = 1 to ncol(mee);
          if (&method=1) then do;
            vdd[(k-1)*ncol(mee)+i,j] =
               (1+0.5*tmp1[k,i]*tmp1[k,j])/nc[k];
            end;
          else do;
            vdd[(k-1)*ncol(mee)+i,j] =
               1/nc[k]+(0.5*tmp1[k,i]*tmp1[k,j])/np[k];
            end;
            if (i = j) then vdd[(k-1)*ncol(mee)+i,j]
               = vdd[(k-1)*ncol(mee)+i,j] + 1/nee[k,i];
         end;
      end;
   end;
start datamod;
/********************************************************/
/* Create the effect-size vector DD                     */
/********************************************************/
   k=0;
   do i = 1 to ncol(tmp1);
      do j = 1 to nrow(tmp1);
         if (tmp1[j,i] = .) then k=k+1;
      end;
   end;
   var=j(nrow(vdd)-k,nrow(vdd)-k,0);
   index1=j(k,3,0);
   index2=j(nrow(vdd)-k,1,0);
   k1=1;
   k2=1;
   do I = 1 to nrow(tmp1);
      do J = 1 to ncol(tmp1);
         if (tmp1[i,j] = .) then
         do;
         index1[k1,1]=i;
         index1[k1,2]=j;
         index1[k1,3]=(i-1)*ncol(tmp1)+j;
         k1=k1+1;
         end;
      if (tmp1[i,j] ^= .) then
         do;
         index2[k2,1]=(i-1)*ncol(tmp1)+j;
         k2=k2+1;
         end;
      end;
   end;
   dd=remove(tmp1,index1[,3]);
   dd=dd`;
/*********************************************************/
/* Create the model matrix XX                            */
/*********************************************************/
   k=ncol(mee);
   indstep = j(1,k,1);
   do i = 1 to k;
      indstep[i]=i;
   end;
   xx=repeat(i(k),nrow(mee),1);
   xx=xx[index2 , indstep];
/*********************************************************/
/* Create the variance-covariance matrix VAR             */
/*********************************************************/
   rho=vdd[index2 , indstep];
   m=1;
   do I = 1 to nrow(rho);
      if (i = m) then
         do;
         k = I;
         index = I;
         do J = 1 to ncol(rho);
            if (rho[i,j] ^= .) then
               do;
               var[i,k] = rho[i,j];
               m=m+1;
               k=k+1;
               end;
            end;
         end;
      else
         do;
         k=index;
         do J = 1 to ncol(rho);
            if (rho[i,j] ^= .) then
               do;
               var[i,k] = rho[i,j];
               k=k+1;
               end;
            end;
         end;
   end;
/********************************************************/
/* Produce the OUTPUT for the effect-size vector DD,    */
/* the model matrix XX, and the variance-covariance     */
/* matrix VAR                                           */
/********************************************************/
   create ddout from dd;
   append from dd;
   close ddout;
   create xxout from xx;
   append from xx;
   close xxout;
   create varout from var;
   append from var;
   close var;
finish datamod;
reset noprint;
run datamod;
reset print;
start compute;
/********************************************************/
/* Compute the generalized least square estimator:      */
/* (1) Effect-size estimates                            */
/* (2) Variance-covariance matrix of the effect-size    */
/*     estimates                                        */
/* (3) 95% confidence interval for effect-size          */
/*     estimate for each treatment                      */
/* (4) Test statistic for the hypothesis that all       */
/*     effect sizes are equal                           */
/********************************************************/
   covbb=inv(xx`*inv(var)*xx);
   create covbbout from covbb;
   append from covbb;
   close covbbout;
   bb=covbb*xx`*inv(var)*dd;
   aa=i(ncol(xx));
   aaa=j(ncol(xx),1,1);
   lower=aa`*bb+probit(0.025)*diag(sqrt(aa`*covbb*aa))*aaa;
   upper=aa`*bb+probit(0.975)*diag(sqrt(aa`*covbb*aa))*aaa;
   estimate=bb;
   source = 1: ncol(see);
   create bb var{source estimate lower upper};
   append;
   close bb;
   qstat=dd`*inv(var)*dd-bb`*covbb*bb;
   df=nrow(xx)-ncol(xx);
   pvalue = 1 - probchi(qstat,df);
   Source = 1;
   create qerror var{source qstat df pvalue};
   append;
   close qstat;
   finish compute;
reset noprint;
run compute;
run;
quit;
%mend multrt;



10.5 (pgs. 312) Example 10.1, Output 10.3 and Output 10.4

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch10 "d:\metabook\ch10\dataset";
%let melist = me1 me2 me3;
%let nelist = ne1 ne2 ne3;
%let selist = se1 se2 se3;
%let nclist = nc;
%let mclist = mc;
%let sclist = sc;
%multrt(ch10.ex101,2);
proc format;
   value aa 1 = "QERROR";
   value bb 1 = "Placebo    "
            2 = "Antiplacebo"
            3 = "Alcohol    ";
proc print data=qerror noobs;
   title;
   format source aa.;
proc print data=bb noobs;
   format source bb.;
run;



10.6 (pgs. 314) Example 10.1 and Output 10.5

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch10 "d:\metabook\ch10\dataset";
data temp;
   set ch10.ex101;
   sp = sqrt(((nc-1)*sc*sc+(ne1-1)*se1*se1)/(nc+ne1-2));
   eff = (me1-mc)/sp;
   veff = (ne1+nc)/(ne1*nc)+(eff*eff)/(2*(ne1+nc-2));
   source = 1;
   output;
   sp = sqrt(((nc-1)*sc*sc+(ne2-1)*se2*se2)/(nc+ne2-2));
   eff = (me2-mc)/sp;
   veff = (ne2+nc)/(ne2*nc)+(eff*eff)/(2*(ne2+nc-2));
   source = 2;
   output;
   sp = sqrt(((nc-1)*sc*sc+(ne3-1)*se3*se3)/(nc+ne3-2));
   eff = (me3-mc)/sp;
   veff = (ne3+nc)/(ne3*nc)+(eff*eff)/(2*(ne3+nc-2));
   source = 3;
   output;
   keep source eff veff;
%let varlist = source;
%wavgeff(temp,tmpout,.95);
proc format;
   value aa 1 = "Placebo    "
            2 = "Antiplacebo"
            3 = "Alcohol    ";
proc print data=tmpout noobs;
   var source estimate level lower upper;
   format source aa. estimate level lower upper 6.3;
run;



10.7 (pgs. 318-319) Table 10.4 and Example 10.2

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch10 "d:\research\metabook\ch10\dataset";
data ch10.ex102;
   input studyid $ 1-34 vne vnc vgu mgu;
   mne=vne;
   mnc=vnc;
   if (_n_ = 34) then do;
      mne=50;
      mnc=50;
   end;
   if (vgu = .) then do;
      vne=.;
      vnc=.;
   end;
   if (mgu = .) then do;
      mne=.;
      mnc=.;
   end;
cards;
Alderman & Powers, 1980 Study 1    28      22      0.22      .
Alderman & Powers, 1980 Study 2    39      40      0.09      .
Alderman & Powers, 1980 Study 3    22      17      0.14      .
Alderman & Powers, 1980 Study 4    48      43      0.14      .
Alderman & Powers, 1980 Study 5    25      74     -0.01      .
Alderman & Powers, 1980 Study 6    37      35      0.14      .
Alderman & Powers, 1980 Study 7    24      70      0.18      .
Alderman & Powers, 1980 Study 8    16      19      0.01      .
Evans & Pike, 1973 Study 1        145     129      0.13      0.12
Evans & Pike, 1973 Study 2         72     129      0.25      0.06
Evans & Pike, 1973 Study 3         71     129      0.31      0.09
Laschewer, 1986                    13      14      0.00      0.07
Roberts & Oppenheim, 1966 Study 1  43      37      0.01      .
Roberts & Oppenheim, 1966 Study 2  19      13      0.67      .
Roberts & Oppenheim, 1966 Study 3  16      11     -0.38      .
Roberts & Oppenheim, 1966 Study 4  20      12     -0.24      .
Roberts & Oppenheim, 1966 Study 5  39      28      0.29      .
Roberts & Oppenheim, 1966 Study 6  38      25      .        0.26
Roberts & Oppenheim, 1966 Study 7  18      13      .       -0.41
Roberts & Oppenheim, 1966 Study 8  19      13      .        0.08
Roberts & Oppenheim, 1966 Study 9  37      22      .        0.39
Roberts & Oppenheim, 1966 Study 10 19      11      .       -0.53
Roberts & Oppenheim, 1966 Study 11 17      13      .        0.13
Roberts & Oppenheim, 1966 Study 12 20      12      .        0.26
Roberts & Oppenheim, 1966 Study 13 20      13      .        0.47
Zuman, 1988, Study 1               21      34      0.54      0.57
Zuman, 1988, Study 2               16      17      0.13      0.48
Burke, 1986 Study 1                25      25      0.50      .
Burke, 1986 Study 2                25      25      0.74      .
Coffin, 1987                        8       8     -0.23      0.33
Davis, 1985                        22      21      0.13      0.13
Frankel, 1960                      45      45      0.13      0.34
Kintisch, 1979                     38      38      0.06      .
Whitla, 1962                       52      52     0.09      -0.11
Curran, 1988 Study 1               21      17     -0.10      -0.08
Curran, 1988 Study 2               24      17     -0.14      -0.29
Curran, 1988 Study 3               20      17     -0.16      -0.34
Curran, 1988 Study 4               20      17     -0.07      -0.06
Dear, 1958                         60     526     -0.02      0.21
Dyer, 1953                        225     193      0.06      0.17
French, 1955 Study 1              110     158      0.06       .
French, 1955 Study 2              161     158      .        0.20
FTC, 1978                         192     684      0.15      0.03
Keefauver, 1976                    16      25      0.17     -0.19
Lass, 1961                         38      82      0.02      0.10
Reynolds & Oberman, 1987           93      47     -0.04      0.60
Teague, 1992                       10      15      0.40      .
proc print noobs;
   title;
run;



10.8 (pgs. 331-334) Appendix 10.3

%macro mulend(indata);
/********************************************************/
/*  INDATA:  Input data set                             */
/*                                                      */
/*  MLIST:  List of effect size estimates for each end  */
/*          point                                       */
/*  NLIST1: List of control group sample sizes for each */
/*          end point                                   */
/*  NLIST2: List of experimental group sample sizes for */
/*          each end point                              */
/*  CORR: List of imputed correlationd between each     */
/*          pair of endpoints                           */
/*                                                      */
/*  Output Data Files                                   */
/*    (1) DDOUT:  Response vector for the model         */
/*    (2) XXOUT:  Model matrix                          */
/*    (3) VAROUT: Model variance-covariance matrix      */
/*    (4) BB:  Effect-size estimate                     */
/*        SOURCE: SOURCE = p for the pth end point      */
/*        EFFECT: Effect-size estimate for each         */
/*                end point                             */
/*        LOWER: Lower bound of 95% confidence          */
/*                interval for each end point */
/*        UPPER: Upper bound of 95% confidence          */
/*                interval for each end point */
/*    (5) COVBBOUT:  Variance-covariance matrix for     */
/*                each end point */
/*    (6) QERROR:  Q statistic for the hypothesis       */
/*                that all effect-sizes are equal       */
/*        SOURCE:  SOURCE = 1 for QERROR                */
/*        QSTAT:  Q statistic                           */
/*        DF:     Degrees of freedom for Q statistic    */
/*        PVALUE:  p-value for Q statistic              */
/********************************************************/
proc iml;
   reset nolog;
   reset storage=ch10.imlrout;
   use &indata;
   read all var {&mlist} into effmean;
   read all var {&nlist1} into nendc;
   read all var {&nlist2} into nendt;
/********************************************************/
/*  Compute the effect-size for each end point and      */
/*  study                                               */
/********************************************************/
    tmp1=j(ncol(effmean)*nrow(effmean),1,.);
    do i = 1 to nrow(effmean);
       tmp1[2*i-1]=effmean[i,1];
       tmp1[2*i]=effmean[i,2];
    end;
/********************************************************/
/* Compute the estimated large-sample covariance for    */
/* each study under equal variance covariance assumption*/
/********************************************************/
   vdd=j(ncol(effmean)*nrow(effmean),ncol(effmean),.);
   do k = 1 to nrow(effmean);
      do i = 1 to ncol(effmean);
         do j = 1 to ncol(effmean);
           if (i = j) then
              do;
               vdd[(k-1)*ncol(effmean)+i,j] = 1/nendc[k,i]
               +1/nendt[k,i]+(0.5*effmean[k,i]
               *effmean[k,i])/(nendc[k,i]+nendt[k,i]);
              end;
           else
              do;
               vdd[(k-1)*ncol(effmean)+i,j] = (1/nendc[k,i]
               +1/nendt[k,i])*&corr+(0.5*effmean[k,i]
               *effmean[k,j]*&corr*&corr)
               /(nendc[k,i]+nendt[k,i]);
              end;
         end;
      end;
   end;
start datamod;
/********************************************************/
/* Create the effect-size vector DD                     */
/********************************************************/
   k=0;
   do i = 1 to ncol(tmp1);
      do j = 1 to nrow(tmp1);
         if (tmp1[j,i] = .) then k=k+1;
      end;
   end;
   var=j(nrow(vdd)-k,nrow(vdd)-k,0);
   index1=j(k,3,0);
   index2=j(nrow(vdd)-k,1,0);
   k1=1;
   k2=1;
   do I = 1 to nrow(tmp1);
      do J = 1 to ncol(tmp1);
         if (tmp1[i,j] = .) then
         do;
         index1[k1,1]=i;
         index1[k1,2]=j;
         index1[k1,3]=(i-1)*ncol(tmp1)+j;
         k1=k1+1;
         end;
      end;
   end;
   dd=remove(tmp1,index1[,3]);
   dd=dd`;
/*********************************************************/
/* Create the model matrix XX                            */
/*********************************************************/
   k=ncol(effmean);
   xx=i(k);
   xx1=repeat(xx,nrow(effmean),1);
   k=ncol(xx1);
   do i = 1 to k;
     xx2=remove(xx1[,i],index1[,3]);
     if (i=1) then xx=xx2`;
     else xx = xx || (xx2`);
   end;
/*********************************************************/
/* Create the variance-covariance matrix VAR             */
/*********************************************************/
   k = ncol(vdd);
   do i = 1 to k;
     rho1=remove(vdd[,i],index1[,3]);
     if (i = 1) then rho=rho1`;
     else rho=rho||(rho1`);
   end;
   m=1;
   do I = 1 to nrow(rho);
      if (i = m) then
         do;
         k = I;
         index = I;
         do J = 1 to ncol(rho);
            if (rho[i,j] ^= .) then
               do;
               var[i,k] = rho[i,j];
               m=m+1;
               k=k+1;
               end;
            end;
         end;
      else
         do;
         k=index;
         do J = 1 to ncol(rho);
            if (rho[i,j] ^= .) then
               do;
               var[i,k] = rho[i,j];
               k=k+1;
               end;
            end;
         end;
   end;
/********************************************************/
/* Produce the OUTPUT for the effect-size vector DD,    */
/* the model matrix XX, and the variance-covariance     */
/* matrix VAR                                           */
/********************************************************/
   create ddout from dd;
   append from dd;
   close ddout;
   create xxout from xx;
   append from xx;
   close xxout;
   create varout from var;
   append from var;
   close var;
finish datamod;
reset noprint;
run datamod;
reset print;
start compute;
/********************************************************/
/* Compute the generalized least square estimator:      */
/* (1) Effect-size estimates                            */
/* (2) Variance-covariance matrix of the effect-size    */
/*     estimates                                        */
/* (3) 95% confidence interval for effect-size          */
/*     estimate for each end point */
/* (4) Test statistic for the hypothesis that all       */
/*     effect sizes are equal                           */
/********************************************************/
   covbb=inv(xx`*inv(var)*xx);
   create covbbout from covbb;
   append from covbb;
   close covbbout;
   bb=covbb*xx`*inv(var)*dd;
   aa=i(ncol(xx));
   aaa=j(ncol(xx),1,1);
   lower=aa`*bb+probit(0.025)*diag(sqrt(aa`*covbb*aa))*aaa;
   upper=aa`*bb+probit(0.975)*diag(sqrt(aa`*covbb*aa))*aaa;
   estimate=bb;
   source = 1: ncol(effmean);
   create bb var{source estimate lower upper};
   append;
   close bb;
   qstat=dd`*inv(var)*dd-bb`*covbb*bb;
   df=nrow(xx)-ncol(xx);
   pvalue = 1 - probchi(qstat,df);
   Source = 1;
   create qerror var{source qstat df pvalue};
   append;
   close qstat;
   finish compute;
reset noprint;
run compute;
run;
quit;
%mend mulend;



10.9 (pgs. 320) Example 10.2, Output 10.6, and Output 10.7

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch10 "d:\research\metabook\ch10\dataset";
%let mlist = vgu mgu;
%let nlist1 = vnc mnc;
%let nlist2 = vne mne;
%let corr = 0.66;
%mulend(ch10.ex102);
proc format;
   value aa 1 = "QERROR";
   value bb 1 = "Verbal"
            2 = "Math  ";
proc print data=bb noobs;
   format source bb. estimate lower upper 6.3;
proc print data=qerror noobs;
   format source aa. qstat pvalue 6.3;
run;



10.10 (pgs. 321) Example 10.2 and Output 10.8

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch10 "d:\metabook\ch10\dataset";
data temp;
   set ch10.ex102;
   eff = vgu;
   veff = 1/vnc+1/vne+0.5*(vgu*vgu)/(vnc+vne);
   source = 1;
   output;
   eff = mgu;
   veff = 1/mne+1/mnc+0.5*(mgu*mgu)/(mne+mnc);
   source = 2;
   output;
   keep source eff veff;
%let varlist = source;
%wavgeff(temp,tmpout,.95);
proc format;
   value aa 1 = "Verbal"
            2 = "Math  ";
proc print data=tmpout noobs;
   var source estimate level lower upper;
   format source aa. estimate level lower upper 6.3;
run;


11.1 (pgs. 348) Table 11.6

options nodate nocenter pagesize=54 linesize=132 pageno=1;
libname ch11 "d:\metabook\ch11\dataset";
data ch11.ex1;
   input study $ 1-28 nn rr context;
   eff = 0.5*log((1+rr)/(1-rr));
   veff = 1/(nn-3);
cards;
Shemberg et al. (1968)       45      .59      1
Knott (1970)                 18      .51      1
Williams et al. (1967)       60      .43      1
Giancola & Zeichner (1995a)  79      .42      1
Wolfe & Baron (1971)         40      .35      1
Scheier et al. (1978)        63      .34      1
Hammock & Richardson (1992) 196      .28      1
Giancola & Zeichner (1995b)  60      .27      1
Hartman (1969)               57      .25      1
Bushman (1995)              296      .23      1
Leibowitz (1968)             38      .23      1
Pihl et al. (1997)          114      .20      1
Cleare & Bond (1995)         48      .15      1
Larsen et al. (1972)         78      .15      1
Muntaner et al. (1990)       85     -.02      1
Boone & Flint (1988)         53      .61      2
Lange et al. (1995)          49      .52      2
Maiuro et al. (1988)         67      .50      2
Selby (1984)                100      .46      2
Buss & Perry (1992)          98      .45      2
Gunn & Gristwood (1975)      30      .45      2
Maiuro et al. (1988)         68      .44      2
Boone & Flint (1988)         52      .44      2
Maiuro et al. (1988)         58      .41      2
Lothstein & Jones (1978)     61      .40      2
Renson et al. (1978)         51      .39      2
Stanford  et al. (1995)     214      .38      2
Archer et al. (1995)        100      .33      2
Syverson & Romney (1985)     60      .27      2
run;
proc print;
run;


11.2 (pgs. 349) Output 11.1

options nodate nocenter pagesize=54 linesize=132 pageno=1;
libname ch11 "d:\metabook\ch11\dataset";
data;
   set ch11.ex1;
   lower = eff + probit(0.025)*sqrt(veff);
   upper = eff + probit(0.975)*sqrt(veff);
   lower = (exp(2*lower)-1)/(exp(2*lower)+1);
   upper = (exp(2*upper)-1)/(exp(2*upper)+1);
proc sort;
   by context eff;
proc format;
   value aa 1 = "Laboratory"
            2 = "Field     ";
proc timeplot;
   plot lower="[" rr="*" upper="]"/
      overlay hiloc ref=0 refchar="0";
   id study context;
   format context aa.;
   title;
run;


11.3 (pgs. 350-351) Output 11.2

options nodate nocenter pagesize=54 linesize=132 pageno=1;
libname ch11 "d:\metabook\ch11\dataset";
data;
   set ch11.ex1;
   weight = 1/ veff;
   dummy = 1;
proc glm noprint outstat=ch11.ex1b;
   class dummy;
   model eff = dummy / noint;
   weight weight;
data ch11.ex1b;
   source = "ERROR";
   set ch11.ex1b;
   if (_type_ = "ERROR");
   qstat = ss;
   pvalue = 1 - probchi(qstat,df);
   keep source df qstat pvalue;
proc print noobs;
   title;
   format qstat pvalue 6.3;
run;



11.4 (pgs. 351) Output 11.3

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch11 "d:\metabook\ch11\dataset";
data;
   set ch11.ex1;
   weight = 1 /veff;
proc glm;
   class context;
   model eff = context;
   weight weight;
quit;



11.5 (pgs. 352) Output 11.4

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch11 "d:\metabook\ch11\dataset";
data;
   set ch11.ex1;
   stdeff = eff / sqrt(veff);
proc univariate noprint;
   var stdeff;
   output out=outa min=mineff max=maxeff;
proc print data=outa noobs;
   title;
   var mineff maxeff;;
   format maxeff mineff 7.4;
quit;



11.6 (pgs. 354) Output 11.5

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch11 "d:\metabook\ch11\dataset";
proc univariate data= ch11.ex1 plot;
   var eff;
run;



11.7 (pgs. 355) Output 11.6

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch11 "d:\metabook\ch11\dataset";
%let varlist1 = context;
%let varlist2 = context;
%within(ch11.ex1,ch11.out1106,eff,veff,context,2);
proc format;
   value aa  1 = "Between Groups       "
             2 = "Within Groups        "
             3 = "  Within (Laboratory)"
             4 = "  Within (Field)     "
             5 = "Corrected Total      ";
proc print noobs;
   title;
   format source aa. qstat pvalue 7.3;
quit;


11.8 (pgs. 356) Output 11.7

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch11 "d:\metabook\ch11\dataset";
data temp;
   set ch11.ex1;
   output;
   context = 3;
   output;
%let varlist = context;
%wavgeff(temp,ch11.out1107,.95);
data;
   set ch11.out1107;
   estimate=(exp(2*estimate)-1)/(exp(2*estimate)+1);
   lower=(exp(2*lower)-1)/(exp(2*lower)+1);
   upper=(exp(2*upper)-1)/(exp(2*upper)+1);
   rename fact1=context;
proc format;
   value aa 1 = "Laboratory Study"
            2 = "Field Study     "
            3 = "Over All        ";
proc print noobs;
   var context estimate level lower upper;
   format context aa. estimate level lower upper 6.3;
run;



11.9 (pgs. 357-358) Figure 11.2

/*  side-by-side box plots;                   */
options nodate pagesize=54 linesize=80 nocenter pageno=1;
libname ch11 "d:\research\metabook\ch11\dataset";
data fig1102;
   set ch11.ex1;
   label eff="Effect Size Estimate";
   label context="Study Context";
proc sort data=fig1102;
   by context;
filename fig1102 "d:\tmp\fig1102.cgm";
goptions reset=goptions device=cgmmwwc gsfname=fig1102
   gsfmode=replace ftext=hwcgm005 gunit=pct;
proc shewhart data=fig1102 gout=fig1102 graphics;
   boxchart eff*context / boxstyle=schematic
                        idsymbol=dot
                        vref=0
                        haxis=axis1
                        nolegend
                        hoffset=5
                        nolimits
                        stddevs
                        boxwidth=30;
axis1 value =  ("Laboratory Study" " " "Field Study");
run;
quit;


11.10 (pgs. 359) Output 11.8 and Output 11.9

options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch11 "d:\research\metabook\ch11\dataset";
%let varlist1 = context;
%let varlist2 = context;
data temp;
   set ch11.ex1;
   if (_n_ = 1 or _n_ = 15 or _n_ = 16 or _n_ = 29) then delete;
%within(temp,ch11.out1108,eff,veff,context,2);
proc format;
   value aa  1 = "Between Groups       "
             2 = "Within Groups        "
             3 = "  Within (Laboratory)"
             4 = "  Within (Field)     "
             5 = "Corrected Total      ";
proc print data=ch11.out1108 noobs;
   title;
   format source aa. qstat pvalue 7.3;
quit;
options nodate nocenter pagesize=54 linesize=80 pageno=1;
libname ch11 "d:\research\metabook\ch11\dataset";
proc print data=ch11.ex1;
data temp;
   set ch11.ex1;
   if (_n_ = 1 or _n_ = 15 or _n_ = 16 or _n_ = 29) then delete;
   output;
   context = 3;
   output;
%let varlist = context;
proc print;
%wavgeff(temp,ch11.out1109,.95);
data ch11.out1109;
   set ch11.out1109;
   estimate=(exp(2*estimate)-1)/(exp(2*estimate)+1);
   lower=(exp(2*lower)-1)/(exp(2*lower)+1);
   upper=(exp(2*upper)-1)/(exp(2*upper)+1);
   rename fact1=context;
proc format;
   value aa 1 = "Laboratory Study"
            2 = "Field Study     "
            3 = "Over All        ";
proc print data=ch11.out1109 noobs;
   var context estimate level lower upper;
   format context aa. estimate level lower upper 6.3;
run;





