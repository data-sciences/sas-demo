/*-----------------------------------------------------------------*/
/* Categorical Data Analysis Using the SAS System                  */
/* by Maura Stokes, Charles S. Davis, and Gary G. Koch             */
/*                                                                 */
/* SAS Publications order # 55320                                  */
/* ISBN 1-55544-219-6                                              */
/* Copyright 1995 by SAS Institute Inc., Cary, NC, USA             */
/*                                                                 */
/* SAS Institute does not assume responsibility for the accuracy   */
/* of any material presented in this file.                         */
/*-----------------------------------------------------------------*/

/* Chapter 1 */

/* page 10 of Categorical Data Analysis */

data respire;
   input treat $ outcome $ count ;
   cards;
   placebo f 16
   placebo u 48 
   test    f 40 
   test    u 20
   ; 
proc freq;
   weight count;
   tables treat*outcome;
run;

/* pages 11-12 of Categorical Data Analysis */

data respire;
   input treat $ outcome $ @@ ;
   cards;
placebo f placebo f  placebo f  
placebo f placebo f 
placebo u placebo u  placebo u 
placebo u placebo u  placebo u 
placebo u placebo u  placebo u 
placebo u 
test    f test    f  test    f 
test    f test    f  test    f  
test    f test    f
test    u test    u  test    u
test    u test    u  test    u
test    u test    u  test    u
test    u test    u  test    u
test    u test    u  test    u
test    u test    u  test    u
test    u test    u 
    ; 
proc freq;
    tables treat*outcome;
run;

/* page 12 of Categorical Data Analysis */

data arthrit;           
   length treat $7. sex $6. ;    
   input sex $ treat $ improve $ count @@ ;
   cards ;  
female active  marked 16 female active  some 5 female active  none  6
female placebo marked  6 female placebo some 7 female placebo none 19
male   active  marked  5 male   active  some 2 male   active  none  7
male   placebo marked  1 male   placebo some 0 male   placebo none 10
; 
run;

/* page 13 of Categorical Data Analysis */

proc freq order=data;
   weight count;
   tables treat*improve;
run; 

proc freq order=data;
   weight count;
   tables sex*treat*improve / nocol nopct;
run; 

/* Chapter 2 */

/* page 22 of Categorical Data Analysis */

data respire;
   input treat $ outcome $ count ;
   cards;
   test    f 40 
   test    u 20
   placebo f 16
   placebo u 48 
   ; 
proc freq;
   weight count;
   tables treat*outcome / chisq;
   run;

/* pages 24-25 of Categorical Data Analysis */
   
data severe;
   input treat $ outcome $ count ;
   cards;
   Test    f 10 
   Test    u 2
   Control f 2 
   Control u 4 
   ; 
proc freq order=data;
    tables treat*outcome / chisq nocol;
    weight count;
run; 

/* pages 29-30 of Categorical Data Analysis */

data stress;
   input stress $ outcome $ count ;
   cards;
 low f 48 
 low  u 12 
 high f 96 
 high u 94
   ; 
proc freq order=data;
     tables stress*outcome / chisq measures nocol nopct;
     weight count; 
run ; 

/* page 32 of Categorical Data Analysis */

data respire;
   input treat $ outcome $ count ;
   cards;
 test    yes  29 
 test    no   16 
 placebo yes  14 
 placebo no   31
   ; 
proc freq order=data;
   tables treat*outcome / measures chisq nocol nopct;
   weight count;
run ; 

/* pages 35-36 of Categorical Data Analysis */

data approval;
   input hus_resp $ wif_resp $ count ;
   cards;
   yes yes 20 
   yes no   5
   no yes  10
   no no   10 
   ; 
proc freq order=data;
   weight count;
   tables hus_resp*wif_resp / agree;
run;

/* Chapter 3 */

/* page 41 of Categorical Data Analysis */

data respire;
   input center treatmnt $ response $ count @@;
   cards;
   1 test    y 29 1 test    n 16
   1 placebo y 14 1 placebo n 31
   2 test    y 37 2 test    n  8
   2 placebo y 24 2 placebo n 21
   ; 

/* page 42 of Categorical Data Analysis */

proc freq order=data;
      weight count; 
      tables center*treatmnt*response / 
          nocol nopct chisq cmh;
run; 

/* page 46 of Categorical Data Analysis */

data stress;
   input region $ stress $ outcome $ count @@;
   cards;
 urban low  f 48 urban  low  u  12 
 urban high f 96 urban  high u  94  
 rural low  f 55 rural  low  u 135
 rural high f  7 rural  high u  53
   ; 
proc freq order=data; 
   weight count;
   tables region*stress*outcome / chisq cmh nocol nopct;
   run;

/* page 48 of Categorical Data Analysis */

data soft;
   input gender $ country $ question $ count @@;
   cards;
   male   American  y 29 male   American  n  6
   male   British   y 19 male   British   n 15
   female American  y  7 female American  n 23
   female British   y 24 female British   n 29
   ;
proc freq order=data;
   weight count; 
   tables gender*country*question / 
           chisq cmh nocol nopct;
run; 

/* pages 53-54 of Categorical Data Analysis */

data ca;
   input gender $ ECG $ disease $ count ; 
   cards; 
   female <0.1  yes   4 
   female <0.1  no   11 
   female >=0.1 yes   8    
   female >=0.1 no   10 
   male   <0.1  yes   9 
   male   <0.1  no    9 
   male   >=0.1 yes  21 
   male   >=0.1 no    6 
;
proc freq; 
  weight count; 
  tables gender*disease / nocol nopct chisq; 
  tables gender*ECG*disease / nocol nopct cmh chisq measures;  
run;

/* Chapter 4 */

/* page 62 of Categorical Data Analysis */

data arth;
   input gender $ treat $ response $ count @@;
   cards;
female test    none 6  female test    some 5  female test    marked 16
female placebo none 19 female placebo some 7  female placebo marked 6
male   test    none 7  male   test    some 2  male   test    marked 5
male   placebo none 10 male   placebo some 0  male   placebo marked 1
;
proc freq data=arth order=data;
   weight count;
   tables treat*response / chisq nocol nopct;
run;

/* page 66 of Categorical Data Analysis */

data arth;
   input gender $ treat $ response $ count @@;
   cards;
female test    none 6  female test    some 5  female test    marked 16
female placebo none 19 female placebo some 7  female placebo marked 6
male   test    none 7  male   test    some 2  male   test    marked 5
male   placebo none 10 male   placebo some 0  male   placebo marked 1
;
proc freq data=arth order=data;
   weight count;
   tables gender*treat*response / cmh nocol nopct;
run;          
            
/* page 67 of Categorical Data Analysis */

proc freq data=arth order=data;
   weight count;
   tables gender*treat*response/cmh scores=modridit nocol nopct;
run;

/* page 68 of Categorical Data Analysis */

data colds;
   input gender $ residnce $ per_cold count @@;
   cards;
female urban 0   45  female urban  1  64  female urban 2  71
female rural 0   80  female rural  1 104  female rural 2 116
male   urban 0   84  male   urban  1 124  male   urban 2  82
male   rural 0  106  male   rural  1 117  male   rural 2  87
;
proc freq data=colds order=data;
   weight count;
   tables gender*residnce*per_cold / all cmh nocol nopct;
run;

/* page 72 of Categorical Data Analysis */
          
data tobacco;
   length risk $11. ;
   input f_usage $ risk $ usage $ count @@;
   cards;
no minimal      no   59 no  minimal     yes 25
no moderate     no  169 no  moderate    yes 29
no substantial  no  196 no  substantial yes  9
yes minimal     no   11 yes minimal     yes  8
yes moderate    no   33 yes moderate    yes 11
yes substantial no   22 yes substantial yes  2
;
proc freq;
   weight count;
   tables f_usage*risk*usage /cmh chisq measures;
   tables f_usage*risk*usage /cmh scores=modridit;
run;

/* page 75 of Categorical Data Analysis */

data pain;
   input dgnosis $ treatmnt $ response $ count @@;
   cards;
   I placebo  no 26 I  placebo yes  6
   I dosage1  no 26 I  dosage1 yes  7
   I dosage2  no 23 I  dosage2 yes  9
   I dosage3  no 18 I  dosage3 yes 14
   I dosage4  no  9 I  dosage4 yes 23
   II placebo no 26 II placebo yes  6
   II dosage1 no 12 II dosage1 yes 20
   II dosage2 no 13 II dosage2 yes 20
   II dosage3 no  1 II dosage3 yes 31
   II dosage4 no  1 II dosage4 yes 31
;
proc freq order=data;
   weight count;
   tables treatmnt*response /chisq;
   tables dgnosis*treatmnt*response/
              chisq cmh;
   tables dgnosis*treatmnt*response/
              scores=modridit cmh;
run;

/* page 78 of Categorical Data Analysis */

proc freq order=data;
   weight count;
   tables dgnosis*response*treatmnt /
              cmh;
run;

/* Chapter 5 */

/* page 85 of Categorical Data Analysis */

data neighbor;
   length party $ 11 nei_hood $ 10; 
   input party $ nei_hood $ count @@;
   cards;
democrat    longview   360 democrat    bayside  221
democrat    sheffeld   140 democrat    highland 160
republican  longview   316 republican  bayside  208
republican  sheffeld    97 republican  highland 106
independent longview   160 independent bayside  200
independent sheffeld   311 independent highland 291
;
proc freq ;
   weight count;
   tables party*nei_hood / chisq cmh;
run;

/* page 88 of Categorical Data Analysis */

data pain;
   input treatmnt $ hours count @@;
   cards;
   placebo  0 6 placebo  1  9 placebo   2 6 placebo  3 3 placebo  4 1
   standard 0 1 standard 1  4 standard  2 6 standard 3 6 standard 4 8
   test     0 2 test     1  5 test      2 6 test     3 8 test     4 6
   ;
proc freq;
   weight count;
   tables treatmnt*hours/ cmh nocol nopct;
run;

/* page 90 of Categorical Data Analysis */

data wash;
   input treatmnt $ washblty $ count @@;
   cards;
   water low 27 water medium 14 water high 5
   standard low 10 standard medium 17 standard high 26
   super low 5 super medium 12 super high 50
   ;
proc freq order=data;
   weight count;
   tables treatmnt*washblty / chisq cmh;
   tables treatmnt*washblty / scores=modridit cmh noprint;
run;

/* page 93 of Categorical Data Analysis */

data market;
   length ad_sourc $ 9. ;
   input car $ ad_sourc $ count @@;
   cards;
   sporty  paper 3 sporty  radio 4 sporty  tv 0 sporty  magazine 3
   sedan   paper 0 sedan   radio 2 sedan   tv 4 sedan   magazine 0
   utility paper 2 utility radio 2 utility tv 5 utility magazine 5
   ;
proc freq;
   weight count;
   table car*ad_sourc / exact norow nocol nopct;
run;

/* page 96 of Categorical Data Analysis */

data wash;
   input treatmnt $ washblty $ count @@; 
   cards;
   water    low 27 water    medium 14 water    high  5
   standard low 10 standard medium 17 standard high 26
   super    low  5 super    medium 12 super    high 50
   ;
proc freq order=data;
   weight count;
   tables treatmnt*washblty / measures noprint;
   tables treatmnt*washblty / measures scores=rank noprint;
run;

/* pages 97-98 of Categorical Data Analysis */

data neighbor;
   length party $ 11 nei_hood $ 10;
   input party $ nei_hood $ count @@;
   cards;
democrat    longview   360 democrat    bayside  221
democrat    sheffeld   140 democrat    highland 160
republican  longview   316 republican  bayside  208
republican  sheffeld    97 republican  highland 106
independent longview   160 independent bayside  200
independent sheffeld   311 independent highland 291
;
proc freq ;
   weight count;
   tables party*nei_hood / chisq measures;
run;

/* page 100 of Categorical Data Analysis */

data classify;
   input no_rater w_rater count @@;
   cards;
   1 1 38 1 2  5 1 3 0 1 4  1
   2 1 33 2 2 11 2 3 3 2 4  0
   3 1 10 3 2 14 3 3 5 3 4  6
   4 1  3 4 2  7 4 3 3 4 4 10
   ;
proc freq;
   weight count;
   tables no_rater*w_rater / agree ;
run;

/* Chapter 6 */

/* pages 111-112 of Categorical Data Analysis */

data operate;
   input hospital trt $ severity $ wt @@;
   cards;
1 v+d none 23    1 v+d slight  7    1 v+d moderate 2
1 v+a none 23    1 v+a slight 10    1 v+a moderate 5
1 v+h none 20    1 v+h slight 13    1 v+h moderate 5
1 gre none 24    1 gre slight 10    1 gre moderate 6
2 v+d none 18    2 v+d slight  6    2 v+d moderate 1
2 v+a none 18    2 v+a slight  6    2 v+a moderate 2
2 v+h none 13    2 v+h slight 13    2 v+h moderate 2
2 gre none  9    2 gre slight 15    2 gre moderate 2
3 v+d none  8    3 v+d slight  6    3 v+d moderate 3
3 v+a none 12    3 v+a slight  4    3 v+a moderate 4
3 v+h none 11    3 v+h slight  6    3 v+h moderate 2
3 gre none  7    3 gre slight  7    3 gre moderate 4
4 v+d none 12    4 v+d slight  9    4 v+d moderate 1
4 v+a none 15    4 v+a slight  3    4 v+a moderate 2
4 v+h none 14    4 v+h slight  8    4 v+h moderate 3
4 gre none 13    4 gre slight  6    4 gre moderate 4
;
proc freq order=data;
   weight wt;
   tables hospital*trt*severity / cmh;
   tables hospital*trt*severity / cmh scores=modridit;
run;

/* pages 113-114 of Categorical Data Analysis */

data shoulder;
   input area $ location $ size $ usage $ count @@;
   cards;
   coast    urban large  no 174 coast    urban large  yes 69 
   coast    urban medium no 134 coast    urban medium yes 56 
   coast    urban small  no 150 coast    urban small  yes 54 
   coast    rural large  no  52 coast    rural large  yes 14 
   coast    rural medium no  31 coast    rural medium yes 14 
   coast    rural small  no  25 coast    rural small  yes 17 
   piedmont urban large  no 127 piedmont urban large  yes 62 
   piedmont urban medium no  94 piedmont urban medium yes 63 
   piedmont urban small  no 112 piedmont urban small  yes 93 
   piedmont rural large  no  35 piedmont rural large  yes 29 
   piedmont rural medium no  32 piedmont rural medium yes 30 
   piedmont rural small  no  46 piedmont rural small  yes 34 
   mountain urban large  no 111 mountain urban large  yes 26 
   mountain urban medium no 120 mountain urban medium yes 47 
   mountain urban small  no 145 mountain urban small  yes 68 
   mountain rural large  no  62 mountain rural large  yes 31 
   mountain rural medium no  44 mountain rural medium yes 32 
   mountain rural small  no  85 mountain rural small  yes 43 
   ;
