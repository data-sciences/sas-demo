/*------------------------------------------------------------------- */
 /*       Advanced Log-Linear Models Using SAS                        */
 /*          by Daniel Zelterman                                      */
 /*       Copyright(c) 2002 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 57496                  */
 /*                        ISBN 1-59047-080-X                         */
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
 /* Attn: Daniel Zelterman                                            */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Daniel Zelterman                                 */
 /*                                                                   */
 /*-------------------------------------------------------------------*/



Program 1.1:


        title1 'Beetle mortality and pesticide dose';
        data beetle;
           input y n dose;
        label
           y    = 'number killed in group'
           n    = 'number in dose group'
           dose = 'insecticide dose' ;

        datalines; 
           15  50  1.08
           24  49  1.16
           26  50  1.21
           24  50  1.26
           29  50  1.31
           29  49  1.35
        run;

        proc print;
        run;

        title2 'Fit a linear dose effect to the binomial data';
        proc genmod;
          model y/n=dose / dist=binomial link=identity obstats;
        run;

        title2 'Logistic regression in GENMOD';
        proc genmod;
          model y/n=dose / dist=binomial obstats;
        run;

        title2 'Probit regression in GENMOD';
        proc genmod;
           model y/n=dose / dist=binomial link=probit obstats;
        run;


Program 2.1

options linesize=80 center pagesize=54;
 
ods trace on;
ods printer file='c:\Table2-1.ps' ps;
ods printer select Genmod.ModelFit;
ods listing select Genmod.Modelfit;

 data;
    input count expos tumor alpha beta;
    label
       tumor =   'mice with tumors'
       expos =   'exposure status'
       alpha =   'row effects'
       beta  =   'column effect'  ;
    datalines;
  4  1  1  1  1
  5  0  1  1 -1
 12  1  0 -1  1
 79  0  0 -1 -1
 run;

 proc genmod;         /* Model using the CLASS statement */ 
    class tumor expos;
    model count = tumor expos
        /dist = Poisson obstats;     
 run;

 proc genmod;         /* Mimic the CLASS statement */
    model count = tumor expos
        /dist = Poisson obstats;
 run;

 proc genmod;         /* Row and column effects sum to zero */
    model count = alpha beta
        /dist = Poisson obstats;
 run;

ods printer close;



Program 2.2

     title1 'Perinatal mortality';
     data;
        input gest age cigs vita count @@;
        label
           gest =   'Gestational age 261+ days'
           age  =   'Mother over 30 years'
           cigs =   'More than 6 cigarettes/day'
           vita =   'Live births' ;
        datalines;
             0 0 0 0   50        0 0 0 1  315        0 0 1 0    9
             0 0 1 1   40        0 1 0 0   41        0 1 0 1  147
             0 1 1 0    4        0 1 1 1   11        1 0 0 0   24
             1 0 0 1 4012        1 0 1 0    6        1 0 1 1  459
             1 1 0 0   14        1 1 0 1 1494        1 1 1 0    1
             1 1 1 1  124
     run;
     title2 'Log-linear model of mutual independence';
     proc genmod;                         /*  Produces Output 2.6  */
        model count = gest  age  cigs  vita / dist = Poisson;
     run;
     title2 'Log-linear model with all pairwise effects';
     proc genmod;                         /*  Produces Output 2.7  */
        model count = gest | age | cigs | vita @2 / dist = Poisson;
     run;
     title2 'Log-linear model with all 3-way interactions';
     proc genmod;                         /*  Produces Output 2.8  */
        model count = gest | age | cigs | vita @3 / dist = Poisson;
     run;
     title2 'A small log-linear model with 5 pairwise interactions';
     proc genmod;                         /*  Produces Output 2.9  */
        model count = gest  age  cigs  vita  gest*age age*cigs 
                gest*vita age*vita cigs*vita / dist = Poisson;
     run;
     title2 'A log-linear model with 4 pairwise interactions';
     proc genmod;                         /*  Produces Output 2.10  */
        model count = gest  age  cigs  vita  gest*age age*cigs 
                gest*vita age*vita  / dist = Poisson;
     run;


Program 2.3

              proc genmod;
                 model count = gest  age  cigs  vita
                 gest*age age*cigs cigs*vita gest*vita age*vita
                   / dist = Poisson  type1  type3;
              run;



