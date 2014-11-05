/*-------------------------------------------------------------------*/
/*          A Handbook of Statistical Analyses Using SAS,            */
/*                         Second Edition                            */
/*                by Geoff Der and Brian Everitt                     */
/*         Copyright(c) 2001 by Chapman & Hall / CRC Press           */
/*                        ISBN 1-58488-245-X                         */
/*-------------------------------------------------------------------*/
/* Provided with permission from Chapman & Hall / CRC Press          */
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
/* Attn: Geoff Der and Brian Everitt                                 */
/* SAS Campus Drive                                                  */
/* Cary, NC   27513                                                  */
/*                                                                   */
/*                                                                   */
/* If you prefer, you can send email to:  sasbbu@sas.com             */
/* Use this for subject field:                                       */
/*     Comments for Geoff Der and Brian Everitt                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Date Last Updated:   04OCT01                                      */
/*-------------------------------------------------------------------*/
/* 
******************** NOTES and WARNINGS ************************
The SAS programs below differ in several ways from those given 
in the book.

INSTREAM DATA
To make the examples simpler to run, all the raw data used are 
instream (ie within the data step). The original statements used
have been commented out and new statements added below where 
necessary.  
Where the data are instream the infile statement is only needed 
when options are required. 
'Cards' and 'datalines' are synonyms.

Where a data set is used in more than one chapter, the data are 
provided for the first occurence only.

WARNING
Within the Enhanced Editor, the effect of the expandtabs option 
depends on the tab size setting. This should be set to 8 and the
'insert spaces for tabs' box unchecked (see section 1.2.1 and 
Display 1.2).

EXERCISES
The answers to the exercises are included at the end of the 
chapter to which they relate.

SCATTERPLOT MACRO
The macro is listed at the end of this file.  It can be selected
and submitted from there, or copied to an external file and a 
%include statement used as in the book.

SYSTEM SETTINGS
The graphics and system options used for the book were set as follows:
goptions reset=all;
goptions device=win target=winprtm rotate=landscape ftext=swiss lfactor=10;
options ps=70 ls=100 nodate nonumber center;

USING THIS FILE
All the programs and data have been put in this one file to simplify
downloading. Some comments have been added to aid navigation when 
the code is 'collapsed'. If working with the single, large file proves
unweildy, it could be split into separate chapters after making 
allowance for data sets used repeatedly and the scatter plot macro.
*/


data bodyfat;                          /* Chapter 1 */
   Input age pctfat;
datalines;
23	28
39	31
41	26
49	25
50	31
53	35
53	42
54	29
56	33
57	30
58	33
58	34
60	41
61	34
;
proc print data=bodyfat;
run;
proc corr data=bodyfat;
run;

/* Chapter 2 */

data water;                            /* Chapter 2 */
*    infile 'n:\handbook\datasets\water.dat';
    input flag $ 1 Town $ 2-18 Mortal 19-22 Hardness 25-27;
    if flag='*' then location='north';
        else location='south';
*run;
cards;
 Bath             1247  105        
*Birkenhead       1668  17         
 Birmingham       1466  5          
*Blackburn        1800  14         
*Blackpool        1609  18         
*Bolton           1558  10         
*Bootle           1807  15         
 Bournemouth      1299  78         
*Bradford         1637  10         
 Brighton         1359  84         
 Bristol          1392  73         
*Burnley          1755  12         
 Cardiff          1519  21    
 Coventry         1307  78         
 Croydon          1254  96         
*Darlington       1491  20         
*Derby            1555  39         
*Doncaster        1428  39         
 East Ham         1318  122        
 Exeter           1260  21         
*Gateshead        1723  44         
*Grimsby          1379  94         
*Halifax          1742  8          
*Huddersfield     1574  9          
*Hull             1569  91         
 Ipswich          1096  138        
*Leeds            1591  16         
 Leicester        1402  37         
*Liverpool        1772  15         
*Manchester       1828  8          
*Middlesbrough    1704  26         
*Newcastle        1702  44              
 Newport          1581  14    
 Northampton      1309  59    
 Norwich          1259  133   
*Nottingham       1427  27    
*Oldham           1724  6     
 Oxford           1175  107   
 Plymouth         1486  5     
 Portsmouth       1456  90    
*Preston          1696  6     
 Reading          1236  101   
*Rochdale         1711  13    
*Rotherham        1444  14    
*St Helens        1591  49    
*Salford          1987  8     
*Sheffield        1495  14    
 Southampton      1369  68    
 Southend         1257  50    
*Southport        1587  75    
*South Shields    1713  71    
*Stockport        1557  13    
*Stoke            1640  57  
*Sunderland       1709  71    
 Swansea          1625  13    
*Wallasey         1625  20    
 Walsall          1527  60    
 West Bromwich    1627  53    
 West Ham         1486  122
 Wolverhampton    1485  81    
*York             1378  71    
;

proc univariate data=water normal;
  var mortal hardness;
  histogram mortal hardness /normal;
  probplot mortal hardness;
run; 

proc gplot;
  plot mortal*hardness;
run;

proc corr data=water pearson spearman;
  var mortal hardness;
run;

symbol1 value=dot;
symbol2 value=circle;
proc gplot;
  plot mortal*hardness=location;
run;
run cancel;

proc sort;
   by location;
run;
proc corr data=water pearson spearman;
  var mortal hardness;
  by location;
run;

data water;
   set water;
   lhardnes=log(hardness);
run;

proc ttest data=water;
   class location;
   var mortal hardness lhardnes;
run;

proc npar1way data=water wilcoxon;
   class location;
   var hardness;
run;

proc kde data=water out=bivest;
  var mortal hardness;
run;

proc g3d data=bivest;
  plot hardness*mortal=density;
run;

/* exercises */

proc univariate data=water normal plot;  /* 2.1 */
  var mortal hardness;
run; 

proc sort data=water;                    /* 2.2 */
  by location;
run;
proc boxplot data=water;
  plot (mortal hardness)*location;
run;

proc univariate data=water normal;       /* 2.3 */
  var hardness;
  histogram hardness / lognormal(theta=est) exponential(theta=est);
  probplot hardness / lognormal(theta=est sigma=est zeta=est);
  probplot hardness / exponential (theta=est sigma=est);
run; 

proc univariate data=water;              /* 2.4 */
  var mortal hardness;
  histogram mortal hardness /kernel ;
run; 

proc sort data=water;                    /* 2.5 */
  by location;
run;
proc kde data=water out=bivest;
  var mortal hardness;
  by location;
run;
proc g3d data=bivest;
  plot hardness*mortal=density;
  by location;
run;

proc gplot data=water;                   /* 2.6 */   
  plot mortal*hardness=location;
  symbol1 v=dot i=r l=1;
  symbol2 v=circle i=r l=2;
run;

/* Chapter 3 */
/*
data water;
    infile 'n:\handbook\datasets\water.dat';
    input flag $ 1 Town $ 2-18 Mortal 19-22 Hardness 25-27;
    if flag='*' then location='north';
        else location='south';
    mortgrp=mortal > 1555;
    hardgrp=hardness > 39;
run;
*/

data water;                            /* Chapter 3 */
  set water;   /* having created the water data set as above for chapter 2 */
  mortgrp=mortal > 1555;
  hardgrp=hardness > 39;
run;

proc freq data=water;
  tables mortgrp*hardgrp /chisq;
run;

data sandflies;
    input sex $ height n;
cards;
m 3  173
m 35 125
f 3  150
f 35  73
;
run;

proc freq data=sandflies;
  tables sex*height /chisq riskdiff;
  weight n;
run;

data ants;
  input species $ invaded $ n;
cards;
A no 2
A yes 13
B no 10 
B no 3
;
run;

proc freq data=ants;
  tables species*invaded / chisq expected;
  weight n;
run;

data pistons;
  input machine site $ n;
cards;
1 North  17
1 Centre 17 
1 South  12
2 North  11
2 Centre  9 
2 South  13
3 North  11
3 Centre  8 
3 South  19
4 North  14
4 Centre  7 
4 South  28
;
run;

proc freq data=pistons order=data;
  tables machine*site / chisq deviation cellchi2 norow nocol nopercent;
  weight n;
run;

data the_pill;
  input caseuse $ contruse $ n;
cards;
Y Y 10
Y N 57
N Y 13
N N 95
;
run;

proc freq data=the_pill order=data;
 tables caseuse*contruse / agree;
 weight n;
run;

data lesions;
  length region $8.;
  input site $ 1-16 n1 n2 n3;
  region='Keral';
  n=n1;
  output;
  region='Gujarat';
  n=n2;
  output;
  region='Anhara';
  n=n3;
  output;
  drop n1-n3;
cards;
Buccal Mucosa    8  1  8
Labial Mucosa    0  1  0
Commissure       0  1  0
Gingiva          0  1  0
Hard palate      0  1  0
Soft palate      0  1  0
Tongue           0  1  0
Floor of mouth   1  0  1
Alveolar ridge   1  0  1
;
run;

proc freq data=lesions order=data;
  tables site*region /exact;
  weight n;
  run;

data bronchitis;
  input agegrp level $ bronch $ n;
cards;
1 H Y 20
1 H N 382
1 L Y 9 
1 L N 214
2 H Y 10
2 H N 172
2 L Y 7
2 L N 120
3 H Y 12
3 H N 327
3 L Y 6
3 L N 183
;

