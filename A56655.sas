

/*---------------------------------------------------------------*/
/* SAS System for Linear Models, Fourth Edition                  */
/* Ramon Littell, Walter Stroup, and Rudolf Freund               */               
/*                                                               */
/* Copyright(c) 2002 by SAS Institute, Cary, NC, USA             */
/* SAS Publications order # 56655                                */
/* ISBN 1-59047-023-0                                            */
/*---------------------------------------------------------------*/
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
 /* Attn: Ramon Littell, Walter Stroup, and Rudolf Freund             */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Ramon Littell, Walter Stroup, and Rudolf Freund  */
 /*                                                                   */
 /*-------------------------------------------------------------------*/


/* This appendix contains the SAS code needed to produce the output
   in this book with Release 8.2 of the SAS System. The DATA steps,
   including the raw data, that are needed to produce the output are
   shown here. The PROC statements that you must use are presented
   in the appropriate chapter in the context of the discussion.

   This appendix is divided into sections that correspond to chapter
   numbers to help you quickly locate the example code you need.
   Before each DATA step, there is a sentence telling you what output
   that DATA step corresponds to.
*/

/* Chapter 2 */

/* Use the following DATA step to produce Output 2.1 through 2.4. */;

data market;
  input marketid $ cattle cost;
datalines;
A         3.437     27.698
B        12.801     57.634
C         6.136     47.172
D        11.685     49.295
E         5.733     24.115
F         3.021     33.612
G         1.689      9.512
H         2.339     14.755
I         1.025     10.570
J         2.936     15.394
K         5.049     27.843
L         1.693     17.717
M         1.187     20.253
N         9.730     37.465
O        14.325    101.334
P         7.737     47.427
Q         7.538     35.944
R        10.211     45.945
S         8.697     46.890
;
proc print data=market;
run;
proc reg data=market; id cattle;
  model cost=cattle/p clm cli;
  plot cost*cattle;
run;


/* Use the following DATA step to produce Outputs 2.5 through 2.8.  */

data auction;
  input marketid $ cattle  calves  hogs  sheep  cost type $;
  volume=cattle+calves+hogs+sheep;
cards;
A  3.437  5.791  3.268 10.649  27.698 O
B 12.801  4.558  5.751 14.375  57.634 O
C  6.136  6.223 15.175  2.811  47.172 O
D 11.685  3.212   .639   .694  49.295 B
E  5.733  3.220   .534  2.052  24.115 B
F  3.021  4.348   .839  2.356  33.612 B
G  1.689   .634   .318  2.209   9.512 O
H  2.339  1.895   .610   .605  14.755 B
I  1.025   .834   .734  2.825  10.570 O
J  2.936  1.419   .331   .231  15.394 B
K  5.049  4.195  1.589  1.957  27.843 B
L  1.693  3.602   .837  1.582  17.717 B
M  1.187  2.679   .459 18.837  20.253 O
N  9.730  3.951  3.780   .524  37.465 B
O 14.325  4.300 10.781 36.863 101.334 O
P  7.737  9.043  1.394  1.524  47.427 B
Q  7.538  4.538  2.565  5.109  35.944 B
R 10.211  4.994  3.081  3.681  45.945 B
S  8.697  3.005  1.378  3.338  46.890 B
;

proc print data=auction;
run;

proc reg data=auction; id marketid;
  model cost=cattle calves hogs sheep/ss1 ss2;
  hogs:     test hogs=0;
  hogsheep: test hogs=0, sheep=0;
  intercep: test intercept=0;
  hogone:   test hogs=1;
  hequals:  test hogs-sheep=0;
run;

/* Use the following DATA step to produce Output 2.9.  */

proc reg data=auction; id marketid;
  model cost=cattle calves hogs sheep;
  restrict intercept=0, hogs-sheep=0;
run;

/* Use the following DATA step to produce Output 2.10.  */

data auction; set auction; hs=hogs+sheep;
run;
proc reg data=auction; id marketid;
  model cost=cattle calves hs / noint;
run;

/* Use the following DATA step to produce Output 2.11.  */

proc reg data=auction; id marketid;
  model cost=cattle calves hogs sheep volume;
run;

/* Use the following DATA step to produce Output 2.12.  */

proc glm data=auction; id marketid;
  model cost=cattle calves hogs sheep;
run;

/* Use the following DATA step to produce Outputs 2.13 and 2.14.  */

proc glm data=auction; id marketid;
  model cost=cattle calves hogs sheep;
  contrast 'hogcost=0' intercept 0 cattle 0 calves 0 hogs 1 sheep 0;
  contrast 'hogcost=0' hogs 1;
  contrast 'hogcost=sheepcost' hogs 1 sheep -1;
  contrast 'hogcost=sheepcost=0' hogs 1, sheep 1;
  estimate 'hogcost' hogs 1;
  estimate 'hogcost-sheepcost' hogs 1 sheep -1;
run;



/* Chapter 3 */

/* Use the following DATA step to produce Output 3.1. */

    data peppers;
      input angle @@;
    datalines;
    3 11 -7 2 3 8 -3 -2 13 4 7
    -1 4 7 -1 4 12 -3 7 5 3 -1
    9 -7 2 4 8 -2
    ;
    proc print;
    proc means mean std stderr t prt;
    run;

/* Use the following DATA step to produce Outputs 3.2 and 3.3.  */

        data pulse;
      input pre post;
      d=pre-post;
    cards;
    62 61
    63 62
    58 59
    64 61
    64 63
    61 58
    68 61
    66 64
    65 62
    67 68
    69 65
    61 60
    64 65
    61 63
    63 62
    ;
    proc print;
    proc means mean std stderr t prt;
      var d;
        proc ttest;
         paired pre*post;
    run;

/* Use the following DATA step to produce Outputs 3.4 and 3.5.  */

    data bullets;
      input powder velocity;
    datalines;
    1 27.3
    1 28.1
    1 27.4
    1 27.7
    1 28.0
    1 28.1
    1 27.4
    1 27.1
    2 28.3
    2 27.9
    2 28.1
    2 28.3
    2 27.9
    2 27.6
    2 28.5
    2 27.9
    2 28.4
    2 27.7
    proc print data=bullets;
    proc ttest data=bullets; var velocity;
      class powder;
    run;

/* Use the following SAS statements produce Outputs 3.6.       */
/* Note that you must use these statements together with the   */
/*    DATA step used to produce Output 3.4                     */

proc anova data=bullets;
 class powder;
 model velocity=powder;
run; 

/* Use the following SAS statements produce Outputs 3.7.       */
/* Note that you must use these statements together with the   */
/*    DATA step used to produce Output 3.4                     */

proc sort data=bullets; by powder;
proc univariate data=bullets normal plot;
 by powder; 
 var velocity;
run;


/* Use the following DATA step to produce Output 3.8 through 3.16. */

   data veneer;
      input brand $ wear;
   cards;
   ACME 2.3
   ACME 2.1
   ACME 2.4
   ACME 2.5
   CHAMP 2.2
   CHAMP 2.3
   CHAMP 2.4
   CHAMP 2.6
   AJAX 2.2
   AJAX 2.0
   AJAX 1.9
   AJAX 2.1
   TUFFY 2.4
   TUFFY 2.7
   TUFFY 2.6
   TUFFY 2.7
   XTRA 2.3
   XTRA 2.5
   XTRA 2.3
   XTRA 2.4
   ;
   proc print data=veneer;
   run;
   
   proc glm;
    class brand;
    model wear=brand;
        means brand/lsd;
        means brand/lsd clm hovtest;
    contrast 'ACME vs AJAX' brand 1 -1 0 0 0;
    contrast 'US vs NON U.S.' brand  2  2  2 -3 -3;
    contrast 'A-L vs C-L'    brand  1  1 -2  0  0;
    contrast 'ACME vs AJAX'  brand  1 -1  0  0  0;
    contrast 'TUFFY vs XTRA' brand  0  0  0  1 -1;
    contrast 'US BRANDS' brand 1 -1 0 0 0,  brand 1 0 -1 0 0;
        estimate 'ACME vs AJAX' brand 1 -1 0 0 0;
        estimate 'US MEAN' intercept 3 brand 1 1 1 0 0 / divisor=3;
   run;

/* Use the following DATA step to produce Output 3.17 through 3.22. */

data methods;
 input irrig $ @@;
  do bloc=1 to 8;
   input fruitwt @@;
   logfwt=log(fruitwt);
   output;
  end;
datalines;
trickle       450 469 249 125 280 352 221 251
basin         358 512 281  58 352 293 283 186
spray         331 402 183  70 258 281 219  46
sprnkler      317 423 379  63 289 239 269 357
flood         245 380 263  62 336 282 171  98
;

proc sort;
 by bloc irrig;
proc print;
 var bloc irrig fruitwt;
run;

proc glm;
 class bloc irrig;
 model fruitwt=bloc irrig;
 means irrig/duncan lsd tukey waller;
 means irrig/duncan tukey alpha=0.1;
 means irrig/tukey alpha=0.1 cldiff;
 means irrig/dunnett alpha=0.1; 
 means irrig/dunnett ('flood') alpha=0.1; 
run;

/* Use the following DATA step to produce Output 3.23 and 3.24. */


 data garments;
 input run pos mat $ wtloss shrink;
 cards;
 2 4 A 251 50
 2 2 B 241 48
 2 1 D 227 45
 2 3 C 229 45
 3 4 D 234 46
 3 2 C 273 54
 3 1 A 274 55
 3 3 B 226 43
 1 4 C 235 45
 1 2 D 236 46
 1 1 B 218 43
 1 3 A 268 51
 4 4 B 195 39
 4 2 A 270 52
 4 1 C 230 48
 4 3 D 225 44
 ;
 proc print data=garments;
 run;

    proc glm data=garments;
      class run pos mat;
      model wtloss shrink = run pos mat;
    run;

/*  Use the following DATA step to produce Output 3.25 through 3.27. */

data grasses;
input method $ 1 variety 2 y1-y6 trt $ 1-2;
y1=y1/10; y2=y2/10; y3=y3/10; y4=y4/10; y5=y5/10; y6=y6/10;
cards;
a1 221 241 191 221 251 181
a2 271 151 206 286 151 246
a3 223 258 228 283 213 183
a4 198 283 268 273 268 268
a5 200 170 240 225 280 225
b1 135 145 115  60 270 180
b2 169 174 104 194 119 154
b3 157 102 167 197 182 122
b4 151  65 171  76 136 211
b5 218 228 188 213 163 143
c1 190 220 200 145 190 160
c2 200 220 255 165 180 175
c3 164 144 214 199 104 214
c4 245 160 110  75 145 155
c5 118 143 213  63  78 138
;
*proc print; 
*run;

data fctorial;  set grasses;  drop y1-y6;
  yield=y1; output;
  yield=y2; output;
  yield=y3; output;
  yield=y4; output;
  yield=y5; output;
  yield=y6; output;
run;

proc sort; 
 by method variety;
proc means data=fctorial noprint;
 by method variety;
 output out=factmean mean=yldmean;
proc print data=factmean;
run;

axis1 value=(font=swiss2 h=2) label=(f=swiss h=2 'yield mean');
axis2 value=(font=swiss h=2 )label=(f=swiss h=2 'Variety');
legend1 value=(font=swiss h=2  ) label=(f=swiss h=2 'Method');
symbol1 color=black interpol=join
         line=1  value='A' font=swiss;
symbol2 color=black interpol=join
       line=2 value='B' font=swiss;
symbol3 color=black interpol=join
        line=20 value='C' font=swiss;

proc gplot data=factmean;
 plot yldmean*variety=method/caxis=black ctext=black vaxis=axis1 haxis=axis2 legend=legend1;
run;

/* The following SAS statements produce Output 3.28 through 3.30  */
/* These statements must be used in conjuction with the DATA step */
/*    used to produce Output 3.25                                 */

proc glm data=fctorial;
 class method variety;
 model yield=method|variety;
 means method variety method*variety;
 lsmeans method*variety/slice=(variety method);
 lsmeans method*variety/cl pdiff adjust=tukey;
run;

/* The following SAS statements produce Output 3.31               */
/* These statements must be used in conjuction with the DATA step */
/*    used to produce Output 3.25                                 */

proc mixed data=fctorial;
 class variety method;
 model yield=method variety method*variety;
 lsmeans method*variety/diff;
 ods output diffs=cld;
run;

data smpleff;
 set cld;
 if variety=_variety;

proc print data=smpleff;
 var variety _variety method _method estimate stderr df tvalue probt;
run;

/* The following SAS statements produce Output 3.32 through 3.36  */
/* These statements must be used in conjuction with the DATA step */
/*    used to produce Output 3.25                                 */

proc glm data=fctorial; 
 class method variety;
 model yield=method variety method*variety / ss1;
       estimate 'A vs B,C in V1' method 1 -.5 -.5
        method*variety 1 0 0 0 0  -.5 0 0 0 0  -.5 0 0 0 0;
       estimate 'A vs B,C in V2' method 1 -.5 -.5
        method*variety 0 1 0 0 0  0 -.5 0 0 0  0 -.5 0 0 0;
       estimate 'A vs B,C in V3' method 1 -.5 -.5
        method*variety 0 0 1 0 0  0 0 -.5 0 0  0 0 -.5 0 0;
       estimate 'A vs B,C in V4' method 1 -.5 -.5
        method*variety 0 0 0 1 0  0 0 0 -.5 0  0 0 0 -.5 0;
       estimate 'A vs B,C in V5' method 1 -.5 -.5
        method*variety 0 0 0 0 1  0 0 0 0 -.5  0 0 0 0 -.5;
 estimate 'A vs B,C Overall' method 1 -.5 -.5
   method*variety .2 .2 .2 .2 .2  -.1 -.1 -.1 -.1 -.1 -.1 -.1 -.1 -.1 -.1;
contrast 'A vs BC * Varieties'
   method * variety 1 0 0 0 -1  -.5 0 0 0 .5  -.5 0 0 0 .5,
   method * variety 0 1 0 0 -1  0 -.5 0 0 .5  0 -.5 0 0 .5,
   method * variety 0 0 1 0 -1  0 0 -.5 0 .5  0 0 -.5 0 .5,
   method * variety 0 0 0 1 -1  0 0 0 -.5 .5  0 0 0 -.5 .5;    
contrast 'A vs B,C * V1,V2'
    method*variety 1 -1 0 0 0  -.5 .5 0 0 0  -.5 .5 0 0 0;   
contrast 'A vs B,C * V3,V4'
    method*variety 0 0 1 -1 0  0 0 -.5 .5 0  0 0 -.5 .5 0;
estimate 'A vs B,C in V1,V2' method 1 -.5 -.5
   method*variety .5 .5 0 0 0  -.25 -.25 0 0 0  -.25 -.25 0 0 0;
run;


options ls=78;

/* Chapter 4 */

