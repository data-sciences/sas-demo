/*-----------------------------------------------------------------*/
/* Statistical Quality Control Using the SAS System                */
/* by Dennis W. King, Ph.D.                                        */
/*                                                                 */
/* SAS Publications order # 55232                                  */
/* ISBN 1-55544-280-3                                              */
/* Copyright 1995 by SAS Institute Inc., Cary, NC, USA             */
/*                                                                 */
/* SAS Institute does not assume responsibility for the accuracy   */
/* of any material presented in this file.                         */
/*-----------------------------------------------------------------*/


---------------
Chapter 1
---------------

/*The following code appears on p. 8 */

goptions hsize=6 vsize=4.5 border device=hplj300 ftext=swissx;


/*The following code appears on p. 9 */

%macro red(dsn=,var=);
   proc print data=&dsn;
     var &var;
   run;
%mend red;

%red(dsn=one,var=x y z)


/*The following code appears on p. 9 */

proc print data=one;
  var x y z;
run;


---------------
Chapter 2
---------------

/*The following code appears on p. 16 */

data framepre;
  input day samples defects;
cards;
1   50    6
2   50    1
3   50    5
4   50    7
5   50    7
6   50    8
7   50    10
8   50    5
9   50    1
10  50    10
11  50    10
12  50    18
13  50    17
14  50    7
15  50    8
16  50    0
17  50    4
18  50    20
19  50    17
20  50    5
21  50    4
22  50    3
23  50    7
24  50    9
25  50    3
run;


/*The following code appears on p. 17 */

data boards; infile 'borthick.dat';
  input thick @@;
label thick='Thickness (mm)';
run;


/*The following code appears on p. 19 */

data bricks;
  input time temp @;
     do rep=1 to 4;
       input mor @;
       output;
     end;
cards;
23  2365   650   655   651   659
23  2370   680   685   679   674
23  2375   683   684   684   681
24  2365   620   626   627   630
24  2370   770   793   792   771
24  2375   699   703   711   713
25  2365   707   718   710   693
25  2370   754   764   785   776
25  2375   729   736   707   709
run;


---------------
Chapter 3
---------------

/*The following code appears on p. 23 */

title1 'Check Sheet';
title2 'Insurance Claim Rejection Data';
title3 '5/9/91-5/14/91';

proc tabulate data=claims format=5.0 ;
  class reason day;
  label reason='Reason for Rejection';
  var form;
  table reason all='Total',day*(form='  '*sum='  ') all='Total' /
                            rts=30 printmiss misstext='  ';
run;


/*The following code appears on p. 25 */

goptions hsize=6 vsize=7;

symbol w=3 v=dot;
title1 'Pareto Chart';
title2 'Insurance Claims Rejection Data';
title3 '5/9/91-5/14/91';

proc pareto data=claims graphics;
  vbar reason /
         scale=count
         maxcmpct=95
         other='Others'
         last='Others'
         barlabel=value
         pbars=m5x45
         nlegend='Total Rejected'
         anchor=bl;
run;


/*The following code appears on pp. 27-28 */

goptions hsize=7.5 vsize=7 device=hplj300;

title1 'Pareto Chart';
title2 'Insurance Claims Rejection Data';
title3 'by Location';

proc pareto data=claims graphics;
  vbar reason /
         class = location
         classkey = 'Downtown'
         intertile=1.0
         nrow=1
         ncol=4
         nocurve
         scale=count
         maxcmpct=90
         other='Others'
         last='Others'
         pbars=m5x45
         nlegend ;
run;


/*The following code appears on p. 31 */

libname circuit '\qcbook';


/*The following code appears on pp. 40-41 */

data board;
  length function style $ 8;
  xsys='5'; ysys='5';

  style='empty'; line=0;                   /* Create Outline */
  function='move'; x=10; y=10; output;     /* of Circuit    */
  function='bar '; x=90; y=95; output;     /* Board         */
  do row=15,30,45,60,75;                   /* Draw Five Rows*/
    do col=20,35,50,65,80;                 /* of Five DIPS  */
      function='move'; x=row; y=col; output;
      function='bar '; x=row+10; y=col+6; output;
    end;
  end;
run;


/*The following code appears on p. 41 */

data leadpos;
  length function style color $ 8;
  xsys='5'; ysys='5';

  input x y lead @@;
    x=15*x+lead; y=15*y+5;
    if lead>10 then do; y=y+6; x=x-10; end;
    style='solid'; color='red'; rotate=360;
    function='pie '; size=.2;
    output;
cards;
1 1 3   3 5 7   4 5 14   5 5 12   3 4 12   2 1 1   3 5 15  3 5 20
4 5 7   4 4 8   4 5 12   3 5 8    2 1 1    5 4 9   4 1 7   4 5 6
2 5 7   5 4 8   3 5 12   3 5 18   2 4 1    5 4 12  4 1 5   4 5 2
5 5 7   5 4 3   4 5 10   4 5 2    2 3 6    5 4 2   4 1 14  4 5 19
5 5 17  5 5 14  5 5 10   5 5 20   2 4 7    5 5 17  4 1 10  4 5 1
5 3 17  5 3 14  5 3 10   5 3 20   1 4 7    1 5 17  5 1 1   5 3 11
5 4 10  5 4 20  3 3 3
run;


/*The following code appears on p. 42 */

data circuit; set board leadpos; run;

title1 f=swissx h=1 'Defect Concentration Diagram for Circuit Board';
title2 f=swissx h=1 'Board Style VX025B7 --- July 7-July 15';

proc gslide annotate=circuit;
run;


/*The following code appears on p. 45 */

symbol v=dot h=.5;

proc gplot data=fills;
  plot filllevl*filltime
       filllevl*fillpres
       filltime*fillpres;
run;


---------------
Chapter 4
---------------

/*The following code appears on p. 58 */

title 'Computer Monitor Frames Control Chart';
title2 h=.5 'Preliminary Study Data';
symbol v=dot h=.8 i=join l=1;

proc shewhart data=framepre graphics;
  pchart defects*day / subgroupn=samples;
run;


/*The following code appears on p. 59 */

title 'Computer Monitor Frames Control Chart';
title2 h=.5 'Preliminary Study Data';
title3 h=.5 'Out-of-Control Points Excluded';
symbol v=dot h=.8 i=join l=1;

proc shewhart data=framepre graphics;
  where (1 le day le 11) or (14 le day le 17) or (20 le day le 25);
  pchart defects*day / subgroupn=samples outlimits=initlim;
run;


/*The following code appears on p. 60 */

title 'Computer Monitor Frames Control Chart';
title2 'Control Limits Data Set';

proc print data=initlim;
run;


/*The following code appears on p. 61 */

title 'Computer Monitor Frames Control Chart';
title2 h=.7 'Production Phase 1 (Days 26-50)';
symbol v=dot h=.8 i=join ;

proc shewhart data=frames1 limits=initlim graphics;
  pchart defects*day / subgroupn=samples;
run;


/*The following code appears on p. 80 */

data shew1;
  length type $ 30;
  type="Shewhart 3 Sigma"; k=3; lcl=-k; ucl=k;

  do delta=0 to 2 by .2;
    p=probnorm(ucl-delta) - probnorm(lcl-delta);
    arl=1/(1-p);
    output;
  end;
run;

title 'Shewhart ARL Table';

proc tabulate data=shew1 format=5.1;
  class delta type;
  var arl;
  table type,delta*arl='  '*sum='  ' / rts=10;
run;


/*The following code appears on p. 85 */


%macro cuarltab(type=,delta=,sigma=,n=,hs=);
  %if &hs= %then %let hs=0;

  data cuarltab;
    n=&n; sigma=&sigma; k=&delta/2; litdelta=&delta/(sigma/sqrt(n));
    do hstar=1 to 12 by .1;
      kstar=k/(sigma/sqrt(n));
      arl0=cusumarl("&type",0,hstar,kstar,&hs);
      arls=cusumarl("&type",litdelta,hstar,kstar,&hs);
      h=hstar*(sigma/sqrt(n));
      output;
      if arl0>2000 then go to endarl;
    end;
  endarl:
  run;

  title 'CUSUM ARL and Parameters Table';

  proc print;
  run;

%mend cuarltab;


/*The following code appears on p. 86 */

%cuarltab(type=ONESIDED,delta=.4,sigma=.4,n=1)


/*The following code appears on p. 87 */

title h=.7 'CUSUM Control Chart for Gasoline Impurities';
symbol v=dot h=.5;

proc cusum data=impone graphics;
  xchart impure*day / scheme=onesided h=4.8 k=.5
                      mu0=2 sigma0=.4 delta=1 tablesummary tablecomp;
run;


/*The following code appears on pp. 89-90 */

data shewcus;
  length type $ 30;
  k=3; ucl=k;
  do delta=0 to 2 by .2;
    type='Shewhart 3 Sigma';
    p=probnorm(ucl-delta); arl=1/(1-p);
    output;
    type='CUSUM h=4.8, k=.5';
    arl=cusumarl('ONESIDED',delta,4.8,.5);
    output;
  end;
run;

title 'Shewhart CUSUM ARL Comparison';

proc tabulate data=shewcus format=5.1;
   class delta type;
   var arl;
   table type,delta*arl=' '*sum=' ' / rts=10;
run;


/*The following code appears on p. 92 */

title h=.7 'FIR CUSUM Control Chart for Gasoline Impurities';
symbol v=dot h=.5;

proc cusum data=imptwo graphics;
  xchart impure*day / scheme=onesided h=4.84 k=.5 headstart=2.42
                      mu0=2 sigma0=.4 delta=1 tablecomp tablesummary;
run;


/*The following code appears on p. 94 */

data cusfir;
  length type $ 30;
  do delta=0 to 2 by .2;
    type='CUSUM h=4.8, k=.5';
    arl=cusumarl('ONESIDED',delta,4.8,.5);
    output;
    type='FIR CUSUM h=4.84, k=.5, HS=2.42';
    arl=cusumarl('ONESIDED',delta,4.84,.5,2.42);
    output;
  end;
run;

title 'CUSUM and FIR CUSUM ARL Comparison';

proc tabulate data=cusfir format=5.1;
   class delta type;
   var arl;
   table type,delta*arl=' '*sum=' ' / rts=10;
run;


/*The following code appears on p. 96 */

proc cusum data=impthree graphics;
  xchart impure*day / nochart mu0=2 sigma0=.4 delta=1
                      h=4.94 k=.5
                      scheme=onesided
                      outtable=cusumlim
                         (drop = _var_ _subn_ _exlim_
                          rename = (_cusum_=_subr_ _h_=_uclr_));
run;

proc shewhart data=impthree graphics;
  irchart impure*day / nochart mu0=2 sigma0=.4
                       sigmas=3.5
                       outtable=shewlim
                          (drop= _subr_ _lclr_ _r_ _uclr_);
run;

data combine; merge shewlim cusumlim; by day;
   _lclr_=0.0; _r_=.5*_uclr_;
run;

title h=.7 'Combined Shewhart-CUSUM Control Chart for Gasoline Impurities';
symbol i=join v=dot h=.5;

proc shewhart table=combine graphics;
  irchart impure*day /  ucllabel2='H=4.94'
                        xsymbol=mu0
                        ypct1=50 split='/' nolcl noctl2;
label _subi_='Shewhart/Cusum';
run;


/*The following code appears on p. 100 */

%macro ewmamac(delta=,icarl=);

  data ewarl;
    do k=1 to 3.5 by .01;
      do lambda=.05 to .95 by .05;
        arl0=ewmaarl(0,lambda,k);
        arls=ewmaarl(&delta,lambda,k);
        if &icarl-3 le arl0 lt &icarl+3 then output;
      end;
    end;
  run;

  proc sort data=ewarl; by arls;

  data topfive; set ewarl;
    if _n_ le 5 then do delta=0 to 3 by .2;
      arl = ewmaarl(delta,lambda,k);
      output;
    end;
  run;

  title 'Sensitivity Analysis for EWMA Control Chart Parameters';

  proc tabulate data=topfive format=7.2;
     class delta lambda k;
     var arl;
     table delta,lambda*k*arl='  '*(sum='  ');
  run;

%mend ewmamac;


/*The following code appears on pp. 101-102 */

title h=.8 'Aircraft Primer Paint Viscosity EWMA Chart';
symbol v=dot h=.6 ;
label viscosty='Viscosity';

proc macontrol data=primevis graphics;
  ewmachart viscosty*batch / sigmas=2.65 weight=.15
            mu0=50.00 xsymbol=mu0;
run;


/*The following code appears on p. 107 */

data bikestd;
  input style $  uzero  @@;
cards;
12G  2.0    12B  2.0   14G  2.0    14B  2.0    16G  2.0    16B  2.0
20G  3.0    20B  2.0   24G  3.0    24B  3.0    26G  3.0    26B  3.0
RAG  1.0    RAB  1.0
run;


/*The following code appears on p. 108 */

proc sort data=bikestd; by style;
proc sort data=bikes  ; by style;