proc freq data=bronchitis order=data;
  Tables agegrp*level*bronch / cmh noprint;
  weight n;
run;

/*  exercises  */

data pill2;                                    /* 3.1 */
  set the_pill;
  use=caseuse;
  case='Y';
  output;
  use=contruse;
  case='N';
  output;
run;
proc freq data=pill2;
  tables case*use /riskdiff;
  weight n;
run;

proc freq data=pistons order=data;             /* 3.2 */
  tables machine*site / out=tabout outexpect outpct;
  weight n;
run;
data resids;
  set tabout;
  r=(count-expected)/sqrt(expected);
  radj=r/sqrt((1-percent/pct_row)*(1-percent/pct_col));
run;
proc tabulate data=resids;
  class machine site;
  var r radj;
  table machine,
        site*r;
  table machine,
        site*radj;
run;

data lesions2;                                 /* 3.3 */
   set lesions;
   region2=region;
   if region ne 'Gujarat' then region2='Others';
run;
proc freq data=lesions2 order=data;
  tables site*region2 /exact;
  weight n;
  run;

/* Chapter 4 */

data uscrime;                          /* Chapter 4 */
*    infile 'n:\handbook2\datasets\uscrime.dat' expandtabs;
  infile cards expandtabs;
  input R Age S Ed Ex0 Ex1 LF M N NW U1 U2 W X;
cards;
79.1	151	1	91	58	56	510	950	33	301	108	41	394	261
163.5	143	0	113	103	95	583	1012	13	102	96	36	557	194
57.8	142	1	89	45	44	533	969	18	219	94	33	318	250
196.9	136	0	121	149	141	577	994	157	80	102	39	673	167
123.4	141	0	121	109	101	591	985	18	30	91	20	578	174
68.2	121	0	110	118	115	547	964	25	44	84	29	689	126
96.3	127	1	111	82	79	519	982	4	139	97	38	620	168
155.5	131	1	109	115	109	542	969	50	179	79	35	472	206
85.6	157	1	90	65	62	553	955	39	286	81	28	421	239
70.5	140	0	118	71	68	632	1029	7	15	100	24	526	174
167.4	124	0	105	121	116	580	966	101	106	77	35	657	170
84.9	134	0	108	75	71	595	972	47	59	83	31	580	172
51.1	128	0	113	67	60	624	972	28	10	77	25	507	206
66.4	135	0	117	62	61	595	986	22	46	77	27	529	190
79.8	152	1	87	57	53	530	986	30	72	92	43	405	264
94.6	142	1	88	81	77	497	956	33	321	116	47	427	247
53.9	143	0	110	66	63	537	977	10	6	114	35	487	166
92.9	135	1	104	123	115	537	978	31	170	89	34	631	165
75.0	130	0	116	128	128	536	934	51	24	78	34	627	135
122.5	125	0	108	113	105	567	985	78	94	130	58	626	166
74.2	126	0	108	74	67	602	984	34	12	102	33	557	195
43.9	157	1	89	47	44	512	962	22	423	97	34	288	276
121.6	132	0	96	87	83	564	953	43	92	83	32	513	227
96.8	131	0	116	78	73	574	1038	7	36	142	42	540	176
52.3	130	0	116	63	57	641	984	14	26	70	21	486	196
199.3	131	0	121	160	143	631	1071	3	77	102	41	674	152
34.2	135	0	109	69	71	540	965	6	4	80	22	564	139
121.6	152	0	112	82	76	571	1018	10	79	103	28	537	215
104.3	119	0	107	166	157	521	938	168	89	92	36	637	154
69.6	166	1	89	58	54	521	973	46	254	72	26	396	237
37.3	140	0	93	55	54	535	1045	6	20	135	40	453	200
75.4	125	0	109	90	81	586	964	97	82	105	43	617	163
107.2	147	1	104	63	64	560	972	23	95	76	24	462	233
92.3	126	0	118	97	97	542	990	18	21	102	35	589	166
65.3	123	0	102	97	87	526	948	113	76	124	50	572	158
127.2	150	0	100	109	98	531	964	9	24	87	38	559	153
83.1	177	1	87	58	56	638	974	24	349	76	28	382	254
56.6	133	0	104	51	47	599	1024	7	40	99	27	425	225
82.6	149	1	88	61	54	515	953	36	165	86	35	395	251
115.1	145	1	104	82	74	560	981	96	126	88	31	488	228
88.0	148	0	122	72	66	601	998	9	19	84	20	590	144
54.2	141	0	109	56	54	523	968	4	2	107	37	489	170
82.3	162	1	99	75	70	522	996	40	208	73	27	496	224
103.0	136	0	121	95	96	574	1012	29	36	111	37	622	162
45.5	139	1	88	46	41	480	968	19	49	135	53	457	249
50.8	126	0	104	106	97	599	989	40	24	78	25	593	171
84.9	130	0	121	90	91	623	1049	3	22	113	40	588	160
;

/* 
%include 'n:\sasjobs\macs\scattmat.sas';
The macro is listed at the end of this file.
*/
%scattmat(uscrime,R--X);

proc reg data=uscrime;
    model R= Age--X / vif;
run;

proc reg data=uscrime;
    model R= Age--Ed Ex1--X / vif;
run;

proc reg data=uscrime;
    model R= Age--Ed Ex1--X / selection=stepwise sle=.05 sls=.05;
    plot student.*(ex1 x ed age u2);
    plot student.*predicted. cookd.*obs.;
    plot npp.*residual.;
run;

/* exercises */

proc reg data=uscrime;                            /* 4.1 */
    model R= Age--Ed Ex1--X / selection=cp;
run;

proc reg data=uscrime;                            /* 4.2 */
    model R= Age Ed Ex1 U2 X / selection=cp start=1 stop=5;
	plot cp.*np. / cmallows=black;
run;

data uscrime;                                     /* 4.5 */
  set uscrime;
  age_s=age*s;
run;

proc reg data=uscrime;
   model R=age s age_s;
   output out=regout p=rhat;
run;

proc gplot data=regout;
   plot rhat*age=s / vaxis=axis1;
   plot2 r*age=s /vaxis=axis1;
   symbol1 i=join v=none l=1;
   symbol2 i=join v=none l=2;
   symbol3 v=dot;
   symbol4 v=circle;
   axis1 order=20 to 200 by 10;
run;

/* Chapter 5 */

data hyper;                            /* Chapter 5 */
*  infile 'N:\handbook2\datasets\hypertension.dat';
  input n1-n12;
  if _n_<4 then biofeed='P';
           else biofeed='A';
  if _n_ in(1,4) then drug='X';
  if _n_ in(2,5) then drug='Y';
  if _n_ in(3,6) then drug='Z';
  array nall {12} n1-n12;
  do i=1 to 12;
      if i>6 then diet='Y';
	         else diet='N';
	  bp=nall{i};
	  cell=drug||biofeed||diet;
	  output;
  end;
  drop i n1-n12;
cards;
170 175 165 180 160 158 161 173 157 152 181 190
186 194 201 215 219 209 164 166 159 182 187 174
180 187 199 170 204 194 162 184 183 156 180 173
173 194 197 190 176 198 164 190 169 164 176 175
189 194 217 206 199 195 171 173 196 199 180 203
202 228 190 206 224 204 205 199 170 160 179 179
;
 
proc print data=hyper;
run;

proc tabulate data=hyper;
  class  drug diet biofeed;
  var bp;
  table drug*diet*biofeed,
        bp*(mean std n);
run;

proc anova data=hyper;
  class cell;
  model bp=cell;
  means cell / hovtest;
  run;

proc anova data=hyper;
  class diet drug biofeed;
  model bp=diet|drug|biofeed;
  means diet*drug*biofeed;
  ods output means=outmeans;
run;

proc print data=outmeans;
run;

proc sort data=outmeans;
 by drug;
run;

symbol1 i=join v=none l=2;
symbol2 i=join v=none l=1;

proc gplot data=outmeans;
  plot mean_bp*biofeed=diet ;
  by drug;
run;

data hyper;
  set hyper;
  logbp=log(bp);
run;

proc anova data=hyper;
  class diet drug biofeed;
  model logbp=diet|drug|biofeed;
  run;

proc anova data=hyper;
  class diet drug biofeed;
  model logbp=diet drug biofeed;
  means drug / scheffe;
run;

/* exercises */

proc anova data=hyper;                    /* 5.1 */
  class diet drug biofeed;
  model logbp=diet drug biofeed;
  means drug / bon duncan;
run;

proc sort data=hyper;                     /* 5.2 */
  by diet;
proc boxplot data=hyper;
  plot logbp*diet;
run;
proc sort data=hyper;
  by drug;
proc boxplot data=hyper;
  plot logbp*drug;
run;
proc sort data=hyper;
  by biofeed;
proc boxplot data=hyper;
  plot logbp*biofeed;
run;

/* Chapter 6 */

data ozkids;                           /* Chapter 6 */
*    infile 'n:\handbook2\datasets\ozkids.dat' dlm=' ,' expandtabs missover;
  infile cards dlm=' ,' expandtabs missover;
    input cell origin $ sex $ grade $ type $ days @;
	do until (days=.);
	  output;
	  input days @;
	end;
	input;