/* Use the following DATA steps to produce Output 4.1 through 4.11. */

    data microbgs;
      do package=1 to 20;
       p=rannor(111); drop p;
        s1=rannor(1111); s2=rannor(1112); s3=rannor(1113);
         drop s1 s2 s3;
       lgct11=5 + p + .7* s1 + .3*rannor(11111); ct11=4**lgct11;
       lgct12=5 + p + .7* s1 + .3*rannor(11111); ct12=4**lgct12;
       lgct21=5 + p + .7* s2 + .3*rannor(11111); ct21=4**lgct21;
       lgct22=5 + p + .7* s2 + .3*rannor(11111); ct22=4**lgct22;
       lgct31=5 + p + .7* s3 + .3*rannor(11111); ct31=4**lgct31;
       lgct32=5 + p + .7* s3 + .3*rannor(11111); ct32=4**lgct32;
      output;
    end;
    data microbgs; set microbgs;
    keep package ct11 ct12 ct21 ct22 ct31 ct32;
      ct11=round(ct11);
      ct12=round(ct12);
      ct21=round(ct21);
      ct22=round(ct22);
      ct31=round(ct31);
      ct32=round(ct32);
    run;

proc print;
run;

    data logbgs; set microbgs;
      drop ct11 ct12 ct21 ct22 ct31 ct32;
       sample=1; logct=log10(ct11); output;
       sample=1; logct=log10(ct12); output;
       sample=2; logct=log10(ct21); output;
       sample=2; logct=log10(ct22); output;
       sample=3; logct=log10(ct31); output;
       sample=3; logct=log10(ct32); output;
    run;
    data bugs; set logbgs;
      ct=10**logct;

options ps=36;
proc plot;
 plot (ct logct)*package=sample;
run;

proc glm;
 class package sample;
 model logct=package sample(package);
 means package;
 random package sample(package)/test;
 test h=package e=sample(package);
run;

proc mixed covtest;
 class package sample;
 model logct= / solution;
 random package sample(package)/solution;
* random package; /* use this RANDOM statement in place of above to obtain Ouptut 4.8,  */
                  /* used for likelihood ratio test discussed on pp. 102-103            */
 estimate 'overall mean' intercept 1;
 estimate 'pkg 1 blup' intercept 1 | package 1 0;
run;

/* Use the following SAS program statements to generate Outputs 4.12 through 4.13, 4.15, and 4.16.    */
/* Note: Output 4.14 generated by separate code given below.                                          */
/* Also note: these statements must be used in conjunction with the SAS DATA step statements          */
/*    given above to generate the Valencia orange data shown in Output 3.17.                          */  

proc mixed data=methods;
 class bloc irrig;
 model fruitwt=irrig;
 random bloc;
 lsmeans irrig/diff adjust=dunnett;
 estimate 'trt diff' irrig 1 -1 0;
 estimate 'irrig lsmean' intercept 1 irrig 1 0;
 estimate 'irrig narrow lsm' intercept 8 irrig 8 0
         | bloc 1 1 1 1 1 1 1 1/divisor=8;
run;

/* Run the following SAS statements to obtain Output 4.14. Use them in conjunction with the            */
/*    SAS DATA step statements given above to generate the Valencia orange data shown in Output 3.17.  */
  
proc mixed order=data data=methods;
 class bloc irrig;
 model fruitwt=irrig;
 random bloc;
 lsmeans irrig/diff adjust=dunnett;

/* Run the following SAS statements to obtain Output 4.17. Use them in conjunction with the            */
/*    SAS DATA step statements given above to generate the Valencia orange data shown in Output 3.17.  */

proc glm data=methods;
 class bloc irrig;
 model fruitwt=bloc irrig;
 estimate 'trt diff' irrig 1 -1 0;
run;

/* Run the following SAS statements to produce Outputs 4.18 through 4.21.     */
/* These statements also produce Ouptut 4.25                                  */
/* Note that these statements must be run in conjuction with the DATA step    */
/*    uaed to create DATA=FCTORIAL, the univariate version of the factorial   */
/*    data setshown in Output 3.25                                            */

proc glm data=fctorial; 
 class method variety;
  model yield = method variety method*variety;
  contrast 'A vs B,C' method 2 -1 -1;
  random variety method*variety/q;
run;

/* Run the following SAS statements to produce Output 4.22.                   */
/* Note that these statements must be run in conjuction with the DATA step    */
/*    uaed to create DATA=FCTORIAL, the univariate version of the factorial   */
/*    data setshown in Output 3.25                                            */

proc mixed data=fctorial; 
 class method variety;
  model yield = method ;
  contrast 'A vs B,C' method 2 -1 -1;
  estimate 'A-B diff' method 1 -1 0;
  random variety method*variety;
run;

/* Run the following SAS statements to produce Output 4.23.                   */
/* Note that these statements must be run in conjuction with the DATA step    */
/*    uaed to create DATA=FCTORIAL, the univariate version of the factorial   */
/*    data setshown in Output 3.25                                            */

proc mixed data=fctorial method=type3; 
 * proc mixed data=fctorial method=type1; /* alternative PROC MIXED statement to obtain  */
                                          /* analysis using REML with NOBOUND option     */
 class method variety;
  model yield = method ;
  contrast 'A vs B,C' method 2 -1 -1;
  estimate 'A-B diff' method 1 -1 0;
  random variety method*variety;
run;

/* Run the following DATA step to obtain Outputs 4.28 through 4.34          */


    data chips;
      input resista et wafer pos;
    cards;
   5.22 1 1 1
   5.61 1 1 2
   6.11 1 1 3
   6.33 1 1 4
   6.13 1 2 1
   6.14 1 2 2
   5.60 1 2 3
   5.91 1 2 4
   5.49 1 3 1
   4.60 1 3 2
   4.95 1 3 3
   5.42 1 3 4
   5.78 2 1 1
   6.52 2 1 2
   5.90 2 1 3
   5.67 2 1 4
   5.77 2 2 1
   6.23 2 2 2
   5.57 2 2 3
   5.96 2 2 4
   6.43 2 3 1
   5.81 2 3 2
   5.83 2 3 3
   6.12 2 3 4
   5.66 3 1 1
   6.25 3 1 2
   5.46 3 1 3
   5.08 3 1 4
   6.53 3 2 1
   6.50 3 2 2
   6.23 3 2 3
   6.84 3 2 4
   6.22 3 3 1
   6.29 3 3 2
   5.63 3 3 3
   6.36 3 3 4
   6.75 4 1 1
   6.97 4 1 2
   6.02 4 1 3
   6.88 4 1 4
   6.22 4 2 1
   6.54 4 2 2
   6.12 4 2 3
   6.61 4 2 4
   6.05 4 3 1
   6.15 4 3 2
   5.55 4 3 3
   6.13 4 3 4
   ;

proc print;
run; 

proc glm data=chips;
 class et wafer pos;
 model resista = et wafer(et) pos et*pos / ss3;
 test h=et e=wafer(et); 
 random wafer(et)/test;
 lsmeans et*pos/slice=pos;
 contrast 'ET1 vs ET2'           et 1 -1 0 0;
 contrast 'ET1 vs ET2'           et 1 -1 0 0/e=wafer(et);
 contrast 'POS1 vs POS2'         pos 1 -1 0 0;
 contrast 'POS1 vs POS2 in ET1'  pos 1 -1 0 0 et*pos 1 -1;
 contrast 'ET1 vs ET2 in POS1'   et 1 -1 0 0 et*pos 1 0 0 0 -1;
 estimate 'ET1 vs ET2 in POS1'   et 1 -1 0 0 et*pos 1 0 0 0 -1;
run;

proc mixed data=chips;
 class et wafer pos;
 model resista = et|pos/ddfm=satterth;
 random wafer(et);
 lsmeans et*pos/slice=pos;
 lsmeans et|pos/diff;
 contrast 'ET1 vs ET2'           et 1 -1 0 0;
 contrast 'POS1 vs POS2'         pos 1 -1 0 0;
 contrast 'POS1 vs POS2 in ET1'  pos 1 -1 0 0 et*pos 1 -1;
 contrast 'ET1 vs ET2 in POS1'   et 1 -1 0 0 et*pos 1 0 0 0 -1;
 estimate 'ET1 vs ET2 in POS1'   et 1 -1 0 0 et*pos 1 0 0 0 -1;
run;

/* Run the following DATA step to obtain Outputs 4.35 through 4.38  */

data cult_inoc;
 input rep cult $ inoc $ drywt;
cards;
1 a con 27.4
1 a dea 29.7
1 a liv 34.5
1 b con 29.4
1 b dea 32.5
1 b liv 34.4
2 a con 28.9
2 a dea 28.7
2 a liv 33.4
2 b con 28.7
2 b dea 32.4
2 b liv 36.4
3 a con 28.6
3 a dea 29.7
3 a liv 32.9
3 b con 27.2
3 b dea 29.1
3 b liv 32.6
4 a con 26.7
4 a dea 28.9
4 a liv 31.8
4 b con 26.8
4 b dea 28.6
4 b liv 30.7
run;

proc glm;
 class rep cult inoc;
  model drywt = rep cult rep*cult inoc cult*inoc;
 test h=cult e=rep*cult;
 random rep cult*rep/test;
run;

proc mixed;
 class rep cult inoc;
  model drywt = cult inoc cult*inoc;
 random rep rep*cult;
run;




/* Chapter 5 */

/* Use the following DATA steps to produce Outputs 5.1 through 5.6. */

data drugs1;
input STUDY TRT $ PATIENT FLUSH0 FLUSH;
datalines;
41      B       102        77.5    72.0000
41      B       104        23.5     5.6250
41      B       105        63.5    81.8750
41      B       106        72.5    83.5000
41      B       107        58.0    75.5000
41      B       108        49.0    13.7500
41      B       109         7.5     9.3750
41      B       110        13.5     7.8750
41      B       111        13.5     6.0000
41      B       112        76.5    61.6000
41      B       113        78.5    98.1250
41      B       114        56.5    46.1250
41      B       115        61.0    24.2500
41      B       116        91.0    64.4000
41      B       117        13.5     7.3333
41      B       118        63.5    79.2500
42      A       201        50.5    70.3333
42      A       203        84.5    16.1429
42      B       202        33.5    28.3333
43      A       302        22.0    14.5000
43      A       305        23.0    25.5000
43      A       306        22.0    12.2500
43      A       307        13.0     3.1250
43      A       310        50.5    51.1250
43      A       313        57.0    49.2500
43      A       316        13.5     1.6250
43      A       317        36.5    29.5000
43      A       321        59.0    30.5000
43      A       322        30.5    33.5000
43      A       323        10.5     2.2500
43      A       325        37.0    13.8750
43      A       327        35.5    21.0000
43      A       329        28.0    16.0000
43      B       301        40.5    17.5000
43      B       303        12.5     8.8333
43      B       304        47.5    40.0000
43      B       308        34.5    23.1429
43      B       309        15.5     3.1250
43      B       311        43.0    35.8750
43      B       314        30.0    31.6250
43      B       315        27.5    16.0000
43      B       318        62.0    41.1250
43      B       319       105.0    44.7500
43      B       324        38.5    43.1250
43      B       326         7.0    15.0000
43      B       328         8.0     4.5000
43      B       330        30.5    19.0000
44      A       401        46.0    14.8750
44      A       405        36.5     2.9231
44      A       406        22.5     2.8000
44      A       408        21.5     1.3750
44      A       409        27.0    22.0000
44      A       411        46.5      .
44      B       402        14.0     4.7778
44      B       403        23.0     3.6667
44      B       404        30.0    17.1250
44      B       407        19.0    22.3636
44      B       410        67.5    18.1667
44      B       412        12.0     2.0000
45      A       502        60.0    62.0000
45      A       503        36.0    13.6250
45      A       506        24.0     1.0000
45      A       507        29.0    24.1250
45      A       510        12.5    11.5000
45      A       512        82.5    84.0000
45      A       513        31.5     0.6250
45      A       515        53.0    45.0000
45      A       518        56.0    43.7500
45      A       519       23.0      7.3750
45      A       520       48.5     43.1429
45      A       527       16.0       .
45      B       501       34.0     30.0000
45      B       504       74.5     38.3750
45      B       505       22.0     25.3750
45      B       508        7.0      2.8750
45      B       509       13.0      8.1250
45      B       511       34.5     28.8750
45      B       514       20.5     22.6000
45      B       516       75.5     37.0000
45      B       517       50.0     59.1250
45      B       529       27.5     26.8000
45      B       530       49.0     33.0000
46      A       601       31.0      5.0000
46      A       602       53.0     20.8750
46      A       605       28.0     16.0000
46      A       608       21.5      7.5000
46      A       609       11.5      3.3750
46      A       611       59.0     35.6250
46      B       603       39.0     50.0000
46      B       604       65.0     43.0000
46      B       606       43.5     41.0000
46      B       607       25.0      8.5000
46      B       610       26.5      0.5000
46      B       629       27.5     15.5000
46      B       630       19.5     11.1250
47      A       702       19.5     17.6000
47      A       703       28.0      6.8750
47      A       704       53.5     28.7500
47      A       707       29.0     22.3750
47      A       710       37.5     23.0000
47      A       712       29.0     26.6667
47      B       701       59.0     51.5000
47      B       705       59.0     29.8750
47      B       706       89.5     61.6250
47      B       708       72.0     77.6250
47      B       709       16.0     26.0000
47      B       711       88.0     92.1250
47      B       713       38.0      4.3750
48      A       801       56.0     42.5000
48      A       803       79.5     40.2500
48      A       804       42.0     12.6250
48      A       808       78.0       .
48      A       809       37.5      7.0000
48      A       812       45.5     17.1250
48      A       813       81.0     15.0000
48      A       816       22.5     18.0000
48      B       802       30.5     19.6250
48      B       805       20.0      3.8750
48      B       806       71.5     49.2500
48      B       807       13.5     15.0000
48      B        810      11.0      15.375
48      B        811      15.0      12.375
48      B        814      22.5      27.800
48      B        815      40.0      37.286
49      A        901      40.5      27.500
49      A        902      68.5      17.000
49      A        905      10.5       0.125
49      A        909      20.0       4.571
49      A        911      74.5      79.125
49      A        912      61.5      67.750
49      A        913      32.5      11.875
49      A        916      52.0      79.750
49      A        917      50.0      21.429
49      A        930      23.5      12.429
49      B        903      46.0      53.750
49      B        904      11.5       0.125
49      B        906      71.0      53.500
49      B        907      68.5      49.250
49      B        908      26.0      10.500
49      B        910      19.0       3.250
49      B        914       3.5       0.000
49      B        915      76.5      59.625
49      B        918      21.0      24.286
49      B        920      15.5      19.667
50      A       1004      19.5       5.000
50      A       1005      22.0       2.125
50      A       1006      14.0      18.750
50      A       1007      67.0      12.000
50      B       1001      87.0      50.250
50      B       1002      37.5      32.375
50      B       1003      85.5     133.000
;