data bike2; merge bikes bikestd; by style;
   u=defects/sampsize;
   z=(u-uzero)/sqrt(uzero/sampsize);
   if z ne .;
run;

proc sort data=bike2; by batch;


/*The following code appears on pp.108-109 */

data bikelim;
  _var_='Z'; _subgrp_='BATCH'; _mean_=0; _lclx_=-3; _uclx_=3;
run;

title 'Bicycle Frames Defect Control Chart';
title2 h=.7 'Standardized U Chart';
symbol v=dot h=.8;
label z='Std. Value Z';

proc shewhart data=bike2 limits=bikelim graphics;
  xchart Z*batch / nolegend nolimitslegend xsymbol=mu;
run;


/*The following code appears on p. 112 */

proc sort data=hemoglob; by run consamp;

data hemotab(rename=(hemoglob=_subx_)); set hemoglob; by run consamp;
  length _tests_ $ 8;
  retain above 0 below 0 a23 0 b23 0 low high;
  sample+1; _subn_=1; sigma=.1; mu=12;

  /* One value outside three sigma limits */
    if hemoglob gt mu + 3*sigma or hemoglob lt mu-3*sigma
                            then substr(_tests_,1,1)='1';

  /* Two out of three values in zone A in a run */
    if hemoglob gt mu+2*sigma then a23=a23+1;
    if hemoglob lt mu-2*sigma then b23=b23+1;
    if last.run and (a23 ge 2 or b23 ge 2)then substr(_tests_,2,1)='2';
    if last.run then do; a23=0; b23=0; end;

  /* Range of Sample within a run greater than 4 sigma */
    if first.run then do; low=hemoglob; high=hemoglob; end;
    if hemoglob gt high then high=hemoglob;
    if hemoglob lt low  then low =hemoglob;
    if high-low gt 4*sigma then do;
       substr(_tests_,3,1)='3'; low=.; high=.; end;

  /* Nine points in a row on one side of center across runs */
    if hemoglob gt mu then above=above + 1; else above=0;
    if hemoglob lt mu then below=below + 1; else below=0;
    if above gt 9 or below gt 9 then substr(_tests_,4,1)='4';
run;

title 'Table Data Set for Hemoglobin Control Chart';

proc print data=hemotab;
  var sample run consamp _subx_ _tests_;
run;


/*The following code appears on p. 113 */

title 'Control Chart for Hemoglobin';
symbol v=dot i=none;
label _subx_='Hemoglobin (g/dL)'  run='Run';

proc shewhart table=hemotab graphics;
  xchart hemoglob*sample(run) / mu0=12 href=3.5 to 24.5 by 3
                sigma0=.1 tests=1 2 3 4 noconnect zones  ;
run;


/*The following code appears on p. 116 */

data cornlim;
   sigma=.25; alpha=.10; beta=.10; usl=17; lsl=15; p2=.05;
   zalpha=probit(1-(alpha/2));
   zbeta=probit(1-(beta/2));
   urpl=usl-probit(1-p2)*sigma;
   uapl=16.25; lapl=15.75;
   lrpl=lsl+probit(1-p2)*sigma;
   _lclx_=lapl+(zalpha/(zbeta+zalpha))*(lrpl-lapl);
   _uclx_=uapl+(zalpha/(zbeta+zalpha))*(urpl-uapl);
   _mean_=_lclx_+(_uclx_-_lclx_)/2;
   n=(((zalpha+zbeta)*sigma)/(urpl-uapl))**2;
   _var_='XBAR'; _subgrp_='BATCH';
run;

title 'Canned Corn Process Data';
title2 'Control Limits Data Set';

proc print;
run;


/*The following code appears on p. 117 */

title 'Acceptance Control Chart';
title2 h=.7 'Canned Corn Filling Process';
label xbar='Fill in Ounces';
symbol i=join v=dot h=.8;

proc shewhart data=corn limits=cornlim graphics;
  xchart xbar*batch / nolegend nolimitslegend;
run;


/*The following code appears on p. 122 */

title 'Toy Plane Wing Width Data - Regression Modeling';

proc reg data=wings;
  model width = hour hr2;
  output out=predict pred=pred;
run;

title 'Toy Plane Wing Width Data';
title2 'Observed and Fitted Values From Regression Modeling';

proc print data=predict(obs=20);
run;


/*The following code appears on p. 123 */

title 'Toy Airplane Wing Width Control Chart';
symbol v=dot h=.7;

proc shewhart data=predict graphics;
  xchart width*hour / trendvar=pred npanelpos=200;
run;


---------------
Chapter 5
---------------

/*The following code appears on p. 129 */

title 'Minimum and Maximum Values in Pipe Diameter Data Set';

proc means data=diams min max;
run;


/*The following code appears on p. 130 */

title h=.8 'Pipe Diameter Data Histogram';

proc capability data=diams noprint graphics;
  histogram diameter / midpoints=219.5 to 234.5 by 3;
  histogram diameter;
  histogram diameter / nobars kernel(c=.675 k=T);
  histogram diameter / nobars kernel(c=1.35 k=T);
run;


/*The following code appears on p. 133 */

title h=.8 'Pipe Diameter Data Comparative Histograms';

proc capability data=diams noprint graphics;
  var diameter;
  comphistogram diameter / class=line;
  inset mean std n / position=ne height=1.5;
  label line='Assembly Line';
run;


/*The following code appears on p. 137 */

title h=.8 'Board Thickness Data';

proc capability data=boards graphics normaltest;
  var thick;
  spec lsl=2.82 usl=3.18 target=3.00
            cleft=black  cright=black
            pleft=solid  pright=solid
            wlsl=5 wusl=5 llsl=2 lusl=2;
  histogram thick / normal(fill) pfill=empty haxis=axis1 nolegend;
  inset cp cpk / position=(3.05,23) data height=2.3;
  inset lslpct / position=(2.72,3) data height=1.7
        header='Est. % < LSL';
  qqplot thick / nolegend nospeclegend;
axis1 order=2.7 to 3.3 by .1;
run;


/*The following code appears on p. 144 */

proc capability data=boards graphics noprint;
  var thick;
  spec lsl=2.82 usl=3.18 target=3.00;
  output out=index cpk=cpk n=n cpklcl=lcl cpkucl=ucl;
run;

title 'Capability Index Output Data Set';
title2 'Capability Index Estimate with 95% Confidence Interval';

proc print data=index;
run;


/*The following code appears on p. 148 */

title h=.8 'Board Thickness Data';

proc capability data=boards graphics noprint;
  var thick;
  intervals thick / alpha=.05 p=.99 k=1 2 method=1 3 4 6;
run;


/*The following code appears on p. 153 */

title 'Wooden Stool Assembly Time Data';
title2 'PROC CAPABILITY Output with Generalized Capability Index';

proc capability data=wstools noprint graphics;
  spec usl=5.0;
  histogram assmtime / exp(indices);
run;


/*The following code appears on p. 158 */

title 'Toy Car Engine Reliability Data';

proc capability data=engines graphics noprint;
  var survtime;
  histogram survtime / midpoints=10 to 200 by 20
       weibull outfit=parms(keep=_var_--_shape1_);
  inset weibull(shape scale) / header='Weibull Parameter Estimates'
                  position = NE;
run;

proc print data=parms;
run;


/*The following code appears on p. 161 */

data cir; set parms;
  alpha=.05;  n=100; t=70;
  z = probit(1-(alpha/2));
  rhat=exp(-(t/_scale_)**_shape1_);
  vr = (rhat**2)*(log(rhat)**2)*(1.109-(.514*log(-log(rhat)))
       +(.608*(log(-log(rhat)))));
  rellcl = rhat + z*sqrt(vr/n);
  relucl = rhat - z*sqrt(vr/n);
  keep alpha n t rhat rellcl relucl;
run;

title 'Toy Engine Reliability Data';
title2 'Confidence Interval on Reliability Estimate';

proc print data=cir;
run;


/*The following code appears on p. 162 */

data cis; set parms;
  n=100;
  alpha=.05;
  z = probit(1-(alpha/2));
  clcl = _shape1_ / (1+sqrt(.608/n)*z);
  cucl = _shape1_ / (1-sqrt(.608/n)*z);
run;

title 'Toy Engine Reliability Data';
title2 'Confidence Interval on Shape Parameter';

proc print data=cis;
run;


---------------
Chapter 6
---------------

/*The following code appears on p. 182 */

proc factex;
   factors temp time / nlev=3;
   output out=brickdes temp nvals=(2365 2370 2375)
                       time nvals=(23 24 25)
                       designrep=4;
run;


/*The following code appears on p. 183 */

data brickdes; set brickdes;
 run=_n_;
 mor='________';
run;

title 'Brick Breaking Strength Experiment';
title2 'Experimental Design/Data Collection Form';

proc print data=brickdes;
  id run;
run;


/*The following code appears on p. 184 */

title 'Refractory Brick Data';
title2 'Analysis of Variance';

proc glm data=bricks;
  class time temp;
  model mor = time temp time*temp;
  means time temp time*temp;
run;


/*The following code appears on p. 186 */

proc means data=bricks nway noprint;
  class time temp;
  var mor;
  output out=brikmean mean=;
run;

title 'Refractory Brick Data';
title2 h=.7 'Interaction Plot';
label temp='Degrees Fahrenheit' mor='MOR';
symbol1 f=marker v=C i=join w=4;
symbol2 f=marker v=P i=join w=4;
symbol3 f=marker v=U i=join w=4;

proc gplot data=brikmean;
  plot mor*temp=time / haxis=2360 to 2380 by 5 vaxis=620 to 800 by 30;
run;


/*The following code appears on p. 188 */

title 'Refractory Brick Data';
title2 'Analysis of Variance';

proc glm data=bricks;
  class time temp;
  model mor = time temp time*temp;
  contrast 'mu22-mu32' time 0  1 -1 time*temp 0  0  0  0  1  0  0 -1  0;
  contrast 'mu22-mu33' time 0  1 -1 temp 0  1 -1
                       time*temp 0  0  0  0  1  0  0  0  -1;
  contrast 'mu32-mu33' temp 0  1 -1
                       time*temp 0  0  0  0  0  0  0  1  -1;
run;


/*The following code appears on p. 189 */

contrast 'T23*Temp Quad.'  temp 1 -2 1 time*temp 1 -2  1  0 0 0  0 0 0;


/*The following code appears on p. 190 */

title 'Refractory Brick Data';
title2 'Analysis of Variance';

proc glm data=bricks;
  class time temp;
  model mor = time temp time*temp;
  contrast 'T23*Temp Quad.' temp 1 -2 1 time*temp 1 -2 1 0  0 0 0  0 0;
  contrast 'T24*Temp Quad.' temp 1 -2 1 time*temp 0  0 0 1 -2 1 0  0 0;
  contrast 'T25*Temp Quad.' temp 1 -2 1 time*temp 0  0 0 0  0 0 1 -2 1;
  contrast 'Time*T2365 Quad.' time 1 -2 1
                              time*temp 1  0  0 -2  0  0  1 0 0;
  contrast 'Time*T2370 Quad.' time 1 -2 1
                              time*temp 0  1  0  0 -2  0  0 1 0;
  contrast 'Time*T2375 Quad.' time 1 -2 1
                              time*temp 0  0  1  0  0 -2  0 0 1;
run;


/*The following code appears on p. 194 */

title 'Truck Spring Experiment Aliasing Structure';

proc factex;
  factors trantime furntemp heattime holdtime / nlev=2;
  model resolution=4;
  size fraction=2;
  examine aliasing(4);
  output out=sprdes trantime cvals=('-' '+')
                    furntemp cvals=('-' '+')
                    heattime cvals=('-' '+')
                    holdtime cvals=('-' '+');
run;

title 'Truck Spring Experiment Design Points';

proc print data=sprdes;
run;


/*The following code appears on pp. 196-197 */

title 'Experimental Design for Fertilizer Water Content Experiment';
title2 'Distillation Method Ruggedness Test';

proc factex;
  examine aliasing(7) confounding;
  factors g a b c d e f / nlev=2;
  model resolution=3;
  size fraction=16;
  output out=rugged a cvals=('ca 5 mL' 'ca 2 mL')
                    b cvals=('15 min' '0 min')
                    c cvals=('6 dr/s' '2 dr/s')
                    d cvals=('45 min' '90 min')
                    e cvals=('190 mL' '210 mL')
                    f cvals=('12 mL' '8 mL')
                    g cvals=('Used' 'New');
run;

proc print data=rugged label split='*';
  var a--f g;
  label a='Amt.*of Water'  b='Reaction*Time'  c='Distill.*Rate'
        d='Distill.*Time'  e='n-Heptane'      f='Aniline'
        g='Reagant';
run;


/*The following code appears on p. 208 */

title 'Paint Thickness Experiment';
title2 'A 1/9 Replicate of a Resolution III Design';

proc factex;
  factors a b c d / nlev=3;
  examine aliasing(4) confounding design;
  model resolution=3;
  size fraction=9;
run;


/*The following code appears on p. 210 */

title 'Paint Thickness Experiment';
title2 'Full Replicate in Blocks of Size 27';