*run;
cards;
1	A	M	F0	SL	2,11,14
2	A	M	F0	AL	5,5,13,20,22
3	A	M	F1	SL	6,6,15
4	A	M	F1	AL	7,14
5	A	M	F2	SL	6,32,53,57
6	A 	M	F2	AL	14,16,16,17,40,43,46
7	A	M	F3	SL	12,15
8	A	M	F3	AL	8,23,23,28,34,36,38
9	A	F	F0	SL	3
10	A 	F	F0	AL	5,11,24,45
11	A	F	F1	SL	5,6,6,9,13,23,25,32,53,54
12	A	F	F1	AL	5,5,11,17,19
13	A	F	F2	SL	8,13,14,20,47,48,60,81
14	A	F	F2	AL	2
15	A	F	F3	SL	5,9,7
16	A	F	F3	AL	0,2,3,5,10,14,21,36,40
17	N	M	F0	SL	6,17,67
18	N	M	F0	AL	0,0,2,7,11,12
19	N	M	F1	SL	0,0,5,5,5,11,17
20	N	M	F1	AL	3,3
21	N	M	F2	SL	22,30,36
22	N	M	F2	AL	8,0,1,5,7,16,27
23	N	M	F3	SL	12,15
24	N	M	F3	AL	0,30,10,14,27,41,69
25	N	F	F0	SL	25
26	N	F	F0	AL	10,11,20,33
27	N	F	F1	SL	5,7,0,1,5,5,5,5,7,11,15
28	N	F	F1	AL	5,14,6,6,7,28
29	N	F	F2	SL	0,5,14,2,2,3,8,10,12
30	N	F	F2	AL	1
31	N	F	F3	SL	8
32	N	F	F3	AL	1,9,22,3,3,5,15,18,22,37
;
 
proc glm data=ozkids;
  class origin sex grade type;
  model days=origin sex grade type /ss1 ss3;
run;
proc glm data=ozkids;
  class origin sex grade type;
  model days=grade sex type origin  /ss1;
run;
proc glm data=ozkids;
  class origin sex grade type;
  model days=type sex origin grade /ss1;
run;
proc glm data=ozkids;
  class origin sex grade type;
  model days=sex origin type grade /ss1;
run;

proc glm data=ozkids;
  class origin sex grade type;
  model days=origin sex grade type origin|sex|grade|type /ss1 ss3;
run;

/* exercises  */
                                                 /* 6.1 */
/* use @ to restrict the expansion of the bar operator eg.
  model days=type|sex|origin|grade@3 /ss2 ss3;
or
  model days=type|sex|origin|grade@2 /ss2 ss3;
*/

data ozkids;                                     /* 6.2 */
  set ozkids;
  logdays=log(days+0.5);
run;


proc tabulate data=ozkids f=6.2;                 /* 6.3 */
  class type sex origin grade;
  var days;
  table sex*grade,
        origin*type*days*(mean std);
run;

proc glm data=ozkids noprint;                    /* 6.4 */
  class origin sex grade type;
  model days=origin sex grade type;
  output out=glmout r=res;
run;

proc univariate data=glmout noprint;
var res;
probplot;
run;

/* Chapter 7 */

data vision;                           /* Chapter 7 */
*  infile 'n:\handbook2\datasets\visual.dat' expandtabs;
  infile cards expandtabs;
  input idno x1-x8;
*run;
cards;
1	116	119	116	124	120	117	114	122
2	110	110	114	115	106	112	110	110
3	117	118	120	120	120	120	120	124
4	112	116	115	113	115	116	116	119
5	113	114	114	118	114	117	116	112
6	119	115	94	116	100	99	94	97
7	110	110	105	118	105	105	115	115
;
 
proc glm data=vision;
  model x1-x8= /nouni;
  repeated eye 2, strength 4 /summary ;
run;


proc glm data=vision;
  model x1-x8= /nouni;
  repeated eye 2, strength 4 (1 3 6 10) polynomial /summary;
run;

/* exercises */

/* restructure data for 7.1 and 7.2 */

data vision2;
  set vision;
  array xall {8} x1-x8;
  do i=1 to 8;
    if i > 4 then eye='R';
	         else eye='L';
    select(i);
      when(1,5) strength=1;
      when(2,6) strength=3;
      when(3,7) strength=6;
      when(4,8) strength=10;
    end;
  response=xall{i};
  output;
  end;
  drop i x1-x8;
run;

proc gplot data=vision2;                         /* 7.1 */
 plot response*strength=eye;
 symbol1 i=std1mj l=1;
 symbol2 i=std1mj l=2;
 run;

proc sort data=vision2;                          /* 7.2 */
  by eye strength;
run;

proc boxplot data=vision2;
  plot response*strength;
  by eye;
run;

proc corr data=vision;                           /* 7.3 */
  var x1-x8;
run;

/* Chapter 8 */

data ghq;                              /* Chapter 8 */
*  infile 'N:\handbook2\datasets\ghq.dat' expandtabs;
  infile cards expandtabs;
  input ghq sex $ cases noncases;
  total=cases+noncases;
  prcase=cases/total;
*run;
cards;
0       F       4       80
1       F       4       29
2       F       8       15
3       F       6       3
4       F       4       2
5       F       6       1
6       F       3       1
7       F       2       0
8       F       3       0
9       F       2       0
10      F       1       0
0       M       1       36
1       M       2       25
2       M       2       8
3       M       1       4
4       M       3       1
5       M       3       1
6       M       2       1
7       M       4       2
8       M       3       1
9       M       2       0
10      M       2       0
;

proc gplot data=ghq;
  plot prcase*ghq;
run;

proc reg data=ghq;
  model prcase=ghq;
  output out=rout p=rpred;
run;

proc logistic data=ghq;
   model cases/total=ghq;
   output out=lout p=lpred;
run;

data lrout;
  set rout;
  set lout;
run;
proc sort data=lrout;
  by ghq;
run;

symbol1 i=join v=none l=1;
symbol2 i=join v=none l=2;
symbol3 v=circle;

proc gplot data=lrout;
  plot (lpred rpred prcase)*ghq /overlay;
run;

proc logistic data=ghq;
  class sex;
  model cases/total=sex ghq; 
run;


data plasma;
*  infile 'n:\handbook2\datasets\plasma.dat';
  input fibrinogen gamma esr;
*run;
cards;
2.52 38 0
2.56 31 0
2.19 33 0
2.18 31 0
3.41 37 0
2.46 36 0
3.22 38 0
2.21 37 0
3.15 39 0
2.60 41 0
2.29 36 0
2.35 29 0
5.06 37 1
3.34 32 1
2.38 37 1
3.15 36 0
3.53 46 1
2.68 34 0
2.60 38 0
2.23 37 0
2.88 30 0
2.65 46 0
2.09 44 1
2.28 36 0
2.67 39 0
2.29 31 0
2.15 31 0
2.54 28 0
3.93 32 1
3.34 30 0
2.99 36 0
3.32 35 0
;
 
proc logistic data=plasma desc;
  model esr=fibrinogen gamma fibrinogen*gamma / selection=backward;
run;

proc logistic data=plasma desc;
  model esr=fibrinogen;
  output out=lout p=lpred;
run;

proc sort data=lout;
  by fibrinogen;
run;
symbol1 i=none v=circle;
symbol2 i=join v=none;
proc gplot data=lout;
  plot (esr lpred)*fibrinogen /overlay ;
run;

data diy;
*  infile 'n:\handbook2\datasets\diy.dat' expandtabs;
  infile cards expandtabs;
  input y1-y6 / n1-n6;
  length work $9.;
  work='Skilled';
  if _n_ > 2 then work='Unskilled';
  if _n_ > 4 then work='Office';
  if _n_ in(1,3,5) then tenure='rent';
                   else tenure='own';
  array yall {6} y1-y6;
  array nall {6} n1-n6;
  do i=1 to 6;
    if i>3 then type='house';
	       else type='flat';
    agegrp=1;
	if i in(2,5) then agegrp=2;
	if i in(3,6) then agegrp=3;
    yes=yall{i};
	no=nall{i};
	total=yes+no;
	prdiy=yes/total;
	output;
  end;
  drop i y1--n6;
*run;
cards;
18      15      6       34      10      2
15      13      9       28      4       6
5       3       1       56      56      35
1       1       1       12      21      8
17      10      15      29      3       7
34      17      19      44      13      16
2       0       3       23      52      49
3       2       0       9       31      51
30      23      21      22      13      11
25      19      40      25      16      12
8       5       1       54      191     102
4       2       2       19      76      61
;
 
proc print data=diy;
run;

proc tabulate data=diy order=data f=6.2;
 class work tenure type agegrp;
 var prdiy;
 table work*tenure all,
       (type*agegrp all)*prdiy*mean;
run;

proc logistic data=diy;
  class work tenure type agegrp /param=ref ref=first;
  model yes/total=work tenure type agegrp / selection=backward;
run;

/* exercises */

proc logistic data=ghq;                          /* 8.1 */
   class sex;
   model cases/total=ghq sex ghq*sex;
run;

proc logistic data=plasma desc;                  /* 8.2 */
  model esr=fibrinogen|fibrinogen gamma|gamma;
run;

 
/* Chapter 9 */
/* read in uscrime and ozkids data as per chapters 4 and 6 */
/*
data uscrime;
    infile 'n:\handbook2\datasets\uscrime.dat' expandtabs;
    input R Age S Ed Ex0 Ex1 LF M N NW U1 U2 W X;
run;

data ozkids;
    infile 'n:\handbook2\datasets\ozkids.dat' dlm=' ,' expandtabs missover;
    input cell origin $ sex $ grade $ type $ days @;
        do until (days=.);
          output;
          input days @;
        end;
*        input;
run;
*/