data drugs;
set drugs1;
if study>41;
run;
proc print data=drugs;
run;
proc means data=drugs; var flush;
by study trt;
run;

proc glm data=drugs;
  class trt study;
  model flush = trt study trt*study / ss1 ss2 ss3;
run;
contrast 'trtB-trtA' trt -1 1;
estimate 'trtB-trtA' trt -1 1;
run;
lsmeans trt / stderr pdiff;
run;
contrast 'trtB-trtA wtd' trt -1 1 trt*study -.03 -.20 -.09 -.17 -.1 -.1 -.1 -.14 -.07
                                             .03  .20  .09  .17  .1  .1  .1  .14  .07;
run; 

/* Use the following DATA steps to produce Outputs 5.7 through 5.9. */

proc glm data=drugs1;
  class trt study;
  model flush = trt study trt*study / ss1 ss2 ss3 ss4;
run;
contrast 'trtB-trtA' trt -1 1;
estimate 'trtB-trtA' trt -1 1;
lsmeans trt / stderr pdiff;
run;

/* Use the following DATA steps to produce Outputs 5.10 through 5.12. */

proc glm data=drugs;
  class trt study;
  model flush = trt study trt*study / ss1 ss2 ss3;
  contrast 'trtB-trtA' trt -1 1;
  estimate 'trtB-trtA' trt -1 1;
  lsmeans trt / stderr pdiff;
  random study trt*study / test;
run;

/* Use the following DATA steps to produce Outputs 5.13 through 5.15. */

proc mixed data=drugs;
  class trt study;
  model flush = trt / ddfm=satterth;
  random study trt*study;
  contrast 'trtB-trtA' trt -1 1;
  estimate 'trtB-trtA' trt -1 1;
  lsmeans trt / pdiff;
run;
proc glm data=drugs1;
  class trt study;
  model flush = trt study trt*study / ss1 ss2 ss3 ss4;
  contrast 'trtB-trtA' trt -1 1;
  estimate 'trtB-trtA' trt -1 1;
  lsmeans trt / stderr pdiff;
  random study trt*study / test;
run;
proc mixed data=drugs1;
  class trt study;
  model flush = trt / ddfm=satterth;
  random study trt*study;
  contrast 'trtB-trtA' trt -1 1;
  estimate 'trtB-trtA' trt -1 1;
  lsmeans trt / pdiff;
run;



/* Chapter 6 */

/* Use the following statements to produce Output 6.1 through 6.3. */

data teachers;
input teach $ score1 score2;
datalines;
    JAY        69        75
    JAY        69        70
    JAY        71        73
    JAY        78        82
    JAY        79        81
    JAY        73        75
    PAT        69        70
    PAT        68        74
    PAT        75        80
    PAT        78        85
    PAT        68        68
    PAT        63        68
    PAT        72        74
    PAT        63        66
    PAT        71        76
    PAT        72        78
    PAT        71        73
    PAT        70        73
    PAT        56        59
    PAT        77        83
    ROBIN      72        79
    ROBIN      64        65
    ROBIN      74        74
    ROBIN      72        75
    ROBIN      82        84
    ROBIN      69        68
    ROBIN      76        76
    ROBIN      68        65
    ROBIN      78        79
    ROBIN      70        71
    ROBIN      60        61
;
proc print data=teachers;
run;

proc glm data=teachers;
  class teach;
  model score2=teach / solution xpx i;
run;

/* Use the following statements insteaDATA step to produce Output 6.4 through 6.6. */

proc glm data=teachers;
  class teach;
  model score2=teach / e;
  lsmeans teach / stderr pdiff;
  contrast 'JAY vs OTHERS';
  contrast 'PAT vs ROBIN';
run;

/* Use the following statements to produce Output 6.7 through 6.8. */

data twoway;
input a b Y;
datalines;
    1    1    5
    1    1    6
    1    2    2
    1    2    3
    1    2    5
    1    2    6
    1    2    7
    1    3    3
    2    1    2
    2    1    3
    2    2    8
    2    2    8
    2    2    9
    2    3    4
    2    3    4
    2    3    6
    2    3    6
    2    3    7
;
proc print data=twoway;
run;

proc glm data=twoway;
  class a b;
  model Y=a b a*b / ss1 ss2 ss3 ss4 solution;
run;

/* Use the following statements to produce Output 6.9 through 6.11. */

proc glm data=twoway;
  class a b;
  model y=a b a*b;
  means a b;
  lsmeans a b / stderr;
  contrast 'A EFFECT' a -1 1;
  contrast 'B 1 vs 2 & 3' b -2 1 1;
  contrast 'B 2 vs 3' b 0 -1 1;
  contrast 'ALL B' b -2 1 1, b 0 -1 1;
  contrast 'A*B 2 vs 3' a*b 0 1 -1 0 -1 1;
  estimate 'B2, B3 MEAN' intercept 1 a .5 .5 b 0 .5 .5
                         a*b 0 .25 .25 0 .25 .25;
  estimate 'A in B1' a -1 1 a*b -1 0 0 1;
run;

/* Use the following statements to produce results in Tables 6.2 through 6.5. */

proc glm data=twoway;
  class a b;
  model y=a b a*b / e e1 e2 e3;
run;

/* Use the following statements to produce Output 6.12 */

proc glm data=twoway;
class a b;
model y=a b a*b / solution;
contrast 'B 2 vs 3' b 0 -1 1 / e;
estimate 'A in B1' a -1 1 a*b -1 0 0 1 / e;
lsmeans a / stderr e;
run;

/* Use the following statements to produce results in Tables 6.6 through 6.8.
and Output 6.13 */

data twoway2;
input a b Y;
datalines;
    1    1    5
    1    1    6
    1    2    2
    1    2    3
    1    2    5
    1    2    6
    1    2    7
    1    3    .
    2    1    2
    2    1    3
    2    2    8
    2    2    8
    2    2    9
    2    3    4
    2    3    4
    2    3    6
    2    3    6
    2    3    7
;
proc glm data=twoway2;
  class a b;
  model y=a b a*b / e3 e4 solution;
  lsmeans a b / e stderr;
run;



/* Chapter 7 */

/* Use the following DATA step to produce Output 7.1 through 7.6. */

    data oysters;
       input  trt rep initial final;
       cards;
    1        1        27.2        32.6
    1        2        32.0        36.6
    1        3        33.0        37.7
    1        4        26.8        31.0
    2        1        28.6        33.8
    2        2        26.8        31.7
    2        3        26.5        30.7
    2        4        26.8        30.4
    3        1        28.6        35.2
    3        2        22.4        29.1
    3        3        23.2        28.9
    3        4        24.4        30.2
    4        1        29.3        35.0
    4        2        21.8        27.0
    4        3        30.3        36.4
    4        4        24.3        30.5
    5        1        20.4        24.6
    5        2        19.6        23.4
    5        3        25.1        30.3
    5        4        18.1        21.8
    ;

        proc print;
        run;

        proc glm;
         class rep trt;
         model final=rep trt initial/solution;
         lsmeans trt / stderr tdiff;
         means trt;
         estimate 'trt 1 adj mean' intercept 1 trt 1 0 0 0 0 initial 25.76;
         estimate 'trt 2 adj mean' intercept 1 trt 0 1 0 0 0 initial 25.76;
         estimate 'trt 1 unadj mean' intercept 1 trt 1 0 0 0 0 initial 29.75;
         estimate 'trt 2 unadj mean' intercept 1 trt 0 1 0 0 0 initial 27.175;
         estimate 'unadj diff' trt 1 -1 0 0 0 initial 2.575;
         lsmeans trt / bylevel stderr tdiff;
         contrast 'CONTROL VS. TREATMENT' -1 -1 -1 -1 4;
         contrast 'BOTTOM VS. TOP' -1 1 -1 1 0;
         contrast 'INTAKE VS. DISCHARGE' -1 -1 1 1 0;
         contrast 'BOT/TOP*INT/DIS' 1 -1 -1 1 0;
         contrast 'CTL V UNADJUSTED' TRT -1 -1 -1 -1 4 INITIAL -24.85;
        run;

        proc glm;
         class rep trt;
         model final=trt initial trt*initial;
        run;

data plot;
trt=1;
do initial=18,25.76,29.75,34;
 f_hat=3.077+1.0554*initial;
 output;
end;
trt=2;
do initial=18,25.76,27.175,34;
 f_hat=2.967+1.0554*initial;
 output;
end;
trt=3;
do initial=18,24.65,25.76,34;
 f_hat=4.834+1.0554*initial;
 output;
end;
trt=4;
do initial=18,25.76,26.425,34;
 f_hat=4.336+1.0554*initial;
 output;
end;
trt=5;
do initial=18,20.80,25.76,34;
 f_hat=3.073+1.0554*initial;
 output;
end;
axis1 value=(font=swiss2 h=2) label=(f=swiss h=2 'Final');
axis2 value=(font=swiss h=2 )label=(f=swiss h=2 'Initial');
legend1 value=(font=swiss h=2  ) label=(f=swiss h=2 'Treatment');
symbol1 color=black interpol=join
         line=1  value='1' font=swiss h=2;
symbol2 color=black interpol=join
       line=2 value='2' font=swiss h=2;
symbol3 color=black interpol=join
        line=20 value='3' font=swiss h=2;
symbol4 color=black interpol=join
       line=6 value='4' font=swiss h=2;
symbol5 color=black interpol=join
        line=9 value='5' font=swiss h=2;

proc gplot;
 plot f_hat*initial=trt/caxis=black ctext=black vaxis=axis1 haxis=axis2 legend=legend1 
     href=(20.8,24.65,25.76,26.425,27.175,29.75) vref=(25.025,30.85,31.65,32.225,34.475) ch=gray cv=gray
         vaxis=16 to 34 by 2;
run;



  /* run the following DATA steps to obtain Outputs 7.7 though 7.16    */

        

   data oranges;
      input  store week day p1 p2 q1 q2;
      cards;
   1      1      1    37   61    11.3208    0.0047
   1      1      2    37   37    12.9151    0.0037
   1      1      3    45   53    18.8947    7.5429
   1      1      4    41   41    14.6739    7.0652
   1      1      5    57   41     8.6493   21.2085
   1      1      6    49   33     9.5238   16.6667
   2      1      1    49   49     7.6923    7.1154
   2      1      2    53   53     0.0017    1.0000
   2      1      3    53   45     8.0477   24.2176
   2      1      4    53   53     6.7358    2.9361
   2      1      5    61   37     6.1441   40.5720
   2      1      6    49   65    21.7939    2.8324
   3      1      1    53   45     4.2553    6.0284
   3      1      2    57   57     0.0017    2.0906
   3      1      3    49   49    11.0196   13.9329
   3      1      4    53   53     6.2762    6.5551
   3      1      5    53   45    13.2316   10.6870
   3      1      6    53   53     5.0676    5.1351
   4      1      1    57   57     5.6235    3.9120
   4      1      2    49   49    14.9893    7.2805
   4      1      3    53   53    13.7233   16.3105
   4      1      4    53   45     6.0669   23.8494
   4      1      5    53   53     8.1602    4.1543
   4      1      6    61   37     1.4423   21.1538
   5      1      1    45   45     6.9971    6.9971
   5      1      2    53   45     5.2308    3.6923
   5      1      3    57   57     8.2560   10.6679
   5      1      4    49   49    14.5000   16.7500
   5      1      5    53   53    20.7627   15.2542
   5      1      6    53   45     3.6115   21.5442
   6      1      1    53   53    11.3475    4.9645
   6      1      2    53   45     9.4650   11.7284
   6      1      3    53   53    22.6103   14.8897
   6      1      4    61   37     0.0020   19.2000
   6      1      5    49   65    20.5997    2.3468
   6      1      6    37   37    28.1828   17.9543
   ;

   proc print;
   run;

   proc glm;
    class day;
         model q1=p1 day p1*day/solution;
         lsmeans day;
         lsmeans day / at means;
         lsmeans day / at p1=0;
         estimate 'P1:DAY 1' p1 1 p1*day 1 0 0 0 0 0;
         estimate 'P1:DAY 2' p1 1 p1*day 0 1 0 0 0 0;
         estimate 'P1:DAY 3' p1 1 p1*day 0 0 1 0 0 0;
         estimate 'P1:DAY 4' p1 1 p1*day 0 0 0 1 0 0;
         estimate 'P1:DAY 5' p1 1 p1*day 0 0 0 0 1 0;
         estimate 'P1:DAY 6' p1 1 p1*day 0 0 0 0 0 1;
         contrast 'trt' day 1 -1 0 0 0 0,
                        day 1 0 -1 0 0 0,
                        day 1 0 0 -1 0 0,
                        day 1 0 0 0 -1 0,
                        day 1 0 0 0 0 -1;
        contrast 'trt' day 1 -1 0 0 0 0
           p1*day 51.2222 -51.2222 0 0 0 0,
           day 1 0 -1 0 0 0 p1*day 51.2222 0 -51.2222 0 0 0,
           day 1 0 0 -1 0 0 p1*day 51.2222 0 0 -51.2222 0 0,
           day 1 0 0 0 -1 0 p1*day 51.2222 0 0 0 -51.2222 0,
           day 1 0 0 0 0 -1 p1*day 51.2222 0 0 0 0 -51.2222;
   run;

   proc glm;
    class day;
         model q1=day p1(day)/solution;
         contrast 'equal slopes' p1(day) 1 0 0 0 0 -1,
                                 p1(day) 0 1 0 0 0 -1,
                                 p1(day) 0 0 1 0 0 -1,
                                 p1(day) 0 0 0 1 0 -1,
                                 p1(day) 0 0 0 0 1 -1;

proc glm;
 class store day;
 model q1 q2=store day p1 p2;
 lsmeans day/stderr;
run;

/* run the following DATA steps to obtain  Outputs 7.17 through 7.20   */