proc freq;
   weight count;
   tables size*usage / chisq;
   tables area*location*size*usage / cmh scores=modridit;
   tables area*size*usage / noprint cmh scores=modridit; 
   tables location*size*usage / noprint scores=modridit cmh;
run;

/* page 117 of Categorical Data Analysis */

data school;
   input school program $ style $ count @@; 
   cards;
   1 regular  self 10  1 regular  team 17 1 regular class   26
   1 after    self  5  1 after    team 12 1 after   class   50 
   2 regular  self 21  2 regular  team 17 2 regular class   26
   2 after    self 16  2 after    team 12 2 after   class   36 
   3 regular  self 15  3 regular  team 15 3 regular class   16
   3 after    self 12  3 after    team 12 3 after   class   20 
   ; 
proc freq; 
   weight count;
   tables school*program*style / cmh chisq measures;
run;   

/* pages 124-125 of Categorical Data Analysis */

data pump;
   input subject time $ response $ @@;
   cards; 
 1 before no   1 after no   2 before no   2 after no 
 3 before no   3 after no   4 before no   4 after no 
 5 before no   5 after no   6 before no   6 after no  
 7 before no   7 after no   8 before no   8 after no 
 9 before no   9 after no  10 before no  10 after no
11 before no  11 after no  12 before no  12 after no  
13 before no  13 after no  14 before no  14 after no
15 before no  15 after no  16 before no  16 after no
17 before no  17 after no  18 before no  18 after no  
19 before no  19 after no  20 before no  20 after no
21 before no  21 after no  22 before no  22 after no
23 before no  23 after no  24 before no  24 after no  
25 before no  25 after no  26 before no  26 after no
27 before no  27 after no  28 before no  28 after no 
29 before no  29 after no  30 before no  30 after no  
31 before no  31 after no  32 before no  32 after no
33 before no  33 after no  34 before no  34 after no
35 before no  35 after no  36 before no  36 after no
37 before no  37 after no  38 before no  38 after no
39 before no  39 after no  40 before no  40 after no
41 before no  41 after no  42 before no  42 after no  
43 before no  43 after no  44 before no  44 after no
45 before no  45 after no  46 before no  46 after no
47 before no  47 after no  48 before no  48 after no  
49 before no  49 after yes 50 before no  50 after yes
51 before no  51 after yes 52 before no  52 after yes
53 before no  53 after yes 54 before no  54 after yes 
55 before no  55 after yes 56 before no  56 after yes
57 before no  57 after yes 58 before no  58 after yes
59 before no  59 after yes 60 before no  60 after yes 
61 before no  61 after yes 62 before no  62 after yes
63 before no  63 after yes 64 before yes 64 after no
65 before yes 65 after no  66 before yes 66 after no 
67 before yes 67 after no  68 before yes 68 after no 
69 before yes 69 after yes 70 before yes 70 after yes
71 before yes 71 after yes 72 before yes 72 after yes
73 before yes 73 after yes 74 before yes 74 after yes 
75 before yes 75 after yes 76 before yes 76 after yes
77 before yes 77 after yes 78 before yes 78 after yes
79 before yes 79 after yes 80 before yes 80 after yes 
81 before yes 81 after yes 82 before yes 82 after yes
83 before yes 83 after yes 84 before yes 84 after yes
85 before yes 85 after yes 86 before yes 86 after yes 
87 before yes 87 after yes 
;

proc freq;
   tables subject*time*response/ noprint cmh out=freqtab;
run;

data shoes;
   input before $ after $ count ;
   cards;
   yes yes 19 
   yes no  5
   no yes  15
   no no   48 
   ; 
proc freq;
   weight count;
   tables before*after / agree;
run;

/* pages 127-128 of Categorical Data Analysis */

data drug;
   input druga $ drugb $ drugc $ count;
   cards;
F F F  6
F F U 16
F U F  2
F U U  4
U F F  2
U F U  4
U U F  6
U U U  6
;
data drug2; set drug;
   keep patient drug response;
   retain patient 0;
   do i=1 to count;
   patient=patient+1;
   drug='A';  response=druga;  output;
   drug='B';  response=drugb;  output;
   drug='C';  response=drugc;  output;
   end;
proc freq;
   tables patient*drug*response / noprint cmh;
run;

/* pages 130-131 of Categorical Data Analysis */

data cold;
   keep id day drainage;
   input id day1-day4;
   day=1; drainage=day1; output;
   day=2; drainage=day2; output;
   day=3; drainage=day3; output;
   day=4; drainage=day4; output;
   cards;
 1 1 1 2 2
 2 0 0 0 0
 3 1 1 1 1
 4 1 1 1 1
 5 0 2 2 0
 6 2 0 0 0
 7 2 2 1 2
 8 1 1 1 0
 9 3 2 1 1
10 2 2 2 3
11 1 0 1 1
12 2 3 2 2
13 1 3 2 1
14 2 1 1 1
15 2 3 3 3
16 2 1 1 1
17 1 1 1 1
18 2 2 2 2
19 3 1 1 1
20 1 1 2 1
21 2 1 1 2
22 2 2 2 2
23 1 1 1 1
24 2 2 3 1
25 2 0 0 0
26 1 1 1 1
27 0 1 1 0
28 1 1 1 1
29 1 1 1 0
30 3 3 3 3
;
proc freq;
   tables id*day*drainage / cmh noprint;
   tables id*day*drainage / cmh noprint scores=rank;
run;

/* page 134 of Categorical Data Analysis */

data animals;
   keep id pulse severity;
   input id sev2 sev4 sev6 sev8 sev10;
   pulse=2;  severity=sev2;  output;
   pulse=4;  severity=sev4;  output;
   pulse=6;  severity=sev6;  output;
   pulse=8;  severity=sev8;  output;
   pulse=10; severity=sev10; output;
   cards;
 6 0 0 5 0 3
 7 0 3 3 4 5
 8 0 3 4 3 2
 9 2 2 3 0 4
10 0 0 4 4 3
12 0 0 0 4 4
13 0 4 4 4 0
15 0 4 0 0 0
16 0 3 0 1 1
17 . . 0 1 0
19 0 0 1 1 0
20 . 0 0 2 2
21 0 0 2 3 3
22 . 0 0 3 0
;
proc freq;
   tables id*pulse*severity / noprint cmh;
   tables id*pulse*severity / noprint cmh2 scores=rank;
   tables id*pulse*severity / noprint cmh2 scores=ridit;
   tables id*pulse*severity / noprint cmh2 scores=modridit;
run;

/* page 137 of Categorical Data Analysis */

proc freq data=animals;
   where id notin(17,20,22);
   tables id*pulse*severity / noprint cmh;
   tables id*pulse*severity / noprint cmh scores=rank;
run;

/* page 139 of Categorical Data Analysis */

data ph_vmax;
   keep subject ph vmax;
   input subject vmax1-vmax4;
   ph=6.5;  vmax=vmax1;  output;
   ph=6.9;  vmax=vmax2;  output;
   ph=7.4;  vmax=vmax3;  output;
   ph=7.9;  vmax=vmax4;  output;
   cards;
 1  .  284 310 326
 2  .   .  261 292
 3  .  213 224 240
 4  .  222 235 247
 5  .   .  270 286
 6  .   .  210 218
 7  .  216 234 237
 8  .  236 273 283
 9 220 249 270 281
10 166 218 244  . 
11 227 258 282 286
12 216  .  284  . 
13  .   .  257 284
14 204 234 268  . 
15  .   .  258 267
16  .  193 224 235
17 185 222 252 263
18  .  238 301 300
19  .  198 240  . 
20  .  235 255  . 
21  .  216 238  . 
22  .  197 212 219
23  .  234 238  . 
24  .   .  295 281
25  .   .  261 272
 ;
proc freq;
   tables subject*ph*vmax / noprint cmh2;
   tables subject*ph*vmax / noprint cmh2 scores=modridit;
run;

/* Chapter 7 */

/* page 145 of Categorical Data Analysis */

data sodium;
   input group $ subject intake;
   cards;
Normal    1  10.2
Normal    2   2.2
Normal    3   0.0
Normal    4   2.6
Normal    5   0.0
Normal    6  43.1
Normal    7  45.8
Normal    8  63.6
Normal    9   1.8
Normal   10   0.0
Normal   11   3.7
Normal   12   0.0
Hyperten  1  92.8
Hyperten  2  54.8
Hyperten  3  51.6
Hyperten  4  61.7
Hyperten  5 250.8
Hyperten  6  84.5
Hyperten  7  34.7
Hyperten  8  62.2
Hyperten  9  11.0
Hyperten 10  39.1
;
proc freq; 
   tables group*intake / noprint cmh2 scores=rank;
run;  

/* page 146 of Categorical Data Analysis */

proc freq;
   tables group*intake / noprint chisq scores=rank;
run;  

proc npar1way wilcoxon; 
   class group;
   var intake;
run;

/* pages 148-149 of Categorical Data Analysis */

data cortisol;
   input group $ subject cortisol;
   cards;
I    1  262
I    2  307
I    3  211
I    4  323
I    5  454
I    6  339
I    7  304
I    8  154
I    9  287
I   10  356
II   1  465
II   2  501
II   3  455
II   4  355
II   5  468
II   6  362
III  1  343
III  2  772
III  3  207
III  4 1048
III  5  838
III  6  687
;
proc freq;
   tables group*cortisol / noprint cmh2 scores=rank;
run;

proc npar1way wilcoxon;
   class group; 
   var cortisol;
run;

/* pages 151-152 of Categorical Data Analysis */

data electrod;
   input subject resist1-resist5;
   type=1;  resist=resist1;  output;
   type=2;  resist=resist2;  output;
   type=3;  resist=resist3;  output;
   type=4;  resist=resist4;  output;
   type=5;  resist=resist5;  output;
   cards;
 1  500  400   98  200  250
 2  660  600  600   75  310
 3  250  370  220  250  220
 4   72  140  240   33   54
 5  135  300  450  430   70
 6   27   84  135  190  180
 7  100   50   82   73   78
 8  105  180   32   58   32
 9   90  180  220   34   64
10  200  290  320  280  135
11   15   45   75   88   80
12  160  200  300  300  220
13  250  400   50   50   92
14  170  310  230   20  150
15   66 1000 1050  280  220
16  107   48   26   45   51
;
proc freq;
   tables subject*type*resist / noprint cmh2 scores=rank;
run;

/* page 153 of Categorical Data Analysis */

proc standard mean=0;
   by subject;
   var resist;
proc rank;
   var resist;
proc freq; 
   tables subject*type*resist / noprint cmh2;
run;

/* page 155 of Categorical Data Analysis */

data tracing;
   keep subject angle time;
   input subject angle1 angle2 time1 time2;
   angle=angle1;  time=time1;  output;
   angle=angle2;  time=time2;  output;
   cards;
 1  0.0 22.5   7  15
 2  0.0 45.0  20  72
 3  0.0 67.5   8  26
 4  0.0 90.0  33  36
 5 22.5  0.0  16   7
 6 22.5 45.0  68  67
 7 22.5 67.5  33  64
 8 22.5 90.0  34  12
 9 45.0  0.0  96  10
10 45.0 22.5  59  29
11 45.0 67.5  17   9
12 45.0 90.0 100  15
13 67.5  0.0  32  16
14 67.5 22.5  32  19
15 67.5 45.0  39  36
16 67.5 90.0  44  54
17 90.0  0.0  38  16
18 90.0 22.5  12  17
19 90.0 45.0  11  37
20 90.0 67.5   6  56
;
proc freq;
   tables subject*angle*time / noprint cmh2 scores=rank;
run;

/* pages 157-158 of Categorical Data Analysis */

data exercise;
   input sex $ case duration vo2max @@;
   cards;
 M  1 706 41.5    M  2 732 45.9    M  3 930 54.5    M  4 900 60.3
 M  5 903 60.5    M  6 976 64.6    M  7 819 47.4    M  8 922 57.0
 M  9 600 40.2    M 10 540 35.2    M 11 560 33.8    M 12 637 38.8
 M 13 593 38.9    M 14 719 49.5    M 15 615 37.1    M 16 589 32.2
 M 17 478 31.3    M 18 620 33.8    M 19 710 43.7    M 20 600 41.7
 M 21 660 41.0    M 22 644 45.9    M 23 582 35.8    M 24 503 29.1
 M 25 747 47.2    M 26 600 30.0    M 27 491 34.1    M 28 694 38.1
 M 29 586 28.7    M 30 612 37.1    M 31 610 34.5    M 32 539 34.4
 M 33 559 35.1    M 34 653 40.9    M 35 733 45.4    M 36 596 36.9
 M 37 580 41.6    M 38 550 22.7    M 39 497 31.9    M 40 605 42.5
 M 41 552 37.4    M 42 640 48.2    M 43 500 33.6    M 44 603 45.0
 F  1 660 38.1    F  2 628 38.4    F  3 637 41.7    F  4 575 33.5
 F  5 590 28.6    F  6 600 23.9    F  7 562 29.6    F  8 495 27.3
 F  9 540 33.2    F 10 470 26.6    F 11 408 23.6    F 12 387 23.1
 F 13 564 36.6    F 14 603 35.8    F 15 420 28.0    F 16 573 33.8
 F 17 602 33.6    F 18 430 21.0    F 19 508 31.2    F 20 565 31.2
 F 21 464 23.7    F 22 495 24.5    F 23 461 30.5    F 24 540 25.9
 F 25 588 32.7    F 26 498 26.9    F 27 483 24.6    F 28 554 28.8
 F 29 521 25.9    F 30 436 24.4    F 31 398 26.3    F 32 366 23.2
 F 33 439 24.6    F 34 549 28.8    F 35 360 19.6    F 36 566 31.4
 F 37 407 26.6    F 38 602 30.6    F 39 488 27.5    F 40 526 30.9
 F 41 524 33.9    F 42 562 32.3    F 43 496 26.9
;
run;

proc rank out=ranks;
   var duration vo2max;
run; 

proc reg noprint;
   model vo2max=duration;
   output out=residual r=resid;
run;

proc freq;
   tables sex*resid / noprint cmh2;
run;

/* pages 159-160 of Categorical Data Analysis */

