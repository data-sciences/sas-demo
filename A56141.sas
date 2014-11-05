/*------------------------------------------------------------------*/
/* SAMPLE CODE                                                      */
/* SAS System for Regression, Second Edition                        */
/* Publication book code:  56141                                    */
/*                                                                  */
/* Each sample begins with a comment that states the                */
/* chapter and page number where the code is located.               */
/*------------------------------------------------------------------*/


/* Chapter 1 page 9 */
/* DATA step to produce Output 1.1. */

   data air;
   input utl 1-4 .2 asl 5-8 .3 spa 9-12 .4 avs 13-15 .2
         alf 16-18 .3 cpm 19-22 .3 csm 23-26 .3;
   type = (asl >= 1200);
cards;
 7871790137546859122581333
 9502515354648348822751111
 7911350192044241223410965
13303607339050139723570935
 8481963138147058223631375
 9381123148142446624041119
10801576136148753524251297
 8361912314846543427111177
 8431584160744743927431203
 8832377328747341727801159
 8421495359744440028331133
 9620840139042541028461166
 8711392114844447829061390
 8440871118643849529541461
 8910961123641647629621411
 6841008115041353929711600
 9000845139042540930441245
10201692300746538130961179
 8290877106043748631401528
 8091528352243228733060949
 9471408134547050433061662
 7701236122142845533111507
 9570863139042640533131343
 8351031136542242233921431
 7271416114543847634371636
 7520975202539642634621476
 9562189327946234935271230
 7940949148840039436891452
 7551164127042245237601700
10602780128246542538561637
10801518135644336239591432
 6310823094340654140242176
 5650821129040137847371791