proc genmod data=uscrime;              /* Chapter 9 */
  model R=ex1 x ed age u2 / dist=normal link=identity;
run;

proc genmod data=ozkids;
  class origin sex grade type;
  model days=sex origin type grade / dist=p link=log type1 type3;
run;

proc genmod data=ozkids;
  class origin sex grade type;
  model days=sex|origin|type|grade@2 / dist=p link=log scale=d;
run;

proc genmod data=ozkids;
  class origin sex grade type;
  model days=sex origin type grade / dist=p link=log type1 type3 scale=3.1892;
  output out=genout pred=pr_days stdreschi=resid;
run;

proc gplot data=genout;
  plot resid*pr_days;
run;

/* exercises */
 
proc genmod data=ozkids;                         /* 9.1 */
  class origin sex grade type;
  model days=sex origin type grade grade*origin / dist=p link=log type1 type3 scale=3.1892;
run;

data ozkids;                                     /* 9.2 */
  set ozkids;
  absent=days>13;
run;

proc genmod data=ozkids desc;
  class origin sex grade type;
  model absent=sex origin type grade grade*origin / dist=b link=logit type1 type3;
run;

proc genmod data=ozkids desc;
  class origin sex grade type;
  model absent=sex origin type grade grade*origin / dist=b link=probit type1 type3;
run;

/* Chapter 10 */

data pndep(keep=idno group x1-x8) pndep2(keep=idno group time dep);   /* Chapter 10 */
*  infile 'n:\handbook2\datasets\channi.dat';
  input group x1-x8;
  idno=_n_;
  array xarr {8} x1-x8;
  do i=1 to 8;
    if xarr{i}=-9 then xarr{i}=.;
        time=i;
        dep=xarr{i};
        output pndep2;
  end;
  output pndep;
*run;
cards;
 0.  18.00  18.00  17.00  18.00  15.00  17.00  14.00  15.00
 0.  25.00  27.00  26.00  23.00  18.00  17.00  12.00  10.00
 0.  19.00  16.00  17.00  14.00  -9.00  -9.00  -9.00  -9.00
 0.  24.00  17.00  14.00  23.00  17.00  13.00  12.00  12.00
 0.  19.00  15.00  12.00  10.00   8.00   4.00   5.00   5.00
 0.  22.00  20.00  19.00  11.00   9.00   8.00   6.00   5.00
 0.  28.00  16.00  13.00  13.00   9.00   7.00   8.00   7.00
 0.  24.00  28.00  26.00  27.00  -9.00  -9.00  -9.00  -9.00
 0.  27.00  28.00  26.00  24.00  19.00  13.00  11.00   9.00
 0.  18.00  25.00   9.00  12.00  15.00  12.00  13.00  20.00
 0.  23.00  24.00  14.00  -9.00  -9.00  -9.00  -9.00  -9.00
 0.  21.00  16.00  19.00  13.00  14.00  23.00  15.00  11.00
 0.  23.00  26.00  13.00  22.00  -9.00  -9.00  -9.00  -9.00
 0.  21.00  21.00   7.00  13.00  -9.00  -9.00  -9.00  -9.00
 0.  22.00  21.00  18.00  -9.00  -9.00  -9.00  -9.00  -9.00
 0.  23.00  22.00  18.00  -9.00  -9.00  -9.00  -9.00  -9.00
 0.  26.00  26.00  19.00  13.00  22.00  12.00  18.00  13.00
 0.  20.00  19.00  19.00   7.00   8.00   2.00   5.00   6.00
 0.  20.00  22.00  20.00  15.00  20.00  17.00  15.00  13.00
 0.  15.00  16.00   7.00   8.00  12.00  10.00  10.00  12.00
 0.  22.00  21.00  19.00  18.00  16.00  13.00  16.00  15.00
 0.  24.00  20.00  16.00  21.00  17.00  21.00  16.00  18.00
 0.  -9.00  17.00  15.00  -9.00  -9.00  -9.00  -9.00  -9.00
 0.  24.00  22.00  20.00  21.00  17.00  14.00  14.00  10.00
 0.  24.00  19.00  16.00  19.00  -9.00  -9.00  -9.00  -9.00
 0.  22.00  21.00   7.00   4.00   4.00   4.00   3.00   3.00
 0.  16.00  18.00  19.00  -9.00  -9.00  -9.00  -9.00  -9.00
 1.  21.00  21.00  13.00  12.00   9.00   9.00  13.00   6.00
 1.  27.00  27.00   8.00  17.00  15.00   7.00   5.00   7.00
 1.  24.00  15.00   8.00  12.00  10.00  10.00   6.00   5.00
 1.  28.00  24.00  14.00  14.00  13.00  12.00  18.00  15.00
 1.  19.00  15.00  15.00  16.00  11.00  14.00  12.00   8.00
 1.  17.00  17.00   9.00   5.00   3.00   6.00   0.00   2.00
 1.  21.00  20.00   7.00   7.00   7.00  12.00   9.00   6.00
 1.  18.00  18.00   8.00   1.00   1.00   2.00   0.00   1.00
 1.  24.00  28.00  11.00   7.00   3.00   2.00   2.00   2.00
 1.  21.00  21.00   7.00   8.00   6.00   6.50   4.00   4.00
 1.  19.00  18.00   8.00   6.00   4.00  11.00   7.00   6.00
 1.  28.00  27.00  22.00  27.00  24.00  22.00  24.00  23.00
 1.  23.00  19.00  14.00  12.00  15.00  12.00   9.00   6.00
 1.  21.00  20.00  13.00  10.00   7.00   9.00  11.00  11.00
 1.  18.00  16.00  17.00  26.00  -9.00  -9.00  -9.00  -9.00
 1.  22.00  21.00  19.00   9.00   9.00  12.00   5.00   7.00
 1.  24.00  23.00  11.00   7.00   5.00   8.00   2.00   3.00
 1.  23.00  23.00  16.00  13.00  -9.00  -9.00  -9.00  -9.00
 1.  24.00  24.00  16.00  15.00  11.00  11.00  11.00  11.00
 1.  25.00  25.00  20.00  18.00  16.00   9.00  10.00   6.00
 1.  15.00  22.00  15.00  17.00  12.00   9.00   8.00   6.00
 1.  26.00  20.00   7.00   2.00   1.00   0.00   0.00   2.00
 1.  22.00  20.00  12.00   8.00   6.00   3.00   2.00   3.00
 1.  24.00  25.00  15.00  24.00  18.00  15.00  13.00  12.00
 1.  22.00  18.00  17.00   6.00   2.00   2.00   0.00   1.00
 1.  27.00  26.00   1.00  18.00  10.00  13.00  12.00  10.00
 1.  22.00  20.00  27.00  13.00   9.00   8.00   4.00   5.00
 1.  20.00  17.00  20.00  10.00   8.00   8.00   7.00   6.00
 1.  22.00  22.00  12.00  -9.00  -9.00  -9.00  -9.00  -9.00
 1.  20.00  22.00  15.00   2.00   4.00   6.00   3.00   3.00
 1.  21.00  23.00  11.00   9.00  10.00   8.00   7.00   4.00
 1.  17.00  17.00  15.00  -9.00  -9.00  -9.00  -9.00  -9.00
 1.  18.00  22.00   7.00  12.00  15.00  -9.00  -9.00  -9.00
 1.  23.00  26.00  24.00  -9.00  -9.00  -9.00  -9.00  -9.00
;

proc print data=pndep;
run;

proc tabulate data=pndep2 f=6.2;
  class group time;
  var dep;
  table time,
         group*dep*(mean var n);
run;

symbol1 i=join v=none l=1 r=27;
symbol2 i=join v=none l=2 r=34;
proc gplot data=pndep2;
   plot dep*time=idno /nolegend skipmiss;
run;

proc sort data=pndep2;
  by group time;
run;
 
proc boxplot data=pndep2;
  plot dep*time;
  by group;
run;

goptions reset=symbol;
symbol1 i=stdm1j l=1;
symbol2 i=stdm1j l=2;
proc gplot data=pndep2;
  plot dep*time=group;
run;

/*
%include 'n:\sasjobs\macs\scattmat.sas';
The macro is listed at the end of this file.
*/
%scattmat(pndep,x1-x8);

data group0 group1; 
  set pndep; 
  if group=0 then output group0;
             else output group1;
run;

%scattmat(group0,x1-x8);
%scattmat(group1,x1-x8);

data pndep;
  set pndep;
  array xarr {8} x1-x8;
  array locf  {8} locf1-locf8;
  do i=3 to 8;
	locf{i}=xarr{i};
	if xarr{i}=. then locf{i}=locf{i-1};
  end;
  mnbase=mean(x1,x2);
  mnresp=mean(of x3-x8);
  mncomp=(x3+x4+x5+x6+x7+x8)/6; 
  mnlocf=mean(of locf3-locf8);
  chscore=mnbase-mnresp;
run;

proc print;
run;

proc ttest data=pndep;
 class group;
 var mnresp mnlocf mncomp;
run;

proc ttest data=pndep;
 class group;
 var chscore;
run;