data caries;
   input center id group $ before after @@;
   cards;
 1  1 W    7 11    1  2 W   20 24    1  3 W   21 25    1  4 W    1  2
 1  5 W    3  7    1  6 W   20 23    1  7 W    9 13    1  8 W    2  4
 1  9 SF  11 13    1 10 SF  15 18    1 11 APF  7 10    1 12 APF 17 17
 1 13 APF  9 11    1 14 APF  1  5    1 15 APF  3  7    2  1 W   10 14
 2  2 W   13 17    2  3 W    3  4    2  4 W    4  7    2  5 W    4  9
 2  6 SF  15 18    2  7 SF   6  8    2  8 SF   4  6    2  9 SF  18 19
 2 10 SF  11 12    2 11 SF   9  9    2 12 SF   4  7    2 13 SF   5  7
 2 14 SF  11 14    2 15 SF   4  6    2 16 APF  4  4    2 17 APF  7  7
 2 18 APF  0  4    2 19 APF  3  3    2 20 APF  0  1    2 21 APF  8  8
 3  1 W    2  4    3  2 W   13 18    3  3 W    9 12    3  4 W   15 18
 3  5 W   13 17    3  6 W    2  5    3  7 W    9 12    3  8 SF   4  6
 3  9 SF  10 14    3 10 SF   7 11    3 11 SF  14 15    3 12 SF   7 10
 3 13 SF   3  6    3 14 SF   9 12    3 15 SF   8 10    3 16 SF  19 19
 3 17 SF  10 13    3 18 APF 10 12    3 19 APF  7 11    3 20 APF 13 12
 3 21 APF  5  8    3 22 APF  1  3    3 23 APF  8  9    3 24 APF  4  5
 3 25 APF  4  7    3 26 APF 14 14    3 27 APF  8 10    3 28 APF  3  5
 3 29 APF 11 12    3 30 APF 16 18    3 31 APF  8  8    3 32 APF  0  1
 3 33 APF  3  4
;
run;

proc rank nplus1 ties=mean out=ranks;
   by center; 
   var before after;
run;

proc reg noprint; 
   by center;
   model after=before;
   output out=residual r=resid;
run;

proc freq;
   tables center*group*resid / noprint cmh2;
run;

/* Chapter 8 */

/* page 170 of Categorical Data Analysis */

data coronary;
   input sex ecg ca count @@;
   sexecg=sex*ecg;
   cards;
   0 0 0  11 0 0 1  4
   0 1 0  10 0 1 1  8
   1 0 0   9 1 0 1  9
   1 1 0   6 1 1 1 21
   ;
run; 

/* page 171 of Categorical Data Analysis */

proc logistic descending;
   freq count;
   model ca=sex ecg / scale=none aggregate;
run;

/* page 174 of Categorical Data Analysis */

proc logistic descending;
   freq count;
   model ca=sex ecg / risklimits;
   output out= predict pred=prob;
run;
proc print data=predict;
run;

/* page 175 of Categorical Data Analysis */

proc logistic descending;
   freq count;
   model ca=sex ecg sexecg;
run;

/* page 178 of Categorical Data Analysis */

data sentence;
   input type $ prior $ sentence $ count @@;
   iprior=(prior='some');
   itype=(type= 'nrb');
   itypepri=itype*iprior;
   cards;
   nrb   some  y  42 nrb   some  n 109
   nrb   none  y  17 nrb   none  n  75
   other some  y  33 other some  n 175
   other none  y  53 other none  n 359
  ;
run;

/* page 179 of Categorical Data Analysis */

proc logistic descending;
   freq count;
   model sentence = itype iprior / scale=none aggregate;
run;

/* page 181 of Categorical Data Analysis */

proc logistic  descending;
   freq count;
   model sentence = itype / scale=none aggregate=(itype iprior);
run;

/* page 183 of Categorical Data Analysis */

data uti;
   input diagnoss : $13. treat $ response $ count @@;
   idiag=(diagnoss='complicated');
   iatreat=(treat='A');
   ibtreat=(treat='B');
   iacomp=idiag*iatreat;
   ibcomp=idiag*ibtreat;
cards;
complicated    A  cured 78  complicated   A not 28
complicated    B  cured 101 complicated   B not 11
complicated    C  cured 68  complicated   C not 46
uncomplicated  A  cured 40  uncomplicated A not 5
uncomplicated  B  cured 54  uncomplicated B not 5
uncomplicated  C  cured 34  uncomplicated C not 6
;
run;

/* page 184 of Categorical Data Analysis */

proc logistic;
   freq count;
   model response = idiag iatreat ibtreat iacomp ibcomp;
run;
proc logistic;
   freq count;
   model response = idiag iatreat ibtreat / scale=none
   aggregate risklimits;
run;

/* page 187 of Categorical Data Analysis */

proc logistic;
   freq count;
   model response = idiag iatreat ibtreat /
      scale=none aggregate risklimits plcl plrl;
run;

/* page 188 of Categorical Data Analysis */

proc logistic;
   freq count;
   model response = idiag iatreat ibtreat;
   test1: test iatreat = ibtreat;
   test2: test iatreat = 0;
   test3: test iatreat = ibtreat = 0;
run;

/* pages 189-190 of Categorical Data Analysis */

data coronary;
  input sex ecg age ca @@  ;
   ecg2=ecg*ecg ; age2=age*age ;
  sexecg=sex*ecg; sexage=sex*age; ecgage=ecg*age ; 
  cards;
  0 0 28 0   1 0 42 1    0 1 46 0  1 1 45 0
  0 0 34 0   1 0 44 1    0 1 48 1  1 1 45 1
  0 0 38 0   1 0 45 0    0 1 49 0  1 1 45 1
  0 0 41 1   1 0 46 0    0 1 49 0  1 1 46 1
  0 0 44 0   1 0 48 0    0 1 52 0  1 1 48 1
  0 0 45 1   1 0 50 0    0 1 53 1  1 1 57 1
  0 0 46 0   1 0 52 1    0 1 54 1  1 1 57 1
  0 0 47 0   1 0 52 1    0 1 55 0  1 1 59 1
  0 0 50 0   1 0 54 0    0 1 57 1  1 1 60 1
  0 0 51 0   1 0 55 0    0 2 46 1  1 1 63 1
  0 0 51 0   1 0 59 1    0 2 48 0  1 2 35 0
  0 0 53 0   1 0 59 1    0 2 57 1  1 2 37 1
  0 0 55 1   1 1 32 0    0 2 60 1  1 2 43 1
  0 0 59 0   1 1 37 0    1 0 30 0  1 2 47 1
  0 0 60 1   1 1 38 1    1 0 34 0  1 2 48 1
  0 1 32 1   1 1 38 1    1 0 36 1  1 2 49 0
  0 1 33 0   1 1 42 1    1 0 38 1  1 2 58 1
  0 1 35 0   1 1 43 0    1 0 39 0  1 2 59 1
  0 1 39 0   1 1 43 1    1 0 42 0  1 2 60 1
  0 1 40 0   1 1 44 1
  ;

/* page 191 of Categorical Data Analysis */

proc logistic descending ; 
   model ca=sex ecg age 
            ecg2 age2 
            sexecg sexage ecgage / 
            selection=forward include=3 details lackfit; 
run ;  

/* page 194 of Categorical Data Analysis */

proc logistic descending ; 
   model ca=sex ecg age;
   units age=10;
   run; 

/* page 196 of Categorical Data Analysis */

data uti;
   input diagnoss : $13. treat $ response trials;
   idiag=(diagnoss='complicated');
   iatreat=(treat='A');
   ibtreat=(treat='B');
   iacomp=idiag*iatreat;
   ibcomp=idiag*ibtreat;
cards;
complicated    A   78   106
complicated    B   101  112
complicated    C   68   114
uncomplicated  A   40    45
uncomplicated  B   54    59
uncomplicated  C   34    40
;
proc logistic;
   model response/trials = idiag iatreat ibtreat /
   influence;
run;

/* page 197 of Categorical Data Analysis */

proc logistic;
   model response/trials = idiag /
    scale=none aggregate=(iatreat ibtreat idiag) influence iplots;
run;

/* pages 201-202 of Categorical Data Analysis */

data quasi;
   input treatA treatB response count @@;
   cards;
   0 0 0 0  0 0 1  0
   0 1 0 2  0 1 1  0
   1 0 0 0  1 0 1  8
   1 1 0 6  1 1 1 21
   ;
proc logistic;
   freq count;
   model response= TreatA TreatB;
run;

data complete;
   input gender region count response @@;
   cards;
   0 0 0  1  0 0 5   0
   0 1 1  1  0 1 0   0
   1 0 0  1  1 0 175 0
   1 1 53 1  1 1 0   0
   ;
proc logistic;
   freq count;
   model response = gender region;
run;

/* page 203 of Categorical Data Analysis */

data liver;
   input time $ group $ status $ count @@;
   dtime=(time='delayed');
   ltime=(time='late');
   agroup=(group='antidote');
cards;
early   antidote severe 6 early   antidote not 12
early   control  severe 6 early   control  not  2
delayed antidote severe 3 delayed antidote not 4
delayed control  severe 3 delayed control  not 0
late    antidote severe 5 late    antidote not 1
late    control  severe 6 late    control  not 0
;
run;
proc logistic descending;
   freq count;
   model status = dtime ltime agroup / scale=none aggregate;
run;

/* page 205 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   model sentence = type prior;
run;

/* page 209 of Categorical Data Analysis */

data uti2;
   input diagnoss : $13. treat $ events trials;
cards;
complicated    A   78   106
complicated    B  101   112
complicated    C   68   114
uncomplicated  A   40   45
uncomplicated  B   54   59
uncomplicated  C   34   40
;
run;

proc genmod;
   class diagnoss treat;
   model events/trials = diagnoss treat /
   link=logit dist=binomial type3;
run;

/* page 212 of Categorical Data Analysis */

proc genmod;
   class diagnoss treat;
   model events/trials = diagnoss treat /
   link=logit dist=binomial;
   contrast 'treatment' treat 1 0 -1 ,
                        treat 0 1 -1;
   contrast 'A-B' treat 1 -1  0;
   contrast 'A-C' treat 1  0 -1;
run;

/* Chapter 9 */

/* page 221 of Categorical Data Analysis */

data arthrit;           
   length treat $7. sex $6.;   
   input sex $ treat $ improve $ count @@;
   _treat_ = (treat ='active'); 
   _sex_   = (sex = 'female');  
   sextrt  = _sex_*_treat_; 
   cards;  
female active  marked 16 female active  some 5 female active  none  6
female placebo marked  6 female placebo some 7 female placebo none 19
male   active  marked  5 male   active  some 2 male   active  none  7
male   placebo marked  1 male   placebo some 0 male   placebo none 10
;
run;

/* page 222 of Categorical Data Analysis  */

proc logistic order=data;
   freq count;  
   model  improve = _sex_  _treat_ /scale=none aggregate;
run;   

/* page 224 of Categorical Data Analysis */

proc logistic order=data;
   freq count;
   model  improve = _sex_  _treat_  sextrt / 
                    selection=forward start=2;
run;  

/* pages 227-228 of Categorical Data Analysis */

data respire;
   input air $ exposure $ smoking $ level count @@;
   iair=(air='high');
   iexp=(exposure='yes');
   ismkex=(smoking='ex');
   ismkcur=(smoking='cur');
   iairexp=iair*iexp;
   iairex=iair*ismkex;
   iaircur=iair*ismkcur;
   iexpex=iexp*ismkex;
   iexpcur=iexp*ismkcur;
   cards;  
   low no non   1 158 low  no  non 2   9    
   low no ex    1 167 low  no  ex  2  19   
   low no cur   1 307 low  no  cur 2 102  
   low yes non  1  26 low  yes non 2   5    
   low yes ex   1  38 low  yes ex  2  12   
   low yes cur  1  94 low  yes cur 2  48   
   high no non  1  94 high no  non  2  7    
   high no ex   1  67 high no  ex   2  8   
   high no cur  1 184 high no  cur  2 65  
   high yes non 1  32 high yes non 2   3    
   high yes ex  1  39 high yes ex  2  11   
   high yes cur 1  77 high yes cur 2  48  
   low  no  non 3  5  low  no non  4  0
   low  no  ex  3  5  low  no ex   4  3
   low  no  cur 3 83  low  no cur  4 68
   low  yes non 3  5  low  yes non 4  1
   low  yes ex  3  4  low  yes ex  4  4
   low  yes cur 3 46  low  yes cur 4 60
   high no  non 3  5  high no  non 4  1
   high no  ex  3  4  high no  ex  4  3
   high no  cur 3 33  high no  cur 4 36
   high yes non 3  6  high yes non 4  1
   high yes ex  3  4  high yes ex  4  2
   high yes cur 3 39  high yes cur 4 51
   ;
run;

proc logistic descending;
   freq count;
   model level = iair iexp ismkex ismkcur 
         iairexp iairex iaircur iexpex iexpcur / 
         selection=forward include=4 scale=none 
         aggregate=(iair iexp ismkex ismkcur);
run;       

/* page 230 of Categorical Data Analysis */

proc logistic data=respire descending;
   freq count;
   model level = iair iexp ismkex ismkcur; 
   smoking: test ismkex=ismkcur=0;
run;     

/* pages 232-233 of Categorical Data Analysis */

proc logistic data=respire descending outest=estimate
              (drop= _link_ _lnlike_) covout;
     freq count;
     model level = iair iexp ismkex ismkcur; 
run;     