data cotton;
      input variety spacing plant bollwt lint;
      cards;
    37     30      3      8.4     2.9
    37     30      3      8.0     2.5
    37     30      3      7.4     2.7
    37     30      3      8.9     3.1
    37     30      5      5.6     2.1
    37     30      5      8.0     2.7
    37     30      5      7.6     2.5
    37     30      5      5.4     1.5
    37     30      5      6.9     2.5
    37     40      3      4.5     1.3
    37     40      3      9.1     3.1
    37     40      3      9.0     3.1
    37     40      3      8.0     2.3
    37     40      3      7.2     2.2
    37     40      3      7.6     2.5
    37     40      3      9.0     3.0
    37     40      3      2.3     0.6
    37     40      3      8.7     3.0
    37     40      5      8.0     2.6
    37     40      5      7.2     2.5
    37     40      5      7.6     2.4
    37     40      5      6.9     2.2
    37     40      5      6.9     2.5
    37     40      5      7.6     2.4
    37     40      5      4.7     1.4
   213     30      3      4.6     1.7
   213     30      3      6.8     1.7
   213     30      3      3.5     1.3
   213     30      3      2.4     1.0
   213     30      3      3.0     1.0
   213     30      5      2.8     0.5
   213     30      5      3.6     0.9
   213     30      5      6.7     1.9
   213     40      0      7.4     2.1
   213     40      0      4.9     1.0
   213     40      0      5.7     1.0
   213     40      0      3.0     0.7
   213     40      0      4.7     1.5
   213     40      0      5.0     1.3
   213     40      0      2.8     0.4
   213     40      0      5.2     1.2
   213     40      0      5.6     1.0
   213     40      3      4.5     1.0
   213     40      3      5.6     1.2
   213     40      3      2.0     0.7
   213     40      3      1.2     0.2
   213     40      3      4.2     1.2
   213     40      3      5.3     1.2
   213     40      3      7.0     1.7
   ;

proc print;
run;

proc glm;
 class variety spacing plant;
 model lint=bollwt variety spacing variety*spacing plant(variety*spacing) /  solution;
 random plant(variety*spacing)/test;
 *test h=variety spacing variety*spacing   e=plant(variety*spacing);
run;

proc mixed method=type3;
 class variety spacing plant;
 model lint=bollwt variety spacing variety*spacing/  solution;
 random plant(variety*spacing);
run;
proc glm;
 class variety spacing plant;
 model lint=bollwt variety spacing /  solution;
 lsmeans variety spacing;
run;

/* use the following DATA step to obtain Outputs 7.21 through 7.24    */


data type_dose;
 input bloc type dose y;
 logdose=log10(dose);
 logd2=logdose*logdose;
datalines;
1 1 1 63
1 2 1 59
1 1 10 62
1 2 10 62
1 1 100 62
1 2 100 68
2 1 1 50
2 2 1 49
2 1 10 49
2 2 10 55
2 1 100 48
2 2 100 58
3 1 1 53
3 2 1 47
3 1 10 52
3 2 10 51
3 1 100 51
3 2 100 50
4 1 1 52
4 2 1 48
4 1 10 54
4 2 10 49
4 1 100 55
4 2 100 72

;

proc print;
 var bloc type dose logdose  y;
run;

proc glm data=type_dose;
 class bloc type logdose;
 model y=bloc type|logdose;
 lsmeans type*logdose;
 contrast 'linear logdose' logdose -1 0 1;
 contrast 'quadratic logdose' logdose -1 2 -1;
 contrast 'linear logodse x type' type*logodse 1 0 -1 -1 0 1;
 contrast 'quad logodse x type' type*logodse 1 -2 1 -1 2 -1;
run;

proc glm data=type_dose;
 class bloc type logdose;
 model y=bloc type logdose(type);
 contrast 'lin in type 1' dose(type)  1  0 -1   0  0  0;
 contrast 'lin in type 2' dose(type)  0  0  0   1  0 -1;
 contrast 'quad in type 1' dose(type) 1 -2  1   0  0  0;
 contrast 'quad in type 2' dose(type) 0  0  0   1 -2  1;
run;

proc glm data=type_dose;
 class bloc type;
 model y=bloc type logdose logd2 type*logdose type*logd2;
run;

proc glm data=type_dose;
 class bloc type;
 model y=bloc type logdose(type)/solution;
 estimate 'beta-0, type 1' intercept 4 bloc 1 1 1 1 type 4 0/divisor=4;
 estimate 'beta-0, type 2' intercept 4 bloc 1 1 1 1 type 0 4/divisor=4;
run;

proc mixed data=type_dose;
 class bloc type;
 model y=type dose(type)/noint solution;
 random bloc;
run;


/* use the following SAS statements to obtain Output 7.25    */

proc iml;
 levels={1,10,100};
 coef=orpol(levels);
 print coef;
 log_lev=log10(levels);
 coef=orpol(log_lev);
 print log_lev;
 print coef;
 fuzzed_coef=fuzz(coef);
 print fuzzed_coef;
run;


/* use the following DATA step to obtain Outputs 8.1 and Outputs 8.7 through 8.11   */

data fev1mult;
input PATIENT  BASEFEV1  FEV11H  FEV12H  FEV13H  FEV14H  FEV15H  FEV16H  FEV17H  FEV18H  DRUG $;
cards;
     201      2.46     2.68    2.76    2.50    2.30    2.14    2.40    2.33    2.20    a
     202      3.50     3.95    3.65    2.93    2.53    3.04    3.37    3.14    2.62    a
     203      1.96     2.28    2.34    2.29    2.43    2.06    2.18    2.28    2.29    a
     204      3.44     4.08    3.87    3.79    3.30    3.80    3.24    2.98    2.91    a
     205      2.80     4.09    3.90    3.54    3.35    3.15    3.23    3.46    3.27    a
     206      2.36     3.79    3.97    3.78    3.69    3.31    2.83    2.72    3.00    a
     207      1.77     3.82    3.44    3.46    3.02    2.98    3.10    2.79    2.88    a
     208      2.64     3.67    3.47    3.19    2.19    2.85    2.68    2.60    2.73    a
     209      2.30     4.12    3.71    3.57    3.49    3.64    3.38    2.28    3.72    a
     210      2.27     2.77    2.77    2.75    2.75    2.71    2.75    2.52    2.60    a
     211      2.44     3.77    3.73    3.67    3.56    3.59    3.35    3.32    3.18    a
     212      2.04     2.00    1.91    1.88    2.09    2.08    1.98    1.70    1.40    a
     214      2.77     3.36    3.42    3.28    3.30    3.31    2.99    3.01    3.08    a
     215      2.96     4.31    4.02    3.38    3.31    3.46    3.49    3.38    3.35    a
     216      3.11     3.88    3.92    3.71    3.59    3.57    3.48    3.42    3.63    a
     217      1.47     1.97    1.90    1.45    1.45    1.24    1.24    1.17    1.27    a
     218      2.73     2.91    2.99    2.87    2.88    2.84    2.67    2.69    2.77    a
     219      3.25     3.59    3.54    3.17    2.92    3.48    3.05    3.27    2.96    a
     220      2.73     2.88    3.06    2.75    2.71    2.83    2.58    2.68    2.42    a
     221      3.30     4.04    3.94    3.84    3.99    3.90    3.89    3.89    2.98    a
     222      2.85     3.38    3.42    3.28    2.94    2.96    3.12    2.98    2.99    a
     223      2.72     4.49    4.35    4.38    4.36    3.77    4.23    3.83    3.89    a
     224      3.68     4.17    4.30    4.16    4.07    3.87    3.87    3.85    3.82    a
     232      2.49     3.73    3.51    3.16    3.26    3.07    2.77    2.92    3.00    a
     201      2.30     3.41    3.48    3.41    3.49    3.33    3.20    3.07    3.15    c
     202      2.91     3.92    4.02    4.04    3.64    3.29    3.10    2.70    2.69    c
     203      2.08     2.52    2.44    2.27    2.23    2.01    2.26    2.34    2.44    c
     204      3.02     4.43    4.30    4.08    4.01    3.62    3.23    2.46    2.97    c
     205      3.26     4.55    4.58    4.44    4.04    4.33    3.87    3.75    3.81    c
     206      2.29     4.25    4.37    4.10    4.20    3.84    3.43    3.79    3.74    c
     207      1.96     3.00    2.80    2.59    2.42    1.61    1.83    1.21    1.50    c
     208      2.70     4.06    3.98    4.06    3.93    3.61    2.91    2.07    2.67    c
     209      2.50     4.37    4.06    3.68    3.64    3.17    3.37    3.20    3.25    c
     210      2.35     2.83    2.79    2.82    2.79    2.80    2.76    2.64    2.69    c
     211      2.34     4.06    3.68    3.59    3.27    2.60    2.72    2.22    2.68    c
     212      2.20     2.82    1.90    2.57    2.30    1.67    1.90    2.07    1.76    c
     214      2.78     3.18    3.13    3.11    2.97    3.06    3.27    3.24    3.33    c
     215      3.43     4.39    4.63    4.19    4.00    4.01    3.66    3.47    3.22    c
     216      3.07     3.90    3.98    4.09    4.03    4.07    3.56    3.83    3.75    c
     217      1.21     2.31    2.19    2.21    2.09    1.75    1.72    1.80    1.36    c
     218      2.60     3.19    3.18    3.15    3.14    3.08    2.96    2.97    2.85    c
     219      2.61     3.54    3.45    3.25    3.01    3.07    2.65    2.47    2.55    c
     220      2.48     2.99    3.02    3.02    2.94    2.69    2.66    2.68    2.70    c
     221      3.73     4.37    4.20    4.17    4.19    4.07    3.86    3.89    3.89    c
     222      2.54     3.26    3.39    3.27    3.20    3.32    3.09    3.25    3.15    c
     223      2.83     4.72    4.97    4.99    4.96    4.95    4.82    4.56    4.49    c
     224      3.47     4.27    4.50    4.34    4.00    4.11    3.93    3.68    3.77    c
     232      2.79     4.10    3.85    4.27    4.01    3.78    3.14    3.94    3.69    c
     201      2.14     2.36    2.36    2.28    2.35    2.31    2.62    2.12    2.42    p
     202      3.37     3.03    3.02    3.19    2.98    3.01    2.75    2.70    2.84    p
     203      1.88     1.99    1.62    1.65    1.68    1.65    1.85    1.96    1.30    p
     204      3.10     3.24    3.37    3.54    3.31    2.81    3.58    3.76    3.05    p
     205      2.91     3.35    3.92    3.69    3.97    3.94    3.63    2.92    3.31    p
     206      2.29     3.04    3.28    3.17    2.99    3.31    3.21    2.98    2.82    p
     207      2.20     2.46    3.22    2.65    3.02    2.25    1.50    2.37    1.94    p
     208      2.70     2.85    2.81    2.96    2.69    2.18    1.91    2.21    1.71    p
     209      2.25     3.45    3.48    3.80    3.60    2.83    3.17    3.22    3.13    p
     210      2.48     2.56    2.52    2.67    2.60    2.68    2.64    2.65    2.61    p
     211      2.12     2.19    2.44    2.41    2.55    2.93    3.08    3.11    3.06    p
     212      2.37     2.14    1.92    1.75    1.58    1.51    1.94    1.84    1.76    p
     214      2.73     2.57    3.08    2.62    2.91    2.71    2.39    2.42    2.73    p
     215      3.15     2.90    2.80    3.17    2.39    3.01    3.22    2.75    3.14    p
     216      2.52     3.02    3.21    3.17    3.13    3.38    3.25    3.29    3.35    p
     217      1.48     1.35    1.15    1.24    1.32    0.95    1.24    1.04    1.16    p
     218      2.52     2.61    2.59    2.77    2.73    2.70    2.72    2.71    2.75    p
     219      2.90     2.91    2.89    3.01    2.74    2.71    2.86    2.95    2.66    p
     220      2.83     2.78    2.89    2.77    2.77    2.69    2.65    2.84    2.80    p
     221      3.50     3.81    3.77    3.78    3.90    3.80    3.78    3.70    3.61    p
     222      2.86     3.06    2.95    3.07    3.10    2.67    2.68    2.94    2.89    p
     223      2.42     2.87    3.08    3.02    3.14    3.67    3.84    3.55    3.75    p
     224      3.66     3.98    3.77    3.65    3.81    3.77    3.89    3.63    3.74    p
     232      2.88     3.04    3.00    3.24    3.37    2.69    2.89    2.89    2.76    p
;
run;
title2 'Multivariate Arrangement';
proc print;
run;

proc glm data=fev1mult;
 class drug;
 model fev11h fev12h fev13h fev14h fev15h fev15h fev17h fev18h=drug;
 contrast 'a-c' drug 1 -1 0;
 repeated hour/printe summary;
 run;

/* run the follwoing DATA step to obtain Outputs 8.2 through 8.6                  */
 /* note that you must run these statements in conjunction with the statements    */
 /*   used to create Output 8.1 (i.e. to create DATA=FEV1MULT                     */

data fev1uni; set fev1mult;
  drop fev11h fev12h fev13h fev14h fev15h fev16h fev17h fev18h;
  hour=1; fev1=fev11h; output;
  hour=2; fev1=fev12h; output;
  hour=3; fev1=fev13h; output;
  hour=4; fev1=fev14h; output;
  hour=5; fev1=fev15h; output;
  hour=6; fev1=fev16h; output;
  hour=7; fev1=fev17h; output;
  hour=8; fev1=fev18h; output;
run;
title2 'Univariate Arrangement';
proc print data=fev1uni;
run;

proc glm data=fev1uni;
 class drug patient hour;
 model fev1=drug patient(drug) hour drug*hour / ss3;
 random patient(drug)/test;
 lsmeans drug / pdiff stderr e=patient(drug);
 contrast 'a=c overall' drug 1 -1 0;
 contrast 'a=c overall' drug 1 -1 0/e=patient(drug);
 contrast 'a-c at hour 1' drug 1 -1 0
     drug*hour 1 0 0 0 0 0 0 0  -1 0 0 0 0 0 0 0 0;
contrast 'a-c*hour' drug*hour 1 0 0 0 0 0 0 -1
                             -1 0 0 0 0 0 0 1,
                                        drug*hour 0 1 0 0 0 0 0 -1
                                                 0 -1 0 0 0 0 0 1,
                                        drug*hour 0 0 1 0 0 0 0 -1
                                                 0 0 -1 0 0 0 0 1,
                                        drug*hour 0 0 0 1 0 0 0 -1
                                                 0 0 0 -1 0 0 0 1,
                                        drug*hour 0 0 0 0 1 0 0 -1
                                                 0 0 0 0 -1 0 0 1,
                                        drug*hour 0 0 0 0 0 1 0 -1
                                                 0 0 0 0 0 -1 0 1,
                                        drug*hour 0 0 0 0 0 0 1 -1
                                                 0 0 0 0 0 0 -1 1;
run;

/* use the following SAS statements in conjunction with the FEV1UNI data set created above    */
/* to obtain Ouptut 8.12 and Figures 8.1 through 8.5                                          */

proc mixed data=fev1uni;
 class drug hour patient;
 model fev1=drug|hour;
* model fev1=drug|hour basefev1;
 repeated / type=un sscp subject=patient(drug) rcorr;
lsmeans drug*hour
lsmeans drug*hour;
ods output covparms=cov;
ods output rcorr=corr;
ods output lsmeans=lsm;
run;

/* create data set for covariance plots & adjusted covariance & correlation plots (figues 8.2 through 8.5) */

data times;
 do time1=1 to 8;
  do time2=1 to time1;
   dist=time1-time2;
   output;
  end;
 end;