Program 3.1

      title1 'Coal miners: breathlessness and wheezing by age';
      data;
      /*    Read data as a 2x2 table for each age group.  
            Produce a data set with one frequency per line.     */
         input age a b c d;
         label
            age    = '5 year interval'
            br     = 'breathlessness'
            wh     = 'wheeze'
            bwa    = 'linear age times br-wh interaction';
         age=age/5 - 3;       /* recode age categories: 1 to 9  */
      /*    Output four lines of frequencies for each age group.
            bwa is a log-odds ratio that is linear in age       */ 
         br=1;   wh=1;   bwa= age;   freq=a;   output;    
         br=1;   wh=0;   bwa=-age;   freq=b;   output;
         br=0;   wh=1;   bwa=-age;   freq=c;   output;
         br=0;   wh=0;   bwa= age;   freq=d;   output;
         drop a b c d;           /* omit the original 2x2 table */
         datalines;
             20     9     7    95   1841  
             25    23     9   105   1654 
             30    54    19   177   1863
             35   121    48   257   2357
             40   169    54   273   1778
             45   269    88   324   1712
             50   404   117   245   1324
             55   406   152   225    967
             60   372   106   132    526
      run;
      title2 'Log-linear model with all pairwise interactions';
      proc genmod;
                /*  age as a class variable ignores its ordering */
         class age br wh;
         model freq = br | wh | age @2  / dist = Poisson  obstats;
      run;
      
      title2 'All pairwise interactions + linear odds ratio';
      proc genmod;
     /* bwa models the interaction of br and wh as linear in age */
         class age br wh;
         model freq =  br | wh | age @2  bwa / dist = Poisson obstats;
      run;

Program 3.2

      title1 'Trauma and outcome.  Data from Agresti and Coull, 1998.';
      data;
         input treat outcome freq common @@;
         label
            treat  = 'four treatments'
            outcome= 'five ordered outcomes'
            txo    = 'treatment and outcome interaction'
            common = 'common class-style odds ratio' ;
         txo=treat*outcome;         /* linear by linear interaction */
         datalines;
         1 1 59  1   1 2 25  1   1 3 46  1   1 4 48  1   1 5 32 -4
         2 1 48  1   2 2 21  1   2 3 44  1   2 4 47  1   2 5 30 -4
         3 1 44  1   3 2 14  1   3 3 54  1   3 4 64  1   3 5 31 -4
         4 1 43 -3   4 2  4 -3   4 3 49 -3   4 4 58 -3   4 5 41 12
      run;
      title2 'Independence of treatment and outcome';
      proc genmod;                /*  This step produces Output 3.3 */
         class treat outcome;
         model freq = treat outcome  /  dist = Poisson;
      run;
      title2 'Interaction of a pair of class variables';
      proc genmod;          /*  Output 3.4 is produced by this step */
         class treat outcome;
         model freq = treat outcome  treat * outcome / dist = Poisson;
      run;
      title2 'Fit the common odds ratio interaction';
      proc genmod;
            /* The fitted values from this step appear in Table 3.5 */
         class treat outcome;
         model freq = treat outcome common / dist = Poisson;
      run;
      title2 'Fit the treat * outcome linear by linear interaction';
      proc genmod;
            /* The fitted values from this step appear in Table 3.6 */
         class treat outcome;
         model freq =  treat outcome txo /dist = Poisson;
      run;
      title2 'Common odds and linear by linear interaction effects';
      proc genmod;
         class treat outcome;
         model freq = treat outcome common txo / dist = Poisson;
      run;



Program 4.1

         title1 'Triangular stroke data';
         data;
            input  count  row $ col $;
            label
                count   =   'number of patients'
                row     =   'admission status'
                col     =   'discharge status'
            ;
         datalines;
           11  E  A
           23  E  B
           12  E  C
           15  E  D
            8  E  E
            9  D  A
           10  D  B
            4  D  C
            1  D  D
            6  C  A
            4  C  B
            4  C  C
            4  B  A
            5  B  B
            5  A  A
         run;
         
         proc print;
         run;
         
         proc genmod;
            class row col;
            model count = row col   /* independence of rows and columns */ 
                /    dist = Poisson obstats;
         run;

Program 4.2

    data stroke;
       input  count  row  col @@;
       h=(col-5.5)*(row-6);                 /*  h asymmetry           */
       b= 1/(1+(col-5.5)**2 +(row-6)**2);   /*  center bump           */
       ob= 1/(1+(col-4.5)**2 +(row-6)**2);  /*  offset bump           */
       e=sqrt(col**2+row**2);               /*  distance from center  */
       rowc = row;                          /*  row category          */
       colc = col;                          /*  column category       */
       jr=row+normal(0)/10;                 /*  jitter row            */
       label
          count   =   'number of patients'
          colc    =   'left to right category'
          rowc    =   'front to back category'
          e       =   'distance from center'
          h       =   'h interaction'
          b       =   'bump in the center'
          ob      =   'offset bump'
          jr      =   'jittered row'  ;