proc glm data=pndep;
  class group;
  model chscore=group /solution;
run;

proc glm data=pndep;
  class group;
  model mnresp=mnbase group /solution;
run;

/* exercises */

data pndep2;                                     /* 10.1 */
  set pndep2;
  depz=dep;
run;

proc sort data=pndep2;
  by idno time;
run;

proc stdize data=pndep2 out=pndep2;
  var depz;
  by idno;
run;

goptions reset=symbol;
symbol1 i=join v=none l=1 r=27;
symbol2 i=join v=none l=2 r=34;
proc gplot data=pndep2;
   plot depz*time=idno /nolegend skipmiss;
run;

data pndep2;                                     /* 10.2 */
  set pndep2;
  if time=1 then time=2;
run;

proc sort data=pndep2;
  by idno;
run;

proc reg data=pndep2 outest=regout(keep=idno time) noprint;
  model dep=time;
  by idno;
run;

data pndep;
  merge pndep regout (rename=(time=slope));
  by idno;
run;

proc ttest data=pndep;
 class group;
 var slope;
run;

proc glm data=pndep;
  class group;
  model slope=mnbase group /solution;
run;

/* Chapter 11 */

data alzheim;                          /* Chapter 11 */
*  infile 'n:\handbook2\datasets\alzheim.dat';
  input group score1-score5;
  array sc {5} score1-score5;
  idno=_n_;
  do visit=1 to 5;
     score=sc{visit};
     output;
  end;
*run;
cards;
1       20      15      14      13      13
1       14      12      12      10     10
1       7       5       5       6       5
1       6       10      9       8      7
1       9       7       9       5       4
1       9       9      9       11      8
1       7       3       7       6       5
1       18      17      16      14      12
1       6       9       9       9       9
1       10      15      12      12      11
1       5       9       7       3       5
1       11      11      8       8     9
1       10      2       9       3       5
1       17      12      14      10     9
1       16      15      12     7       9
1       7       10      4       7     5
1       5       0       5       0       0
1       16      7       7       6       4
1       2       1       1       2       2
1       7       11      7       5       8
1       9       16      14     10      6
1       2       5       6       7       6
1       7       3       5       5       5
1       19      13      14     12     10
1       7       5       8       8       6
2       9       12      16      17    18
2       6       7       10     15      16
2       13      18      14      21      21
2       9       10      12      14    15
2       6       7       8       9       12
2       11      11      12      14      16
2       7       10      11      12      14
2       8       18      19      19      22
2       3       3       3       7       8
2       4       10      11     17      18
2       11      10      10      15      16
2       1       3       2       4       5
2       6       7       7       9       10
2       0       3       3       4       6
2       18      18      19      22      22
2       15      15      15      18      19
2       10      14      16      17      19
2       6       6       7       9       10
2       9       9      13      16     20
2       4       3       4       7       9
2       4       13      13     16     19
2       10      11      13    17     21
;
 
proc sort data=alzheim;
  by group;
run;

symbol1 i=join v=none r=25;
proc gplot data=alzheim;
  plot score*visit=idno /nolegend;
  by group;
run;

goptions reset=symbol;
symbol1 i=std1mj v=none l=1;
symbol2 i=std1mj v=none l=3;
proc gplot data=alzheim;
  plot score*visit=group;
run;

proc mixed data=alzheim method=ml;
  class group idno;
  model score=group visit /s outpred=mixout;
  random int /subject=idno;
run; 

symbol1 i=join v=none l=1 r=30;
proc gplot data=mixout;
  plot pred*visit=idno / nolegend;
  by group;
run;

proc mixed data=alzheim method=ml covtest;
  class group idno;
  model score=group visit /s outpred=mixout;
  random int visit /subject=idno type=un;
run; 

symbol1 i=join v=none l=1 r=30;
proc gplot data=mixout;
  plot pred*visit=idno / nolegend;
  by group;
run;

/* exercises */

proc mixed data=alzheim method=ml covtest;       /* 11.1 */
  class group idno;
  model score=group visit group*visit /s ;
  random int /subject=idno type=un;
run; 

proc mixed data=alzheim method=ml covtest;      
  class group idno;
  model score=group visit group*visit /s ;
  random int visit /subject=idno type=un;
run; 

proc sort data=alzheim;                          /* 11.2 */
  by idno;
run;

proc reg data=alzheim outest=regout(keep=idno intercept visit) noprint  ;
  model score=visit;
  by idno;
run;

data regout;
  merge regout(rename=(visit=slope)) alzheim;
  by idno;
  if first.idno;
run;

proc gplot data=regout;
  plot intercept*slope=group;
  symbol1 v='L';
  symbol2 v='P';
run;


data pndep(keep=idno group x1-x8) pndep2(keep=idno group time dep mnbase);  /* 11.3 */
  infile 'n:\handbook2\datasets\channi.dat';
  input group x1-x8;
  idno=_n_;
  mnbase=mean(x1,x2);
  array xarr {8} x1-x8;
  do i=1 to 8;
    if xarr{i}=-9 then xarr{i}=.;
        time=i;
        dep=xarr{i};
        output pndep2;
  end;
  output pndep;
run;

proc mixed data=pndep2 method=ml covtest;
  class group idno;
  model dep=mnbase time group /s;
  random int /sub=idno;
  where time>2;
run;

proc mixed data=pndep2 method=ml covtest;
  class group idno;
  model dep=mnbase time group /s;
  random int time /sub=idno type=un;
  where time>2;
run;

data alzheim;
  set alzheim;
  mnscore=mean(of score1-score5);
  maxscore=max(of score1-score5);
run;

proc ttest data=alzheim;
  class group;
  var mnscore maxscore;
  where visit=1;
run;

/* Chapter 12 */

data cancer;                           /* Chapter 12 */

*  infile 'n:\handbook2\datasets\time.dat' expandtabs missover;
  infile cards expandtabs missover;
  do i = 1 to 6;
    input temp $ @;
    censor=(index(temp,'*')>0);
	temp=substr(temp,1,4);
    days=input(temp,4.);
    group=i>3;
    if days>0 then output;
  end;
  drop temp i;
*run;
cards;
17	185	542	1	383	778
42	193	567	63	383	786
44	195	577	105	388	797
48	197	580	125	394	955
60	208	795	182	408	968
72	234	855	216	460	977
74	235	1174*	250	489	1245
95	254	1214	262	523	1271
103	307	1232*	301	524	1420
108	315	1366	301	535	1460*
122	401	1455*	342	562	1516*
144	445	1585*	354	569	1551
167	464	1622*	356	675	1690*
170	484	1626*	358	676	1694
183	528	1736*	380	748	
;
 
proc lifetest data=cancer plots=(s);
   time days*censor(1);
   strata group;
symbol1 l=1;
symbol2 l=3;
run;

data heroin;
*  infile 'n:\handbook2\datasets\heroin.dat' expandtabs;
  infile cards expandtabs;
  input id clinic status time prison dose @@;
