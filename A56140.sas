/*---------------------------------------------------------------*/
/* SAS System for Linear Models, Third Edition                   */
/* Rudolph Freund and Ramon Littell                              */
/*                                                               */
/* Copyright 1991 by SAS Institute, Cary, NC, USA                */
/* ISBN 1-55544-430-X                                            */
/*---------------------------------------------------------------*/

/* This appendix contains the SAS code needed to produce the output
   in this book with Release 6.06 of the SAS System. The DATA steps,
   including the raw data, that are needed to produce the output are
   shown here. The PROC statements that you must use are presented
   in the appropriate chapter in the context of the discussion.

   This appendix is divided into sections that correspond to chapter
   numbers to help you quickly locate the example code you need.
   Before each DATA step, there is a sentence telling you what output
   that DATA step corresponds to.
*/

/* Chapter 1 */

/* Use the following DATA step to produce Output 1.1 through 1.3. */

    data methane;
       input stortime gas;
       cards;
    1  8.2
    1  6.6
    1  9.8
    2  19.7
    2  15.7
    2  16.0
    3  28.6
    3  25.0
    3  31.9
    4  30.8
    4  37.8
    4  40.2
    5  40.3
    5  42.9
    5  32.6
    ;

/* Use the following DATA step to produce Output 1.6. */

data methane;
   input stortime gas;
   cards;
1  8.2
1  6.6
1  9.8
2  19.7
2  15.7
2  16.0
3  28.6
3  25.0
3  31.9
4  30.8
4  37.8
4  40.2
5  40.3
5  42.9
5  32.6
2.5 .
;
proc reg;
   id stortime;
   model gas=stortime / p clm cli;
run;

/* Use the following DATA step to produce Output 1.15 and 1.18. */

    data newmeth;
       set methane;
       storsq=stortime**2;
    data phony;
       do stortime=1 to 5 by .1;
          storsq=stortime**2;
          output;
       end;
    data both;
       set newmeth phony;

/* Note:  You must use the raw data used to produce Output 1.1 through */
/* 1.3 to produce Output 1.15 and 1.18. */

/* Use the following DATA step to produce Output 1.4 and 1.5, 1.7 */
/* through 1.12, and 1.17. */

    data auction;
       input mkt cattle calves hogs sheep cost volume type $;
       cards;
    1  3.437   5.791  3.268   10.649   27.698  23.145   O
    2  12.801  4.558  5.751   14.375   57.634  37.485   O
    3  6.136   6.223  15.175  2.811    47.172  30.345   O
    4  11.685  3.212  0.639   0.694    49.295  16.230   B
    5  5.733   3.220  0.534   2.052    24.115  11.539   B
    6  3.021   4.348  0.839   2.356    33.612  10.564   B
    7  1.689   0.634  0.318   2.209    9.512   4.850    O
    8  2.339   1.895  0.610   0.605    14.755  5.449    B
    9  1.025   0.834  0.734   2.825    10.570  5.418    O
    10 2.936   1.419  0.331   0.231    15.394  4.917    B
    11 5.049   4.195  1.589   1.957    27.843  12.790   B
    12 1.693   3.602  0.837   1.582    17.717  7.714    B
    13 1.187   2.679  0.459   18.837   20.253  23.162   O
    14 9.730   3.951  3.780   0.524    37.465  17.985   B
    15 14.325  4.300  10.781  36.863   101.334 66.269   O
    16 7.737   9.043  1.394   1.524    47.427  19.698   B
    17 7.538   4.538  2.565   5.109    35.944  19.750   B
    18 10.211  4.994  3.081   3.681    45.945  21.967   B
    19 8.697   3.005  1.378   3.338    46.890  16.418   B
    ;

/* Note: In Output 1.10, you must use the following assignment */
/* statement in the DATA step to get the correct output: */

hs=hogs+sheep;