datalines;
 0  1  4   1  1  5   0  1  6   0  1  7   1  2  3   1  2  4   1  2  5
 0  2  6   0  2  7   4  2  8   3  3  2   1  3  3   0  3  4   1  3  5
 0  3  6   2  3  7   9  3  8  11  3  9   1  4  1   4  4  2   3  4  3
 0  4  4   1  4  5   0  4  6   3  4  7  11  4  8  15  4  9  11  4 10
 2  5  1   2  5  2   3  5  3   3  5  4   0  5  5   1  5  6   0  5  7
 1  5  8   8  5  9  13  5 10  13  6  1   7  6  2   2  6  3   5  6  4
 6  6  5   3  6  6   1  6  7   0  6  8   9  6  9  12  6 10  15  7  1
 9  7  2   4  7  3   4  7  5   0  7  6   8  7  8   7  7  9   9  7 10
 6  8  1   8  8  2   5  8  3   1  8  4   0  8  5   1  8  6   1  8  7
 8  8  8   8  8  9   7  8 10   4  9  2   4  9  3   2  9  4   1  9  5
 2  9  6   5  9  7   7  9  8   7  9  9   6 10  2   4 10  3   2 10  4
 1 10  5   2 10  6   5 10  7   8 10  8   7 10  9   3 11  3   1 11  4
 1 11  5   2 11  6   5 11  7   5 11  8
    run;
    proc genmod;      /* model of independence for rows and columns  */
       class rowc colc;
       model count =rowc colc / dist=Poisson;
    run;
         /*   Fit model for indep, h, e, ob and obtain residuals      */
    proc genmod;
       class rowc colc;
       model count = h e ob rowc colc / dist=Poisson obstats;
       ods output obstats=fitted;           /*   Capture residuals    */
    run;
    data origin;                           /*  Drop class variables   */
       set stroke;
       drop rowc colc;
    run;
    data both;                 /*  Merge observed and fitted values   */
       merge origin fitted;
    run;
    proc gplot;      /*  Plot chi-squared residuals by jittered row   */
      plot reschi * jr    / vref=0 haxis=axis1  vaxis=axis2;
    run;


Program 4.3

      %let max=7;                 /* maximum number of items to compare */
      %let cons=13;        /* number of pairwise comparisons performed  */
      title1 'Baseball games using the Bradley Terry model';
      data bball;
         input wteam $ 1-10 wtmn ltmn freq;
         label
            wteam  = 'name of winning team'
            wtmn   = 'winning team number'
            ltmn   = 'losing team number'
            freq   = 'number of wins'   ;
         jitwin=wtmn+normal(0)/10;        /* jitter winning team number */
         if ltmn < wtmn then delete;        /*  omit top half of table  */
         comps=&cons;       /*  number of times each team plays others  */
         array ph(&max) phi1-phi&max;           /* build phi parameters */
         do j=1 to &max;
            ph(j)=0;                        /*  initialize all to zero  */
         end;             /*  differences of phi's for comparisons:     */
         ph(wtmn)=+1;                            /* +1 for winning team */
         ph(ltmn)=-1;                            /* -1 for losing team  */
         datalines;
Milwaukee  1  2  7
Milwaukee  1  3  9
Milwaukee  1  4  7
Milwaukee  1  5  7
Milwaukee  1  6  9
Milwaukee  1  7 11
Detroit    2  1  6
Detroit    2  3  7
Detroit    2  4  5
Detroit    2  5 11
Detroit    2  6  9
Detroit    2  7  9
Toronto    3  1  4
Toronto    3  2  6
Toronto    3  4  7
Toronto    3  5  7
Toronto    3  6  8
Toronto    3  7 12
New York   4  1  6
New York   4  2  8
New York   4  3  6
New York   4  5  6
New York   4  6  7
New York   4  7 10
Boston     5  1  6
Boston     5  2  2
Boston     5  3  6
Boston     5  4  7
Boston     5  6  7
Boston     5  7 12
Cleveland  6  1  4
Cleveland  6  2  4
Cleveland  6  3  5
Cleveland  6  4  6
Cleveland  6  5  6
Cleveland  6  7  6
Baltimore  7  1  2
Baltimore  7  2  4
Baltimore  7  3  1
Baltimore  7  4  3
Baltimore  7  5  1
Baltimore  7  6  7
      run;

      ods output obstats=fitted;
      proc genmod;                          /* Fit Bradley-Terry model */
         model freq / comps  =  phi1-phi7 
              / dist = binomial noint obstats;
      run;
      data two;
         merge fitted bball;             /* combine fitted and raw data */
         output;                          /* output lower half of table */
         j=wtmn;  wtmn=ltmn;  ltmn=j;    /* rebuild upper half of table */
         reschi=-reschi;  pred=13-pred;
         jitwin=wtmn+normal(0)/10;
         output;
         drop phi1-phi7;
      run;
      proc gplot;
         plot Streschi * jitwin;
      run;
      quit;


========================================================


Program 5.1

       title1 'Deaths from testicular cancer in Japan';
       data tcancer;
          input age pop1 c1 pop2 c2 pop3 c3 pop4 c4 pop5 c5;
          array p(5) pop1-pop5;       /* populations at each year group */
          array d(5) c1-c5;         /* cancer cases for each year group */
          label
             agegrp = 'age in 5yr interval'
             logpop = 'log-population';
            /* Produce a separate line for each year/age combination    */
           agegrp=age/5;                  /* age in five year intervals */
           do j=1 to 5;                   /* for each line read in . .  */
              deaths=d(j);                   /* number of cancer deaths */
              logpop=log(p(j));                    /* log of population */
              year=j-1;                  /* recode the years as 0,...,4 */
              yearc=year;                              /* year category */
              cohort=agegrp - year + 4; /* identify the diagonal cohort */
              output;     /* produce five output lines for each read in */
           end;
           drop j pop1-pop5 c1-c5;           /* omit unneeded variables */
           datalines;
 0 15501 17 26914 51 21027 65 20246 69 21596  74
 5 14236  . 25380  6 26613  7 20885  8 20051   7