*run;
cards;
1	1	1	428	0	50	132	2	0	633	0	70
2	1	1	275	1	55	133	2	1	661	0	40
3	1	1	262	0	55	134	2	1	232	1	70
4	1	1	183	0	30	135	2	1	13	1	60
5	1	1	259	1	65	137	2	0	563	0	70
6	1	1	714	0	55	138	2	0	969	0	80
7	1	1	438	1	65	143	2	0	1052	0	80
8	1	0	796	1	60	144	2	0	944	1	80
9	1	1	892	0	50	145	2	0	881	0	80
10	1	1	393	1	65	146	2	1	190	1	50
11	1	0	161	1	80	148	2	1	79	0	40
12	1	1	836	1	60	149	2	0	884	1	50
13	1	1	523	0	55	150	2	1	170	0	40
14	1	1	612	0	70	153	2	1	286	0	45
15	1	1	212	1	60	156	2	0	358	0	60
16	1	1	399	1	60	158	2	0	326	1	60
17	1	1	771	1	75	159	2	0	769	1	40
18	1	1	514	1	80	160	2	1	161	0	40
19	1	1	512	0	80	161	2	0	564	1	80
21	1	1	624	1	80	162	2	1	268	1	70
22	1	1	209	1	60	163	2	0	611	1	40
23	1	1	341	1	60	164	2	1	322	0	55
24	1	1	299	0	55	165	2	0	1076	1	80
25	1	0	826	0	80	166	2	0	2	1	40
26	1	1	262	1	65	168	2	0	788	0	70
27	1	0	566	1	45	169	2	0	575	0	80
28	1	1	368	1	55	170	2	1	109	1	70
30	1	1	302	1	50	171	2	0	730	1	80
31	1	0	602	0	60	172	2	0	790	0	90
32	1	1	652	0	80	173	2	0	456	1	70
33	1	1	293	0	65	175	2	1	231	1	60
34	1	0	564	0	60	176	2	1	143	1	70
36	1	1	394	1	55	177	2	0	86	1	40
37	1	1	755	1	65	178	2	0	1021	0	80
38	1	1	591	0	55	179	2	0	684	1	80
39	1	0	787	0	80	180	2	1	878	1	60
40	1	1	739	0	60	181	2	1	216	0	100
41	1	1	550	1	60	182	2	0	808	0	60
42	1	1	837	0	60	183	2	1	268	1	40
43	1	1	612	0	65	184	2	0	222	0	40
44	1	0	581	0	70	186	2	0	683	0	100
45	1	1	523	0	60	187	2	0	496	0	40
46	1	1	504	1	60	188	2	1	389	0	55
48	1	1	785	1	80	189	1	1	126	1	75
49	1	1	774	1	65	190	1	1	17	1	40
50	1	1	560	0	65	192	1	1	350	0	60
51	1	1	160	0	35	193	2	0	531	1	65
52	1	1	482	0	30	194	1	0	317	1	50
53	1	1	518	0	65	195	1	0	461	1	75
54	1	1	683	0	50	196	1	1	37	0	60
55	1	1	147	0	65	197	1	1	167	1	55
57	1	1	563	1	70	198	1	1	358	0	45
58	1	1	646	1	60	199	1	1	49	0	60
59	1	1	899	0	60	200	1	1	457	1	40
60	1	1	857	0	60	201	1	1	127	0	20
61	1	1	180	1	70	202	1	1	7	1	40
62	1	1	452	0	60	203	1	1	29	1	60
63	1	1	760	0	60	204	1	1	62	0	40
64	1	1	496	0	65	205	1	0	150	1	60
65	1	1	258	1	40	206	1	1	223	1	40
66	1	1	181	1	60	207	1	0	129	1	40
67	1	1	386	0	60	208	1	0	204	1	65
68	1	0	439	0	80	209	1	1	129	1	50
69	1	0	563	0	75	210	1	1	581	0	65
70	1	1	337	0	65	211	1	1	176	0	55
71	1	0	613	1	60	212	1	1	30	0	60
72	1	1	192	1	80	213	1	1	41	0	60
73	1	0	405	0	80	214	1	0	543	0	40
74	1	1	667	0	50	215	1	0	210	1	50
75	1	0	905	0	80	216	1	1	193	1	70
76	1	1	247	0	70	217	1	1	434	0	55
77	1	1	821	0	80	218	1	1	367	0	45
78	1	1	821	1	75	219	1	1	348	1	60
79	1	0	517	0	45	220	1	0	28	0	50
80	1	0	346	1	60	221	1	0	337	0	40
81	1	1	294	0	65	222	1	0	175	1	60
82	1	1	244	1	60	223	2	1	149	1	80
83	1	1	95	1	60	224	1	1	546	1	50
84	1	1	376	1	55	225	1	1	84	0	45
85	1	1	212	0	40	226	1	0	283	1	80
86	1	1	96	0	70	227	1	1	533	0	55
87	1	1	532	0	80	228	1	1	207	1	50
88	1	1	522	1	70	229	1	1	216	0	50
89	1	1	679	0	35	230	1	0	28	0	50
90	1	0	408	0	50	231	1	1	67	1	50
91	1	0	840	0	80	232	1	0	62	1	60
92	1	0	148	1	65	233	1	0	111	0	55
93	1	1	168	0	65	234	1	1	257	1	60
94	1	1	489	0	80	235	1	1	136	1	55
95	1	0	541	0	80	236	1	0	342	0	60
96	1	1	205	0	50	237	2	1	41	0	40
97	1	0	475	1	75	238	2	0	531	1	45
98	1	1	237	0	45	239	1	0	98	0	40
99	1	1	517	0	70	240	1	1	145	1	55
100	1	1	749	0	70	241	1	1	50	0	50
101	1	1	150	1	80	242	1	0	53	0	50
102	1	1	465	0	65	243	1	0	103	1	50
103	2	1	708	1	60	244	1	0	2	1	60
104	2	0	713	0	50	245	1	1	157	1	60
105	2	0	146	0	50	246	1	1	75	1	55
106	2	1	450	0	55	247	1	1	19	1	40
109	2	0	555	0	80	248	1	1	35	0	60
110	2	1	460	0	50	249	2	0	394	1	80
111	2	0	53	1	60	250	1	1	117	0	40
113	2	1	122	1	60	251	1	1	175	1	60
114	2	1	35	1	40	252	1	1	180	1	60
118	2	0	532	0	70	253	1	1	314	0	70
119	2	0	684	0	65	254	1	0	480	0	50
120	2	0	769	1	70	255	1	0	325	1	60
121	2	0	591	0	70	256	2	1	280	0	90
122	2	0	769	1	40	257	1	1	204	0	50
123	2	0	609	1	100	258	2	1	366	0	55
124	2	0	932	1	80	259	2	0	531	1	50
125	2	0	932	1	80	260	1	1	59	1	45
126	2	0	587	0	110	261	1	1	33	1	60
127	2	1	26	0	40	262	2	1	540	0	80
128	2	0	72	1	40	263	2	0	551	0	65
129	2	0	641	0	70	264	1	1	90	0	40
131	2	0	367	0	70	266	1	1	47	0	45
;
 
proc phreg data=heroin;
  model time*status(0)=prison dose / rl;
  strata clinic;
run;

proc stdize data=heroin out=heroin2;
  var dose;
run;

proc phreg data=heroin2;
  model time*status(0)=prison dose / rl;
  strata clinic;
  baseline out=phout loglogs=lls / method=ch;
run;

symbol1 i=join v=none l=1;
symbol2 i=join v=none l=3;
proc gplot data=phout;
  plot lls*time=clinic;
run;

/* exercises */

data heroin3;
  set heroin;
  if time > 450 then do;               /* censor times over 450 */
     time=450;
     status=0;
     end;
  clinic=clinic-1;                     /* recode clinic to 0,1  */
  dosegrp=1;                           /* recode dose to 3 groups */
  if dose >= 60 then dosegrp=2;
  if dose >=80 then dosegrp=3;
  dose1=dosegrp eq 1;                  /* dummy variables for dose group */
  dose2=dosegrp eq 2;
  clindose1=clinic*dose1;              /* dummies for interaction */
  clindose2=clinic*dose2;
run;
proc stdize data=heroin3 out=heroin3;
  var dose;
run;
data heroin3;
  set heroin3;
  clindose=clinic*dose;                /* interaction term */
run;

proc phreg data=heroin3;                         /* 12.1 */
  model time*status(0)=prison dose clinic / rl;
run;

data covvals;                                    /* 12.2 */
  retain prison clinic 0;
  input dose1 dose2;
cards;
1 0
0 1
0 0
; 
proc phreg data=heroin3; 
  model time*status(0)=prison clinic dose1 dose2 / rl;
  baseline covariates=covvals out=baseout  survival=bs / method=ch nomean;
run;
data baseout;
  set baseout;
  dosegrp=3-dose1*2-dose2;
run;
proc gplot data=baseout;
  plot bs*time=dosegrp;
  symbol1 v=none i=stepjs l=1;
  symbol2 v=none i=stepjs l=3;
  symbol3 v=none i=stepjs l=33 w=20;
run;

proc phreg data=heroin3;                         /* 12.3 */                      
  model time*status(0)=prison clinic dose1 dose2 clindose1 clindose2/ rl;
  test clindose1=0, clindose2=0;
run;

proc phreg data=heroin3;
  model time*status(0)=prison clinic dose clindose / rl;
run;

proc phreg data=heroin3;                         /* 12.4 */                     
  model time*status(0)=prison clinic dose / rl;
  output out=phout xbeta=lp resmart=resm resdev=resd;
run;

goptions reset=symbol;
proc gplot data=phout;
  plot (resm resd)*lp / vref=-2,2 lvref=2;
  symbol1 v=circle;
run;

/* Chapter 13 */

data decathlon;                        /* Chapter 13 */
*  infile 'N:handbook2\datasets\olympic.dat' expandtabs;
  infile cards expandtabs;
  input run100 Ljump shot Hjump run400 hurdle discus polevlt javelin run1500 score;