proc iml;
    title 'Wald tests';
    use estimate;
    read all into beta where (_type_='PARMS');
    read all into cov  where (_type_='COV');
    start waldtest (L,beta,cov,label);
       DF=nrow(L);
       wald=(L*beta`)`*inv(L*cov*L`)*(L*beta`);
       prob=1-probchi(wald,DF); 
       print label wald[format=8.4] DF prob [format=6.4]; 
    finish;
L1 ={ 0 0 0 0 0 1 0 , 0 0 0 0 0 0 1};  
label1={'smoking              '};
L2 ={ 0 0 0 0 0 1 -1};
label2={'current vs. predicted'};
L3 ={0 0 0 1 0 0 0 };
label3={'exposure             '};      
reset noname;
run waldtest(L1,beta,cov,label1);
run waldtest(L2,beta,cov,label2);
run waldtest(L3,beta,cov,label3);

/* page 235 of Categorical Data Analysis */

data school;
   input school program $ style $ count @@; 
   cards;
   1 regular  self 10  1 regular  team 17 1 regular class   26
   1 after    self  5  1 after    team 12 1 after   class   50 
   2 regular  self 21  2 regular  team 17 2 regular class   26
   2 after    self 16  2 after    team 12 2 after   class   36 
   3 regular  self 15  3 regular  team 15 3 regular class   16
   3 after    self 12  3 after    team 12 3 after   class   20 
   ; 
proc catmod order=data;
   weight count;
   model style=school program school*program;
run;   

/* page 237 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   model style=school program;
run;   

/* pages 241-242 of Categorical Data Analysis */

data survey;
   input age sex race poverty function $ count @@;
   cards;
1 0 0 0 major 5.361   1 0 0 0 other   1.329   1 0 0 0 not 102.228
1 0 0 1 major 20.565  1 0 0 1 other   13.952  1 0 0 1 not  336.160  
1 0 0 2 major 21.299  1 0 0 2 other    5.884  1 0 0 2 not  284.931
1 0 1 0 major 53.314  1 0 1 0 other  16.402   1 0 1 0 not 827.900 
1 0 1 1 major 102.076 1 0 1 1 other  36.551   1 0 1 1 not 1518.796
1 0 1 2 major 52.338  1 0 1 2 other  21.105   1 0 1 2 not 666.909  
1 1 0 0 major 1.172   1 1 0 0 other   1.199   1 1 0 0 not  87.292
1 1 0 1 major 11.169  1 1 0 1 other   2.945   1 1 0 1 not 304.234   
1 1 0 2 major 15.286  1 1 0 2 other   3.665   1 1 0 2 not 302.511
1 1 1 0 major 21.882  1 1 1 0 other  16.979   1 1 1 0 not 846.270  
1 1 1 1 major 52.354  1 1 1 1 other  33.106   1 1 1 1 not 1452.895
1 1 1 2 major 28.203  1 1 1 2 other  11.455   1 1 1 2 not 687.109  
2 0 0 0 major .915    2 0 0 0 other   1.711   2 0 0 0 not  91.071
2 0 0 1 major 12.591  2 0 0 1 other   8.026   2 0 0 1 not 326.930  
2 0 0 2 major 21.059  2 0 0 2 other   6.993   2 0 0 2 not 313.633
2 0 1 0 major 36.384  2 0 1 0 other  27.558   2 0 1 0 not 888.833    
2 0 1 1 major 85.974  2 0 1 1 other  42.755   2 0 1 1 not 1509.87 
2 0 1 2 major 40.112  2 0 1 2 other  23.493   2 0 1 2 not 725.004  
2 1 0 0 major 5.876   2 1 0 0 other   2.550   2 1 0 0 not 115.968
2 1 0 1 major  8.772  2 1 0 1 other   6.922   2 1 0 1 not 344.076    
2 1 0 2 major 17.385  2 1 0 2 other   2.354   2 1 0 2 not 286.68
2 1 1 0 major 42.741  2 1 1 0 other  31.025   2 1 1 0 not 817.478  
2 1 1 1 major 72.688  2 1 1 1 other  35.979   2 1 1 1 not 1499.816
2 1 1 2 major 26.296  2 1 1 2 other  29.321   2 1 1 2 not 716.860   
;
run;

proc catmod order=data;
   direct poverty;
   weight count;
   model function=age|sex|race|poverty@2;
run;

/* pages 243-244 of Categorical Data Analysis */

proc catmod order=data;
   direct poverty;
   weight count;
   model function=age sex race poverty 
      age*sex sex*race race*poverty;
run;

proc catmod order=data;
   direct poverty;
   weight count;
   model function=age sex race poverty 
      age*sex race*poverty /pred=freq;
run;

/* Chapter 10 */

/* pages 252-254 of Categorical Data Analysis */

data trial;
   drop center1 i_sex1 age1 initial1 improve1 trtsex1 trtinit1
        trtage1 isexage1 isexint1 iageint1;  
   retain center1 i_sex1 age1 initial1 improve1 trtsex1 trtinit1
         trtage1 isexage1 isexint1 iageint1 0;
   input center treat $ sex $ age improve initial @@;
   /* compute model terms for each observation */
   i_sex=(sex='m');       i_trt=(treat='t');
   trtsex=i_sex*i_trt;    trtinit=i_trt*initial;
   trtage=i_trt*age;      isexage=i_sex*age;
   isexinit=i_sex*initial;iageinit=age*initial;
   /* compute differences for paired observation*/
   if (center=center1) then do;
      pair=10*improve + improve1;
          i_sex=i_sex1-i_sex;
          age=age1-age;
          initial=initial1-initial;
          trtsex=trtsex1-trtsex;
          trtinit=trtinit1-trtinit;
          trtage=trtage1-trtage;
          isexage=isexage1-isexage;
          isexint=isexint1-isexinit;
          iageinit=iageint1-iageinit;
          if (pair=10 or pair=1) then do;
                 /* output discordant pair observations */
                improve=(pair=1); output trial; end;
      end;
   else do;
        center1=center; age1=age;
        initial1=initial; i_sex1=i_sex; improve1=improve;
        trtsex1=trtsex; trtinit1=trtinit; trtage1=trtage;
        isexage1=isexage; isexint1=isexinit; iageint1=iageinit;
        end;
cards;
1  t f 27 0 1  1 p f 32 0 2     
2  t f 41 1 3  2 p f 47 0 1 
3  t m 19 1 4  3 p m 31 0 4 
4  t m 55 1 1  4 p m 24 1 3 
5  t f 51 1 4  5 p f 44 0 2 
6  t m 23 0 1  6 p f 44 1 3 
7  t m 31 1 2  7 p f 39 0 2
8  t m 22 0 1  8 p m 54 1 4 
9  t m 37 1 3  9 p m 63 0 2 
10 t m 33 0 3 10 p f 43 0 3 
11 t f 32 1 1 11 p m 33 0 3 
12 t m 47 1 4 12 p m 24 0 4
13 t m 55 1 3 13 p f 38 1 1 
14 t f 33 0 1 14 p f 28 1 2 
15 t f 48 1 1 15 p f 42 0 1 
16 t m 55 1 3 16 p m 52 0 1 
17 t m 30 0 4 17 p m 48 1 4
18 t f 31 1 2 18 p m 27 1 3  
19 t m 66 1 3 19 p f 54 0 1 
20 t f 45 0 2 20 p f 66 1 2 
21 t m 19 1 4 21 p f 20 1 4 
22 t m 34 1 4 22 p f 31 0 1 
23 t f 46 0 1 23 p m 30 1 2
24 t m 48 1 3 24 p f 62 0 4 
25 t m 50 1 4 25 p m 45 1 4 
26 t m 57 1 3 26 p f 43 0 3 
27 t f 13 0 2 27 p m 22 1 3 
28 t m 31 1 1 28 p f 21 0 1 
29 t m 35 1 3 29 p m 35 1 3 
30 t f 36 1 3 30 p f 37 0 3 
31 t f 45 0 1 31 p f 41 1 1 
32 t m 13 1 2 32 p m 42 0 1 
33 t m 14 0 4 33 p f 22 1 2
34 t f 15 1 2 34 p m 24 0 1
35 t f 19 1 3 35 p f 31 0 1 
36 t m 20 0 2 36 p m 32 1 3  
37 t m 23 1 3 37 p f 35 0 1  
38 t f 23 0 1 38 p m 21 1 1  
39 t m 24 1 4 39 p m 30 1 3  
40 t m 57 1 3 40 p f 43 1 3 
41 t f 13 1 2 41 p m 22 0 3 
42 t m 31 1 1 42 p f 21 1 3 
43 t f 19 1 3 43 p m 35 1 3 
44 t m 31 1 3 44 p f 37 0 2 
45 t f 44 0 1 45 p f 41 1 1 
46 t m 41 1 2 46 p m 41 0 1 
47 t m 41 1 2 47 p f 21 0 4
48 t f 51 1 2 48 p m 22 1 1
49 t f 62 1 3 49 p f 32 0 3 
50 t m 21 0 1 50 p m 34 0 1  
51 t m 55 1 3 51 p f 35 1 2  
52 t f 61 0 1 52 p m 19 0 1  
53 t m 43 1 2 53 p m 31 0 2  
54 t f 44 1 1 54 p f 41 1 1 
55 t m 67 1 2 55 p m 41 0 1 
56 t m 41 0 2 56 p m 21 1 4
57 t f 51 1 3 57 p m 51 0 2
58 t m 62 1 3 58 p m 54 1 3 
59 t m 22 0 1 59 p f 22 0 1  
60 t m 42 1 2 60 p f 29 1 2  
61 t f 51 1 1 61 p f 31 0 1  
62 t m 27 0 2 62 p m 32 1 2  
63 t m 31 1 1 63 p f 21 0 1 
64 t m 35 0 3 64 p m 33 1 3 
65 t m 67 1 2 65 p m 19 0 1 
66 t m 41 0 2 66 p m 62 1 4
67 t f 31 1 2 67 p m 45 1 3  
68 t m 34 1 1 68 p f 54 0 1 
69 t f 21 0 1 69 p m 34 1 4  
70 t m 64 1 3 70 p m 51 0 1 
71 t f 61 1 3 71 p m 34 1 3 
72 t m 33 0 1 72 p f 43 0 1 
73 t f 36 0 2 73 p m 37 0 3 
74 t m 21 1 1 74 p m 55 0 1 
75 t f 47 0 2 75 p f 42 1 3
76 t f 51 1 4 76 p m 44 0 2 
77 t f 23 1 1 77 p m 41 1 3 
78 t m 31 0 2 78 p f 23 1 4
79 t m 22 0 1 79 p m 19 1 4 
;

proc logistic data=trial descending;
    model improve = initial age i_sex
       isexage isexinit iageinit
       trtsex trtinit trtage / 
       selection=forward include=3 details;
run;

/* page 256 of Categorical Data Analysis */

proc logistic data=trial descending;
    model improve =;
run;

/* page 259 of Categorical Data Analysis */

data cross;
   input outcome $ per_age DrugA DrugB CarryA CarryB count;
   cards;
FU 1  1 -1 -1  0 12 
UF 1  1 -1 -1  0  6 
FU 1  0  1  0 -1  5 
UF 1  0  1  0 -1  6 
FU 1 -1  0  0  0  3
UF 1 -1  0  0  0 22
FU 0 -1  1  0 -1  3 
UF 0 -1  1  0 -1 25
FU 0  1  0 -1  0  6
UF 0  1  0 -1  0  6
FU 0  0 -1  0  0  5
UF 0  0 -1  0  0 21
;
proc logistic;
   freq count;
   model outcome=per_age DrugA DrugB CarryA CarryB;
run; 

/* page 260 of Categorical Data Analysis */

proc logistic;
   freq count;
   model outcome=per_age DrugA DrugB /
   scale=none aggregate=(DrugA DrugB);
   ab: test DrugA - DrugB =0;
run; 

/* pages 264-266 of Categorical Data Analysis */

data match1;
   drop   id1 gall1 hyper1 age1 est1 nonest1 gallest1;
   retain id1 gall1 hyper1 age1 est1 nonest1 gallest1 0;
   input id case age est gall hyper nonest @@;
   gallest=est*gall;
   if (id = id1) then do;
       gall=gall1-gall; hyper=hyper1-hyper; age=age1-age;
       est=est1-est;  nonest=nonest1-nonest;
       gallest=gallest1-gallest;
       output;
    end;
    else do;
       id1=id;   gall1=gall;       hyper1=hyper; age1=age;
       est1=est; nonest1=nonest; gallest1=gallest;
    end;
    cards;
1 1 74 1 0 0  1  1 0 75 0 0 0  0
2 1 67 1 0 0  1  2 0 67 0 0 1  1
3 1 76 1 0 1  1  3 0 76 1 0 1  1
4 1 71 1 0 0  0  4 0 70 1 1 0  1
5 1 69 1 1 0  1  5 0 69 1 0 1  1
6 1 70 1 0 1  1  6 0 71 0 0 0  0
7 1 65 1 1 0  1  7 0 65 0 0 0  0
8 1 68 1 1 1  1  8 0 68 0 0 1  1
9 1 61 0 0 0  1  9 0 61 0 0 0  1
10 1 64 1 0 0  1 10 0 65 0 0 0  0
11 1 68 1 1 0  1 11 0 69 1 1 0  0
12 1 74 1 0 0  1 12 0 74 1 0 0  0
13 1 67 1 1 0  1 13 0 68 1 0 1  1
14 1 62 1 1 0  1 14 0 62 0 1 0  0
15 1 71 1 1 0  1 15 0 71 1 0 1  1
16 1 83 1 0 1  1 16 0 82 0 0 0  0
17 1 70 0 0 0  1 17 0 70 0 0 1  1
18 1 74 1 0 0  1 18 0 75 0 0 0  0
19 1 70 1 0 0  1 19 0 70 0 0 0  0
20 1 66 1 0 1  1 20 0 66 1 0 0  1
21 1 77 1 0 0  1 21 0 77 1 1 1  1
22 1 66 1 0 1  1 22 0 67 0 0 1  1
23 1 71 1 0 1  0 23 0 72 0 0 0  0
24 1 80 1 0 0  1 24 0 79 0 0 0  0
25 1 64 1 0 0  1 25 0 64 1 0 0  1
26 1 63 1 0 0  1 26 0 63 1 0 1  1
27 1 72 0 1 0  1 27 0 72 0 0 1  0
28 1 57 1 0 0  0 28 0 57 1 0 1  1
29 1 74 0 1 0  1 29 0 74 0 0 0  1
30 1 62 1 0 1  1 30 0 62 1 0 0  1
31 1 73 1 0 1  1 31 0 72 1 0 0  1
32 1 71 1 0 1  1 32 0 71 1 0 1  1
33 1 64 0 0 1  1 33 0 65 1 0 0  1
34 1 63 1 0 0  1 34 0 64 0 0 0  1
35 1 79 1 1 1  1 35 0 78 1 1 1  1
36 1 80 1 0 0  1 36 0 81 0 0 1  1
37 1 82 1 0 1  1 37 0 82 0 0 0  1
38 1 71 1 0 1  1 38 0 71 0 0 1  1
39 1 83 1 0 1  1 39 0 83 0 0 0  1
40 1 61 1 0 1  1 40 0 60 0 0 0  1
41 1 71 1 0 0  1 41 0 71 0 0 0  0
42 1 69 1 0 1  1 42 0 69 0 1 0  1
43 1 77 1 0 0  1 43 0 76 1 0 1  1
44 1 64 1 0 0  0 44 0 64 1 0 0  0
45 1 79 0 1 0  0 45 0 82 1 0 0  1
46 1 72 1 0 0  1 46 0 72 1 0 0  1
47 1 82 1 1 1  1 47 0 81 0 0 0  0
48 1 73 1 0 1  1 48 0 74 1 0 0  1
49 1 69 1 0 0  1 49 0 68 0 0 0  1
50 1 79 1 0 1  1 50 0 79 0 0 0  1
51 1 72 1 0 0  0 51 0 71 1 0 1  1
52 1 72 1 0 1  1 52 0 72 1 0 1  1
53 1 65 1 0 1  1 53 0 67 0 0 0  0
54 1 67 1 0 1  1 54 0 66 1 0 0  1
55 1 64 1 1 0  1 55 0 63 0 0 0  1
56 1 62 1 0 0  0 56 0 63 0 0 0  0
57 1 83 0 1 1  1 57 0 83 0 1 0  0
58 1 81 1 0 0  1 58 0 79 0 0 0  0
59 1 67 1 0 0  1 59 0 66 1 0 1  1
60 1 73 1 1 1  1 60 0 72 1 0 0  1
61 1 67 1 1 0  1 61 0 67 1 1 0  1
62 1 74 1 0 1  1 62 0 75 0 0 0  1
63 1 68 1 1 0  1 63 0 69 1 0 0  1
;

proc logistic;
   model case = gall hyper age est nonest /
                noint selection=forward details; 
run;

/* pages 268-269 of Categorical Data Analysis */

data match2;
     input id case age est gall hyper nonest @@;
   case=2-case;
   cards;
 1 1 74 1 0 0  1  1 0 75 0 0 0  0
  2 1 67 1 0 0  1  2 0 67 0 0 1  1
  3 1 76 1 0 1  1  3 0 76 1 0 1  1
  4 1 71 1 0 0  0  4 0 70 1 1 0  1
  5 1 69 1 1 0  1  5 0 69 1 0 1  1
  6 1 70 1 0 1  1  6 0 71 0 0 0  0
  7 1 65 1 1 0  1  7 0 65 0 0 0  0
  8 1 68 1 1 1  1  8 0 68 0 0 1  1
  9 1 61 0 0 0  1  9 0 61 0 0 0  1
 10 1 64 1 0 0  1 10 0 65 0 0 0  0
 11 1 68 1 1 0  1 11 0 69 1 1 0  0
 12 1 74 1 0 0  1 12 0 74 1 0 0  0
 13 1 67 1 1 0  1 13 0 68 1 0 1  1
 14 1 62 1 1 0  1 14 0 62 0 1 0  0
 15 1 71 1 1 0  1 15 0 71 1 0 1  1
 16 1 83 1 0 1  1 16 0 82 0 0 0  0
 17 1 70 0 0 0  1 17 0 70 0 0 1  1
 18 1 74 1 0 0  1 18 0 75 0 0 0  0
 19 1 70 1 0 0  1 19 0 70 0 0 0  0
 20 1 66 1 0 1  1 20 0 66 1 0 0  1
 21 1 77 1 0 0  1 21 0 77 1 1 1  1
 22 1 66 1 0 1  1 22 0 67 0 0 1  1
 23 1 71 1 0 1  0 23 0 72 0 0 0  0
 24 1 80 1 0 0  1 24 0 79 0 0 0  0
 25 1 64 1 0 0  1 25 0 64 1 0 0  1
 26 1 63 1 0 0  1 26 0 63 1 0 1  1
 27 1 72 0 1 0  1 27 0 72 0 0 1  0
 28 1 57 1 0 0  0 28 0 57 1 0 1  1
 29 1 74 0 1 0  1 29 0 74 0 0 0  1
 30 1 62 1 0 1  1 30 0 62 1 0 0  1
 31 1 73 1 0 1  1 31 0 72 1 0 0  1
 32 1 71 1 0 1  1 32 0 71 1 0 1  1
 33 1 64 0 0 1  1 33 0 65 1 0 0  1
 34 1 63 1 0 0  1 34 0 64 0 0 0  1
 35 1 79 1 1 1  1 35 0 78 1 1 1  1
 36 1 80 1 0 0  1 36 0 81 0 0 1  1
 37 1 82 1 0 1  1 37 0 82 0 0 0  1
 38 1 71 1 0 1  1 38 0 71 0 0 1  1
 39 1 83 1 0 1  1 39 0 83 0 0 0  1
 40 1 61 1 0 1  1 40 0 60 0 0 0  1
 41 1 71 1 0 0  1 41 0 71 0 0 0  0
 42 1 69 1 0 1  1 42 0 69 0 1 0  1
 43 1 77 1 0 0  1 43 0 76 1 0 1  1
 44 1 64 1 0 0  0 44 0 64 1 0 0  0
 45 1 79 0 1 0  0 45 0 82 1 0 0  1
 46 1 72 1 0 0  1 46 0 72 1 0 0  1
 47 1 82 1 1 1  1 47 0 81 0 0 0  0
 48 1 73 1 0 1  1 48 0 74 1 0 0  1
 49 1 69 1 0 0  1 49 0 68 0 0 0  1
 50 1 79 1 0 1  1 50 0 79 0 0 0  1
 51 1 72 1 0 0  0 51 0 71 1 0 1  1
 52 1 72 1 0 1  1 52 0 72 1 0 1  1
 53 1 65 1 0 1  1 53 0 67 0 0 0  0
 54 1 67 1 0 1  1 54 0 66 1 0 0  1
 55 1 64 1 1 0  1 55 0 63 0 0 0  1
 56 1 62 1 0 0  0 56 0 63 0 0 0  0
 57 1 83 0 1 1  1 57 0 83 0 1 0  0
 58 1 81 1 0 0  1 58 0 79 0 0 0  0
 59 1 67 1 0 0  1 59 0 66 1 0 1  1
 60 1 73 1 1 1  1 60 0 72 1 0 0  1
 61 1 67 1 1 0  1 61 0 67 1 1 0  1
 62 1 74 1 0 1  1 62 0 75 0 0 0  1
 63 1 68 1 1 0  1 63 0 69 1 0 0  1
;

proc phreg;
   strata id;
   model case = gall est / selection=forward details; 
run;

/* pages 271-272 of Categorical Data Analysis */

data matched;
   input id outcome lung vaccine @@;
   outcome=2-outcome;
   lung_vac=lung*vaccine;
   cards;
 1 1 0 0  1 0 1 0  1 0 0 0  2 1 0 0  2 0 0 0  2 0 1 0
 3 1 0 1  3 0 0 1  3 0 0 0  4 1 1 0  4 0 0 0  4 0 1 0
 5 1 1 0  5 0 0 1  5 0 0 1  6 1 0 0  6 0 0 0  6 0 0 1
 7 1 0 0  7 0 0 0  7 0 0 1  8 1 1 1  8 0 0 0  8 0 0 1
 9 1 0 0  9 0 0 1  9 0 0 0 10 1 0 0 10 0 1 0 10 0 0 0
11 1 1 0 11 0 0 1 11 0 0 0 12 1 1 1 12 0 0 1 12 0 0 0
13 1 0 0 13 0 0 1 13 0 1 0 14 1 0 0 14 0 0 0 14 0 0 1
15 1 1 0 15 0 0 0 15 0 0 1 16 1 0 1 16 0 0 1 16 0 0 1
17 1 0 0 17 0 1 0 17 0 0 0 18 1 1 0 18 0 0 1 18 0 0 1
19 1 1 0 19 0 0 1 19 0 0 1 20 1 0 0 20 0 0 0 20 0 0 0
21 1 0 0 21 0 0 1 21 0 0 1 22 1 0 1 22 0 0 0 22 0 1 0
23 1 1 1 23 0 0 0 23 0 0 0 24 1 0 0 24 0 0 1 24 0 0 1
25 1 1 0 25 0 1 0 25 0 0 0 26 1 1 1 26 0 0 0 26 0 0 0
27 1 1 0 27 0 0 1 27 0 0 0 28 1 0 1 28 0 1 0 28 0 0 0
29 1 0 0 29 0 0 0 29 0 1 1 30 1 0 0 30 0 0 0 30 0 0 0
31 1 0 0 31 0 0 0 31 0 0 1 32 1 1 0 32 0 0 0 32 0 0 0
33 1 0 1 33 0 0 0 33 0 0 0 34 1 0 0 34 0 1 0 34 0 0 0
35 1 1 0 35 0 1 1 35 0 0 0 36 1 0 1 36 0 0 0 36 0 0 1
37 1 0 1 37 0 0 0 37 0 0 1 38 1 1 1 38 0 0 1 38 0 0 0
39 1 0 0 39 0 0 1 39 0 0 1 40 1 0 0 40 0 0 0 40 0 1 1
41 1 1 0 41 0 0 0 41 0 0 1 42 1 1 0 42 0 0 0 42 0 0 0
43 1 0 0 43 0 0 1 43 0 0 0 44 1 1 0 44 0 0 0 44 0 0 0
45 1 1 0 45 0 0 0 45 0 0 0 46 1 1 0 46 0 1 1 46 0 0 0
47 1 0 1 47 0 0 0 47 0 0 1 48 1 0 0 48 0 0 0 48 0 0 0
49 1 1 0 49 0 1 0 49 0 1 1 50 1 1 1 50 0 0 0 50 0 0 1
51 1 1 0 51 0 0 1 51 0 0 1 52 1 0 1 52 0 0 0 52 0 0 0
53 1 0 1 53 0 0 1 53 0 0 1 54 1 1 0 54 0 0 0 54 0 0 0
55 1 0 0 55 0 0 1 55 0 0 0 56 1 0 0 56 0 0 0 56 0 1 0
57 1 1 1 57 0 1 0 57 0 0 0 58 1 1 0 58 0 0 1 58 0 0 1
59 1 0 0 59 0 0 0 59 0 1 1 60 1 0 0 60 0 0 0 60 0 0 1
61 1 0 1 61 0 0 0 61 0 0 1 62 1 0 0 62 0 0 0 62 0 0 1
63 1 0 0 63 0 0 1 63 0 0 0 64 1 0 0 64 0 1 0 64 0 0 0
65 1 1 1 65 0 0 0 65 0 1 0 66 1 1 1 66 0 0 1 66 0 1 0
67 1 0 0 67 0 0 0 67 0 0 1 68 1 0 0 68 0 0 1 68 0 0 1
69 1 1 1 69 0 0 1 69 0 0 1 70 1 0 0 70 0 0 1 70 0 1 1
71 1 0 0 71 0 0 0 71 0 0 1 72 1 1 0 72 0 0 0 72 0 0 0
73 1 1 0 73 0 0 1 73 0 0 0 74 1 0 0 74 0 0 0 74 0 0 1
75 1 0 0 75 0 0 1 75 0 0 0 76 1 0 0 76 0 0 0 76 0 0 0
77 1 0 1 77 0 0 0 77 0 0 1 78 1 0 0 78 0 0 1 78 0 0 0
79 1 1 0 79 0 0 1 79 0 0 1 80 1 0 1 80 0 0 0 80 0 0 0
81 1 0 0 81 0 1 1 81 0 0 1 82 1 1 1 82 0 1 0 82 0 0 0
83 1 0 1 83 0 0 0 83 0 0 1 84 1 0 0 84 0 0 0 84 0 0 1
85 1 1 0 85 0 0 0 85 0 0 0 86 1 0 0 86 0 1 1 86 0 1 0
87 1 1 1 87 0 0 0 87 0 0 0 88 1 0 0 88 0 0 0 88 0 0 0
89 1 0 0 89 0 0 1 89 0 1 1 90 1 0 0 90 0 0 0 90 0 0 0
91 1 0 1 91 0 0 0 91 0 0 1  92 1 0 0  92 0 1 1  92 0 0 0
93 1 0 1 93 0 0 0 93 0 1 0  94 1 1 0  94 0 0 0  94 0 0 0
95 1 1 1 95 0 0 1 95 0 0 0  96 1 1 0  96 0 0 1  96 0 0 1
97 1 1 1 97 0 0 0 97 0 0 1  98 1 0 0  98 0 0 0  98 0 1 1
99 1 0 1 99 0 1 1 99 0 0 1 100 1 1 0 100 0 0 0 100 0 0 0
101 1 0 0 101 0 0 0 101 0 0 0 102 1 0 1 102 0 0 0 102 0 0 0
103 1 0 1 103 0 0 0 103 0 0 0 104 1 1 0 104 0 0 1 104 0 1 0
105 1 1 0 105 0 1 0 105 0 0 0 106 1 0 0 106 0 0 0 106 0 0 1
107 1 0 0 107 0 0 1 107 0 0 1 108 1 1 1 108 0 0 0 108 0 0 1
109 1 0 1 109 0 0 0 109 0 0 0 110 1 0 0 110 0 0 0 110 0 0 0
111 1 1 0 111 0 0 1 111 0 0 1 112 1 0 0 112 0 0 1 112 0 0 0
113 1 0 1 113 0 0 0 113 0 1 0 114 1 1 1 114 0 0 1 114 0 0 1
115 1 1 1 115 0 0 1 115 0 0 1 116 1 0 0 116 0 0 1 116 0 1 0
117 1 0 1 117 0 0 0 117 0 0 0 118 1 1 0 118 0 1 0 118 0 0 0
119 1 1 0 119 0 0 0 119 0 0 0 120 1 1 0 120 0 0 0 120 0 0 1
121 1 0 0 121 0 0 1 121 0 0 0 122 1 0 1 122 0 0 0 122 0 0 0
123 1 1 0 123 0 0 0 123 0 1 1 124 1 0 0 124 0 0 1 124 0 0 0
125 1 1 0 125 0 1 0 125 0 0 0 126 1 1 1 126 0 0 0 126 0 0 0
127 1 1 0 127 0 0 1 127 0 0 0 128 1 0 1 128 0 1 0 128 0 0 0
129 1 0 0 129 0 0 0 129 0 1 1 130 1 0 0 130 0 0 0 130 0 0 0
131 1 0 0 131 0 0 0 131 0 0 1 132 1 1 0 132 0 0 0 132 0 0 1
133 1 0 1 133 0 0 0 133 0 0 0 134 1 0 0 134 0 1 0 134 0 0 1
135 1 1 0 135 0 1 1 135 0 0 0 136 1 0 0 136 0 0 0 136 0 0 0
137 1 0 0 137 0 0 0 137 0 0 1 138 1 1 0 138 0 0 0 138 0 0 0
139 1 0 0 139 0 0 0 139 0 0 0 140 1 0 0 140 0 0 1 140 0 1 1
141 1 1 1 141 0 0 0 141 0 0 1 142 1 1 0 142 0 0 0 142 0 0 0
143 1 0 0 143 0 0 1 143 0 1 1 144 1 1 1 144 0 0 1 144 0 0 1
145 1 1 0 145 0 0 1 145 0 0 0 146 1 1 0 146 0 1 0 146 0 0 0
147 1 0 1 147 0 0 0 147 0 0 1 148 1 0 0 148 0 0 1 148 0 0 0
149 1 1 0 149 0 1 0 149 0 1 0 150 1 1 1 150 0 0 0 150 0 0 1
;

proc freq;
   tables outcome*lung outcome*vaccine / nocol nopct;
run;

/* page 273 of Categorical Data Analysis */

proc phreg;
   strata id;
   model outcome = lung vaccine lung_vac /         
   selection=forward details ties=discrete;
run;

/* page 274 of Categorical Data Analysis */

proc phreg;
   strata id;
   model outcome = lung vaccine lung_vac /
         selection=forward include=2 details ties=discrete; 
run;

/* Chapter 11 */

/* page 282 of Categorical Data Analysis */

data bacteria;
   input dose status $ count @@;
   ldose=log(dose);
   sq_ldose=ldose*ldose;
   cards;
1200      dead   0    1200      alive 5
12000     dead   0    12000     alive 5
120000    dead   2    120000    alive 3
1200000   dead   4    1200000   alive 2
12000000  dead   5    12000000  alive 1
120000000 dead   5    120000000 alive 0
;
proc print;
run;

proc logistic data=bacteria descending;
   freq count;
   model status = ldose sq_ldose / scale=none aggregate
         selection=forward start=1 details covb;
run;

/* page 287 of Categorical Data Analysis */

data assay;
   input drug $ dose status $ count;
   int_n=(drug='n');
   int_s=(drug='s');
   ldose=log(dose);
   ldose_n=int_n*ldose;
   ldose_s=int_s*ldose;
   sqdose_n=int_n*ldose*ldose;
   sqdose_s=int_s*ldose*ldose;
   cards;
n 0.01   dead   0
n 0.01   alive 30
n  .03   dead   1
n  .03   alive 29
n  .10   dead   1
n  .10   alive  9
n  .30   dead   1
n  .30   alive  9
n 1.00   dead   4
n 1.00   alive  6
n 3.00   dead   4
n 3.00   alive  6
n 10.00  dead   5
n 10.00  alive  5
n 30.00  dead   7
n 30.00  alive  3
s   .30  dead   0
s   .30  alive 10
s  1.00  dead   0
s  1.00  alive 10
s 3.00   dead   1
s 3.00   alive  9
s 10.00  dead   4
s 10.00  alive  6
s 30.00  dead   5
s 30.00  alive  5
s 100.00 dead   8
s 100.00 alive  2
;

/* page 288 of Categorical Data Analysis */

proc logistic data=assay descending;
   freq count;
   model status = int_n int_s ldose_n ldose_s
                  sqdose_n sqdose_s  / noint
                  scale=none aggregate
                  start=4 selection=forward details;
   eq_slope: test ldose_n=ldose_s;
run;

/* page 289 of Categorical Data Analysis */

proc logistic data=assay descending outest=estimate
           (drop= _link_ _lnlike_) covout;
   freq count;
   model status = int_n int_s ldose /
               noint scale=none aggregate covb;
run;

/* pages 290-291 of Categorical Data Analysis */

proc iml;
  use estimate;
  start fieller;
  title 'Confidence Intervals';
  use estimate;
  read all into beta where (_type_='PARMS');
  beta=beta`;
  read all into cov where (_type_='COV');
  ratio=(k`*beta) / (h`*beta);
  a=(h`*beta)**2-(3.84)*(h`*cov*h);
  b=2*(3.84*(k`*cov*h)-(k`*beta)*(h`*beta));
  c=(k`*beta)**2 -(3.84)*(k`*cov*k);
   disc=((b**2)-4*a*c);
  if (disc<=0 | a<=0) then do;
  print "confidence interval can't be computed", ratio;
  stop; end;
  sroot=sqrt(disc);
   l_b=((-b)-sroot)/(2*a);
   u_b=((-b)+sroot)/(2*a);
  interval=l_b||u_b;
  lname={"l_bound", "u_bound"};
  print "95 % ci for ratio based on fieller", ratio interval[colname=lname];
  finish fieller;
  k={ 1 -1 0 }`;
  h={ 0  0 1 }`;
   run fieller;
  k={-1 0 0 }`;
  h={ 0 0 1 }`;
   run fieller;
  k={ 0 -1 0 }`;
  h={ 0 0 1 }`;
   run fieller;