proc factex;
  factors a b c d / nlev=3;
  examine confounding aliasing;
  model estimate=(a b c d a*b a*c a*d b*c b*d c*d);
  blocks size=27;
  output out=design a nvals=(0 1 2)
                    b nvals=(0 1 2)
                    c nvals=(0 1 2)
                    d nvals=(0 1 2);
run;

proc print data=design;
run;


/*The following code appears on p. 214 */

title 'Paint Thickness Experiment';
title2 'A Full Replicate in Blocks of Size 9';

proc factex;
  factors a b c d / nlev=3;
  examine confounding aliasing;
  model estimate=(a b c d a*b a*c a*d b*c b*d c*d);
  blocks size=9;
  output out=design3 a nvals=(0 1 2)
                    b nvals=(0 1 2)
                    c nvals=(0 1 2)
                    d nvals=(0 1 2);
run;

proc print;
run;


/*The following code appears on pp. 219-220 */

proc factex;  /* Generate Outer Array */
  factors m n o / nlev=2;
  model resolution=3;
  size fraction=2;
  output out=outer;
run;

proc factex;   /* Generate Inner Array */
  factors a b c d e f g / nlev=2;
  model resolution=3;
  size fraction=16;
  output out=taguchi pointrep=outer;
run;

data taguchi; set taguchi; z=' '; label z='00'X;
run;

title 'Taguchi Design for Injection Molding Process';

proc print data=taguchi label;
 var a b c d e f g z m n o;
run;


/*The following code appears on p. 224 */

title2 'Parameter Estimates in Uncoded Form';

proc glm;
  model mor = time temp / ss1;
run;

title2 'Parameter Estimates in Coded Form';

proc glm;
  model mor = codetime codetemp / ss1;
run;


/*The following code appears on p. 226 */

title2 'Lack of Fit Analysis';

proc glm;
  class lof;
  model mor=time temp lof / ss1;
run;


/*The following code appears on p. 232 */

data brickpt2;
  input mor @@;
cards;
640  650  780  830  620 770  650  670  800  804  803  802  802
run;

data sasuser.brickrs;
   merge sasuser.brickrs brickpt2;
run;

title 'Refractory Brick Response Surface Experiment Data - Part 2';
title2 'Central Composite Design Response Data';

proc print data=sasuser.brickrs;
run;


/*The following code appears on p. 232 */

title 'Refractory Brick Response Surface Experiment Data - Part 2';
title2 'Second Order Response Surface Model Data Analysis';

proc rsreg data=sasuser.brickrs;
  model mor = time temp ;
run;


/*The following code appears on p. 235 */

data plot3d; set sasuser.brickrs end=eof;
  output;
  if eof then do;
    mor=.;
    do time=22.5 to 25.5 by .1;
      do temp=2360 to 2380 by .2;
        output;
      end;
    end;
  end;
run;

proc rsreg data=plot3d out=plotdata noprint;
  model mor=time temp / predict;
run;

data plotdata; set plotdata;
  if _n_ le 13 then delete;
label mor='MOR';
run;

title h=.8 'Refractory Brick Experiment';
title2 h=.7 'Second Order Response Surface';

proc g3d data=plotdata;
  plot time*temp=mor / xticknum=3 yticknum=3 grid rotate=65;
run;


---------------
Chapter 7
---------------

/*The following code appears on pp. 254-255 */

data single;
  n=125; c=3; lotn=5000;
  do p=.000 to .06 by .001;
    k=ceil(lotn*p);
    if p=0 then pa=1;
      else pa=probhypr(lotn,k,n,c);
    ati=n+(1-pa)*(lotn-n);
    aoq=(pa*p*(lotn-n))/lotn;
    output;
  end;
run;

title 'Performance Measures for Single Sampling Plan';
title2 'N=5000, n=125, c=3';

proc print data=single;
run;
title 'OC Curve for Single Sampling Plan';
title2 h=.7 'N=5000, n=125, c=3';
symbol i=join v=none;

proc gplot data=single;
  plot pa*p / vaxis=axis1 vzero;
axis1 label=(a=90 'Prob. of Acc.');
run;

title  'Average Total Inspection for Single Sampling Plan';
title2 h=.7 'N=5000, n=125, c=3';
symbol i=join v=none;

proc gplot data=single;
  plot ati*p / vaxis=axis1 vzero;
axis1 label=(a=90 'Units Inspected');
run;

title  'Average Outgoing Quality';
title2 h=.7 'N=5000, n=125, c=3';
symbol i=join v=none;

proc gplot data=single;
  plot aoq*p / vaxis=axis1 vzero;
axis1 label=(a=90 'Ave. Outgoing Quality');
run;


/*The following code appears on p. 260 */

data oc105;
  n=125; c=3; lotn=2000;
  do p=.00658, .01, .0109, .014, .0203, .0294, .0409, .062, .0804;
    k=ceil(lotn*p);
    pa=probhypr(lotn,k,n,c);
    output;
  end;
run;

title 'OC Curve Values for MIL-STD-105 Plan';
title2 'N=2,000, n=125, c=3';

proc print;
run;


/*The following code appears on p. 261 */

data newoc;
  lotn=2000; aql=.008; c=-1;
  if lotn gt 1200 then logn=2.05+.37*log(lotn);
    else logn=-.63+.75*log(lotn);
  n=int(exp(logn));

  do while (pa<.90);
    k=ceil(aql*lotn);
    c=c+1;
    pa=probhypr(lotn,k,n,c);
  end;

keep lotn aql n c pa;
run;

title 'Sample Size and Acceptance Number';
title2 'to Achieve Specified PA at AQL';

proc print;
run;


/*The following code appears on p. 262 */

data dodgerom;
  ltpd=.04;  conrisk=.10;  aql=.015; lotn=1500;
  ati=1E10;

    do newc=0 to 30;
      newn=newc+3;
      do until ((ppp le conrisk) or (n ge lotn));
        newn=newn+1;
        k=int(ltpd*lotn);
        if ((newc lt max(0,k+newn-lotn)) or
            (newc gt min(k,lotn))) then ppp=0;
           else ppp=probhypr(lotn,k,newn,newc);
      end;
      if ppp=0 then newpa=0;
         else newpa=probbnml(aql,newn,newc);
      newati=newn+((lotn-newn)*(1-newpa));
      if newati lt ati then do;
         ati = newati;  c=newc;  n=newn;  pa=newpa; pa_ltpd = ppp; end;
    end;
keep lotn n c ati pa ltpd aql pa_ltpd conrisk;
run;

title 'Dodge Romig LTPD Plan';

proc print;
run;


/*The following code appears on p. 264 */

data sampplan;
  aql=.01; paaql=.95; ltpd=.08; paltpd=.10;

  n=0; c=-1;
  do until (pa>paaql);
    c=c+1;
    do until (pa<paltpd);
      n=n+1;
      pa=probbnml(ltpd,n,c);
    end;
    pa2=pa;
    pa=probbnml(aql,n,c);
  end;
run;

title 'Single Sampling Plan for Specified Probability of Acceptance';
title2 'at AQL and LTPD';

proc print;
  var aql paaql ltpd paltpd lotn n c pa pa2;
run;


/*The following code appears on pp. 266-267 */

data double;
  n1=100; c1=2; n2=175; c2=4; lotn=5000;
  do p=.000 to .06 by .001;
    d=ceil(lotn*p);
    k=ceil(lotn*p);
    if p=0 then pa=1;
      else pa=probacc2(c1,c2,c2,n1,n2,d,lotn);
    asn=asn2('SEMI',c1,c2,c2,n1,n2,p);
    ati=ati2(lotn,c1,c2,c2,n1,n2,p);
    aoq=aoq2('REP',lotn,c1,c2,c2,n1,n2,p);
    output ;
  end;
run;

title 'Performance Measures for Double Sampling Plan';
title2 'N=5000, n1=100, c1=2, n2=175, c2=4';

proc print data=double;
run;

title 'OC Curve for Double Sampling Plan';
title2 h=.7 'N=5000, n1=100, c1=2, n2=175, c2=4';
symbol i=join v=none;

proc gplot data=double;
  plot pa*p / vaxis=axis1 vzero;
axis1 label=(a=90 'Prob. of Acc.');
run;

title 'Average Sample Number for Double Sampling Plan';
title2 h=.7 'N=5000, n1=100, c1=2, n2=175, c2=4';
symbol i=join v=none;

proc gplot data=double;
  plot asn*p / vaxis=axis1 vzero vref=125;
axis1 label=(a=90 'Ave. Sample Number') order=90 to 150 by 20;
run;


/*The following code appears on p. 269 */

data tablets;
  do p=.5,.402,.309,.227,.159,.106,.067,.04,.023,.012,.006;
    pa=probacc2(0,3,2,6,6,p);
    asn=asn2('FULL',0,3,2,6,6,p);
    output;
  end;
run;

title 'Probability of Acceptance and Average Sample Number';
title2 'for USP XIX Tablet Dissolution Sampling Plan';

proc print;
run;


/*The following code appears on pp. 271-272 */

data csp1;
  pt=.023; specaoql=.03;

  f=log(.1)/(1000*log(1-pt));
  i=9;
  do until(aoql lt specaoql);
    i=i+1;
    aoql=0;
    do p=.01 to .75 by .01;
      q=1-p;
      aoq=p*((1-f)*q**i)/(f+(1-f)*q**i);
      if aoq>aoql then aoql=aoq;
    end;
  end;
drop p q aoq;
found: run;

title 'Parameters for Continuous Sampling Plan (CSP-1)';
title2 'for Specified AOQL and Percent Defective per 1000 Parts';

proc print;
run;


/*The following code appears on p. 272 */

%samptab(ltpd=0.05, conrisk=0.10, aql=0.0125);


/*The following code appears on p. 275 */

data kmethod;
  alpha=.05; beta=.1; p1=.01; p2=.08;
  zalpha=probit(1-alpha);
  zbeta=probit(1-beta);
  zp1=probit(1-p1);
  zp2=probit(1-p2);
  k=(zalpha*zp2+zbeta*zp1) / (zalpha+zbeta);
  n=(1+(k**2/2))*((zalpha+zbeta)/(zp2-zp1))**2;
  drop zalpha zbeta zp1 zp2;
run;

title 'Variables Sample Plan - K Method Procedure';

proc print;
run;


/*The following code appears on pp. 276-277 */

data mmethod;
  xbar=1910;  s=50; l=1700; n=27; k=1.809;
  a=(n/2)-1;  b=(n/2)-1;
  z1=max(0,.5-.5*((xbar-L)/s)*(sqrt(n)/(n-1)));
  phatl=probbeta(z1,a,b);
  z3=.5-(k*sqrt(n))/(2*(n-1));
  m=probbeta(z3,a,b);
  drop a b z1 z3;
run;

title 'Variables Sampling Plan - M Method - One Sided Spec Limit';

proc print;
run;


/*The following code appears on p. 277 */

data mmethod;
   xbar=1910;  s=50; L=1700; U=2000; n=27; k=1.809;
   a=(n/2)-1;  b=(n/2)-1;
   z1=max(0,.5-.5*((xbar-L)/s)*(sqrt(n)/(n-1)));
   phatl=probbeta(z1,a,b);
   z2=max(0,.5-.5*((U-xbar)/s)*(sqrt(n)/(n-1)));
   phatu=probbeta(z2,a,b);
   z3=.5-(k*sqrt(n))/(2*(n-1));
   m=probbeta(z3,a,b);
   drop a b z1 z2 z3;
run;

title 'Variables Sampling Plan - M Method - Two Sided Spec Limits';

proc print;
run;


/*The following code appears on p. 279 */

data oc414;
  n=30; k=1.86;

  do p=.01 to .15 by .01;
    kp=probit(1-p);
    nc=sqrt(n)*kp;
    pa=1-probt(sqrt(n)*k,n-1,nc);
    output;
  end;
run;

title 'OC Curve Values for MIL-STD-414 Plan';

proc print;
run;


---------------
Chapter 8
---------------

/*The following code appears on p. 284 */

title 'Linear Calibration Function Calculations';

proc reg data=hplc outest=xxx outsscp=xx2;
  model peak=red_no2;
run;


/*The following code appears on p. 287 */

data xx3; set xx2;      /* Get sample size and SSX */
  n=lag(intercep);      /* from OUTSSCP data set   */
  rename red_no2 = SSX intercep=sumx;
  keep n red_no2 intercep;
  if _name_='RED_NO2';
run;

data xyz; merge xxx xx3;
   rename red_no2=slope;
   peak=22;         /* Input value for Inverse Prediction */
run;

data ci; set xyz;
  alpha=.05;
  xbar=sumx/n;
  red_no2 = (peak-intercep)/slope;
  tval = tinv(1-(alpha/2),n-1);
  g = (tval**2) * (_rmse_**2) /
           ((slope**2) * (ssx-(n*xbar**2)));
  lcl = xbar + ((red_no2-xbar) - (tval*_rmse_/slope)*sqrt((1+1/n)*(1-g)
                     + ((red_no2-xbar)/(ssx-n*xbar**2)))) / (1-g);
  ucl = xbar + ((red_no2-xbar) + (tval*_rmse_/slope)*sqrt((1+1/n)*(1-g)
                     + ((red_no2-xbar)/(ssx-n*xbar**2)))) / (1-g);
  keep peak red_no2 lcl ucl slope intercep;