data covplot;
 merge times cov;
 adjcov=estimate-0.3652;
 adjcorr=adjcov/0.3652;
proc print;
run;

title ' ';
axis1 value=(font=swiss2 h=2) label=(angle=90 f=swiss h=2 'Correlation adj for Between Subj Var');
*axis1 value=(font=swiss2 h=2) label=(angle=90 f=swiss h=2 'Covariance of Within Subject Effects');
axis2 value=(font=swiss h=2 )label=(f=swiss h=2 'Distance');
legend1 value=(font=swiss h=2  ) label=(f=swiss h=2 'From Time');
symbol1 color=black interpol=join
         line=1 value=square; 
symbol2 color=black interpol=join
       line=2 value=circle; 
symbol3 color=black interpol=join
        line=20 value=triangle;
symbol4 color=black interpol=join
         line=3 value=plus; 
symbol5 color=black interpol=join
       line=4 value=star; 
symbol6 color=black interpol=join
        line=5 value=dot; 
symbol7 color=black interpol=join
       line=6 value=_; 
symbol8 color=black interpol=join
        line=10 value==;
                
/* plot figure 8.1                                             */
/* note this statement can also be used to create figure 8.6   */
/*  you must create new LSM data set with ODS statement        */
/*    using LS means with AR(1) covariance structure           */

proc gplot data=lsm;
 plot estimate*hour=drug/haxis=axis1 vaxis=axis2 legend=legend1 vref=0;
run;

/* plot figures 8.2 through 8.5  */
proc gplot data=covplot;
 *plot estimate*dist=time2/vaxis=axis1 haxis=axis2 legend=legend1; ** vref=0;
 plot adjcorr*dist=time2/vaxis=axis1 haxis=axis2 legend=legend1 vref=0;
 run;


/* run the following SAS statements to obtain Outputs 8.13 and 8.14  */ 
/* note that you must select the appropriate REPEATED statement      */
/*   consistent with the desired covariance structure                */

proc mixed data=fev1uni;
 class drug hour patient;
 model fev1=drug|hour basefev1/ddfm=kr;
 random patient(drug);  /* use this statement ONLY with AR(1) structure  */
 repeated / type=ar(1) subject=patient(drug);
 *repeated / type=toep subject=patient(drug);
 *repeated / type=cs subject=patient(drug);
run;

/* use the follwoing SAS statements to obtain Outputs 8.15 though 8.18      */
/*  also, ODS statement creates LSM data set to used to creat Figure 8.6    */
/*         with above PROC GPLOT statement                                  */

proc mixed data=fev1uni;
 class drug hour patient;
 model fev1=drug|hour basefev1/ddfm=kr;
 random patient(drug);
 repeated / type=ar(1) subject=patient(drug);
 lsmeans drug*hour/slice=hour diff;
 contrast 'hr=1 vs hr=8 x a vs c' drug*hour 1 0 0 0 0 0 0 -1
             -1 0 0 0 0 0 0 1 0;
 contrast 'hr=1 vs hr=8 x p v trt' drug*hour 1 0 0 0 0 0 0 -1
             1 0 0 0 0 0 0 -1   -2 0 0 0 0 0 0 2;
 ods listing exclude lsmeans;
 ods listing exclude diffs;
 ods output LSMeans=lsm diffs=dhdiff;
run;

data smpleff;
 set dhdiff;
 if drug=_drug or hour=_hour;

proc print data=smpleff;
run;

/* Use the following SAS statements in conjuctions with the FEV1UNI data set  */
/*   to obtain Outputs 8.19 through 8.21                                      */


data fev1regr;
 set fev1uni;
  h=hour;
  h2=h*h;

/* program to daignose order of polynomial regression
    and lack of fit    */

proc mixed noprofile;
 class drug hour patient;
 model fev1=basefev1 drug h h2 hour drug*h drug*h2 drug*hour/htype=1;
 random patient(drug);
 repeated / type=ar(1) subject=patient(drug);
 parms (0.1848)(0.08309)  (0.5401) / noiter;
run;

/* program to obtain estimates of regression equation
    and test equality of regressions for drugs a and c */

proc mixed data=fev1regr;
 class drug patient;
 model fev1=basefev1 drug h(drug) /noint solution ddfm=kr htype=1;
 random patient(drug);
 repeated / type=ar(1) subject=patient(drug);
 contrast 'drug a vs c intercept' drug 1 -1 0;
 contrast 'drug a vs c slope' h(drug) 1 -1 0;
run; 



/* Chapter 9 */

/* Use the following DATA steps to produce Outputs 9.1 through 9.3. */

data teachers;
  input teach $ score1 score2;
datalines;
        JAY             69  75
        JAY             69  70
        JAY     71  73
        JAY     78  82
        JAY     79  81
        JAY     73  75
        PAT     69  70
        PAT     68  74
        PAT     75  80
        PAT     78  85
        PAT     68  68
        PAT     63  68
        PAT     72  74
        PAT     63  66
        PAT     71  76
        PAT     72  78
        PAT     71  73
        PAT     70  73
        PAT     56  59
        PAT     77  79
        ROBIN   64  65
        ROBIN   74  74
        ROBIN   72  75
        ROBIN   82  84
        ROBIN   69  68
        ROBIN   76  76
        ROBIN   68  65
        ROBIN   78  79
        ROBIN   70  71
        ROBIN   60  61
;
proc print data=teachers;
run;
proc glm data=teachers;
  class teach;
  model score1 score2=teach;
  manova h=teach / printh printe;
run;

/* Use the following DATA steps to produce Outputs 9.4 through 9.5. */

data rats;
input gain1 gain2 gain3 gain4;
datalines;
      29       28       25       33
      33       30       23       31
      25       34       33       41
      18       33       29       35
      25       23       17       30
      24       32       29       22
      20       23       16       31
      28       21       18       24
      18       23       22       28
      25       28       29       30
;
proc print data=rats;
run;

proc glm data=rats;
  model gain1-gain4 = /nouni;
  manova h=intercept
  m=gain2-gain1, gain3-gain1, gain4-gain1
  mnames=diff2 diff3 diff4 / summary;
run;

/* Use the following DATA steps to produce Outputs 9.6 through 9.9. */

data cotton;
input variety spacing plant seed lint bract;
datalines;
      213         30        3       3.1     1.7     2.0
      213         30        3       1.5     1.7     1.4
      213         30        5       3.0     1.9     1.8
      213         30        5       1.4     0.9     1.3
      213         30        6       2.3     1.7     1.5
      213         30        6       2.2     2.0     1.4
      213         30        8       0.4     0.9     1.2
      213         30        8       1.7     1.6     1.3
      213         30        9       1.8     1.2     1.0
      213         30        9       1.2     0.8     1.0
      213         40        0       2.0     1.0     1.9
      213         40        0       1.5     1.5     1.7
      213         40        1       1.8     1.1     2.1
      213         40        1       1.0     1.3     1.1
      213         40        2       1.3     1.1     1.3
      213         40        2       2.9     1.9     1.7
      213         40        3       2.8     1.2     1.3
      213         40        3       1.8     1.2     1.2
      213         40        4       3.2     1.8     2.0
      213         40        4       3.2     1.6     1.9
       37         30        1       3.2     2.6     1.4
       37         30        1       2.8     2.1     1.2
       37         30        2       3.6     2.4     1.5
       37         30        2       0.9     0.8     0.8
       37         30        3       4.0     3.1     1.8
       37         30        3       4.0     2.9     1.5
       37         30        5       3.7     2.7     1.6
       37         30        5       2.6     1.5     1.3
       37         30        8       2.8     2.2     1.2
       37         30        8       2.9     2.3     1.2
       37         40        1       4.1     2.9     2.0
       37         40        1       3.4     2.0     1.6
       37         40        3       3.7     2.3     2.0
       37         40        3       3.2     2.2     1.8
       37         40        4       3.4     2.7     1.5
       37         40        4       2.9     2.1     1.2
       37         40        5       2.5     1.4     0.8
       37         40        5       3.6     2.4     1.6
       37         40        6       3.1     2.3     1.4
       37         40        6       2.5     1.5     1.5
;
proc print data=cotton;
run;
proc glm data=cotton;
  class variety spacing plant;
  model seed lint bract = variety spacing variety*spacing
                          plant(variety spacing)/ss3;
  test h=variety|spacing e=plant(variety spacing);
  means variety|spacing;
  manova h=variety|spacing e=plant(variety spacing);
run;

/* Use the following DATA steps to produce Outputs 9.10 and 9.11. */

data oranges;
  input STORE DAY P1 P2 Q1 Q2;
datalines;
      1       1     37    61    11.3208     0.0047
      1       2     37    37    12.9151     0.0037
      1       3     45    53    18.8947     7.5429
      1       4     41    41    14.6739     7.0652
      1       5     57    41     8.6493    21.2085
      1       6     49    33     9.5238    16.6667
      2       1     49    49     7.6923     7.1154
      2       2     53    53     0.0017     1.0000
      2       3     53    45     8.0477    24.2176
      2       4     53    53     6.7358     2.9361
      2       5     61    37     6.1441    40.5720
      2       6     49    65    21.7939     2.8324
      3       1     53    45     4.2553     6.0284
      3       2     57    57     0.0017     2.0906
      3       3     49    49    11.0196    13.9329
      3       4     53    53     6.2762     6.5551
      3       5     53    45    13.2316    10.6870
      3       6     53    53     5.0676     5.1351
      4       1     57    57     5.6235     3.9120
      4       2     49    49    14.9893     7.2805
      4       3     53    53    13.7233    16.3105
      4       4     53    45     6.0669    23.8494
      4       5     53    53     8.1602     4.1543
      4       6     61    37     1.4423    21.1538
      5       1     45    45     6.9971     6.9971
      5       2     53    45     5.2308     3.6923
      5       3     57    57     8.2560    10.6679
      5       4     49    49    14.5000    16.7500
      5       5     53    53    20.7627    15.2542
      5       6     53    45     3.6115    21.5442
      6       1     53    53    11.3475     4.9645
      6       2     53    45     9.4650    11.7284
      6       3     53    53    22.6103    14.8897
      6       4     61    37     0.0020    19.2000
      6       5     49    65    20.5997     2.3468
      6       6     37    37    28.1828    17.9543
;

proc glm data=oranges;
  class store day;
  model q1 q2=store day p1 p2 / nouni;
  manova h=store day p1 p2 / printh printe;
run;

/* Chapter 10  */

/* Use the following DATA step to obtain Outputs 10.1 through 10.4   */

data Challenger;
 input temp td no_td;
 total=td+no_td;
datalines;
53 1 0
57 1 0
58 1 0
63 1 0
66 0 1
67 0 3
68 0 1
69 0 1
70 2 2
72 0 1
73 0 1
75 1 1
76 0 2
78 0 1
79 0 1
81 0 1
;

proc genmod data=Challenger;
 model td/total=temp/dist=binomial link=logit type1;
 estimate 'logit at 50 deg' intercept 1 temp 50;
 estimate 'logit at 60 deg' intercept 1 temp 60;
 estimate 'logit at 64.7 deg' intercept 1 temp 64.7;
 estimate 'logit at 64.8 deg' intercept 1 temp 64.8;
 estimate 'logit at 70 deg' intercept 1 temp 70;
 estimate 'logit at 80 deg' intercept 1 temp 80;
 ods output estimates=logit;
run;

/* following creates Output 10.4  */
data prob_hat;
 set logit;
  phat=exp(estimate)/(1+exp(estimate));
  se_phat=phat*(1-phat)*stderr;
  prb_LcL=exp(LowerCL)/(1+exp(LowerCL));
  prb_UcL=exp(UpperCL)/(1+exp(UpperCL));

proc print data=prob_hat;
run;

/* Use the following DATA step to obtain Outputs 10.5 and 10.6                 */

data O_Ring;
 input flt temp td;
datalines;
 1 66 0
 2 70 1
 3 69 0
 4 68 0
 5 67 0
 6 72 0
 7 73 0
 8 70 0
 9 57 1
10 63 1
11 70 1
12 78 0
13 67 0
14 53 1
15 67 0
16 75 0
17 70 0
18 81 0
19 76 0
20 79 0
21 75 1
22 76 0
23 58 1
;

proc freq;
 tables temp*td;
run;

proc genmod data=O_Ring;
 model td=temp  /dist=binomial link=logit type1;
 estimate 'logit at 50 deg' intercept 1 temp 50;
 estimate 'logit at 60 deg' intercept 1 temp 60;
 estimate 'logit at 64.7 deg' intercept 1 temp 64.7;
 estimate 'logit at 64.8 deg' intercept 1 temp 64.8;
 estimate 'logit at 70 deg' intercept 1 temp 70;
 estimate 'logit at 80 deg' intercept 1 temp 80;
 ods output estimates=logit;
run;

/* following not shown in text, but similar to Output 10.4   */
data prob_hat;
 set logit;
  phat=exp(estimate)/(1+exp(estimate));
  se_phat=phat*(1-phat)*stderr;
  prb_LcL=exp(LowerCL)/(1+exp(LowerCL));
  prb_UcL=exp(UpperCL)/(1+exp(UpperCL));
proc print data=prob_hat;
run;

/* Use the following SAS statements in conjuction with the DATA step used      */
/*    to create data set DATA=Challlenger (Output 10.1)                        */
/*    to obtain Outputs 10.7 and 10.8                                          */ 

proc genmod data=Challenger;
 model td/total=temp/dist=binomial link=probit type1;
 estimate 'logit at 50 deg' intercept 1 temp 50;
 estimate 'logit at 60 deg' intercept 1 temp 60;
 estimate 'logit at 64.7 deg' intercept 1 temp 64.7;
 estimate 'logit at 64.8 deg' intercept 1 temp 64.8;
 estimate 'logit at 70 deg' intercept 1 temp 70;
 estimate 'logit at 80 deg' intercept 1 temp 80;
 ods output estimates=logit;
run;

/* following creates Output 10.8  */
data prob_hat;
 set logit;
  phat=probnorm(estimate);
  pi=3.14159;
  invsqrt=1/(sqrt(2*pi));
  se_phat=invsqrt*exp(-0.5*(estimate**2))*stderr;
  prb_LcL=probnorm(LowerCL);
  prb_UcL=probnorm(UpperCL);
proc print data=prob_hat;
run;

/* Use the following DATA step to obtain Outputs 10.9 through 10.14       */

data a;
 input clinic trt $ fav unfav;
 nij=fav+unfav;
cards;
1 drug 11 25
1 cntl 10 27
2 drug 16 4
2 cntl 22 10
3 drug 14 5
3 cntl 7 12
4 drug 2 14
4 cntl 1 16
5 drug 6 11
5 cntl 0 12
6 drug 1 10
6 cntl 0 10
7 drug 1 4
7 cntl 1 8
8 drug 4 2
8 cntl 6 1
run;