/* Use the following DATA step to produce Output 1.13 and 1.14. */

    data newmeth;
       input stortime gas;
       storsq=stortime**2;
       storcu=stortime**3;
       cards;
    1  8.2
    1  6.6
    1  9.8
    2  19.7
    2  15.7
    2  16.0
    3  28.6
    3  25.0
    3  31.9
    4  30.8
    4  37.8
    4  40.2
    5  40.3
    5  42.9
    5  32.6
    ;

/* Use the following DATA step to produce Output 1.16. */

    data weighgas;
       input stortime gas;
       storsq=stortime**2;
       ww=1/storsq;
       cards;
    1  8.2
    1  6.6
    1  9.8
    2  19.7
    2  15.7
    2  16.0
    3  28.6
    3  25.0
    3  31.9
    4  30.8
    4  37.8
    4  40.2
    5  40.3
    5  42.9
    5  32.6
    ;

/* Use the following DATA step to produce Output 1.19. */

data resplot;
  set resplot;
  if type='B' then bcost=cost;
  else bcost=.;

/* Note: You must use the raw data presented earlier to produce */
/* Output 1.4 with this DATA step, along with the appropriate */
/* PROC REG statements given in the chapter, to produce Output 1.19. */

/* Chapter 2 */

/* Use the following DATA step to produce Output 2.1. */

    data peppers;
      input angle @@;
    cards;
    3 11 -7 2 3 8 -3 -2 13 4 7
    -1 4 7 -1 4 12 -3 7 5 3 -1
    9 -7 2 4 8 -2
    ;

/* Use the following DATA step to produce Output 2.2. */

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

/* Use the following DATA step to produce Output 2.3. */

    data bullets;
      input powder velocity;
    cards;
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
    ;

/* Use the following DATA step to produce Output 2.4 through 2.12. */

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

/* Use the following DATA step to produce Output 2.13 through 2.16. */

    data pestcide;
    input block blend $ pctloss;
    cards;
    1 B 18.2
    1 A 16.9
    1 C 17.0
    1 E 18.3
    1 D 15.1
    2 A 16.5
    2 E 18.3
    2 B 19.2
    2 C 18.1
    2 D 16.0
    3 B 17.1
    3 D 17.8
    3 C 17.3
    3 E 19.8
    3 A 17.5
    ;

/* Use the following DATA step to produce Output 2.17 and 2.18. */

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

/* Use the following DATA step to produce Output 2.19. */

   data grasses;
   input method $ 1 variety 2 y1-y6 trt $ 1-2;
   y1=y1/10; y2=y2/10; y3=y3/10; y4=y4/10; y5=y5/10; y6=y6/10;
   cards;
   A1 221 241 191 221 251 181
   A2 271 151 206 286 151 246
   A3 223 258 228 283 213 183
   A4 198 283 268 273 268 268
   A5 200 170 240 225 280 225
   B1 135 145 115  60 270 180
   B2 169 174 104 194 119 154
   B3 157 102 167 197 182 122
   B4 151  65 171  76 136 211
   B5 218 228 188 213 163 143
   C1 190 220 200 145 190 160
   C2 200 220 255 165 180 175
   C3 164 144 214 199 104 214
   C4 245 160 110  75 145 155
   C5 118 143 213  63  78 138
   ;

/* Use the following DATA step to produce Output 2.20 through 2.29. */

   data fctorial;  set grasses;  drop y1-y6;
   yield=y1; output;
   yield=y2; output;
   yield=y3; output;
   yield=y4; output;
   yield=y5; output;
   yield=y6; output;
   run;

/* Note: You must use the raw data presented in Output 2.19 to */
/* produce Output 2.20 through 2.29. */