*run;
cards;
11.25	7.43	15.48	2.27	48.90	15.13	49.28	4.7	61.32	268.95	8488
10.87	7.45	14.97	1.97	47.71	14.46	44.36	5.1	61.76	273.02	8399
11.18	7.44	14.20	1.97	48.29	14.81	43.66	5.2	64.16	263.20	8328
10.62	7.38	15.02	2.03	49.06	14.72	44.80	4.9	64.04	285.11	8306
11.02	7.43	12.92	1.97	47.44	14.40	41.20	5.2	57.46	256.64	8286
10.83	7.72	13.58	2.12	48.34	14.18	43.06	4.9	52.18	274.07	8272
11.18	7.05	14.12	2.06	49.34	14.39	41.68	5.7	61.60	291.20	8216
11.05	6.95	15.34	2.00	48.21	14.36	41.32	4.8	63.00	265.86	8189
11.15	7.12	14.52	2.03	49.15	14.66	42.36	4.9	66.46	269.62	8180
11.23	7.28	15.25	1.97	48.60	14.76	48.02	5.2	59.48	292.24	8167
10.94	7.45	15.34	1.97	49.94	14.25	41.86	4.8	66.64	295.89	8143
11.18	7.34	14.48	1.94	49.02	15.11	42.76	4.7	65.84	256.74	8114
11.02	7.29	12.92	2.06	48.23	14.94	39.54	5.0	56.80	257.85	8093
10.99	7.37	13.61	1.97	47.83	14.70	43.88	4.3	66.54	268.97	8083
11.03	7.45	14.20	1.97	48.94	15.44	41.66	4.7	64.00	267.48	8036
11.09	7.08	14.51	2.03	49.89	14.78	43.20	4.9	57.18	268.54	8021
11.46	6.75	16.07	2.00	51.28	16.06	50.66	4.8	72.60	302.42	7869
11.57	7.00	16.60	1.94	49.84	15.00	46.66	4.9	60.20	286.04	7860
11.07	7.04	13.41	1.94	47.97	14.96	40.38	4.5	51.50	262.41	7859
10.89	7.07	15.84	1.79	49.68	15.38	45.32	4.9	60.48	277.84	7781
11.52	7.36	13.93	1.94	49.99	15.64	38.82	4.6	67.04	266.42	7753
11.49	7.02	13.80	2.03	50.60	15.22	39.08	4.7	60.92	262.93	7745
11.38	7.08	14.31	2.00	50.24	14.97	46.34	4.4	55.68	272.68	7743
11.30	6.97	13.23	2.15	49.98	15.38	38.72	4.6	54.34	277.84	7623
11.00	7.23	13.15	2.03	49.73	14.96	38.06	4.5	52.82	285.57	7579
11.33	6.83	11.63	2.06	48.37	15.39	37.52	4.6	55.42	270.07	7517
11.10	6.98	12.69	1.82	48.63	15.13	38.04	4.7	49.52	261.90	7505
11.51	7.01	14.17	1.94	51.16	15.18	45.84	4.6	56.28	303.17	7422
11.26	6.90	12.41	1.88	48.24	15.61	38.02	4.4	52.68	272.06	7310
11.50	7.09	12.94	1.82	49.27	15.56	42.32	4.5	53.50	293.85	7237
11.43	6.22	13.98	1.91	51.25	15.88	46.18	4.6	57.84	294.99	7231
11.47	6.43	12.33	1.94	50.30	15.00	38.72	4.0	57.26	293.72	7016
11.57	7.19	10.27	1.91	50.71	16.20	34.36	4.1	54.94	269.98	6907
12.12	5.83	9.71	1.70	52.32	17.05	27.10	2.6	39.10	281.24	5339
;

proc univariate data=decathlon plots;
 var score;
run;

data decathlon;
  set decathlon;
  if score > 6000;
  run100=run100*-1;
  run400=run400*-1;
  hurdle=hurdle*-1;
  run1500=run1500*-1;
run;

proc princomp data=decathlon out=pcout;
 var run100--run1500;
run;

proc rank data=pcout out=pcout descending;
 var score;
 ranks posn;
run;

data labels;
  set pcout;
  retain xsys ysys '2';
  y=prin1;
  x=prin2;
  text=put(posn,2.);
  keep xsys ysys x y text;
run;

proc gplot data=pcout;
  plot prin1*prin2 /annotate=labels;
  symbol v=none;
run;

goptions reset=symbol;
proc gplot data=pcout;
  plot score*(prin1 prin2);
run;

proc corr data=pcout;
  var score prin1 prin2;
run;

data pain (type = corr);
*infile 'n:\handbook2\datasets\pain.dat' expandtabs missover;
infile cards expandtabs missover;
input _type_ $  _name_ $   p1 - p9;
*run;
cards;
CORR   p1 1.0
CORR   p2 -.0385    1.0
CORR   p3 .6066     -.0693    1.0
CORR   p4 .4507     -.1167    .5916     1.0
CORR   p5 .0320     .4881     .0317     -.0802    1.0
CORR   p6 -.2877    .4271     -.1336    -.2073    .4731     1.0
CORR   p7 -.2974    .3045     -.2404    -.1850    .4138     .6346     1.0
CORR   p8 .4526     -.3090    .5886     .6286     -.1397    -.1329    -.2599    1.0
CORR   p9 .2952     -.1704    .3165     .3680     -.2367    -.1541    -.2893    .4047     1.0
N      N  123  123  123  123  123  123  123   123  123
;
 
proc factor data=pain method=ml n=2 scree;
 var p1-p9;
run;

proc factor data=pain method=ml n=3 rotate=varimax;
 var p1-p9;
run;

/* exercise */

data decathlon;
  infile 'N:handbook2\datasets\olympic.dat' expandtabs;
  input run100 Ljump shot Hjump run400 hurdle discus polevlt javelin run1500 score;
  run100=run100*-1;
  run400=run400*-1;
  hurdle=hurdle*-1;
  run1500=run1500*-1;
run;

/* and re-run analysis as before */

proc princomp data=pain;
 var p1-p9;
run;

proc factor data=decathlon method=principal priors=smc mineigen=1 rotate=oblimin;
 var run100--run1500;
 where score>6000;
run;

proc factor data=decathlon method=ml min=1 rotate=obvarimax;
 var run100--run1500;
 where score>6000;
run;

/* Chapter 14 */

data usair;                            /* Chapter 14 */
*  infile 'N:handbook2\datasets\usair.dat' expandtabs;
  infile cards expandtabs;
  input city $16. so2 temperature factories population windspeed rain rainydays;
*run;
cards;
Phoenix		10	70.3	213	582	6.0	7.05	36
Little Rock	13	61.0	91	132	8.2	48.52	100
San Francisco	12	56.7	453	716	8.7	20.66	67
Denver		17	51.9	454	515	9.0	12.95	86
Hartford	56	49.1	412	158	9.0	43.37	127
Wilmington	36	54.0	80	80	9.0	40.25	114
Washington	29	57.3	434	757	9.3	38.89	111
Jacksonville	14	68.4	136	529	8.8	54.47	116
Miami		10	75.5	207	335	9.0	59.80	128
Atlanta		24	61.5	368	497	9.1	48.34	115
Chicago		110	50.6	3344	3369	10.4	34.44	122
Indianapolis	28	52.3	361	746	9.7	38.74	121
Des Moines	17	49.0	104	201	11.2	30.85	103
Wichita		8	56.6	125	277	12.7	30.58	82
Louisville	30	55.6	291	593	8.3	43.11	123
New Orleans	9	68.3	204	361	8.4	56.77	113
Baltimore	47	55.0	625	905	9.6	41.31	111
Detroit		35	49.9	1064	1513	10.1	30.96	129
Minneapolis	29	43.5	699	744	10.6	25.94	137
Kansas City	14	54.5	381	507	10.0	37.00	99
St. Louis	56	55.9	775	622	9.5	35.89	105
Omaha		14	51.5	181	347	10.9	30.18	98
Albuquerque	11	56.8	46	244	8.9	7.77	58
Albany		46	47.6	44	116	8.8	33.36	135
Buffalo		11	47.1	391	463	12.4	36.11	166
Cincinnati	23	54.0	462	453	7.1	39.04	132
Cleveland	65	49.7	1007	751	10.9	34.99	155
Columbus	26	51.5	266	540	8.6	37.01	134
Philadelphia	69	54.6	1692	1950	9.6	39.93	115
Pittsburgh	61	50.4	347	520	9.4	36.22	147
Providence	94	50.0	343	179	10.6	42.75	125
Memphis		10	61.6	337	624	9.2	49.10	105
Nashville	18	59.4	275	448	7.9	46.00	119
Dallas		9	66.2	641	844	10.9	35.94	78
Houston		10	68.9	721	1233	10.8	48.19	103
Salt Lake City	28	51.0	137	176	8.7	15.17	89
Norfolk		31	59.3	96	308	10.6	44.68	116
Richmond	26	57.8	197	299	7.6	42.59	115
Seattle		29	51.1	379	531	9.4	38.79	164
Charleston	31	55.2	35	71	6.5	40.75	148
Milwaukee	16	45.7	569	717	11.8	29.07	123
;
 
proc print;
run;

proc univariate data=usair plots;
  var temperature--rainydays;
  id city;
run;

data usair2;
  set usair;
  if city not in('Chicago','Phoenix');
run;

proc cluster data=usair2 method=single simple ccc std outtree=single;
  var temperature--rainydays;
  id city;
  copy so2;
proc tree horizontal;
run;

proc cluster data=usair2 method=complete ccc std outtree=complete;
  var temperature--rainydays;
  id city;
  copy so2;
proc tree horizontal;
run;

proc cluster data=usair2 method=average ccc std outtree=average;
  var temperature--rainydays;
  id city;
  copy so2;
proc tree horizontal;
run;

proc tree data=complete out=clusters n=4 noprint;
  copy city so2 temperature--rainydays;
run;

proc sort data=clusters;
 by cluster;
run;

proc means data=clusters;
 var temperature--rainydays;
 by cluster;
run;

proc princomp data=clusters n=2 out=pcout noprint;
  var temperature--rainydays;
run;

proc gplot data=pcout;
  symbol1 v='1';
  symbol2 v='2';
  symbol3 v='3';
  symbol4 v='4';
  plot prin1*prin2=cluster;
run;

proc boxplot data=clusters;
 plot so2*cluster;
run;

proc glm data=clusters;
  class cluster;
  model so2=cluster ;
run;

/* exercises */

proc modeclus data=usair2 out=modeout method=1 std r=1 to 3 by .25  test;    /* 14.1 */
  var temperature--rainydays;
  id city;
run;
proc print data=modeout;
 where _R_=2;
run;

proc stdize data=usair2 method=range out=usair3;                 /* 14.3 */
  var temperature--rainydays;
run;

/* then repeat the analyses without the std option */

proc glm data=clusters;                                          /* 14.4 */
  class cluster;
  model so2=cluster;
  means cluster / scheffe;
run;

/* Chapter 15 */