proc print;
run;

proc genmod data=a;
 class clinic trt;
 model fav/nij=clinic trt/dist=binomial link=logit type3;
 lsmeans trt;
 estimate 'lsm - cntl' intercept 1 trt 1 0;
 estimate 'lsm - drug' intercept 1 trt 0 1;
 estimate 'diff' trt 1 -1;
 contrast 'diff' trt 1 -1;
 ods output lsmeans=lsm;
run;

/* following creates Output 10.14  */
data prob_hat;
 set lsm;
  phat=exp(estimate)/(1+exp(estimate));
  se_phat=phat*(1-phat)*stderr;

proc print data=prob_hat;
run;

/* Use the following SAS statements in conjuction with data set DATA=A  */
/*  (shown in Output 10.9) to obtain Outputs 10.15 and 10.16           */

proc genmod data=a;
 class clinic trt;
 model fav/nij=clinic trt/dist=binomial link=probit type3;
 lsmeans trt;
 estimate 'lsm - cntl' intercept 1 trt 1 0;
 estimate 'lsm - drug' intercept 1 trt 0 1;
 estimate 'diff' trt 1 -1;
 contrast 'diff' trt 1 -1;
 ods output lsmeans=lsm;
run;

/* creates Output 10.16  */
data prob_hat;
 set lsm;
  phat=probnorm(estimate);
  pi=3.14159;
  invsqrt=1/sqrt(2*pi);
  se_phat=invsqrt*exp(-0.5*(estimate**2))*stderr;
proc print data=prob_hat;
run;

/* Use the following DATA step to obtain Outputs 10.17 through 10.23  */

data fr_t7_3;
 input drug $ dosage alive dead;
 total=alive+dead;
 x=log2(dosage);
datalines;
std  1 19  1
std  2 15  5
std  4 11  9
std  8  4 16
std 16  1 19
trt  1 16  4
trt  2 12  8
trt  4  5 15
trt  8  2 18
;

proc print;
run;

proc genmod;
 class drug;
 model alive/total=drug x drug*x /dist=bin link=logit type1 type3;
run;

proc genmod;
 class drug;
 model alive/total=drug x(drug)/dist=bin link=logit noint;
 contrast 'trt effect' drug 1 -1;
 contrast 'equal slope?' x(drug) 1 -1;
run;

proc genmod;
 class drug;
 model alive/total=drug x /dist=bin link=logit type1 type3;
 lsmeans / e;
 estimate 'STD at dose=1' intercept 1 drug 1 0 x 0;
 estimate 'STD at dose=16' intercept 1 drug 1 0 x 4;
 estimate 'diff' drug 1 -1;
run;

proc genmod;
 class drug;
 model alive/total=drug x /dist=bin link=logit noint;
 contrast 'drugg effect' drug 1 -1;
 estimate 'STD at dose=1' drug 1 0 x 0;
 estimate 'STD at dose=16' drug 1 0 x 4;
run;

/* Use the following DATA step to obtain Outputs 10.24 through 10.27  */

Data Counts;
  input block trt a b count;
  ctl_trt=(trt>0);
datalines;
1 1 1 1 6
1 2 1 2 2
1 5 2 2 3
1 8 3 2 3
1 7 3 1 1
1 0 0 0 16
1 3 1 3 4
1 6 2 3 1
1 9 3 3 1
1 4 2 1 5
2 1 1 1 9
2 2 1 2 6
2 5 2 2 4
2 8 3 2 2
2 7 3 1 2
2 0 0 0 25
2 3 1 3 3
2 6 2 3 5
2 9 3 3 0
2 4 2 1 3
3 1 1 1 2
3 2 1 2 14
3 5 2 2 6
3 8 3 2 3
3 7 3 1 2
3 0 0 0 5
3 3 1 3 5
3 6 2 3 17
3 9 3 3 2
3 4 2 1 3
4 1 1 1 22
4 2 1 2 4
4 5 2 2 3
4 8 3 2 4
4 7 3 1 3
4 0 0 0 9
4 3 1 3 5
4 6 2 3 1
4 9 3 3 9
4 4 2 1 2
;

proc sort; 
 by block trt;
proc print;
 var block trt ctl_trt a b count;
run;

proc genmod data=counts;
 class BLOCK CTL_TRT a b;
 model count=BLOCK CTL_TRT a b a*b/dist=negbin type1 type3 wald;
 title 'uncorrected Poisson model';
run;

proc genmod data=counts;
 class BLOCK CTL_TRT a b;
 model count=BLOCK CTL_TRT a b a*b/dist=poisson type1 ObStats;
 ODS OUTPUT ObStats=check;
 title 'compute model checking statistics';
run;

data plot;
 merge check;
 adjlamda=2*sqrt(pred);
 ystar=xbeta+(count-pred)/pred;
 absres=abs(resdev);

proc plot;
 plot resdev*(pred xbeta);
 plot (resdev reschi)*adjlamda;
 plot ystar*xbeta;
 plot absres*adjlamda;
run;

/* Use the following SAS statements in conjunction with     */
/* data set DATA=Counts (shown in Output 10.24)             */
/*    to obtain Output 10.28                                */

proc genmod data=Counts;
 class BLOCK CTL_TRT a b;
 model count=BLOCK CTL_TRT a b a*b/dist=poisson dscale type1 type3;
 title ' correction for overdispersion';
run;

/* Use the following SAS statements in conjunction with     */
/* data set DATA=Counts (shown in Output 10.24)             */
/*    to obtain Output 10.29                                */

proc genmod data=Counts;
 class block trt;
 model count=block trt/dist=poisson type1 type3 wald;
 contrast 'ctl vs trt' trt 9 -1 -1 -1 -1 -1 -1 -1 -1 -1/wald;
 contrast 'a' trt 0  1 1 1  0 0 0  -1 -1 -1,
              trt 0  0 0 0  1 1 1  -1 -1 -1/wald;
 contrast 'b' trt 0  1 0 -1  1 0 -1  1 0 -1,
              trt 0  0 1 -1  0 1 -1  0 1 -1/wald;
 contrast 'a x b' trt 0  1 0 -1  0 0  0  -1 0 1,
                  trt 0  0 0  0  1 0 -1  -1 0 1,
                                  trt 0  0 1 -1  0 0  0  0 -1 1,
                                  trt 0  0 0  0  0 1 -1  0 -1 1/wald;
 estimate 'ctl lsmean' intercept 1 trt 1 0/exp;
 estimate 'treated lsm'intercept 9 trt 0 1 1 1 1 1 1 1 1 1/divisor=9 exp;
 estimate 'A=1 lsmean' intercept 3 trt 0 1 1 1 0/divisor=3 exp;
 estimate 'A=2 lsmean' intercept 3 trt 0 0 0 0 1 1 1 0/divisor=3 exp;
 estimate 'A=3 lsmean' intercept 3 trt 0 0 0 0 0 0 0 1 1 1 0/divisor=3 exp;
run; 

/* Use the following SAS statements in conjunction with     */
/* data set DATA=Counts (shown in Output 10.24)             */
/*    to obtain Outputs 10.30 and 10.31                     */

proc genmod data=Counts;
 class BLOCK CTL_TRT a b;
 model count=BLOCK CTL_TRT a b a*b/dist=negbin type1 type3;
 title 'uncorrected Poisson model';
run;

proc genmod data=Counts;
 class BLOCK TRT;
 model count=BLOCK TRT/dist=negbin type1 type3 Wald;
 contrast 'ctl vs trt' trt 9 -1 -1 -1 -1 -1 -1 -1 -1 -1/wald;
 contrast 'a' trt 0  1 1 1  0 0 0  -1 -1 -1,
              trt 0  0 0 0  1 1 1  -1 -1 -1/wald;
 contrast 'b' trt 0  1 0 -1  1 0 -1  1 0 -1,
              trt 0  0 1 -1  0 1 -1  0 1 -1/wald;
 contrast 'a x b' trt 0  1 0 -1  0 0  0  -1 0 1,
                  trt 0  0 0  0  1 0 -1  -1 0 1,
                                  trt 0  0 1 -1  0 0  0  0 -1 1,
                                  trt 0  0 0  0  0 1 -1  0 -1 1/wald;
 estimate 'ctl lsmean' intercept 1 trt 1 0/exp;
 estimate 'treated lsm'intercept 9 trt 0 1 1 1 1 1 1 1 1 1/divisor=9 exp;
 estimate 'A=1 lsmean' intercept 3 trt 0 1 1 1 0/divisor=3 exp;
 estimate 'A=2 lsmean' intercept 3 trt 0 0 0 0 1 1 1 0/divisor=3 exp;
 estimate 'A=3 lsmean' intercept 3 trt 0 0 0 0 0 0 0 1 1 1 0/divisor=3 exp;
 title 'uncorrected Poisson model';
run;

/* Use the following SAS statements in conjunction with     */
/* data set DATA=Counts (shown in Output 10.24)             */
/*    to obtain Outputs 10.32 through 10.38                 */

PROC GENMOD data=Counts;
 k=1/0.2383;
 mu=_mean_;
 eta=_xbeta_;
 fwdlink link=log(mu/(mu+k));
 invlink ilink=k*exp(eta)/(1-exp(eta));
 CLASS BLOCK TRT;
 MODEL count=BLOCK TRT/ dist=negbin type1 type3 wald;
 contrast 'ctl vs trt' trt 9 -1 -1 -1 -1 -1 -1 -1 -1 -1;
 contrast 'a' trt 0  1 1 1  0 0 0  -1 -1 -1,
              trt 0  0 0 0  1 1 1  -1 -1 -1;
 contrast 'b' trt 0  1 0 -1  1 0 -1  1 0 -1,
              trt 0  0 1 -1  0 1 -1  0 1 -1;
 contrast 'a x b' trt 0  1 0 -1  0 0  0  -1 0 1,
                  trt 0  0 0  0  1 0 -1  -1 0 1,
                                  trt 0  0 1 -1  0 0  0  0 -1 1,
                                  trt 0  0 0  0  0 1 -1  0 -1 1;
 title 'negative binomial model';
run;

PROC GENMOD data=Counts;
 k=1/0.2383;
 mu=_mean_;
 eta=_xbeta_;
 fwdlink link=log(mu/(mu+k));
 invlink ilink=k*exp(eta)/(1-exp(eta));
 CLASS BLOCK CTL_TRT a b;
 *MODEL count=BLOCK CTL_TRT/ type3 wald;
 MODEL count=BLOCK CTL_TRT a b a*b/type3 wald ;
run;

PROC GENMOD data=Counts;
 count=_resp_;
 y=count;
 if y=0 then y=0.1;
 mu=_mean_;
 eta=_xbeta_;
 K=1;
 fwdlink link=log(mu/(mu+k));
 invlink ilink=k*exp(eta)/(1-exp(eta));
 lly=y*log(y/(y+k))-k*log((k+y)/k);
 llm=y*log(mu/(mu+k))-k*log((k+mu)/k);
 d=2*(lly-llm);
 variance var=mu+(mu*mu/k);
 deviance dev=d;
 class block ctl_trt a b;
 *model y=block ctl_trt/type3 wald;
 model y=block ctl_trt a b a*b/type3 wald;

PROC GENMOD data=Counts;
 K=2.5;
 count=_resp_;
 y=count;
 if y=0 then y=0.1;
 mu=_mean_;
 eta=_xbeta_;
 fwdlink link=log(mu/(mu+k));
 invlink ilink=k*exp(eta)/(1-exp(eta));
 lly=y*log(y/(y+k))-k*log((k+y)/k);
 llm=y*log(mu/(mu+k))-k*log((k+mu)/k);
 d=2*(lly-llm);
 variance var=mu+(mu*mu/k);
 deviance dev=d;
 CLASS BLOCK TRT;
 MODEL y=trt block;
 contrast 'ctl vs trt' trt 9 -1 -1 -1 -1 -1 -1 -1 -1 -1/wald;
 contrast 'a' trt 0  1 1 1  0 0 0  -1 -1 -1,
              trt 0  0 0 0  1 1 1  -1 -1 -1/wald;
 contrast 'b' trt 0  1 0 -1  1 0 -1  1 0 -1,
              trt 0  0 1 -1  0 1 -1  0 1 -1/wald;
 contrast 'a x b' trt 0  1 0 -1  0 0  0  -1 0 1,
                  trt 0  0 0  0  1 0 -1  -1 0 1,
                                  trt 0  0 1 -1  0 0  0  0 -1 1,
                                  trt 0  0 0  0  0 1 -1  0 -1 1/wald;
 contrast 'ctl vs trt' trt 9 -1 -1 -1 -1 -1 -1 -1 -1 -1;
 contrast 'a' trt 0  1 1 1  0 0 0  -1 -1 -1,
              trt 0  0 0 0  1 1 1  -1 -1 -1;
 contrast 'b' trt 0  1 0 -1  1 0 -1  1 0 -1,
              trt 0  0 1 -1  0 1 -1  0 1 -1;
 contrast 'a x b' trt 0  1 0 -1  0 0  0  -1 0 1,
                  trt 0  0 0  0  1 0 -1  -1 0 1,
                                  trt 0  0 1 -1  0 0  0  0 -1 1,
                                  trt 0  0 0  0  0 1 -1  0 -1 1;
 estimate 'ctl lsmean' intercept 1 trt 1 0;
 estimate 'treated lsm'intercept 9 trt 0 1 1 1 1 1 1 1 1 1/divisor=9;
 estimate 'A=1 lsmean' intercept 3 trt 0 1 1 1 0/divisor=3;
 estimate 'A=2 lsmean' intercept 3 trt 0 0 0 0 1 1 1 0/divisor=3;
 estimate 'A=3 lsmean' intercept 3 trt 0 0 0 0 0 0 0 1 1 1 0/divisor=3;
 ods output estimates=lsm;
 title 'negative binomial model';
run;

data c_lsm;
 set lsm;
 *k=1;
 k=2.5;
 counthat=k*exp(estimate)/(1-exp(estimate));
 deriv=k*exp(estimate)/((1-exp(estimate))**2);
 se_count=deriv*stderr;

proc print data=c_lsm;
run;

/* Use the following DATA step to obtain Outputs 10.39 through 10.42  */

data Leppik;
   input id y1-y4 trt base age;
    if t=4 then visit4=1;
     else visit4=0;
    log_base = log(base/4);
    log_age = log(age);