/* page 293 of Categorical Data Analysis */

data adverse;
   input diagnos $ dose status $ count @@;
   i_diagII=(diagnos='II');
   i_diagI= (diagnos='I');
   doseI=i_diagI*dose;
   doseII=i_diagII*dose;
   diagdose=i_diagII*dose;
   if doseI > 0 then ldoseI=log(doseI); else ldoseI=0;
   if doseII > 0 then ldoseII=log(doseII); else ldoseII=0;
   cards;
I    1   adverse  3 I    1 no 26
I    5   adverse  7 I    5 no 26
I    10  adverse 10 I   10 no 22
I    12  adverse 14 I   12 no 18
I    15  adverse 18 I   15 no 14
II   1   adverse  6 II   1 no 26
II   5   adverse 20 II   5 no 12
II   10  adverse 26 II  10 no  6
II   12  adverse 28 II  12 no  4
II   15  adverse 31 II  15 no  1
;  

proc freq data=adverse;
   weight count;
   tables dose*status diagnos*status diagnos*dose*status /
          nopct nocol cmh;
run;

/* pages 295-296 of Categorical Data Analysis */

proc logistic data=adverse outest=estimate
                 (drop= _link_ _lnlike_) covout;
   freq count;
   model status = i_diagI i_diagII doseI doseII  /
                  noint scale=none aggregate;
   eq_slope: test doseI=doseII;