data skulls;                           /* Chapter 15 */
*  infile 'n:\handbook2\datasets\tibetan.dat' expandtabs;
  infile cards expandtabs;
  input length width height faceheight facewidth;
  if _n_ < 18 then type='A';
    else type='B';
*run;
cards;
190.5	152.5	145.0	73.5	136.5
172.5	132.0	125.5	63.0	121.0
167.0	130.0	125.5	69.5	119.5
169.5	150.5	133.5	64.5	128.0
175.0	138.5	126.0	77.5	135.5
177.5	142.5	142.5	71.5	131.0
179.5	142.5	127.5	70.5	134.5
179.5	138.0	133.5	73.5	132.5
173.5	135.5	130.5	70.0	133.5
162.5	139.0	131.0	62.0	126.0
178.5	135.0	136.0	71.0	124.0
171.5	148.5	132.5	65.0	146.5
180.5	139.0	132.0	74.5	134.5
183.0	149.0	121.5	76.5	142.0
169.5	130.0	131.0	68.0	119.0
172.0	140.0	136.0	70.5	133.5
170.0	126.5	134.5	66.0	118.5


182.5	136.0	138.5	76.0	134.0
179.5	135.0	128.5	74.0	132.0
191.0	140.5	140.5	72.5	131.5
184.5	141.5	134.5	76.5	141.5
181.0	142.0	132.5	79.0	136.5
173.5	136.5	126.0	71.5	136.5
188.5	130.0	143.0	79.5	136.0
175.0	153.0	130.0	76.5	142.0
196.0	142.5	123.5	76.0	134.0
200.0	139.5	143.5	82.5	146.0
185.0	134.5	140.0	81.5	137.0
174.5	143.5	132.5	74.0	136.5
195.5	144.0	138.5	78.5	144.0
197.0	131.5	135.0	80.5	139.0
182.5	131.0	135.0	68.5	136.0
;
 
proc discrim data=skulls pool=test simple manova wcov crossvalidate;
  class type;
  var length--facewidth;
run;

proc stepdisc data=skulls sle=.05 sls=.05;
   class type;
   var length--facewidth;
run;

proc discrim data=skulls crossvalidate;
  class type;
  var faceheight;
run;

/* exercises */

proc discrim data=skulls method=npar k=4 crossvalidate;          /* 15.2 */
  class type;
  var length--facewidth;
run;

proc discrim data=skulls method=npar kernel=normal r=.7 crossvalidate;
  class type;
  var length--facewidth;
run;

/* Chapter 16 */

data boyfriends;                       /* Chapter 16 */
*  infile 'n:\handbook2\datasets\boyfriends.dat' expandtabs;
  infile cards expandtabs;
  input c1-c5;
  if _n_=1 then rowid='NoBoy';
  if _n_=2 then rowid='NoSex';
  if _n_=3 then rowid='Both';
  label c1='under 16' c2='16-17' c3='17-18' c4='18-19' c5='19-20';
*run;
cards;
21	21	14	13	8
8	9	6	8	2			
2	3	4	10	10
;

proc corresp data=boyfriends out=coor;
  var c1-c5;
  id rowid;
run;

%plotit(data=coor,datatype=corresp,color=black,colors=black);

data births;
*  infile 'n:\handbook2\datasets\births.dat' expandtabs;
  infile cards expandtabs;
  input c1-c4;
  length rowid $12.;
  select(_n_);
   when(1) rowid='Young NS';
   when(2) rowid='Young Smoker';
   when(3) rowid='Old NS';
   when(4) rowid='Old Smoker';
  end;
  label c1='Prem Died' c2='Prem Alive' c3='FT Died' c4='FT Alive';
*run;
cards;
50	315	24	4012
9	40	6	459
41	147	14	1594
4	11	1	124
;

proc corresp data=births out=coor;
 var c1-c4;
 id rowid;
run;

%plotit(data=coor,datatype=corresp,color=black,colors=black);

data europeans;
*  infile 'n:\handbook2\datasets\europeans.dat' expandtabs;
  infile cards expandtabs;
  input country $ c1-c13;
  label c1='stylish'
        c2='arrogant'
		c3='sexy'
		c4='devious'
		c5='easy-going'
		c6='greedy'
		c7='cowardly'
		c8='boring'
		c9='efficient'
		c10='lazy'
		c11='hard working'
		c12='clever'
		c13='courageous';
*run;
cards;
France	37	29	21	19	10	10	8	8	6	6	5	2	1
Spain	7	14	8	9	27	7	3	7	3	23	12	1	3
Italy	30	12	19	10	20	7	12	6	5	13	10	1	2
UK	9	14	4	6	27	12	2	13	26	16	29	6	25
Ireland	1	7	1	16	30	3	10	9	5	11	22	2	27
Holland	5	4	2	2	15	2	0	13	24	1	28	4	6
Germany	4	48	1	12	3	9	2	11	41	1	38	8	8
;
 
proc corresp data=europeans out=coor;
 var c1-c13;
 id country;
run;

%plotit(data=coor,datatype=corresp,color=black,colors=black);

/* exercises */

proc corresp data=europeans out=coor dim=4;
 var c1-c13;
 id country;
run;

/*
%include 'N:\sasjobs\macs\scattmat.sas';
The macro is listed at the end of this file.
*/
%scattmat(coor,dim1-dim4);

proc corresp data=births out=coor cp rp;
 var c1-c4;
 id rowid;
run;
/* the cp and rp options (row profile and column profile)
   together with the row and column masses provide the 
   proportions used in the calculations.
*/




%macro scattmat(data,vars);
/* This macro is based on one supplied with the SAS system,
   but has been adapted and simplified. It uses PROC IML and 
   therefore requires that SAS/IML be licensed.

   The macro has two arguments: the first is the name of the 
   SAS data set that contains the data to be plotted; the second 
   is a list of numeric variables to be plotted. Both arguments
   are required.

   The macro takes a pairwise approach to missing values.
*/
 
/* expand variable list and separate with commas */
data _null_;
  set &data (keep=&vars);
  length varlist $500. name $32.;
  array xxx {*} _numeric_;
  do i=1 to dim(xxx);
    call vname(xxx{i},name);
    varlist=compress(varlist||name);
    if i<dim(xxx) then varlist=compress(varlist||',');
  end;
  call symput('varlist',varlist);
  stop;
run;

proc iml;
     /*-- Load graphics --*/
      call gstart;

      /*-- Module : individual scatter plot --*/
      start gscatter(t1, t2);
         /* pairwise elimination of missing values */
         t3=t1;
         t4=t2;
         t5=t1+t2;
         dim=nrow(t1);
         j=0;         
         do i=1 to dim;
           if t5[i]=. then ;
           else do;
           j=j+1;
           t3[j]=t1[i];
           t4[j]=t2[i];
           end;
         end;
         t1=t3[1:j];
         t2=t4[1:j];
         /* ---------------- */
         window=(min(t1)||min(t2))//
                (max(t1)||max(t2));
         call gwindow(window);
         call gpoint(t1,t2);
       finish gscatter;

      /*-- Module : do scatter plot matrix --*/
      start gscatmat(data, vname);
         call gopen('scatter');
         nv=ncol(vname);
         if (nv=1) then nv=nrow(vname);
         cellwid=int(90/nv);
         dist=0.1*cellwid;
         width=cellwid-2*dist;
         xstart=int((90 -cellwid * nv)/2) + 5;
         xgrid=((0:nv-1)#cellwid + xstart)`;

      /*-- Delineate cells --*/
         cell1=xgrid;
         cell1=cell1||(cell1[nv]//cell1[nv-(0:nv-2)]);
         cell2=j(nv, 1, xstart);
         cell2=cell1[,1]||cell2;
         call gdrawl(cell1, cell2);
         call gdrawl(cell1[,{2 1}], cell2[,{2 1}]);
         xstart = xstart + dist;  ystart = xgrid[nv] + dist;

      /*-- Label variables ---*/
         call gset("height", 3);
         call gset("font","swiss");
         call gstrlen(len, vname);
         where=xgrid[1:nv] + (cellwid-len)/2;
         call gscript(where, 0, vname) ;
         len=len[nv-(0:nv-1)];
         where=xgrid[1:nv] + (cellwid-len)/2;
         call gscript(0,where, vname[nv - (0:nv-1)]);

      /*-- First viewport --*/
         vp=(xstart || ystart)//((xstart || ystart) + width) ;

      /*  Since the characters are scaled to the viewport      */
      /*   (which is inversely porportional to the             */
      /*   number of variables),                               */
      /*   enlarge it proportional to the number of variables  */

         ht=2*nv;
         call gset("height", ht);
         do i=1 to nv;
            do j=1 to i;
               call gportstk(vp);
              if (i=j) then ; 
                 else run gscatter(data[,j], data[,i]);

         /*-- onto the next viewport --*/
               vp[,1] = vp[,1] + cellwid;
               call gportpop;
            end;
            vp=(xstart // xstart + width) || (vp[,2] - cellwid);
         end;
         call gshow;
   finish gscatmat;

      /*-- Placement of text is based on the character height.       */
      /* The IML modules defined here assume percent as the unit of  */
      /* character height for device independent control.            */
   goptions gunit=pct;

   use &data;
   vname={&varlist};
   read all var vname into xyz;
   run gscatmat(xyz, vname);       
   quit;

   goptions gunit=cell;             /*-- reset back to default --*/
%mend;