datalines;
104   5   3   3   3  0  11  31
106   3   5   3   3  0  11  30
107   2   4   0   5  0   6  25
114   4   4   1   4  0   8  36
116   7  18   9  21  0  66  22
118   5   2   8   7  0  27  29
123   6   4   0   2  0  12  31
126  40  20  23  12  0  52  42
130   5   6   6   5  0  23  37
135  14  13   6   0  0  10  28
141  26  12   6  22  0  52  36
145  12   6   8   4  0  33  24
201   4   4   6   2  0  18  23
202   7   9  12  14  0  42  36
205  16  24  10   9  0  87  26
206  11   0   0   5  0  50  26
210   0   0   3   3  0  18  28
213  37  29  28  29  0 111  31
215   3   5   2   5  0  18  32
217   3   0   6   7  0  20  21
219   3   4   3   4  0  12  29
220   3   4   3   4  0   9  21
222   2   3   3   5  0  17  32
226   8  12   2   8  0  28  25
227  18  24  76  25  0  55  30
230   2   1   2   1  0   9  40
234   3   1   4   2  0  10  19
238  13  15  13  12  0  47  22
101  11  14   9   8  1  76  18
102   8   7   9   4  1  38  32
103   0   4   3   0  1  19  20
108   3   6   1   3  1  10  30
110   2   6   7   4  1  19  18
111   4   3   1   3  1  24  24
112  22  17  19  16  1  31  30
113   5   4   7   4  1  14  35
117   2   4   0   4  1  11  27
121   3   7   7   7  1  67  20
122   4  18   2   5  1  41  22
124   2   1   1   0  1   7  28
128   0   2   4   0  1  22  23
129   5   4   0   3  1  13  40
137  11  14  25  15  1  46  33
139  10   5   3   8  1  36  21
143  19   7   6   7  1  38  35
147   1   1   2   3  1   7  25
203   6  10   8   8  1  36  26
204   2   1   0   0  1  11  25
207 102  65  72  63  1 151  22
208   4   3   2   4  1  22  32
209   8   6   5   7  1  41  25
211   1   3   1   5  1  32  35
214  18  11  28  13  1  56  21
218   6   3   4   0  1  24  41
221   3   5   4   3  1  16  32
225   1  23  19   8  1  22  26
228   2   3   0   1  1  25  21
232   0   0   0   0  1  13  36
236   1   4   3   2  1  12  37
;

proc print data=Leppik;
title 'output 10.39';
run;

data seizure;
 set Leppik;
   time = 1; y = y1; output;
   time = 2; y = y2; output;
   time = 3; y = y3; output;
   time = 4; y = y4; output;
run;

proc genmod data=seizure;
 class id trt time;
/* this model first */
 *model y=trt time trt*time log_base trt*log_base log_age/
      dist=poisson link=log type1 type3;
/* then this model */
 model y=trt time log_base(trt)log_age/
      dist=poisson link=log type1 type3;
 repeated subject=id / type=exch corrw;
 lsmeans trt / e;
 * estimate & contrast statements with model 2 only;
 * use 2nd set (unstarred);
 *estimate 'lsm trt 0' intercept 1 trt 1 0 time 0.25 0.25 0.25 0.25
          log_base 1.7679547 trt*log_base 1.7679547 0 log_age 3.3197835/exp; 
 *estimate 'lsm at t=4' intercept 1 trt 1 0 time 0 0 0 1
          log_base 1.7679547 trt*log_base 1.7679547 0 log_age 3.3197835/exp;  
 *estimate 'lsm at t<4' intercept 3 trt 3 0 time 1 1 1 0 
          log_base 5.3038641 trt*log_base 5.3038641 0 
          log_age 9.9593505/ divisor=3 exp;

 estimate 'lsm trt 0' intercept 1 trt 1 0 time 0.25 0.25 0.25 0.25
          log_base(trt) 1.7679547 0 log_age 3.3197835/exp; 
 estimate 'lsm at t=4' intercept 1 trt 1 0 time 0 0 0 1
          log_base(trt) 1.7679547 0 log_age 3.3197835/exp;  
 estimate 'lsm at t<4' intercept 3 trt 3 0 time 1 1 1 0 
          log_base(trt) 5.3038641 0 
          log_age 9.9593505/ divisor=3 exp;
 contrast 'log_b slopes =' log_base(trt) 1 -1;  
 contrast 'visit 4 vs others' time 1 1 1 -3;
 contrast 'among visit 1-3' time 1 -1 0 0, time 1 1 -2 0;
run;

/* Following is included for readers' convenience, but not shown in text  */
/* These statements obtain analysis of SEIZURE data using                 */
/* generalized linear mixed model via GLIMMIX macro                       */

%INCLUDE 'c:\SAS Institute\Sas\V8\glmm800.sas';
options nonotes;
%GLIMMIX(DATA=seizure,procopt=method=reml,
    stmts=%str(CLASS id trt time;
         MODEL y=trt time log_base(trt) log_age;
         repeated  /type=cs subject=id; 
         LSMEANS TRT/diff;
 estimate 'lsm trt 0' intercept 1 trt 1 0 time 0.25 0.25 0.25 0.25
          log_base(trt) 1.7679547 0 log_age 3.3197835; 
 estimate 'lsm at t=4' intercept 1 trt 1 0 time 0 0 0 1
          log_base(trt) 1.7679547 0 log_age 3.3197835;  
 estimate 'lsm at t<4' intercept 3 trt 3 0 time 1 1 1 0 
          log_base(trt) 5.3038641 0 
          log_age 9.9593505/ divisor=3;
 contrast 'log_b slopes =' log_base(trt) 1 -1;  
 contrast 'visit 4 vs others' time 1 1 1 -3;
 contrast 'among visit 1-3' time 1 -1 0 0, time 1 1 -2 0;),
         ERROR=Poisson,
         LINK=log);
run;


/* Chapter 11 */

/* Use the following DATA step to produce Output 11.1. */;

data confound;
  input rep blk a b c y;
    ca= -(a=0) + (a=1);
        cb= -(b=0) + (b=1);
        cc= -(b=0) + (c=1);
datalines;
     1      1     1    1    1     3.99
     1      1     1    0    0     1.14
     1      1     0    1    0     1.52
     1      1     0    0    1     3.33
     1      2     1    1    0     2.06
     1      2     1    0    1     5.58
     1      2     0    1    1     2.06
     1      2     0    0    0    -0.17
     2      1     1    1    1     3.77
     2      1     1    0    1     6.69
     2      1     0    1    0     2.17
     2      1     0    0    0    -0.01
     2      2     1    1    0     2.43
     2      2     0    1    1     1.22
     2      2     1    0    0     0.37
     2      2     0    0    1     2.06
     3      1     1    1    1     4.53
     3      1     0    1    1     1.90
     3      1     1    0    0     1.62
     3      1     0    0    0    -0.70
     3      2     1    1    0     1.56
     3      2     1    0    1     5.99
     3      2     0    1    0     1.44
     3      2     0    0    1     2.42
;
proc print data=confound;
run;

/* Use the following statements to produce Output 11.2. */;

proc sort data=confound;
  by rep;
proc glm data=confound;
  by rep;
  class blk;
  model y=blk ca|cb|cc / solution aliasing;
run;

/* Use the following statements to produce Output 11.3 through 11.4. */;

proc glm data=confound;
  class rep blk;
  model y=rep blk(rep) ca|cb|cc / solution;
run;

/* Use the following statements to produce Output 11.5. */;

proc glm data=confound;
  class rep blk;
  model y=rep blk(rep) ca|cb|cc / e1;
run;

/* Use the following DATA step to produce Output 11.5. */;

data fraction;
input a b c d  y ca cb cc cd;
datalines;
     0    0    0    0    2.29    -1    -1    -1    -1
     0    0    1    1    1.51    -1    -1     1     1
     0    1    0    1    1.49    -1     1    -1     1
     0    1    1    0    3.43    -1     1     1    -1
     1    0    0    1    3.78     1    -1    -1     1
     1    0    1    0    2.08     1    -1     1    -1
     1    1    0    0    3.30     1     1    -1    -1
     1    1    1    1    3.63     1     1     1     1
;
proc print data=fraction;
run;

/* Use these statements to produce Output 11.6. */;

proc glm data=fraction;
  model y=ca|cb|cc|cd / solution aliasing;
run;

/* Use these statements to produce Output 11.7. */;

proc glm data=fraction;
  model y=ca cb cc cd / solution aliasing;
run;

/* Use these statements to produce Output 11.8. */;

proc glm data=fraction;
  model y=a|b|c|d / aliasing;
run;

/* Use the following DATA step to produce Output 11.9. */;

data bibd;
input  blk trt y;
datalines;
     1      1      1.2
     1      2      2.7
     2      3      7.1
     2      4      8.6
     3      1      7.1
     3      3      9.7
     4      2      8.8
     4      4     15.1
     5      1      9.7
     5      4     17.4
     6      2     13.0
     6      3     16.6
;

proc print data=bibd;
run;

/* Use these statements to produce Outputs 11.10 and 11.11. */;

proc glm data=bibd;
  class blk trt;
  model y=trt blk / e1 ss3;
  means trt blk;
  lsmeans trt / stderr pdiff cl;
  random blk;
run;

/* Use these statements to produce Output 11.12. */;

proc mixed data=bibd;
  class blk trt;
  model y=trt / ddfm=satterth;
  lsmeans trt / pdiff cl;
  random blk;
run;

/* Use the following DATA step to produce Output 11.13. */;

data hrtrate;
 input PATIENT SEQUENCE $ VISIT BASEHR HR DRUG $ residt resids;
datalines;
             1         B          2         86      86    placebo          0       0
             1         B          3         86     106    test            -1      -1
             1         B          4         62      79    standard         1       0
             2         F          2         48      66    test             0       0
             2         F          3         58      56    placebo          1       0
             2         F          4         74      79    standard        -1      -1
             3         B          2         78      84    placebo          0       0
             3         B          3         78      76    test            -1      -1
             3         B          4         82      91    standard         1       0
             4         D          2         66      79    standard         0       0
             4         D          3         72     100    test             0       1
             4         D          4         90      82    placebo          1       0
             5         C          2         74      74    test             0       0
             5         C          3         90      71    standard         1       0
             5         C          4         66      62    placebo          0       1
             6         B          2         62      64    placebo          0       0
             6         B          3         74      90    test            -1      -1
             6         B          4         58      85    standard         1       0
             7         A          2         94      75    standard         0       0
             7         A          3         72      82    placebo          0       1
             7         A          4        100     102    test            -1      -1
             8         A          2         54      63    standard         0       0
             8         A          3         54      58    placebo          0       1
             8         A          4         66      62    test            -1      -1
             9         D          2         82      91    standard         0       0
             9         D          3         96      86    test             0       1
             9         D          4         78      88    placebo          1       0
            10         C          2         86      82    test             0       0
            10         C          3         70      71    standard         1       0
            10         C          4         58      62    placebo          0       1
            11         F          2         82      80    test             0       0
            11         F          3         80      78    placebo          1       0
            11         F          4         72      75    standard        -1      -1
            12         E          2         96      90    placebo          0       0
            12         E          3         92      93    standard        -1      -1
            12         E          4         82      88    test             0       1
            13         D          2         78      87    standard         0       0
            13         D          3         72      80    test             0       1
            13         D          4         76      78    placebo          1       0
            14         F          2         98      86    test             0       0
            14         F          3         86      86    placebo          1       0
            14         F          4         70      79    standard        -1      -1
            15         A          2         86      71    standard         0       0
            15         A          3         66      70    placebo          0       1
            15         A          4         74      90    test            -1      -1
            16         E          2         86      86    placebo          0       0
            16         E          3         90     103    standard        -1      -1
            16         E          4         82      86    test             0       1
            17         A          2         66      83    standard         0       0
            17         A          3        82       86    placebo          0       1
            17         A          4        86      102    test            -1      -1
            18         F          2        66       82    test             0       0
            18         F          3        78       80    placebo          1       0
            18         F          4        74       95    standard        -1      -1
            19         E          2        74       80    placebo          0       0
            19         E          3        78       79    standard        -1      -1
            19         E          4        70       74    test             0       1
            20         B          2        66       70    placebo          0       0
            20         B          3        74       62    test            -1      -1
            20         B          4        62       67    standard         1       0
            21         C          2        82       90    test             0       0
            21         C          3        90      103    standard         1       0
            21         C          4        76       82    placebo          0       1
            22         C          2        82       82    test             0       0
            22         C          3        66       83    standard         1       0
            22         C          4        90       82    placebo          0       1
            23         E          2        82       66    placebo          0       0
            23         E          3        74       87    standard        -1      -1
            23         E          4        82       82    test             0       1
            24         D          2        72       75    standard         0       0
            24         D          3        82       86    test             0       1
            24         D          4        74       82    placebo          1       0
;
proc print data=hrtrate;
run;

/* Use these statements to produce Outputs 11.14 through 11.16. */;

proc glm data=hrtrate;
  class sequence patient visit drug;
  model hr = sequence patient(sequence) visit drug resids residt / solution;
  random patient(sequence);
run;

/* Use these statements to produce Outputs 11.17 and 11.18. */;

estimate 'DIRECT EFFECT OF STD' drug -1 2 -1 / divisor=3;
estimate 'DIRECT EFFECT OF TST' drug -1 -1 2 / divisor=3;
estimate 'DIRECT EFFECT OF PCB' drug 2 -1 -1 / divisor=3;
lsmeans drug / pdiff cl e;
run; 

/* Use these statements to produce Output 11.19. */;

proc mixed data=hrtrate order=internal;
  class sequence patient visit drug;
  model hr = sequence visit drug resids residt / solution ddfm=satterth;
  random patient(sequence);
  lsmeans drug / pdiff cl e;
run;

/* Use the following DATA step to produce Output 11.20. */;

data monofil;
input SOURCE $ AMT TS;
datalines;
       A           1       11.5
       A           2       13.8
       A           3       14.4
       A           4       16.8
       A           5       18.7
       B           1       10.8
       B           2       12.3
       B           3       13.7
       B           4       14.2
       B           5       16.6
       C           1       13.1
       C           2       16.2
       C           3       19.0
       C           4       22.9
       C           5       26.5
;
proc print data=monofil;
run;

/* Use these statements to produce Outputs 11.21 and 11.22*/

proc glm data=monofil;
  class source;
  model ts=source amt source*amt / solution;
  estimate 'A vs B at AMT=3.5' source 1 -1 0 source*amt 3.5 -3.5 0;
run;

/* Use the following DATA step to produce Output 11.23. */;

data monofil2;
input SOURCE $ AMT TS;
datalines;
       A           1       11.5
       A           2       13.8
       A           3       14.4
       A           4       16.8
       A           5       18.7
       B           1       10.8
       B           2       12.3
       B           3       13.7
       B           4       14.2
       B           5       16.6
       C           1       13.1
       C           2       16.2
       C           3       19.0
       C           4       22.9
       C           5       26.5
       C           0       10.1
       C           0       10.2
       C           0        9.8
       C           0        9.9
       C           0       10.2
;
proc print data=monofil2;
run;

/* Use these statements to produce Output 11.24*/

proc glm data=monofil2;
  class source;
  model ts=source*amt / solution;
run;