run;

/* pages 297-298 of Categorical Data Analysis */

proc logistic data=adverse;
   freq count;
   model status = i_diagI i_diagII ldoseI ldoseII  /
                  noint scale=none aggregate;
   eq_slope: test ldoseI=ldoseII;
run;

proc iml;
  use estimate;
  start fieller;
  title 'Confidence Intervals';
  use estimate;
  read all into beta where (_type_='PARMS');
  beta=beta`;
  read all into cov where (_type_='COV');
  ratio=(k`*beta) / (h`*beta);
  a=(h`*beta)**2-(3.84)*(h`*cov*h);
  b=2*(3.84*(k`*cov*h)-(k`*beta)*(h`*beta));
  c=(k`*beta)**2 -(3.84)*(k`*cov*k);
   disc=((b**2)-4*a*c);
  if (disc<=0 | a<=0) then do;
  print "confidence interval can't be computed", ratio;
  stop; end;
  sroot=sqrt(disc);
   l_b=((-b)-sroot)/(2*a);
   u_b=((-b)+sroot)/(2*a);
  interval=l_b||u_b;
  lname={"l_bound", "u_bound"};
  print "95 % ci for ratio based on fieller", ratio interval[colname=lname];
  finish fieller;
  k={ -1 0 0 0}`;
  h={  0 0 1 0}`;
   run fieller;
  k={ 0 -1 0 0}`;
  h={ 0  0 0 1}`;
   run fieller;

/* Chapter 12 */

*/ page 307 of Categorical Data Analysis */

data colds;
   input sex $ residnce $ periods count @@;
   cards;  
female rural 0 45 female rural 1 64  female rural 2 71
female urban 0 80 female urban 1 104 female urban 2 116
male rural   0 84 male   rural 1 124 male   rural 2 82
male urban   0 106 male  urban 1 117 male   urban 2 87
;
run;

/* page 308 of Categorical Data Analysis */

proc catmod; 
   weight count;
   response means;
   model periods = sex residnce sex*residnce /freq prob;     
run;

/* page 310 of Categorical Data Analysis */

proc catmod; 
   weight count;
   response means ;
   model periods = sex residnce ;     
run;  

/* pages 311-312 of Categorical Data Analysis */

proc catmod;
   weight count;
   response means;
   model periods = sex;     
run;  

proc catmod;
   population sex residnce; 
   weight count;
   response means;
   model periods = sex;     
run;    

/* pages 314-315 of Categorical Data Analysis */

data cpain;
   input dstatus $ invest $ treat $ status $ count @@;
cards;
 I  A active poor  3 I   A active  fair 2 I A active moderate 2  
 I  A active good  1 I   A active  excel 0 
 I  A placebo poor 7 I   A placebo fair 0 I A placebo moderate 1  
 I  A placebo good 1 I   A placebo excel 1 
 I  B active poor  1 I   B active  fair 6 I B active moderate 1  
 I  B active good  5 I   B active  excel 3 
 I  B placebo poor 5 I   B placebo fair 4 I B placebo moderate 2  
 I  B placebo good 3 I   B placebo excel 3 
II  A active poor  1 II  A active  fair 0 II A active moderate 1  
II  A active good  2 II  A active  excel 2 
II  A placebo poor 1 II  A placebo fair 1 II A placebo moderate 0  
II  A placebo good 1 II  A placebo excel 1 
II  B active poor  0 II  B active  fair  1 II B active moderate 1  
II  B active good  1 II  B active  excel 6 
II  B placebo poor 3 II  B placebo fair 1 II B placebo moderate 1  
II  B placebo good 5 II  B placebo excel 0 
III A active poor  2 III A active  fair 0 III A active moderate 3  
III A active good  3 III A active  excel 2 
III A placebo poor 5 III A placebo fair 0 III A placebo moderate 0  
III A placebo good 8 III A placebo excel 1 
III B active poor  2 III B active  fair 4 III B active moderate 1  
III B active good 10 III B active  excel 3 
III B placebo poor 2 III B placebo fair 5 III B placebo moderate 1  
III B placebo good 4 III B placebo excel 2 
IV  A active poor  8 IV  A active  fair 1 IV A active moderate 3  
IV  A active good  4 IV  A active  excel 0 
IV  A placebo poor 5 IV  A placebo fair 0 IV A placebo moderate 3  
IV  A placebo good 3 IV  A placebo excel 0 
IV  B active poor  1 IV  B active  fair 5 IV B active moderate 2  
IV  B active good  3 IV  B active  excel 1 
IV  B placebo poor 3 IV  B placebo fair 4 IV B placebo moderate 3  
IV  B placebo good 4 IV  B placebo excel 2 
;

proc catmod order=data;
  weight count;
  response 1 2 3 4 5;
  model status=dstatus|invest|treat;
run;   

/* page 317 of Categorical Data Analysis */

model status=dstatus|invest|treat@2; run;

/* page 318 of Categorical Data Analysis */

model status=dstatus invest treat; run;

/* page 320 of Categorical Data Analysis */

contrast 'Diag I versus II' dstatus 1 -1 0;

contrast 'I versus II'    dstatus 1 -1  0;
contrast 'I versus III'   dstatus 1  0 -1;
contrast 'I versus IV'    dstatus 2  1  1; 
contrast 'II versus III'  dstatus 0  1 -1;
contrast 'II versus IV'   dstatus 1  2  1;
contrast 'III versus IV'  dstatus 1  1  2; 
contrast 'dstatus'  dstatus 1 0 0 ,
                    dstatus 0 1 0 ,
                    dstatus 0 0 1 ;
run;

/* page 323 of Categorical Data Analysis */

data byss;
   input workplce $ em_years $ smoking $ status $ count @@;
   cards ;
dusty        <10   yes  yes 30  dusty     <10   yes no  203
dusty        <10   no   yes  7  dusty     <10   no  no  119
dusty       >=10   yes  yes 57  dusty     >=10  yes no  161
dusty       >=10   no   yes 11  dusty     >=10  no  no   81
notdusty     <10   yes  yes 14  notdusty  <10   yes no 1340
notdusty     <10   no   yes 12  notdusty  <10   no  no 1004
notdusty    >=10   yes  yes 24  notdusty  >=10  yes no 1360
notdusty    >=10   no   yes 10  notdusty  >=10  no  no  986
; 
run;

/* page 324 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   response marginals;
   model status = workplce|em_years|smoking;
run;    

/* page 325 of Categorical Data Analysis */  

proc catmod order=data;
    weight count ;
    response marginals;
    model status = workplce|em_years workplce|smoking
                   em_years|smoking;
run;     

/* page 327 of Categorical Data Analysis */

proc catmod order=data;
    weight count;
    response marginals;
    model status = workplce
                  em_years(workplce='dusty')
                  em_years(workplce='notdusty')                   
                  smoking(workplce='dusty')
                  smoking(workplce='notdusty') ;                   
run;     

/* page 328 of Categorical Data Analysis */

proc catmod order=data;
   weight count ;
   response marginals;
   model status = workplce
                  em_years(workplce='dusty')
                  smoking(workplce='dusty') / pred;
run;     

/* page 331 of Categorical Data Analysis */

data highway ;
   input size $ age $ modelyr $ status $ count @@ ;
   linsize = (size='middle') + 2*(size='small') ;
   cards; 
small     0-2 <67   yes 31  small    0-2 <67   no  119 
small     0-2 67-69 yes 61  small    0-2 67-69 no  262
small     3-5 <67   yes 66  small    3-5 <67   no  255
small     3-5 67-69 yes 42  small    3-5 67-69 no  171
middle    0-2 <67   yes 29  middle   0-2 <67   no  143
middle    0-2 67-69 yes 67  middle   0-2 67-69 no  405
middle    3-5 <67   yes 69  middle   3-5 <67   no  297
middle    3-5 67-69 yes 49  middle   3-5 67-69 no  223
standard  0-2 <67   yes 31  standard 0-2 <67   no  137
standard  0-2 67-69 yes 87  standard 0-2 67-69 no  624
standard  3-5 <67   yes 82  standard 3-5 <67   no  470
standard  3-5 67-69 yes 50  standard 3-5 67-69 no  407
; 
proc catmod order=data; 
   weight count;
   response marginals;
   model status = size|age|modelyr ;  
run ;

/* page 333 of Categorical Data Analysis */

model status = size age modelyr; run;

/* pages 334-335 of Categorical Data Analysis */

proc catmod order=data; 
   population size age modelyr;
   weight count;
   response marginals;
   model status = size modelyr;
   contrast 'linearity' size 0 1;  
run ;   

proc catmod order=data; 
   population size age modelyr;
   direct linsize ;
   weight count;
   response marginal;
   model status = linsize modelyr /pred;
run ;   

/* page 337 of Categorical Data Analysis */ 

proc catmod order=data; 
   population size age modelyr ;
   direct linsize ;
   weight count;
   model status = linsize modelyr /pred;
run ;   

/* page 338 of Categorical Data Analysis */

proc catmod order=data; 
   population size age modelyr ;
   direct linsize ;
   weight count;
   model status = linsize modelyr /pred wls;
run ;   

/* pages 341-342 of Categorical Data Analysis */

data pain (drop=h0-h8);
   input center initial $ treat $ h0-h8;
   array hours h0-h8;
   do i=1 to 9;
      no_hours=i-1; count=hours(i); output;
   end ;    