/* Use the following DATA step to produce Output 2.30 and 2.31. */

   data splplot;
   input rep cult $ inoc $ drywt;
   cards;
   1  A  CON  27.4
   1  A  DEA  29.7
   1  A  LIV  34.5
   1  B  CON  29.4
   1  B  DEA  32.5
   1  B  LIV  34.4
   2  A  CON  28.9
   2  A  DEA  28.7
   2  A  LIV  33.4
   2  B  CON  28.7
   2  B  DEA  32.4
   2  B  LIV  36.4
   3  A  CON  28.6
   3  A  DEA  29.7
   3  A  LIV  32.9
   3  B  CON  27.2
   3  B  DEA  29.1
   3  B  LIV  32.6
   4  A  CON  26.7
   4  A  DEA  28.9
   4  A  LIV  31.8
   4  B  CON  26.8
   4  B  DEA  28.6
   4  B  LIV  30.7
   ;

/* Use the following DATA step to produce Output 2.32 through 2.34. */

   data nested;
   input package sample srct;
   cards;
   1  1  3.4641
   1  1  3.7417
   1  2  5.1962
   1  2  5.9161
   1  3  4.8990
   1  3  7.9363
   1  4  9.2195
   1  4  6.0828
   2  1  23.5160
   2  1  19.9499
   2  2  6.8557
   2  2  7.6158
   2  3  14.4914
   2  3  19.6214
   2  4  64.8895
   2  4  29.1548
   3  1  9.7980
   3  1  8.6603
   3  2  14.1774
   3  2  12.5300
   3  3  7.2801
   3  3  7.9373
   3  4  9.2195
   3  4  14.3875
   4  1  7.9373
   4  1  8.5440
   4  2  9.2736
   4  2  9.2195
   4  3  4.4721
   4  3  6.3246
   4  4  9.0000
   4  4  6.0828
   5  1  14.1774
   5  1  15.9060
   5  2  20.5670
   5  2  17.5214
   5  3  22.4499
   5  3  24.5967
   5  4  29.6142
   5  4  23.2164
   ;

/* Chapter 3 */

/* Use the following DATA steps to produce Output 3.1 through 3.7. */

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

/* Use the following DATA steps to produce Output 3.8 through 3.11. */

    data grasses;
      input method $ variety y1-y6;
       y1=y1/10; y2=y2/10; y3=y3/10; y4=y4/10; y5=y5/10; y6=y6/10;
   cards;
   A 1 221 241 191 221 251 181
   A 2 271 151 206 286 151 246
   A 3 223 258 228 283 213 183
   A 4 198 283 268 273 268 268
   A 5 200 170 240 225 280 225
   B 1 135 145 115  60 270 180
   B 2 169 174 104 194 119 154
   B 3 157 102 167 197 182 122
   B 4 151  65 171  76 136 211
   B 5 218 228 188 213 163 143
   C 1 190 220 200 145 190 160
   C 2 200 220 255 165 180 175
   C 3 164 144 214 199 104 214
   C 4 245 160 110  75 145 155
   C 5 118 143 213  63  78 138
   ;
   data fctorial;  set grasses;  drop y1-y6;
     yield=y1; output;
      yield=y2; output;
      yield=y3; output;
      yield=y4; output;
      yield=y5; output;
      yield=y6; output;
    run;

/* Use the following DATA step to produce Output 3.12 through 3.16. */

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

/* Use the following DATA step to produce Output 3.17 and 3.18. */

    data inoc;
      input rep cult $ inoc $ drywt;
   cards;
   1 A CON 27.4
   1 A DEA 29.7
   1 A LIV 34.5
   1 B CON 29.4
   1 B DEA 32.5
   1 B LIV 34.4
   2 A CON 28.9
   2 A DEA 28.7
   2 A LIV 33.4
   2 B CON 28.7
   2 B DEA 32.4
   2 B LIV 36.4
   3 A CON 28.6
   3 A DEA 29.7
   3 A LIV 32.9
   3 B CON 27.2
   3 B DEA 29.1
   3 B LIV 32.6
   4 A CON 26.7
   4 A DEA 28.9
   4 A LIV 31.8
   4 B CON 26.8
   4 B DEA 28.6
   4 B LIV 30.7
   ;

/* Chapter 4 */