/* Use the following statements to produce Outputs 11.25 and 11.26. */;

data lackofit;
  input level lackofit loglivcu;
datalines;
          0             0       1.16761
          0             0       1.25789
          0             0       1.27312
          0             0       1.09688
          0             0       1.26881
          0             0       1.24391
          150         150       1.38957
          150         150       1.46716
          150         150       1.51402
          150         150       1.30969
          150         150       1.24596
          150         150       1.37160
          300         300       1.99269
          300         300       2.19897
          300         300       2.14038
          300         300       1.83695
          300         300       1.97164
          300         300       2.11470
          450         450       2.41911
          450         450       2.34434
          450         450       2.15644
          450         450       2.32868
          450         450       2.46058
          450         450       2.43342
;
proc print data=lackofit;
run;

proc glm data=lackofit;
  class lackofit;
  model loglivcu=level lackofit/ss1;
run;
/* Use the following statements to produce Outputs 11.27 through 11.29. */;

data unbalnst;
input TRT POT PLANT Y;
datalines;
     1      1       1      15
     1      1       2      13
     1      1       3      16
     1      2       1      17
     1      2       2      19
     1      3       1      12
     2      1       1      20
     2      1       2      21
     2      2       1      20
     2      2       2      23
     2      2       3      19
     2      2       4      19
     3      1       1      12
     3      1       2      13
     3      1       3      14
     3      2       1      11
     3      3       1      12
     3      3       2      13
     3      3       3      15
     3      3       4      11
     3      3       5       9
;
proc print data=unbalnst;
run;

proc glm data=unbalnst;
  class trt pot;
  model y=trt pot(trt)/ss1 ss3;
  means trt pot(trt);
  lsmeans trt pot(trt);
run;

/* Use the following statements to produce Outputs 11.30 and 11.31. */;

options ls=80;

data mloc;
 input exp_unit loc blk  trt y;
datalines;
                         1     1       1     1     46.6
                         2     1       2     1     43.7
                         3     1       3     1     37.9
                         4     2       1     1     34.0
                         5     2       2     1     38.1
                         6     2       3     1     28.5
                         7     3       1     1     42.7
                         8     3       2     1     27.7
                         9     3       3     1     39.6
                        10     4       1     1     39.5
                        11     4       2     1     53.4
                        12     4       3     1     50.2
                        13     5       1     1     48.0
                        14     5       2     1     45.8
                        15     5       3     1     39.0
                        16     5       4     1     38.3
                        17     5       5     1     42.6
                        18     5       6     1     37.1
                        19     6       1     1     30.1
                        20     6       2     1     33.8
                        21     6       3     1     35.6
                        22     6       4     1     33.3
                        23     6       5     1     31.4
                        24     6       6     1     39.6
                        25     7       1     1     34.8
                        26     7       2     1     38.3
                        27     7       3     1     39.8
                        28     7       4     1     41.8
                        29     7       5     1     31.0
                        30     7       6     1     43.3
                        31     7       7     1     41.1
                        32     7       8     1     32.9
                        33     7       9     1     35.0
                        34     7      10     1     38.0
                        35     7      11     1     51.5
                        36     7      12     1     36.2
                        37     8       1     1     44.5
                        38     8       2     1     48.2
                        39     8       3     1     46.4
                        40     8       4     1     53.0
                        41     8       5     1     51.7
                        42     8       6     1     43.5
                        43     8       7     1     44.1
                        44     8       8     1     43.3
                        45     8       9     1     44.2
                        46     8      10     1     54.6
                        47     8      11     1     52.1
                        48     8      12     1     44.9
                        49     1       1     2     46.4
                        50     1       2     2     43.6
                        51     1       3     2     39.5
                        52     2       1     2     28.5
                        53     2       2     2     40.0
                        54     2       3     2     42.5
                        55     3       1     2     38.9
                        56     3       2     2     46.2
                        57     3       3     2     45.1
                        58     4       1     2     47.2
                        59     4       2     2     59.0
                        60     4       3     2     50.7
                        61     5       1     2     46.3
                        62     5       2     2     53.6
                        63     5       3     2     44.0
                        64     5       4     2     41.6
                        65     5       5     2     44.2
                        66     5       6     2     46.0
                        67     6       1     2     27.7
                        68     6       2     2     36.9
                        69     6       3     2     35.7
                        70     6       4     2     41.2
                        71     6       5     2     36.5
                        72     6       6     2     51.0
                        73     7       1     2     43.6
                        74     7       2     2     48.9
                        75     7       3     2     44.6
                        76     7       4     2     52.1
                        77     7       5     2     38.5
                        78     7       6     2     36.8
                        79     7       7     2     37.8
                        80     7       8     2     46.2
                        81     7       9     2     43.9
                        82     7      10     2     41.5
                        83     7      11     2     48.4
                        84     7      12     2     47.9
                        85     8       1     2     48.2
                        86     8       2     2     57.6
                        87     8       3     2     44.1
                        88     8       4     2     46.7
                        89     8       5     2     56.1
                        90     8       6     2     52.1
                        91     8       7     2     54.8
                        92     8       8     2     49.4
                        93     8       9     2     54.6
                        94     8      10     2     56.6
                        95     8      11     2     44.3
                        96     8      12     2     43.3
                        97     1       1     3     44.4
                        98     1       2     3     31.4
                        99     1       3     3     48.2
                       100     2       1     3     20.1
                       101     2       2     3     29.5
                       102     2       3     3     17.1
                       103     3       1     3     47.5
                       104     3       2     3     48.8
                       105     3       3     3     47.4
                       106     4       1     3     74.4
                       107     4       2     3     71.6
                       108     4       3     3     75.1
                       109     5       1     3     38.3
                       110     5       2     3     51.1
                       111     5       3     3     44.4
                       112     5       4     3     56.6
                       113     5       5     3     47.3
                       114     5       6     3     44.3
                       115     6       1     3     28.4
                       116     6       2     3     27.3
                       117     6       3     3     31.6
                       118     6       4     3     31.6
                       119     6       5     3     34.2
                       120     6       6     3     28.3
                       121     7       1     3     55.4
                       122     7       2     3     46.9
                       123     7       3     3     50.9
                       124     7       4     3     51.7
                       125     7       5     3     49.3
                       126     7       6     3     58.4
                       127     7       7     3     46.5
                       128     7       8     3     53.9
                       129     7       9     3     43.8
                       130     7      10     3     57.7
                       131     7      11     3     41.6
                       132     7      12     3     66.1
                       133     8       1     3     61.9
                       134     8       2     3     64.9
                       135     8       3     3     57.0
                       136     8       4     3     57.5
                       137     8       5     3     46.9
                       138     8       6     3     61.4
                       139     8       7     3     59.9
                       140     8       8     3     63.0
                       141     8       9     3     64.8
                       142     8      10     3     64.6
                       143     8      11     3     59.7
                       144     8      12     3     65.0
;
proc print data=mloc;
run;

proc sort data=mloc;
 by loc trt;

proc means noprint data=mloc;
 by loc trt; var y;
 output out=averages mean=y_mean;
run;

proc print data=averages;
run;

/*Use these statements to produce Output 11.32*/;

proc glm data=mloc;
 class loc blk trt;
 model y=trt loc blk(loc);
 means trt;
 lsmeans trt;
run;

/*Use these statements to produce Output 11.33*/;

proc glm data=mloc;
 class loc blk trt;
 model y=loc blk(loc) trt loc*trt;
 means trt;
 lsmeans trt loc*trt/slice=loc;
run;

/*Use these statements to produce Outputs 11.34 through 11.36*/;

proc mixed method=type3 data=mloc;
 class loc blk  trt;
 model y=trt/ddfm=kr;
 random loc blk(loc) loc*trt;
 lsmeans trt/diff;
 estimate 't1 vs t2 at loc 1' trt 1 -1 0 | loc*trt 1 -1 0;
 estimate 't1 vs t3 at loc 1' trt 1 0 -1 | loc*trt 1 0 -1;
 estimate 't1 vs t2 at loc 2' trt 1 -1 0 | loc*trt 0 0 0  1 -1 0;
 estimate 't1 vs t3 at loc 2' trt 1 0 -1 | loc*trt 0 0 0  1 0 -1;
 estimate 't1 vs t2 at loc 3' trt 1 -1 0
          | loc*trt 0 0 0 0 0 0  1 -1 0;
 estimate 't1 vs t3 at loc 3' trt 1 0 -1  
          | loc*trt 0 0 0 0 0 0  1 0 -1;
 estimate 't1 vs t2 at loc 4' trt 1 -1 0
          | loc*trt 0 0 0 0 0 0 0 0 0 1 -1 0;
 estimate 't1 vs t3 at loc 4' trt 1 0 -1  
          | loc*trt 0 0 0 0 0 0 0 0 0  1 0 -1;
 estimate 't1 vs t2 at loc 5' trt 1 -1 0
          | loc*trt 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0;
 estimate 't1 vs t3 at loc 5' trt 1 0 -1  
          | loc*trt 0 0 0 0 0 0 0 0 0 0 0 0 1 0 -1;
 estimate 't1 vs t2 at loc 6' trt 1 -1 0
          | loc*trt 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  1 -1 0;
 estimate 't1 vs t3 at loc 6' trt 1 0 -1  
          | loc*trt 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  1 0 -1;
 estimate 't1 vs t2 at loc 7' trt 1 -1 0
          | loc*trt 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  1 -1 0;
 estimate 't1 vs t3 at loc 7' trt 1 0 -1  
          | loc*trt 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0  1 0 -1;
 estimate 't1 vs t2 at loc 8' trt 1 -1 0
          | loc*trt 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0   1 -1 0;
 estimate 't1 vs t3 at loc 8' trt 1 0 -1  
          | loc*trt 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0    1 0 -1;
run;

/*Use these statements to produce Output 11.37*/;

proc sort data=mloc;
 by loc;
proc means noprint data=mloc;
 by loc; var y;
 output out=env_indx mean=index;
run;
data all;
 merge mloc env_indx;
 by loc;
proc print data=all;
run;

proc mixed data=all;
 class loc blk trt;
 model y=trt trt*index/noint solution ddfm=satterth;
 random loc blk(loc) loc*trt;
 lsmeans trt/diff;
 contrast 'trt at mean index'
    trt 1 -1 0 trt*index 45.2 -45.2 0,
    trt 1 0 -1 trt*index 45.2 0 -45.2;
run;

/*Use these statements to produce Output 11.38*/;

proc mixed data=all;
 class loc blk trt;
 model y=trt trt*index/noint solution ddfm=satterth;
 random loc blk(loc) loc*trt;
 lsmeans trt/at index=30.9 diff;
 lsmeans trt/at means diff;
 lsmeans trt/at index=57.9 diff;
run;

/*Use these statements to produce Outputs 11.39 and 11.40*/;

data sires;
input line sire agedam steerno age intlwt avdlygn;
cards;
1 1 3 1  192 390 2.24
1 1 3 2  154 403 2.65
1 1 4 3  185 432 2.41
1 1 4 4  193 457 2.25
1 1 5 5  186 483 2.58
1 1 5 6  177 469 2.67
1 1 5 7  177 428 2.71
1 1 5 8  163 439 2.47
1 2 4 9  188 439 2.29
1 2 4 10 178 407 2.26
1 2 5 11 198 498 1.97
1 2 5 12 193 459 2.14
1 2 5 13 186 459 2.44
1 2 5 14 175 375 2.52
1 2 5 15 171 382 1.72
1 2 5 16 168 417 2.75
1 3 3 17 154 389 2.38
1 3 4 18 184 414 2.46
1 3 5 19 174 483 2.29
1 3 5 20 170 430 2.30
1 3 5 21 169 443 2.94
2 4 3 22 158 381 2.50
2 4 3 23 158 365 2.44
2 4 4 24 169 386 2.44
2 4 4 25 144 339 2.15
2 4 5 26 159 419 2.54
2 4 5 27 152 469 2.74
2 4 5 28 149 379 2.50
2 4 5 29 149 375 2.54
2 5 3 30 189 395 2.65
2 5 4 31 187 447 2.52
2 5 4 32 165 430 2.67
2 5 5 33 181 453 2.79
2 5 5 34 177 385 2.33
2 5 5 35 151 414 2.67
2 5 5 36 147 353 2.69
3 6 4 37 184 411 3.00
3 6 4 38 184 420 2.49
3 6 5 39 187 427 2.25
3 6 5 40 184 409 2.49
3 6 5 41 183 337 2.02
3 6 5 42 177 352 2.31
3 7 3 43 205 472 2.57
3 7 3 44 193 340 2.37
3 7 4 45 162 375 2.64
3 7 5 46 206 451 2.37
3 7 5 47 205 472 2.22
3 7 5 48 187 402 1.90
3 7 5 49 178 464 2.61
3 7 5 50 175 414 2.13
3 8 3 51 200 466 2.16
3 8 3 52 184 356 2.33
3 8 3 53 175 449 2.52
3 8 4 54 178 360 2.45
3 8 5 55 189 385 1.44
3 8 5 56 184 431 1.72
3 8 5 57 183 401 2.17
3 9 3 58 166 404 2.68
3 9 4 59 187 482 2.43
3 9 4 60 186 350 2.36
3 9 4 61 184 483 2.44
3 9 5 62 180 425 2.66
3 9 5 63 177 420 2.46
3 9 5 64 175 440 2.52
3 9 5 65 164 405 2.42
;
proc print data=sires;
run;
proc glm data=sires;
  class line sire agedam;
  model avdlygn=line sire(line) agedam line*agedam age intlwt / solution ss3;
  test h=line e=sire(line);    
run;

/*Use these statements to produce Output 11.41*/;

proc glm data=sires;
  class sire agedam;
  model avdlygn=sire agedam / solution ss1 ss2 ss3;
  contrast 'young vs old' agedam .5 .5 -1;
  estimate 'young vs old' agedam .5 .5 -1;
run;

/*Use these statements to produce Output 11.42*/;

proc glm data=sires;
  absorb sire;
  class agedam;
  model avdlygn=agedam / solution ss1 ss2 ss3;
  contrast 'young vs old' agedam .5 .5 -1;
  estimate 'young vs old' agedam .5 .5 -1;
run;

/*Use these statements to produce Output 11.43*/;

proc glm;
  absorb line sire;
  class line agedam;
  model avdlygn=agedam line*agedam age intlwt / solution ss3;
  contrast 'young vs old' agedam .5 .5 -1;
  estimate 'young vs old' agedam .5 .5 -1;
run;

/*Use these statements to produce Output 11.44*/;

proc mixed data=sires;
  class line sire agedam;
  model avdlygn=line agedam line*agedam age intlwt/htype=1,2,3 ddfm=satterth;
  random sire(line);
  contrast 'young vs old' agedam .5 .5 -1;
  estimate 'young vs old' agedam .5 .5 -1;
run;