cards ; 
1 some placebo  1 0 3 0 2 2 4 4 2 
1 some treat_a  2 1 0 2 1 2 4 5 1 
1 some treat_b  0 0 0 1 0 3 7 6 2 
1 some treat_ba 0 0 0 0 1 3 5 4 6 
1 lot  placebo  6 1 2 2 2 3 7 3 0 
1 lot  treat_a  6 3 1 2 4 4 7 1 0 
1 lot  treat_b  3 1 0 4 2 3 11 4 0  
1 lot  treat_ba 0 0 0 1 1 7 9 6 2 
2 some placebo  2 0 2 1 3 1 2 5 4 
2 some treat_a  0 0 0 1 1 1 8 1 7 
2 some treat_b  0 2 0 1 0 1 4 6 6 
2 some treat_ba 0 0 0 1 3 0 4 7 5 
2 lot  placebo  7 2 3 2 3 2 3 2 2 
2 lot  treat_a  3 1 0 0 3 2 9 7 1 
2 lot  treat_b  0 0 0 1 1 5 8 7 4 
2 lot  treat_ba 0 1 0 0 1 2 8 9 5 
3 some placebo  5 0 0 1 3 1 4 4 5 
3 some treat_a  1 0 0 1 3 5 3 3 6 
3 some treat_b  3 0 1 1 0 0 3 7 11 
3 some treat_ba 0 0 0 1 1 4 2 4 13 
3 lot  placebo  6 0 2 2 2 6 1 2 1 
3 lot  treat_a  4 2 1 5 1 1 3 2 3 
3 lot  treat_b  5 0 2 3 1 0 2 6 7 
3 lot  treat_ba 3 2 1 0 0 2 5 9 4 
4 some placebo  1 0 1 1 4 1 1 0 10 
4 some treat_a  0 0 0 1 0 2 2 1 13
4 some treat_b  0 0 0 1 1 1 1 5 11 
4 some treat_ba 1 0 0 0 0 2 2 2 14 
4 lot  placebo  4 0 1 3 2 1 1 2 2 
4 lot  treat_a  0 1 3 1 1 6 1 3 6 
4 lot  treat_b  0 0 0 0 2 7 2 2 9  
4 lot  treat_ba 1 0 3 0 1 2 3 4 8 
;
proc print ;
run;

proc catmod;
   weight count; 
   response 0 .125 .25 .375 .5 .625 .75 .875 1;
   model no_hours =  center initial treat
                     treat*initial;
run;

/* page 346 of Categorical Data Analysis */

proc catmod ;
   weight count ; 
   response 0 .125 .25 .375 .5 .625 .75 .875 1;
   model no_hours = center initial 
                   treat(initial) ;  
run;

/* pages 349-350 of Categorical Data Analysis */

contrast 'lot: a-placebo'  treat(initial) -1  1  0  0  0  0 ;
contrast 'lot: b-placebo'  treat(initial) -1  0  1  0  0  0 ; 
contrast 'lot: ba-placebo' treat(initial) -2 -1 -1  0  0  0 ; 
contrast 'lot: ba-a'       treat(initial) -1 -2 -1  0  0  0 ;
contrast 'lot: ba-b'       treat(initial) -1 -1 -2  0  0  0 ;
contrast 'some:a-placebo'  treat(initial)  0  0  0 -1  1  0 ;
contrast 'some:b-placebo'  treat(initial)  0  0  0 -1  0  1 ; 
contrast 'some:ba-placebo' treat(initial)  0  0  0 -2 -1 -1 ; 
contrast 'some:ba-a'       treat(initial)  0  0  0 -1 -2 -1 ;
contrast 'some:ba-b'       treat(initial)  0  0  0 -1 -1 -2 ;
run;

/* page 351 of Categorical Data Analysis */

contrast 'interact:a-placebo'  treat(initial) -1  1  0  1 -1  0 ;
contrast 'interact:b-placebo'  treat(initial) -1  0  1  1  0 -1 ; 
contrast 'interact:ba-placebo' treat(initial) -2 -1 -1  2  1  1 ; 
contrast 'average:a-placebo'   treat(initial) -1  1  0 -1  1  0 ;
contrast 'average:b-placebo'   treat(initial) -1  0  1 -1  0  1 ; 
contrast 'average:ba-placebo'  treat(initial) -2 -1 -1 -2 -1 -1 ;
contrast 'average:ba-a'        treat(initial) -1 -2 -1 -1 -2 -1 ;
contrast 'average:ba-b'        treat(initial) -1 -1 -2 -1 -1 -2 ; 
contrast 'interaction'         treat(initial) -1  1  0  1 -1  0 ,
                               treat(initial) -1  0  1  1  0 -1 , 
                               treat(initial) -2 -1 -1  2  1  1 ; 
contrast 'treatment effect'    treat(initial) -1  1  0 -1  1  0 ,
                               treat(initial) -1  0  1 -1  0  1 , 
                               treat(initial) -2 -1 -1 -2 -1 -1 ; 

/* pages 353-354 of Categorical Data Analysis */

data wbeing;
     input #1 b1-b5 _type_ $ _name_ $8. #2 b6-b10;
     cards;
 7.24978   7.18991   7.35960   7.31937   7.55184 parms
 7.93726   7.92509   7.82815   7.73696   8.16791 
 0.01110   0.00101   0.00177  -0.00018  -0.00082 cov       b1
 0.00189  -0.00123   0.00434   0.00158  -0.00050 
 0.00101   0.02342   0.00144   0.00369   0.25300 cov       b2
 0.00118  -0.00629  -0.00059   0.00212  -0.00098 
 0.00177   0.00144   0.01060   0.00157   0.00226 cov       b3
 0.00140  -0.00088  -0.00055   0.00211   0.00239 
-0.00018   0.00369   0.00157   0.02298   0.00918 cov       b4
-0.00140  -0.00232   0.00023   0.00066  -0.00010 
-0.00082   0.00253   0.00226   0.00918   0.01921 cov       b5
 0.00039   0.00034  -0.00013   0.00240   0.00213 
 0.00189   0.00118   0.00140  -0.00140   0.00039 cov       b6
 0.00739   0.00019   0.00146  -0.00082   0.00076 
-0.00123  -0.00629  -0.00088  -0.00232   0.00034 cov       b7
 0.00019   0.01172   0.00183   0.00029   0.00083 
 0.00434  -0.00059  -0.00055   0.00023  -0.00013 cov       b8
 0.00146   0.00183   0.01050  -0.00173   0.00011 
 0.00158   0.00212   0.00211   0.00066   0.00240 cov       b9
-0.00082   0.00029  -0.00173   0.01335   0.00140 
-0.00050  -0.00098   0.00239  -0.00010   0.00213 cov      b10
 0.00076   0.00083   0.00011   0.00140   0.01430 
;  

/* pages 354-355 of Categorical Data Analysis */

proc catmod data=wbeing;
     response read b1-b10;
     factors sex $ 2, age $  5 / 
          _response_ = sex|age 
     profile = (female '25-34',
                female '35-44',
                female '45-54',
                female '55-64',
                female '65-74',
                male   '25-34',
                male   '35-44',
                male   '45-54',
                male   '55-64',
                male   '65-74');
     model _f_ = _response_; run ;

/* page 356 of Categorical Data Analysis */

proc catmod data=wbeing;
   response read b1-b10;
   factors sex $ 2, age $ 5 / 
     _response_ = sex age  
     profile = (male '25-34' ,
                male '35-44',
                male '45-54' ,
                male '55-64',
                male '65-74' ,
                female '25-34',
                female '35-44',
                female '45-54',
                female '55-64' ,
                female '65-74');
   model _f_ = _response_;

contrast '25-34 vs. 35-44' all_parms  0 0 1 -1  0  0 ;
contrast '25-34 vs. 45,54' all_parms  0 0 1  0 -1  0 ;
contrast '25-34 vs. 55,64' all_parms  0 0 1  0  0 -1 ;
contrast '25-34 vs. 65,74' all_parms  0 0 2  1  1  1 ;
run;

/* page 357 of Categorical Data Analysis */

contrast '25-64 the same'    all_parms  0 0 1 -1  0  0 ,
                             all_parms  0 0 1  0 -1  0 ,
                             all_parms  0 0 1  0  0 -1 ;
run;

/* page 358 of Categorical Data Analysis */

model _f_ = ( 1 0 0 ,
              1 0 0 ,
              1 0 0 ,
              1 0 0 ,
              1 0 1 ,
              1 1 0 ,
              1 1 0 ,
              1 1 0 ,
              1 1 0 ,
              1 1 1 );

/* page 359 of Categorical Data Analysis */

proc catmod data=wbeing; 
     response read b1-b10;
     factors sex $ 2, age $  5 / 
          _response_ = sex age 
     profile = (female '25-34',
                female '35-44',
                female '45-54',
                female '55-64',
                female '65-74',
                male   '25-34',
                male   '35-44',
                male   '45-54',
                male   '55-64',
                male   '65-74');
     model _f_ = ( 1 0 0 ,
                   1 0 0 ,
                   1 0 0 ,
                   1 0 0 ,
                   1 0 1 ,
                   1 1 0 ,
                   1 1 0 ,
                   1 1 0 ,
                   1 1 0 ,
                   1 1 1 ) (1='Intercept', 2='Sex', 3='65-74')
                           / pred;

/* pages 361-362 of Categorical Data Analysis */

data sheep ;
   input treatmnt $ size count @@ ;  
   ic=(treatmnt='control'); 
   ip=(treatmnt='pessary'); 
   if=(treatmnt='FSH-LH'); 
   ib=(treatmnt='both');   
   ipb = (treatmnt='pessary' or treatmnt='both'); 
   ifb = (treatmnt='FSH-LH' or treatmnt='both'); 
   cards ; 
   control 1 11 control 2 32 control 3  9 
   pessary 1 24 pessary 2 27 pessary 3  3 
   FSH-LH  1 12 FSH-LH  2 31 FSH-LH  3 15
   both    1 14 both    2 32 both    3  9  
   ;
run; 

proc catmod data=sheep order=data ;
   population treatmnt; 
   direct ic ip if ib ;   
   weight count ;
   response means ;  
   model size  = ic ip if ib / noint;
run ; 

/* page 364 of Categorical Data Analysis */

contrast 'treatments'  all_parms 1 0 0 -1 , 
                       all_parms 0 1 0 -1 ,                       
                       all_parms 0 0 1 -1 ; 
contrast 'FHS-LH'      all_parms 1 1 -1 -1 ; 
contrast 'pessary'     all_parms 1 -1 1 -1 ; 
contrast 'interaction' all_parms 1 -1 -1 1 ; 
run ;  

/* page 365 of Categorical Data Analysis */

direct ipb ifb ; 
model size = ifb ipb / pred; run ;        

/* page 366 of Categorical Data Analysis */

proc catmod data=sheep order=data ; 
   weight count ;
   response means ;  
   model size= ipb ifb ipb*ifb;
run ;     

/* Chapter 13 */

/* page 377 of Categorical Data Analysis */

data drug;
   input druga $ drugb $ drugc $ count;
   cards;
F F F  6
F F U 16
F U F  2
F U U  4
U F F  2
U F U  4
U U F  6
U U U  6
;  

proc catmod;
   weight count;
   response marginals;
   model druga*drugb*drugc=_response_ / oneway cov;
   repeated drug 3 / _response_=drug;
run; 

/* page 380 of Categorical Data Analysis */

contrast 'A versus C' _response_ 2 1;

/* page 382 of Categorical Data Analysis */

data church;
   input gender $ attend0 $ attend3 $ attend6 $ count;
cards;
F Y Y Y 904
F Y Y N  88
F Y N Y  25
F Y N N  51
F N Y Y  33
F N Y N  22
F N N Y  30
F N N N 158
M Y Y Y 391
M Y Y N  36
M Y N Y  12
M Y N N  26
M N Y Y  15
M N Y N  21
M N N Y  18
M N N N 143
;
proc catmod order=data;
   weight count;
   response marginals;
   model attend0*attend3*attend6=gender|_response_ / oneway;
   repeated year;
run;

/* page 383 of Categorical Data Analysis */

proc freq;
   weight count;
   by gender;
   tables attend0 attend3 attend6;
run;

/* page 385 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   response marginals;
   model attend0*attend3*attend6=gender _response_ / noprofile;
   repeated year;
run;

/* page 387 of Categorical Data Analysis */

data vision;
   input gender $ right left count;
cards;
F 1 1 1520
F 1 2  266
F 1 3  124
F 1 4   66
F 2 1  234
F 2 2 1512
F 2 3  432
F 2 4   78
F 3 1  117
F 3 2  362
F 3 3 1772
F 3 4  205
F 4 1   36
F 4 2   82
F 4 3  179
F 4 4  492
M 1 1  821
M 1 2  112
M 1 3   85
M 1 4   35
M 2 1  116
M 2 2  494
M 2 3  145
M 2 4   27
M 3 1   72
M 3 2  151
M 3 3  583
M 3 4   87
M 4 1   43
M 4 2   34
M 4 3  106
M 4 4  331
;

/* page 388 of Categorical Data Analysis */

proc catmod;
   weight count;
   response marginals;
   model right*left=gender _response_(gender='F') _response_(gender='M');
   repeated eye 2;
run;

/* page 390 of Categorical Data Analysis */

contrast 'Interaction' all_parms 0 0 0 0 0 0 1 0 0 -1  0  0,
                       all_parms 0 0 0 0 0 0 0 1 0  0 -1  0,
                       all_parms 0 0 0 0 0 0 0 0 1  0  0 -1;
run;

/* page 391 of Categorical Data Analysis */  

proc catmod;
   weight count;
   response means;
   model right*left=gender _response_(gender='F')
         _response_(gender='M') / noprofile;
   repeated eye;
run;

contrast 'Interaction' all_parms 0 0 1 -1;
run;

/* page 393 of Categorical Data Analysis */

data diagnos;
   input std1 $ test1 $ std2 $ test2 $ count;
   cards;
Neg Neg Neg Neg 509
Neg Neg Neg Pos   4
Neg Neg Pos Neg  17
Neg Neg Pos Pos   3
Neg Pos Neg Neg  13
Neg Pos Neg Pos   8
Neg Pos Pos Neg   0
Neg Pos Pos Pos   8
Pos Neg Neg Neg  14
Pos Neg Neg Pos   1
Pos Neg Pos Neg  17
Pos Neg Pos Pos   9
Pos Pos Neg Neg   7
Pos Pos Neg Pos   4
Pos Pos Pos Neg   9
Pos Pos Pos Pos 170
;
proc catmod;
   weight count;
   response marginals;
   model std1*test1*std2*test2=_response_ / oneway;
   repeated time 2, trtment 2 / _response_=time|trtment;
run;

/* page 395 of Categorical Data Analysis */

proc catmod;
   weight count;
   response marginals;
   model std1*test1*std2*test2=_response_ / noprofile;
   repeated time 2, trtment 2 / _response_=trtment;
run;

/* pages 397-398 of Categorical Data Analysis */

data wheeze;
   input wheeze9 $ wheeze10 $ wheeze11 $ wheeze12 $ count;
   cards;