/* Use the following DATA step to produce Output 4.1 through 4.6. */

   data teachers;
      input teach $ score1 score2;
      cards;
   JAY    69 75
   JAY    69 70
   JAY    71 73
   JAY    78 82
   JAY    79 81
   JAY    73 75
   PAT    69 70
   PAT    68 74
   PAT    75 80
   PAT    78 85
   PAT    68 68
   PAT    63 68
   PAT    72 74
   PAT    63 66
   PAT    71 76
   PAT    72 78
   PAT    71 73
   PAT    70 73
   PAT    56 59
   PAT    77 83
   ROBIN  72 79
   ROBIN  64 65
   ROBIN  74 74
   ROBIN  72 75
   ROBIN  82 84
   ROBIN  69 68
   ROBIN  76 76
   ROBIN  68 65
   ROBIN  78 79
   ROBIN  70 71
   ROBIN  60 61
   ;

/* Use the following DATA step to produce Output */
/* 4.7 through 4.12, and Output 4.15. */

   data bulls;
      input a b y;
      cards;
   1 1 5
   1 1 6
   1 2 2
   1 2 3
   1 2 5
   1 2 6
   1 2 7
   1 3 3
   2 1 2
   2 1 3
   2 2 8
   2 2 8
   2 2 9
   2 3 4
   2 3 4
   2 3 6
   2 3 6
   2 3 7
   ;

/* Use the following DATA step to produce Output 4.13, 4.14, and 4.16. */

   data bullmiss;
      input a b y;
      cards;
   1 1 5
   1 1 6
   1 2 2
   1 2 3
   1 2 5
   1 2 6
   1 2 7
   2 1 2
   2 1 3
   2 2 8
   2 2 8
   2 2 9
   2 3 4
   2 3 4
   2 3 6
   2 3 6
   2 3 7
   ;

/* Use the following DATA step to produce Output 4.19 through 4.21. */

   data irrigate;
      input irrig reps cult $ yield;
      cards;
   1 1 A 1.6
   1 1 B 3.3
   1 2 A 3.4
   1 2 B 4.7
   1 3 A 3.2
   1 3 B 5.6
   2 1 A 2.6
   2 1 B 5.1
   2 2 A 4.6
   2 2 B 1.1
   2 3 A 5.1
   2 3 B 6.2
   3 1 A 4.7
   3 1 B 6.8
   3 2 A 5.5
   3 2 B 6.6
   3 3 A 5.7
   3 3 B 4.5
   ;

/* Chapter 5 */

/* Use the following DATA step to produce Output 5.1 through 5.3. */

   data confound;
      input rep blk a b c y;
      ca=-(a=0)+(a=1);
      cb=-(b=0)+(b=1);
      cc=-(c=0)+(c=1);
      cards;
   1 1 1 1 1  3.99
   1 1 1 0 0  1.14
   1 1 0 1 0  1.52
   1 1 0 0 1  3.33
   1 2 1 1 0  2.06
   1 2 1 0 1  5.58
   1 2 0 1 1  2.06
   1 2 0 0 0 -0.17
   2 1 1 1 1  3.77
   2 1 1 0 1  6.69
   2 1 0 1 0  2.17
   2 1 0 0 0 -0.01
   2 2 1 1 0  2.43
   2 2 0 1 1  1.22
   2 2 1 0 0  0.37
   2 2 0 0 1  2.06
   3 1 1 1 1  4.53
   3 1 0 1 1  1.90
   3 1 1 0 0  1.62
   3 1 0 0 0 -0.70
   3 2 1 1 0  1.56
   3 2 1 0 1  5.99
   3 2 0 1 0  1.44
   3 2 0 0 1  2.42
   ;

/* Use the following DATA step to produce Output 5.4 through 5.6. */

   data bibd;
      input blk trt y;
      cards;
   1 1  1.2
   1 2  2.7
   2 3  7.1
   2 4  8.6
   3 1  7.1
   3 3  9.7
   4 2  8.8
   4 4 15.1
   5 1  9.7
   5 4 17.4
   6 2 13.0
   6 3 16.6
   ;