run;

title 'Inverse Predicted Value with Confidence Interval';

proc print;
run;


/*The following code appears on p. 300 */

title 'Height Gauge R&R Study Data';
title2 'Variance Component Analysis Using PROC MIXED';

proc mixed data=heights;
  class operator part;
  model height=;
  random operator part part*operator;
run;


/*The following code appears on p. 303 */

title 'Analysis of Variance and Variance Component Estimation';
title2 'for Peanut Butter Aflatoxin Data';

proc mixed data=pbutter method=reml;
  class lab;
  model aflatox =  ;
  random lab;
run;


/*The following code appears on p. 306 */

%tolford(nvar=2,lsl=98,usl=102,nominal=25 4,
         vars=.1089 .0004,
         func=a*b,dera=b,derb=a)


/*The following code appears on p. 307 */

%tolford(nvar=4,lsl=45,usl=65,nominal=120 2.98 15 20,
         vars=15 1 1 2,
         func=a*((1/b)+(1/c)+(1/d)),
         dera=((1/b)+(1/c)+(1/d)),
         derb=-a/(b**2),
         derc=-a/(c**2),
         derd=-a/(d**2))


---------------
Appendix A
---------------

/*The following code appears on pp. 309-313 */


data claims;
  length reason $ 16  location $ 15;
  input reason &$  date:mmddyy8.  location $;
  form=1; day=day(date);
  format date mmddyy8.;
cards;
ID #                              5/9/91         Downtown
ID #                              5/9/91         Downtown
Group #                           5/9/91         Downtown
Medicare Suffix                   5/9/91         Downtown
ID #                              5/9/91         Oakridge
Missing service                   5/9/91         Downtown
Group #                           5/9/91         Downtown
ID #                              5/9/91         Berryessa
Referring MD                      5/9/91         Downtown
ID #                              5/9/91         Downtown
ID #                              5/9/91         Downtown
Item not covered                  5/9/91         Downtown
ID #                              5/9/91         Downtown
Prov sub ID                       5/9/91         Downtown
Bad carrier zip                   5/9/91         Downtown
Item not covered                  5/9/91         Berryessa
Medicare Suffix                   5/9/91         Downtown
ID #                              5/10/91        Berryessa
Referring MD                      5/10/91        Downtown
Referring MD                      5/10/91        Downtown
Blue Shield #                     5/10/91        Downtown
Medicare Suffix                   5/10/91        Downtown
ID #                              5/10/91        Downtown
Bad carrier zip                   5/10/91        Berryessa
ID #                              5/10/91        Berryessa
Referring MD                      5/10/91        Downtown
ID #                              5/10/91        Downtown
ID #                              5/10/91        Oakridge
CPT4/HCPCS                        5/10/91        Downtown
Medicare Suffix                   5/10/91        Downtown
Referring MD                      5/10/91        Downtown
Prov sub ID                       5/10/91        Downtown
Medicare Suffix                   5/10/91        Downtown
Bad patient zip                   5/10/91        Downtown
Bad carrier zip                   5/10/91        Downtown
Prov sub ID                       5/10/91        Downtown
Medicare Suffix                   5/10/91        Downtown
Missing date                      5/10/91        Downtown
Blue Shield #                     5/10/91        Downtown
Referring MD                      5/10/91        Downtown
Prov sub ID                       5/10/91        Downtown
Prov sub ID                       5/10/91        Downtown
Group #                           5/10/91        Downtown
Prov sub ID                       5/10/91        Downtown
Referring MD                      5/10/91        Downtown
ID #                              5/10/91        Downtown
Medicare Suffix                   5/10/91        Downtown
ID #                              5/10/91        Downtown
Medicare Suffix                   5/10/91        Downtown
Prov sub ID                       5/10/91        Downtown
ID #                              5/10/91        Downtown
Missing service                   5/10/91        Downtown
Medicare Suffix                   5/11/91        Downtown
Referring MD                      5/11/91        Downtown
Referring MD                      5/11/91        Downtown
Prov sub ID                       5/11/91        Downtown
ID #                              5/11/91        Downtown
Prov sub ID                       5/11/91        Downtown
ID #                              5/11/91        Berryessa
ID #                              5/11/91        Downtown
CPT4/HCPCS                        5/11/91        Downtown
Missing service                   5/11/91        Downtown
Medicare Suffix                   5/11/91        Downtown
Group #                           5/11/91        Berryessa
Blue Shield #                     5/11/91        Downtown
Blue Shield #                     5/11/91        Downtown
Missing service                   5/11/91        Downtown
ID or group #                     5/11/91        Downtown
Prov sub ID                       5/11/91        Downtown
Referring MD                      5/11/91        Downtown
Referring MD                      5/11/91        Downtown
Referring MD                      5/11/91        Downtown
Group #                           5/11/91        Berryessa
Group #                           5/11/91        Downtown
Bad carrier zip                   5/11/91        Downtown
Group #                           5/11/91        Downtown
ID #                              5/11/91        Milpitas
Referring MD                      5/11/91        Downtown
Missing service                   5/11/91        Downtown
Bad carrier zip                   5/11/91        Downtown
ID #                              5/11/91        Downtown
Medicare Suffix                   5/11/91        Downtown
Prov sub ID                       5/11/91        Downtown
Missing date                      5/11/91        Downtown
Prov sub ID                       5/11/91        Downtown
Referring MD                      5/11/91        Downtown
Medicare Suffix                   5/11/91        Downtown
Prov sub ID                       5/11/91        Downtown
Referring MD                      5/11/91        Downtown
Group #                           5/11/91        Downtown
Blue Shield #                     5/11/91        Downtown
Missing service                   5/11/91        Downtown
Referring MD                      5/11/91        Downtown
Medicare Suffix                   5/11/91        Downtown
Referring MD                      5/12/91        Downtown
Group #                           5/12/91        Downtown
Missing date                      5/12/91        Downtown
Referring MD                      5/12/91        Downtown
ID or group #                     5/12/91        Milpitas
Group #                           5/12/91        Oakridge
Blue Shield #                     5/12/91        Downtown
ID #                              5/12/91        Downtown
ID #                              5/12/91        Downtown
CPT4/HCPCS                        5/12/91        Downtown
ID #                              5/12/91        Downtown
Referring MD                      5/12/91        Downtown
Group #                           5/12/91        Downtown
Medicare Suffix                   5/12/91        Downtown
Missing date                      5/12/91        Downtown
Referring MD                      5/12/91        Downtown
Referring MD                      5/12/91        Downtown
Missing service                   5/12/91        Downtown
Missing date                      5/12/91        Downtown
ID #                              5/12/91        Downtown
Referring MD                      5/12/91        Berryessa
Referring MD                      5/12/91        Downtown
Missing date                      5/12/91        Downtown
ID #                              5/12/91        Downtown
Item not covered                  5/12/91        Berryessa
Group #                           5/12/91        Downtown
Missing service                   5/12/91        Downtown
ID or group #                     5/12/91        Berryessa
Referring MD                      5/12/91        Downtown
Bad patient zip                   5/12/91        Downtown
ID #                              5/12/91        Downtown
ID #                              5/12/91        Downtown
ID or group #                     5/12/91        Berryessa
Referring MD                      5/12/91        Downtown
Blue Shield #                     5/12/91        Berryessa
ID #                              5/12/91        Downtown
Prov sub ID                       5/12/91        Downtown
Group #                           5/12/91        Downtown
Missing date                      5/12/91        Downtown
ID #                              5/12/91        Downtown
Prov sub ID                       5/12/91        Downtown
Referring MD                      5/12/91        Downtown
Referring MD                      5/12/91        Downtown
Group #                           5/12/91        Downtown
Medicare Suffix                   5/12/91        Downtown
Group #                           5/13/91        Downtown
Medicare Suffix                   5/13/91        Downtown
ID #                              5/13/91        Oakridge
Group #                           5/13/91        Berryessa
Medicare Suffix                   5/13/91        Downtown
Group #                           5/13/91        Downtown
ID or group #                     5/13/91        Berryessa
CPT4/HCPCS                        5/13/91        Downtown
Bad patient zip                   5/13/91        Downtown
Prov sub ID                       5/13/91        Downtown
ID #                              5/13/91        Downtown
Missing date                      5/13/91        Downtown
ID #                              5/13/91        Downtown
ID #                              5/13/91        Downtown
ID #                              5/13/91        Downtown
Referring MD                      5/13/91        Downtown
Prov sub ID                       5/13/91        Downtown
Prov sub ID                       5/13/91        Downtown
Blue Shield #                     5/13/91        Downtown
ID #                              5/13/91        Downtown
Referring MD                      5/13/91        Downtown
Medicare Suffix                   5/13/91        Downtown
Group #                           5/13/91        Berryessa
ID #                              5/13/91        Downtown
Medicare Suffix                   5/13/91        Downtown
Prov sub ID                       5/13/91        Downtown
Blue Shield #                     5/13/91        Downtown
Prov sub ID                       5/13/91        Downtown
ID #                              5/13/91        Downtown
ID #                              5/13/91        Downtown
ID #                              5/13/91        Downtown
Referring MD                      5/13/91        Downtown
Group #                           5/13/91        Downtown
ID or group #                     5/13/91        Berryessa
Medicare Suffix                   5/13/91        Downtown
Referring MD                      5/13/91        Downtown
Prov sub ID                       5/13/91        Downtown
ID #                              5/13/91        Oakridge
ID #                              5/13/91        Berryessa
ID #                              5/13/91        Downtown
Medicare Suffix                   5/13/91        Downtown
Bad carrier zip                   5/13/91        Downtown
Missing date                      5/13/91        Downtown
Blue Shield #                     5/13/91        Downtown
Prov sub ID                       5/13/91        Downtown
Missing service                   5/13/91        Downtown
ID #                              5/13/91        Milpitas
Group #                           5/13/91        Downtown
Prov sub ID                       5/13/91        Downtown
ID #                              5/13/91        Downtown
ID or group #                     5/13/91        Milpitas
ID #                              5/13/91        Downtown
Referring MD                      5/13/91        Downtown
Referring MD                      5/13/91        Downtown
Blue Shield #                     5/13/91        Downtown
ID #                              5/13/91        Downtown
ID #                              5/13/91        Downtown
ID #                              5/13/91        Oakridge
ID #                              5/14/91        Berryessa
Group #                           5/14/91        Downtown
Referring MD                      5/14/91        Downtown
Group #                           5/14/91        Berryessa
ID #                              5/14/91        Oakridge
ID or group #                     5/14/91        Berryessa
ID #                              5/14/91        Downtown
Group #                           5/14/91        Downtown
Bad carrier zip                   5/14/91        Downtown
Referring MD                      5/14/91        Downtown
Group #                           5/14/91        Milpitas
Blue Shield #                     5/14/91        Downtown
Prov sub ID                       5/14/91        Downtown
Medicare Suffix                   5/14/91        Downtown
Group #                           5/14/91        Downtown
ID or group #                     5/14/91        Berryessa
run;

title 'Insurance Claims Data Set';

proc print data=claims(obs=25);
  var reason date location;
run;


/*The following code appears on p. 314 */

data fills;
  input filltime filllevl fillpres;
cards;
1.99   12.018  40.26
1.983  11.939  39.34
1.999  11.957  40.72
2.038  12.233  39.6
2.031  12.095  39.36
1.988  11.918  38.95
2.05   12.277  40.73
2.022  12.168  39.04
1.997  11.996  39.71
1.98   11.898  41.94
2.005  12.017  41.02
1.986  11.874  38.42
2.01   11.953  40.45
2.011  12.065  41.67
1.992  11.874  40.43
2.022  12.134  39.11
1.991  11.889  39.98
2.011  12.091  40.09
1.99   11.785  39.33
1.977  11.933  41.14
2.033  12.248  39.19
1.982  11.9    41.28
1.968  11.825  38.67
1.971  11.805  40.43
1.966  11.728  40.98
2.037  12.245  39.99
1.959  11.711  40.99
2.026  12.072  41.19
1.992  11.905  40.1
1.937  11.666  40.92
run;

title 'Soft Drink Filling Data';

proc print data=fills;
run;


/*The following code appears on pp. 315-316 */

data framepre;
  input day samples defects;
cards;
1   50    6
2   50    1
3   50    5
4   50    7
5   50    7
6   50    8
7   50    10
8   50    5
9   50    1
10  50    10
11  50    10
12  50    18
13  50    17
14  50    7
15  50    8
16  50    0
17  50    4
18  50    20
19  50    17
20  50    5
21  50    4
22  50    3
23  50    7
24  50    9
25  50    3
run;

title 'Computer Monitor Frames Preliminary Study Data';

proc print;
run;

data frames1;
  input day samples defects;