10 13270  . 23492  3 25324  3 26540  7 20718  11
15 12658  2 21881  6 23211 15 24931 25 26182  39
20 10696  5 20402 27 21263 39 22228 56 24033  83
25  7563  5 17242 40 19994 58 20606 97 21805 125
30  7074  7 12609 18 17128 54 19864 77 20750 129
35  7038 10 11712 13 12476 36 17001 70 19890 101
40  6418  9 11478 26 11450 32 12275 29 16794  67
45  5981  7 10274 16 11157 26 11147 34 11962  37
50  4944  7  9325 16  9828 27 10705 27 10741  29
55  3994  7  7562 17  8718 19  9206 32 10086  39
60  3098  6  5902 13  6796 21  7869 21  8399  31
65  2317  4  4244 12  4911 26  5728 29  6715  34
70  1513  7  2845 17  3197 22  3737 25  4448  33
75   688  5  1587  9  1812 10  2061 25  2482  31
80   264  2   583  6   787  6   904 14  1068   9
85    73  2   179  2   246  3   335  3   419   3
       run;
       title2 'Model (5.1): Cohort, age, year; No population information';
       proc genmod;
          class yearc agegrp cohort;
          model deaths  = yearc agegrp cohort / type1 type3 dist=Poisson;
       run;
       title2 'Model (5.2): Cohort, age, year, and offset log(Pop)';
       proc genmod;
          class yearc agegrp cohort;
          ods listing exclude obstats;  /* turn off the obstats listing */
          output out=fitted  reschi=reschi; /* create an output dataset */
          model deaths  = yearc agegrp cohort
              /  obstats type1 type3 offset=logpop dist=Poisson;
       run;
       proc gplot data=fitted;              /* bubble plot of residuals */
          bubble reschi * agegrp= year;
       run;


===========================================================


Program 5.2

   title1 'Species diversity on the Galapagos Islands';
   data species;
      input name $ 1-13  species  area  d2neigh  d2sc  adjsp;
      loga=log(area);
      area=area/1000;                           /* rescale variables */
      adjsp=adjsp/100;
      d2sc=d2sc/100;
      d2neigh=d2neigh/100;
      isa=0; if name='Isabela' then isa=1;  /* indicator for Isabela */
      label
         species = '# of species on island'
         area    = 'in sq-km' 
         loga    = 'log area'
         d2neigh = 'distance to nearest neighbor'
         d2sc    = 'distance to Santa Cruz' 
         adjsp   = '# of species on adjacent island';
      datalines;
Baltra         58   25.09   0.6   0.6   44
Bartolome      31    1.24   0.6  26.3  237
Caldwell        3     .21   2.8  58.7    5
Champion       25     .10   1.9  47.4    2
Coamano         2     .05   1.9   1.9  444
Daphne Major   18     .34   8.0   8.0   44
Daphne Minor   24     .08   6.0  12.0   18
Darwin         10    2.33  34.1 290.2   21
Eden            8     .03   0.4   0.4  108
Enderby         2     .18   2.6  50.2   25
Espanola       97   58.27   1.1  88.3   58
Fernandina     93  634.49   4.3  95.3  347
Gardner A      58     .57   1.1  93.1   97
Gardner B       5     .78   4.6  62.2    3
Genovesa       40   17.35  47.4  92.2   51
Isabela       347 4669.32   0.7  28.1   93
Marchena       51  129.49  29.1  85.9  104
Onslow          2     .01   3.3  45.9   25
Pinta         104   59.56  29.1 119.6   51
Pinzon        108   17.95  10.7  10.7    8
Las Plazas     12     .23   0.5   0.6   58
Rabida         70    4.89   4.4  24.4  237
San Cristobal 280  551.62  45.2  66.6   58
San Salvador  237  572.33   0.2  19.8   70
Santa Cruz    444  903.82   0.6   0.0    8
Santa Fe       62   24.08  16.5  16.5  444
Santa Maria   285  170.92   2.6  49.2   25
Seymour        44    1.84   0.6   9.6   58
Tortuga        16    1.24   6.8  50.9  108
Wolf           21    2.85  34.1 254.7   10
   run;
   proc print;
   run;
   title2 'Fit Poisson model with all pairwise interactions';
   proc genmod;
      ods output obstats=fit;
      model species = loga | d2neigh | adjsp | d2sc @2 isa
        /   dist=Poisson obstats  type1  type3;
   run;
   proc plot data=fit;           /*  plot Poisson Pearson residuals */
     plot  reschi * loga;
   run;
   title2 'Fit Negative Binomial model with all pairwise interactions';
   proc genmod;
      ods output obstats=fitnb;
      model species = loga | d2neigh | adjsp | d2sc @2 isa
        /   dist=nb obstats type1 type3;
   run;
   proc plot data=fitnb;        /* plot negative binomial residuals */
      plot reschi* loga;
   run;