/* Use the following DATA step to produce Output 5.7 through 5.9. */

   data resdefct;
      retain ptrtment ' ';
      input cow period trtment $ square milk;
      resid='O'; if period ne 1 then resid = ptrtment;
      ptrtment=trtment;
      drop ptrtment;
      resida=0; residb=0;
      if resid='A' then resida=1;
      if resid='C' then resida=-1;
      if resid='B' then residb=1;
      if resid='C' then residb=-1;
      cards;
   1 1 A 1  38
   1 2 B 1  25
   1 3 C 1  15
   2 1 B 1 109
   2 2 C 1  86
   2 3 A 1  39
   3 1 C 1 124
   3 2 A 1  72
   3 3 B 1  27
   4 1 A 2  86
   4 2 C 2  76
   4 3 B 2  46
   5 1 B 2  75
   5 2 A 2  35
   5 3 C 2  34
   6 1 C 2 101
   6 2 B 2  63
   6 3 A 2   1
   ;

/* Use the following DATA step to produce Output 5.10 through 5.12. */

   data monofil;
      input source $ amt ts;
      cards;
   A 1  11.5
   A 2  13.8
   A 3  14.4
   A 4  16.8
   A 5  18.7
   B 1  10.8
   B 2  12.3
   B 3  13.7
   B 4  14.2
   B 5  16.6
   C 1  13.1
   C 2  16.2
   C 3  19.0
   C 4  22.9
   C 5  26.5
   ;

/* Use the following DATA step to produce Output 5.13 and 5.14. */

   data monofil;
      input source $ amt ts;
      cards;
   A 1  11.5
   A 2  13.8
   A 3  14.4
   A 4  16.8
   A 5  18.7
   B 1  10.8
   B 2  12.3
   B 3  13.7
   B 4  14.2
   B 5  16.6
   C 1  13.1
   C 2  16.2
   C 3  19.0
   C 4  22.9
   C 5  26.5
   ;
   data zeroamt;
      input source $ amt ts;
      cards;
   C  0  10.1
   C  0  10.2
   C  0   9.8
   C  0   9.9
   C  0  10.2
   ;
   data monofil; set monofil zeroamt;

/* Use the following DATA step to produce Output 5.15 through 5.17. */

   data pots;
   input trt pot plant y;
   cards;
   1  1 1  15
   1  1 2  13
   1  1 3  16
   1  2 1  17
   1  2 2  19
   1  3 1  12
   2  1 1  20
   2  1 2  21
   2  2 1  20
   2  2 2  23
   2  2 3  19
   2  2 4  19
   3  1 1  12
   3  1 2  13
   3  1 3  14
   3  2 1  11
   3  3 1  12
   3  3 2  13
   3  3 3  15
   3  3 4  11
   3  3 5   9
   ;

/* Use the following DATA step to produce Output 5.18 through 5.22. */

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

/* Chapter 6 */

/* Use the following DATA step to produce Output 6.1 through 6.4. */

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

/* Use the following DATA step to produce Output 6.5, 6.6, and 6.10. */

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

/* Use the following DATA step to produce Output 6.7 through 6.9. */

   data cotton;
      input var spac plt boll lint;
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

/* Chapter 7 */

/* Use the following DATA step to produce Output 7.1 and 7.2. */

   data tests;
      input teach $ score1 score2;
      cards;
   JAY    69  75
   JAY    69  70
   JAY    71  73
   JAY    78  82
   JAY    79  81
   JAY    73  75
   PAT    69  70
   PAT    68  74
   PAT    75  80
   PAT    78  85
   PAT    68  68
   PAT    63  68
   PAT    72  74
   PAT    63  66
   PAT    71  76
   PAT    72  78
   PAT    71  73
   PAT    70  73
   PAT    56  59
   PAT    77  83
   ROBIN  72  79
   ROBIN  64  65
   ROBIN  74  74
   ROBIN  72  75
   ROBIN  82  84
   ROBIN  69  68
   ROBIN  76  76
   ROBIN  68  65
   ROBIN  78  79
   ROBIN  70  71
   ROBIN  60  61
   ;