cards;
26  50    1
27  50    1
28  50    4
29  50    6
30  50    7
31  50    8
32  50    8
33  50    5
34  50    1
35  50    1
36  50    3
37  50    8
38  50    7
39  50    7
40  50    8
41  50    3
42  50    4
43  50    2
44  50    1
45  50    5
46  50    6
47  50    3
48  50    7
49  50    2
50  50    4
run;

title 'Computer Monitor Frames Production Data';

proc print;
run;


/*The following code appears on pp. 316-317 */


data wood;
  input kiln batch $ @;
  do sample=1 to 5;
     input shrink @@;
     output;
  end;
cards;
4  A33   10.11  11.12  10.72  11.72  11.00
1  A34   11.23  10.75  11.34  10.13  10.11
2  A35   12.22  10.46  11.47  10.54  10.12
3  A36   10.25  11.96  12.22  10.63  10.46
4  A37   12.24  12.32  12.52  12.43  12.37
4  A38   12.26  12.00  10.18  10.57  10.58
2  A39   10.70   9.66  11.21  10.96  10.86
4  A40   11.11  10.67  10.98  10.68  10.67
1  A41   10.44   9.83   9.19   8.79   9.27
3  A42   11.32  11.47   9.38  10.19  10.48
4  A43   11.43  11.36  11.23  11.64  11.55
2  A44   10.45  10.38  10.22  11.24  10.42
2  A45   11.45  11.52  10.64  10.67  11.45
1  A46   10.13  10.17  10.56  12.34  10.64
4  A47    9.66  10.32  10.43  11.56  10.67
3  A48   11.71  11.32  11.20  11.61  11.67
3  A49   11.22  11.49  11.42  11.38  11.44
3  A50   11.41  11.61  11.67  11.56  11.49
1  A51   10.92  10.96  10.27   9.48  10.95
2  A52   10.02   9.58  10.17  11.14   9.15
2  A53   10.92  10.58  10.87  11.14  10.85
1  A54   10.92  10.96  10.27   9.48  10.95
3  A55   11.42  11.98  11.57  11.64  11.35
4  A56   10.99  10.58  10.17   9.84  10.85
run;


/*The following code appears on pp. 317-318 */

data kiln3;
  input kiln batch $ @;
  do sample=1 to 5;
    input shrink @@;
    output;
  end;
cards;
3  A61    10.91   11.53   11.24   11.30   10.30
3  A62    10.13   10.49   11.02    9.88   10.81
3  A63    11.30   11.23   10.73   11.52   10.35
3  A64     9.63   11.12   11.96   11.32   10.69
3  A65    11.29   11.08   11.08   10.90   10.20
3  A66    10.38   11.31   10.38   10.63   11.01
3  A67    11.10   10.69   11.19   10.73   11.70
3  A68    10.50   11.34    9.93   10.99   11.47
3  A69    10.85   11.30   11.31   11.03   10.44
3  A70    10.45   11.10   11.28   11.71   11.07
3  A71    10.02   10.75   11.14   10.49   11.46
3  A72    11.11   11.46   10.72   10.55   11.03
3  A73    11.73   10.93   11.96   11.79   11.92
3  A74    13.00   10.90   11.15   11.57   11.57
3  A75    11.60   11.19   11.65   11.13   11.62
run;


/*The following code appears on pp. 318-319 */

data impone;
  input day impure;
cards;
1   2.33
2   1.90
3   2.27
4   1.40
5   1.54
6   1.39
7   2.14
8   1.89
9   1.92
10   1.76
11   1.85
12   1.79
13   1.37
14   2.12
15   2.97
16   3.13
17   2.12
18   2.47
19   2.37
20   2.28
21   2.80
22   2.88
23   2.33
24   2.45
25   2.71
run;

data imptwo;
  input day impure;
cards;
26   2.78
27   3.65
28   2.72
29   1.85
30   1.99
31   1.84
run;


data impthree;
  input day impure;
cards;
32   2.06
33   2.25
34   2.12
35   1.83
36   2.58
37   2.65
38   1.48
39   2.27
40   1.79
41   1.57
42   1.66
43   2.34
44   2.08
45   2.09
46   2.43
47   2.37
48   1.99
49   2.18
50   2.34
51   2.00
52   2.36
53   1.91
54   2.46
55   1.36
run;


/*The following code appears on p. 320 */

data primevis;
  input viscosty @@;
  batch + 1;
cards;
   49.46   50.15   49.12   49.42   50.54   50.72   50.56
   49.83   47.83   47.96   49.09   47.88   49.85   50.54
   49.01   49.93   50.57   48.86   50.43   50.18   49.95
   47.57   49.07   50.13   51.50   51.99   50.71   51.64
   52.13   51.24
run;

title 'Aircraft Primer Paint Viscosity Data';

proc print;
run;


/*The following code appears on pp. 320-321 */

data bikes;
   input batch sampsize defects style $;
cards;
1   3    3     26G
2   3    9     26B
3   4   12     24B
4   5   12     20G
5   3    6     26G
6   8   10     12B
7   10  20     14B
8   3   10     26G
9   5    5     16G
10  5    8     16G
11  8    7     12B
12  10   12    14G
13  8    25    12B
14  3    2     RAB
15  3    6     26B
16  5    9     16B
17  5    12    16B
18  8    15    12G
19  5    14    20B
20  3    19    26G
run;


/*The following code appears on p. 321 */

data hemoglob;
  input run consamp hemoglob @@;
cards;
1 1 12.21   1 2 12.05   1 3 12.05
2 1 11.88   2 2 12.25   2 3 12.26
3 1 12.14   3 2 11.85   3 3 11.92
4 1 12.05   4 2 12.25   4 3 11.73
5 1 12.01   5 2 11.77   5 3 11.94
6 1 12.03   6 2 12.06   6 3 12.15
7 1 12.04   7 2 11.98   7 3 11.79
8 1 12.09   8 2 12.10   8 3 12.37
9 1 12.23   9 2 12.01   9 3 12.14
run;

title 'Hemoglobin Check Samples';

proc print;
run;


/*The following code appears on p. 322 */

data corn;
  input batch xbar  @@;
cards;
 1  16.15    2  16.07    3  16.11    4  16.03
 5  16.09    6  15.97    7  15.93    8  15.91
 9  15.98   10  15.67   11  16.15   12  15.88
run;

title 'Canned Corn Process Data';
title2 'Fill Level in Ounces';

proc print;
run;


/*The following code appears on pp. 322-323 */

data wings;
  input hour width;
  hr2=hour**2;
cards;
    1   49.9988
    3   49.9975
    5   49.9939
    7   49.9958
    9   50.0063
   11   50.0210
   13   49.9628
   15   50.0350
   17   50.0316
   19   50.0233
   21   49.9787
   23   50.0399
   25   50.0119
   27   50.0874
   29   50.0430
   31   50.0770
   33   50.0726
   35   50.0704
   37   50.0940
   39   50.0979
   41   50.0895
   43   50.1111
   45   50.0703
   47   50.1252
   49   50.1642
   51   50.1853
   53   50.1065
   55   50.1046
   57   50.1211
   59   50.1407
   61   50.1970
   63   50.1650
   65   50.2264
   67   50.2234
   69   50.2244
   71   50.2289
   73   50.2428
   75   50.2657
   77   50.2808
   79   50.2956
   81   50.2969
   83   50.3618
   85   50.3379
   87   50.4269
   89   50.4081
   91   50.3711
   93   50.4217
   95   50.5126
   97   50.4793
   99   50.4448
  101   50.4594
  103   50.5488
  105   50.5368
  107   50.4995
  109   50.6032
  111   50.6219
  113   50.6075
  115   50.6258
  117   50.6788
  119   50.7506
run;

title 'Wooden Airplane Wing Width Data';

proc print data=wings(obs=20);
  var hour width;
run;


/*The following code appears on pp. 324-329 */

data diams;
  input partno $ line $ diameter @@;