Program 6.1

     data;
        input count birth death medic ;
        label
           birth =  'names on birth certificate'
           death =  'names on death certificate'
           medic =  'names on medical record'   ;
        datalines;
           60 0 0 1
           49 0 1 0
            4 0 1 1
          247 1 0 0
          112 1 0 1
          142 1 1 0
           12 1 1 1
     run;
     title2 'Log-linear model of mutual independence';
     proc genmod;                                  /*  m, d, b model  */
        model count = medic birth death /dist = Poisson;
     run;
     title2 'Log-linear models with one interaction';
     proc genmod;                                   /*  d, b*m model  */
        model count = medic  birth  death  birth*medic / dist = Poisson;
     run;
     proc genmod;                                   /*  m, b*d model  */
        model count = medic birth death birth*death / dist = Poisson;
     run;
     proc genmod;   /*  b, d*m model (6.1) with output in Table 6.4   */
        model count = medic death birth death*medic / dist = Poisson;
     run;
     title2 'Log-linear models with two interactions';
     proc genmod;                                 /*  b*m, d*b model  */
        model count = medic birth death birth*medic birth*death
              /dist = Poisson;
     run;
     proc genmod;                                 /*  b*d, m*d model  */
        model count = medic birth death birth*death death*medic
            /dist = Poisson;
     run;
     proc genmod;                                 /*  d*m, m*b model  */
        model count = medic birth death death*medic birth*medic
            /dist = Poisson;
     run;




Program 7.1 (Macros)


     %macro tpr;                       /* Truncated Poisson regression */
        y=_RESP_;                      /*  Observed count              */
        lambda=exp(_XBETA_);           /*  Truncated Poisson parameter */
        eml=exp(-lambda);              /*  e to the minus lambda       */
        
                     /*  Truncated Poisson deviance  */
        
        dev=0;                         /*  Deviance for y=1            */
        if y > 1 then do;     
           %inv(y);                    /*  lam is MLE for y >1         */
           dev= -lam + y*log(lam) - log(1-exp(-lam));  /* deviance     */
        end;
        dev = dev + lambda - y*log(lambda) + log(1-eml);
        deviance d = 2*dev;  /*  times 2 for chi-squared distribution  */
        
            /* Provide GENMOD with link functions and variance  */
        
        %inv(_MEAN_);                    /* Find lambda for _MEAN_     */ 
        fwdlink ey = log(lam);           /* Link function: log lambda  */
        invlink linv = lambda / (1-eml); /* Truncated Poisson mean     */
                                         /* Truncated Poisson variance */
        variance var = (lambda*(lambda+1)*(1-eml)-lambda**2)/(1-eml)**2;
     %mend tpr;

     %macro inv(ev);
    /* Interval bisection to find lambda from the expected value (ev)  */
        if &ev LE 1 then                  /* expected value must be >1 */
           lam= . ;              /* lambda is not defined for ev LE 1  */
        else do;                   /* otherwise iterate to find lambda */
           lamlo=&ev-1;        /* lambda is between exp value less one */
           lamhi=&ev;                /*  . . .  and the expected value */
           do until (abs(lamhi-lamlo)<1e-7);  /* convergence criteria  */
              lam=(lamhi+lamlo)/2;            /* examine midpoint      */
              mal= lam/(1-exp(-lam));         /* mean at midpoint      */
              if mal GE &ev then lamhi=lam;   /* lower upper endpoint  */
              if mal LE &ev then lamlo=lam;   /* raise lower endpoint  */
          end;
       end;
    %mend inv;




Program 7.2

data skunk;
   input  count freq year sex $ @@;
   yr=year;  sx=sex;     /* make copies of year and sex variables */
    label
      count ='count'
      freq = 'frequency'
      year = '1977 or 1978'
      sex  = 'F M'       ;
   datalines;
   1  1 77  F    2  2  77  F    3  4  77  F   4  2  77  F   5  1  77  F
   1  3 77  M    2  0  77  M    3  3  77  M   4  3  77  M   5  2  77  M
   6  2 77  M    1  7  78  F    2  7  78  F   3  3  78  F   4  1  78  F
   5  2 78  F    1  4  78  M    2  3  78  M   3  1  78  M
run;
proc genmod;
   %tpr;                                 /* invoke the %tpr macro */
   frequency freq;
   class sex year;
   model count = sex year year*sex / obstats type1 type3;
   ods listing exclude obstats;            /* omit obstats output */
   ods output obstats=fitted;      /* Create fitted value dataset */
run;
data fit2;      /* omit class variables because these are defined */
   set fitted;                           /* in two different ways */
   drop sex year;  