/* Use the following DATA step to produce Output 7.3 and 7.4. */

   data wtgain;
      input gain1-gain4;
      cards;
   29 28 25 33
   33 30 23 31
   25 34 33 41
   18 33 29 35
   25 23 17 30
   24 32 29 22
   20 23 16 31
   28 21 18 24
   18 23 22 28
   25 28 29 30
   ;

/* Use the following DATA step to produce Output 7.5 through 7.8. */

   data cotton;
      input variety spacing plant seed lint bract;
      cards;
   213         30        3     3.1     1.7      2.0
   213         30        3     1.5     1.7      1.4
   213         30        5     3.0     1.9      1.8
   213         30        5     1.4     0.9      1.3
   213         30        6     2.3     1.7      1.5
   213         30        6     2.2     2.0      1.4
   213         30        8     0.4     0.9      1.2
   213         30        8     1.7     1.6      1.3
   213         30        9     1.8     1.2      1.0
   213         30        9     1.2     0.8      1.0
   213         40        0     2.0     1.0      1.9
   213         40        0     1.5     1.5      1.7
   213         40        1     1.8     1.1      2.1
   213         40        1     1.0     1.3      1.1
   213         40        2     1.3     1.1      1.3
   213         40        2     2.9     1.9      1.7
   213         40        3     2.8     1.2      1.3
   213         40        3     1.8     1.2      1.2
   213         40        4     3.2     1.8      2.0
   213         40        4     3.2     1.6      1.9
    37         30        1     3.2     2.6      1.4
    37         30        1     2.8     2.1      1.2
    37         30        2     3.6     2.4      1.5
    37         30        2     0.9     0.8      0.8
    37         30        3     4.0     3.1      1.8
    37         30        3     4.0     2.9      1.5
    37         30        5     3.7     2.7      1.6
    37         30        5     2.6     1.5      1.3
    37         30        8     2.8     2.2      1.2
    37         30        8     2.9     2.3      1.2
    37         40        1     4.1     2.9      2.0
    37         40        1     3.4     2.0      1.6
    37         40        3     3.7     2.3      2.0
    37         40        3     3.2     2.2      1.8
    37         40        4     3.4     2.7      1.5
    37         40        4     2.9     2.1      1.2
    37         40        5     2.5     1.4      0.8
    37         40        5     3.6     2.4      1.6
    37         40        6     3.1     2.3      1.4
    37         40        6     2.5     1.5      1.5
    ;

/* Use the following DATA step to produce Output 7.9 and 7.10. */

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

/* Chapter 8 */