cards;
AA445 A 221.0   AA446 B 230.2   AA447 B 229.6   AA448 A 225.6   AA449 B 229.0
AA450 B 230.1   AA451 A 223.4   AA452 B 232.3   AA453 B 228.3   AA454 B 233.1
AA455 A 220.2   AA456 B 233.7   AA457 A 224.8   AA458 B 230.4   AA459 A 223.9
AA460 B 229.9   AA461 B 232.8   AA462 A 224.5   AA463 B 229.7   AA464 A 222.1
AA465 B 231.9   AA466 A 221.2   AA467 A 222.2   AA468 B 228.4   AA469 B 230.6
AA470 A 220.7   AA471 B 228.9   AA472 B 234.1   AA473 B 234.1   AA474 B 229.0
AA475 B 225.0   AA476 B 232.2   AA477 B 229.6   AA478 B 231.0   AA479 B 230.7
AA480 B 229.8   AA481 B 230.0   AA482 B 231.5   AA483 B 231.3   AA484 B 232.0
AA485 B 227.1   AA486 B 229.0   AA487 A 221.7   AA488 A 227.1   AA489 A 221.4
AA490 A 221.1   AA491 B 230.1   AA492 B 233.3   AA493 A 222.3   AA494 B 231.6
AA495 B 233.4   AA496 A 223.9   AA497 A 222.1   AA498 B 233.8   AA499 A 221.8
AA500 B 228.4   AA501 A 224.0   AA502 A 220.9   AA503 B 231.9   AA504 B 234.5
AA505 B 229.9   AA506 B 231.9   AA507 A 222.8   AA508 B 231.3   AA509 B 226.7
AA510 A 223.2   AA511 B 230.8   AA512 B 233.3   AA513 A 223.2   AA514 B 233.3
AA515 B 231.9   AA516 B 230.0   AA517 A 223.5   AA518 A 227.1   AA519 B 227.8
AA520 B 226.2   AA521 B 228.2   AA522 B 231.4   AA523 B 228.3   AA524 B 230.3
AA525 A 223.5   AA526 B 231.9   AA527 B 230.9   AA528 B 231.7   AA529 A 226.4
AA530 B 230.9   AA531 B 232.3   AA532 B 231.7   AA533 A 225.3   AA534 B 229.9
AA535 A 220.1   AA536 A 224.2   AA537 A 227.9   AA538 B 229.3   AA539 B 233.1
AA540 B 229.1   AA541 A 219.5   AA542 B 232.6   AA543 B 231.3   AA544 B 233.0
AA545 A 224.6   AA546 A 225.2   AA547 A 225.5   AA548 A 224.1   AA549 B 233.4
AA550 A 223.8   AA551 A 223.6   AA552 B 230.4   AA553 A 226.0   AA554 B 230.1
AA555 B 233.0   AA556 B 227.2   AA557 A 225.1   AA558 B 230.2   AA559 B 231.2
AA560 B 231.3   AA561 B 225.2   AA562 B 229.7   AA563 B 232.3   AA564 B 231.2
AA565 B 231.6   AA566 A 225.7   AA567 B 229.7   AA568 A 225.2   AA569 B 228.6
AA570 B 232.4   AA571 A 222.2   AA572 B 230.5   AA573 B 229.6   AA574 B 233.1
AA575 B 231.7   AA576 A 224.9   AA577 B 230.2   AA578 B 230.5   AA579 B 232.0
AA580 B 231.7   AA581 B 231.7   AA582 B 227.9   AA583 B 229.7   AA584 B 229.1
AA585 A 225.6   AA586 B 231.2   AA587 B 230.5   AA588 A 223.6   AA589 B 226.0
AA590 B 230.2   AA591 B 229.5   AA592 B 230.6   AA593 B 226.9   AA594 B 229.3
AA595 B 227.6   AA596 B 229.0   AA597 A 225.5   AA598 A 225.7   AA599 B 226.0
AA600 A 223.6   AA601 B 230.8   AA602 B 230.3   AA603 B 230.9   AA604 B 228.7
AA605 B 227.9   AA606 A 223.7   AA607 B 231.5   AA608 A 223.7   AA609 B 227.4
AA610 B 226.0   AA611 B 230.3   AA612 B 224.6   AA613 A 223.6   AA614 B 230.2
AA615 B 230.9   AA616 B 231.5   AA617 A 222.6   AA618 A 223.3   AA619 B 232.1
AA620 B 232.1   AA621 B 226.1   AA622 B 228.9   AA623 B 233.2   AA624 A 226.3
AA625 B 231.8   AA626 B 228.2   AA627 B 230.7   AA628 A 225.6   AA629 B 227.4
AA630 B 229.6   AA631 A 222.3   AA632 B 232.3   AA633 B 228.9   AA634 A 225.3
AA635 B 232.4   AA636 B 226.9   AA637 B 230.5   AA638 B 231.2   AA639 A 224.5
AA640 A 223.3   AA641 A 223.7   AA642 B 231.2   AA643 B 230.2   AA644 B 230.3
AA645 A 226.4   AA646 B 223.9   AA647 A 224.9   AA648 B 229.8   AA649 A 227.6
AA650 B 227.0   AA651 B 229.3   AA652 A 227.0   AA653 B 229.3   AA654 B 228.2
AA655 A 224.3   AA656 B 228.1   AA657 A 225.5   AA658 B 229.1   AA659 A 220.1
AA660 B 230.2   AA661 B 231.2   AA662 B 233.1   AA663 B 232.6   AA664 B 229.5
AA665 A 220.5   AA666 B 227.8   AA667 B 233.1   AA668 A 226.2   AA669 A 222.8
AA670 B 229.4   AA671 B 225.4   AA672 A 225.7   AA673 B 227.7   AA674 B 230.6
AA675 A 223.8   AA676 B 227.1   AA677 B 228.5   AA678 A 223.7   AA679 B 228.1
AA680 A 221.7   AA681 B 231.8   AA682 B 231.4   AA683 B 231.8   AA684 A 226.1
AA685 B 226.4   AA686 B 232.1   AA687 B 232.8   AA688 B 231.2   AA689 B 233.1
AA690 A 221.4   AA691 A 222.7   AA692 B 229.6   AA693 A 226.0   AA694 A 223.7
AA695 A 220.3   AA696 B 235.4   AA697 B 232.7   AA698 A 221.2   AA699 B 225.9
AA700 A 223.3   AA701 A 226.1   AA702 A 229.5   AA703 B 229.7   AA704 A 224.8
AA705 B 231.9   AA706 B 229.2   AA707 A 226.2   AA708 B 230.1   AA709 B 231.6
AA710 A 222.6   AA711 A 228.2   AA712 B 227.6   AA713 A 223.5   AA714 B 229.3
AA715 B 225.4   AA716 A 226.4   AA717 B 228.7   AA718 B 230.9   AA719 A 224.2
AA720 B 232.8   AA721 B 227.8   AA722 A 225.6   AA723 A 224.9   AA724 B 229.3
AA725 B 232.5   AA726 B 228.7   AA727 A 221.4   AA728 B 228.0   AA729 B 230.7
AA730 A 224.7   AA731 A 225.0   AA732 B 229.2   AA733 A 222.7   AA734 B 229.2
AA735 B 227.8   AA736 B 229.7   AA737 B 227.9   AA738 B 229.7   AA739 B 229.2
AA740 B 228.2   AA741 A 221.6   AA742 B 230.3   AA743 B 234.8   AA744 A 220.6
AA745 A 225.2   AA746 B 230.7   AA747 B 229.5   AA748 A 225.2   AA749 B 229.9
AA750 B 231.3   AA751 B 228.2   AA752 A 226.0   AA753 B 231.1   AA754 B 230.8
AA755 B 233.3   AA756 B 229.8   AA757 B 234.1   AA758 B 227.7   AA759 A 225.9
AA760 B 229.2   AA761 B 227.1   AA762 B 228.4   AA763 B 231.7   AA764 B 231.6
AA765 B 229.0   AA766 A 223.6   AA767 B 229.7   AA768 B 230.1   AA769 A 225.1
AA770 A 222.4   AA771 B 227.9   AA772 B 230.4   AA773 B 230.4   AA774 B 228.4
AA775 A 227.5   AA776 B 227.5   AA777 A 221.3   AA778 B 229.8   AA779 A 223.9
AA780 A 224.7   AA781 B 229.4   AA782 A 223.4   AA783 B 228.9   AA784 B 231.9
AA785 A 225.7   AA786 B 226.4   AA787 A 226.3   AA788 B 230.2   AA789 A 226.0
AA790 A 223.1   AA791 B 233.0   AA792 A 222.8   AA793 A 224.1   AA794 B 229.8
AA795 B 233.7   AA796 A 225.6   AA797 A 224.6   AA798 A 222.6   AA799 B 233.5
AA800 B 229.6   AA801 B 227.3   AA802 A 223.9   AA803 B 229.7   AA804 B 231.1
AA805 B 232.6   AA806 A 224.0   AA807 B 229.8   AA808 B 231.2   AA809 B 229.3
AA810 B 226.8   AA811 B 226.8   AA812 B 231.2   AA813 A 225.6   AA814 A 225.8
AA815 B 231.1   AA816 B 232.0   AA817 A 222.2   AA818 B 230.6   AA819 B 230.5
AA820 A 222.6   AA821 B 234.2   AA822 B 231.3   AA823 A 223.9   AA824 A 226.6
AA825 B 235.8   AA826 B 229.8   AA827 B 234.2   AA828 B 230.2   AA829 B 231.8
AA830 A 223.3   AA831 B 226.8   AA832 B 228.3   AA833 B 233.0   AA834 A 223.5
AA835 B 230.8   AA836 B 229.0   AA837 A 225.2   AA838 B 229.5   AA839 B 227.0
AA840 B 233.9   AA841 B 230.5   AA842 B 230.1   AA843 A 224.8   AA844 B 228.9
AA845 B 230.3   AA846 B 230.9   AA847 B 227.5   AA848 A 225.3   AA849 B 232.1
AA850 B 229.7   AA851 B 229.4   AA852 B 228.8   AA853 B 228.9   AA854 B 228.7
AA855 B 229.5   AA856 B 229.0   AA857 A 225.1   AA858 B 233.2   AA859 B 230.2
AA860 A 222.1   AA861 B 228.2   AA862 B 231.1   AA863 A 220.9   AA864 B 224.2
AA865 B 231.8   AA866 B 228.3   AA867 B 229.1   AA868 A 223.2   AA869 B 228.4
AA870 B 231.2   AA871 A 227.1   AA872 B 231.0   AA873 B 228.4   AA874 B 230.0
AA875 A 222.3   AA876 A 229.5   AA877 A 222.3   AA878 A 223.6   AA879 B 230.6
AA880 A 223.3   AA881 B 231.6   AA882 B 235.0   AA883 B 230.9   AA884 A 225.4
AA885 B 230.9   AA886 B 227.1   AA887 B 229.0   AA888 B 229.0   AA889 B 224.0
AA890 B 227.0   AA891 B 234.5   AA892 B 229.6   AA893 A 223.4   AA894 B 231.9
AA895 B 226.2   AA896 B 227.6   AA897 B 230.7   AA898 A 224.6   AA899 A 220.7
AA900 B 229.2   AA901 B 227.5   AA902 B 233.4   AA903 B 234.9   AA904 B 230.2
AA905 B 234.0   AA906 A 224.6   AA907 A 224.0   AA908 B 230.5   AA909 B 229.0
AA910 B 229.2   AA911 B 228.8   AA912 A 223.5   AA913 A 228.0   AA914 B 230.2
AA915 B 229.4   AA916 B 227.0   AA917 B 230.8   AA918 B 229.8   AA919 A 222.7
AA920 B 228.6   AA921 A 223.1   AA922 A 222.8   AA923 B 225.9   AA924 B 228.0
AA925 A 224.9   AA926 B 231.5   AA927 B 230.6   AA928 A 223.1   AA929 A 223.1
AA930 B 231.4   AA931 B 225.9   AA932 A 220.9   AA933 B 231.7   AA934 B 227.5
AA935 B 229.6   AA936 B 233.3   AA937 A 220.8   AA938 B 231.8   AA939 A 224.2
AA940 B 228.3   AA941 B 228.1   AA942 B 229.9   AA943 B 230.6   AA944 A 223.4
AA945 A 223.8   AA946 B 230.9   AA947 B 227.9   AA948 A 224.4   AA949 B 229.7
AA950 A 222.2   AA951 B 227.6   AA952 A 221.6   AA953 B 232.7   AA954 B 229.8
AA955 B 234.1   AA956 B 230.1   AA957 B 229.9   AA958 B 228.1   AA959 B 230.2
AA960 B 231.2   AA961 A 224.8   AA962 B 232.6   AA963 A 222.8   AA964 B 231.8
AA965 B 230.2   AA966 B 232.5   AA967 B 227.2   AA968 B 229.7   AA969 B 230.4
AA970 B 229.0   AA971 B 232.6   AA972 B 232.2   AA973 A 224.6   AA974 A 223.7
AA975 B 229.3   AA976 B 230.9   AA977 B 231.8   AA978 B 229.0   AA979 B 229.5
AA980 B 229.7   AA981 B 229.0   AA982 B 228.9   AA983 A 224.1   AA984 A 221.9
AA985 B 225.8   AA986 A 226.1   AA987 B 232.3   AA988 B 229.0   AA989 A 226.0
AA990 B 230.4   AA991 B 231.2   AA992 A 224.7   AA993 B 234.0   AA994 B 229.3
AA995 A 224.6   AA996 B 229.5   AA997 A 226.2   AA998 B 228.7   AA999 A 218.0
AA1000 A 224.8   AA1001 B 229.1   AA1002 B 228.5   AA1003 B 231.4   AA1004 A 223.8
AA1005 A 222.8   AA1006 B 236.0   AA1007 B 233.0   AA1008 B 229.8   AA1009 B 234.2
AA1010 A 223.5   AA1011 A 223.7   AA1012 B 229.8   AA1013 B 229.9   AA1014 B 228.1
AA1015 B 230.2   AA1016 B 229.5   AA1017 A 221.9   AA1018 A 222.2   AA1019 A 225.3
AA1020 B 228.3   AA1021 B 227.6   AA1022 A 223.1   AA1023 B 229.5   AA1024 B 231.6
AA1025 B 230.5   AA1026 B 230.1   AA1027 A 224.0   AA1028 B 231.3   AA1029 B 228.9
AA1030 A 222.4   AA1031 A 222.4   AA1032 A 224.0   AA1033 B 230.9   AA1034 B 230.2
AA1035 A 223.0   AA1036 A 225.9   AA1037 A 222.2   AA1038 B 228.1   AA1039 A 225.1
AA1040 B 228.2   AA1041 B 231.1   AA1042 B 228.9   AA1043 B 229.6   AA1044 B 227.2
AA1045 B 231.9   AA1046 A 227.8   AA1047 B 227.3   AA1048 B 228.1   AA1049 B 232.8
AA1050 B 232.6   AA1051 A 223.7   AA1052 A 224.5   AA1053 B 230.9   AA1054 B 230.6
AA1055 B 231.0   AA1056 B 234.3   AA1057 B 225.5   AA1058 B 231.5   AA1059 A 222.1
AA1060 B 229.8   AA1061 B 232.6   AA1062 B 233.0   AA1063 B 228.9   AA1064 B 227.8
AA1065 B 229.7   AA1066 B 228.2   AA1067 B 228.7   AA1068 A 225.3   AA1069 B 232.8
AA1070 B 229.4   AA1071 B 228.2   AA1072 B 231.0   AA1073 B 227.2   AA1074 B 231.0
AA1075 B 231.3   AA1076 B 228.4   AA1077 A 225.3   AA1078 B 229.9   AA1079 A 223.5
AA1080 B 226.7   AA1081 B 229.8   AA1082 B 232.1   AA1083 B 231.3   AA1084 A 222.8
AA1085 B 230.8   AA1086 B 230.2   AA1087 A 222.3   AA1088 B 232.9   AA1089 A 224.3
AA1090 B 230.8   AA1091 B 227.8   AA1092 B 229.0   AA1093 B 233.8   AA1094 A 220.1
AA1095 A 224.2   AA1096 B 229.4   AA1097 B 232.0   AA1098 B 231.0   AA1099 B 232.1
AA1100 A 224.9   AA1101 B 228.7   AA1102 B 230.0   AA1103 B 232.3   AA1104 B 228.4
AA1105 B 232.8   AA1106 B 231.5   AA1107 B 228.8   AA1108 B 231.6   AA1109 B 224.5
AA1110 B 231.2   AA1111 B 231.8   AA1112 B 231.1   AA1113 B 227.1   AA1114 B 229.3
AA1115 B 232.4   AA1116 B 231.6   AA1117 B 227.7   AA1118 B 231.2   AA1119 B 234.1
AA1120 A 224.5   AA1121 A 226.8   AA1122 B 232.4   AA1123 B 226.9   AA1124 A 223.8
AA1125 B 232.2   AA1126 B 232.6   AA1127 B 228.7   AA1128 B 227.5   AA1129 A 221.8
AA1130 B 233.3   AA1131 B 232.5   AA1132 B 228.4   AA1133 B 232.9   AA1134 A 223.9
AA1135 B 231.0   AA1136 A 222.5   AA1137 A 223.8   AA1138 B 231.7   AA1139 B 230.5
AA1140 B 227.4   AA1141 A 221.0   AA1142 B 231.1   AA1143 B 226.8   AA1144 B 229.1
AA1145 A 228.2   AA1146 B 227.8   AA1147 A 226.2   AA1148 B 231.6   AA1149 B 233.2
AA1150 B 230.0   AA1151 B 231.0   AA1152 A 223.0   AA1153 A 224.2   AA1154 B 230.7
AA1155 B 228.6   AA1156 A 222.0   AA1157 B 231.8   AA1158 B 228.8   AA1159 A 223.1
AA1160 A 223.4   AA1161 A 225.4   AA1162 B 227.2   AA1163 A 226.4   AA1164 B 231.6
AA1165 B 229.7   AA1166 B 227.3   AA1167 B 232.7   AA1168 A 222.6   AA1169 B 228.7
AA1170 B 229.8   AA1171 B 229.0   AA1172 B 227.9   AA1173 B 226.7   AA1174 B 230.1
AA1175 A 222.8   AA1176 B 227.2   AA1177 A 220.0   AA1178 A 223.7   AA1179 B 226.4
AA1180 A 224.0   AA1181 A 221.8   AA1182 A 223.5   AA1183 A 226.9   AA1184 A 226.3
AA1185 A 227.1   AA1186 B 231.2   AA1187 B 225.5   AA1188 B 226.9   AA1189 B 227.9
AA1190 B 232.6   AA1191 B 232.7   AA1192 B 230.9   AA1193 B 232.2   AA1194 A 224.5
run;