run;
data both;                               /* Combine two data sets */
   merge skunk fit2;           /* Merge fitted & original values  */
   lambda=exp(xbeta);             /* Estimate of lambda parameter */
   p0 = exp(-lambda);      /* Est of probability of zero category */
   lamup = exp(xbeta + 1.96*std);            /* 95% CI for lambda */
   lamlow = exp(xbeta - 1.96*std);
   p0up = exp(-lamlow);                          /* 95% CI for p0 */
   p0low = exp(-lamup);
   se=std*lambda;               /* SE of lambda from delta-method */
   sep0=std*lambda*p0;          /* SE of p0 from the delta method */
run;
data;                                 /* Remove duplicated values */
  set both;
  by yr sx;
  if not ( first.yr | first.sx ) then delete;
run;
proc print noobs;
   var yr sx lambda se lamlow lamup p0 sep0 p0low p0up;
run;



Program 7.3

    title1 'Truncated Poisson regression to model lottery winners';
    data lottery;
       input town $ 1-14  winners popul area mill;
       dens = popul/area;
       logpop = log(popul);
       label
          popul  = 'population in 1000s'
          logpop = 'log population'
          area   = 'in square miles'
          mill   = 'property tax rate'
          dens   = 'population density';
       datalines;
Ansonia            6    17.9     6.2    28.9 
Beacon Falls       3     5.3     9.8    25.0 
Branford          11    28.0    27.9    22.6 
Cheshire           6    26.2    33.0    27.1 
Clinton            2    12.8    17.2    27.9 
Derby              6    12.0     5.3    29.6 
East Haven         9    26.5    12.6    37.1 
Guilford           6    20.3    47.7    28.6 
Hamden             9    52.0    33.0    34.1 
Madison            5    16.0    36.3    22.3 
Milford           10    49.5    23.5    30.8 
N. Branford        2    13.1    26.8    26.9 
North Haven       12    21.6    21.0    23.4 
Old Saybrook       1     9.3    18.3    15.3 
Orange             9    12.5    17.6    23.8 
Oxford             3     9.1    33.0    29.0 
Seymour            1    14.5    14.7    40.5 
Shelton            7    36.0    31.4    21.6 
Trumbull          14    33.0    23.5    24.1 
West Haven        12    54.0    10.6    41.4 
Woodbridge         1     8.0    19.3    28.4 
    run;
    title2 'Fit log population as a covariate';
    proc genmod;
       %tpr;                                /*  invoke the %tpr macros */
       model winners = mill area dens logpop / type1 type3 
          maxiter=100                 /* increase number of iterations */
          intercept=.3;        /* initial starting value for intercept */
    run;
    title2 'Fit log population using offset'; 
    proc genmod;
       %tpr;                                 /* invoke the %tpr macros */
       model winners = mill area dens / 
          offset=logpop obstats type1 type3 
          maxiter=100                 /* increase number of iterations */
          intercept=.3;        /* initial starting value for intercept */
       ods output obstats=fitted;       /* create fitted value dataset */
       ods listing exclude obstats;   /* do not print the obstats data */
    run;
    data both;
       merge lottery fitted;  /* merge the fitted and original values  */
       lambda=exp(xbeta);                /* estimated lambda parameter */
    run;
    title3 'Plot of residuals from the fitted model';
    proc gplot;
       bubble reschi * pred = dens;
    run;




Program 8.1

      data;
         do row=1 to 2;
            do col=1 to 2;
               input count @@;
               output;
            end;
         end;
         datalines;
          4 5 12 74
      run;
      proc freq;
         tables row * col / all;
         weight count;
         exact or;
      run;




Program 8.2

title1 'Extended hypergeometric distribution in Genmod';
title2 'Oral contraceptive use and myocardial infarction, Shapiro 1979';
data mi;
   input age cwoc ocuse cases total;
   label
      cwoc  = 'cases with oc use'
      ocuse = '# in age stratum using oc''s'
      cases = '# of cases in age stratum'
      total = 'sample size in this age stratum'
      age   = 'age category'
      loga  = 'log-age category';
   loga=log(age);
   datalines;
        1   4   66    6   292
        2   9   42   21   444
        3   4   30   37   393
        4   6   15   71   442
        5   6   11   99   405
run;
title3 'Model for log-odds ratio is linear in age';
proc genmod data=mi;
   %fithyp(cases,ocuse,total); /* Provide table margins */
   model cwoc = age / obstats intercept=2 
      initial = -.30 to -.10 by .05  maxit=250000;
run;
title3 'Model for log-odds ratio is linear in log-age';
proc genmod data=mi;
   %fithyp(cases,ocuse,total); /* Provide table margins */
   model cwoc = loga / obstats intercept=2
      initial = -.80 to -.60 by .05  maxit=250000;
   ods output obstats=fitted;   /* Create fitted value dataset */
   ods exclude listing obstats;
run;
data both;
   merge mi fitted;      /* Merge fitted & original values  */
   %hypmean(cases,ocuse,total,xbeta);
   mean=hypmean;
   sd=sqrt(hypvar);
run;
proc print data=both;
   var age loga mean sd total pred xbeta;
run;




Program 8.3


title1 'Extended hypergeometric regression in Genmod';
title2 'Four fungicide 2x2 tables';