;
run;
proc sort;
by alf;
run;

   /* Invoke PROC IML and create the x and y matrices using the   */
   /* variables UTL, SPA, ALF, and CPM from the SAS data set AIR. */

   proc iml;
      use air;
      read all var {'utl' 'spa' 'alf' 'asl'} into x;
      read all var {'cpm'} into y;

   /* Define the number of observations (N) and the number of       */
   /* variables (M) as the number of rows and columns of X. Add a   */
   /* column of ones for the intercept variable to the X matrix.    */

      n=nrow(x);     /* number of observations  */
      m=ncol(x);     /* number of variables     */
      x=j(n,1,1)||x; /* add column of ones to X */

   /* Compute C, the inverse of X`X and the vector of     */
   /* coefficient estimates BHAT.                        */

      c=inv(x`*x);
      bhat=c*x`*y;

   /* Compute SSE, the residual sum of squares, and MSE, the       */
   /* residual mean square (variance estimate).                    */

      sse= y`*y-bhat`*x`*y;
      dfe= n-m-1;
      mse=sse/dfe;

   /* The test for the model can be restated as a test for the     */
   /* linear function L\beta  where L is the matrix.                    */

      l={0 1 0 0 0,
         0 0 1 0 0,
         0 0 0 1 0,
         0 0 0 0 1};

   /* Compute SSMODEL and MSMODEL and the corresponding F ratio.   */

      ssmodel=(l*bhat)`*inv(l*c*l`)*(l*bhat);
      msmodel=ssmodel/m;
      f=(ssmodel/m)/mse;

   /* Concatenate results into one matrix.                         */

      source=(m||ssmodel||msmodel||f)//(dfe||sse||mse||{.});

   /* Compute                                                       */
   /* SEB   vector of standard errors of the estimated coefficients */
   /* T     matrix containing the t statistic for testing that each */
   /*       coefficient is zero                                     */
   /* PROBT significance level of test                              */
   /* STATS matrix which contains as its columns the coefficient    */
   /*       estimates, their standard errors, and the t statistics. */

     seb=sqrt(vecdiag(c)#mse);
     t=bhat/seb;
     probt=1-probf(t#t,1,dfe);
     stats=bhat||seb||t||probt;

   /* Compute                                                        */
   /* YHAT  predicted values                                         */
   /* RESID residual values                                          */
   /* OBS   matrix containing as its columns the actual, predicted,  */
   /*       and residual values, respectively.                       */

      yhat=x*bhat;
      resid=y-yhat;
      obs=y||yhat||resid;

   /* Print the matrices containing the desired results.             */

      print 'Regression Results',
      source (|colname={DF SS MS F} rowname={MODEL ERROR}
      format=8.4|),,
      'Parameter Estimates',
      stats (|colname={BHAT SEB T PROBT} rowname={INT UTL SPA ALF ASL}
      format=8.4|) ,,,
      'RESIDUALS', obs (| colname={Y YHAT RESID} format=8.3|) ;


/* Chapter 2, Using the REG Procedure */
/* DATA step to produce Output 2.1 through Output 2.25. */

   data air;
   input utl 1-4 .2 asl 5-8 .3 spa 9-12 .4 avs 13-15 .2
         alf 16-18 .3 cpm 19-22 .3 csm 23-26 .3;
   type = (asl >= 1.200);
   cards;
 7871790137546859122581333
 9502515354648348822751111
 7911350192044241223410965
13303607339050139723570935
 8481963138147058223631375
 9381123148142446624041119
10801576136148753524251297
 8361912314846543427111177
 8431584160744743927431203
 8832377328747341727801159
 8421495359744440028331133
 9620840139042541028461166
 8711392114844447829061390
 8440871118643849529541461
 8910961123641647629621411
 6841008115041353929711600
 9000845139042540930441245
10201692300746538130961179
 8290877106043748631401528
 8091528352243228733060949
 9471408134547050433061662
 7701236122142845533111507
 9570863139042640533131343
 8351031136542242233921431
 7271416114543847634371636
 7520975202539642634621476
 9562189327946234935271230
 7940949148840039436891452
 7551164127042245237601700
10602780128246542538561637
10801518135644336239591432
 6310823094340654140242176
 5650821129040137847371791
;

   proc sort;
      by alf;
   run;

/* Chapter 2, page 17 */

     proc plot data=air;
          plot cpm*alf / hpos=30 vpos=25;
     run;

/* Chapter 2, page 18 */

     proc reg data = air;
          model cpm = alf;
     run;

/* Chapter 2, page 21 */

     proc corr;
          var alf utl asl spa cpm;
          run;

/* Chapter 2, page 22 */

     proc reg;
          model cpm = alf utl asl spa;
     run;

/* Chapter 2, page 25 */

     proc reg data = air;
          model cpm = alf utl asl spa / p clm ;
          id alf;
     run;

/* Chapter 2, page 28 */

     proc reg;
          model cpm = alf utl asl spa / ss1 ss2;
     run;

/* Chapter 2, page 31 */

     proc reg data = air;
          model cpm = alf utl asl spa / stb;
     run;

/* Chapter 2, page 32 */

     proc reg;
          model cpm = alf utl asl spa / xpx i;
     run;

/* Chapter 2, page 33 */

     proc reg;
          model cpm = alf utl asl spa / noint p;
     run;

/* Chapter 2, page 47 */

   proc reg;
    model cpm = alf utl asl spa;
          plot r.*p. / hplots=2 vplots=2 collect;
     delete spa;
          plot r.*p.=' ' r.*p. / nocollect;
   run;

/* Chapter 2, page 49 */

     proc reg data = air;
          model cpm = alf;
          output out=d p=pcpm r=rcpm u95=up l95=down;
     run;

/* Chapter 2, page 50 */

   proc gplot data=d;
      plot
           cpm*alf=1
           pcpm*alf=2
           up*alf=3
           down*alf=4 / overlay;
      symbol1 v=star c=red;
      symbol2 v=p i=join c=blue;
      symbol3 v=U i=spline c=green;
      symbol4 v=l i=spline c=green;
    run;

/* Chapter 2, page 52 */

    proc reg data = air;
          model cpm = alf;
          output out=b p=yhat stdp=stdmean;
     run;

     data c; set b;
       lower = yhat - tinv(0.995,31)*stdmean;
       upper = yhat + tinv(0.995,31)*stdmean;
       proc print;
     run;

/* Chapter 2, page 52 */

     data short; set air;
     if type = 0 then scpm = cpm;
          else scpm = .;

      proc reg data=short;
          model scpm = alf utl asl spa ;
          output out=e p=pscpm ;
          run;

     data f;
           set e;
           rscpm = cpm - pscpm;

     proc plot data=f;
          plot rscpm*pscpm=type / hpos=30 vpos=25 vref=0;
     run;

/* Chapter 2, page 55 */

     data depend; set air;
     pass = alf*spa;
     array a alf utl asl spa cpm pass;
     do over a;
          a = log(a);
     end;

     proc reg data = depend;
          model cpm = alf utl asl spa pass;
      run;


/* Chapter 3 page 61 */
/* DATA step to produce Output 3.1. through 3.7 */

   data boq;
   input id $ occup checkin hours common wings cap rooms manh;
     drop id;
   cards;
   A 2 4 4 1.26 1 6 6 180.23
   B 3 1.58 40 1.25 1 5 5 182.61
   C 16.6 23.78 40 1 1 13 13 164.38
   D 7 2.37 168 1 1 7 8 284.55
   E 5.3 1.67 42.5 7.79 3 25 25 199.92
   F 16.5 8.25 168 1.12 2 19 19 267.38
   G 25.89 3 40 0 3 36 36 999.09
   H 44.42 159.75 168 .6 18 48 48 1103.24
   I 39.63 50.86 40 27.37 10 77 77 944.21
   J 31.92 40.08 168 5.52 6 47 47 931.84
   K 97.33 255.08 168 19 6 165 130 2268.06
   L 56.63 373.42 168 6.03 4 36 37 1489.5
   M 96.67 206.67 168 17.86 14 120 120 1891.7
   N 54.58 207.08 168 7.77 6 66 66 1387.82
   O 113.88 981 168 24.48 6 166 179 3559.92
   P 149.58 233.83 168 31.07 14 185 202 3115.29
   Q 134.32 145.82 168 25.99 12 192 192 2227.76
   R 188.74 937 168 45.44 26 237 237 4804.24
   S 110.24 410 168 20.05 12 115 115 2628.32
   T 96.83 677.33 168 20.31 10 302 210 1880.84
   U 102.33 288.83 168 21.01 14 131 131 3036.63
   V 274.92 695.25 168 46.63 58 363 363 5539.98
   W 811.08 714.33 168 22.76 17 242 242 3534.49
   X 384.5 1473.66 168 7.36 24 540 453 8266.77
   Y 95 368 168 30.26 9 292 196 1845.89
   ;
run;

proc sort;
  by occup; run;

proc reg data=boq;
   model manh = occup checkin hours common wings cap rooms;
run;

/* Chapter 3 page 62 */

proc reg data=boq;
   model manh = occup checkin hours common wings cap rooms/ r;
run;

/* Chapter 3 page 64 */

proc reg data=boq;
   model manh = occup checkin hours common wings cap rooms;
   output out = resid p = pman r = rman student = student;
run;

proc plot data = resid hpercent=50;
   plot rman*pman student*pman / vpos = 20 vref = 0;
run;

/* Chapter 3 page 65 */

proc reg data=boq;
   model manh = occup checkin hours common wings cap rooms/ influence;
run;
/* Chapter 3 page 68 */
   paint obs. = 25;
   plot (student. rstudent. h. dffits.)*p. /
         hplots = 2 vplots = 2;
   run;

/* Chapter 3 page 69 */

data miss25; set boq;
   if _n_ = 25 then manh = . ;
run;

proc reg data=boq;
   model manh = occup checkin hours common wings cap rooms/ influence;
   reweight obs. = 25;
   print anova;
run;

/* Chapter 3, page 71 */
/* DATA step to produce Output 3.8. through Output 3.12 */

data irrig;
   input perc ratio inft lost advt ;
   cards;
   16.8 3.64 .343 21.27 .6991
   25.76 1.67 .343 21.27 .564
   14.73 2.34 .343 21.27 .750
   12.71 3.78 .387 25.45 .680
   14.56 3.73 .397 25.45 .701
   13.16 2.71 .397 25.45 .747
   9.06 4.97 .397 26.53 .772
   14.46 3.17 .397 26.53 .436
   17.16 2.32 .397 26.53 .596
   9.52 6.86 .397 26.53 .840
   13.72 3.69 .387 26.53 .600
   12.96 3.35 .397 26.53 .760
   19.04 2.39 .427 29.1 .600
   18.03 2.82 .427 29.1 .730
   34.83 .97 .427 29.1 .698
   30.26 1.27 .427 29.1 .880
   37.75 .77 .427 29.1 .582
   26.26 1.87 .309 20.90 .836
   30.60 1.27 .309 20.90 .685
   33.75 1.15 .309 20.90 .519
   25.75 2.25 .309 20.90 .841
   29.05 1.51 .309 20.90 .800
   ;
run;

proc sort;
  by ratio;
run;

proc reg data=irrig;
     model perc = ratio inft lost advt;
     output out=irrplot r=rperc p=pperc;
run;

proc plot;
  plot rperc*pperc / vref=0;
run;

/* Chapter 3 page 73 */

proc reg data=irrig;
    model perc = inft lost advt;
    output out=a r=rperc;
    model ratio = inft lost advt;
    output out=b r=rratio;
run;

data c; merge a b;
run;

proc plot;
  plot rperc*rratio;
run;

proc reg data=c;
  model rperc = rratio;
run;


/* Chapter 3 page 76 */

data quad; set irrig;
   ratsq = ratio * ratio;
run;

proc reg data=quad;
   model perc = ratio ratsq inft lost advt;
run;

/* Chapter 3 page 77 */
/* DATA step to produce Output 3.13. through Output 3.17 */

data diamonds;
  input carats color $  clar $  price ;
    price = price / 1000;
    csq = carats*carats;
  cards;
   1.9 H A 28473
   1.35 F D 15297
   1.46 G C  16596
   1.03 G C 11372
   1.66 E F 16321
   .91 G F 4816
   .68 G F 2324
   1.92 D B 100411
   1.25 D F 19757
   1.36 E E 17432
   .73 G E 3719
   1.41 H A 19176
   1.29 E A 36161
   .5 H D 1918
   .77 G E 3951
   .79 G E 4131
   .6 G E 2499
   .63 G F 2324
   .79 G E 4184
   .53 I B 1976
   .52 G E 2055
   .54 G E 2134
   1.02 D C 27264
   1.02 G C 12684
   1.06 F D 13181
   .63 H D 2747
   .52 I B 1976
   1.23 E D 17958
   1.24 E D 18095
   .75 E E 5055

proc sort;
  by carats;
run;

data _null_;
  file print n=ps header=h;
   do c= 21,45;
     do r=6 to 20;
      set diamonds;
      put #r @c carats 4.2 +5 price 7.3 ;
     end;
   end;
  return;
  put _page_;
  h:
   put /// @20 'carats' +5 'price' +8  'carats' +5 'price';
run;

/* Chapter 3 page 78 */

proc reg data=diamonds;
   model price = carats csq / p cli;
run;

/* Chapter 3 page 80 */
proc reg data=diamonds;
   model price = carats csq;
   output out=a p=pprice u95=upper l95=lower;
run;

data b; set a;
  w = 1/(pprice*pprice);
run;

proc reg data= b; weight w;
   model price = carats csq / p cli;
   output out=c p=pwprice u95=wupper l95=wlower;
run;

/* Chapter 3 page 82 */

data all;
  merge a c;
run;

proc plot data= all hpercent = 50 ;
   plot  upper*carats='U' lower*carats='L'
       / overlay vaxis = -25 to 125 by 25;
   plot  wupper*carats='U' wlower*carats='L'
       / overlay vaxis = -25 to 125 by 25;
run;

/* Chapter 3 page 85 */
/* DATA step to produce Output 3.18 through Output 3.21 */

data consume;
   input curr 1-3 .1 (ddep prices gnp)(4.1) wages 3.2
   (income pop cons)(4.1)  yr 2. qtr 1.;
   n=_n_;
   idx=prices*pop; drop idx;
   curr=100000*curr/idx;
   ddep=100000*ddep/idx;
   gnp=100000*gnp/idx;
   wages=100*wages/prices;
   income=100000*income/idx;
   cons=100000*cons/idx;
cards;
251 920 8993180154270015401739511
253 929 9033258157276215471743512
257 939 9103328158280515541774513
260 959 9223369161285315611809514
263 972 9163395163286315671817521
265 980 9243391163286615731855522
268 990 9303456167291715811893523
272 999 9303577170301215881930524
2751001 9263642173306015941950531
2771007 9333675174307916001967532
2781008 9393658176306416071976533
2781010 9363608177298516151977534
2771015 9363607177299316212003541
2761018 9383604178299516282020542
2751032 9353647178302916362047543
2741046 9323734181310916432075544
2751060 9323862182320516502103551
2761067 9323944184328716572130552
2771072 9364025188334516652154553
2781073 9354088190340916732203554
2791077 9354106192343016802234561
2791080 9474162195348316872259562
2801080 9544206198351916952291563
2811084 9624295202359317032326564
2821086 9694369203364517102367571
2821087 9804399204366017172384572
2831086 9874463206369517252433573
2831079 9914415208364017332452574
282107810054347208357917402467581
283109310084383210359317462506582
284110610084514212370217542545583
285112210084644217383017622570584
287113310084740219392417692612591
289114110154869221404917762648592
290114610204840219399717842690593
289113610234905224402817922717594
290112310245030226414217982751601
290111410315047226417118052801602
290111910335042227415218132806603
290112010395033229411718212839604
289112710395036229412218282865611
289113710405149232422618352889612
291114310465242232430718432919613
294115510455377237443418512965614
297116010505478238448818582998621
300116210535572239456018643032622
302115810615644239460418723072623
304116410585720243465618793120624
309117610625774244470618853158631
313118510665842246477418923188632
318119510715947247485719003238633
323120610766058251493919073259634
328121110776177251504019133336641
333121810806280253513719193381642
338123610846389256524219263464643
341124910886451258530419333499644
346125410906627259544919383544651
349126311016754261555319443635652
355127711026900263566519513698653
361129811107084266582819573785654
367131911207259268604019623865661
373133211297367271615119673933662
378132311417488274626719733998663
382132011477621277637319794026664
387133011507663279638619844109671
391135211607751282645119894162672
395139111717912285656919954224673
401141011828161291670920014274674
408142611958353296688120054412681
416145112098587300705420104485682
424148312228764304722520164591683
431150312378925311737320214644684
441152712569087313751320254736691
448154212769248317765720304822692
452153712939428324780620354900693
460157713139522329786520414990694
;

/* Chapter 3, page 86 */

proc reg data=consume;
   model cons = curr ddep gnp wages income / dw;
   output out=a p=pc r=rc;
run;

/* Chapter 3, page 87 */

data plot; set a;       /* use output from REG proc */
  n = _n_;
run;

symbol1 v=point i=join;
proc gplot data=plot;
   plot rc*n =1;
run;

/* Chapter 3, page 88 */

proc autoreg data=consume;
  model cons = curr ddep gnp wages income / nlag = 4;
run;

/* Chapter 4 page 95 */
/* DATA step to produce Output 4.1 through Output 4.17 */

data boq;
   input id $ occup checkin hours common wings cap rooms manh;
   if id = 'W' then delete;
   cards;
   A 2 4 4 1.26 1 6 6 180.23
   B 3 1.58 40 1.25 1 5 5 182.61
   C 16.6 23.78 40 1 1 13 13 164.38
   D 7 2.37 168 1 1 7 8 284.55
   E 5.3 1.67 42.5 7.79 3 25 25 199.92
   F 16.5 8.25 168 1.12 2 19 19 267.38
   G 25.89 3 40 0 3 36 36 999.09
   H 44.42 159.75 168 .6 18 48 48 1103.24
   I 39.63 50.86 40 27.37 10 77 77 944.21
   J 31.92 40.08 168 5.52 6 47 47 931.84
   K 97.33 255.08 168 19 6 165 130 2268.06
   L 56.63 373.42 168 6.03 4 36 37 1489.5
   M 96.67 206.67 168 17.86 14 120 120 1891.7
   N 54.58 207.08 168 7.77 6 66 66 1387.82
   O 113.88 981 168 24.48 6 166 179 3559.92
   P 149.58 233.83 168 31.07 14 185 202 3115.29
   Q 134.32 145.82 168 25.99 12 192 192 2227.76
   R 188.74 937 168 45.44 26 237 237 4804.24
   S 110.24 410 168 20.05 12 115 115 2628.32
   T 96.83 677.33 168 20.31 10 302 210 1880.84
   U 102.33 288.83 168 21.01 14 131 131 3036.63
   V 274.92 695.25 168 46.63 58 363 363 5539.98
   W 811.08 714.33 168 22.76 17 242 242 3534.49
   X 384.5 1473.66 168 7.36 24 540 453 8266.77
   Y 95 368 168 30.26 9 292 196 1845.89
   ;
run;

proc sort;
  by occup; run;

proc reg;
   model manh = occup checkin hours common wings cap rooms /
           vif collinoint;
run;


/* Chapter 4 page 100 */

data rel; set boq;
          relocc = occup / rooms;
          relcheck = checkin / rooms;
          relcom = common / rooms;
          relwing = wings / rooms;
          relcap = cap / rooms;
          relman = manh / rooms;
run;

proc print;
   var relocc--relcap rooms hours relman;
run;

proc reg;
  model relman = relocc relcheck relcom relwing relcap hours
                rooms / vif;
run;

/* Chapter 4 page 102 */

proc princomp data = boq out = prin;
          var occup checkin hours common wings cap rooms;
run;

/* Chapter 4 page 104 */

proc reg data = prin;
    model manh = prin1 - prin7 / ss2;
run;
/* Chapter 4 page 106 */
  plot prin3*manh prin6*manh  / hplots = 2 vplots = 2;
run;

proc plot  data = prin vpercent =50 hpercent = 50 ;
    plot prin3*manh  prin6*manh ;
run;

/* Chapter 4 page 108 */

proc reg;
  model manh = occup checkin hours common wings cap rooms /
         selection = rsquare  best = 4 cp;
run;

/* Chapter 4 page 110 */

proc reg outest = est;
  model manh = occup checkin hours common wings cap rooms /
         selection = rsquare CP best = 2;
run;

/* Chapter 4 page 111 */

proc plot;
   plot _cp_*_in_ = 'C' _p_*_in_ = '*' / overlay
        vaxis = 0 to 25 by 1 haxis = 0 to 7 by 1
        hpos=40 vpos=30;
run;

/* Chapter 4 page 112 */

proc reg data = boq;
   model manh = occup checkin cap / vif;
run;

/* Chapter 4 page 116 */

proc reg data = rel;
  model relman = relocc relcheck relcom relwing relcap
         hours rooms / selection = f ;
run;


/* Chapter 4 pages 120 through 123 */

**** incomplete pc regression ***;
****    standardize to mean zero and standard deviation of unity
        so that X'X/(n-1)  is the correlation matrix. *****;
proc standard data=boq out = stand m=0 s=1;
var occup -- rooms manh;
run;

proc iml;
use stand;
read all var {occup checkin hours common wings cap rooms} into x;
read all var {manh} into y;
****** n= sample size df=n-1, p=no vars *****;
n = nrow(x);
df = n-1;
p = ncol (x);
****** compute correlation matrices *****;
corr = x`*x/(n-1);
****** do principal components, a= eigenvalues, v = eigenvectors *****;
call eigen (a,v,corr);
print a v;

****** compute components and principal component regression *****;
z = x*v;
bpc = inv(z`*z)*z`*y;
print bpc;

***** delete last component, retaining six *****;
bpc6 = bpc [{1 2 3 4 5 6}];
v6 = v [,{1 2 3 4 5 6}];
***** incomplete principal component regression;
b6 = v6*bpc6;
print b6;
***** standard errors of coefficients***;
***** for variance use MSE from full component regression ***;
mse = (y`*y - bpc`*z`*y)/ (df - p);
zz = z`*z;
zz6 = zz[{1 2 3 4 5 6},{1 2 3 4 5 6}];
stdb6 = sqrt(mse # vecdiag(v6*inv(zz6)*v6` ));
print stdb6;
***** rescale to get nonstandardized coefficients *****;
use boq;
read all var {occup checkin hours common wings cap rooms} into x1;
read all var {manh} into y1;
* sumx is row vector *;
sumx = x1[+,];
sumy = y1[+];
sscp = x1`*x1 - sumx`*sumx/n;
ssy  = y1`*y1 - sumy`*sumy/n;
stdx= sqrt(vecdiag (sscp));
stdy= sqrt(ssy);
***** compute coefficients, standard errors and t ratios*****;
b6s = stdy#(b6/stdx);
stdb6s = stdy#(stdb6/stdx);
t6s = b6s/stdb6s;
* intercept*;
int = sumy/n - b6s`*(sumx/n)`;
print int b6s stdb6s t6s;

***** matrix of coefficients relating OLS to PC coefficients
      see Rawlings, p. 351 ****;
rel = v6*v6` ;
print rel;
quit;


/* Chapter 5  page 128 */
/* DATA step to produce Output 5.1 through Output 5.8. */

data fish;
   input age length @@ ;
   if age > 28 then age=age+1;
   asq=age*age;
   acub=age*asq; aqt=asq*asq;
   if _n_ <= 21 then temp = 25;
   if 22 <= _n_ <= 42 then temp = 27;
   if 43 <= _n_ <= 63 then temp = 29;
   if _n_ >= 64 then temp = 31;
   tsq=temp*temp;
   at=age*temp; asqt=asq*temp; atsq=age*tsq;
   cards;
   14 620 21 910 28 1315 34 1635 41 2120 48 2300 55 2600 62 2925
   69 3110 76 3315 83 3535 90 3710 97 3935 104 4145 111 4465 118 4510
   125 4530 132 4545 139 4570 146 4605 153 4600
   14 625 21 820 28 1215 34 1515 41 2110 48 2320 55 2805 62 2940
   69 3255 76 3620 83 4015 90 4235 97 4315 104 4435 111 4495 118 4475
   125 4535 132 4520 139 4600 146 4600 153 4600
   14 590 21 910 28 1305 34 1730 41 2140 48 2725 55 2890 62 3685
   69 3920 76 4325 83 4410 90 4485 97 4515 104 4480  111 4520 118 4545
   125 4525 132 4560 139 4565 146 4626 153 4566
   14 590 21 910 28 1205 34 1605 41 1915 48 2035 55 2140 62 2520 69 2710
   76 2870 83 3020 90 3025 97 3030 104 3025 111 3040 118 3177 125 3180
   132 3180 139 3257 146 3166 153 3214

data _null_;
   set fish;
   retain c1 7 c2 7 c3 7 c4 7;
   file print header=h n=ps;
   if temp=25 then do;
   c1+1; put # c1 @19 age 5.  @29 length 5. ; end;
   if temp=27 then do;
   c2+1; put # c2 @39 length 5.; end;
   if temp=29 then do;
   c3+1; put # c3 @ 49 length 5.; end;
   if temp = 31 then do;
   c4+1; put # c4 @ 59 length 5.; end;
   return;
   h: put //
   @ 20 'temp' +7 '25' +8 '27' +8 '29' +8 '31' //
   @ 21 'age' ; return;
run;

/* Chapter 5 page 129 */

data temp29; set fish;
   if temp = 29;
   asq = age*age;
   acub = age*age*age;
   aqt = asq*asq;
run;

proc reg data=temp29;
   model length = age asq acub aqt / ss1 seqb;
run;

/* Chapter 5 page 132 */

proc reg data = temp29;
   model length = age;
   output out=l p=pl r=rl;
   model length = age asq;
   output out=q p=pq r=rq;
   model length = age asq acub;
   output out=c p=pc r=rc;
   model length = age asq acub aqt;
   output out=qt p=pqt r=rqt;
run;

data all;
   merge l q c qt;
run;

proc plot data=all;
   plot length*age='*' pl*age='L' pq*age='Q' pc*age='C'
        pqt*age='4' / overlay;
run;

/* Chapter 5 page 133 */

proc gplot data = all;
   symbol1 v=square i=join;
   symbol2 v=l i=spline ;
   symbol3 v=q i=spline ;
   symbol4 v=c i=spline ;
   symbol5 v=4 i=spline ;
   plot
     length*age=1
     pl*age=2
     pq*age=3
     pc*age=4
     pqt*age=5 / overlay;
run;

proc plot data=q;
   plot rq*age / vref=0;
run;

/* Chapter 5 page 135 */

proc rsreg data=fish;
   model length = age temp;
run;

/* Chapter 5 page 139 */

data f1;
   do temp = 25 to 31 by .2;
   do age = 10 to 160 by 2.5;
   id = 1;
   output; end; end;
run;

data f2;
   set fish f1;
run;

proc rsreg data=f2 out=p1;
    model length = age temp /predict residual;
    id id;
run;

/* Chapter 5 pages 140-141 */

data plot
   pred (rename=(length=pred))
   resid (rename=(length=resid));
   set p1;
      if id = 1 and _type_= 'PREDICT' then output plot;
      else if id = . then do;
               if _type_= 'PREDICT' then output pred;
               if _type_= 'RESIDUAL' then output resid;
      end;
run;

data resid2;
    merge pred resid;
run;

proc plot data = resid2;
   plot resid*pred / vref = 0;
run;

proc plot data=plot;
   plot temp*age=length / contour = 8;
run;

/* Chapter 5 page 143 */
/* DATA step to produce Output 5.9 through Output 5.12 */

data peanuts ;
   input length 30-32 .2   freq 36-38   space 42-44 .2   time 47-50 .2
   unshl 53-56   damg 59-62 .2   exp 6 no 7-8 ;
   if exp=2 then output ;      drop exp no;
 cards ;
012s 1 1     2     2     2   125   130    40   720   117   550
012s 1 2     2     2     4   125   130    86  1620   217   460
012s 1 3     2     4     2   125   220    40   410   134   690
012s 1 4     2     4     4   125   220    86   850   229   310
012s 1 5     4     2     2   225   130    40   230   117   800
012s 1 6     4     2     4   225   130    86   520   117   400
012s 1 7     4     4     2   225   220    40   230   153   740
012s 1 8     4     4     4   225   220    86   580   128   380
012s 1 9     1     3     3   100   175    63  1600   221   360
012s 110     5     3     3   250   175    63   350   106   370
012s 111     3     1     3   175   100    63  1300   153   350
012s 112     3     5     3   175   250    63   500   116   400
012s 113     3     3     1   175   175    25   350    98   820
012s 114     3     3     5   175   175   100  1200   171   380
012s 115     3     3     3   175   175    63   430   150   580
012s 116     3     3     3   175   175    63   440   156   580
012s 117     3     3     3   175   175    63   440   145   520
012s 118     3     3     3   175   175    63   440   155   500
012s 119     3     3     3   175   175    63   440   151   570
012s 120     3     3     3   175   175    63   440   144   580
012s 2 1     2     2     2   125   130    63   925   149   823
012s 2 2     2     2     4   125   130   109  1800   240   315
012s 2 3     2     4     2   125   220    63   475   155   526
012s 2 4     2     4     4   125   220   109  1550   197   423
012s 2 5     4     2     2   225   130    63   400    84   902
012s 2 6     4     2     4   225   130   109   700   145   300
012s 2 7     4     4     2   225   220    63   225    97   741
012s 2 8     4     4     4   225   220   109   575   168   378
012s 2 9     1     3     3   100   175    86  1600   284   355
012s 210     5     3     3   250   175    86   350   168   372
012s 211     3     1     3   175   100    86  1300   154   354
012s 212     3     5     3   175   250    86   500   126   405
012s 213     3     3     1   175   175    48   350   100   816
012s 214     3     3     5   175   175   123  1200   195   380
012s 215     3     3     3   175   175    86   700   176   327
012s 216     3     3     3   175   175    86   625   177   438
012s 217     3     3     3   175   175    86   650   212   326
012s 218     3     3     3   175   175    86   650   200   357
012s 219     3     3     3   175   175    86   650   160   465
012s 220     3     3     3   175   175    86   650   176   402
012s 3 1     1     1     1   150   175    86   575   200   283
012s 3 2     1     1     2   150   175   100   925   248   217
012s 3 3     1     1     3   150   175   115   950   185   271
012s 3 4     1     2     1   150   220    86   475   201   388
012s 3 5     1     2     2   150   220   100   775   159   294
012s 3 6     1     2     3   150   220   115   775   200   249
012s 3 7     1     3     1   150   265    86   400   204   341
012s 3 8     1     3     2   150   265   100   650   205   227
012s 3 9     1     3     3   150   265   115   750   200   284
012s 310     2     1     1   200   175    86   350   176   368
012s 311     2     1     2   200   175   100   525   188   351
012s 312     2     1     3   200   175   115   650   150   321
012s 313     2     2     1   200   220    86   350   180   385
012s 314     2     2     2   200   220   100   450   185   451
012s 315     2     2     3   200   220   115   500   136   437
012s 316     2     3     1   200   265    86   300   180   461
012s 317     2     3     2   200   265   100   450   175   371
012s 318     2     3     3   200   265   115   525   171   298
012s 319     3     1     1   250   175    86   300   116   441
012s 320     3     1     2   250   175   100   425   151   220
012s 321     3     1     3   250   175   115   500   110   370
012s 322     3     2     1   250   220    86   275   129   369
012s 323     3     2     2   250   220   100   450   130   408
012s 324     3     2     3   250   220   115   425   120   354
012s 325     3     3     1   250   265    86   250   126   474
012s 326     3     3     2   250   265   100   400   124   438
012s 327     3     3     3   250   265   115   600   149   439
;

/* Chapter 5 page 144 */

proc sort data=peanuts;
   by length freq space;
run;

proc rsreg data=peanuts;
   model unshl = length freq space / lackfit;
   ridge min;
run;

/* Chapter 5 pages 147 to 148 */

data p1;
   id=1;
     do freq = 175 to 225 by 25;
        do length = 1 to 2.5 by .05;
          do space = .6 to 1.2 by .02;
             output;
          end;
        end;
     end;
run;

data p2;
   set peanuts p1;
run;

proc rsreg data=p2 out=p1;
   model unshl = length freq space / predict residual;
   id id;
run;

data
     plot (rename = (unshl = predict))
     p4 (rename = (unshl = predict))
     p5 (rename = (unshl = residual));
   set p1;
   if id = 1 and _type_ = 'PREDICT' then output plot;
   if id = . and _type_ = 'PREDICT' then output p4;
   if id = . and _type_ = 'RESIDUAL' then output p5;
run;
data p6;
   merge p4 p5;
run;

proc plot data = p6;
   plot residual*predict / vref = 0;
run;

proc plot data=plot;
   plot length*space = predict / contour = 6;
   by freq;
run;

proc g3d data=plot;
   plot length*space = predict;
   by freq;
run;


/* Chapter 6 page 152 */
/* DATA step to produce Output 6.1 through Output 6.6. */

data pines;
   input  dbh    height    age    grav     weight;
   cards;
    5.7      34      10     0.409      174
    8.1      68      17     0.501      745
    8.3      70      17     0.445      814
    7.0      54      17     0.442      408
    6.2      37      12     0.353      226
   11.4      79      27     0.429     1675
   11.6      70      26     0.497     1491
    4.5      37      12     0.380      121
    3.5      32      15     0.420       58
    6.2      45      15     0.449      278
    5.7      48      20     0.471      220
    6.0      57      20     0.447      342
    5.6      40      20     0.439      209
    4.0      44      27     0.394       84
    6.7      52      21     0.422      313
    4.0      38      27     0.496       60
   12.1      74      27     0.476     1692
    4.5      37      12     0.382       74
    8.6      60      23     0.502      515
    9.3      63      18     0.458      766
    6.5      57      18     0.474      345
    5.6      46      12     0.413      210
    4.3      41      12     0.382      100
    4.5      42      12     0.457      122
    7.7      64      19     0.478      539
    8.8      70      22     0.496      815
    5.0      53      23     0.485      194
    5.4      61      23     0.488      280
    6.0      56      23     0.435      296
    7.4      52      14     0.474      462
    5.6      48      19     0.441      200
    5.5      50      19     0.506      229
    4.3      50      19     0.410      125
    4.2      31      10     0.412       84
    3.7      27      10     0.418       70
    6.1      39      10     0.470      224
    3.9      35      19     0.426       99
    5.2      48      13     0.436      200
    5.6      47      13     0.472      214
    7.8      69      13     0.470      712
    6.1      49      13     0.464      297
    6.1      44      13     0.450      238
    4.0      34      13     0.424       89
    4.0      38      13     0.407       76
    8.0      61      13     0.508      614
    5.2      47      13     0.432      194
    3.7      33      13     0.389       66
    ;
run;

/* Chapter 6 page 153 */

proc reg data=pines;
    model weight = height dbh age grav;
    output out=a p=pw r=rw;
run;

proc plot data=a;
   plot rw*pw / vref=0;
run;

/* Chapter 6 page 155 */

data log; set pines;
   array x dbh -- weight;
   array l ldbh lheight lage lgrav lweight;
     do over x;
          l = log(x);
     end;
run;

proc reg data=log;
   model lweight = ldbh lheight lage lgrav ;
   output out = b p=plw r=rlw;
run;

proc plot data=b;
   plot rlw*plw / vref = 0;
run;

/* Chapter 6 pages 158 to 160  */
/* DATA step to produce Output 6.7 through 6.10 */

data temp29;
   input age length @@ ;
   if age > 28 then age=age+1;
   asq=age*age;
   if 43<= _n_ <= 63 then output;
   cards;
   14 620 21 910 28 1315 34 1635 41 2120 48 2300 55 2600 62 2925
   69 3110 76 3315 83 3535 90 3710 97 3935 104 4145 111 4465 118 4510
   125 4530 132 4545 139 4570 146 4605 153 4600
   14 625 21 820 28 1215 34 1515 41 2110 48 2320 55 2805 62 2940
   69 3255 76 3620 83 4015 90 4235 97 4315 104 4435 111 4495 118 4475
   125 4535 132 4520 139 4600 146 4600 153 4600
   14 590 21 910 28 1305 34 1730 41 2140 48 2725 55 2890 62 3685
   69 3920 76 4325 83 4410 90 4485 97 4515 104 4480  111 4520 118 4545
   125 4525 132 4560 139 4565 146 4626 153 4566
   14 590 21 910 28 1205 34 1605 41 1915 48 2035 55 2140 62 2520 69 2710
   76 2870 83 3020 90 3025 97 3030 104 3025 111 3040 118 3177 125 3180
   132 3180 139 3257 146 3166 153 3214
   ;
run;

data spline; set temp29;
   ageplus = max (age - 80, 0);
run;

proc reg data=spline;
    model length = age ageplus;
run;

proc reg;
   model length = age ageplus;
   restrict age + ageplus = 0;
run;

/* Chapter 6 page 162 */

data quad; set spline;
   agesq = age*age;
   ageplsq = ageplus*ageplus;
run;

proc reg data=quad;
   model length = age agesq ageplsq ageplus / p;
   restrict ageplus=0;
   plot r.*age / vplots = 2;
run;

/* Chapter 6 page 163 */
/* DATA step to produce Output 6.11 through Output 6.13 */

data air;
   input utl 1-4 .2 asl 5-8 .3 spa 9-12 .4 avs 13-15 .2
         alf 16-18 .3 cpm 19-22 .3 csm 23-26 .3;
   type=0; if asl>1.20 then type=1;
   cards;
 7871790137546859122581333
 9502515354648348822751111
 7911350192044241223410965
13303607339050139723570935
 8481963138147058223631375
 9381123148142446624041119
10801576136148753524251297
 8361912314846543427111177
 8431584160744743927431203
 8832377328747341727801159
 8421495359744440028331133
 9620840139042541028461166
 8711392114844447829061390
 8440871118643849529541461
 8910961123641647629621411
 6841008115041353929711600
 9000845139042540930441245
10201692300746538130961179
 8290877106043748631401528
 8091528352243228733060949
 9471408134547050433061662
 7701236122142845533111507
 9570863139042640533131343
 8351031136542242233921431
 7271416114543847634371636
 7520975202539642634621476
 9562189327946234935271230
 7940949148840039436891452
 7551164127042245237601700
10602780128246542538561637
10801518135644336239591432
 6310823094340654140242176
 5650821129040137847371791
;
run;

proc reg;
   model cpm = utl spa alf type;
run;

/* Chapter 6 page 165 */

data prod; set air;
   utltp = utl*type;
   spatp = spa*type;
   alftp = alf*type;
run;

proc reg;
   model cpm = utl spa alf type utltp spatp alftp / vif;
   alldiff : test utltp,spatp,alftp;
run;

/* Chapter 6 page 166 */

proc reg data=prod;
   model cpm = utl spa alf type utltp;
   utltype1: test utl + utltp;
run;


/* Chapter 7 page 170 to 171 */
/* DATA step to produce Output 7.1 through  Output 7.6 */

data decay;
   input count time;
   cards;
   383 0
   373 14
   348 43
   328 61
   324 69
   317 74
   307 86
   302 90
   298 92
   280 117
   268 133
   261 138
   244 165
   200 224
   197 236
   185 253
   180 265
   120 404
   112.5 434
   ;
run;

proc nlin data=decay;
   parms b=380 c=-0.0026;
   model count = b*exp(c*time);
run;

/* Chapter 7 page 173 */

proc nlin data=decay;
   parms b=380 c=-0.0026;
   model count = b*exp(c*time);
  output out=plot p=pct r=rct;
run;
proc plot data=plot hpercent=50 vpercent=50;
   plot rct*time / vref=0;
   plot count*time='*' pct*time='+' / overlay;
run;
proc univariate data=plot plot;
   var rct;
run;

/* Chapter 7 page 175 */

data logdecay; set decay;
   logcount = log(count);
run;
proc reg data = logdecay;
   model logcount = time;
run;

/* Chapter 7 page 176 */
/* DATA step to produce Output 7.7 through Output 7.12. */

data fish;
   input age len29  @@ ;
   if age > 28 then age=age+1;
   if 43<= _n_ <= 63 then output;
   cards;
   14 620 21 910 28 1315 34 1635 41 2120 48 2300 55 2600 62 2925
   69 3110 76 3315 83 3535 90 3710 97 3935 104 4145 111 4465 118 4510
   125 4530 132 4545 139 4570 146 4605 153 4600
   14 625 21 820 28 1215 34 1515 41 2110 48 2320 55 2805 62 2940
   69 3255 76 3620 83 4015 90 4235 97 4315 104 4435 111 4495 118 4475
   125 4535 132 4520 139 4600 146 4600 153 4600
   14 590 21 910 28 1305 34 1730 41 2140 48 2725 55 2890 62 3685
   69 3920 76 4325 83 4410 90 4485 97 4515 104 4480  111 4520 118 4545
   125 4525 132 4560 139 4565 146 4626 153 4566
   14 590 21 910 28 1205 34 1605 41 1915 48 2035 55 2140 62 2520 69 2710
   76 2870 83 3020 90 3025 97 3030 104 3025 111 3040 118 3177 125 3180
   132 3180 139 3257 146 3166 153 3214
   ;
run;

proc nlin data=fish;
   parms k=4500 no=500 r=1;
   bound -1<r<1;   /* restrict large -r that cause errors */
   model len29 = k/(1+((k-no)/no)*exp(-r*age));
run;

/* Chapter 7 pages 178 to 179 */

proc nlin data=fish;
   parms k=4500 no=500 r=1;
   bound -1<r<1;   /* restrict large -r that cause errors */
   model len29 = k/(1+((k-no)/no)*exp(-r*age));
   output out=plotdata p=plen29 r=rlen29;
run;

proc plot data=plotdata;
   plot rlen29*age;
run;

proc plot data=plotdata;
   plot len29*age='+' plen29*age='*' / overlay;
run;

/* Chapter 7 page 181 */

proc nlin data=fish;
   parms b0=-328 b1=61 b2=-59 knot=80;
   agepl=max(age-knot, 0);
   model len29 = b0 +b1*age + b2*agepl;
run;

/* Chapter 7 page 183 */
/* DATA step to produce Output 7.13 through Output 7.15 */

data decay;
   input count time;
   cards;
   383 0
   373 14
   348 43
   328 61
   324 69
   317 74
   307 86
   302 90
   298 92
   280 117
   268 133
   261 138
   244 165
   200 224
   197 236
   185 253
   180 265
   120 404
   112.5 434
   ;
run;

proc nlin data=decay;
   parms b=380 c=-.0028 t0=100;
   if time < t0 then do;
      model count = b*exp(c*t0)*(1 + c*(time - t0));
   end;
   else do;
       model count = b*exp(c*time);
   end;
run;

/* Chapter 7 page 184 */

proc nlin data=decay;
   parms b=380 c=-.0028 t0=100;
   if time < t0 then do;
      model count = b*exp(c*t0)*(1 + c*(time - t0));
   end;
   else do;
      model count = b*exp(c*time);
   end;
   output out=plot p=pct r=rct;
run;
proc plot data=plot vpercent=50 hpercent=50;
   plot rct*time ;
   plot count*time='*' pct*time='+' / overlay;
run;

proc nlin data = decay;
   parms b = 380 c = -.0026;
   model count = b*exp(c*time);
   der.b = exp(c*time);
   der.c = b*time*exp(c*time);
run;