/*The following code appears on p. 329 */

data boards; infile 'borthick.dat';
  input thick @@;
label thick='Thickness (mm)';
run;

title 'Board Thickness Data';

proc print data=boards(obs=25);
run;


/*The following code appears on p. 331 */

data wstools;
  input assmtime @@;
cards;
   0.4   0.7   7.7   1.2   0.5
   0.4   4.2   1.3   0.6   0.9
   1.2   1.4   2.3   1.1   2.1
   0.4   0.3   0.7   0.3   0.9
   0.2   1.9   3.5   4.8   1.4
   2.1   0.9   3.3   3.6   0.4
   0.2   0.9   1.1   0.4   2.6
   0.4   4.3   0.2   5.8   0.1
   3.5   4.5   1.0   3.6   1.7
   0.3   0.5   6.0   5.0   0.4
   0.1   0.4   1.9   1.8   2.4
   5.9   4.0   0.8   7.6   0.5
   0.8   5.2   3.8   0.3   0.4
   2.9   1.0   0.3   4.9   4.6
   2.0   4.0   1.9   6.9   3.4
   5.4   2.7   1.5   0.6   3.0
   2.2   0.4   0.9   4.7   2.4
   2.7   1.4   0.4   0.1   1.5
   1.2   1.0   0.5   1.9   3.6
   2.2   2.3   2.9   3.9   1.4
   1.5   1.2   2.0   1.1   0.7
   2.1   2.1   2.8   5.3   1.8
   0.3   9.0   1.4   2.5   2.2
   1.1   1.1   1.9   1.7   0.5
   0.4   0.7   2.4   2.3   1.0
run;

title 'Wooden Stool Assembly Times';
title2 'in Minutes';

proc print;
run;


/*The following code appears on p. 332 */

data engines;
   input survtime @@;
label survtime='Survival Time (hrs.)';
cards;
        25.0        53.7        67.7        13.8        50.8
        62.8        22.6        47.8        75.1        66.5
        23.3        45.1         7.5        58.7        27.3
        37.3        38.8        17.4        72.5        17.4
        31.1        23.7        28.1        53.0        39.4
        11.3        93.2        33.5        30.8        49.6
        35.1        54.4        38.3        57.0        39.0
        37.0        79.8        77.8        35.6        29.8
        41.9        71.9        25.0         8.3        24.5
         8.4        80.6        29.6        15.0        56.8
        30.6        21.8        22.2        53.8        23.1
        37.9        27.9        19.5        80.1        85.5
        59.7        61.5        22.2        29.1        59.1
        17.7        42.6        29.0        28.0        37.8
        84.7        32.7        25.2        20.1        80.5
        40.4        51.2        65.1        78.4        62.6
         0.7       118.4        61.0       104.6        18.6
        29.5       112.7        52.0        18.3        76.4
        24.8         8.3         9.4        62.8        56.4
        51.8        19.7        30.0        54.7        33.7
        16.5
run;

title 'Car Engine Reliability Data';

proc print data=engines(obs=25);
run;


/*The following code appears on p. 333 */

data bricks;
  input time temp @;
     do rep=1 to 4;
       input mor @;
       output;
     end;
cards;
23  2365   650   655   651   659
23  2370   680   685   679   674
23  2375   683   684   684   681
24  2365   620   626   627   630
24  2370   770   793   792   771
24  2375   699   703   711   713
25  2365   707   718   710   693
25  2370   754   764   785   776
25  2375   729   736   707   709
run;

title 'Refractory Brick Data';

proc print;
run;


/*The following code appears on p. 333 */

data phosacid;
  input perwater @@;
cards;
19.85  19.50  19.90  20.58  19.88  19.16  18.03  18.80
run;

data rugged; merge rugged phosacid;
  rename a=amtwater b=reactime c=distrate d=disttime
         e=n_Heptan f=aniline  g=reagant;
run;

proc print;
run;


/*The following code appears on p. 334 */

data bricks;
  input time temp mor;
  codetime=time-24;
  codetemp=(temp-2370)/5;
  if _n_<5 then lof=_n_; else lof=5;
cards;
23 2365  640
23 2375  650
25 2365  780
25 2375  830
24 2370  800
24 2370  804
24 2370  803
24 2370  802
run;

title 'Refractory Brick Response Surface Experiment Data';

proc print data=bricks;
run;


data brickpt2;
  input mor @@;
cards;
640  650  780  830  620 770  650  670  800  804  803  802  802
run;

data sasuser.brickrs;
   merge sasuser.brickrs brickpt2;
run;

title 'Refractory Brick Response Surface Experiment Data - Part 2';
title2 'Central Composite Design Response Data';

proc print data=sasuser.brickrs;
run;


/*The following code appears on p. 335 */

data hplc;
   input red_no2 peak;
label peak='HPLC Peak Area'
      red_no2='FD&C Red No.2 Concentration';
cards;
0.18    26.666
0.35    50.651
0.055    9.628
0.022    4.634
0.29    40.206
0.15    21.369
0.044    5.948
0.028    4.245
0.044    4.786
0.073   11.321
0.13    18.456
0.088   12.865
0.26    35.186
0.16    24.245
0.10    14.175
run;

title 'Linear Calibration Data';
symbol i=none v=dot h=.7;

proc gplot data=hplc;
  plot peak*red_no2;
run;


/*The following code appears on p. 336 */

data heights;
  input operator $ part @;
  do measure=1 to 2;
     input height @;
     output;
  end;
cards;
BOB  1  8.011  8.015
BOB  2  8.013  8.015
BOB  3  8.030  8.037
BOB  4  7.988  7.982
BOB  5  7.997  8.002
BOB  6  7.958  7.952
BOB  7  8.008  8.009
JIM  1  8.016  8.010
JIM  2  8.013  8.014
JIM  3  8.031  8.029
JIM  4  7.980  7.987
JIM  5  7.993  7.991
JIM  6  7.949  7.955
JIM  7  8.002  8.003
JOE  1  8.017  8.011
JOE  2  8.014  8.008
JOE  3  8.029  8.029
JOE  4  7.985  7.988
JOE  5  8.000  8.001
JOE  6  7.951  7.955
JOE  7  8.000  8.005
run;

title 'Height Gauge R&R Study Data';

proc print data=heights;
run;


/*The following code appears on p. 337 */

data pbutter;
  input lab sample aflatox;
cards;
1  1  13
1  2   9
2  1   6
2  2   6
4  1   9
4  2  16
6  1   7
6  2   9
7  1   6
7  2   6
8  1   8
8  2   7
9  1  15
9  2   9
10 1   6
10 2   6
11 1   8
11 2   9
12 1   6
12 2   5
13 1   7
13 2  13
run;

title 'Peanut Butter Contamination Data';
title2 'Total Aflatoxins as Measured by Biokits ELISA Test';

proc print data=pbutter;
run;


---------------
Appendix B
---------------

/*The following code appears on pp. 339-340 */


options nodate pageno=1 ls=72;

%macro samptab(ltpd=, conrisk=, aql=);

data dr;
  ltpd=&ltpd;  conrisk=&conrisk; aql=&aql;

  do lotn=100 to 400 by 10;
    ati=1E10;
    do newc=0 to 30;
      newn=newc+3;
      do until ((ppp le conrisk) or (n ge lotn));
        newn=newn+1;
        k = int(ltpd*lotn);
        if ((newc lt max(0,k+newn-lotn)) or
            (newc gt min(k,lotn))) then ppp=0;
           else ppp=probhypr(lotn,k,newn,newc);
      end;
      if ppp=0 then newpa=0;
         else newpa=probbnml(aql,newn,newc);
      newati=newn+((lotn-newn)*(1-newpa));
      if newati lt ati then do;
        ati=newati;  c=newc;  n=newn;  pa=newpa; pa_ltpd=ppp; end;
    end;
    output;
  end;
keep lotn n c ati pa ltpd aql pa_ltpd conrisk;
run;
data dr; set dr;
  dummy='Accept.';
  dummy2='Inspection';
run;

title 'Dodge Romig LTPD Plan Sampling Table';

proc tabulate data=dr format=f4.0 noseps;
  label ltpd='LTPD=' aql='AQL=' c='Acceptance Number'
        dummy='Prob. of'
        dummy2='Ave. Tot.'
        pa='at AQL'
        pa_ltpd='at LTPD'
        ati='at AQL'
        lotn='Lot Size'
        conrisk='Consumer Risk at LTPD=';
  class ltpd conrisk aql lotn c dummy dummy2;
  var n pa ati pa_ltpd;
  table (ltpd*conrisk*aql),lotn,c*n='  '*(sum='   ')
        dummy*pa*(sum='   '*f=8.5)
        dummy2*ati*(sum='   '*f=10.1)
        dummy*pa_ltpd*(sum='   '*f=8.5) / misstext=' '
        box='Sample Size within Table';
run;

%mend samptab;


/*The following code appears on pp. 341-342 */

%macro tolford(nvar=,nominal=,vars=,func=,lsl=,usl=,
               dera=,derb=,derc=,derd=,dere=,derf=,derg=,derh=);

   data one;
     array v v1-v8; retain v1-v8 0;
     array perc perc1-perc8;
     %do i=1 %to &nvar;
        %let x=%scan(a b c d e f g h,&i);
        &x = %scan(&nominal,&i,%str( ));
        var&x = %scan(&vars,&i,%str( ));
     %end;
     meany = &func; func="y=&func"; lsl=&lsl; usl=&usl;
     %do i=1 %to &nvar;
        %let x=%scan(a b c d e f g h,&i);
        v&i = ((&&der&x) ** 2) * var&x;
     %end; ;
     vary = sum(of v1-v8);
     do over v; perc=(v/vary)*100; end;
     sdy = sqrt(vary);
     percy = (probnorm((&usl-meany)/sdy)-probnorm((&lsl-
                              meany)/sdy))*100;
     file print;

     put // @10 50*'*' / @20 'Function:' func
         / @10 50*'*'
                  / @13  'Lower Specification Limit'     @50 lsl 10.5
                  / @13  'Upper Specification Limit'     @50 usl 10.5
                  / @13  'Mean of Output'  @50 meany 10.5
                  / @13  'Standard Deviation of Output' @50 sdy 10.5
                  / @13  'Percent of Output Between Spec Limits' @50
                                                        percy 7.2 '%'
         / @10 50*'*' / @20 'Sensitivity Analysis'
         / @10 50*'*' / @13 'Variance of Output' @50 vary best10.
     %do i=1 %to &nvar;
        %let x=%scan(a b c d e f g h,&i);
                  / @13 "Percent of Var. of Output Due to &x" @50
                                                         perc&i 6.2 '%'
     %end;
         / @10 50*'*';
title 'First Order Tolerance Analysis';
run;

%mend tolford;


---------------
Appendix C
---------------

/*The following code appears on pp. 343-344 */

data one;
  do i=1 to 25;
    x=rannor(123);
    y =1.1*x + rannor(121)/5;
    output;
  end;
run;

data two;
  do i=1 to 25;
    x=rannor(123);
    y =-1.1*x + rannor(121)/5;
    output;
  end;
run;

data three;
  do i=1 to 25;
    y=rannor(12345);
    x=rannor(123);
    output;
  end;
run;

goptions device=os2 hsize=2.2 in vsize=2.2 in;

symbol h=.5 v=dot;

proc gplot data=one;
  plot y*x / vaxis=axis1 haxis=axis2;
  axis1 minor=none value=none major=none;
  axis2 minor=none value=none major=none;
run;

symbol h=.5 v=dot;

proc gplot data=two;
  plot y*x / vaxis=axis1 haxis=axis2;
  axis1 minor=none value=none major=none;
  axis2 minor=none value=none major=none;
run;

symbol h=.5 v=dot;

proc gplot data=three;
  plot y*x / vaxis=axis1 haxis=axis2;
  axis1 minor=none value=none major=none;
  axis2 minor=none value=none major=none;
run;


/*The following code appears on p. 344 */

data obs1;
  input x y ;
cards;
1  1
2  -1
3  1
4  -1
5  1
6  1
7  1
8  1
9  1
10  1
11  1
run;

goptions border hsize=6.5 vsize=5 horigin=1in  device=hplj300;

title '    ';
symbol1 v=dot h=1 c=white;