data avadex;
   input
      expt exposed tumors total strain $ sex $;
   label
      expt    = 'exposed mice w/tumors'
      exposed = 'mice exposed to fungicide'
      tumors  = 'mice with tumors'
      total   = 'sample size in this 2x2 table'
      strain  = 'X or Y'
      sex     = 'M or F' ;
   datalines;
   4  16   9   95  X  M
   2  14   5  101  X  F
   4  18  14  108  Y  M
   1  15   4   97  Y  F
run;

proc genmod;
   %fithyp(exposed,tumors,total); /* Provide table margins */
   class strain sex;
   model expt = strain sex / obstats maxiter=250 type1 type3;
run;





Program 8.4 (hypergeometric macros)

 
 /* 
    Macros to fit the extended hypergeometric distribution in Genmod
 */

%macro hyp(m,n,nn,x);
/*   Log of 2 binomial coefficients in the numerator of the extended
        hypergeometric distribution: m=row sum; n=col sum;
        nn=sample size; x=count                              */
   lgamma(&m+1)-lgamma(&x+1)-lgamma(&m-&x+1)  /* m choose x  */
                                         /*  nn-m choose n-x */
      + lgamma(&nn-&m+1)-lgamma(&n-&x+1)-lgamma(&nn-&n-&m+&x+1)
                                   /* note omitted semicolon */
%mend hyp;


%macro hypmean(m,n,nn,lor);
/* Extended hypergeometric mean and variance:  m=row sum;
         n=column sum; nn=sample size; lor=log-odds ratio   */
   den=0;
   hypmean=0;
   hypvar=0;
   do j=max(0,&m+&n-&nn) to min(&n,&m);  /* loop over range */
      dterm=exp(%hyp(&m,&n,&nn,j)+j*&lor);
      den=den+dterm;              /* accumulate denominator */
      hypmean=hypmean+j*dterm;    /*  accumulate mean       */
      hypvar=hypvar+j**2*dterm;   /*  accumulate variance   */
   end;
   hypmean=hypmean/den;           /*  divide by denominator */
   hypvar=hypvar/den -hypmean**2; /*  corrected variance    */
%mend hypmean;


%macro hypinv(m,n,nn,expv);
/*  Find the hypergeometric parameter giving a distribution with 
     expected value equal to expv. This value is called lamd upon
     completion. Interval bisection is used to find lamd. 
     The initial interval for estimation of log-odds-ratio is
     +/- lorlimit. This log-odds parameter is needed for the
     deviance.                                                       */
                   lorlimit= 15;

   lamlo= -lorlimit;  lamhi= lorlimit;       /*  initial interval     */

   /* if expv is at extreme of its range then the model is degenerate */
   if &expv LE max(0,&m+&n-&nn) then lamhi=lamlo;         /* expv low */
   if &expv GE min(&n,&m) then lamlo=lamhi;         /* exvp at hi end */

   do until (abs(lamhi-lamlo)<1e-6);         /* convergence criteria  */
      lamd=(lamhi+lamlo)/2;                  /* examine midpoint      */
      %hypmean(&m,&n,&nn,lamd);              /* mean at midpoint      */
           /* shrink interval: equate expected value with expv        */
      if hypmean GE &expv then lamhi=lamd;
      if hypmean LE &expv then lamlo=lamd;
   end;
%mend hypinv;



%macro fithyp(n,m,nn);
/* This macro provides GENMOD with the link, inverse link,
   variance, and deviance needed to perform regression on the 
   log odds ratio parameter of the extended hypergeometric
   distribution.  The parameters are: n=row sum; m=column sum;
   nn=2x2 table total.                                               */

   /*   Inverse link is the mean of the distribution at _XBETA_      */
   %hypmean(&m,&n,&nn,_XBETA_);
   mean0=hypmean;
  
   /*   Likelihood evaluated at _XBETA_ is denominator of deviance   */
   devden=exp(%hyp(&m,&n,&nn,_RESP_)+_RESP_*_XBETA_)/den;


/* The deviance requires the unconstrained maximum likelihood
   estimator. This estimate is the parameter value that equates 
   the expected value with the observed value, _RESP_                */

   %hypinv(&m,&n,&nn,_RESP_);
   var0=hypvar;                              /*  Variance at MLE     */
 
    /*   Maximized likelihood is the numerator of deviance           */
   devnum=exp(%hyp(&m,&n,&nn,_RESP_)+_RESP_*lamd)/den;

   /*    Deviance at observed count is twice the log ratio           */
   devi= 2*log(devnum/devden);


   /*       Tell GENMOD about these values    */

   invlink ilink = mean0;          /* Hypergeometric mean at _XBETA_ */
   fwdlink  link = log(_MEAN_);                 /*  Forward link     */
   deviance  dev = devi;                        /*  Deviance         */
   variance vari = var0;              /*   Hypergeometric variance   */

%mend fithyp;