/* Use the following DATA step to produce Output 8.1 through */
/* 8.3, and to produce Output 8.5 and 8.6. */

   data weights;
      input program $ s1-s7;
      cards;
   CONT  85 85 86 85 87 86 87
   CONT  80 79 79 78 78 79 78
   CONT  78 77 77 77 76 76 77
   CONT  84 84 85 84 83 84 85
   CONT  80 81 80 80 79 79 80
   CONT  76 78 77 78 78 77 74
   CONT  79 79 80 79 80 79 81
   CONT  76 76 76 75 75 74 74
   CONT  77 78 78 80 80 81 80
   CONT  79 79 79 79 77 78 79
   CONT  81 81 80 80 80 81 82
   CONT  77 76 77 78 77 77 77
   CONT  82 83 83 83 84 83 83
   CONT  84 84 83 82 81 79 78
   CONT  79 81 81 82 82 82 80
   CONT  79 79 78 77 77 78 78
   CONT  83 82 83 85 84 83 82
   CONT  78 78 79 79 78 77 77
   CONT  80 80 79 79 80 80 80
   CONT  78 79 80 81 80 79 80
   RI    79 79 79 80 80 78 80
   RI    83 83 85 85 86 87 87
   RI    81 83 82 82 83 83 82
   RI    81 81 81 82 82 83 81
   RI    80 81 82 82 82 84 86
   RI    76 76 76 76 76 76 75
   RI    81 84 83 83 85 85 85
   RI    77 78 79 79 81 82 81
   RI    84 85 87 89 88 85 86
   RI    74 75 78 78 79 78 78
   RI    76 77 77 77 77 76 76
   RI    84 84 86 85 86 86 86
   RI    79 80 79 80 80 82 82
   RI    78 78 77 76 75 75 76
   RI    78 80 77 77 75 75 75
   RI    84 85 85 85 85 83 82
   WI    84 85 84 83 83 83 84
   WI    74 75 75 76 75 76 76
   WI    83 84 82 81 83 83 82
   WI    86 87 87 87 87 87 86
   WI    82 83 84 85 84 85 86
   WI    79 80 79 79 80 79 80
   WI    79 79 79 81 81 83 83
   WI    87 89 91 90 91 92 92
   WI    81 81 81 82 82 83 83
   WI    82 82 82 84 86 85 87
   WI    79 79 80 81 81 81 81
   WI    79 80 81 82 83 82 82
   WI    83 84 84 84 84 83 83
   WI    81 81 82 84 83 82 85
   WI    78 78 79 79 78 79 79
   WI    83 82 82 84 84 83 84
   WI    80 79 79 81 80 80 80
   WI    80 82 82 82 81 81 81
   WI    85 86 87 86 86 86 86
   WI    77 78 80 81 82 82 82
   WI    80 81 80 81 81 82 83
   ;

/* Use the following DATA step to produce Output 8.4. */

   data split;
      set weights;
      array s{7} s1-s7;
      subject + 1;
      do time=1 to 7;
         strength=s{time};
        output;
      end;
      drop s1-s7;

/* Note: You must use the raw data needed for Output 8.1 through */
/* 8.3 to produce Output 8.4. */

/* Use the following DATA step to produce Output 8.7. */

   data plot;
      set new;
      array mwt(7) mwt1-mwt7;
      do time=1 to 7;
         strength=mwt(time);
         output;
      end;
      drop mwt1-mwt7;

/* Note: You must use the raw data needed for Output 8.1 through 8.3 */
/* with the PROC SUMMARY statement presented in the chapter before */
/* using this DATA step. */

/* Use the following DATA step to produce Output 8.8 and 8.9. */

   data moisture;
     input bed $ m10_am m10_pm m20_am m20_pm m40_am m40_pm
                    m50_am m50_pm;
     cards;
   LOW    12.3  13.4  13.7  15.0  16.4  15.6  16.4  17.0
   LOW    12.0  12.8  13.5  14.3  14.4  13.4  14.9  14.1
   LOW    11.7  12.2  12.2  12.7  13.3  14.1  13.6  14.0
   MED    12.2  13.4  13.2  14.0  15.5  15.4  16.7  16.4
   MED     9.6   9.9  12.0  12.9  14.3  14.0  16.2  16.9
   HIGH   16.5  15.2  17.6  18.1  21.2  21.2  22.7  22.1
   HIGH   14.3  15.2  18.7  16.8  18.9  20.1  23.0  22.5
   HIGH   12.8  12.2  14.5  16.9  17.3  18.5  19.5  19.4
   ;

/* Use the following DATA step to produce Output 8.10. */

   data one;
      set moisture;
      array m{8} m10_am--m50_pm;
      k=1;
      do depth=10,20,40,50;
         do timeday=1 to 2;
            moisture=m{k};
            k=k+1;
            output;
         end;
      end;
     keep depth bed moisture;

/* Note: You must use the raw data needed in Output 8.8 and 8.9 to */
/* produce Output 8.10. */