proc shewhart graphics data=obs1;
  xchart y*x / haxis=0 to 14 by 1 nolegend nolimitslegend
    lcllabel='LCL'  ucllabel='UCL' xsymbol='Center Line'
    mu0=0
    noconnect sigma0=1 font=swissx vaxis=-4 to 4 by 1;
label x='Time' y='Quality Characteristic';
run;


/*The following code appears on p. 345 */

data obs1;
  input x y ;
cards;
1  1
2  -1
3  1
4  -1
5  1
6  1
7  1
8  1
9  1
10  1
11  1
run;

goptions noborder hsize=6.5 vsize=5 horigin=1in  device=hplj300;

title '    ';
symbol1 v=dot h=1 c=white;

proc shewhart graphics data=obs1;
  xchart y*x / haxis=0 to 14 by 1 nolegend nolimitslegend
    lcllabel='LCL'  ucllabel='UCL' xsymbol='Center Line'
    mu0=0
    noconnect sigma0=1 font=swissx vaxis=-4 to 4 by 8;
label x='Time' y='00'X;
run;


/*The following code appears on pp. 345-346 */

data obs2;
  do x=1,2;
  if x=1 then y=d2(2)/2;
    else y=-d2(2)/2;
  output;
  end;
run;


title 'Zones for Supplemental Run Rules';
symbol1 v=dot h=1 c=white i=join;

proc shewhart graphics;
  xchart y*x / haxis=0 to 10 zones zonelabels noconnect nolegend
         font=swissx vaxis=-4 to 4 by 1;
label x='Time' y='Quality Characteristic';
run;


/*The following code appears on p. 346 */

data impone;
  file 'junk111.lst';
  do day=1 to 25;
    if day lt 15 then mean=2;
      else mean=2.45;
    impure=.4*normal(1133) + mean;
    put day impure 6.2;
    output;
  end;
run;

goptions device=hplj300;

title h=.7 'Shewhart Control Chart for Gasoline Impurities';
symbol v=dot h=.5;

proc shewhart data=impone graphics;
  xchart impure*day / mu0=2 sigma0=.4 nolcl;
run;


data imptwo;
  file 'junk222.lst';
  do day=26 to 31;
    mean=2.45;
    impure=.4*normal(1133) + mean;
    output;
    put day impure 6.2;
  end;
run;


/*The following code appears on p. 347 */

data fig4_16;
  do hour=1 to 72;
    if mod(hour,24)=1 then t=0; else t=t+1;
    if 1 le hour le 24 then part='Part 1';
    if 25 le hour le 48 then part='Part 2';
    if 49 le hour le 72 then part='Part 3';
    diameter=20+.006*t + (.015*normal(12345));
    output;
  end;
run;

title h=.8 'Example of Tool Wear Data';
symbol v=dot i=none h=.3;

proc shewhart data=fig4_16 graphics;
  xchart diameter*hour(part) / npanelpos=75 nolegend
    href=24 48  lhref=2  vref=20  lvref=1  vreflabels='Target Value'
    noconnect nolimits vaxis=19.9 to 20.2 by .1;
run;


/*The following code appears on p. 347 */

title 'Toy Airplane Wing Width Data';
symbol v=dot h=.7;

proc shewhart data=wings graphics;
  xchart width*hour / npanelpos=200 nolimits;
run;


/*The following code appears on pp. 347-348 */

data pop;
  do i=1 to 150;
    z=normal(12345) + 100;
    output;
  end;
label z='Part Length';
run;

goptions hsize=6 vsize=5 device=hplj300;

title h=.7 'Population Distribution';

proc capability data=pop graphics noprint;
  var z;
  histogram z / normal(mu=100 sigma=1 noprint)
            nobars nocurvelegend haxis=axis1 pctaxis=axis2;
axis1 order=(95 to 105 by 1) minor=none;
axis2 order=(0 to 25 by 5) minor=none;
run;


data sample;
  do i=1 to 150;
    z=normal(12345)+100;
    output;
  end;
label z='Part Length';
run;

goptions hsize=6 vsize=5 device=hplj300;

title h=.7 'Histogram Using Sample Data';

proc capability data=sample graphics noprint;
  var z;
  histogram z / haxis=axis1 pctaxis=axis2;
axis1 order=(95 to 105 by 1) minor=none;
axis2 order=(0 to 25 by 5) minor=none;
run;


/*The following code appears on pp. 348-349 */

data fig5_2;
  do i=1 to 1000;
    y=2*normal(1234)+100;
    z=2*normal(1114)+106;
    output;
  end;
run;

goptions hsize=6 vsize=3 border device=os2 targetdevice=hplj300
         ftext=swissx;


proc capability data=fig5_2 graphics;
   spec lsl=88 usl=112 target=100 wlsl=2 wusl=2;
   histogram y / normal(sigma=2 mu=100 noprint) nobars
             haxis=axis1 vaxis=axis2 nolegend hminor=0;
axis1 order=85 to 115 by 3;
axis2 label=none value=none;
label y='00'X;
title 'Process A';
title2 h=1 f=greek 'm' f=swissx '=100, ' f=greek 's' f=swissx '=2, C'
       move=(-0,-.3) h=.7 'p' move=(+0,+.3) h=1 '=2';
run;

proc capability data=fig5_2 graphics;
   spec lsl=88 usl=112 target=100 llsl=1 wlsl=4 lusl=1 wusl=4;
   histogram z / normal(sigma=2 mu=106 noprint) nobars
           haxis=axis1 vaxis=axis2 nolegend hminor=0;
axis1 order=85 to 115 by 3;
axis2 label=none value=none;
label z='00'X;
title 'Process B';
title2 h=1 f=greek 'm' f=swissx '=106, ' f=greek 's' f=swissx '=2, C'
       move=(-0,-.3) h=.7 'p' move=(+0,+.3) h=1 '=2';
run;


/*The following code appears on pp. 349-350 */


data fig5_4a;
  do x=0 to 30 by .1;
    c=2; sigma=5;
    fx1=(c/sigma)*((x/sigma)**(c-1))*exp(-(x/sigma)**c);
    c=2; sigma=10;
    fx2=(c/sigma)*((x/sigma)**(c-1))*exp(-(x/sigma)**c);
    c=2; sigma=15;
    fx3=(c/sigma)*((x/sigma)**(c-1))*exp(-(x/sigma)**c);
    output;
  end;
run;

goptions hsize=4 vsize=3;

proc gplot data=fig5_4a;
  plot fx1*x fx2*x fx3*x / overlay vaxis=axis1 haxis=axis2;
axis1 label=none value=none minor=none major=none;
axis2 label=none value=none minor=none;
title 'Weibull Distribution';
title2 'c=2, ' f=greek 's' f=swissx '=5, 10, 15';
symbol1 i=join v=none l=1;
symbol2 i=join v=none l=1;
symbol3 i=join v=none l=1;
run;


data fig5_4b;
  do x=0 to 15 by .1;
    c=1; sigma=5;
    fx1=(c/sigma)*((x/sigma)**(c-1))*exp(-(x/sigma)**c);
    c=2; sigma=5;
    fx2=(c/sigma)*((x/sigma)**(c-1))*exp(-(x/sigma)**c);
    c=4; sigma=5;
    fx3=(c/sigma)*((x/sigma)**(c-1))*exp(-(x/sigma)**c);
    output;
  end;
run;

goptions hsize=4 vsize=3;

proc gplot data=fig5_4b;
  plot fx1*x fx2*x fx3*x / overlay vaxis=axis1 haxis=axis2;
axis1 label=none value=none minor=none major=none;
axis2 label=none value=none minor=none;
title 'Weibull Distribution';
title2 'c=1, 2, 4 ' f=greek 's' f=swissx '=5';
symbol1 i=join v=none l=1;
symbol2 i=join v=none l=1;
symbol3 i=join v=none l=1;
run;


/*The following code appears on pp. 350-351 */

%macro drawrsm(dsn=,lab=,c1=,c2=,x1=,x2=);

data drawrsm;
  length function $ 8;
  retain xsys ysys '3'  line 1  position '9';

  function='MOVE'; x=12; y=50; output;
  function='DRAW'; x=88; y=50; output;
  function='MOVE'; x=50; y=12; output;
  function='DRAW'; x=50; y=88; output;


  do while (1);
    set &dsn;
    x=((&c1+1)*25)+25;
    y=((&c2+1)*25)+25;
    function='PIE';  rotate=360;  style='SIMPLEX';  size=.25;  output;
    position='9';  function='LABEL';  size=.8;
    text=compress('(' || put(&c1,best5.) || ',' || put(&c2,best5.) || ')'); output;
    position='3';
    text=compress('(' || put(&x1,best5.) || ','  || put(&x2,best5.) || ')'); output;
  end;
run;

goptions hsize=6.5 vsize=6.5;

title "&Lab Response Surface Design";

proc gslide annotate=drawrsm;
run;

%mend drawrsm;

%drawrsm(dsn=bricks,lab=First Order,c1=codetime,c2=codetemp,x1=time,x2=temp)


/*The following code appears on p. 351 */

%drawrsm(dsn=temp2,lab=Second Order,c1=codex1,c2=codex2,x1=x1,x2=x2)


/*The following code appears on pp. 351-352 */

data one;
  x1=1; x2=0; x3=0; output;
  x1=0; x2=1; x3=0; output;
  x1=0; x2=0; x3=1; output;
  x1=.25; x2=.25; x3=.5; output;
run;

%macro drawmix(dsn=,x1=,x2=,x3=);

data drawmix;
  length function $ 8;
  retain xsys ysys '3' line 1 position '9'   ;

  function='MOVE'; x=20; y=20; output;
  function='DRAW'; x=20+(50*(2*sqrt(3)/3)); y=20; output;
  function='DRAW'; x=20+(50*(sqrt(3)/3));  y=20+(50*1); output;
  function='DRAW'; x=20; y=20; output;
  do while (1);
    set &dsn;
    w1=((2*sqrt(3)/3)*&x2) + ((sqrt(3)/3)*&x3); x=20+(50*w1);
    w2=&x3; y=20+(50*w2);
    function='PIE'; rotate=360; style='SIMPLEX'; size=.25; output;
    function='LABEL';
    text=compress('(' || put(&x1,best3.) || ',' || put(&x2,best3.)
                    || ',' || put(&x3,best3.) || ')');
    size=1; output;
  end;
run;

goptions hsize=6.5 vsize=6.5;

title 'Mixture Design';

proc gslide annotate=drawmix;
run;

%mend drawmix;

%drawmix(dsn=one,x1=x1,x2=x2,x3=x3)


/*The following code appears on p. 352 */

%drawmix(dsn=nuts1,x1=peanuts,x2=almonds,x3=cashews)


/*The following code appears on pp. 352-353 */

data occurve;
  n=100; c=2; lotn=10000;
  do p=.000 to .06 by .001;
    k = ceil(lotn*p);
    if p=0 then pa=1;
      else pa = probhypr(lotn,k,n,c);
    output ;
  end;
run;

data lines; set occurve;
  length text function $ 8;
  xsys='2'; ysys='2'; line=3;
  p=round(p,.001);
  if round(p,.001)=.01 or p=.05 then do;
    function='MOVE'; x=0; y=pa; output;
    function='DRAW'; x=p; y=pa; output;
    function='DRAW'; x=p; y=0;  output;
    function='LABEL'; position='A';
    if p=.01 then text='AQL'; else text='LTPD'; output;
  end;
run;

goptions device=hplj300 hsize=5 vsize=4 border;

title1 'OC Curve for Single Sampling Plan';
title2 h=.7 'N=10,000, n=100, c=2';
symbol i=join v=none;

proc gplot data=occurve annotate=lines;
  plot pa*p / vaxis=axis1 vzero;
axis1 label=(a=90 'Prob. of Acc.');
run;


/*The following code appears on p. 353 */

data dodgeoc;
  length plan $ 16;
  lotn=1500; c1=7; n1=281; c2=3; n2=125;

  do p=.005 to .07 by .005;
    k=int(lotn*p);
    plan='Dodge-Romig';
    pa = probhypr(lotn,k,n1,c1);
    output;
    plan='MIL-STD-105';
    pa = probhypr(lotn,k,n2,c2);
    output;
  end;
run;

title h=.7 'Comparison of Dodge-Romig LTPD Plan to AQL Plan';
symbol1 i=join v=none l=1;
symbol2 i=join v=none l=2;

proc gplot;
  plot pa*p=plan / vaxis=axis1;
axis1 label=(a=90 'Prob. of Acc.');
run;


/*The following code appears on p. 354 */

data hplc;
  input red_no2 peak;
label peak='HPLC Peak Area'
      red_no2='FD&C Red No.2 Concentration';
cards;
0.18    26.666
0.35    50.651
0.055    9.628
0.022    4.634
0.29    40.206
0.15    21.369
0.044    5.948
0.028    4.245
0.044    4.786
0.073   11.321
0.13    18.456
0.088   12.865
0.26    35.186
0.16    24.245
0.10    14.175
run;

title 'Linear Calibration Data';
symbol i=none v=dot h=.7;

proc gplot data=hplc;
  plot peak*red_no2;
run;