Present Present Present Present   94
Present Present Present Absent    30
Present Present Absent  Present   15
Present Present Absent  Absent    28
Present Absent  Present Present   14
Present Absent  Present Absent     9
Present Absent  Absent  Present   12
Present Absent  Absent  Absent    63
Absent  Present Present Present   19
Absent  Present Present Absent    15
Absent  Present Absent  Present   10
Absent  Present Absent  Absent    44
Absent  Absent  Present Present   17
Absent  Absent  Present Absent    42
Absent  Absent  Absent  Present   35
Absent  Absent  Absent  Absent   572
;
proc catmod order=data;
   weight count;
   response marginals;
   model wheeze9*wheeze10*wheeze11*wheeze12=_response_ / oneway;
   repeated age;
run;

/* page 399 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   response marginals;
   model wheeze9*wheeze10*wheeze11*wheeze12=(1  9,
                                             1 10,
                                             1 11,
                                             1 12)
                                            (1='Intercept',
                                             2='Linear Age') / noprofile;
run;

/* page 401 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   response logits;
   model wheeze9*wheeze10*wheeze11*wheeze12=(1  9,
                                             1 10,
                                             1 11,
                                             1 12)
                                            (1='Intercept',
                                             2='Linear Age') / noprofile;
run;

/* pages 403-404 of Categorical Data Analysis */

data collisn;
   input program $ gender $ coll1 $ coll2 $ coll3 $ count;
   cards;
 SPC     Male   Yes Yes Yes   19
 SPC     Male   No  No  No  1467
 SPC     Male   No  No  Yes  295
 SPC     Male   No  Yes No   305
 SPC     Male   No  Yes Yes   79
 SPC     Male   Yes No  No   190
 SPC     Male   Yes No  Yes   68
 SPC     Male   Yes Yes No    60
 SPC     Female No  No  No  1659
 SPC     Female No  No  Yes  218
 SPC     Female No  Yes No   217
 SPC     Female No  Yes Yes   28
 SPC     Female Yes No  No   120
 SPC     Female Yes No  Yes   30
 SPC     Female Yes Yes No    17
 SPC     Female Yes Yes Yes    4
 PDL     Male   No  No  No  1495
 PDL     Male   No  No  Yes  264
 PDL     Male   No  Yes No   278
 PDL     Male   No  Yes Yes   80
 PDL     Male   Yes No  No   206
 PDL     Male   Yes No  Yes   52
 PDL     Male   Yes Yes No    46
 PDL     Male   Yes Yes Yes   25
 PDL     Female No  No  No  1618
 PDL     Female No  No  Yes  228
 PDL     Female No  Yes No   191
 PDL     Female No  Yes Yes   24
 PDL     Female Yes No  No   122
 PDL     Female Yes No  Yes   12
 PDL     Female Yes Yes No    17
 PDL     Female Yes Yes Yes    3
 Control Male   No  No  No  1552
 Control Male   No  No  Yes  288
 Control Male   No  Yes No   271
 Control Male   No  Yes Yes   94
 Control Male   Yes No  No   167
 Control Male   Yes No  Yes   47
 Control Male   Yes Yes No    55
 Control Male   Yes Yes Yes   23
 Control Female No  No  No  1640
 Control Female No  No  Yes  217
 Control Female No  Yes No   185
 Control Female No  Yes Yes   24
 Control Female Yes No  No    96
 Control Female Yes No  Yes   13
 Control Female Yes Yes No    16
 Control Female Yes Yes Yes    2
;
run;

/* pages 404-405 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   response logits;
   model coll1*coll2*coll3=program|gender program|_response_
                           gender|_response_ / oneway nodesign noparm;
   repeated year;
run;

/* page 406 of Categorical Data Analysis */

model coll1*coll2*coll3=program|_response_ gender|_response_
                        / noprofile nodesign noparm;
run;

/* pages 407-408 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   population program gender;
   response logits;
   model coll1*coll2*coll3=(1  0  0  1  1  0  0  0  0  1  0  0,
                            1  1  0  0  0  1  1  0  0  0  1  0,
                            1  1  1  0  0  0  0  1  1  0  0  1,
                            1  0  0  1  1  0  0  0  0  0  0  0,
                            1  1  0  0  0  1  1  0  0  0  0  0,
                            1  1  1  0  0  0  0  1  1  0  0  0,
                            1  0  0  1 -1  0  0  0  0  1  0  0,
                            1  1  0  0  0  1 -1  0  0  0  1  0,
                            1  1  1  0  0  0  0  1 -1  0  0  1,
                            1  0  0  1 -1  0  0  0  0  0  0  0,
                            1  1  0  0  0  1 -1  0  0  0  0  0,
                            1  1  1  0  0  0  0  1 -1  0  0  0,
                            1  0  0 -2  0  0  0  0  0  1  0  0,
                            1  1  0  0  0 -2  0  0  0  0  1  0,
                            1  1  1  0  0  0  0 -2  0  0  0  1,
                            1  0  0 -2  0  0  0  0  0  0  0  0,
                            1  1  0  0  0 -2  0  0  0  0  0  0,
                            1  1  1  0  0  0  0 -2  0  0  0  0)
                           (1='Intercept',
                          2 3='Year',
                            2='  Year 2 Increment',
                            3='  Year 3 Increment',
                  4 5 6 7 8 9='Program',
                          4 5='  Year 1',
                            4='    Education',
                            5='    Method', 
                          6 7='  Year 2',
                            6='    Education',
                            7='    Method', 
                          8 9='  Year 3',
                            8='    Education',
                            9='    Method',
                     10 11 12='Gender',
                           10='  Year 1',
                           11='  Year 2',
                           12='  Year 3') / noprofile;
run;

/* page 409 of Categorical Data Analysis */

contrast 'Education x Year'   all_parms 0 0 0 1 0 0 0 -1  0 0 0 0,
                              all_parms 0 0 0 0 0 1 0 -1  0 0 0 0;
contrast 'Method x Year'      all_parms 0 0 0 0 1 0 0  0 -1 0 0 0,
                              all_parms 0 0 0 0 0 0 1  0 -1 0 0 0;
run;

/* page 410 of Categorical Data Analysis */

contrast 'Method Effects'     all_parms 0 0 0 0 1 0 0  0  0 0 0 0,
                              all_parms 0 0 0 0 0 0 1  0  0 0 0 0,
                              all_parms 0 0 0 0 0 0 0  0  1 0 0 0;
contrast 'Educ. (yrs. 2 & 3)' all_parms 0 0 0 0 0 1 0  0  0 0 0 0,
                              all_parms 0 0 0 0 0 0 0  1  0 0 0 0;
run;

/* pages 410-411 of Categorical Data Analysis */

model coll1*coll2*coll3=(1 0 0 1 1 0 0,
                         1 1 0 0 0 1 0,
                         1 1 1 0 0 0 1,
                         1 0 0 1 0 0 0,
                         1 1 0 0 0 0 0,
                         1 1 1 0 0 0 0,
                         1 0 0 1 1 0 0,
                         1 1 0 0 0 1 0,
                         1 1 1 0 0 0 1,
                         1 0 0 1 0 0 0,
                         1 1 0 0 0 0 0,
                         1 1 1 0 0 0 0,
                         1 0 0 0 1 0 0,
                         1 1 0 0 0 1 0,
                         1 1 1 0 0 0 1,
                         1 0 0 0 0 0 0,
                         1 1 0 0 0 0 0,
                         1 1 1 0 0 0 0)
                        (1='Intercept',
                       2 3='Year',
                         2='  Year 2 Increment',
                         3='  Year 3 Increment',
                         4='Year 1 Education',
                     5 6 7='Gender',
                         5='  Year 1',
                         6='  Year 2',
                         7='  Year 3') / noprofile;
run;

/* page 412 of Categorical Data Analysis */

contrast 'Equal. of Gender Effects' all_parms 0 0 0 0 1 -1  0,
                                    all_parms 0 0 0 0 1  0 -1;
contrast '   Year 1=Year 2'         all_parms 0 0 0 0 1 -1  0;
contrast '   Year 1=Year 3'         all_parms 0 0 0 0 1  0 -1;
contrast '   Year 2=Year 3'         all_parms 0 0 0 0 0  1 -1;
contrast 'Gender Nonlinearity'      all_parms 0 0 0 0 1 -2  1; 
run;

/* Chapter 14 */

/* page 431 of Categorical Data Analysis */

data bicycle;
   input type $ helmet $ count;
   cards;
Mountain Yes  34
Mountain No   32
Other    Yes  10
Other    No   24
; 
run;

proc catmod;
   weight count;
   model type*helmet=_response_ / noresponse noiter noparm;
   loglin type|helmet;
run; 

/* page 433 of Categorical Data Analysis */

proc catmod;
   weight count;
   model type*helmet=_response_ /  noprofile noresponse noiter noparm;
   loglin type helmet;
run;

proc freq order=data;
   weight count;
   tables type*helmet / nopercent norow chisq;
run;

/* pages 435-436 of Categorical Data Analysis */

data melanoma;
   input type $ site $ count;
   cards;
Hutchinson's  Head&Neck    22
Hutchinson's  Trunk         2
Hutchinson's  Extremities  10
Superficial   Head&Neck    16
Superficial   Trunk        54
Superficial   Extremities 115
Nodular       Head&Neck    19
Nodular       Trunk        33
Nodular       Extremities  73
Indeterminate Head&Neck    11
Indeterminate Trunk        17
Indeterminate Extremities  28
;
run;

proc catmod;
   weight count;
   model type*site=_response_ / noresponse noiter noparm;
   loglin type site;
run;

/* page 442 of Categorical Data Analysis */

data satisfac;
   input managmnt $ supervis $ worker $ count;
   cards;
Bad  Low  Low  103
Bad  Low  High  87
Bad  High Low   32
Bad  High High  42
Good Low  Low   59
Good Low  High 109
Good High Low   78
Good High High 205
;
proc catmod order=data;
   weight count;
   model managmnt*supervis*worker=_response_ / noresponse noiter noparm;
   loglin managmnt|supervis|worker;
run;

/* page 443 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   model managmnt*supervis*worker=_response_
         / noprofile noresponse noiter p=freq;
   loglin managmnt|supervis managmnt|worker supervis|worker;
run;

/* page 444 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   model managmnt*supervis*worker=_response_
         / noprofile noresponse noiter noparm;
   loglin managmnt|supervis managmnt|worker;
proc catmod order=data;
   weight count;
   model managmnt*supervis*worker=_response_
         / noprofile noresponse noiter noparm;
   loglin managmnt|supervis supervis|worker;
proc catmod order=data;
   weight count;
   model managmnt*supervis*worker=_response_
         / noprofile noresponse noiter noparm;
   loglin managmnt|worker supervis|worker;
run;

/* pages 448-449 of Categorical Data Analysis */

data cancer;
   input news $ radio $ reading $ lectures $ knowledg $ count;
   cards;
Yes Yes Yes Yes  Good  23
Yes Yes Yes Yes  Poor   8
Yes Yes Yes No   Good 102
Yes Yes Yes No   Poor  67
Yes Yes No  Yes  Good   8
Yes Yes No  Yes  Poor   4
Yes Yes No  No   Good  35
Yes Yes No  No   Poor  59
Yes No  Yes Yes  Good  27
Yes No  Yes Yes  Poor  18
Yes No  Yes No   Good 201
Yes No  Yes No   Poor 177
Yes No  No  Yes  Good   7
Yes No  No  Yes  Poor   6
Yes No  No  No   Good  75
Yes No  No  No   Poor 156
No  Yes Yes Yes  Good   1
No  Yes Yes Yes  Poor   3
No  Yes Yes No   Good  16
No  Yes Yes No   Poor  16
No  Yes No  Yes  Good   4
No  Yes No  Yes  Poor   3
No  Yes No  No   Good  13
No  Yes No  No   Poor  50
No  No  Yes Yes  Good   3
No  No  Yes Yes  Poor   8
No  No  Yes No   Good  67
No  No  Yes No   Poor  83
No  No  No  Yes  Good   2
No  No  No  Yes  Poor  10
No  No  No  No   Good  84
No  No  No  No   Poor 393
;
proc catmod order=data;
   weight count;
   model news*radio*reading*lectures*knowledg=_response_
         / noresponse noiter noparm;
   loglin news|radio|reading|lectures      news|radio|reading|knowledg
          news|radio|lectures|knowledg     news|reading|lectures|knowledg
          radio|reading|lectures|knowledg;
run;

/* page 451 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   model news*radio*reading*lectures*knowledg=_response_
         / noprofile noresponse noiter noparm;
   loglin news|radio|reading       news|radio|lectures
          news|radio|knowledg      news|reading|lectures
          news|reading|knowledg    news|lectures|knowledg
          radio|reading|lectures   radio|reading|knowledg
          radio|lectures|knowledg  reading|lectures|knowledg;
run; 

/* page 452 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   model news*radio*reading*lectures*knowledg=_response_
         / noprofile noresponse noiter noparm;
   loglin news|radio               radio|reading
          radio|lectures           radio|knowledg
          news|reading|knowledg    news|lectures|knowledg
          reading|lectures|knowledg;
run;

/* pages 453-454 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   model news*radio*reading*lectures*knowledg=_response_
         / noprofile noresponse noiter noparm;
   loglin news|radio               radio|lectures
          radio|knowledg           news|reading|knowledg
          news|lectures|knowledg   reading|lectures|knowledg;
run;

/* page 455 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   model news*radio*reading*lectures*knowledg=_response_
         / noprofile noresponse noiter noparm;
   loglin news|radio               radio|lectures
          radio|knowledg           reading|knowledg
          news|knowledg            lectures|knowledg
          news*reading(knowledg='Good')
          news*reading(knowledg='Poor')
          news*lectures(knowledg='Good')
          news*lectures(knowledg='Poor')
          reading*lectures(knowledg='Good')
          reading*lectures(knowledg='Poor');
run;

/* page 456 of Categorical Data Analysis */

proc catmod order=data;
   weight count;
   model news*radio*reading*lectures*knowledg=_response_
         / noprofile noresponse noiter;
   loglin news|radio               radio|lectures
          radio|knowledg           reading|knowledg
          news|knowledg            lectures|knowledg
          news*reading(knowledg='Good')
          news*reading(knowledg='Poor')
          news*lectures(knowledg='Good')
          reading*lectures(knowledg='Poor');
run;

/* page 458 of Categorical Data Analysis */

data satisfac;
   input managmnt $ supervis $ worker $ count;
   cards;
Bad  Low  Low  103
Bad  Low  High  87
Bad  High Low   32
Bad  High High  42
Good Low  Low   59
Good Low  High 109
Good High Low   78
Good High High 205
;
proc catmod order=data;
   weight count;
   model worker=managmnt supervis / noprofile noresponse noiter p=freq;  
run;