Program 9.1 (power macro)


 /*   Approximate power for chi-squared tests.
        INVOKE AS    %chipow(df=.,ncp=.,alpha=.);
        INPUT:
           df = degrees of freedom, taken to be 1 if missing
           ncp = non-centrality parameter for a sample of size n=1
           alpha = significance level under null hypothesis, taken
               to be .05 if missing
        OUTPUT variables:
           power = values .25 to .9 by .05 and .9 to .99 by .01
           n = approximate sample size at respective power
 */
%macro chipow(df,ncp,alpha);
   sig=&alpha;
   if sig=. then sig=.05;

   do j=1 to 23;                         /*  range for power          */
      if j<15 then power=.2 + j/20;      /* power is .25 by .05 to .9 */
      if j>=15 then power=.9+.01*(j-14); /* ... and .9 by .01 to .99  */
                                         /* approximate sample size   */
      n=cnonct(cinv(1-sig,&df),&df,1-power)/&ncp; 
      output;
   end;
   drop j sig;                           /* drop local variables      */
%mend chipow;




Program 9.2


/* Power for the null situation where margins are know a priori 
     in a 2x2 table.
        INVOKE this macro as   %nullpow(n=100, p1=.5, p2=.5);
        INPUT:
           n= known sample size, assumed to be 100 if missing
           p1,p2 = marginal probabilities, set to 1/2 if missing
        OUTPUT variables:
           power = values .25 to .9 by .05 and .9 to .99 by .01
           psi1-psi3 = odds ratios that can be tested with 
                specified power and alpha=.01, .05, and .10,
                respectively. */
%macro nullpow(n=100,p1=.5,p2=.5);
   %let nsig=3;                  /* number of significance levels */
   array alpha(&nsig) alpha1-alpha&nsig;
   array theta(&nsig) theta1-theta&nsig;
   array psi(&nsig) psi1-psi&nsig;
   alpha(1)=.01;                   /* specify significance levels */
   alpha(2)=.05;
   alpha(3)=.10;
   m= 1 / (&p1*&p2)  +  1 / (&p1*(1-&p2))  +  1 / ((1-&p1)*&p2) 
        + 1 / ((1-&p1)*(1-&p2));          /* multiplier in (9.10) */
   do j=1 to 23;                               /* range for power */
      if j<15 then power=.2 + j/20;  /* power is .25 by .05 to .9 */
      if j>=15 then power=.9+.01*(j-14); /* and .9 by .01 to .99  */
      do k=1 to &nsig;  /* for every different significance level */
         t=cnonct(cinv(1-alpha(k),1),1,1-power); /* 1 df crit val */
         theta(k)=sqrt(t/(m*&n));       /* theta in Table 9.9, 10 */
         psi(k)=((1+4*theta(k))/(1-4*theta(k)))**2; /* odds ratio */
      end;
      output;          /* every level of power on a different line */
   end;
%mend nullpow;
title1 'Approximate odds ratios for chi-squared tests';
title2 'Significance levels are .01, .05, and .10';
data initial;
  %nullpow(n=150,p1=.5,p2=.5);   /* specify N and marginal prob's */
run;
proc print noobs;
   var power psi1 psi2 psi3;
run;





Program A.1 in Appendix

     %macro tpr;                       /* Truncated Poisson regression */
        y=_RESP_;                      /*  Observed count              */
        lambda=exp(_XBETA_);           /*  Truncated Poisson parameter */
        eml=exp(-lambda);              /*  e to the minus lambda       */
        
                     /*  Truncated Poisson deviance  */
        
        dev=0;                         /*  Deviance for y=1            */
        if y > 1 then do;     
           %inv(y);                    /*  lam is MLE for y >1         */
           dev= -lam + y*log(lam) - log(1-exp(-lam));  /* deviance     */
        end;
        dev = dev + lambda - y*log(lambda) + log(1-eml);
        deviance d = 2*dev;  /*  times 2 for chi-squared distribution  */
        
            /* Provide GENMOD with link functions and variance  */
        
        %inv(_MEAN_);                    /* Find lambda for _MEAN_     */ 
        fwdlink ey = log(lam);           /* Link function: log lambda  */
        invlink linv = lambda / (1-eml); /* Truncated Poisson mean     */
                                         /* Truncated Poisson variance */
        variance var = (lambda*(lambda+1)*(1-eml)-lambda**2)/(1-eml)**2;
     %mend tpr;

     %macro inv(ev);
    /* Interval bisection to find lambda from the expected value (ev)  */
        if &ev LE 1 then                  /* expected value must be >1 */
           lam= . ;              /* lambda is not defined for ev LE 1  */
        else do;                   /* otherwise iterate to find lambda */
           lamlo=&ev-1;        /* lambda is between exp value less one */
           lamhi=&ev;                /*  . . .  and the expected value */
           do until (abs(lamhi-lamlo)<1e-7);  /* convergence criteria  */
              lam=(lamhi+lamlo)/2;            /* examine midpoint      */
              mal= lam/(1-exp(-lam));         /* mean at midpoint      */
              if mal GE &ev then lamhi=lam;   /* lower upper endpoint  */
              if mal LE &ev then lamlo=lam;   /* raise lower endpoint  */
          end;
       end;
    %mend inv;




===================  end of this file =====================


