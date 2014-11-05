/*----------------------------------------------------------------
  SAS System for Mixed Models (1996)                             
  by Ramon C. Littell, Ph.D., George A. Milliken, Ph.D.,         
  Walter W. Stroup, Ph.D., and Russell D. Wolfinger, Ph.D.       
                                                                 
  SAS Publications order # 55235                                 
  ISBN 1-55544-779-1                                             
  Copyright 1996 by SAS Institute Inc., Cary, NC, USA            
                                                                 
  This file contains the SAS code needed to produce the output 
  in this book with Release 6.11 of the SAS System. 
----------------------------------------------------------------*/

* Updated: 12JUN02

/*--------------------------------------------------------------*/

/*---------------*/
/*---Chapter 1---*/
/*---------------*/

/*---Data Set 1.2.4---*/

data rcb;
   input ingot metal $ pres;
   datalines;
1 n 67.0
1 i 71.9
1 c 72.2
2 n 67.5
2 i 68.8
2 c 66.4
3 n 76.0
3 i 82.6
3 c 74.5
4 n 72.7
4 i 78.1
4 c 67.3
5 n 73.1
5 i 74.2
5 c 73.2
6 n 65.8
6 i 70.8
6 c 68.7
7 n 75.6
7 i 84.9
7 c 69.0
;
               
/*---produces Output 1.1-1.3 on pages 6-9---*/

proc mixed data=rcb;
   class ingot metal;
   model pres=metal;
   random ingot;
   lsmeans metal / pdiff;
   estimate 'nickel mean' intercept 1 metal 0 0 1;  
   estimate 'copper vs iron' metal 1 -1 0;
   contrast 'copper vs iron' metal 1 -1 0;
run;


/*---produces Output 1.4 on page 10---*/

proc glm data=rcb;
   class ingot metal;
   model pres=ingot metal;
   lsmeans metal/stderr pdiff;
   estimate 'nickel mean' intercept 1 metal 0 0 1;
   estimate 'copper vs iron' metal 1 -1 0;
   contrast 'copper vs iron' metal 1 -1 0;
   random ingot;
run;


/*---produces Output 1.5 on page 13---*/

proc varcomp method=reml data=rcb;
   class ingot metal;
   model pres=metal ingot/fixed=1;
run;


/*---Data Set 1.5.1---*/

data pbib;
   array trt{4} trt1-trt4;
   array y{4} y1-y4;
   input blk trt1 y1 trt2 y2 trt3 y3 trt4 y4;
   do i=1 to 4;
      response=y{i};
      treat=trt{i};
      output;
   end;
   keep blk response treat;
   datalines;
 1 15 2.4  9 2.5  1 2.6 13 2.0
 2  5 2.7  7 2.8  8 2.4  1 2.7
 3 10 2.6  1 2.8 14 2.4  2 2.4
 4 15 3.4 11 3.1  2 2.1  3 2.3
 5  6 4.1 15 3.3  4 3.3  7 2.9
 6 12 3.4  4 3.2  3 2.8  1 3.0
 7 12 3.2 14 2.5 15 2.4  8 2.6
 8  6 2.3  3 2.3 14 2.4  5 2.7
 9  5 2.8  4 2.8  2 2.6 13 2.5
10 10 2.5 12 2.7 13 2.8  6 2.6
11  9 2.6  7 2.6 10 2.3  3 2.4
12  8 2.7  6 2.7  2 2.5  9 2.6
13  5 3.0  9 3.6 11 3.2 12 3.2
14  7 3.0 13 2.8 14 2.4 11 2.5
15 10 2.4  4 2.5  8 3.2 11 3.1
;
               

/*---produces Output 1.6 on pages 20-22---*/

proc glm data=pbib;
   class blk treat;
   model response=blk treat;
   means treat;
   lsmeans treat / stderr pdiff;
   estimate 'treat 1 mean' intercept 1 treat 1;
   estimate 'trt 1 mean' intercept 15 treat 15
             blk 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 / divisor=15;
   estimate 'trt 1 blk 1' intercept 1 treat 1 blk 1;
   estimate 'trt 1 vs trt 2' treat 1 -1;
   contrast 'trt 1 vs trt 2' treat 1 -1; 
   random blk;
run;


/*---produces Output 1.7 on pages 24-28---*/

proc mixed data=pbib;
   class blk treat;
   model response=treat;
   random blk;
   lsmeans treat / pdiff;
   estimate 'treat 1 mean' intercept 1 treat 1;
   estimate 'trt 1 mean' intercept 15 treat 15 |
             blk 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 / divisor=15;
   estimate 'trt 1 blk 1' intercept 1 treat 1 | blk 1;
   estimate 'trt 1 vs trt 2' treat 1 -1;
   contrast 'trt 1 vs trt 2' treat 1 -1; 
run;


/*---------------*/
/*---Chapter 2---*/
/*---------------*/

/*---Data Set 2.2(a)---*/

data a;
   input block cult$ inoc$ drywt;
   datalines;
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
;
               

/*---Data Set 2.2(b)---*/

data b;
   input resista et wafer pos;
   datalines;
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
               

/*---produces Output 2.1-2.2 on pages 43 and 45---*/

proc mixed data=b;
   class et wafer pos;
   model resista = et pos et*pos;
   random wafer(et);
   lsmeans et pos et*pos;
run;

/*---produces Output 2.3 on page 47---*/
               
proc mixed data=b;
   class et wafer pos;
   model resista=et pos et*pos;
   random wafer(et);
   lsmeans pos/df=18.7;               
run;

/*---produces Output 2.4-2.5 on pages 48-49---*/

proc mixed data=b;
   class et wafer pos;
   model resista=et pos et*pos;
   random wafer(et);
   estimate 'et1 vs et2' et 1 -1 0 0; 
   estimate 'pos1 vs pos2' pos 1 -1 0 0;
   estimate 'pos1 v pos2 in et1' pos 1 -1 0 0 et*pos 1 -1 ;
   estimate 'et1 v et2 in pos1' et 1 -1 0 0 et*pos 1 0 0 0 -1;
   estimate 'et1,et2 v et3,et4 - pos 2'
             et 0.5 0.5 -0.5 -0.5 
             et*pos 0 0.5 0 0 0 0.5 0 0 0 -0.5 0 0 0 -0.5 0 0;
   estimate 'et1 v et2 in pos1' et 1 -1 0 0 
             et*pos 1 0 0 0 -1 / df=18.7;
   estimate 'et1,et2 v et3,et4 - pos 2' et 1 1 -1 -1 
             et*pos 0 1 0 0 0 1 0 0 0 -1 0 0 0 -1 0 0 / 
             divisor=2 df=18.7;
run;


/*---produces Output 2.6-2.8 on pages 50-52---*/

proc mixed data=b;
   class et wafer pos;
   model resista=et pos et*pos/ddfm=satterth;
   random wafer(et);
   lsmeans et pos et*pos;
   estimate 'et1 vs et2' et 1 -1 0 0; 
   estimate 'pos1 vs pos2' pos 1 -1 0 0;
   estimate 'pos1 v pos2 in et1' pos 1 -1 0 0 et*pos 1 -1;
   estimate 'et1 v et2 in pos1' et 1 -1 0 0 et*pos 1 0 0 0 -1;
   estimate 'et1,et2 v et3,et4 - pos 2'
             et 1 1 -1 -1 
             et*pos 0 1 0 0 0 1 0 0 0 -1 0 0 0 -1 0 0/divisor=2;
   contrast 'et1 vs et2' et 1 -1 0 0;
   contrast 'pos1 vs pos2' pos 1 -1 0 0;
   contrast 'pos1 v pos2 in et1' pos 1 -1 0 0 et*pos 1 -1;
   contrast 'et1 v et2 in pos1' et 1 -1 0 0 
             et*pos 1 0 0 0 -1 / df=18.7;
   contrast 'et1,et2 v et3,et4 - pos 2' et 1 1 -1 -1 
             et*pos 0 1 0 0 0 1 0 0 0 -1 0 0 0 -1 0 0 / df=18.7;
   lsmeans et*pos / slice=pos diff;
run;


/*---produces Output 2.9 on page 54---*/

proc glm data=b;
   class et wafer pos;
   model resista = et wafer(et) pos et*pos;
   random wafer(et) / test;
   lsmeans et/stderr e=wafer(et);
   lsmeans pos et*pos/stderr;
   contrast 'et1 vs et2' et 1 -1 0 0/e=wafer(et);
   contrast 'pos1 vs pos2' pos 1 -1 0 0;
   contrast 'pos1 v pos2 in et1' pos 1 -1 0 0 et*pos 1 -1;
   contrast 'et1 v et2 in pos1' et 1 -1 0 0 et*pos 1 0 0 0 -1;
   contrast 'et1,et2 v et3,et4 - pos 2'
             et 1 1 -1 -1 et*pos 0 1 0 0 0 1 0 0 0 -1 0 0 0 -1 0 0;
   estimate 'et1 vs et2' et 1 -1 0 0;
   estimate 'pos1 vs pos2' pos 1 -1 0 0;
   estimate 'pos1 v pos2 in et1' pos 1 -1 0 0 et*pos 1 -1;
   estimate 'et1 v et2 in pos1' et 1 -1 0 0 et*pos 1 0 0 0 -1;
   estimate 'et1,et2 v et3,et4 - pos 2' et 1 1 -1 -1 
             et*pos 0 1 0 0 0 1 0 0 0 -1 0 0 0 -1 0 0 / divisor=2;
run;


/*---produces Output 2.10 on pages 58-59---*/

proc mixed data=a;
   class block cult inoc;
   model drywt = cult inoc cult*inoc / ddfm=satterth;
   random block block*cult;
   lsmeans cult inoc cult*inoc;
run;

/*---produces Output 2.11 on page 60---*/

proc mixed data=a;
   class block cult inoc;
   model drywt = cult inoc cult*inoc / ddfm=satterth;
   random block;
run;


/*---produces Output 2.12 and 2.14 on pages 62 and 65---*/

proc glm data=a;
   class block cult inoc;
   model drywt = block|cult inoc cult*inoc;
   random block block*cult;
   lsmeans cult / stderr e=block*cult e;
   lsmeans inoc cult*inoc / stderr;
run;

/*---produces Outputs 2.13 and 2.15 on pages 64 and
     67-68---*/

proc mixed data=a;
   class block cult inoc;
   model drywt = cult inoc cult*inoc / ddfm=satterth;
   random block block*cult;
   lsmeans cult / e;
   estimate 'cult=1 broad' intercept 12 cult 12 0 inoc 4 4 4
             cult*inoc 4 4 4 0 0 0 | block 0 0 0 0
             block*cult 0 0  0 0  0 0  0 0 / e divisor=12;
   estimate 'cult=1 intermediate' intercept 12 cult 12 0 inoc 4 4 4
             cult*inoc 4 4 4 0 0 0 | block 3 3 3 3
             block*cult 0 0  0 0  0 0  0 0 / e divisor=12;
   estimate 'cult=1 narrow' intercept 12 cult 12 0 inoc 4 4 4
             cult*inoc 4 4 4 0 0 0 | block 3 3 3 3
             block*cult 3 0  3 0  3 0  3 0 / e divisor=12;
run;



/*---produces Output 2.16 on pages 69-71---*/

data unba;
   set a;
   if block=1 and cult='a' then delete;
run;

proc mixed data=unba;
   class block cult inoc;
   model drywt = cult inoc cult*inoc / ddfm=satterth;
   random block block*cult;
   lsmeans cult / e;
   lsmeans inoc cult*inoc;
   estimate 'cult diff' cult 1 -1 / e;
   contrast 'cult diff' cult 1 -1 / e;
run;


/*---produces Output 2.17 on pages 71-74---*/

proc glm data=unba;
   class block cult inoc;
   model drywt = block cult block*cult inoc cult*inoc;
   random block cult*block/test;
   lsmeans cult/e stderr e=block*cult;
   lsmeans inoc cult*inoc/stderr;
   estimate 'cult diff' cult 1 -1 / e;
   contrast 'cult diff' cult 1 -1 / e e=block*cult;
run;


/*---Data Set 2.8.1---*/

data mltloc;
   input obs loc$ block trt adg fe;
   datalines;
  3     A       1       3     3.16454     7.1041
  4     A       1       4     3.12500     6.6847
  6     A       1       2     3.15944     6.8338
  7     A       1       1     3.25000     6.5254
  9     A       2       2     2.71301     8.2505
 10     A       2       1     3.20281     7.5922
 12     A       2       3     3.02423     7.3894
 16     A       2       4     2.87245     7.4604
 19     A       3       1     2.68878     8.2785
 20     A       3       2     2.86862     7.9470
 21     A       3       3     2.89923     7.9739
 22     A       3       4     3.02806     8.4331
 25     B       1       3     2.18131     6.6691
 27     B       1       4     2.51914     5.6281
 28     B       1       2     1.88739     7.0723
 31     B       1       1     2.34685     6.0295
 33     B       2       4     2.45608     5.6195
 35     B       2       1     2.25225     6.3978
 36     B       2       3     2.23649     6.1799
 40     B       2       2     2.47523     5.9985
 41     B       3       2     1.94200     7.2975
 44     B       3       3     2.43243     6.4350
 47     B       3       4     2.30180     6.3339
 48     B       3       1     2.53378     6.1564
 50     C       1       4     2.96014     7.5110
 51     C       1       2     3.23551     7.4762
 54     C       1       3     3.24638     7.2063
 56     C       1       1     3.04710     7.6389
 58     C       2       3     3.26449     7.5466
 59     C       2       2     2.71377     9.0895
 61     C       2       1     3.06522     7.8723
 62     C       2       4     2.71739     8.2318
 66     C       3       4     3.03623     7.9426
 67     C       3       3     3.10507     8.4608
 69     C       3       1     3.16304     8.5549
 70     C       3       2     3.02899     8.5038
 74     D       1       1     2.49164     9.5758
 77     D       1       3     2.51833     9.5121
 79     D       1       2     2.35631    10.3264
 80     D       1       4     2.30331     9.7715
 81     D       2       3     2.72688     9.5628
 83     D       2       2     2.59512     9.9414
 85     D       2       1     2.56516     9.3887
 88     D       2       4     2.91523     8.3158
 89     D       3       3     2.57943    10.4416
 90     D       3       4     2.98159     8.7710
 93     D       3       2     2.35370    11.0148
 94     D       3       1     2.21953    11.2417
 99     E       1       3     2.84158     8.7886
100     E       1       4     2.65264     8.6946
102     E       1       2     2.47112     9.7143
103     E       1       1     2.89769     9.2401
105     E       2       2     2.57343     9.5353
106     E       2       1     2.99752     8.7538
110     E       2       4     2.95380     8.8210
112     E       2       3     3.08663     8.9427
114     E       3       1     2.72525     9.4308
115     E       3       2     2.75825     9.7721
116     E       3       3     3.08333     8.9010
117     E       3       4     3.12129     8.4852
122     F       1       1     3.20600     6.3983
123     F       1       2     2.89500     6.6569
125     F       1       4     3.36900     6.0821
126     F       1       3     3.12000     6.5349
130     F       2       2     3.19300     6.6729
131     F       2       1     3.29800     6.5488
133     F       2       4     3.09700     6.6598
135     F       2       3     3.38500     6.2998
139     F       3       3     3.44900     6.2849
140     F       3       2     3.05000     6.9957
141     F       3       1     3.43500     6.7302
143     F       3       4     3.60600     6.3827
145     G       1       2     2.58669     8.1394
147     G       1       1     3.17892     7.0972
148     G       1       4     2.95284     7.3140
151     G       1       3     3.17924     6.9430
154     G       2       4     2.62344     7.5150
155     G       2       3     2.64286     8.0237
157     G       2       1     3.12760     7.3169
160     G       2       2     2.54993     8.1957
163     G       3       4     2.58322     7.9687
164     G       3       3     2.84813     7.9284
166     G       3       2     2.69279     8.5303
167     G       3       1     3.14424     7.3564
169     H       1       3     3.39974     6.5945
173     H       1       2     3.12370     6.7530
175     H       1       4     3.17969     6.4279
176     H       1       1     3.70052     6.4830
177     H       2       2     2.95192     7.3809
179     H       2       3     3.44661     6.7929
182     H       2       4     3.28906     6.4807
184     H       2       1     3.37500     6.8139
188     H       3       4     3.65104     6.3068
190     H       3       1     3.27734     7.4789
191     H       3       3     3.42708     6.9327
192     H       3       2     3.04818     7.7264
193     I       1       2     2.22105     8.4243
196     I       1       1     3.15526     6.7119
197     I       1       4     2.40263     7.7486
198     I       1       3     3.00000     6.9215
203     I       2       1     2.29079     8.8861
204     I       2       4     2.25395     8.6850
205     I       2       3     2.60526     8.4150
208     I       2       2     2.34737     8.7866
209     I       3       2     2.50505     8.5975
212     I       3       1     2.31316     8.9267
213     I       3       4     2.42105     8.7750
214     I       3       3     2.74211     8.1599
;                                               


/*---produces Output 2.18 on pages 81-82---*/

proc mixed data=mltloc;
   class loc block trt;
   model adg=loc trt loc*trt;
   random block(loc);
   lsmeans loc trt loc*trt;
   contrast 'trt1 vs trt2' trt 1 -1 0;
   contrast 'loc1 vs loc2' loc 1 -1 0;
   contrast 'trt 1 v 2 at loc 1' trt 1 -1 0 loc*trt 1 -1 0/e;
   estimate 'trt1 vs trt2' trt 1 -1 0;
   estimate 'loc1 vs loc2' loc 1 -1 0;
   estimate 'trt 1 v 2 at loc 1' trt 1 -1 0 loc*trt 1 -1 0/e;
run;


/*---produces Output 2.19 on page 84---*/

proc mixed data=mltloc;
   class loc block trt;
   model adg=trt/ddfm=satterth;
   random loc block(loc) loc*trt;
   lsmeans trt;
   contrast 'trt1 vs trt2' trt 1 -1 0;
   estimate 'trt1 vs trt2' trt 1 -1 0;
run;


/*---------------*/
/*---Chapter 3---*/
/*---------------*/

/*---Data Set 3.2(a)---*/

data weights;
   input subj program$ s1 s2 s3 s4 s5 s6 s7;
   datalines;
 1      CONT      85    85    86    85    87    86    87
 2      CONT      80    79    79    78    78    79    78
 3      CONT      78    77    77    77    76    76    77
 4      CONT      84    84    85    84    83    84    85
 5      CONT      80    81    80    80    79    79    80
 6      CONT      76    78    77    78    78    77    74
 7      CONT      79    79    80    79    80    79    81
 8      CONT      76    76    76    75    75    74    74
 9      CONT      77    78    78    80    80    81    80
10      CONT      79    79    79    79    77    78    79
11      CONT      81    81    80    80    80    81    82
12      CONT      77    76    77    78    77    77    77
13      CONT      82    83    83    83    84    83    83
14      CONT      84    84    83    82    81    79    78
15      CONT      79    81    81    82    82    82    80
16      CONT      79    79    78    77    77    78    78
17      CONT      83    82    83    85    84    83    82
18      CONT      78    78    79    79    78    77    77
19      CONT      80    80    79    79    80    80    80
20      CONT      78    79    80    81    80    79    80
 1      RI        79    79    79    80    80    78    80
 2      RI        83    83    85    85    86    87    87
 3      RI        81    83    82    82    83    83    82
 4      RI        81    81    81    82    82    83    81
 5      RI        80    81    82    82    82    84    86
 6      RI        76    76    76    76    76    76    75
 7      RI        81    84    83    83    85    85    85
 8      RI        77    78    79    79    81    82    81
 9      RI        84    85    87    89    88    85    86
10      RI        74    75    78    78    79    78    78
11      RI        76    77    77    77    77    76    76
12      RI        84    84    86    85    86    86    86
13      RI        79    80    79    80    80    82    82
14      RI        78    78    77    76    75    75    76
15      RI        78    80    77    77    75    75    75
16      RI        84    85    85    85    85    83    82
 1      WI        84    85    84    83    83    83    84
 2      WI        74    75    75    76    75    76    76
 3      WI        83    84    82    81    83    83    82
 4      WI        86    87    87    87    87    87    86
 5      WI        82    83    84    85    84    85    86
 6      WI        79    80    79    79    80    79    80
 7      WI        79    79    79    81    81    83    83
 8      WI        87    89    91    90    91    92    92
 9      WI        81    81    81    82    82    83    83
10      WI        82    82    82    84    86    85    87
11      WI        79    79    80    81    81    81    81
12      WI        79    80    81    82    83    82    82
13      WI        83    84    84    84    84    83    83
14      WI        81    81    82    84    83    82    85
15      WI        78    78    79    79    78    79    79
16      WI        83    82    82    84    84    83    84
17      WI        80    79    79    81    80    80    80
18      WI        80    82    82    82    81    81    81
19      WI        85    86    87    86    86    86    86
20      WI        77    78    80    81    82    82    82
21      WI        80    81    80    81    81    82    83
;
               
/*---Data Set 3.2(b)---*/

data weight2; 
   set weights;
   time=1; strength=s1; output;
   time=2; strength=s2; output;
   time=3; strength=s3; output;
   time=4; strength=s4; output;
   time=5; strength=s5; output;
   time=6; strength=s6; output;
   time=7; strength=s7; output;
   keep subj program time strength;
run;
    
proc sort data=weight2; 
   by program time;
run;


/*---Data Set 3.2(c)---*/

proc means data=weight2 noprint; 
   by program time; 
   var strength;
   output out=avg mean=strength;
run;
               
               
/*---produces Output 3.1 on pages 91-92---*/

proc mixed data=weight2;
   class program subj time;
   model strength = program time program*time;
   random subj(program);
run;


/*---produces Output 3.2 on pages 94-96---*/

proc mixed data=weight2;
   class program subj time;
   model strength = program time program*time;
   repeated / type=cs sub=subj(program) r rcorr;
run;


/*---produces Output 3.3 on pages 97-99---*/

proc mixed data=weight2;
   class program subj time;
   model strength = program time program*time;
   repeated / type=ar(1) sub=subj(program) r rcorr;
run;


/*---produces Output 3.4 on pages 99-101---*/

proc mixed data=weight2;
   class program subj time;
   model strength = program time program*time;
   repeated / type=un sub=subj(program) r rcorr;
run;


/*---produces Output 3.5 on page 103---*/

proc mixed data=weight2;
   class program subj;
   model strength = program time time*program 
   time*time time*time*program / htype=1;
   repeated / type=ar(1) sub=subj(program);
run;


/*---produces Output 3.6 on page 104---*/

proc mixed data=weight2;
   class program subj;
   model strength = program time*program time*time*program / noint 
      s htype=1;
   repeated / type=ar(1) sub=subj(program);
run;


/*---produces Output 3.7 on pages 107-108---*/

proc glm data=weight2;
   class program subj time;
   model strength = program subj(program) time program*time;
   test h=program e=subj(program);
   random subj(program);
run;

/*---produces Output 3.8 on pages 110-113---*/

proc glm data=weights;
   class program;
   model s1-s7 = program / nouni;
   repeated time polynomial / printe summary;
run;


/*---Data Set 3.4(a)---*/

data wtsmiss;
   input subj program$ s1 s2 s3 s4 s5 s6 s7;
   u1=ranuni(54321); if u1<.15 then s1=.;
   u2=ranuni(65432); if u2<.15 then s2=.;
   u3=ranuni(76543); if u3<.15 then s3=.;
   u4=ranuni(87654); if u4<.15 then s4=.;
   u5=ranuni(98765); if u5<.15 then s5=.;
   u6=ranuni(09876); if u6<.15 then s6=.;
   u7=ranuni(10987); if u7<.15 then s7=.;
   datalines;
 1      CONT      85    85    86    85    87    86    87
 2      CONT      80    79    79    78    78    79    78
 3      CONT      78    77    77    77    76    76    77
 4      CONT      84    84    85    84    83    84    85
 5      CONT      80    81    80    80    79    79    80
 6      CONT      76    78    77    78    78    77    74
 7      CONT      79    79    80    79    80    79    81
 8      CONT      76    76    76    75    75    74    74
 9      CONT      77    78    78    80    80    81    80
10      CONT      79    79    79    79    77    78    79
11      CONT      81    81    80    80    80    81    82
12      CONT      77    76    77    78    77    77    77
13      CONT      82    83    83    83    84    83    83
14      CONT      84    84    83    82    81    79    78
15      CONT      79    81    81    82    82    82    80
16      CONT      79    79    78    77    77    78    78
17      CONT      83    82    83    85    84    83    82
18      CONT      78    78    79    79    78    77    77
19      CONT      80    80    79    79    80    80    80
20      CONT      78    79    80    81    80    79    80
 1      RI        79    79    79    80    80    78    80
 2      RI        83    83    85    85    86    87    87
 3      RI        81    83    82    82    83    83    82
 4      RI        81    81    81    82    82    83    81
 5      RI        80    81    82    82    82    84    86
 6      RI        76    76    76    76    76    76    75
 7      RI        81    84    83    83    85    85    85
 8      RI        77    78    79    79    81    82    81
 9      RI        84    85    87    89    88    85    86
10      RI        74    75    78    78    79    78    78
11      RI        76    77    77    77    77    76    76
12      RI        84    84    86    85    86    86    86
13      RI        79    80    79    80    80    82    82
14      RI        78    78    77    76    75    75    76
15      RI        78    80    77    77    75    75    75
16      RI        84    85    85    85    85    83    82
 1      WI        84    85    84    83    83    83    84
 2      WI        74    75    75    76    75    76    76
 3      WI        83    84    82    81    83    83    82
 4      WI        86    87    87    87    87    87    86
 5      WI        82    83    84    85    84    85    86
 6      WI        79    80    79    79    80    79    80
 7      WI        79    79    79    81    81    83    83
 8      WI        87    89    91    90    91    92    92
 9      WI        81    81    81    82    82    83    83
10      WI        82    82    82    84    86    85    87
11      WI        79    79    80    81    81    81    81
12      WI        79    80    81    82    83    82    82
13      WI        83    84    84    84    84    83    83
14      WI        81    81    82    84    83    82    85
15      WI        78    78    79    79    78    79    79
16      WI        83    82    82    84    84    83    84
17      WI        80    79    79    81    80    80    80
18      WI        80    82    82    82    81    81    81
19      WI        85    86    87    86    86    86    86
20      WI        77    78    80    81    82    82    82
21      WI        80    81    80    81    81    82    83
;



/*---Data Set 3.4(b)---*/

data wt2miss; 
   set wtsmiss;
   time=1; t=time; strength=s1; output;
   time=2; t=time; strength=s2; output;
   time=3; t=time; strength=s3; output;
   time=4; t=time; strength=s4; output;
   time=5; t=time; strength=s5; output;
   time=6; t=time; strength=s6; output;
   time=7; t=time; strength=s7; output;
   keep subj program time t strength;
run;

proc sort data=wt2miss; 
   by program time;
run;

data wt2miss;
   set wt2miss;
   if strength = . then delete;
run;
               
/*---produces Output 3.9 on pages 117-118---*/

proc mixed data=wt2miss;
   class program subj t;
   model strength=program program*time time*time*program / 
       htype=1 s noint;
   repeated t / type=ar(1) sub=subj(program);
run;

/*---produces Output 3.10 on pages 119-120---*/

proc glm data=wt2miss;
   class program subj time;
   model strength=program subj(program) time program*time;
   random subj(program);
   test h=program e=subj(program);
run;


/*---produces Output 3.11 on pages 121-125---*/

proc glm data=wtsmiss;
   class program;
   model s1-s7=program / nouni;
   repeated time polynomial / printe summary;
run;


/*---Data Set 3.5---*/

data hr;
   input patient drug$ basehr hr1 hr5 hr15 hr30 hr1h;
   array hra{5} hr1 hr5 hr15 hr30 hr1h;
   do i = 1 to 5;
      if (i = 1) then hours = 1/60;
      else if (i = 2) then hours = 5/60;
      else if (i = 3) then hours = 15/60;
      else if (i = 4) then hours = 30/60;
      else hours = 1;
      hours1 = hours;
      hr = hra{i};
      output;
   end;
   drop i hr1 hr5 hr15 hr30 hr1h;
   datalines;
201  p    92   76   84   88   96   84 
202  b    54   58   60   60   60   64 
203  p    84   86   82   84   86   82 
204  a    72   72   68   68   78   72 
205  b    80   84   84   96   92   72 
206  p    68   72   68   68   64   62 
207  a   100  104  100   92   92   68 
208  a    60   60   58   56   50   56 
209  a    88  104   88   88   78   84 
210  b    92   82   82   76   82   80 
211  b    88   80   84   80   80   78 
212  p   102   86   86   96   86   88 
214  a    84   92  100   88   88   80 
215  b   104  100   96   88   92   84 
216  a    92   80   72   64   68   64 
217  p    92   88   84   76   88   84 
218  a    72   84   78   80   80   76 
219  b    72  100   92   84   88   80 
220  p    80   80   80   78   80   78 
221  p    72   68   76   72   72   68 
222  b    88   88   98   98   96   88 
223  b    88   88   96   88   88   80 
224  p    88   78   84   64   68   64 
232  a    78   72   72   78   80   68 
;



/*---produces Output 3.12 on pages 128-129---*/

proc mixed data=hr order=data;
   class drug hours patient;
   model hr = drug|hours basehr;
   repeated hours / type=sp(pow)(hours1) sub=patient r rcorr;
   parms (0.1) (100);
run;


/*---Data Set 3.6---*/

data demand;
   input state$ year d y rd rt rs;
   logd = log(d);
   logy = log(y);
   logrd = log(rd);
   logrt = log(rt);
   logrs = log(rs);
   datalines;
CA  1949    533   1347   0.343   1.114   2.905
CA  1950    603   1464   0.364   1.162   2.935
CA  1951    669   1608   0.367   1.493   3.093
CA  1952    651   1636   0.369   1.567   3.073
CA  1953    609   1669   0.410   1.594   3.357
CA  1954    634   1716   0.499   1.609   3.295
CA  1955    665   1779   0.496   1.637   3.451
CA  1956    676   1878   0.533   1.757   3.539
CA  1957    642   1963   0.630   2.641   3.930
CA  1958    678   2034   0.667   2.641   3.982
CA  1959    714   2164   0.664   2.648   4.047
DC  1949    854   1603   0.261   0.676   2.803
DC  1950   1013   1773   0.267   0.662   2.877
DC  1951   1185   2017   0.266   0.677   3.006
DC  1952   1076   1921   0.267   0.729   2.975
DC  1953   1004   1856   0.287   0.883   3.035
DC  1954   1044   1868   0.308   1.500   3.083
DC  1955   1067   1931   0.318   1.504   3.177
DC  1956   1062   1951   0.322   1.598   3.250
DC  1957   1120   2085   0.346   2.231   3.368
DC  1958   1196   2144   0.360   2.100   3.457
DC  1959   1168   2167   0.418   2.342   3.727
FL  1949    408   1024   0.354   0.909   2.314
FL  1950    433   1007   0.342   0.957   2.327
FL  1951    469   1068   0.335   1.002   2.428
FL  1952    470   1068   0.328   1.052   2.577
FL  1953    464   1138   0.354   1.118   2.625
FL  1954    465   1137   0.374   1.268   2.871
FL  1955    545   1306   0.378   1.339   2.882
FL  1956    567   1339   0.399   1.486   3.032
FL  1957    531   1383   0.447   2.420   3.338
FL  1958    533   1409   0.498   2.453   3.353
FL  1959    522   1457   0.523   2.489   3.575
IL  1949    843   1465   0.143   0.852   2.504
IL  1950    860   1468   0.146   0.847   2.448
IL  1951    887   1555   0.147   0.936   2.449
IL  1952    914   1648   0.144   1.059   2.568
IL  1953    909   1711   0.150   1.091   2.703
IL  1954    928   1775   0.164   1.130   2.748
IL  1955    939   1815   0.172   1.141   2.778
IL  1956    944   1915   0.183   1.354   2.932
IL  1957    899   1980   0.203   1.628   3.155
IL  1958    919   2001   0.214   1.737   3.402
IL  1959    874   2035   0.231   2.054   3.497
NY  1949   1370   1492   0.112   0.687   2.099
NY  1950   1405   1515   0.119   0.724   2.082
NY  1951   1409   1566   0.119   0.795   2.218
NY  1952   1421   1659   0.120   1.050   2.435
NY  1953   1395   1744   0.134   1.241   2.477
NY  1954   1415   1802   0.145   1.346   2.540
NY  1955   1431   1808   0.146   1.406   2.655
NY  1956   1416   1916   0.168   1.754   2.774
NY  1957   1443   2074   0.189   2.231   2.957
NY  1958   1453   2120   0.192   2.360   3.073
NY  1959   1417   2197   0.203   2.521   3.223
TX  1949    573    995   0.149   0.839   2.755
TX  1950    634   1052   0.147   0.836   2.740
TX  1951    679   1154   0.148   0.812   2.819
TX  1952    668   1176   0.147   1.070   2.880
TX  1953    666   1228   0.160   1.170   3.082
TX  1954    708   1285   0.182   1.328   3.093
TX  1955    722   1335   0.191   1.368   3.071
TX  1956    708   1358   0.208   1.544   3.068
TX  1957    675   1416   0.250   2.121   3.487
TX  1958    716   1457   0.278   2.241   3.413
TX  1959    703   1520   0.303   2.435   3.671
WA  1949    418   1146   0.358   0.937   2.068
WA  1950    501   1324   0.361   0.973   2.229
WA  1951    525   1433   0.365   1.039   2.367
WA  1952    519   1481   0.381   1.305   2.553
WA  1953    500   1531   0.414   1.342   2.848
WA  1954    537   1602   0.481   1.348   2.865
WA  1955    545   1649   0.529   1.770   2.907
WA  1956    525   1656   0.587   1.779   3.011
WA  1957    494   1711   0.681   2.313   3.252
WA  1958    521   1754   0.716   2.302   3.306
WA  1959    515   1809   0.730   2.495   3.507
;                                            
 
/*---produces Output 3.13 on pages 132-133---*/

proc mixed data=demand;
   class state year;
   model logd = logy logrd logrt logrs / s;
   random state year;
run;


/*---------------*/
/*---Chapter 4---*/
/*---------------*/

/*---Data Set 4.2---*/

data e_2_2;
   input influent y;
   if influent=3 or influent=5 then type=1;
   else if influent=6 then type=3;
   else type=2;
   datalines;
1       21
1       27
1       29
1       17
1       19
1       12
1       29
1       20
1       20
2       21
2       11
2       18
2        9
2       13
2       23
2        2
3       20
3       19
3       20
3       11
3       14
4       14
4       24
4       30
4       21
4       31
4       27
5        7
5       15
5       18
5        4
5       28
6       41
6       42
6       35
6       34
6       30
;         


/*---produces Output 4.1 on page 142---*/

proc mixed data=e_2_2;
   class influent;
   model y=/solution;
   random influent/solution;
   estimate 'influent 1' intercept 1 | influent 1 0 0 0 0 0;
   estimate 'influent 2' intercept 1 | influent 0 1 0 0 0 0;
   estimate 'influent 3' intercept 1 | influent 0 0 1 0 0 0;
   estimate 'influent 4' intercept 1 | influent 0 0 0 1 0 0;
   estimate 'influent 5' intercept 1 | influent 0 0 0 0 1 0;
   estimate 'influent 6' intercept 1 | influent 0 0 0 0 0 1;
   estimate 'influent 1U' | influent 1 0 0 0 0 0;
   estimate 'influent 2U' | influent 0 1 0 0 0 0;
   estimate 'influent 3U' | influent 0 0 1 0 0 0;
   estimate 'influent 4U' | influent 0 0 0 1 0 0;
   estimate 'influent 5U' | influent 0 0 0 0 1 0;
   estimate 'influent 6U' | influent 0 0 0 0 0 1;
run;


/*---produces Output 4.2 on pages 143-144---*/

proc mixed data=e_2_2 method=ml; 
   class influent;
   model y=/solution;
   random influent/solution;
run;


/*---produces Output 4.3 on pages 144-145---*/

proc mixed data=e_2_2 method=mivque0; 
   class influent;
   model y=/solution;
   random influent/solution;
run;


/*---produces Output 4.4 on pages 145-146---*/

proc mixed data=e_2_2 noprofile; 
   class influent;
   model y=/solution;
   random influent/solution;
   parms (56.16672059) (42.57352791) / noiter;
run;


/*---produces Output 4.5 on pages 146-147---*/

proc glm data=e_2_2; 
   class influent;
   model y=influent;
   random influent/test;
run;


/*---produces Output 4.6 on page 147---*/

proc varcomp data=e_2_2 method=type1; 
   class influent;
   model y=influent;
run;


/*---produces Output 4.7 on page 148---*/

data satt;
   c=6.0973; * coefficient of var(influent) in e(ms influent);
   mssite=1319.77936508/31; * ms error;
   msi=1925.19360789/5; * ms influent;
   sa2=56.16672059 ; *estimate of var(influent);
   v=(sa2**2)/((((msi/c)**2)/5)+(((mssite/c)**2)/31)); * approx df;
   c025=cinv(.025,v); * lower 2.5 chi square percentage point;
   c975=cinv(.975,v); * upper 97.5 chi square percentage point;
   low=v*sa2/C975; * lower limit;
   high=v*sa2/C025; * upper limit;
run; 


/*---produces Output 4.8 on pages 150-151---*/

proc mixed data=e_2_2; 
   class type influent;
   model y=type/solution;
   random influent(type)/solution;
   estimate 'influent 1' intercept 1 type 0 1 0|influent(type) 1 0 0 0 0 0;
   estimate 'influent 2' intercept 1 type 0 1 0|influent(type) 0 1 0 0 0 0;
   estimate 'influent 3' intercept 1 type 1 0 0|influent(type) 0 0 1 0 0 0;
   estimate 'influent 4' intercept 1 type 0 1 0|influent(type) 0 0 0 1 0 0;
   estimate 'influent 5' intercept 1 type 1 0 0|influent(type) 0 0 0 0 1 0;
   estimate 'influent 6' intercept 1 type 0 0 1|influent(type) 0 0 0 0 0 1;
   lsmeans type/pdiff;
run;


/*---produces Output 4.10 on pages 152-153---*/
               
proc glm data=e_2_2 data=e_2_2;
   class type influent;
   model y=type influent(type);
   random influent(type)/test;
run;


/*---produces Output 4.11 on page 154---*/
 
proc varcomp data=e_2_2 method=type1; 
   class type influent;
   model y=type influent(type)/fixed=1;
run;


/*---produces Output 4.12 on page 155---*/

data satt;
   c=5.4393;mssite=1319.77936508/31; 
   msit=421.6388167/3;
   sa2=15.10794656;
   v=(sa2**2)/((((msit/c)**2)/3)+(((mssite/c)**2)/31));
   c025=cinv(.025,v);
   c975=cinv(.975,v);
   low=v*sa2/C975;
   high=v*sa2/C025;
run;


/*---Data Set 4.4---*/

data e_2_4;
   input sor lot wafer site y;
   datalines;
1      1       1        1     2006
1      1       1        2     1999
1      1       1        3     2007
1      1       2        1     1980
1      1       2        2     1988
1      1       2        3     1982
1      1       3        1     2000
1      1       3        2     1998
1      1       3        3     2007
1      2       1        1     1991
1      2       1        2     1990
1      2       1        3     1988
1      2       2        1     1987
1      2       2        2     1989
1      2       2        3     1988
1      2       3        1     1985
1      2       3        2     1983
1      2       3        3     1989
1      3       1        1     2000
1      3       1        2     2004
1      3       1        3     2004
1      3       2        1     2001
1      3       2        2     1996
1      3       2        3     2004
1      3       3        1     1999
1      3       3        2     2000
1      3       3        3     2002
1      4       1        1     1997
1      4       1        2     1994
1      4       1        3     1996
1      4       2        1     1996
1      4       2        2     2000
1      4       2        3     2002
1      4       3        1     1987
1      4       3        2     1990
1      4       3        3     1995
2      5       1        1     2013
2      5       1        2     2004
2      5       1        3     2009
2      5       2        1     2023
2      5       2        2     2018
2      5       2        3     2010
2      5       3        1     2020
2      5       3        2     2023
2      5       3        3     2015
2      6       1        1     2032
2      6       1        2     2036
2      6       1        3     2030
2      6       2        1     2018
2      6       2        2     2022
2      6       2        3     2026
2      6       3        1     2009
2      6       3        2     2010
2      6       3        3     2011
2      7       1        1     1984
2      7       1        2     1993
2      7       1        3     1993
2      7       2        1     1992
2      7       2        2     1992
2      7       2        3     1990
2      7       3        1     1996
2      7       3        2     1993
2      7       3        3     1987
2      8       1        1     1996
2      8       1        2     1989
2      8       1        3     1996
2      8       2        1     1997
2      8       2        2     1993
2      8       2        3     1996
2      8       3        1     1990
2      8       3        2     1989
2      8       3        3     1992
;                                 


/*---produces Output 4.13 on pages 156-157---*/

proc mixed data=e_2_4; 
   class lot wafer site;
   model y=;
   random lot wafer(lot);
run;

/*---produces Output 4.14 on page 158---*/

proc varcomp method=type1; 
   class lot wafer site;
   model y=lot wafer(lot);
run;


/*---produces Output 4.15 on page 159---*/

proc mixed data=e_2_4; 
   class sor lot wafer site;
   model y= sor/ddfm=satterth;
   random lot(sor) wafer(sor lot);
   lsmeans sor/pdiff;
run;


/*---produces Output 4.16 on page 161---*/

proc varcomp method=type1; 
   class sor lot wafer site;
   model y=sor lot(sor) wafer(lot sor)/fixed=1;
run;


/*---produces Output 4.17 on page 162---*/

proc mixed scoring=4; 
   class sor lot wafer site;
   model y= sor/ddfm=satterth;
   random lot(sor)/group=sor;
   random wafer(sor lot);
   lsmeans sor/pdiff;
run;


/*---Data Set 4.5---*/

data ex2_5;
   input loc block fam y;
   datalines;
1       1       1     268
1       2       1     279
1       3       1     261
1       1       2     242
1       2       2     261
1       3       2     258
1       1       3     242
1       2       3     245
1       3       3     234
1       1       4     225
1       2       4     231
1       3       4     219
1       1       5     236
1       2       5     260
1       3       5     248
2       1       1     238
2       2       1     220
2       3       1     243
2       1       2     215
2       2       2     192
2       3       2     226
2       1       3     198
2       2       3     151
2       3       3     191
2       1       4     195
2       2       4     182
2       3       4     202
2       1       5     201
2       2       5     161
2       3       5     196
3       1       1     221
3       2       1     216
3       3       1     224
3       1       2     208
3       2       2     197
3       3       2     201
3       1       3     186
3       2       3     173
3       3       3     161
3       1       4     207
3       2       4     183
3       3       4     186
3       1       5     200
3       2       5     207
3       3       5     190
4       1       1     194
4       2       1     194
4       3       1     197
4       1       2     203
4       2       2     191
4       3       2     204
4       1       3     177
4       2       3     170
4       3       3     180
4       1       4     180
4       2       4     195
4       3       4     193
4       1       5     199
4       2       5     183
4       3       5     208
;                        


/*---produces Output 4.18 on page 165---*/

proc mixed data=ex2_5; 
   class loc fam block;
   model y=;
   random loc fam loc*fam block(loc);
run;


/*---produces Outputs 4.19 and 4.20 on pages 166-168---*/

proc glm data=ex2_5; 
   class loc fam block;
   model y= loc fam loc*fam block(loc);
   random loc fam loc*fam block(loc)/test;
run;


/*---------------*/
/*---Chapter 5---*/
/*---------------*/


/*---Data Set 5.3---*/

data rcb;
   input id blk trt adg iwt;
   datalines;
 1     1       0    1.03    338
 2     1      10    1.54    477
 3     1      20    1.82    444
 4     1      30    1.86    370
 5     2       0    1.31    403
 6     2      10    2.16    451
 7     2      20    2.13    450
 8     2      30    2.23    393
 9     3       0    1.59    394
10     3      10    2.53    499
11     3      20    2.33    482
12     3      30    1.80    317
13     4       0    2.09    499
14     4      10    2.20    411
15     4      20    2.21    391
16     4      30    2.82    396
17     5       0    1.66    371
18     5      10    2.30    418
19     5      20    2.65    486
20     5      30    2.18    333
21     6       0    1.42    395
22     6      10    1.93    325
23     6      20    1.58    316
24     6      30    1.49    311
25     7       0    1.41    414
26     7      10    1.65    313
27     7      20    1.08    309
28     7      30    1.34    323
29     8       0    0.18    315
30     8      10    0.64    376
31     8      20    0.76    308
32     8      30    0.70    439
;


/*---produces Output 5.1 on page 178---*/

proc mixed data=rcb;    
   class trt blk;
   model adg=trt iwt*trt / noint solution;
   random blk;
run;


/*---produces Output 5.2 on page 180---*/

proc mixed data=rcb; 
   class trt blk;
   model adg=trt iwt iwt*trt / solution;
   random blk;
run;
              

/*---produces Outputs 5.3 and 5.4 on pages 181-182---*/

proc mixed data=rcb; 
   class trt blk;
   model adg=trt iwt / solution;
   estimate 'linear' trt -3 -1 1 3;
   estimate 'quad' trt -1 1 1 -1;
   estimate 'cubic' trt -1 3 -3 1;
   random blk;
   lsmeans trt / pdiff ;
run;


/*---produces Output 5.5 on pages 184-185---*/

proc glm;
   class blk trt;
   model adg= trt blk iwt / solution;
run;


/*---produces Output 5.6 on pages 186---*/

proc sort data=rcb; 
   by blk;
   proc means mean n; 
   var adg iwt; 
   by blk;
   output out=means mean=madg miwt n=NADP niwt;
run;
   
proc glm; 
   weight NADP;
   model madg=miwt;
run;


/*---Data Set 5.4---*/

data bib;
   input  id blk trt y x grp;
   datalines;
 1     1      1     31    20     13
 2     1      2     29    18     24
 3     1      3     31    11     13
 4     2      1     29    37     13
 5     2      2     34    37     24
 6     2      4     33    39     24
 7     3      1     31    29     13
 8     3      3     28    12     13
 9     3      4     34    31     24
10     4      2     39    37     24
11     4      3     35    29     13
12     4      4     32    28     24
13     5      1     33    12     13
14     5      2     35    19     24
15     5      3     38    16     13
16     6      1     35    31     13
17     6      2     31    13     24
18     6      4     42    39     24
19     7      1     42    38     13
20     7      3     43    30     13
21     7      4     42    25     24
22     8      2     27    13     24
23     8      3     37    39     13
24     8      4     29    21     24
;


/*---produces Output 5.7 on pages 188-189---*/

proc mixed data=bib;
   class blk trt;
   model y=trt x*trt/solution ddfm=satterth;
   random blk;
run;


/*---produces Output 5.8 on pages 190-191---*/

proc mixed data=bib;
   class blk trt; 
   model y=trt x x*trt/solution ddfm=satterth;
   estimate 'b1-b2' x*trt 1 -1 0 0; 
   estimate 'b1-b3' x*trt 1 0 -1 0;
   estimate 'b1-b4' x*trt 1 0 0 -1; 
   estimate 'b2-b3' x*trt 0 1 -1 0;
   estimate 'b2-b4' x*trt 0 1 0 -1; 
   estimate 'b3-b4' x*trt 0 0 1 -1;
   random blk;
run;


/*---produces Outputs 5.9-5.12 on pages 193-195---*/
              
proc mixed data=bib; 
   class blk trt grp; 
   model y=trt x*grp / solution ddfm=satterth;
   random blk;
   estimate 't1 at 25%=17' intercept 1 trt 1 0 0 0 x*grp 17 0;
   estimate 't1 at 50%=28.5'intercept 1 trt 1 0 0 0 x*grp 28.5 0;
   estimate 't1 at 75%=37' intercept 1 trt 1 0 0 0 x*grp 37 0;
   estimate 't1 at mean' intercept 1 trt 1 0 0 0 x*grp 26 0;
   estimate 't3 at 25%=17' intercept 1 trt 0 0 1 0 x*grp 17 0;
   estimate 't3 at 50%=28.5' intercept 1 trt 0 0 1 0 x*grp 28.5 0;
   estimate 't3 at 75%=37' intercept 1 trt 0 0 1 0 x*grp 37 0;
   estimate 't3 at mean' intercept 1 trt 0 0 1 0 x*grp 26 0;
   estimate 't2 at 25%=17' intercept 1 trt 0 1 0 0 x*grp 0 17;
   estimate 't2 at 50%=28.5' intercept 1 trt 0 1 0 0 x*grp 0 28.5;
   estimate 't2 at 75%=37'  intercept 1 trt 0 1 0 0 x*grp 0 37;
   estimate 't2 at mean' intercept 1 trt 0 1 0 0 x*grp 0 26;
   estimate 't4 at 25%=17' intercept 1 trt 0 0 0 1 x*grp 0 17;
   estimate 't4 at 50%=28.5' intercept 1 trt 0 0 0 1 x*grp 0 28.5;
   estimate 't4 at 75%=37' intercept 1 trt 0 0 0 1 x*grp 0 37;
   estimate 't4 at mean' intercept 1 trt 0 0 0 1 x*grp 0 26;
   ****comparisons of means at 25%, 75%, and 50%;
   estimate 't1-t2 75%=37'   trt 1 -1 0 0 x*grp 37 -37;
   estimate 't1-t2 50%=28.5' trt 1 -1 0 0 x*grp 28.5 -28.5;
   estimate 't1-t2 25%=17'   trt 1 -1 0 0 x*grp 17 -17;
   estimate 't1-t4 75%=37'   trt 1 0 0 -1  x*grp 37 -37;
   estimate 't1-t4 50%=28.5' trt 1 0 0 -1  x*grp 28.5 -28.5;
   estimate 't1-t4 25%=17'   trt 1 0 0 -1  x*grp 17 -17;
   estimate 't3-t2 75%=37'   trt 0 -1 1 0 x*grp 37 -37;
   estimate 't3-t2 50%=28.5' trt 0 -1 1 0 x*grp 28.5 -28.5;
   estimate 't3-t2 25%=17'   trt 0 -1 1 0 x*grp 17 -17;
   estimate 't3-t4 75%=37'   trt 0 0 1 -1  x*grp 37 -37;
   estimate 't3-t4 50%=28.5' trt 0 0 1 -1  x*grp 28.5 -28.5;
   estimate 't3-t4 25%=17'   trt 0 0 1 -1  x*grp 17 -17;
   ****comparison of LSMEANS at X=26***;
   estimate 't1-t2 at mean' trt 1 -1 0 0 x*grp 26 -26;
   estimate 't1-t3 at mean' trt 1 0 -1 0;
   estimate 't1-t4 at mean' trt 1 0 0 -1 x*grp 26 -26;
   estimate 't2-t3 at mean' trt 0 1 -1 0 x*grp 26 -26;
   estimate 't2-t4 at mean' trt 0 1 0 -1;
   estimate 't3-t4 at mean' trt 0 0 1 -1 x*grp 26 -26;
   lsmeans trt / diff e;
run;


/*---Data Set 5.5---*/

data incblk;
   input id blk trt y x;
   datalines;
 1      1     1     0.62    0.078
 2      1     2     0.91    0.010
 3      2     1     0.41    0.032
 4      2     2     0.48    0.050
 5      3     1     0.41    0.000
 6      3     2     0.49    0.015
 7      4     1     0.26    0.010
 8      4     2     0.28    0.016
 9      5     1     0.29    0.053
10      5     2     0.37    0.069
11      6     1     0.73    0.007
12      6     2     0.72    0.062
13      7     3     0.33    0.036
14      7     4     0.31    0.068
15      8     3     0.18    0.068
16      8     4     0.18    0.057
17      9     3     0.19    0.077
18      9     4     0.25    0.090
19     10     3     0.28    0.023
20     10     4     0.32    0.039
21     11     3     0.33    0.017
22     11     4     0.27    0.062
23     12     3     0.24    0.058
24     12     4     0.23    0.082
;


/*---produces Output 5.13 on pages 197-198---*/

proc mixed data=incblk;
   class blk trt;
   model y=trt x*trt / noint solution ddfm=satterth;
   random blk;
run;


/*---produces Output 5.14 on pages 198-199---*/

proc mixed data=incblk; 
   class blk trt;
   model y=trt x x*trt / noint solution ddfm=satterth;
   random blk;
run;


/*---produces Output 5.15 on page 200---*/

proc mixed data=incblk;
   class blk trt;
   model y=trt x / noint solution ddfm=satterth;
   lsmeans trt / pdiff;
   random blk;
run;


/*---Data Set 5.6---*/

data splitpt;
   input id met teacher gen$ student score y_ex;
   datalines;
 1     1        1        f        1         15      11
 2     1        1        f        2         17      11
 3     1        1        f        3         16      11
 4     1        1        f        4         16      11
 5     1        1        m        1         17      11
 6     1        1        m        2         16      11
 7     1        1        m        3         17      11
 8     1        1        m        4         17      11
 9     1        2        f        1         18       8
10     1        2        f        2         17       8
11     1        2        f        3         17       8
12     1        2        f        4         16       8
13     1        2        m        1         16       8
14     1        2        m        2         17       8
15     1        2        m        3         18       8
16     1        2        m        4         17       8
17     1        3        f        1         15       9
18     1        3        f        2         15       9
19     1        3        f        3         15       9
20     1        3        f        4         16       9
21     1        3        m        1         15       9
22     1        3        m        2         15       9
23     1        3        m        3         15       9
24     1        3        m        4         16       9
25     1        4        f        1         16      17
26     1        4        f        2         17      17
27     1        4        f        3         16      17
28     1        4        f        4         15      17
29     1        4        m        1         14      17
30     1        4        m        2         17      17
31     1        4        m        3         17      17
32     1        4        m        4         16      17
33     2        1        f        1         21       6
34     2        1        f        2         22       6
35     2        1        f        3         22       6
36     2        1        f        4         21       6
37     2        1        m        1         20       6
38     2        1        m        2         20       6
39     2        1        m        3         21       6
40     2        1        m        4         22       6
41     2        2        f        1         21      11
42     2        2        f        2         20      11
43     2        2        f        3         20      11
44     2        2        f        4         21      11
45     2        2        m        1         18      11
46     2        2        m        2         19      11
47     2        2        m        3         20      11
48     2        2        m        4         19      11
49     2        3        f        1         23      13
50     2        3        f        2         23      13
51     2        3        f        3         24      13
52     2        3        f        4         23      13
53     2        3        m        1         21      13
54     2        3        m        2         20      13
55     2        3        m        3         21      13
56     2        3        m        4         22      13
57     2        4        f        1         23      18
58     2        4        f        2         22      18
59     2        4        f        3         22      18
60     2        4        f        4         22      18
61     2        4        m        1         19      18
62     2        4        m        2         19      18
63     2        4        m        3         19      18
64     2        4        m        4         20      18
65     3        1        f        1         33       8
66     3        1        f        2         31       8
67     3        1        f        3         31       8
68     3        1        f        4         32       8
69     3        1        m        1         27       8
70     3        1        m        2         28       8
71     3        1        m        3         27       8
72     3        1        m        4         27       8
73     3        2        f        1         28      18
74     3        2        f        2         27      18
75     3        2        f        3         27      18
76     3        2        f        4         29      18
77     3        2        m        1         23      18
78     3        2        m        2         23      18
79     3        2        m        3         24      18
80     3        2        m        4         23      18
81     3        3        f        1         30      12
82     3        3        f        2         29      12
83     3        3        f        3         29      12
84     3        3        f        4         30      12
85     3        3        m        1         25      12
86     3        3        m        2         25      12
87     3        3        m        3         26      12
88     3        3        m        4         24      12
89     3        4        f        1         28       6
90     3        4        f        2         27       6
91     3        4        f        3         28       6
92     3        4        f        4         30       6
93     3        4        m        1         25       6
94     3        4        m        2         25       6
95     3        4        m        3         22       6
96     3        4        m        4         25       6
;                                                     


/*---produces Output 5.16 on pages 202-203---*/

proc mixed data=splitpt; 
   class teacher met gen;
   model score = gen*met y_ex*gen*met / solution noint ddfm=sat;
   random teacher(met);
run;


/*---produces Output 5.17 on page 204---*/

proc mixed data=splitpt; 
   class teacher met gen;
   model score = met gen gen*met y_ex y_ex*met y_ex*gen 
     y_ex*gen*met / ddfm=sat;
   random teacher(met);
run;


/*---produces Output 5.18 on page 205---*/

proc mixed data=splitpt; 
   class teacher met gen;
   model score = met gen gen*met y_ex y_ex*met y_ex*gen / ddfm=sat;
   random teacher(met);
run;


/*---produces Output 5.19 on page 206---*/

proc mixed data=splitpt; 
   class teacher met gen;
   model score = met gen gen*met y_ex y_ex*gen / ddfm=sat;
   random teacher(met);
run;


/*---produces Outputs 5.20-5.23 on pages 208-211---*/

proc mixed data=splitpt;
   class teacher met gen;
   model score =gen*met y_ex*gen / noint solution;
   random teacher(met);
   lsmeans  met*gen / pdiff at means;
   lsmeans gen*met / pdiff at y_ex=5;
   lsmeans gen*met / pdiff at y_ex=10;
   lsmeans gen*met / pdiff at y_ex=20;
   estimate 'f-m m=1 y_ex=5' gen*met 1 -1 0 0 0 0 y_ex*gen 5 -5;
   estimate 'f-m m=1 y_ex=10' gen*met 1 -1 0 0 0 0 y_ex*gen 10 -10;
   estimate 'f-m m=1 y_ex=20' gen*met 1 -1 0 0 0 0 y_ex*gen 20 -20;
   estimate 'f-m m=2 y_ex=5' gen*met 0 0 1 -1   y_ex*gen 5 -5;
   estimate 'f-m m=2 y_ex=10' gen*met 0 0 1 -1  y_ex*gen 10 -10;
   estimate 'f-m m=2 y_ex=20' gen*met 0 0 1 -1  y_ex*gen 20 -20;
   estimate 'f-m m=3 y_ex=5' gen*met 0 0 0 0 1 -1   y_ex*gen 5 -5;
   estimate 'f-m m=3 y_ex=10' gen*met 0 0 0 0 1 -1  y_ex*gen 10 -10;
   estimate 'f-m m=3 y_ex=20' gen*met 0 0 0 0 1 -1  y_ex*gen 20 -20;
   estimate 'male m=1 y_ex=5' gen*met 1 0 0 0 0 0   y_ex*gen 5 0;
   estimate 'male m=1 y_ex=10' gen*met 1 0 0 0 0 0   y_ex*gen 10 0;
   estimate 'male m=1 y_ex=20' gen*met 1 0 0 0 0 0   y_ex*gen 20 0;
   estimate 'male m=2 y_ex=5' gen*met 0 0 1 0 0 0   y_ex*gen 5 0;
   estimate 'male m=2 y_ex=10' gen*met 0 0 1 0 0 0   y_ex*gen 10 0;
   estimate 'male m=2 y_ex=20' gen*met 0 0 1 0 0 0   y_ex*gen 20 0;
   estimate 'male m=3 y_ex=5' gen*met 0 0 0 0 1 0   y_ex*gen 5 0;
   estimate 'male m=3 y_ex=10' gen*met 0 0 0 0 1 0   y_ex*gen 10 0;
   estimate 'male m=3 y_ex=20' gen*met 0 0 0 0 1 0   y_ex*gen 20 0;
   estimate 'female m=1 y_ex=5' gen*met 0 1 0 0 0 0    y_ex*gen 0 5;
   estimate 'female m=1 y_ex=10' gen*met 0 1 0 0 0 0    y_ex*gen 0 10;
   estimate 'female m=1 y_ex=20' gen*met 0 1 0 0 0 0    y_ex*gen 0 20;
   estimate 'female m=2 y_ex=5' gen*met 0 0 0 1 0 0    y_ex*gen 0 5;
   estimate 'female m=2 y_ex=10' gen*met 0 0 0 1 0 0    y_ex*gen 0 10;
   estimate 'female m=2 y_ex=20' gen*met 0 0 0 1 0 0    y_ex*gen 0 20;
   estimate 'female m=3 y_ex=5' gen*met 0 0 0 0 0 1    y_ex*gen 0 5;
   estimate 'female m=3 y_ex=10' gen*met 0 0 0 0 0 1    y_ex*gen 0 10;
   estimate 'female m=3 y_ex=20' gen*met 0 0 0 0 0 1    y_ex*gen 0 20;
run;


/*---Data Set 5.7---*/
               
data splitpt;
   input id met teacher gen$ iq score;
   datalines;
 1     1        1        f      89      54
 2     1        1        f     105      55
 3     1        1        f     108      54
 4     1        1        f     116      64
 5     1        1        m      95      59
 6     1        1        m     103      58
 7     1        1        m      91      42
 8     1        1        m      82      48
 9     1        2        f      83      48
10     1        2        f     103      56
11     1        2        f     123      67
12     1        2        f     103      54
13     1        2        m     118      65
14     1        2        m     101      65
15     1        2        m     101      50
16     1        2        m      82      55
17     1        3        f     115      71
18     1        3        f      91      66
19     1        3        f     109      69
20     1        3        f      85      59
21     1        3        m      98      76
22     1        3        m      84      64
23     1        3        m      91      63
24     1        3        m     110      74
25     1        4        f     120      75
26     1        4        f      98      60
27     1        4        f      99      64
28     1        4        f      91      59
29     1        4        m      80      55
30     1        4        m     112      70
31     1        4        m     105      63
32     1        4        m      94      62
33     2        1        f      97      67
34     2        1        f     105      74
35     2        1        f     120      78
36     2        1        f      92      69
37     2        1        m      91      67
38     2        1        m      96      64
39     2        1        m      95      65
40     2        1        m      84      52
41     2        2        f     105      73
42     2        2        f     110      78
43     2        2        f      98      75
44     2        2        f      92      65
45     2        2        m     104      75
46     2        2        m     105      78
47     2        2        m      82      58
48     2        2        m     109      75
49     2        3        f     141      97
50     2        3        f     107      68
51     2        3        f     116      82
52     2        3        f     105      86
53     2        3        m      93      71
54     2        3        m     113      82
55     2        3        m      92      72
56     2        3        m     115      77
57     2        4        f     112      74
58     2        4        f      96      76
59     2        4        f     103      78
60     2        4        f     105      77
61     2        4        m     111      75
62     2        4        m     121      86
63     2        4        m      87      68
64     2        4        m      90      74
65     3        1        f      87      71
66     3        1        f      78      71
67     3        1        f     117      85
68     3        1        f     108      87
69     3        1        m      92      65
70     3        1        m     111      72
71     3        1        m     126      85
72     3        1        m     123      78
73     3        2        f     126      91
74     3        2        f     112      80
75     3        2        f     108      75
76     3        2        f      92      65
77     3        2        m      95      73
78     3        2        m     109      73
79     3        2        m     115      78
80     3        2        m     115      71
81     3        3        f     102      82
82     3        3        f      96      72
83     3        3        f     113      87
84     3        3        f     127      91
85     3        3        m     112      85
86     3        3        m      96      68
87     3        3        m     114      86
88     3        3        m     101      78
89     3        4        f      95      86
90     3        4        f     105      91
91     3        4        f      95      81
92     3        4        f     102      85
93     3        4        m      80      68
94     3        4        m      97      81
95     3        4        m     114      89
96     3        4        m     100      87
;                                          

proc means data=splitpt; 
   var score; 
run;


/*---produces Outputs 5.24 and 5.25 on pages 212-214---*/

proc mixed data=splitpt; 
   class teacher met gen;
   model score = met gen gen*met iq*gen*met / solution ddfm=satterth;
   random teacher(met);
run;


/*---produces Outputs 5.26 and 5.27 on pages 215-216---*/

proc mixed data=splitpt; 
   class teacher met gen;
   model score = met gen gen*met iq / solution ddfm=satterth;
   random teacher(met);
run;


/*---produces Outputs 5.28 and 5.29 on pages 217-218---*/

proc mixed data=splitpt; 
   class teacher met gen;
   model score = met gen gen*met iq / solution ddfm=satterth;
   random teacher(met);
   lsmeans met gen met*gen / pdiff;
run;


/*---produces Outputs 5.30 and 5.31 on pages 219-222---*/

proc glm; 
   class teacher met gen;
   model score=met teacher(met) gen gen*met iq*gen*met / solution;
   random teacher(met) / test;
run;
   
proc glm; 
   class teacher met gen;
   model score=met teacher(met) gen gen*met iq / solution;
   random teacher(met) / test;
run;
                          

/*---Data Set 5.8---*/
 
data lots;
   input id grp temp type $ wafer site delta thick;
   datalines;
  1     1      900     A        1        1      291      1919
  2     1      900     A        1        2      295      1919
  3     1      900     A        1        3      294      1919
  4     1      900     A        2        1      318      2113
  5     1      900     A        2        2      315      2113
  6     1      900     A        2        3      315      2113
  7     1      900     B        1        1      349      1965
  8     1      900     B        1        2      348      1965
  9     1      900     B        1        3      345      1965
 10     1      900     B        2        1      332      1829
 11     1      900     B        2        2      334      1829
 12     1      900     B        2        3      331      1829
 13     1     1000     A        1        1      319      2098
 14     1     1000     A        1        2      315      2098
 15     1     1000     A        1        3      321      2098
 16     1     1000     A        2        1      290      1823
 17     1     1000     A        2        2      289      1823
 18     1     1000     A        2        3      292      1823
 19     1     1000     B        1        1      358      2059
 20     1     1000     B        1        2      357      2059
 21     1     1000     B        1        3      362      2059
 22     1     1000     B        2        1      365      2145
 23     1     1000     B        2        2      367      2145
 24     1     1000     B        2        3      367      2145
 25     1     1100     A        1        1      264      1846
 26     1     1100     A        1        2      266      1846
 27     1     1100     A        1        3      268      1846
 28     1     1100     A        2        1      276      2028
 29     1     1100     A        2        2      280      2028
 30     1     1100     A        2        3      278      2028
 31     1     1100     B        1        1      352      2086
 32     1     1100     B        1        2      353      2086
 33     1     1100     B        1        3      350      2086
 34     1     1100     B        2        1      330      1899
 35     1     1100     B        2        2      330      1899
 36     1     1100     B        2        3      334      1899
 37     2      900     A        1        1      306      1841
 38     2      900     A        1        2      302      1841
 39     2      900     A        1        3      305      1841
 40     2      900     A        2        1      342      2170
 41     2      900     A        2        2      341      2170
 42     2      900     A        2        3      336      2170
 43     2      900     B        1        1      342      1981
 44     2      900     B        1        2      341      1981
 45     2      900     B        1        3      340      1981
 46     2      900     B        2        1      366      2190
 47     2      900     B        2        2      363      2190
 48     2      900     B        2        3      361      2190
 49     2     1000     A        1        1      299      1915
 50     2     1000     A        1        2      296      1915
 51     2     1000     A        1        3      297      1915
 52     2     1000     A        2        1      329      2161
 53     2     1000     A        2        2      330      2161
 54     2     1000     A        2        3      332      2161
 55     2     1000     B        1        1      348      2072
 56     2     1000     B        1        2      346      2072
 57     2     1000     B        1        3      346      2072
 58     2     1000     B        2        1      350      2082
 59     2     1000     B        2        2      346      2082
 60     2     1000     B        2        3      347      2082
 61     2     1100     A        1        1      285      1854
 62     2     1100     A        1        2      292      1854
 63     2     1100     A        1        3      289      1854
 64     2     1100     A        2        1      306      2046
 65     2     1100     A        2        2      303      2046
 66     2     1100     A        2        3      304      2046
 67     2     1100     B        1        1      357      2062
 68     2     1100     B        1        2      360      2062
 69     2     1100     B        1        3      359      2062
 70     2     1100     B        2        1      361      2055
 71     2     1100     B        2        2      361      2055
 72     2     1100     B        2        3      360      2055
 73     3      900     A        1        1      318      2019
 74     3      900     A        1        2      323      2019
 75     3      900     A        1        3      323      2019
 76     3      900     A        2        1      307      1872
 77     3      900     A        2        2      308      1872
 78     3      900     A        2        3      308      1872
 79     3      900     B        1        1      372      2182
 80     3      900     B        1        2      371      2182
 81     3      900     B        1        3      370      2182
 82     3      900     B        2        1      348      1973
 83     3      900     B        2        2      349      1973
 84     3      900     B        2        3      352      1973
 85     3     1000     A        1        1      264      1828
 86     3     1000     A        1        2      265      1828
 87     3     1000     A        1        3      265      1828
 88     3     1000     A        2        1      274      1827
 89     3     1000     A        2        2      268      1827
 90     3     1000     A        2        3      275      1827
 91     3     1000     B        1        1      332      2109
 92     3     1000     B        1        2      337      2109
 93     3     1000     B        1        3      335      2109
 94     3     1000     B        2        1      322      2003
 95     3     1000     B        2        2      326      2003
 96     3     1000     B        2        3      321      2003
 97     3     1100     A        1        1      273      1925
 98     3     1100     A        1        2      275      1925
 99     3     1100     A        1        3      276      1925
100     3     1100     A        2        1      276      1942
101     3     1100     A        2        2      273      1942
102     3     1100     A        2        3      273      1942
103     3     1100     B        1        1      333      1893
104     3     1100     B        1        2      332      1893
105     3     1100     B        1        3      332      1893
106     3     1100     B        2        1      349      2170
107     3     1100     B        2        2      350      2170
108     3     1100     B        2        3      352      2170
109     4      900     A        1        1      295      1862
110     4      900     A        1        2      297      1862
111     4      900     A        1        3      296      1862
112     4      900     A        2        1      326      2149
113     4      900     A        2        2      326      2149
114     4      900     A        2        3      328      2149
115     4      900     B        1        1      322      1888
116     4      900     B        1        2      325      1888
117     4      900     B        1        3      327      1888
118     4      900     B        2        1      335      1998
119     4      900     B        2        2      332      1998
120     4      900     B        2        3      334      1998
121     4     1000     A        1        1      258      1815
122     4     1000     A        1        2      260      1815
123     4     1000     A        1        3      260      1815
124     4     1000     A        2        1      280      1981
125     4     1000     A        2        2      276      1981
126     4     1000     A        2        3      278      1981
127     4     1000     B        1        1      319      2012
128     4     1000     B        1        2      322      2012
129     4     1000     B        1        3      317      2012
130     4     1000     B        2        1      311      1892
131     4     1000     B        2        2      313      1892
132     4     1000     B        2        3      313      1892
133     4     1100     A        1        1      282      2083
134     4     1100     A        1        2      282      2083
135     4     1100     A        1        3      279      2083
136     4     1100     A        2        1      271      2036
137     4     1100     A        2        2      271      2036
138     4     1100     A        2        3      270      2036
139     4     1100     B        1        1      335      2174
140     4     1100     B        1        2      339      2174
141     4     1100     B        1        3      338      2174
142     4     1100     B        2        1      304      1802
143     4     1100     B        2        2      303      1802
144     4     1100     B        2        3      303      1802
;                                                            


/*---produces Outputs 5.32 and 5.33 on pages 225-227---*/

proc mixed; 
   class grp temp type;
   model delta=temp|type thick / ddfm=satterth;
   random grp grp*temp grp*type grp*type*temp wafer(grp temp type);
   lsmeans temp type;
   lsmeans temp*type / pdiff;
run;


/*---------------*/
/*---Chapter 6---*/
/*---------------*/


/*---Data Set 6.4---*/

data;
   input sire dam adg;
   datalines;
1 1 2.24
1 1 1.85
1 2 2.05
1 2 2.41
2 1 1.99
2 1 1.93
2 2 2.72
2 2 2.32
3 1 2.33
3 1 2.68
3 2 2.69
3 2 2.71
4 1 2.42
4 1 2.01
4 2 1.86
4 2 1.79
5 1 2.82
5 1 2.64
5 2 2.58
5 2 2.56
;


/*---produces Output 6.1 on page 236---*/

proc mixed;
   class sire dam;
   model adg=;
   random sire dam(sire);
   estimate 'sire 1 BLUP broad' intercept 1 | sire 1 0;
   estimate 'sire 1 BLUP narrow' intercept 1 | sire 1 0 0 0 0           
             dam(sire) 0.5 0.5 0 0 0 0 0 0 0 0;
   estimate 'sire1 BLUP dam 1' intercept 1 | sire 1 0 
             dam(sire) 1 0;
run;


/*---produces Output 6.2 on page 238---*/

proc glm;
   class sire dam;
   model adg=sire dam(sire);
   lsmeans sire /stderr;
   lsmeans sire / e=dam(sire) stderr;
run;


/*---produces Output 6.3 on pages 239-240---*/

proc mixed;
   class sire dam;
   model adg= sire;
   random dam(sire);
   lsmeans sire;
   estimate 'sire 1 mean broad' intercept 1 sire 1 0;
   estimate 'sire 1 mean narrow' intercept 1 sire 1 0
            | dam(sire) 0.5 0.5 0 ;
   estimate 'sire 1 - dam 1' intercept 1 sire 1 0
            | dam(sire) 1 0;
run;


/*---Data Set 6.5---*/

data;
   input machine operator y;
   datalines;
1 1 51.43
1 1 51.28
1 2 50.93
1 2 50.75
1 3 50.47
1 3 50.83
2 1 51.91
2 1 52.43
2 2 52.26
2 2 52.33
2 3 51.58
2 3 51.23
;
 
/*---produces Output 6.4 on pages 243-244---*/

proc mixed;
   class machine operator;
   model y=machine;
   random operator machine*operator;
   estimate 'BLUE - mach 1'  intercept 1 machine 1 0;
   estimate 'BLUE - diff' machine 1 -1;
   estimate 'BLUP - m 1 narrow' 
             intercept 3 machine 3 0 | operator 1 1 1
             machine*operator 1 1 1 0 0 0/divisor=3;
   estimate 'BLUP - diff narrow' 
             machine 3 -3 | machine*operator 1 1 1 -1 -1 -1/divisor=3;
   estimate 'BLUP - oper 1' 
             intercept 2 machine 1 1  | operator 2 0 0
             machine*operator 1 0 0 1 0 0/divisor=2;
   estimate 'BLUP -  m 1 op 1' 
   intercept 1 machine 1 0 | operator 1 0 0
             machine*operator 1 0 0 0 0 0;
             estimate 'BLUP - diff op 1' 
             machine 1 -1 | machine*operator 1 0 0 -1 0 0;
   estimate 'BLUP - m 1 interm' 
             intercept 3 machine 3 0 | operator 1 1 1
             machine*operator 0 0 0 0 0 0/divisor=3;
   estimate 'BLUP - op 1 broad' 
             intercept 2 machine 1 1  | operator 2 0 0
             machine*operator 0 0 0 0 0 0 / divisor=2;
run;


/*---produces Outputs 6.5 and 6.6 on pages 246 and 247---*/

proc glm;
   class machine operator;
   model y=machine|operator;
   random operator machine*operator / test;
   lsmeans machine operator machine*operator / stderr;
   lsmeans machine/stderr e=machine*operator;
   estimate 'diff' machine 1 -1 / e;
run;


/*---produces Output 6.7 on page 250---*/

proc mixed data=mltloc;
   class loc block trt;
   model adg=trt / ddfm=satterth;
   random loc block(trt) loc*trt;
   estimate 'loc 1 blup broad'
             intercept 4 trt 1 1 1 1 | loc 4 0/divisor=4;
   estimate 'loc 1 blup narrow' 
             intercept 4 trt 1 1 1 1 | loc 4 0 
             loc*trt 1 1 1 1 0/divisor=4;
   estimate 'trt 1 x loc 1 blup' 
             intercept 1 trt 1 0 0 0 | loc 1 0 loc*trt 1 0;
   estimate 'trt 2 x loc 1 blup' 
             intercept 1 trt 0 1 0 0 | loc 1 0 loc*trt 0 1 0/e;
   estimate 'trt 1 v 2 at loc 1' trt 1 -1 0 | loc*trt 1 -1 0;
run;


/*---------------*/
/*---Chapter 7---*/
/*---------------*/


/*---Data Set 7.2---*/

data wheat;
   input id variety yield moist;
   datalines;
 1       1         41       10
 2       1         69       57
 3       1         53       32
 4       1         66       52
 5       1         64       47
 6       1         64       48
 7       2         49       30
 8       2         44       21
 9       2         44       20
10       2         46       26
11       2         57       44
12       2         42       19
13       3         69       50
14       3         62       40
15       3         50       23
16       3         76       58
17       3         48       21
18       3         55       30
19       4         48       22
20       4         60       40
21       4         45       17
22       4         47       21
23       4         62       44
24       4         43       13
25       5         65       49
26       5         63       44
27       5         71       57
28       5         68       51
29       5         52       27
30       5         68       52
31       6         76       55
32       6         46       11
33       6         45       11
34       6         67       43
35       6         65       38
36       6         79       60
37       7         35       17
38       7         37       20
39       7         30       11
40       7         30       10
41       7         57       48
42       7         49       36
43       8         75       57
44       8         64       41
45       8         46       15
46       8         54       28
47       8         52       23
48       8         52       23
49       9         51       26
50       9         63       44
51       9         42       13
52       9         61       40
53       9         67       48
54       9         69       53
55      10         60       37
56      10         73       58
57      10         66       44
58      10         71       53
59      10         67       48
60      10         74       59
;


/*---produces Outputs 7.1 and 7.2 on pages 257-258---*/

proc mixed scoring=8; 
   class variety;
   model yield = moist / solution;
   random int moist / type=un sub=variety solution; 
run;


/*---produces Output 7.3 on pages 259-260---*/

proc mixed scoring=8; 
   class variety;
   model yield = moist / solution;
   random int moist / sub=variety solution; 
run;


/*---produces Output 7.4 on pages 262-263---*/

data class;
   input size@@;
   retain class 1;
   do i = 1 to size;
      output;
   end;
   drop size i;
   class + 1;
   datalines;
   21   29   16   24   20   19
   16    8   19   18   14   14
   13   19   22   17   11    9
   22   18   19   24   30   20
   16   21   29   22   18   19
   11   16   15    8   13   20
   21   17   20   19   17   17
   21   28   19   17   21   24
   26   35   21   20   22   18
   21   22   11   18    7   26
   19    7   25   18   17   18
   10   17   16    9   23   18
   17   19   17   13   20   17
    8   20   16   20   26   14
   17   27   16   23   25   20
   24   28    8   22   17   21
   25   14   21   23   13   28
   13   22   25   24   14   18
   38   14   21   21   25   27
   34   34   23   19   22   23
   23   26   25   26   14   24
   24   10   18   22   17   22
   20   19   14   16   17   19
    7    9   23   13   18   24
   24   19   30   21   17   26
   29   32   21    8    8   24
   15   27   15   18   15   18
   18   26   23    7   21   22
   23   15   20   18   29   25
   22   21   12   16   12   12
   15   17   20   20   21   15
   18   18   32   25
run;

data sims;
   input pretot gain @@;
   datalines;
 29    2   38    0   31    6   31    6   29    5   23    9   23    7
 33    2   30    1   32    3   22    4   29    6   34    2   30   -1
 35    1   25    1   22    3   31    1   33    3   31    1   35    2
 20    2   18   -3   12    5    9    1   11   -3   12    3   12   -8
 18   -6   13   -4    8    4   21    1    4    4   10    1    8    4
 12   -6   14   -2    9    2   11    3   11   -5   12    7   12    2
 17   -7    7    3   17   -6    9    2   16    2    4    1    5    8
 12   -4    7   -2   13    1   16  -10   11   -4    9   -1   11    6
  6    1    9    3    5    9   12   -5    8    1   12   -4    8    4
  9    2    9    5   11   -4   11    1   16   13   17    4   21    6
 18    9   21    0   18   -2   11    9   14   10   11   -4   13    4
 13    4   10    7   11    3   17    9   14    2   17    4   12    1
 12    8   13   -2   10    5   14    6   12   15   13   -5   20    5
 10    9   16    1   10    7   28   -4   11    5   14   -2   24    5
 13    7    5    5   23    8   11    5   18    4   21    5   24    4
 18   12   29    4   18    0    9   11   15    2   25    4   21    0
 20   10   30   -3   18  -10   26   -2   23   -4   18   -4   19    8
 18   -6   24    1   21    8   19   -1   31    0   14   -5   24    0
 19  -13   22  -10   21    6   20    2   11    6   10    7   24  -10
 24   -7   12    5   15   -4   14   -3    8    0    8   -2   16   14
 16   -4   18    4    4    0   21  -15   21  -12    9   -5   14   -6
  7   -1   13   -7   12   -5    4   10   17   -4   13   -7   16    5
 17   10   30    0   19   10   17   -7    9    2   17    0   15   -8
 12   10   14   -2   24  -11   24    1    6    4   15   -4   20    3
  5    3    8    2   10    5   14    8    6    4   18    2    9    0
 12    5    9    3    9    1   16   10   10    6    5   11    9    0
  9    1   11    1   13    0    7    5   27   -4    8   -2   12    2
 16   -7   14    5    8    4   11    4   16    4    8    2   11    7
  6    0    9    4   12    3   27    1   11    2   10   -1   17   -2
 10   -1   11   -1   15    4    7   -3    7    1    4    8    2   16
  7    8    5    1   16    0   12   -5   19   -2    5    3    6    2
 18    7    3    5    9    4    6    5    7    2   13   -7    8    3
  7    7    6    3    9    1    7    1    9    5    8    5    7    6
 22    2    9   16   18    7   27    6   28    8   14    7   13    0
 21   11   20    5   22    5   19    3   13   15   20    3   24    2
 32    4   17    0   17   11   12   13   19    3    8    7   17    7
 20   -1   14    0   12    3   12   12   17   -8   16   12   26   -2
 18   11   12   17   12    9   22    9   16    5   10    3   14    6
  7    2    6    6   19    5   12    9   10    8   17   -3    9    3
 13   10    8    2    8    5   21   10   12    1   12    2   27    6
 10    6   28    3   15    7   16    3   13    9   24   12   11   11
 15    4   19    8   10   -8   17  -10    6   -4   17   -6   16   -1
  9    1   11    2   13   -3    9    4    4    2    6    1   15   -3
 10    1   21    2   13    1   23    3   21   -7   31   -4   19   -4
 11    1    5    6   12    2   11    4   14    9    8    1   16    1
 16    4    8    4   11    1    9    0    4    6   13    8   13    1
 12   -4   12   -2   16    2   14    9   16    5   13   -1    9    0
  8    7   10    9   23    6   26    7   15    9   13    5   31    2
 31    4   22    5   18   13   26    6   31    4   22    2   23    9
 19    1   21   10   36    3   22   -2   21    6   15    5    8    2
 12   -1   11    7    7   15   13   -5   12   -2    4   11    7   -1
 12    0    7    3    4    7    8    3    8    5   21   -6   11    5
  6    5   12   11    7    2   18    4   23   -7   34   -5   33   -1
 30  -23   22    6   31  -22   32    6   30    5   26    6   33    3
 22    1   26   -2   29    4   24    7   34    0   30    7   30    4
 21    6   21    4   28    5   22   12   27   -3   16    9   36    2
 26   -1   37   -1   25   -2   30    6   28    8   32    2   34    2
 30    2   33    4   36    1   33    2   35    0   29    1   30    5
 37    1   30    1   27    3   36   -2   27    8   30    1   26    9
 32   -1   35   -2   33    3   27    7   28    4   34    3   32    6
 27    6   34    3   26    7   18   10   26    8    7   17   29    8
 33   -1   35    1   17   -9   32   -1   11   10   20    7   24    1
 31    6   20    4   21   10   14   12   25   11   15   12   18   11
 32    4   30    4   18   13   23    8   25    6   24    5   17   10
 15    9   26   11   25    5   16    2   12   18   27    6   13    5
 27    7   26    3   24    5   12    4   24   -1   15  -10   15   -1
  9    7   26   -1   15   -1   11    1   18    1   16    3    8    0
 14    7   15    1    5   10    9    5   21  -12   23    5   13    1
 13   -1   17    7   16    5   14    5   18    7   22    0   20    1
  9    9   16    4   19    3   22    6   22    8   24    4    9   11
 22    4   19    4   19    4   19    6   11    6    7    5   12    8
 16    7   12    1    7    2    6   15   10    0   19   -1   13    4
 12    9   13   -3   14    9   21    2   22    5   11    4   18    6
 19    4   23    1   12   -5   12    9   31   -2    9    8   31    4
 17    4   20    7   28    8   11    0   11   14   25    6   18   -5
 13    2   10    3   14   -3   15  -11    7    0    4    1   15    4
  5    9   14    3   12   -1    8   10   19    4    8    7   15   11
 20  -12   16    6    4    3   15    4    9   -3    7   -4   12   11
  7    3   13    6   20    4   20   11    8    7   23    5   23    9
 19    5   12    6   31    0   15    4    9   11   23    8   12   11
 15    8   11   16   28    4   10    8   22    9   17   13   10   14
 12   -2   10   22   21   -1    7    4   28  -13   12   19   15   13
  9   17   12   -5   29    1    9   10   11   11   20   14   20   11
 19    7   18    4   18   14   21    2   30   -3   21    9   14   11
 22    4    9   16   21    7    9    3   12    4   17    5   23    6
 13    7   33    0   23    2   23    7   28    3   27    2   11    1
 19    6   31    0   14    3   11   -3   14    8   11    7   25    5
 11   13   22   -7   16   15   17   11    7   24   28   -6   20   -7
 11    8   15    3   23    4   33    2   17    3   21   -9   20    2
 25    6   11   19   25   -1   19   13   29    9   28    5    9    2
 18   11   21   11   11   14    6   16   10   -1   14    5   28    7
 20   14   17   16   22    4   10    2   19    6   11    6   24    9
  9    6   18    8   16   15   18    7   13    4   24    5   31    6
 11    4   28   -6   17   13   21    5   23    7   10   -4    8    5
 28    6   22   -6   19    6   27    0   15    5   18    9   27    3
 25   -2   10   10   26    7   16    2   20    2   19   10   26    7
  9    3   18   16    9   12   10   17   32    2   16    6   16   10
 13   -3   15   14   17   -1   20    5   16   10   27   -3   28    2
 19    0   16    0   16   11   15    1   30    2   36   -1   12    9
 23   10   11    1   13   10   20    9   23   11   20   14   21    8
 20    7   23    7   23    9   30    7    7    4   23    6   12   11
 18   13   21    7   11    4   20   10   17    4   17    4   17    3
 10    3   22    3   18    7   19    7   28    7   23    6   26    6
 15    7   22    6    5    7   24   10   18    2   17   16   17    0
 11   -4   26    4   17    6   17    9   26    2   19   -1   16    3
 25   -1   20   -1   13   10   29   -2   23    1   28    7   25    8
 24    1   23   11   21    2   18    5    8    5   13    5   30    4
 17    7   24    5   26    8   19    5   17   -9   16   10   10    4
 15    3   16    8   20   14   20    3   12   11   10    4   10    8
 13    3   11    3   28    8   25    6   17   14   18   13   10    9
  6    6   11   16   25   10   14   12   24    4   20    3   20   10
 17   17   20   14   16    9   27    4   11    7   14   -4   13    4
 19    2    8   11   14    5   18    8   13    2   11    2    7    7
 11    2   12    7   12    8    9    3   28    4   15    5   11    7
 14   -4   12    6   24    5   19    5    8    4   15   -6    9   18
 13    3   22    4   24    8   16    9   12    3    9   -2    7    3
  6   -2   11   -6    9   -2    6    2    3    3   18    5   15   -1
 11    0    8   -1   10    7    6   -2    9   -2    8    5   10    1
  8    2    6   -1    5    0   15    5   23    5   34    0   15    8
  9    3   18    6   18   11    8    2   14    1    9    3   13   -4
 25    7   16    4   12    1    7    6   16    1   23    1   14   -3
 14    2   29    4   20   10   15    4   13   -3    8    0   26   -3
 25    3   12    6   20    2   14   17   11   13   17    4    7    2
 15    8   17   11   15    0   10   15   28    5   17    8   15   11
 17   15   16    4   18    7   14    8   20   10   37    0   17    6
  9   12   27    8   26    0   16   12   25    7   35   -2   22   12
 30    1   27   10   26    0   29    1   19    6   24   11   28    4
 29    7   14    8   16   12   24    5   15    5   25   -5   19    6
 14    5   10    6   16    0   17    8   23   10   22    9   17    8
 10    6   16   15   25   -2    7   10   14    5   12    9   23    3
 16    2   16    1   25    8   10   13   21   -5   12   11   19    3
 19    7   26   -3   31    4   26    4   27    2   19   11   22    7
 22   10   21   11   29    6   14    8   15    3   31    3   22    1
 19    5   33  -24   25    7   19   12   23    5   24    1   16   10
 30    4   29    4   23    4   30    4   16   12   23   10   25    6
 19    9   28    4   20   -4   21   12   26    2   27   -1   23    0
  9    2   12    4   18    9   27    2   11   -5    8    4   11    7
 25    1   11   -1   11    1   15    5   22    2   14    9   13    2
  9    2   10   -1   13    3   15    3   13   10   19   10   27    7
 21    5   35   -2   28   -2    7    7   15    5   18   -2    8    3
 28    1   12    9   17    8   25    2   10   -2   17    6    9    5
 15    4   30    0   22   -1   17    0   25    1   22   -3   26    4
 17    1   16    4   27    8   14    9   24   -1   17   10   25    9
 36    2   18    5   27    2   17    8   13   11   22    3   24    7
 11    6   25    4   17   13   23    1   16    6   11   11   11    7
 23    8   22   11   18   15   31    2   27    6   16   12   31    3
 22   15   28    8   23    8   29    1   22    8   30    4   24    5
 29  -20   27    6   28    6   24   12   10    8   10   11    9    6
 18    9   19    3   12   13   10   13   14    7    6   15   21    9
 14    4   12    9   14   14   21   10    6    6   17    9   11   11
 12   10   12    6   11    8   18    9   16   10   27    8   21    6
 20    9   30    1   23    7   18   10   31    6   15   10    9    6
 22   12   21    1   13   14   26    6   16   10   26    6   29    5
 24   10   18   11   21    0   21    0   25    7    9    2   10    1
 15    1   10   -1   17   -5    5    8   10   10   12    3    6    1
 10    6   11    5    7    3    6    9    7    0    8    0   10   -4
 15   -2    7    0    7    8    8    0   10    3    7    0    9   -2
  9    1    4    6    3    6   12   -7    5    6    4    6    7   -5
  3    6   10   -5    8   -7   14  -13   10   -2    9    3    9    5
  8   11   16    4   17   16   11    5    8    6   23    9   10    6
 15  -10   16   -3   19    2    8    9   18    3   18   14   15   -2
 18   10   10   20   18   -4   12    6   10    0   23   13   19    1
 18   12   10   12   26    2   13   -2   17    2   18   11   15    5
 10   14   17    7   20    0   18    2   10   -5   12    8   14    6
 12   -5   10   12   14   15   13    4   11    6   14    0   16   11
 19    7   16   14   10    4    6   -2    5    1    3    3    4   -4
 12   -8    6   -1   28    4   24    1   24   12   23    0   23   -1
 25    5   30  -11   30   -3   34   -3   34    0   33    3   24    4
 27  -12   25    1   16    6   31   -4   25   -5   22    4   15    2
 19   -1   27    6   17   -5   24   -3   31  -14   37   -9   11   -1
  7   -3   16    4   16    3   11   -4   13    8   10   10   23    1
 10    7   11   -5   13   -1   11    2   15   -1   23    3   18  -13
 25   -2   16    9   14   -1    6    0   14   -1   14    9   14   -4
 19   -1   11   -4   19    0    7    2    2    0   13    4    8    6
 11    2    5    0    6    0    8    1   12   -2   10    2   13    8
 16   13   15    0   18    3   17    4   11   12   15    4   12    2
 16   14   14    5   15    8   17    6   16    4   15   11   13    7
 11    6   12    5   15    2   13    6    7    5    6    3   14    1
 12    2   16    4   16   -5    6   -1   14   -4    8    5   14    6
 16   -4   13   -4    6    5    9    1   12    5   15    5   18    8
 14    2   13    0   12    5   15   10   14   13   27    4    9    9
 12    3   12    2    8    1    8    0    7   18   10   10   12    4
  7    5    6   13   11   15   12   13   17    4    9    6    8   16
 15   13    9    7   11    4    9    4    6   -2   13   -3    4    2
  7    2    9    4    5    0    6    5    8   -1    6    0   16    6
  9    1   22   10   19    4   18   -1   18  -14   13    5   10   -1
 13   -3   19    6   25    0   19  -10   13    4    8    3   13   -8
 17    2   26   -6   18    2   21    1   10    1   17    7   10    0
 18   -3    9    6   13    1   11   -4   15   15   11    2   17    5
 16   10   19   11   22    9   13   16    8   19    9   14   23   10
 18   14   14    7   12    5   15   21   17   11   21   11   13    6
  8   12   17   16   18   18   17   11   15   11    7   19   17   16
 19    4    6   16   15   16   14    5   14   11   21    5   11   17
  6   11   20   10   25    6   12    1   13   -1   15   10   19    4
  8    6    9   20   26    7   24    6   16   10    6    7    7    3
 24    7   10    3    9   13   13    7   19    9   17   11   21   11
 18    6   13    0    4    6   20   11   14   12   24    1   20   10
 14    4   27    6   31    5   25    8   15   11   16   -1    7    0
 17    9   22    0   12   -6    8    1    9    5    9    5    8    7
  8    5    8   12   20    2    9    0    4    4    5    1    8    8
  6    2   12   -1    7    6    6    8   17    9   11    5    3    9
 13   -9   22    1   16    4   10    4   10    1   10   -2    8   11
 13    5   10    2   14    7   23    9   14    2   13    9   11   13
  4    9   11    0   15    2   18    7    7   -1    4   12   16    6
 17    8    9    8    7    3   12   -1   12   -4   13    1   14    3
  8   -2   10  -10   16   -5    6    1    9   -3    5    1    3    7
  7   -2    6    2    8   -2    8   -1    4    2    6    9    6   -6
 15   -7   16    9    7   -2    8   -1    4    8    7    3   22    3
 15    4   11   -1   13   -7    7    2   14   -8   11    5   17    7
 11   -3   14    1    9    8   17    2   19    6   24   -5   17  -13
 19  -10   15   -1   32    1   21    3   10    4   25  -12   13    2
 18    3   20    5   16    1   13   -2   28   -5   15    3    6    5
 15   -9   11   -8   13   -2    6    1   10    6    6    3   13    1
 13   -2   13    6   10   -1    5   11   14    4   10   -3   15    3
 11    4   15   -2   19   -2   10   -5   23    3   24   -1   11    5
 19    9   16   10   16    6   14    6   10    9   25   -3   12    5
 12   12   18    8   21    9   12    4   14    1   19    5   11    5
 17    4   19   -3   12    2   12    1   16    3   22    4   18    3
 12    4   20   10    5    5    7   11   11    1   10    8    6    9
  7    3   14    4    6    4    6    5   19   -2    8    7   17    5
 10    4   13    3   26    6   13    7   19    6   12    2   12    8
 17    5   19    9   16   12   12   10   18    1   20   13   11   11
 28    4   10   12   11   13   18    8   24    2    9    5    8    3
  6    6    8    2    6   11    9   -2    7    6    9    3    9    5
  8   -6    5    7    9    1    6    2   13    0    9   -5    9    3
  7    4   13   -1    9    7    7    5    5    0   12   -6    6    2
  7    2   10   -3   14    1    6    4   11    4   11    1    6    5
  8   -1    9    0   11    1    7    7    8    4   18    4    7    2
 10    1   11    7    5    2   14    2   14   -1   12    1   11    0
 10   -2   10   -1    9    1    5   -1    9    4    6    1    5    1
  7    8    8   -2    5    2    7    1    4    3    8    1    9   -1
  6   -3   10    0   12    1    3    5    9   -1    8    0   11   -3
  8   -4   17    6    8    4   16    1   27    3   21    0   13    9
 23   -3   29  -10   29    5   14    8   14    4   31    3   16   10
 22    4   28    1   29    9   26    3   14   -3   32    4   22    5
 17   10    9    9   26    3   16   11   21   12   15    3   12   -2
 11    9   12   -3    7   -2    8    1   10   -2    9   -2   19    4
 10    2    8    2    8   -5   11   -2    7    2   18    0    9   -1
 11    2   12    0    9    1    8    2    9    1    6    2   20    5
 14   -2   17    1    9   12   13   -1   18    0   11    4   10    6
 12    2   10    8   10    2   16   14   12    2   14   16   28    5
 12   15   11   -1   10    6   12    9   13    7   10   16   18    0
 17    6   16    4   31    4   16   11   13    6   11   14    7    1
 21    3   21    4    9    7   10    5   14    7   12   11   12    0
 23    4   23    1   25    4   12    4   22    0   21    3   11   11
  9   -4   27    4   15    7   27    4   12    7   13    0   25    1
 11   -1   20    0    6   14   15    4   12    8   15   -1    3    9
 23   -5    8   11   10   10   10    5    7    6    7   11    7   15
  8   19    7   12    9   15   15   18   13    6   10    3   10    8
 19    6    5   16   13    4    7    5    8   12    6    6    9   11
  8   13   16   13    8   10   17    8    9    8   11    8   10    3
  9    8   10   16   11   17   27    2   14    3    9   19    8   19
  9    9    8   11    6   14    9   15    8    5   12    9   17   -9
 12    5   13    6   17   -5   11   -2   11   -4    8    1   10    7
  7   -1   13   -3   11   -1    7    2    7    5    6    7    8   -1
 14    2   14    2   15   -3   13    0   16    1   36   -2   28    3
 24    2   29    2   21    5   26    1   19  -18   21    9   33    6
 29    6   22  -19   23    6   31   -1   22    3   18    9   24    6
 14    2   31    1   13    8   36    1   19    5   36   -5   29   -4
 29  -22   23    1   10   -3    9   -1    1    2   10   -3    6    0
  6    3    8    4    8    4    3    3    9    0    6    3    5    1
  4    6   10   -2   13   13   14    4   15   -3   13   14   13   14
 10    3   17    5    9    7   16    4   13   17   14    4   14    3
 16   13   10    0   16    1   19    5   12   11   12    8   13   10
 10   13   14    3   16   12   18    5   14   -6   15    1   10    4
 15   13   22    5    6   10   21    1   21   -2   11    9   13    8
 15   -2   13    8   15    9   14    3   16    9   16    3   12    4
 11   14   11    7   18   11   15    7   13   -5   12    2    7    0
  8    0   11    6   14   -1    8   15    9   -1    8   -1    7   12
 10    4    5    3   17    0   24    5   33    4   17    5   17    4
 23    6   21   13   10   12   28    8   23    5   13    8   16    3
 20    5   24    4   20   10   21    9   16    4   14    8   25   10
 23    5   13    9   27    2   18    2   16    4   31    2   29    4
 21    6   26    2   12    9    8    4   17    8    7    5   26    1
 10    5    9    2   14   -1    8    8   14    2    8    2    7    3
 12    1    9    8   18    3   15   10   13    4   17   12   13   -7
 16   10   15   11   12    9   13   16    9   15   26    9   23   12
 16    9   16    6   24    4   24    4   10   10   18   12   17    2
 22    7   19    6   27    1   24    2   17    6   17    4    4    8
  9    3   10    0   20    9   10    8   30    2   32    0    7    5
 21    3   13    7   24    2   15   -1   10   -2    8   -3   16    1
  9    4   33    3   22    6   10    9   20    1   12    3   15   11
 16  -10   23    0   21   11   10    3   16    4   23    8   11    3
  8   11   19    7   26    1   13   -3   30   -4   10   14   18    2
 29    1   14    2   16   12   29    5   16    8   16    1   12    6
 14    9   22   12   15    9   30    0   37    2   32    1   25    9
 26    8   24    6   22   10   32   -1   32   -3   30    8   27    9
 31    1   24    2   25    1   17   -4   25    5   20    6   12   15
 23    5   13    4   18    5   14   14   11   15   14    8   20    6
 18   10   15    2   12    6   12   -4   18   10   16    8   13    3
  6    4   19   15   16   10   26   10   14    7   15   16   24    5
 20    4   10    6   16    4   19    8   21    5   16    4    6   12
 15   10   24    9   23   10    2    4   15    0   11    9   13   10
 14    3   11    6   17    6   17   11   21    4   16    8   25   10
 21    1   16    0   22    5   19    7   11   10   18   -2   17    6
 14    9   23    3   20    8   23  -16   12   16    3    3    7    9
  8    4   23   12   13    6   22    4   15   -1   13    5    6   25
 16    5    9    5   10    5   10    0   10   -3    9   -2   12    0
 17   -1   18   -1    8    2   18   -5   15   -2   10   -1   10   -4
  9   11   14    5   16    5   20    2    8    5    7    2   12    4
 20    1   10    9   13    5    5   -1   11   -5   13    8   25    2
 13    2   14   10   15    0    9    2    5    6   12    7    9    8
 19   -2   15    0    9    0    8    4    3    9   10    4   12    2
 12    4   12    1    6    7   19    4    7   16   13    9    5   11
  6    4   11    0   24    2   11   14   13    0    9    8   32    0
 15   11    8    1    6   12   22    1   11   -3   17    9   19   -6
 10    2    5    6   13   -3   24   -6   14    9   17    5   12    5
 19    7    9   -3   11    3    6   -1   26    1    7    4   14    5
  9    9   19   11   17    8   12   -5   20    9   10    3    8    2
  5    8    8    7   13    4   10    4    8    0    5    7   10   17
  7    7   14    4    8    1    9    1   11    5   20   14   16    8
 21    8   11   10   19   -9   17    7   27   -3   22    4   25    6
 24    8   16   10   21    2   28    3   17    0   19    3   21   13
 21   12   18    8   25    8   27    3   18    9   24    3   22    1
 19    0   28    6   34    3   25    3   20    9   22    4   28    7
 20   13   25    7   26   -8   27    0   20    3   11    9   17   -3
 13    4   12    1   10   12   16    0   15    5   10    1   15    9
 12    1   13   -1   17   -5   22    2    9    1    7    3   17   -1
 18    5   10   -1   18    5   20    3    6    7   14    9   10    4
 21    3    8   -1   15   -5   13    1   13   -3   17   -1   13   -4
 15    0    9    8   18   -3    7   -1   19   13   18    9   31    3
 17    3   25    2   13    6   16    1   14    9   10   10   14    5
 23   10   11    2   18    4   16   11   17   10   13    5   18   12
 17   11   17   15   21    5   24    9   24    5   21    7   13   -1
 18    9   10   -1   11   -3   10    5    6   -1    7    2    7    4
  5    0   14   11   11   -3   11    3    9    3   13   -2   27    7
 10    4    9    0   12   -4   12    2   29    1   27    4   22   12
 19   10   19    5   28    2   27    4   25   11   20   -2   19    2
 16    9   21    8   27    4   29    5   16   16   23    6   30    3
 33    2   30    5   28    5   27   -2   27    7   22    8   25    6
 16    1   19   -1   14    9   19    4   17    9   14    8   13    6
 13    9   17   -1   13    3   21    1   18   10   10    4   17    8
 12   12   18    5   17    4   30    3   14    3   27    7   29   -3
 15    8    6    0   12    6   14    2   15   -2   10    5   10    4
  7    0   13    0   10   10   18    0   15    0   19    5    6    7
  9    3   16    0   10    8    8    6   13    1    8    5   13   -5
  8    7    9    8   13   16   18    3   22   10   22    1   30    3
 13    1   20    8   27    6   23   -8   16   -5   19   11   21    3
 14    9   14   -7   10    5   15    0    7    9   18  -13   34    0
 14    1   11    6   22    6   20    2   16    6   16   -5   14    2
 14   19   11   13   20    9   15    6   10   11    6    3   24    4
 18   12    8    4   21   13   12   -2   31    0   24    8   25    4
  9    1   16    6   15   13   24   12   27    2   16    8   17    2
 12   13   13    1   32    6    8   12   18   10   24   11   21    7
 22    8   10   14   15   12   22   10   31    5   23    8    9    4
  8    0   18   10   11   16   10    7    9   14   14   13   28    4
 20    8   20    3   27    4   17   16   20    6   11    3   28    8
 19    8   12    7   19   -3    6    2    5    6   11   -5    7    5
 14    6   24   12   10  -10    6    0   10    7   11    7   20   -3
 13   -2   17   -1   30    3   11   13   30    1   32    4   30    2
 18    0   11    8   20    9    8   25   14   15   18   19   17   14
 10    2   21    6   22    5   22   12   16   13   19   -5   33   -1
 30   -4   26    6   34    0   10    8   14   11   28    6   12   12
 33    2   21    4   14    6   25    6   24    7   24    1   20    7
 25    7   25    9   32    2   33    3   13    6   18   -2   28    9
 22    9   31    0   16    6   35    3   21   12   32    3   22   12
 16    8   10    6    8   12    8    0    6    8    9   10    8    1
  7    7    8    4    7    5    5   12   26    1   29    6   31    3
 32   -7   28    8   10   13   30    7   18   16   27    4   25    7
 16   12   22    6   30    2   22    9   23   11   29    6   30    5
 20    6   22    7   19    8   19   13   18    6   10   16   25    7
 23    3   27    4   15    7   26    6   20   11   26    8   13    0
 23   11   15    4   20    0   26    9   21   12   25    6   19   13
 16   16    7    4   17    8   18    4   19    3   25    5   26    4
 12   11   16    8   30    6   16    5   28   10   25   12   26    8
 26    6   28    4   18    4   33    1   11   11   29    0   14   16
 25    1   22    8   31    6   27    4   24   -5   15    4   25    7
 23    7   19    1   26    3   29   -1   29    7   18    1   30    5
 21   -4   16   12   23   10   31    4   31    3   25    7   21    7
 19    8   26    7   18   10   22    4   16    9   19    8   27    2
 25   11   19    9   20    6   19    7   20   10   23    4   20    3
 18    6   22   10   18   12   21    6   14   14   31    5   31    8
 34    3   27    6   26    5   25    2   35   -4   32   -1   26    4
 29    8   33    2   32    2   29    6   21    5   32    2   38   -2
 34    1   24    5   29    1   10   10    4    3    7    3    6    4
 10   17   11   -1    6   10   16    0   10    5    8    4    8    1
 15   12   12   12   18   12    7    8   18    8    7    1    9    3
  3    1    8   12   23    8   15   10    8    3   13   15    9    2
  7    0    4    5    9    0   12   -6    9    4   11   14    8   -1
  7    8    8   -1    5    3    4    2    6   -1    6    2    6    4
 28    6    9    6   12    1   16    0    5    9   13    2    4    7
  6    0   10    1   24   11   11   -5   13    5   11    0   17   -3
 14   -1    6   11   13    7   16   13   12   -2   13    3   21    8
 13    0   16    9   20    9   14   12    9    2   27   10   18   -6
 15    8    9   10    5   13   10    7   12    4   12    2   13    0
 10   -6    6   -3   11    6    7   -1    4    1   10    0    8    4
  7    6   12    3   23    5   27    5   20    4   17    5   17    1
 16    5   18    2   19    7   18    0   16    9   25    4   11    6
 20    1   26   -6   12    0   23    0   19    8   20    2   14   11
 25    7   28    8   13    6   24    8   23    8   20   12   22    3
 18    5   29    4   23    5   18    4   16    6   11    8   13    1
 14    6   29    4    4    6    1    5    8    3    5    5    7    1
  8   -2   10   -2   12   -5    9   -6    7   -3    7    1    4    5
  4    6    4   10   10    2    6    9    7    3    7    1   14    4
 26    9   18    9   33    0   14    5   27    6   25   -6   26    7
 25    1   22    8   20    9   21    6   22   12   38    0   22   10
 21    3   26    6   33    5   27    6   25    2   25   11   19   14
 20   12   19    7    7    6   11    7    8    4   12    3   11    9
 22    7    6    6   17   10   12    5   11    4    8    5   18   13
 13    6   15  -10   17    6   21    8   15    5   22    9    8   -1
 26    4    7    3   10    0   14   11   13   13   15   10   13    6
 19   14   34    4   21    4   26   11   20    0   24    6    9   17
  7   16   14    4   12    8   14    8   23   -2   30   -1   29    3
  9    6    5    7   13   15   14   -7   18    3    9    1   12   -5
 10   -1   19  -11   30   -1   12   -9    9   -2   23    3   14   -6
 16   15   26    4    8   -1    6    8   11   -2   13    8   10    0
 12    1   29    0   22    4   16    3   13   -7   18    3   15    6
 16   -4   12    1   20    8    9    3   26   -9   10   -2    4    8
  7    1    7    0   13   -6   10   -3    8    3   11   -6    9   -4
 11    0   10   -3    5   -1    4    2   13   -1    5    2    7    3
  7    4   10   -6    4   10    9   -2    8    0    9    4   14   -2
 11    4    5    6   15   11   19    6    6    6    7    5   14    6
  8   13   11    1    4    9   11    3   12    6   14    3    9    3
  6    3   12    1   24   -2   23   -1   13   -1   14    6   22   -3
 12   -1   19   -1    7    7   16    6   15   -5   27   -2   16    2
 12   -1    8    1   15    5   10    9    2    6   17   -3   19    3
 16   -6   14    3   10    2   14    4    8    2   13   -5    9    2
 17   11   12   14   30    5    6    4   15   18    7    7    9    3
  8    2   11   -3    9    3    8   -1    9   -3   18    6    4    6
 14    2   20    2    7   -3    9    1    8   12   21    6   21   10
 11    0   16   12   17    2   22    5   16    2   14    2    9    6
 25   -1   30    1   24   -7   31    6   26   -6   16   13   27    3
 22  -13   22    3   16    3   17    5   29    1   35   -3   31    0
 21   -3   16    2   26   -7   26   -4   25    2   32    3   18   12
 22   -7   20    7   24    8   30    1   27    4   15    0   27   -1
 21    4   16    8   24    9   32    5   13    5   18   14   19    6
  8    3   10    9   20    5   12   16   14   12   24   13   15    9
 12    8   14    6   15   14   16    1    9    6   15   10   19    7
 21   11   11   -3    9    8   18   11   19    8   18    9   29    0
 20    6   26    9   19    8   27    6   12   20   19    7   11    6
 10    7    6   -2   12   -2   11    5   19   11   21    6   14    4
 12    6   15    4   21    0   11    9    7   26   18   -3   12    7
 16    5   18    7   26    6   13    4   19    2   27    8   23    0
 17    9   16    4   12    7   16    0   23    9    9    8   17    8
 21    1    6   15    8   14   19   11   32    5   25   12   29    6
 24   10   21    7   32    6   18    8   19    2   30    4   24   11
 22    9   15   15   20    8   22   12   17   -1   19   11   11   13
 16    9   15   18   23    9   24    5   31   -1   23    4   24    7
 19   13    9   20   12   11   24    8   17   -1   16    8   25    7
 11   19   11   12   20   15    8    5   15    7   23   10   20    5
 16   14   10   14   15    9   21    3   20    9   14    2   11    6
 20    8   13    7   25    5   17    9   13    4   12    9   29    3
  7    9    9    1   16   -1   13    2    8    2    7   11   17    7
 17    9   15   -2   16    3    7    8    8    8   10    3   11   -2
  9    8   14   13    9   10   17    7   12    8   15   15    8    2
  8    8   13    5   13    4   10   -2    8   -4    9    3    9    0
  9    1    5    6   18   12   12    9    9    4   11    4    5    8
  9   -4   17    9   23    5   17    4   10   12    7    6   11    5
  6   11   11    4   15   16   17   15   23    7   16    6   10    0
 12    3   11    6    9    6   18    9   23    9   13   -1    7    7
  4    8   13    5    6    3   10    4   13   -2    8    6   10    3
  6    7   10   -2    6   10    6    0   18    0   21  -11    8   -2
  4    8   11   -2   16   14   24    9   30    2   19   13   27    6
 25    4   30    8   20    8   28    8   23    4   24   -2   22    3
 28    4   35    1   30    5   27    3   26    3   35    3   21    4
 25    9   30    3   18   11   27    6   23   10   24    7   22    6
 24    9   17    4   15    5   12   10   13    6   27    4   10    3
 18    8   19    2   19    6   13   11   11    3   13   12   17   13
 14   15   15    7   22   -3   11    3   22   10   14    6   25    6
 23    3   20   12   33    4   25    4   16   12   25    2   24    5
 31    1   24    8   37   -1   35    0   33    2   28    6   32   -2
 31    1   15   -3   33    3   36    0   30    0   18    7   28    6
 32    3   28    7   32    3   30    1   34    4   33   -1   14   12
 32   -8   22   10   21    3    6    2   12   13   18    0   14    6
 20    4   14   -7   14    6   15    9   14    0   12   -1   13    9
 23    2   13   -2   13    1   25    1   17   -4   22    2   13    9
 12   11   18   -5   15   -1   26  -14   25   -5   25    2   22    0
 20    9   20   -3   18    7   16   -2   14   -1   21    4   21   -5
 12    1   29    3   22    0   35    0   23    2   27    3   14    3
 31    4   18    3   20    6   12    2   15    5    6   10   15    1
 21    2   15   -4   13   -2    7    7   13    3   10    7   11   10
 10   -2   12    2   12   -2   16    3    6    5    7    5   11   17
 13   15   16    7   18   11    8   13   10    8   11    4   14   -4
 14    8    6    7    7   11   11    1   21    7   14    0   10    3
 10    1    6    3    8    0   18   14   22    7   15    1   24   -8
  9   10   17   -2   17    7   22    6   12    9   17    4   22    8
 15   -5   17    3   20    6   22   -2   10    5    6    5   22    6
 20   -4   13    5   24    6   27    6   24    9   27    2   17    8
 14    6   10   11   27    7   13    0   33    6    5   14    9    3
 27    0    7   11   16   15   32    4   15   11   17   17   18   11
 16    7   15    8   24    8   16   15    9    3   21    8    8    7
 12    5   18    1   33   -3   12   11   12    3   20   12   10    8
 27    4   21   10   12   12   17   10   13    5   14    0    8    5
 18   11   17   11   14   15   22    6   13    4    9   18   14    2
 11   14   17    6   24    7   15   11   21    5   11   10   15    7
 16    0   19    3   16    3   13    9   15    7   24    6   16    9
 19   12   15    4   14    5   15    3   15    8   10   14   16    2
  7    9   13    5   16   14   20    4   16   15   15   16   21    7
 18    3   11    0   14   -5   20   -1   20   -8    9    1   15    3
 11    1   16   -4   21  -14   17   -1   13    5   19    5   16   -3
 19   -2   30    0   23   -8   15   -6   20   -2   21   -2   25  -10
 15    3    9    1   11    3   10    5   12    9   12    0   16    1
  9    1   14   -1    9   -3    3    1    7    9   17    7    8    6
 10   -2   10    7   14    1   13   -3   14   -6   11    8   10    3
 14    1   10    3   13   10   14   11   10    8   11    6   12   -1
 13    3    9   -3    7   -1    4   -1   12   -9    6   -1   13   -8
  6    4   13   -6    6    2    8    1    2    1    9   -5    7   -1
  5    4    4    5    8   -2   10   -4   13   -7    9   -5   10    4
  8    4    5    6   11   -5   10    3    7    1    9    0   12   -3
  6    4    8    1    8    3    7    4    8    2    8   -1    8    0
 10   -5    6    1    8    1    7    5    4    4    7   -3    4    0
  5    3    6   -1   11   -3   10   -2    2    4    5    0    8   -1
 13   -1    8   -7    5    0    8    0    4    4    6    2    4    6
  9   -1    8    3    7    0   10    0   12   -3   13    1    9   -1
 10    1    9    6    5    3   14   -1    9    1   18   -2   18   -1
 12   -3   12   -3    8    7   12    7   12   -1   12    6    7    7
 10    5    7    9    8    2    7    0    7    2   15   -3   11   -1
  9    2    9   -2    9   -2   11   -3   11    5    6   12    7   10
 13   -2    9    2   14   -9    8   -3   11    6    7    2   10    2
 10   -2    6   -1    5    2    9   -5   12    5    8    0    7    4
  6    1    7   -2   12    3   11    8    9    5    9    1    7   -1
  8   -1    4    1    6    2    5    4   10    1   12   -1   11   -1
 10    4   16    4   11   -4    5    0    6    5    6    1   11   -1
 11    7    7    2   12   -5    9   -2    9    2   10   -3   11   11
 13   -1   17    5   14   -4    4    5    8    0   11   -3    4    1
  4    4   26    5    8   -5    5    5    6    3    7    3    9    4
  5    0    8    3   11    5    7   -2   21    3   10    0   14    1
  7    2    5    3   11   -2    9    3   12    1   12   -4    5    3
 13   -4   14    3   19   -1    6   -1    5   -1   12    1    7    1
  6    2   31    4   33    4   20    5   30    2   32    1   29    2
 29    6   13    7   31   -2   22    5   31    6   37    1   32    1
 28    7   37    0   29    5   32    2   31    0   28   -2   29    3
 22   11   35   -2   29    4   33   -1   31    3   31   -6   28    4
 24    2   30    2   36   -2   32    0   31    6   16    5   13    5
 11   -2   14   -1   10    1   13    7    8    9   15    9    5   14
 18    3    8    6    6    0    7   15   17    1   20    6   10    6
  9    6   11    1   20   -3    7   -1   13    8   11    1   12    5
 16    3   12   12
run;

data sims;
   merge sims class;
run;

proc mixed data=sims;
   class class;
   model gain = pretot / solution;
   random intercept pretot / subject=class type=un;
run;



/*---------------*/
/*---Chapter 8---*/
/*---------------*/


/*---Data Set 8.2---*/
               
data dial;
   input sub qb tmp ufr index;
   tmp = tmp/100;
   ufr = ufr/100;
   datalines;
 1 200  24.0   64.5 1
 1 200  50.5 2011.5 2
 1 200  99.5 3846.0 3
 1 200 148.5 4498.5 4
 1 200 202.0 5176.5 5
 1 200 249.5 4657.5 6
 1 200 297.0 4081.5 7
 2 200  24.0  372.0 1
 2 200  54.0 1888.5 2 
 2 200  99.5 3469.5 3 
 2 200 147.5 4030.5 4 
 2 200 200.0 4447.5 5 
 2 200 250.0 4243.5 6 
 2 200 301.0 4465.5 7 
 3 200  24.5  298.5 1
 3 200  48.0 1770.0 2
 3 200 101.0 3529.5 3
 3 200 150.5 4195.5 4
 3 200 200.0 4761.0 5
 3 200 251.5 4473.0 6
 3 200 297.0 4603.5 7
 4 200  25.5  393.0 1
 4 200  49.5 1983.0 2
 4 200  99.5 4042.5 3
 4 200 148.0 5226.0 4
 4 200 199.5 4939.5 5
 4 200 249.0 4597.5 6
 4 200 303.0 4191.0 7
 5 200  25.5  321.0 1
 5 200  51.5 1770.0 2
 5 200 100.0 3249.0 3
 5 200 150.5 4233.0 4
 5 200 202.0 4573.5 5
 5 200 249.0 4785.0 6
 5 200 301.0 4804.5 7
 6 200  26.0  366.0 1
 6 200  50.0 1695.0 2
 6 200 102.0 3609.0 3
 6 200 149.0 4263.0 4
 6 200 199.0 4647.0 5
 6 200 248.0 4627.5 6
 6 200 299.5 4398.0 7
 7 200  30.5  982.5 1
 7 200  50.5 2163.0 2
 7 200  98.0 4227.0 3
 7 200 150.5 5028.0 4
 7 200 200.5 4551.0 5
 7 200 250.5 4425.0 6
 7 200 299.0 4230.0 7
 8 200  30.5  948.0 1
 8 200  50.5 2175.0 2
 8 200  99.5 3723.0 3
 8 200 150.0 4443.0 4
 8 200 199.0 4216.5 5
 8 200 248.0 4306.5 6
 8 200 300.0 3661.5 7
 9 200  25.0  156.0 1
 9 200  49.5 1665.0 2
 9 200 100.0 3453.0 3
 9 200 150.0 4381.5 4
 9 200 196.5 4849.5 5
 9 200 248.5 4752.0 6
 9 200 298.0 4164.0 7
10 200  23.5  123.0 1
10 200  50.5 1537.5 2
10 200 102.0 3283.5 3
10 200 147.5 3783.0 4
10 200 197.0 4059.0 5
10 200 248.0 3255.0 6
10 200 300.0 3430.5 7
11 300  25.5  388.5 1
11 300  50.0 1915.5 2
11 300  98.0 3765.0 3
11 300 149.0 4789.5 4
11 300 201.5 5449.5 5
11 300 251.0 5317.5 6
11 300 298.0 5935.5 7
12 300  28.0  571.5 1
12 300  50.5 2050.5 2
12 300 100.0 3940.5 3
12 300 149.0 5010.0 4
12 300 200.0 5515.5 5
12 300 250.5 6118.5 6
12 300 302.0 5071.5 7
13 300  35.5 1041.0 1
13 300  48.0 1932.0 2
13 300 102.5 4377.0 3
13 300 150.0 5122.5 4
13 300 199.0 5809.5 5
13 300 250.0 5409.0 6
13 300 300.5 6201.0 7
14 300  23.5  360.0 1
14 300  48.0 2049.0 2
14 300 101.0 4188.0 3
14 300 149.0 4999.5 4
14 300 199.0 5767.5 5
14 300 248.0 6247.5 6
14 300 300.5 6214.5 7
15 300  26.0  189.0 1
15 300  51.5 1851.0 2
15 300  97.0 3721.5 3
15 300 150.5 5235.0 4
15 300 199.0 6091.5 5
15 300 250.0 6298.5 6
15 300 299.5 6477.0 7
16 300  23.5  117.0 1
16 300  48.5 1768.5 2
16 300 102.5 3970.5 3
16 300 151.5 5268.0 4
16 300 199.0 6180.0 5
16 300 251.0 6148.5 6
16 300 302.0 6142.5 7
17 300  28.5  150.0 1
17 300  52.0 1540.5 2
17 300 100.5 3252.0 3
17 300 150.0 4243.5 4
17 300 198.5 4857.0 5
17 300 249.0 5368.5 6
17 300 299.5 5365.5 7
18 300  29.5  642.0 1
18 300  51.5 2025.0 2
18 300 101.0 4305.0 3
18 300 148.0 5811.0 4
18 300 200.0 6199.5 5
18 300 248.0 6091.5 6
18 300 300.5 6360.0 7
19 300  29.0  405.0 1
19 300  49.5 1659.0 2
19 300 101.5 4051.5 3
19 300 152.0 5284.5 4
19 300 202.0 6043.5 5
19 300 250.0 6483.0 6
19 300 297.5 6382.5 7
20 300  40.0 1093.5 1
20 300  47.0 1347.0 2
20 300 101.0 3535.5 3
20 300 151.5 4534.5 4
20 300 198.0 4944.0 5
20 300 251.0 5362.5 6
20 300 300.0 5643.0 7
21 200  25.0     .  1
21 200  50.0     .  2
21 200 100.0     .  3
21 200 150.0     .  4
21 200 200.0     .  5
21 200 250.0     .  6
21 200 300.0     .  7
22 300  25.0     .  1
22 300  50.0     .  2
22 300 100.0     .  3
22 300 150.0     .  4
22 300 200.0     .  5
22 300 250.0     .  6
22 300 300.0     .  7
;
               
/*---produces Output 8.1 on pages 270-272---*/

proc mixed data=dial;
   class qb sub;
   model ufr = tmp|tmp|tmp|tmp qb|tmp|tmp|tmp|tmp;
   repeated / type=un subject=sub r rcorr;
run;


/*---page 274---*/

proc mixed data=dial;
   class qb sub;
   model ufr = tmp|tmp|tmp|tmp qb|tmp|tmp|tmp|tmp;
   repeated / type=arh(1) subject=sub;
run;

proc mixed data=dial ic;
   class qb sub;
   model ufr = tmp|tmp|tmp|tmp qb|tmp|tmp|tmp|tmp;
   random int tmp / subject=sub type=un;
run;
    
proc mixed data=dial ic;
   class qb sub;
   model ufr = tmp|tmp|tmp|tmp qb|tmp|tmp|tmp|tmp;
   random int tmp tmp*tmp / subject=sub type=un;
run;


/*---page 275---*/

data ii;
   input parm row col1-col7;
   datalines;
1 1 1 1 1 1 1 1 1
1 2 1 1 1 1 1 1 1
1 3 1 1 1 1 1 1 1
1 4 1 1 1 1 1 1 1
1 5 1 1 1 1 1 1 1
1 6 1 1 1 1 1 1 1
1 7 1 1 1 1 1 1 1
2 2 0 1 1 1 1 1 1
2 3 0 1 1 1 1 1 1
2 4 0 1 1 1 1 1 1
2 5 0 1 1 1 1 1 1
2 6 0 1 1 1 1 1 1
2 7 0 1 1 1 1 1 1
3 3 0 0 1 1 1 1 1
3 4 0 0 1 1 1 1 1
3 5 0 0 1 1 1 1 1
3 6 0 0 1 1 1 1 1
3 7 0 0 1 1 1 1 1
4 4 0 0 0 1 1 1 1
4 5 0 0 0 1 1 1 1
4 6 0 0 0 1 1 1 1
4 7 0 0 0 1 1 1 1
5 5 0 0 0 0 1 1 1
5 6 0 0 0 0 1 1 1
5 7 0 0 0 0 1 1 1
6 6 0 0 0 0 0 1 1
6 7 0 0 0 0 0 1 1
7 7 0 0 0 0 0 0 1
run;
 
proc mixed data=dial ic;
   class qb sub;
   model ufr = tmp|tmp|tmp|tmp qb|tmp|tmp|tmp|tmp;
   repeated / type=lin(7) ldata=ii sub=sub r rcorr;
run;


/*---page 276---*/ 

data models;
   length type$ 6;
   input type$ aic_r bic_r m2rll parms;
   model = _n_;
   datalines;
UN      -321.0  -361.2  586.1  28
AR(1)   -330.7  -333.6  657.5   2
ARH(1)  -314.9  -326.4  613.8   8
CS      -349.2  -352.0  694.3   2
CSH     -339.1  -350.6  662.2   8
HF      -341.7  -353.2  667.5   8
FA(1)   -333.8  -353.9  639.6  14
FA1(1)  -343.8  -355.3  671.6   8
RC      -339.1  -344.8  670.1   4
RCQ     -329.9  -340.0  645.8   7 
I-I     -317.2  -327.3  620.4   7
run;


/*---page 279 of SAS System for Mixed Models ---*/ 

proc mixed data=dial;
   class qb sub;
   model ufr = tmp|tmp|tmp|tmp qb|tmp|tmp|tmp|tmp / s;
   random int tmp tmp*tmp / type=un sub=sub;
   make 'solutionf' out=sf;
run;

data cp;
   input est;
   datalines;
 2.24606822 
-3.73117853 
24.08025511 
 0.68705846 
-6.82952740
 2.17225966 
 1        
 0.0663507
run;


/*---the fifth run of this program produces Output 8.2 on pages 
     281-283---*/

proc mixed data=dial;
   class qb sub;
   model ufr = tmp|tmp|tmp|tmp qb|tmp|tmp|tmp|tmp / s;
   random int tmp tmp*tmp / type=un sub=sub;
   repeated / local=pom(sf);
   parms / pdata=cp;
   make 'solutionf' out=sf1;
   make 'covparms' out=cp1;
run;
    
proc compare brief data=sf compare=sf1;
   var est;
run;

data sf;
   set sf1;
run;
                  
data cp;
   set cp1;
run;


/*---Data Set 8.3---*/
               
data grip;
   input subject x y1 y2 y3 trt gender$;
   array yy{3} y1-y3;
   do time = 1 to 3;
      t = time;
      y = yy{time};
      output;
   end;
   drop y1-y3;
   datalines;
26 175 161 210 230 1 M
27 165 215 245 265 1 M
29 175 134 215 139 1 M
34 178 165 140 175 1 M
35 220 220 189 158 1 M
38  90 146 140 130 1 M
42 300 300 300 300 1 M
44 238 278 170 158 1 M
54 200 230 220 240 1 M
57 130 155 170 125 1 M
74 215 230 243 245 1 M
76 207 220  .   .  1 M
79 225 220 250 235 1 M
 1 120 130 150 120 2 M
25 300 300 300 300 2 M
28 179 232 285  .  2 M
31 209 260 200 125 2 M
36 200 200 200 232 2 M
39 300 300 300 300 2 M
41 200 245 290 280 2 M
43 172 170 170 146 2 M
45 158 140 152 150 2 M
47 150 220 168 139 2 M
53 135 155 215 170 2 M
56  75 170 220 240 2 M
58 150 200 185 163 2 M
61 155 101  93 120 2 M
73 190 240 210 173 2 M
75 265 275 255 270 2 M
 2  80  80  86  80 1 F
 4  64  80  80  70 1 F
 5  40  60  .   .  1 F
 8  40  50  30  40 1 F
 9  70  90 110  90 1 F
15  70  80  95 110 1 F
18  70  80  86  .  1 F
19  70  60  70  80 1 F
21  50  80  90  90 1 F
24  40  60  60  65 1 F
40 140 156 140 150 1 F
46 110  82  98 110 1 F
48 180 165 150 160 1 F
50 155 150 170 185 1 F
52  55 105  70  88 1 F
59  95  90  90 116 1 F
63  90 135  95  .  1 F
64 145 140 164  .  1 F
70  34  51  87  .  1 F
 3  60  80  60  60 2 F
 6  50  70  70  70 2 F
 7  80  75  90  90 2 F
10  80 100  80  90 2 F
13  80  60  65  70 2 F
17  58  50  80  80 2 F
20  60  60  80  60 2 F
22  80  90 120 130 2 F
23  60  90  94 100 2 F
30  75 131  95 105 2 F
37 150 108 160 160 2 F
49  55  60  65  55 2 F
51 130 130 160 125 2 F
55 115  95 105 110 2 F
62 135 120 144 135 2 F
65  60  85  85  .  2 F
67  40  45  76  75 2 F
71 104 107  .   .  2 F
72  60  60  55  58 2 F
;



/*---produces Output 8.3 on pages 286-288---*/

proc mixed data=grip;
   class subject trt gender time;
   model y = trt|gender|time x time*x gender*x trt*x;
   repeated / type=un subject=subject r rcorr;
run;


/*---produces Output 8.4 on pages 289-291---*/

proc mixed data=grip;
   class subject trt gender time;
   model y = trt|gender|time x time*x gender*x trt*x;
   repeated / type=un sub=subject group=gender r=1,2 rcorr=1,2;
run;


/*---page 292---*/

proc mixed data=grip;
   class subject trt gender time;
   model y = trt|gender|time x time*x gender*x trt*x / p;
   make 'predicted' out=p noprint;
   id time subject gender;
run;
              

/*---page 293---*/ 

proc mixed data=grip;
   class subject trt gender time;
   model y = trt|gender|time x time*x gender*x trt*x;
   random int t / type=un sub=subject group=gender;
run;
               
proc mixed data=grip;
   class subject trt gender time;
   model y = trt|gender|time x time*x gender*x trt*x;
   random int t / type=un sub=subject group=gender;
   repeated / sub=subject group=gender;
run;


/*---Data Set 8.4.1---*/

data preetch;
   input expt wafer mask viscos spin baketemp baketime aperture 
   expos develop etch y1-y5;
   y = y1; loc = 'top'; output;
   y = y2; loc = 'cen'; output;
   y = y3; loc = 'bot'; output;
   y = y4; loc = 'lef'; output;
   y = y5; loc = 'rig'; output;
   drop y1-y5;
   datalines;
 1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 2.43  2.52  2.63  2.52  2.5
 1 2 -1 -1 -1 -1 -1 -1 -1 -1 -1 2.36  2.5   2.62  2.43  2.49
 2 1 -1 -1  0 -1  0  0  0  0  0 2.76  2.66  2.74  2.6   2.53
 2 2 -1 -1  0 -1  0  0  0  0  0 2.66  2.73  2.95  2.57  2.64
 3 1 -1 -1  1 -1  1  1  1  1  1 2.82  2.71  2.78  2.55  2.36
 3 2 -1 -1  1 -1  1  1  1  1  1 2.76  2.67  2.9   2.62  2.43
 4 1 -1  1 -1 -1 -1  0  0  1  1 2.02  2.06  2.21  1.98  2.13
 4 2 -1  1 -1 -1 -1  0  0  1  1 1.85  1.66  2.07  1.81  1.83
 5 1 -1  1  0 -1  0  1  1 -1 -1 1.87  1.78  2.07  1.8   1.83
 6 1 -1  1  1 -1  1 -1 -1  0  0 2.51  2.56  2.55  2.45  2.53
 6 2 -1  1  1 -1  1 -1 -1  0  0 2.68  2.6   2.85  2.55  2.56
 7 1 -1 -1 -1  1  0 -1  1  0  1 1.99  1.99  2.11  1.99  2.0
 7 2 -1 -1 -1  1  0 -1  1  0  1 1.96  2.2   2.04  2.01  2.03
 8 1 -1 -1  0  1  1  0 -1  1 -1 3.15  3.44  3.67  3.09  3.06
 8 2 -1 -1  0  1  1  0 -1  1 -1 3.27  3.29  3.49  3.02  3.19
 9 1 -1 -1  1  1 -1  1  0 -1  0 3.0   2.91  3.07  2.66  2.74
 9 2 -1 -1  1  1 -1  1  0 -1  0 2.73  2.79  3.0   2.69  2.7
10 1  1 -1 -1 -1  1  1  0  0 -1 2.69  2.5   2.51  2.46  2.4
10 2  1 -1 -1 -1  1  1  0  0 -1 2.75  2.73  2.75  2.78  3.03
11 1  1 -1  0 -1 -1 -1  1  1  0 3.2   3.19  3.32  3.2   3.15
11 2  1 -1  0 -1 -1 -1  1  1  0 3.07  3.14  3.14  3.13  3.12
12 1  1 -1  1 -1  0  0 -1 -1  1 3.21  3.32  3.33  3.23  3.10
12 2  1 -1  1 -1  0  0 -1 -1  1 3.48  3.44  3.49  3.25  3.38
13 1  1  1 -1 -1  0  1 -1  1  0 2.6   2.56  2.62  2.55  2.56
13 2  1  1 -1 -1  0  1 -1  1  0 2.53  2.49  2.79  2.5   2.56
14 1  1  1  0 -1  1 -1  0 -1  1 2.18  2.2   2.45  2.22  2.32
14 2  1  1  0 -1  1 -1  0 -1  1 2.33  2.2   2.41  2.37  2.38
15 1  1  1  1 -1 -1  0  1  0 -1 2.45  2.50  2.51  2.43  2.43
16 1  1 -1 -1  1  1  0  1 -1  0 2.67  2.53  2.72  2.7   2.6
16 2  1 -1 -1  1  1  0  1 -1  0 2.76  2.67  2.73  2.69  2.6
17 1  1 -1  0  1 -1  1 -1  0  1 3.31  3.3   3.44  3.12  3.14
17 2  1 -1  0  1 -1  1 -1  0  1 3.12  2.97  3.18  3.03  2.95
18 1  1 -1  1  1  0 -1  0  1 -1 3.46  3.49  3.5   3.45  3.57
;
               
/*---produces Output 8.5 on pages 295-298---*/

proc mixed data=preetch;
   class expt wafer mask viscos spin baketemp 
         baketime aperture expos develop;
   model y = mask viscos spin baketemp 
         baketime aperture expos develop;
   repeated / local=exp(mask viscos spin baketemp 
            baketime aperture expos develop);
run;


/*---produces Output 8.6 on pages 299-301---*/

proc mixed data=preetch;
   class expt wafer mask viscos spin baketemp 
         baketime aperture expos develop;
   model y = mask viscos spin baketemp 
         baketime aperture expos develop / ddfm=bw;
   random int / sub=wafer(expt);
   repeated / local=exp(mask viscos spin baketemp 
            baketime aperture expos develop)
            sub=wafer(expt);
run;


/*---------------*/
/*---Chapter 9---*/
/*---------------*/


/*---Data Set 9.5---*/

data spatvar;
   input rep bloc row col yield;
   datalines;
1       4      1      1     10.5411
1       4      1      2      8.5806
1       2      1      3     11.2790
1       2      1      4     12.4344
1       4      2      1     10.3416
1       4      2      2     11.3103
1       2      2      3      9.0282
1       2      2      4      9.7985
1       3      3      1     10.4939
1       3      3      2     11.2576
1       1      3      3      7.3720
1       1      3      4      6.0833
1       3      4      1      9.8869
1       3      4      2      8.2849
1       1      4      3      7.2836
1       1      4      4      8.0018
2       7      5      1     10.3349
2       7      5      2      9.9135
2       6      5      3      8.1662
2       6      5      4     10.7679
2       7      6      1     12.1580
2       7      6      2     11.0230
2       6      6      3      9.2912
2       6      6      4      9.1392
2       5      7      1     13.1097
2       5      7      2     10.0121
2       8      7      3      8.2482
2       8      7      4      7.3975
2       5      8      1     11.0226
2       5      8      2     10.7690
2       8      8      3      6.2206
2       8      8      4      6.5696
3      12      1      5     11.1944
3      12      1      6      7.9737
3      11      1      7      5.8400
3      11      1      8      6.9580
3      12      2      5     10.2561
3      12      2      6      9.8180
3      11      2      7     10.3009
3      11      2      8      7.4719
3       9      3      5     10.1148
3       9      3      6      9.6252
3      10      3      7      8.7800
3      10      3      8     11.2786
3       9      4      5      7.9548
3       9      4      6      6.1100
3      10      4      7      8.6507
3      10      4      8      9.2237
4      16      5      5     10.3129
4      16      5      6      7.3161
4      13      5      7      8.6394
4      13      5      8      7.8669
4      16      6      5      9.0250
4      16      6      6      7.2483
4      13      6      7     10.0104
4      13      6      8     10.0473
4      14      7      5      7.0507
4      14      7      6     11.1225
4      15      7      7     12.0253
4      15      7      8     10.4298
4      14      8      5      7.3220
4      14      8      6     10.5104
4      15      8      7     12.6808
4      15      8      8     10.4482
;                                                 


/*---produces Output 9.1 on page 310---*/

proc mixed scoring=5;
   model yield= ;
   parms (0 to 10 by 2.5) (1 to 10 by 3);
   repeated / subject=intercept type=sp(sph)(row col);
run;


/*---produces Output 9.2 on pages 312-313---*/

proc mixed scoring=5;
   model yield= ;
   parms (0 to 10 by 2.5) (1 to 10 by 3);
   repeated / subject=intercept type=sp(exp)(row col);
run;


/*---produces Output 9.3 on pages 314-315---*/

proc mixed;
   class rep;
   model yield= ;
   random rep;
run;
    
proc mixed;
   class bloc;
   model yield= ;
   random bloc;
run;


/*---produces Outputs 9.4 and 9.5 on pages 316-317---*/

proc mixed scoring=50 convh=1e-06;
   model yield= ;
   parms (0 to 10 by 2.5) (1 to 10 by 3) (0.05 to 1.05 by 0.25);
   repeated / subject=intercept local type=sp(sph)(row col);
run;



/*---Data Set 9.6.1---*/

data a;
   input easting northing logt salt xxx $;
   if logt=1e31 or logt<-10 then delete;
   if salt=1e31 then delete;
   datalines;
16.442  18.128 -6.02895   28.6     H-1
15.670  18.095 -6.20046   26.9   H-2b1
16.748  17.339 -5.60886   -0.6   H-3b1
15.399  14.927 -5.99598    0     H-4b
19.891  21.245 -7.01145  1E31    H-5b
13.613  21.452 -4.44995   -0.6   H-6b
11.143  11.092 -2.81246  -37.1   H-7b
11.702       0 -5.05465  -19.9   H-8b
17.008   4.705 -3.90188      0   H-9b
25.994   8.917 -7.12337      0   H-10b
18.365  15.574 -4.50570  1E31    H-11b1
20.042  11.896 -6.71319  100.3   H-12
15.36  16.798 -6.48422   1E31    H-14
18.334  18.303 -6.88042  1E31    H-15
16.388  18.656 -6.11491   32.8   H-16
18.737  13.957 -6.63614   64.6   H-17
15.283   19.61 -5.77751   27.4   H-18
18.222  16.777 -4.92707  1E31   DOE-1
16.702  21.738 -4.01908  1E31   DOE-2
15.357  16.785   1E+31    24.3     P-1
18.335  18.292   1E+31    31.1     P-2
15.818  18.342   1E+31    29.9     P-3
17.954  16.763   1E+31    31.7     P-4
16.703  19.984   1E+31    29.6     P-5
13.628  17.528   1E+31    -0.5     P-6
15.327  14.922   1E+31    20.7     P-7
16.849  14.911   1E+31    33.2     P-8
18.375  15.569   1E+31    31.4     P-9
20.106  17.647   1E+31     114    P-10
20.035  19.901   1E+31    30.5    P-11
13.475  19.896   1E+31    -0.9    P-12
13.55   21.473   1E+31    -1.2    P-13
12.10   18.42  -3.55706   -2.4    P-14
13.643  15.191 -7.03535     25    P-15
15.714  13.765   1E+31    28.6    P-16
16.945   13.91 -5.96847   34.4    P-17
21.386  16.794 -10.1233  132.2    P-18
20.7    18.862   1E+31    69.36   P-19
21.551  20.212   1E+31    30.8    P-20
19.917  21.293   1E+31    30.2    P-21
16.81  22.919   1E+31       0  WIPP-11
16.729  19.968 -6.96847   29.9 WIPP-12
15.663  20.691 -4.12962      0 WIPP-13
16.754  19.623 -6.49134   30.3 WIPP-18
16.758  19.226 -6.19031      0 WIPP-19
16.762  18.763 -6.57053   29.9 WIPP-21
16.758  19.097 -6.40026   29.8 WIPP-22
 9.404  20.472 -3.54116  -10.7 WIPP-25
 7.033  17.606 -2.91359   -3.3 WIPP-26
 7.445  29.523 -3.36921    -28 WIPP-27
14.285  31.124 -4.6839   -17.7 WIPP-28
 0      15.138 -2.96847  -32.9 WIPP-29
16.74   26.145 -6.60227      0 WIPP-30
12.649  20.463   1E+31    1E31 WIPP-33
17.353  21.586   1E+31    1E31 WIPP-34
21.239  25.452   1E+31    -0.1  ERDA-6
16.715  18.402 -6.29637   26.7  ERDA-9
 9.704   6.959   1E+31   -15.2 ERDA-10
16.21   14.493 -6.52131  1E31    C-B1
17.972   3.898 -4.33500  1E31  ENGLE
 9.481   5.903 -3.25842  1E31  USGS-1
 8.86    6.331   1E+31   1E31  USGS-4
 8.898   6.332   1E+31   1E31  USGS-8
11.721  15.321 -5.68971  1E31   D-268
24.145  25.825 -6.55349   18.7   AEC-7
20.544  22.886   1E+31       0   AEC-8
14.714  17.053   1E+31    -0.3    B-25
16.736  18.524   1E+31   1E31 EX. SHAFT
10.48   26.499   1E+31   1E31 FFG-107
 2.258   8.668   1E+31   1E31 FFG-153
 4.878    9.65   1E+31   1E31 FFG-165
 7.234   5.137   1E+31   1E31 FFG-181
 6.9  -0.971   1E+31   1E31 FFG-188*
32.296  33.411   1E+31   1E31 FFG-225*
23.873   33.47   1E+31   1E31 FFG-236
30.198  25.776   1E+31   1E31 FFG-244*
-4.458   28.01   1E+31   1E31 FFG-426*
-1.181  21.666   1E+31   1E31  1 DANF
 4.331   25.36   1E+31   1E31  1 DUNC
;


/*---produces Output 9.6 on pages 319-320---*/

proc mixed scoring=50;
   model logt=salt/solution;
   parms (1 to 7 by 3) (2 to 17 by 5) (0.1 to 0.5 by 0.2);
   repeated / subject=intercept local 
   type=sp(exp)(easting northing);
run;


/*---page 321---*/ 

proc mixed;
   model logt=salt/solution;
run;


/*---Data Set 9.6.2---*/
               
data wheat;
   input name$1-13 entry plot rawyld rep nloc y lat lng;
   datalines;
LANCER        1  1101   585   1  4  29.25  4.3 19.2
BRULE         2  1102   631   1  4  31.55  4.3 20.4
REDLAND       3  1103   701   1  4  35.05  4.3 21.6
CODY          4  1104   602   1  4  30.10  4.3 22.8
ARAPAHOE      5  1105   661   1  4  33.05  4.3 24.0
NE83404       6  1106   605   1  4  30.25  4.3 25.2
NE83406       7  1107   704   1  4  35.20  4.3 26.4
NE83407       8  1108   388   1  4  19.40  8.6  1.2
CENTURA       9  1109   487   1  4  24.35  8.6  2.4
SCOUT 66     10  1110   511   1  4  25.55  8.6  3.6
COLT         11  1111   502   1  4  25.10  8.6  4.8
NE83498      12  1112   492   1  4  24.60  8.6  6.0
NE84557      13  1113   509   1  4  25.45  8.6  7.2
NE83432      14  1114   268   1  4  13.40  8.6  8.4
NE85556      15  1115   633   1  4  31.65  8.6  9.6
NE85623      16  1116   513   1  4  25.65  8.6 10.8
CENTURK 78   17  1117   632   1  4  31.60  8.6 12.0
NORKAN       18  1118   446   1  4  22.30  8.6 13.2
KS831374     19  1119   684   1  4  34.20  8.6 14.4
TAM 200      20  1120   422   1  4  21.10  8.6 15.6
NE86482      21  1121   560   1  4  28.00  8.6 16.8
HOMESTEAD    22  1122   566   1  4  28.30  8.6 18.0
LANCOTA      23  1123   514   1  4  25.70  8.6 19.2
NE86501      24  1124   635   1  4  31.75  8.6 20.4
NE86503      25  1125   840   1  4  42.00  8.6 21.6
NE86507      26  1126   618   1  4  30.90  8.6 22.8
NE86509      27  1127   658   1  4  32.90  8.6 24.0
TAM 107      28  1128   481   1  4  24.05  8.6 25.2
CHEYENNE     29  1129   564   1  4  28.20  8.6 26.4
BUCKSKIN     30  1130   597   1  4  29.85 12.9  1.2
NE86527      31  1131   580   1  4  29.00 12.9  2.4
NE86582      32  1132   418   1  4  20.90 12.9  3.6
NE86606      33  1133   526   1  4  26.30 12.9  4.8
NE86607      34  1134   517   1  4  25.85 12.9  6.0
ROUGHRIDER   35  1135   479   1  4  23.95 12.9  7.2
VONA         36  1136   506   1  4  25.30 12.9  8.4
SIOUXLAND    37  1137   542   1  4  27.10 12.9  9.6
GAGE         38  1138   513   1  4  25.65 12.9 10.8
NE83T12      39  1139   504   1  4  25.20 12.9 12.0
NE86T666     40  1140   368   1  4  18.40 12.9 13.2
NE87403      41  1141   437   1  4  21.85 12.9 14.4
NE87408      42  1142   540   1  4  27.00 12.9 15.6
NE87409      43  1143   631   1  4  31.55 12.9 16.8
NE87446      44  1144   610   1  4  30.50 12.9 18.0
NE87451      45  1145   639   1  4  31.95 12.9 19.2
NE87457      46  1146   611   1  4  30.55 12.9 20.4
NE87463      47  1147   545   1  4  27.25 12.9 21.6
NE87499      48  1148   598   1  4  29.90 12.9 22.8
NE87512      49  1149   656   1  4  32.80 12.9 24.0
NE87513      50  1150   557   1  4  27.85 12.9 25.2
NE87522      51  1151   486   1  4  24.30 12.9 26.4
NE87612      52  1152   563   1  4  28.15 17.2  1.2
NE87613      53  1153   539   1  4  26.95 17.2  2.4
NE87615      54  1154   502   1  4  25.10 17.2  3.6
NE87619      55  1155   605   1  4  30.25 17.2  4.8
NE87627      56  1156   403   1  4  20.15 17.2  6.0
CENTURA       9  2101   556   2  4  27.80 17.2  8.4
NE85623      16  2102   569   2  4  28.45 17.2  9.6
CODY          4  2103   455   2  4  22.75 17.2 10.8
NE86582      32  2104   534   2  4  26.70 17.2 12.0
NE87408      42  2105   513   2  4  25.65 17.2 13.2
NE87451      45  2106   549   2  4  27.45 17.2 14.4
NE83432      14  2107   620   2  4  31.00 17.2 15.6
CENTURK 78   17  2108   498   2  4  24.90 17.2 16.8
NE83T12      39  2109   513   2  4  25.65 17.2 18.0
NE87409      43  2110   648   2  4  32.40 17.2 19.2
NE87513      50  2111   624   2  4  31.20 17.2 20.4
NE87627      56  2112   552   2  4  27.60 17.2 21.6
ARAPAHOE      5  2113   693   2  4  34.65 17.2 22.8
LANCER        1  2114   570   2  4  28.50 17.2 24.0
TAM 107      28  2115   589   2  4  29.45 17.2 25.2
REDLAND       3  2116   611   2  4  30.55 17.2 26.4
VONA         36  2117   536   2  4  26.80 21.5  1.2
NE87463      47  2118   477   2  4  23.85 21.5  2.4
NE86507      26  2119   548   2  4  27.40 21.5  3.6
BUCKSKIN     30  2120   602   2  4  30.10 21.5  4.8
ROUGHRIDER   35  2121   495   2  4  24.75 21.5  6.0
NE86527      31  2122   507   2  4  25.35 21.5  7.2
SCOUT 66     10  2123   520   2  4  26.00 21.5  8.4
NE86509      27  2124   500   2  4  25.00 21.5  9.6
NE86606      33  2125   587   2  4  29.35 21.5 10.8
NE84557      13  2126   572   2  4  28.60 21.5 12.0
KS831374     19  2127   534   2  4  26.70 21.5 13.2
GAGE         38  2128   505   2  4  25.25 21.5 14.4
NE87619      55  2129   675   2  4  33.75 21.5 15.6
NE87499      48  2130   446   2  4  22.30 21.5 16.8
CHEYENNE     29  2131   561   2  4  28.05 21.5 18.0
NE86607      34  2132   691   2  4  34.55 21.5 19.2
NE83498      12  2133   748   2  4  37.40 21.5 20.4
NE83404       6  2134   580   2  4  29.00 21.5 21.6
NE87446      44  2135   624   2  4  31.20 21.5 22.8
SIOUXLAND    37  2136   742   2  4  37.10 21.5 24.0
HOMESTEAD    22  2137   590   2  4  29.50 21.5 25.2
NE86501      24  2138   627   2  4  31.35 21.5 26.4
NE87512      49  2139   404   2  4  20.20 25.8  1.2
NE83407       8  2140   528   2  4  26.40 25.8  2.4
NE87403      41  2141   513   2  4  25.65 25.8  3.6
NE87457      46  2142   638   2  4  31.90 25.8  4.8
NE83406       7  2143   621   2  4  31.05 25.8  6.0
COLT         11  2144   615   2  4  30.75 25.8  7.2
NE87522      51  2145   543   2  4  27.15 25.8  8.4
NORKAN       18  2146   606   2  4  30.30 25.8  9.6
NE87615      54  2147   634   2  4  31.70 25.8 10.8
NE85556      15  2148   610   2  4  30.50 25.8 12.0
TAM 200      20  2149   487   2  4  24.35 25.8 13.2
LANCOTA      23  2150   522   2  4  26.10 25.8 14.4
NE86503      25  2151   599   2  4  29.95 25.8 15.6
NE86482      21  2152   656   2  4  32.80 25.8 16.8
BRULE         2  2153   563   2  4  28.15 25.8 18.0
NE87612      52  2154   654   2  4  32.70 25.8 19.2
NE87613      53  2155   738   2  4  36.90 25.8 20.4
NE86T666     40  2156   368   2  4  18.40 25.8 21.6
NE86607      34  3101   623   3  4  31.15 25.8 24.0
LANCOTA      23  3102   539   3  4  26.95 25.8 25.2
NE87513      50  3103   616   3  4  30.80 25.8 26.4
NE87408      42  3104   438   3  4  21.90 30.1  1.2
NE83407       8  3105   592   3  4  29.60 30.1  2.4
NORKAN       18  3106   485   3  4  24.25 30.1  3.6
REDLAND       3  3107   542   3  4  27.10 30.1  4.8
KS831374     19  3108   421   3  4  21.05 30.1  6.0
COLT         11  3109   479   3  4  23.95 30.1  7.2
NE86527      31  3110   546   3  4  27.30 30.1  8.4
VONA         36  3111   600   3  4  30.00 30.1  9.6
TAM 107      28  3112   690   3  4  34.50 30.1 10.8
CENTURK 78   17  3113   662   3  4  33.10 30.1 12.0
NE87627      56  3114   564   3  4  28.20 30.1 13.2
NE86T666     40  3115   516   3  4  25.80 30.1 14.4
NE87615      54  3116   679   3  4  33.95 30.1 15.6
NE86501      24  3117   607   3  4  30.35 30.1 16.8
NE87522      51  3118   378   3  4  18.90 30.1 18.0
CHEYENNE     29  3119   678   3  4  33.90 30.1 19.2
SIOUXLAND    37  3120   675   3  4  33.75 30.1 20.4
NE87451      45  3121   679   3  4  33.95 30.1 21.6
GAGE         38  3122   500   3  4  25.00 30.1 22.8
LANCER        1  3123   562   3  4  28.10 30.1 24.0
NE87446      44  3124   500   3  4  25.00 30.1 25.2
NE86482      21  3125   606   3  4  30.30 30.1 26.4
CODY          4  3126   337   3  4  16.85 34.4  1.2
NE87612      52  3127   342   3  4  17.10 34.4  2.4
NE87457      46  3128   191   3  4   9.55 34.4  3.6
NE84557      13  3129    30   3  4   1.50 34.4  4.8
NE83T12      39  3130   255   3  4  12.75 34.4  6.0
NE86507      26  3131   443   3  4  22.15 34.4  7.2
TAM 200      20  3132   384   3  4  19.20 34.4  8.4
NE87613      53  3133   471   3  4  23.55 34.4  9.6
ARAPAHOE      5  3134   501   3  4  25.05 34.4 10.8
SCOUT 66     10  3135   665   3  4  33.25 34.4 12.0
NE87403      41  3136   480   3  4  24.00 34.4 13.2
NE85623      16  3137   635   3  4  31.75 34.4 14.4
NE86509      27  3138   481   3  4  24.05 34.4 15.6
NE85556      15  3139   769   3  4  38.45 34.4 16.8
HOMESTEAD    22  3140   517   3  4  25.85 34.4 18.0
NE83404       6  3141   656   3  4  32.80 34.4 19.2
NE86503      25  3142   702   3  4  35.10 34.4 20.4
NE86582      32  3143   621   3  4  31.05 34.4 21.6
NE87619      55  3144   663   3  4  33.15 34.4 22.8
NE87463      47  3145   580   3  4  29.00 34.4 24.0
NE86606      33  3146   643   3  4  32.15 34.4 25.2
BRULE         2  3147   818   3  4  40.90 34.4 26.4
BUCKSKIN     30  3148   360   3  4  18.00 38.7  1.2
NE83406       7  3149    43   3  4   2.15 38.7  2.4
NE87409      43  3150    75   3  4   3.75 38.7  3.6
NE87499      48  3151    59   3  4   2.95 38.7  4.8
CENTURA       9  3152   174   3  4   8.70 38.7  6.0
NE83432      14  3153   221   3  4  11.05 38.7  7.2
NE87512      49  3154   247   3  4  12.35 38.7  8.4
ROUGHRIDER   35  3155   449   3  4  22.45 38.7  9.6
NE83498      12  3156   538   3  4  26.90 38.7 10.8
NE86T666     40  4101   471   4  4  23.55 38.7 13.2
NE87403      41  4102   580   4  4  29.00 38.7 14.4
NE87512      49  4103   553   4  4  27.65 38.7 15.6
NE87446      44  4104   480   4  4  24.00 38.7 16.8
CENTURA       9  4105   515   4  4  25.75 38.7 18.0
NE86503      25  4106   471   4  4  23.55 38.7 19.2
NE87408      42  4107   613   4  4  30.65 38.7 20.4
COLT         11  4108   564   4  4  28.20 38.7 21.6
LANCER        1  4109   568   4  4  28.40 38.7 22.8
NE83406       7  4110   574   4  4  28.70 38.7 24.0
NE86607      34  4111   515   4  4  25.75 38.7 25.2
SIOUXLAND    37  4112   450   4  4  22.50 38.7 26.4
NE87612      52  4113   185   4  4   9.25 43.0  1.2
BUCKSKIN     30  4114   486   4  4  24.30 43.0  2.4
NE85556      15  4115    99   4  4   4.95 43.0  3.6
BRULE         2  4116    74   4  4   3.70 43.0  4.8
NE86507      26  4117   294   4  4  14.70 43.0  6.0
ROUGHRIDER   35  4118   272   4  4  13.60 43.0  7.2
VONA         36  4119   246   4  4  12.30 43.0  8.4
NE83404       6  4120   350   4  4  17.50 43.0  9.6
CODY          4  4121   303   4  4  15.15 43.0 10.8
NE87463      47  4122   471   4  4  23.55 43.0 12.0
NE86582      32  4123   390   4  4  19.50 43.0 13.2
NE87499      48  4124   530   4  4  26.50 43.0 14.4
NORKAN       18  4125   416   4  4  20.80 43.0 15.6
SCOUT 66     10  4126   506   4  4  25.30 43.0 16.8
NE87513      50  4127   348   4  4  17.40 43.0 18.0
NE83T12      39  4128   453   4  4  22.65 43.0 19.2
CENTURK 78   17  4129   632   4  4  31.60 43.0 20.4
NE87627      56  4130   339   4  4  16.95 43.0 21.6
NE86606      33  4131   625   4  4  31.25 43.0 22.8
NE87457      46  4132   473   4  4  23.65 43.0 24.0
NE86509      27  4133   509   4  4  25.45 43.0 25.2
LANCOTA      23  4134   549   4  4  27.45 43.0 26.4
KS831374     19  4135   291   4  4  14.55 47.3  1.2
NE86482      21  4136   121   4  4   6.05 47.3  2.4
NE85623      16  4137    21   4  4   1.05 47.3  3.6
NE86527      31  4138   128   4  4   6.40 47.3  4.8
NE87451      45  4139   102   4  4   5.10 47.3  6.0
NE87409      43  4140   356   4  4  17.80 47.3  7.2
GAGE         38  4141   443   4  4  22.15 47.3  8.4
NE83407       8  4142   307   4  4  15.35 47.3  9.6
NE87615      54  4143   240   4  4  12.00 47.3 10.8
ARAPAHOE      5  4144   500   4  4  25.00 47.3 12.0
CHEYENNE     29  4145   442   4  4  22.10 47.3 13.2
REDLAND       3  4146   586   4  4  29.30 47.3 14.4
NE83432      14  4147   469   4  4  23.45 47.3 15.6
NE87619      55  4148   558   4  4  27.90 47.3 16.8
NE83498      12  4149   632   4  4  31.60 47.3 18.0
NE87613      53  4150   604   4  4  30.20 47.3 19.2
NE86501      24  4151   606   4  4  30.30 47.3 20.4
TAM 200      20  4152   406   4  4  20.30 47.3 21.6
NE87522      51  4153   593   4  4  29.65 47.3 22.8
NE84557      13  4154   531   4  4  26.55 47.3 24.0
TAM 107      28  4155   512   4  4  25.60 47.3 25.2
HOMESTEAD    22  4156   538   4  4  26.90 47.3 26.4
;

/*---produces Outputs 9.7(a) and 9.7(b) on pages 323-324---*/

/*---NOTE: Remove the final (1) from the PARMS statement if
     running Release 6.12 or later.---*/

proc mixed data=wheat noprofile;
   class name;
   model y=name;
   parms (61.6) (18.1) (1) / noiter;
   repeated / subject=intercept type=sp(sph)(lat lng);
   lsmeans name;
   estimate 'arap v brul' name 1 -1 0;
   estimate 'arap v buck' name 1 0 -1 0;
   estimate 'arap v ks83' name 1 0 0 0 0 0 0 0 0 0 -1 0;
   estimate 'brul v ks83' name 0 1 0 0 0 0 0 0 0 0 -1 0; 
   make 'lsmeans' out=sph;
run;

/*---produces Output 9.8 on pages 325-326---*/
proc mixed data=wheat;
   class rep name;
   model y=name;
   random rep;
   lsmeans name;
   estimate 'arap v brul' name 1 -1 0;
   estimate 'arap v buck' name 1 0 -1 0;
   estimate 'arap v ks83' name 1 0 0 0 0 0 0 0 0 0 -1 0;
   estimate 'brul v ks83' name 0 1 0 0 0 0 0 0 0 0 -1 0;
   make 'lsmeans' out=rcb;
run;

/*---If running Release 6.12 skip to the code below---*/
data ram;
   set rcb;
   rcb=lsmean;
   drop lsmean se ddf t p_t;
run;

proc rank data=ram descending out=fx;
   var rcb;
   ranks rcb_rank;
run;

proc sort data=fx;
   by level;
run;

data titleist;
   set sph;
   sph = lsmean;
   drop lsmean se ddf t p_t;
run;

proc rank data=titleist descending out=dci;
   var sph;
   ranks sph_rank;
run;

proc sort data=dci;
   by level;
run;

data founders;
   merge fx dci;
   by level;
run;

proc sort data=founders;
   by rcb_rank;
run;

proc print;
run;


/*---Use the following code for Release 6.12---*/
data ram;
   set rcb;
   rcb = _lsmean_;
   drop _lsmean_ _se_ _df_ _t_ _pt_;
run;

proc rank data=ram descending out=fx;
   var rcb;
   ranks rcb_rank;
run;

proc sort data=fx;
   by name;
run;

data titleist;
   set sph;
   sph = _lsmean_;
   drop _lsmean_ _se_ _df_ _t_ _pt_;
run;

proc rank data=titleist descending out=dci;
   var sph;
   ranks sph_rank;
run;

proc sort data=dci;
   by name;
run;

data founders;
   merge fx dci;
   by name;
run;

proc sort data=founders;
   by rcb_rank;
run;

proc print;
run;


/*---produces Outputs 9.9(a) and 9.9(b) on pages 327-329---*/

proc mixed data=wheat;
   class name;
   model y=name;
   parms (0 to 20 by 5) (25 to 100 by 75);
   repeated / subject=intercept type=sp(sph)(lat lng);
   lsmeans name;
run;


/*----------------*/
/*---Chapter 10---*/
/*----------------*/


/*---Data Set 10.2.1---*/

data design;
   input batch a b c d y;
   aa=a;
   datalines;
 1     1     1     1     1    505
 1     1    -1    -1    -1    493
 1     1    -1     1    -1    491
 2     1     1    -1     0    498
 2     1     1    -1    -1    504
 2     1    -1     1     0    500
 3    -1     0    -1    -1    494
 3    -1     0     1     0    498
 3    -1    -1     0     1    498
 4     0    -1    -1     0    496
 4     0     0     1     1    503
 4     0    -1     0    -1    496
 5    -1    -1     1     1    503
 5    -1     1     1    -1    495
 5    -1    -1     1    -1    494
 6     0     0     0     0    486
 6     0     1     1    -1    501
 6     0     1    -1     1    490
 7    -1     1     0     0    494
 7    -1     1     1     1    497
 7    -1    -1     1    -1    492
 8     1    -1     1     1    503
 8     1     0     0    -1    499
 8     1     0    -1     1    493
 9     1     1     1    -1    505
 9     1     1     0     1    500
 9     1    -1    -1     1    490
10    -1    -1    -1     1    494
10    -1     1    -1    -1    497
10    -1    -1    -1    -1    495
;                                      


/*---produces Output 10.1 on pages 334-335---*/

proc mixed; 
   class batch aa;
   model y=a|b|c|d@2 a*a b*b c*c d*d / solution;
   random batch(aa);
run;


/*---produces Output 10.2 on pages 335-336---*/

proc mixed;
   class batch aa;
   model y=a|b|c|d@2 a*a b*b c*c d*d / solution ddfm=satterth;
   random batch(aa);
run;


/*---produces Output 10.3 on pages 337-338---*/

proc glm;
   class batch aa;
   model y= batch(aa) a|b|c|d@2 a*a b*b c*c d*d / solution;
   random batch(aa) / test;
run;


/*---Data Set 10.3.1---*/

data maize;
   input xobs bloc trt level y;
   datalines; 
 1      1      1       1      43
 2      1      2       1      45
 3      1      1       2      41
 4      1      2       2      45
 5      1      1       3      46
 6      1      2       3      46
 7      1      1       4      46
 8      1      2       4      46
 9      1      1       5      45
10      1      2       5      45
11      1      1       6      50
12      1      2       6      51
13      1      1       7      49
14      1      2       7      47
15      1      1       8      46
16      1      2       8      49
17      2      1       1      39
18      2      2       1      44
19      2      3       1      39
20      2      1       2      43
21      2      2       2      47
22      2      3       2      42
23      2      1       3      47
24      2      2       3      49
25      2      3       3      45
26      2      1       4      40
27      2      2       4      42
28      2      3       4      40
29      2      1       5      38
30      2      2       5      39
31      2      3       5      37
32      2      1       6      43
33      2      2       6      45
34      2      3       6      42
35      2      1       7      36
36      2      2       7      36
37      2      3       7      36
38      2      1       8      39
39      2      2       8      40
40      2      3       8      39
41      3      2       1      34
42      3      3       1      31
43      3      2       2      38
44      3      3       2      34
45      3      2       3      37
46      3      3       3      36
47      3      2       4      39
48      3      3       4      37
49      3      2       5      43
50      3      3       5      42
51      3      2       6      43
52      3      3       6      41
53      3      2       7      40
54      3      3       7      39
55      3      2       8      39
56      3      3       8      37
57      4      1       1      44
58      4      3       1      39
59      4      1       2      45
60      4      3       2      41
61      4      1       3      47
62      4      3       3      47
63      4      1       4      46
64      4      3       4      43
65      4      1       5      45
66      4      3       5      40
67      4      1       6      43
68      4      3       6      41
69      4      1       7      41
70      4      3       7      40
71      4      1       8      40
72      4      3       8      38
;                               


/*---produces Output 10.4 on pages 341-343---*/

proc mixed data=maize;
   class bloc trt level;
   model y=level trt trt*level;
   random intercept /subject=bloc;
   random  level / subject=bloc type=ar(1);
   lsmeans trt/diff;
   lsmeans level trt*level;
   estimate 'lev 1 vs lev 2' level 1 -1 0;
   estimate 'lev 1 vs lev 8' level 1 0  0  0  0  0  0  -1;
   estimate 'trt 1 vs trt 2' trt 1 -1 0;
   estimate 'trt 1 v 2 given lev 1' trt 1 -1 0 
             trt*level 1 0 0 0 0 0 0 0 -1 0;
   estimate 'lev 1 v 2 given trt 1' level 1 -1 0 trt*level 1 -1 0;
   estimate 'lev 1 v 8 given trt 1' level 1 0 0 0 0 0 0 -1  
             trt*level 1 0 0 0 0 0 0 -1 0;
   contrast 'linear' level -7 -5 -3 -1 1 3 5 7;
   contrast 'quadratic' level 7 1 -3 -5 -5 -3 1 7;
   contrast 'other' level -7 5 7 3 -3 -7 -5 7,
                    level 7 -13 -3 9 9 -3 -13 7,
                    level -7 23 -17 -15 15 17 -23 7,
                    level 1 -5 9 -5 -5 9 -5 1,
                    level -1 7 -21 35 -35 21 -7 1;
run;


/*---produces Output 10.5 on pages 344-346---*/

proc mixed;
   class bloc trt level;
   model y=level trt trt*level;
   random bloc bloc*level;
run;


/*---Data Set 10.4.1---*/

data complex;
   input row col n g y;
   datalines;
1      1     1    1    20.1
1      1     1    2    20.4
2      1     2    1    16.2
2      1     2    2    14.0
3      1     3    1    16.2
3      1     3    2    12.6
1      2     2    1    18.1
1      2     2    2    16.7
2      2     1    1    10.3
2      2     1    2     8.1
3      2     4    1    15.1
3      2     4    2    10.5
1      3     5    1    23.1
1      3     5    2    18.1
2      3     3    1    17.8
2      3     3    2    16.1
3      3     1    1     9.8
3      3     1    2     9.0
1      4     4    1    22.0
1      4     4    2    18.0
2      4     5    1    18.1
2      4     5    2    12.9
3      4     2    1    14.0
3      4     2    2    12.1
1      5     3    1    22.7
1      5     3    2    19.5
2      5     4    1    18.9
2      5     4    2    14.3
3      5     5    1    17.0
3      5     5    2    10.9
;


/*---produces Outputs 10.6-10.9 on page 349-354---*/

proc mixed data=complex;
   class row col n g;
   model y = n g n*g / ddfm=satterth;
   random row col row*col*n;
   lsmeans n g n*g;
   contrast 'n lin' n -2 -1 0 1 2;
   contrast 'n quad' n  2 -1 -2 -1 2;
   contrast 'n cubic' n -1 2 0 -2 1;
   contrast 'n quartic' n 1 -4 6 -4 1;
   contrast 'g x n lin' n*g -2 2 -1 1 0 0 1 -1 2 -2;
   contrast 'g x n quad' n*g  2 -2 -1 1 -2 2 -1 1 2 -2;
   contrast 'g x n cubic' n*g -1 1 2 -2 0 0 -2 2 1 -1;
   contrast 'g x n quartic' n*g 1 -1 -4 4 6 -6 -4 4 1 -1;
   estimate 'n main eff mu1.-mu2.' n 1 -1 0 0 0;
   estimate 'g main eff mu.1-mu.2' g 1 -1;
   estimate 'mu11-mu12 same n' g 1 -1 n*g 1 -1 0 0 0 0 0 0 0 0;
   estimate 'mu11-mu21 same g' n 1 -1 0 0 0 n*g 1 0 -1 0 0 0 0 0 0 0;
   estimate 'mu11-mu22 diff n,g' n 1 -1 0 0 0 g 1 -1 n*g 1 0 0 -1 0 0 0 0 0 0;
run;


/*---produces Output 10.10 on pages 354-355---*/

proc mixed data=complex;
   class row col n g;
   model y = g n(g)/ ddfm=satterth;;
   random row col row*col*n;
   lsmeans n(g);
   contrast 'n lin for g1' n(g) -2 -1 0 1 2 0;
   contrast 'n quad for g1' n(g)  2 -1 -2 -1 2 0;
   contrast 'n cubic for g1' n(g) -1 2 0 -2 1 0;
   contrast 'n quartic for g1' n(g) 1 -4 6 -4 1 0;
   contrast 'n lin for g2' n(g) 0 0 0 0 0 -2 -1 0 1 2;
   contrast 'n quad for g2' n(g)  0 0 0 0 0 2 -1 -2 -1 2;
   contrast 'n cubic for g2' n(g) 0 0 0 0 0 -1 2 0 -2 1;
   contrast 'n quartic for g2' n(g) 0 0 0 0 0 1 -4 6 -4 1;
run;


/*---produces Output 10.11 on pages 355-356---*/

proc mixed data=complex;
   class row col n g;
   model y = g n(g) / solution ddfm=satterth;
   random row col row*col*n;
run;


/*---produces Outputs 10.12 and 10.13 on pages 357-358---*/

proc glm data=complex;
   class row col n g;
   model y = row col n row*col*n g n*g;
   random row col row*col*n / test;
   lsmeans n g n*g;
run;


/*---Data Set 10.5.1---*/

data range;
   input loc ec ir v y;
   datalines;
1      1     1    1    30.0
1      1     1    2    40.9
1      1     2    1    38.9
1      1     2    2    38.2
1      2     1    1    41.8
1      2     1    2    52.2
1      2     2    1    54.8
1      2     2    2    58.2
2      1     1    1    20.5
2      1     1    2    26.9
2      1     2    1    21.4
2      1     2    2    25.1
2      2     1    1    26.4
2      2     1    2    36.7
2      2     2    1    28.9
2      2     2    2    35.9
3      1     1    1    21.0
3      1     1    2    25.4
3      1     2    1    24.0
3      1     2    2    23.3
3      2     1    1    34.4
3      2     1    2    41.0
3      2     2    1    33.2
3      2     2    2    34.9
;


/*---produces Outputs 10.14-10.7 on pages 363-367---*/

proc mixed data=range;
   class loc ec ir v;
   model y=ec ir  ec*ir v v*ec v*ir v*ec*ir/ddfm=satterth;
   random loc loc*ec loc*ir loc*ec*ir;
   lsmeans ec ir ec*ir v v*ec v*ir v*ec*ir;
   lsmeans ec / diff;
   lsmeans v*ir / slice=v diff;
   lsmeans v*ir / slice=ir;
   estimate 'ec main eff' ec 1 -1;
   estimate 'ir1 v ir2 | v1' ir 1 -1 v*ir 1 0 -1 0;
   estimate 'ir1 v ir2 | v2' ir 1 -1 v*ir 0 1 0 -1;
   estimate 'v1 v v2 | ir1' v 1 -1 v*ir 1 -1 0 0;
   estimate 'v1 v v2 | ir2' v 1 -1 v*ir 0 0 1 -1;
   estimate 'ir main eff' ir 1 -1;
   estimate 'v  main eff' v 1 -1;
   estimate 'e x i same e' ir 1 -1 ec*ir 1 -1 0 0;
   estimate 'e x i same i' ec 1 -1 ec*ir 1 0 -1 0;
   estimate 'e x i diff e,i' ec 1 -1 ir 1 -1 ec*ir 1 0 0 -1;
   estimate 'v x e same e' v 1 -1 v*ec 1 -1 0 0;
   estimate 'v x e diff e' ec 1 -1 v*ec 1 0 -1 0;
   estimate 'v x e diff e,v' ec 1 -1 v 1 -1 v*ec 1 0 0 -1;
   estimate 'v x e x i same e,i' v 1 -1 v*ec 1 -1 0 0 v*ir 1 -1 0 0
             v*ec*ir 1 -1 0 0 0 0 0 0;
   estimate 'same e,v  diff i' ir 1 -1 ec*ir 1 -1 0 0 v*ir 1 0 -1 0
             v*ec*ir 1 0 -1 0 0 0 0 0;
   estimate 'same e  diff v,i' ir 1 -1 v 1 -1 ec*ir 1 -1 0 0 
             v*ec 1 -1 0 0 v*ir 1 0 0 -1 v*ec*ir 1 0 0 -1 0 0 0 0;
   estimate 'same v, diff e,i' ec 1 -1 ir 1 -1 ec*ir 1 0 0 -1
             v*ec 1 0 -1 0 v*ir 1 0 -1 0 v*ec*ir 1 0 0 0 0 0 -1 0;
   estimate 'diff e,i,v' ec 1 -1 ir 1 -1 v 1 -1 ec*ir 1 0 0 -1
             v*ec 1 0 0 -1 v*ir 1 0 0 -1 v*ec*ir 1 0 0 0 0 0 0 -1;
run;


/*---Data Set 10.6.1---*/

data fac_sp;
   input rep blk a b c y;
   abc = a*b*c;
   datalines;
1      1     -1    -1    -1    117
1      1     -1     1     1    130
1      1      1    -1     1    122
1      1      1     1    -1    113
1      2     -1    -1     1    123
1      2     -1     1    -1    121
1      2      1    -1    -1    122
1      2      1     1     1    125
2      1     -1    -1    -1    127
2      1     -1     1     1    137
2      1      1    -1     1    131
2      1      1     1    -1    122
2      2     -1    -1     1    128
2      2     -1     1    -1    124
2      2      1    -1    -1    124
2      2      1     1     1    130
3      1     -1    -1    -1    114
3      1     -1     1     1    132
3      1      1    -1     1    121
3      1      1     1    -1    116
3      2     -1    -1     1    125
3      2     -1     1    -1    124
3      2      1    -1    -1    122
3      2      1     1     1    129
4      1     -1    -1    -1    118
4      1     -1     1     1    132
4      1      1    -1     1    120
4      1      1     1    -1    117
4      2     -1    -1     1    120
4      2     -1     1    -1    118
4      2      1    -1    -1    113
4      2      1     1     1    122
5      1     -1    -1    -1    120
5      1     -1     1     1    132
5      1      1    -1     1    118
5      1      1     1    -1    120
5      2     -1    -1     1    127
5      2     -1     1    -1    127
5      2      1    -1    -1    118
5      2      1     1     1    130
6      1     -1    -1    -1    122
6      1     -1     1     1    134
6      1      1    -1     1    124
6      1      1     1    -1    115
6      2     -1    -1     1    123
6      2     -1     1    -1    122
6      2      1    -1    -1    123
6      2      1     1     1    124
;                                 


/*---produces Output 10.18 on pages 370-371 ---*/

proc mixed; 
   class a b c rep blk;
   model y=a|b|c / ddfm=satterth;
   random rep blk(rep);
   lsmeans a*b b*c / pdiff;
   lsmeans a*b*c;
run;


/*---produces Output 10.19 on page 372---*/

proc mixed; 
   class rep blk;
   model y=a|b|c / solution ddfm=satterth;
   random rep blk(rep);
run;


/*---produces Outputs 10.20 and 10.21 on pages 373-375---*/

proc glm; 
   class rep blk a b c abc;
   model y=rep abc abc*rep a|b|c@2 / solution;
   contrast '111' intercept 1 abc 1 0 a 1 b 1 c 1 a*b 1 a*c 1 b*c 1;
   estimate '111' intercept 1 abc 1 0 a 1 b 1 c 1 a*b 1 a*c 1 b*c 1;
   random rep abc*rep / test;
   lsmeans a*b b*c / pdiff;
run;


/*---produces Output 10.22 on pages 376-377---*/

proc glm; 
   class rep blk;
   model y=rep blk(rep) a|b|c / solution;
   random rep blk(rep) / test;
run;


/*---produces Output 10.23 on pages 377-378---*/

proc glm; 
   class rep blk abc;
   model y=rep abc abc*rep a|b|c@2 / solution;
   contrast '111' intercept 1 abc 1 0 a 1 b 1 c 1 a*b 1 a*c 1 b*c 1;
   estimate '111' intercept 1 abc 1 0 a 1 b 1 c 1 a*b 1 a*c 1 b*c 1;
run;


/*---Data Set 10.7.1---*/

data resist; 
   input rep blk a b c edslp;
   datalines;
1      1     -1    -1    -1     3.6
1      1     -1     1     1     4.5
1      1      1    -1     1     4.2
1      1      1     1    -1     4.0
1      2     -1    -1     1     5.1
1      2     -1     1    -1     3.9
1      2      1    -1    -1     4.5
1      2      1     1     1     4.9
2      1     -1    -1    -1     5.2
2      1     -1     1     1     5.9
2      1      1    -1     1     5.3
2      1      1     1    -1     5.2
2      2     -1    -1     1     5.2
2      2     -1     1    -1     4.6
2      2      1    -1    -1     4.7
2      2      1     1     1     5.2
3      1     -1     1    -1     4.3
3      1     -1     1     1     5.1
3      1      1    -1    -1     4.5
3      1      1    -1     1     4.6
3      2     -1    -1    -1     4.8
3      2     -1    -1     1     5.2
3      2      1     1    -1     5.2
3      2      1     1     1     5.9
4      1     -1    -1     1     5.9
4      1     -1     1     1     6.4
4      1      1    -1    -1     5.7
4      1      1     1    -1     5.6
4      2     -1    -1    -1     4.3
4      2     -1     1    -1     4.4
4      2      1    -1     1     5.3
4      2      1     1     1     5.6
5      1     -1    -1     1     4.3
5      1     -1     1    -1     4.2
5      1      1    -1     1     4.3
5      1      1     1    -1     4.4
5      2     -1    -1    -1     4.5
5      2     -1     1     1     5.5
5      2      1    -1    -1     4.6
5      2      1     1     1     5.2
;                                  


/*---produces Output 10.24 on pages 381-382---*/

proc mixed data=resist; 
   class a b c rep blk;
   model edslp=a|b|c/ddfm=satterth;
   random rep blk(rep);
   lsmeans b c a*c b*c / pdiff;
   lsmeans a*b*c;
run;


/*---produces Output 10.26 on pages 383-384---*/

proc mixed; 
   class rep blk;
   model edslp=a|b|c / solution ddfm=satterth;
   random rep blk(rep);
run;


/*---produces Outputs 10.27 and 10.28 on pages 384-386---*/

proc glm; 
   class rep blk a b c;
   model edslp=rep blk(rep) a|b|c / solution;
   random rep blk(rep) / test;
   lsmeans b c a*c b*c / pdiff;
run;


/*---produces Output 10.29 on pages 387-388---*/

proc glm; 
   class rep blk;
   model edslp=rep blk(rep) a|b|c / solution;
   random rep blk(rep) / test;
run;


/*---Data Set 10.8.1---*/

data prior;
   input blk seq t1 t2 t3 person y11 y12 y13 y21 y22 y23 y31 y32 y33;
   array yy{3,3} y11-y13 y21-y23 y31-y33;
   array tt{3} t1-t3;
   array ll{4} l1-l4;
   do period = 1 to 3;
      prod = tt{period};
      do i = 1 to 4;
         ll{i} = 0;
      end;
      if (period = 1) then priorprd = 0;
      else do;
         priorprd = tt{period - 1};
         ll{priorprd} = 1;
      end;
      do time = 1 to 3;
         y = yy{period,time};
         output;
      end;
   end;
   drop i t1-t3 y11-y13 y21-y23 y31-y33;
   datalines;
1    1    1   2   3    101    5    4    3    5    5    5    5    4    4
1    2    1   3   2    102    4    4    3    6    6    6    5    5    4
1    3    2   1   3    103    5    4    4    5    5    4    5    5    5
1    4    2   3   1    104    4    4    4    4    4    4    4    4    4
1    5    3   2   1    105    5    5    5    5    5    5    6    6    5
1    6    3   1   2    106    6    5    5    6    6    5    7    6    6
2    1    1   2   4    201    3    2    1    3    3    3    2    3    3
2    2    1   4   2    202    4    4    3    4    5    5    4    3    3
2    3    2   1   4    203    4    3    3    3    3    2    4    5    5
2    4    2   4   1    204    4    4    3    4    4    4    3    3    2
2    5    4   2   1    205    4    4    4    3    3    2    4    3    3
2    6    4   1   2    206    4    4    4    3    3    2    4    4    4
3    1    1   3   4    301    4    4    3    5    5    5    4    5    5
3    2    1   4   3    302    3    3    3    4    4    4    3    4    3
3    3    3   1   4    303    4    4    4    4    4    3    4    4    4
3    4    3   4   1    304    3    2    2    3    3    3    3    2    2
3    5    4   3   1    305    2    2    2    2    2    2    2    2    1
3    6    4   1   3    306    4    4    4    4    3    2    4    4    4
4    1    2   3   4    401    3    3    3    3    3    3    4    4    4
4    2    2   4   3    402    3    2    2    4    4    4    3    3    3
4    3    3   2   4    403    4    4    4    5    5    4    4    4    4
4    4    3   4   2    404    2    2    2    3    3    3    4    4    3
4    5    4   3   2    405    4    4    4    4    4    4    4    4    4
4    6    4   2   3    406    3    4    3    4    3    4    3    3    3
;
 

/*---produces Output 10.30 on pages 391-392---*/

proc mixed data=prior; 
   class blk person prod period time priorprd;
   model y=prod period time time*prod priorprd / ddfm=satterth;
   random blk person(blk) period*person(blk);
   lsmeans prod time*prod;
run;


/*---produces Outputs 10.31 and 10.32 on pages 392-393---*/

proc mixed data=prior; 
   class blk person prod period time priorprd;
   model y=prod period time time*prod l1 l2 l3 l4 / ddfm=satterth;
   random blk person(blk) prod*person (blk);
   lsmeans prod time*prod / pdiff;
run;


/*---produces Output 10.33 on pages 395-396---*/

proc mixed data=prior; 
   class blk person prod period time priorprd;
   model y=prod period time time*prod priorprd/ ddfm=satterth;
   random blk person(blk) period(person blk);
   repeated time/subject=period*person(blk) type=ar(1);
   parms (0.49973234) (0.31497310) (0.13799768) (0.20127984)
         (0.111540430);
run;


/*---produces Outputs 10.34 and 10.35 on pages 396-397---*/

proc mixed data=prior; 
   class blk person prod period time priorprd;
   model y=prod period time time*prod L1 L2 L3 L4 / ddfm=satterth;
   random blk person(blk) period*person (blk);
   repeated time/subject=period*person(blk) type=ar(1);
   parms (0.49973234) (0.31497310) (0.13799768) (0.20127984)
         (0.111540430);
   lsmeans prod time*prod / pdiff;
run;


/*---produces Output 10.36 on page 399---*/

proc mixed data=prior; 
   class blk person prod period time priorprd;
   model y=prod period time time*prod priorprd/ddfm=satterth;
   random blk person(blk);
   random period/type=ar(1) subject=person(blk);
   repeated time/subject=period*person(blk) type=ar(1);
   parms (0.50079619) (0.32416655) (0.18092665) (-0.0558346)
         (0.20127984) (0.11540430);
run;


/*---produces Outputs 10.37 and 10.38 on pages 400-401---*/

proc mixed data=prior; 
   class blk person prod period time priorprd;
   model y=prod period time time*prod L1 L2 L3 L4 / ddfm=satterth;
   random blk person(blk);
   random period/type=ar(1) subject=person(blk);
   repeated time/subject=period*person*blk type=ar(1);
   parms (0.50079619) (0.32416655) (0.18092665) (-0.0558346) 
      (0.20127984) (0.11540430);
   lsmeans prod time*prod / pdiff;
run;


/*---Data Set 10.9.1---*/

data farm;
   input farm rep trt y;
   datalines;
1      1      1     49.7
1      1      2     56.2
1      2      1     41.0
1      2      2     52.8
1      3      1     40.8
1      3      2     57.4
2      1      1     42.9
2      1      2     55.9
2      2      1     47.5
2      2      2     52.6
3      1      1     41.8
3      1      2     46.9
3      2      1     39.2
3      2      2     33.3
4      1      1     31.5
4      1      2     51.6
4      2      1     33.5
4      2      2     54.5
5      1      1     46.8
5      1      2     36.6
6      1      1     49.0
6      1      2     63.9
7      1      1     43.2
7      1      2     40.2
7      2      1     37.8
7      2      2     31.9
;


/*---produces Output 10.39 on page 403---*/

proc mixed data=farm;
   class farm rep trt;
   model y=trt/ddfm=satterth;
   random farm rep(farm) farm*trt;
run;

/*---produces Output 10.41 on page 404---*/

proc mixed data=farm;
   class farm rep trt;
   model y=trt;
   random farm rep(farm);
run;
 
/*---produces Outputs 10.42 and 10.43 on pages 406 and 407---*/

proc mixed data=farm;
   class farm rep trt;
   model y=trt;
   random farm rep(farm) farm*trt;
   estimate 'farm 1 trt 1 blup' intercept 1 trt 1 0 |
             farm 1 0 0 0 0 0 0 farm*trt 1 0  0 0  0 0  0 0  0 0  0 0  0 0;
   estimate 'farm 1 trt 2 blup' intercept 1 trt 0 1 |
             farm 1 0 0 0 0 0 0 farm*trt 0 1  0 0  0 0  0 0  0 0  0 0  0 0;
                 
   estimate 'farm 2 trt 1 blup' intercept 1 trt 1 0 |
             farm 0 1 0 0 0 0 0 farm*trt 0 0  1 0  0 0  0 0  0 0  0 0  0 0;
   estimate 'farm 2 trt 2 blup' intercept 1 trt 0 1 |
             farm 0 1 0 0 0 0 0 farm*trt 0 0  0 1  0 0  0 0  0 0  0 0  0 0;
                 
   estimate 'farm 3 trt 1 blup' intercept 1 trt 1 0 |
             farm 0 0 1 0 0 0 0 farm*trt 0 0  0 0  1 0  0 0  0 0  0 0  0 0;
   estimate 'farm 3 trt 2 blup' intercept 1 trt 0 1 |
             farm 0 0 1 0 0 0 0 farm*trt 0 0  0 0  0 1  0 0  0 0  0 0  0 0;
                
   estimate 'farm 4 trt 1 blup' intercept 1 trt 1 0 |
             farm 0 0 0 1 0 0 0 farm*trt 0 0  0 0  0 0  1 0  0 0  0 0  0 0;
   estimate 'farm 4 trt 2 blup' intercept 1 trt 0 1 |
             farm 0 0 0 1 0 0 0 farm*trt 0 0  0 0  0 0  0 1  0 0  0 0  0 0;
   
              
   estimate 'farm 5 trt 1 blup' intercept 1 trt 1 0 |
             farm 0 0 0 0 1 0 0 farm*trt 0 0  0 0  0 0  0 0  1 0  0 0  0 0;
   estimate 'farm 5 trt 2 blup' intercept 1 trt 0 1 |
             farm 0 0 0 0 1 0 0 farm*trt 0 0  0 0  0 0  0 0  0 1  0 0  0 0;
              
   estimate 'farm 6 trt 1 blup' intercept 1 trt 1 0 |
             farm 0 0 0 0 0 1 0 farm*trt 0 0  0 0  0 0  0 0  0 0  1 0  0 0;
   estimate 'farm 6 trt 2 blup' intercept 1 trt 0 1 |
             farm 0 0 0 0 0 1 0 farm*trt 0 0  0 0  0 0  0 0  0 0  0 1  0 0;
              
   estimate 'farm 7 trt 1 blup' intercept 1 trt 1 0 |
             farm 0 0 0 0 0 0 1 farm*trt 0 0  0 0  0 0  0 0  0 0  0 0  1 0;
   estimate 'farm 7 trt 2 blup' intercept 1 trt 0 1 |
             farm 0 0 0 0 0 0 1 farm*trt 0 0  0 0  0 0  0 0  0 0  0 0  0 1;
               
   
   estimate 'farm 1 trt diff' trt 1 -1 |
             farm*trt 1 -1    0  0    0  0    0  0    0  0    0  0    0  0;
   estimate 'farm 2 trt diff' trt 1 -1 |
             farm*trt 0  0    1 -1    0  0    0  0    0  0    0  0    0  0;
   estimate 'farm 3 trt diff' trt 1 -1 |
             farm*trt 0  0    0  0    1 -1    0  0    0  0    0  0    0  0;
   estimate 'farm 4 trt diff' trt 1 -1 |
             farm*trt 0  0    0  0    0  0    1 -1    0  0    0  0    0  0;
   estimate 'farm 5 trt diff' trt 1 -1 |
             farm*trt 0  0    0  0    0  0    0  0    1 -1    0  0    0  0;
   estimate 'farm 6 trt diff' trt 1 -1 |
             farm*trt 0  0    0  0    0  0    0  0    0  0    1 -1    0  0;
   estimate 'farm 7 trt diff' trt 1 -1 |
             farm*trt 0  0    0  0    0  0    0  0    0  0    0  0    1 -1;
   contrast 'farm 5&7 v oth x trt' 
            |  farm*trt 2 -2   2 -2  2 -2  2 -2  -5 5  2 -2  -5 5;
   contrast 'farm 5 v 7 x trt'  
            |  farm*trt 0 0   0 0  0 0  0 0   1 -1   0 0  -1 1;
   contrast 'oth farms x trt'
            |  farm*trt 1 -1  -1  1   0  0   0  0   0  0   0  0   0  0,
            |  farm*trt 1 -1   0  0   -1 1   0  0   0  0   0  0   0  0,
            |  farm*trt 1 -1   0  0   0  0   -1 1   0  0   0  0   0  0,
            |  farm*trt 1 -1   0  0   0  0   0  0   0  0   -1 1   0  0;
   contrast 'among (1,2,4,6) x trt'
            |  farm*trt 1 -1  -1  1   0  0   0  0   0  0   0  0   0  0,
            |  farm*trt 1 -1   0  0   0  0   -1 1   0  0   0  0   0  0,
            |  farm*trt 1 -1   0  0   0  0   0  0   0  0   -1 1   0  0;
run;


/*---produces Outputs 10.44 and 10.45 on pages 408-410---*/

proc glm;
   class farm rep trt;
   model y=farm rep(farm) trt farm*trt;
   random farm rep(farm) farm*trt / test;
   lsmeans farm*trt / stderr;
   contrast 'site 5&7 v oth x trt'
             farm*trt 2 -2   2 -2  2 -2  2 -2  -5 5  2 -2  -5 5;
   contrast 'farm 5 v 7 x trt'
             farm*trt 0 0   0 0  0 0  0 0   1 -1   0 0  -1 1;
   contrast 'oth sites x trt'
             farm*trt 1 -1  -1  1   0  0   0  0   0  0   0  0   0  0,
             farm*trt 1 -1   0  0   -1 1   0  0   0  0   0  0   0  0,
             farm*trt 1 -1   0  0   0  0   -1 1   0  0   0  0   0  0,
             farm*trt 1 -1   0  0   0  0   0  0   0  0   -1 1   0  0;
run;


/*---Data Set 10.10---*/

data cd4;
   input randgrp stratum unit @@;
   seq = _n_;
   do visit = 0,2,6,12,18;
      input cd4 @@;
      sqrtcd4 = sqrt(cd4);
      if visit ne 0 then notbase = 1;
      else notbase = 0;
      if visit ne 0 then visitm2 = visit - 2;
      else visitm2 = 0;
      output;
   end;
   datalines;
2   2    2   114      .     71     89      .
1   2    2    40      .     66     21     25
1   2    3    12     13     38      .      .
2   1    3    15     21      7      3      .
1   1    3    53     74     74     45      .
2   1    3    21      .      .      .      .
2   2    3    46     29     20     10      .
1   2    5    12      1      0      .      .
2   1    5     0     33      .      .      .
1   2    5   147    180    111     56      .
2   2    5    47      .      .      .      .
1   2    5   185    262    177     91    138
2   2    5     6     16      6      .      .
1   2    5     4      8      .      .      .
1   1    5   138     97     83     79      .
2   2    5     3      1     26      .      .
2   2    5    43     24     25     25      .
2   2    5    32     29      9      7      .
1   2    5     9      .      .      .      .
2   1    6   363    364    270    279      .
1   2    6    52     29     11      .      .
1   2    6     3      3      2      4      .
1   2    6    15      .      .      .      .
2   2    6   197    255      .    235    206
2   1    6     5      .      .      .      .
1   2    6   295    394    411    291    185
2   2    6    17      .      5      2      3
1   1    6   285      .      .      .      .
1   1    6    21      .      .      .      .
2   2    6    33      .     19      .      .
2   2    6    83    112     31      .      .
1   2    6     3      .      1      .      .
1   1    6    60     43      .      .     12
2   2    6     1      .      2      .      7
1   2    6   157    101     51     47     40
2   2    6     0      .      1      .      .
2   2    6    15      9      5      .      .
1   2    6   280    233      .      .      .
2   2    6   100      .     61     20      .
1   2    6   263    204      .      .      .
2   2    6    22     11      .      2      .
2   2    6    69      .      .      .      .
2   2    6   272      .      .      .      .
1   2    6    21     29     12      .      .
2   1    6     3      .      .      .      .
1   2    6    39     24      7      .      .
2   1    6    16     13      .      .      .
2   1    6     1      2      .      .      .
1   2    6     1      .      .      .      .
1   2    6   190    207    147     16      .
1   2    6     9     20      .      .      .
2   2    6     2      0      .      .      .
2   1    6    13      .      .      .      .
2   1    7   111    187    130     81      .
2   2    7     6     10     23      4      .
2   1    7    48     53     13     20      .
1   2    7    11     32     10      .      .
1   2    7     6      3      3      .      .
2   2    7   130     27     33      .      .
2   1    7     8      .      5      1      .
2   2    7   154    177      .      .      .
2   2    7   271    250    125    169      .
2   1    7   194    307    142     99      .
1   2    7    32     31      6      .      .
1   1    7    15      .      .      .      .
1   1    7    50      .     21      .      .
1   1    7    17      .      6      .      .
1   1    7   192     78     33     11      .
2   1    7     5      .      .      .      .
1   2    7    46     61     79      .      .
2   2    7     4      5      .      .      .
2   2    7   226    187    190    187      .
1   2    7     1      .      .      .      .
1   2    7    21     37      4      8      .
1   1    7   110     66     58      .      .
2   2    7    19     19     16     10      .
2   1    7    14      1      2      .      .
1   2    7    52    137    104    130      .
2   2    7    21     31     32      8      .
2   2    8   120    300    220    272      .
1   2    8     5      5      .      .      .
1   1    8    42     34     15      .      7
1   1    8    50     50      .      .      .
2   2    8    64     15      .      .      .
1   2    8    15     54     45     25      .
1   2    8   242    390    264    332      .
2   1    8    39      2     24      .      .
2   1    8     8     30      3      .      .
2   1    8     4     11      2     21     19
1   2    8   199    203    286    255    183
2   2    8    65     51     46      5     37
1   1    8    45     48     60     61     42
2   2    8   291    314    453    382    273
1   2    8    39     30     21     16      .
2   2    8   115     90    139    141      .
2   2    8   224      .    363    262      .
1   1    8    40     16      .      .      .
2   1    8    40     26     36      .      .
2   2    8    24      .      3      .      .
2   1    8    21     35     28      .      .
1   1    8   176    198     98     22      .
1   1    8     6      2      .      .      .
2   2    8    13    162      .     42      .
2   1    8    15     20     20      .      .
2   2    8    11      5      .      .      .
1   2    8   275    415    284    308      .
1   1    8    50     72     36      .      .
2   1    8     2      .      .      .      .
2   1    8    61      .      .      .      .
1   1    8   274    265      .      .      .
1   1    8    28     42     16      .      .
2   2    8    41     30      .      .      .
1   1    8    54      .      .      .      .
1   2    8     4      4      2      .      .
2   1    8    54     21      .      .      .
2   1    8    29     21      .      .      .
1   1    8   100      .     14     29      .
2   1    8    10      .      .      .      .
1   2    8   156      .     39      .      .
1   2    8     0      .      .      .      .
1   2    8    59     43     61     25      .
2   2    8     6      4      .      .      .
2   2    8    71      .      .      6      .
1   2    8    27      8     13     18      .
2   2    9    15      3      3      4      .
2   2    9    63     30     22      4      .
1   2    9    25    163    113     59      .
1   1    9    14      .      .      .      .
2   2    9    21     15      5      .      .
2   2    9   197    154    135    110     31
1   2    9   130    582      .      .      .
2   2    9    16     37     10      8      .
2   1    9    37     26      0      8      .
1   2    9    10     12      9      .      .
2   2    9    50     40     20     10      .
2   2    9   109     42     18      .      .
1   2    9    89     19     43      9      6
1   2    9    52     15     26      .      .
2   2    9    42     23     30     11     15
1   1    9     7      .      1      .      .
1   2    9    10      0      5      .      .
1   2    9   232    221    166    141      .
2   1    9   117     17      .     55      .
1   2    9   288    268    150    298      .
2   2    9   168    226    129    144      .
2   1    9   169    149     93     45      .
2   2    9    12     16      0      .      .
1   2    9   126    246    153    140      .
1   2    9   136    112      .     86      .
2   2    9     1      3      0      0      .
1   2    9    91     37      .      .      .
2   2    9   280      .    319      .      .
2   2    9   160    115     57     69      .
1   2    9    46     31      8     10      .
1   2    9     5      3      3      7      .
1   1    9     0      .      .      .      .
1   2   10   246    333      .    232    177
1   2   10   224      .    204    141      .
1   2   10   240    360      .    310      .
2   2   10   198    172      .    286      .
2   1   10    66     89     81     18      .
1   1   10    40     15     34      5      .
1   1   10    10     30      .      .      .
1   1   10    30      .      .      .      .
2   2   10   120    160    120    130     80
2   1   10    50      .     20     10      .
1   2   10    47    110     63     20      .
2   1   10    20     10     20      .      .
2   2   10    30     40     95     50      .
2   2   10    80     50     60     10      .
2   1   10    30      4     40     10      .
1   1   10    76    110      .      .      .
2   2   10   250      .    210    220      .
2   2   10    30     40     40    320      .
2   1   10   100     40      .      .      .
2   1   10   140    105      .     89      .
2   1   10    20     20     10     20      .
2   2   10   270    290    220    240      .
1   2   10    40     20     30      .      .
2   2   10   190     90    130     80      .
1   1   10    40      .      .      .      .
1   2   10    40     80     20     20      .
2   2   10    70     40     30      0      .
1   2   10   180    260    160    180      .
1   1   10     0      .     60     70      .
2   2   10   190    280    130    200      .
2   2   10   270    370    360    350      .
1   2   10     7      4      6    287      .
1   2   10   370      .      .      .      .
2   2   10    24      3     11      7      .
1   2   10   144    237    242    119      .
1   1   10    13     27      .     19      .
1   2   10   104    174    194      .      .
2   1   10    25      0      9     23      .
1   2   10   110    250    170     80      .
1   2   10    20      .      .      .      .
2   2   10   130      .      .      .      .
1   2   10   160    230    300    200      .
1   2   10   190    300    150    240      .
2   2   10    20     10      0      4      .
1   1   10     5      0      .      .      .
2   1   11    59      .      .      .      .
1   1   11     5     14      5      .      .
1   2   11    28      .     46      .      .
1   1   12     6      5      .      .      .
2   2   12   107    126     72     14      .
1   1   12    23      .      .      .      .
2   1   12     4      5      4      9      .
1   1   12    32     39     46     30     34
1   2   12   143    154    264    176      .
2   1   12    14      8      .      .      .
2   2   12   273    383    263    369      .
1   1   12    72     20      9      .      .
2   2   12    77     19      .      .      .
1   2   12    95    234    216     98      .
2   1   12    94     53     29      5      .
1   2   12   165      .     35      .      .
1   2   12     6     18      .      .      .
2   2   12   281    207    160     71     62
2   2   12    17     10      .      .      .
1   2   12     7     15     11      .      .
1   2   12   109     92     85      .     68
2   2   12   222    136      .    179      .
1   2   12     6     10      8      5     11
2   2   12    10      8      3      .      .
1   2   12    21     17      8      .      .
1   2   12    10      .      .      .      .
2   1   12     0     21      .      .      .
2   2   12    13      .      .      .      .
2   2   12    14      .      .      .      .
1   2   12     9      .     10     30      .
1   2   12    11      7     14     16      .
2   1   12    53     27      .      .      .
2   2   12   131    129    122     66      .
1   1   12     3      7      .      .      .
1   2   12   216    249     14    139      .
1   1   12     8      7      .      .      .
1   2   12    37     30     21     16      .
2   2   12   200      .    203    209      .
2   2   12    32     57     13      7      .
2   2   12    67     40     32     54      .
2   2   12   235      .    134     53      .
2   2   12    43     55      .      .      .
1   2   12    35     19     11      .      .
1   2   12   228    235     29    294      .
1   2   12   109    124     88      .      .
1   1   12    11      .      .      .      .
2   2   12    82      .      .      .      .
2   1   12   112      9      5      .      .
1   2   12   181    110      .      .      .
2   1   12    76     18     11      7      .
2   1   12   152    168    144     68      .
2   1   12     7      8      5      2      .
2   2   12   230    253     17    170      .
2   1   13     2      3      2      4      .
2   1   13     1      2      1      1      .
2   2   13     9     22      8     11      .
2   2   13   281    300    368    202    130
1   2   13     5      .      .      .      .
2   2   13    12     35     34     14     14
2   2   13   277     84      .      .      .
1   1   13     4      3      1      1      .
2   1   13     2      2      2      2      .
1   2   13   254    284    291    204      .
2   2   13    51     75     78      .      .
1   1   13     6      2      1      .      .
1   2   13    19     27     34     12      .
2   2   13    16     10      3      4      .
1   2   13     2      6      1      1      .
1   2   13     8     12      4      .      .
2   1   14    17      4      7      .      .
1   2   14    11      8      .      5      .
1   2   14    41     52     30      1      .
1   1   14    54     39     23     14     19
1   1   14    16      .     10      2      4
1   2   14    70     35     49     26      .
1   1   14    10      .      .      .      .
2   2   14    10     10      4      .      .
1   1   14     8      9      6      9      .
2   2   14    12      .      6      .      .
2   1   14    10      8      3      7      .
1   2   14    17      3      1      .      .
1   1   14    15      5      1      1      .
1   1   14    31     26     27     12      .
1   2   14    40      9      .      .      .
1   2   14    44     30      .      .      .
2   1   14    40      6      .      .      .
1   1   14    12      .      .      .      .
1   1   14    80     35     47      3      .
1   2   14    99    200    152    191      .
2   1   14     8      .      .      5      .
2   2   14     3      .      .      .      .
2   2   14    34     34     36     13      .
1   2   14    60     33     37     14      .
2   2   14    38     17     12     55      .
2   1   14    31     22     10      .      .
2   1   14    34     13      9      .      .
1   1   14    11     11      3      .      .
1   1   14    77     51     37      .      .
1   2   14     9     21      .      .      .
1   2   14   122    112     77     72      .
2   2   14   273    129    163    154      .
2   1   14    81     52     26      .      .
1   1   14    10      7     14     10      .
2   1   14     4      .      6      .      .
2   1   14    35      .     11      4      .
2   2   14    65     58     22     15      .
2   1   14     7      4      6      .      .
2   2   14   180    238    171     65      .
2   1   14     4      8      3      .      .
2   2   14    93    142      .     15      .
2   2   14   297    122     89     40      .
2   2   14   300    330    290    270    340
2   2   15    13     10      .      .      .
1   1   15     8     15     17     12      8
2   1   15     3      3      8      6      3
1   1   15     7      9      2      .      .
1   1   15   273    152     65     38     21
1   2   15   137    121    146    138      .
2   2   15    42      .      .      .      .
1   1   15     8      .      .      .      .
2   2   15    62      .      .      .      .
1   2   15     3      4      3      4      .
2   1   15    13      7      3      .      .
2   1   15    37     17     20      1      .
2   1   15     6      3      1      .      .
1   2   15   128      .     24     15      .
1   2   15    64     28      .      .      .
1   1   15     2      .      .      .      .
1   2   15   125    147    203    113      .
2   1   15    18     30     22      .      .
2   2   15    21      .      8      7      .
2   2   15    47     56      .      .      .
1   2   15     5      5      4      .      .
2   1   15    11     12      8      .      .
2   2   15   184    138     37      .      .
1   1   15    12      .      .      .      .
2   1   15     7     10      9      4      .
1   2   15    40     29     28     20      .
2   2   15   100    145     88     45      .
1   2   15   113    116    173    126      .
1   2   15    74     56     29     27      .
2   2   15   161    176      .     30      .
2   2   15     5      .      .      .      .
2   2   15    31     24     31      .      .
1   1   15   233    269    182     71      .
1   2   15    63     71     16     16      .
1   1   15   247    289    219      .      .
1   1   15    10     20      .      .      .
2   2   15   291    367    323    267      .
2   2   15    30     41     22     16      .
2   2   15     5      .      .      .      .
1   2   15   108    475    284    151      .
1   2   15    13     15      .      .      .
1   2   15   341      .      .      .      .
1   1   15     6      6      .      .      .
2   1   15     7     12      9      0      .
1   2   16    23     54      .      .      .
1   1   16    27     33     18      5     12
1   2   16    52     48     84     63     20
1   1   16     0      .     15      .      .
2   1   16     0      .      .      .      .
2   2   16     4     10      0      .      .
1   2   16    14      .      .      0      .
2   2   16    48    143      .      .      .
2   2   16    49     77      .     90      .
2   2   16     5      2      .      .      .
1   2   16    63    110     55     26      .
2   1   16     6      0      .      5      .
2   1   16     8      0      .      .      .
2   1   16    10      .      7      .      .
2   2   16   237    306    286    276      .
1   2   16    66     70      .      .      .
2   1   16   155    104      .    184      .
1   2   16   281      .      .      .      .
1   1   16     0      .      .      .      .
2   2   16   201    238    240    418      .
1   1   16     6      0      .      .      .
1   2   17    20     12     12      .      .
2   2   17    27     20     11      .      .
2   2   17   110     57     41      .      .
2   1   17    37     40      .      .      .
2   2   17     3      5      1      .      .
1   2   17   176    207    383    161      .
2   1   17   217     90     97      9      .
2   1   17    84     39      .      .      .
2   2   17    22     14      6      .      .
2   1   17     8     29     16      7      .
1   2   17    80     51      .      .      .
2   1   17   224    194    125      .      .
1   2   17    13     19      .      3      2
2   2   17    96     53      .      .      .
2   1   17    10     17      9      .      .
1   2   17    30      .      .      .      .
2   2   17    57     55      .     11      .
1   1   17     2      3     11      .      .
2   2   17    19      .      .      .      .
1   2   17    39     14     16      .      .
1   2   17   288    323    357    369      .
2   1   17    15     11      3      .      .
1   2   17    43     13      .      .      .
1   1   17    14     14     10      .      .
1   2   17   125      .      .      .      .
1   1   17     7      7      3     11      .
1   2   17    14      9     10      7      .
1   1   17     2      8      .      .      .
2   2   17    11      7      8      0      .
2   2   17     5      7      .      .      .
1   1   17    46     47     35     25      .
2   2   17     3      2      .      .      .
2   2   17   132     90     60     23      .
1   1   17    84     57     54      .      .
1   1   17    26      .      .      .      .
1   2   17   239    200     89     51      .
2   2   17     4      .      .      .      .
2   2   17    29     23     35      .      .
1   2   17    21    113      5      .      .
1   2   17   166      .      .      .      .
1   2   17   273     87    359    285      .
2   2   17   181      .      .      .      .
1   2   17     2      4      2      0      .
2   1   17    28     43     28     28      .
2   2   17    70     60     66     49      .
1   2   17    76    105     40      .      .
2   2   17    78      .      .      .      .
1   2   18    75    132      .      .      .
2   1   18    36      .      .      .      .
2   2   18    12      6     16     13      .
2   1   18    40      .     28      .      .
2   2   18    16     50     17      5      .
2   1   18     5      .      .      .      .
1   1   18     3     12      .      .      .
1   1   18    56     45      9      8      .
2   2   18    66     78     50     32      .
2   2   18    65     96     60     91      .
1   2   18   272    240    234     98      .
2   1   18    60     24     90     76      .
1   2   18   105    272    375    150      .
1   2   18    36     32     42      .      .
2   1   18    24      4      .      .      .
2   1   18   300    270    143    160      .
2   2   18    20     18     10      .      .
2   2   18    13     14      6      7      7
1   2   18    42     20     30     18      .
2   2   18    27     42      6      6      .
1   1   18     7      9     21      .      .
1   2   18    70     63     30      .      .
1   2   18   159     73      .      .      .
1   1   18    14     16      5      .      .
1   1   18   138    140    154    120    126
1   2   18   169    144     84      .      .
2   1   18    40     36      .     10      .
1   1   18    40      .      .      .      .
1   2   18    24     15      5      5      3
2   2   18    21     12     24    102      .
2   2   18     6     24      .      .      .
2   1   18    10     20     14      3      .
1   2   18   190    136      .      .      .
1   2   18   220    400    240      .      .
1   1   18   247    300    220    242      .
1   1   18     9     30     10      .      .
1   1   18     3     21      .      .      .
1   2   18     7     10      6      7      .
2   2   18    24      .      .      .      .
1   1   18    10      6     12      .      .
2   2   18     9     10      .      .      .
2   1   18    30      5      .      .      . 
run;


/*---produces Output 10.46 on pages 413-414---*/

proc mixed data=cd4;
   class randgrp stratum unit seq;
   model sqrtcd4 = stratum unit
      notbase notbase*randgrp notbase*stratum
      visitm2 visitm2*randgrp visitm2*stratum  / ddfm=res;
   random int notbase visitm2 / type=un sub=seq g gcorr;
run;


/*---produces Output 10.47 on pages 415-416---*/

proc mixed data=cd4;
   class randgrp stratum unit seq visit;
   model sqrtcd4 = stratum unit
      notbase notbase*randgrp notbase*stratum
      visitm2 visitm2*randgrp visitm2*stratum / ddfm=res;
   random int notbase visitm2 / type=un sub=seq;
   repeated visit / sub=seq group=randgrp*stratum;
run;


/*---produces Output 10.48 on pages 418-419---*/

data cd4x;
   input seq randgrp stratum visit notbase;
   cd4 = .;
   sqrtcd4 = .;
   unit = .;
   if (visit ne 0) then visitm2 = visit - 2;
   else visitm2 = 0;
   datalines;
1000 1 1  0 0
1000 1 1  2 1
1000 1 1  6 1
1000 1 1 12 1
1000 1 1 18 1
1001 1 2  0 0
1001 1 2  2 1
1001 1 2  6 1
1001 1 2 12 1
1001 1 2 18 1
1002 2 1  0 0
1002 2 1  2 1
1002 2 1  6 1
1002 2 1 12 1
1002 2 1 18 1
1003 2 2  0 0
1003 2 2  2 1
1003 2 2  6 1
1003 2 2 12 1
1003 2 2 18 1
run;
               
proc append base=cd4 data=cd4x;
run;

proc mixed data=cd4;
   class randgrp stratum visit seq;
   model sqrtcd4 = stratum  
      notbase notbase*randgrp notbase*stratum
      visitm2 / s ddfm=res p;
   random int notbase visitm2 / type=un sub=seq g gcorr;
   repeated visit / sub=seq group=randgrp*stratum;
   estimate 'ddI 2 - base s 2' notbase 1 notbase*randgrp 1 0 
            visitm2 0 / cl;
   estimate 'ddC 2 - base s 2' notbase 1 notbase*randgrp 0 1 
            visitm2 0;
   estimate 'ddI 6 - base s 2' notbase 1 notbase*randgrp 1 0 
            visitm2 4;
   estimate 'ddC 6 - base s 2' notbase 1 notbase*randgrp 0 1 
            visitm2 4;
   estimate 'ddI - ddC s 2' notbase*randgrp 1 -1;
   estimate 'ddI 24 s 1' int 1 stratum 1 0 notbase 1 
            notbase*randgrp 1 0 notbase*stratum 1 0 visitm2 22;
   estimate 'ddC 24 s 1' int 1 stratum 1 0 notbase 1 
            notbase*randgrp 0 1 notbase*stratum 1 0 visitm2 22;
   estimate 'ddI 24 s 2' int 1 notbase 1 notbase*randgrp 1 0 
            visitm2 22;
   estimate 'ddC 24 s 2' int 1 notbase 1 notbase*randgrp 0 1 
            visitm2 22;
   make 'predicted' out=p noprint;
   id visit seq;
run;




/*----------------*/
/*---Chapter 11---*/
/*----------------*/

/*---NOTE: before running the GLIMMIX code you must first 
     %include the GLIMMIX macro.  That is, submit
    
        %inc 'glimmix.sas' / nosource;

     before running the code.---*/

/*---Data Set 11.5---*/

data a;
   input clinic trt$ fav unfav;
   nij=fav+unfav;
   if fav=0 then fav=0.1/nij;
   datalines;
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
;


/*---page 439---*/

%glimmix(data=a,
   procopt=method=reml,
   stmts=%str(
      class clinic trt;
      model fav/nij = trt/solution;
      random clinic trt*clinic / solution;
      estimate 'lsm trt 1' intercept 1 trt 1 0 / cl;
      estimate 'trt diff' trt 1 -1;
      estimate 'trt 1 clinic 1 BLUP' intercept 1 trt 1 0 
               | clinic 1 0;
      estimate 'trt 1 clinic 6 BLUP' intercept 1 trt 1 0
               | clinic 0 0 0 0 0 1 0;
   ),
   error=binomial,
   link=logit
);
run;


/*---produces Output 11.1-11.3 on pages 440-445---*/

data new;
   set a;
   do i=1 to fav;
      y=1;
      output;
   end;
   do i=1 to unfav;
      y=0;
      output;
   end;
run;
   
%glimmix(data=new,
   procopt=method=reml,
   stmts=%str(
      class clinic trt;
      model y = trt / solution;
      random clinic clinic*trt / solution;
      lsmeans trt;
      estimate 'lsm trt 1' intercept 1 trt 1 0 / cl;
      estimate 'trt diff' trt 1 -1;
      estimate 'trt 1 clinic 1 blup' intercept 1 trt 1 0
               | clinic 1 0 trt*clinic 1 / e;
      estimate 'trt 1 clinic 6 blup' intercept 1 trt 1 0 
               | clinic 0 0 0 0 0 1 0 0
                 trt*clinic 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 / e; 
   ),
   error=binomial,
   link=logit
);
run;


/*---produces what should be Output 11.4 on page 446 (the listed
     output is not correct).  However, the output running Release 
     6.11 of GLIMMIX is misleading because the Extra-Dispersion 
     Scale is printed as 0.9415 instead of 1.0000 (this problem 
     is fixed in Release 6.12).  A deviance value of 8.1426 is
     what should be used for comparison.---*/

%glimmix(data=a,
   stmts=%str(
      class clinic trt;
      model fav/nij = trt / solution;
      random clinic trt*clinic / solution;
      repeated;
      parms (2.032) (0.0813) (1.0) (1.0) / noiter;
   ),
   error=binomial,
   link=logit
);
run;


/*---produces Output 11.5-11.6 on pages 448-450---*/

%glimmix(data=new,
   procopt=method=reml,
   stmts=%str(
      class clinic trt;
      model y = trt / solution;
      random clinic trt*clinic / solution;
      estimate 'lsm trt 1' intercept 1 trt 1 0 / cl;
      estimate 'trt diff' trt 1 -1;
      estimate 'trt 1 clinic 1 BLUP' intercept 1 trt 1 0 
               | clinic 1 0;
      estimate 'trt 1 clinic 6 BLUP' intercept 1 trt 1 0
               | clinic 0 0 0 0 0 1 0;
   ),
   error=binomial,
   link=probit
);
run;

/*---produces Output 11.7-11.8 on pages 451-453---*/

%glimmix(data=a,
   procopt=method=reml,
   stmts=%str(
      class clinic trt;
      model fav/nij = trt / solution;
      random clinic trt*clinic / solution;
      parms (2) (0.12) (1.0) / noiter;
      estimate 'lsm trt 1' intercept 1 trt 1 0 / cl;
      estimate 'trt diff' trt 1 -1;
      estimate 'trt 1 clinic 1 BLUP' intercept 1 trt 1 0 
               | clinic 1 0;
      estimate 'trt 1 clinic 6 BLUP' intercept 1 trt 1 0
               | clinic 0 0 0 0 0 1 0;
      lsmeans trt;
   ),
   error=binomial,
   link=identity
);
run;

/*---additional code not in the book---*/

%glimmix(data=a,
   procopt=method=reml,
   stmts=%str(
      class clinic trt;
      model fav/nij = trt / solution;
      random clinic trt*clinic / solution;
      parms (2) (0.12) (1.0) / hold=3;
      estimate 'lsm trt 1' intercept 1 trt 1 0 / cl;
      estimate 'trt diff' trt 1 -1;
      estimate 'trt 1 clinic 1 BLUP' intercept 1 trt 1 0 
               | clinic 1 0;
      estimate 'trt 1 clinic 6 BLUP' intercept 1 trt 1 0
               | clinic 0 0 0 0 0 1 0;
      lsmeans trt;
   ),
   error=binomial,
   maxit=100,
   link=identity
);
run;

/*---Data Set 11.6 A---*/

data a;
   input trt blk mix count;
   y = count + 1;
   datalines;
1 1 1  24
1 1 2  12
1 1 3   8
1 1 4  13
1 2 1   9
1 2 2   9
1 2 3   9
1 2 4  18
1 3 1  12
1 3 2   8
1 3 3  44
1 3 4   0
1 4 1   8
1 4 2  12
1 4 3  25
1 4 4   0
2 1 1  11
2 1 2  32
2 1 3  12
2 1 4  22
2 2 1  41
2 2 2  15
2 2 3  39
2 2 4  38
2 3 1  30
2 3 2  11
2 3 3   5
2 3 4  50
2 4 1  11
2 4 2   0
2 4 3   7
2 4 4  10
3 1 1   0
3 1 2   0
3 1 3  19
3 1 4  25
3 2 1  33
3 2 2  14
3 2 3  20
3 2 4  30
3 3 1  46
3 3 2  31
3 3 3   5
3 3 4   7
3 4 1   8
3 4 2  25
3 4 3  19
3 4 4   3
4 1 1  19
4 1 2  50
4 1 3  20
4 1 4   7
4 2 1  13
4 2 2  42
4 2 3  37
4 2 4   6
4 3 1  10
4 3 2   9
4 3 3  10
4 3 4  24
4 4 1  24
4 4 2  34
4 4 3  35
4 4 4  45
5 1 1  19
5 1 2  48
5 1 3  50
5 1 4  34
5 2 1   0
5 2 2  36
5 2 3  24
5 2 4  24
5 3 1  40
5 3 2  40
5 3 3  14
5 3 4  18
5 4 1  99
5 4 2  39
5 4 3  21
5 4 4  25
6 1 1 115
6 1 2  38
6 1 3  16
6 1 4  34
6 2 1  52
6 2 2  55
6 2 3  17
6 2 4  18
6 3 1  37
6 3 2  19
6 3 3  44
6 3 4  10
6 4 1  10
6 4 2  11
6 4 3  14
6 4 4  13
7 1 1  46
7 1 2  45
7 1 3  37
7 1 4  13
7 2 1  30
7 2 2  96
7 2 3  41
7 2 4  37
7 3 1  59
7 3 2  34
7 3 3  28
7 3 4  20
7 4 1  84
7 4 2  56
7 4 3  26
7 4 4  27
;


/*---produces Output 11.9 on pages 454-455---*/

%glimmix(data=a,
   procopt=method=reml,
   stmts=%str(
      class trt blk mix;
      model y = trt mix trt*mix;
      random blk blk*trt;
      lsmeans trt mix;
   ),
   error=poisson,
   link=log
);
run;


/*---produces Output 11.10 on page 456---*/

%glimmix(data=a,
   procopt=method=reml,
   stmts=%str(
      class trt blk mix;
      model y = trt mix trt*mix;
      random blk*trt;
      lsmeans trt mix;
   ),
   error=poisson,
   link=log
);
run;


/*---produces Output 11.11 on pages 457-458---*/

%glimmix(data=a,
   procopt=method=reml,
   stmts=%str(
      class trt blk mix;
      model y = trt mix trt*mix;
      random blk*trt;
      parms (1) (1) / eqcons=2;
      lsmeans trt mix;
   ),
   error=poisson,
   link=log
);
run;


/*---produces Output 11.12 on page 459---*/

%glimmix(data=a,
   procopt=method=reml,
   stmts=%str(
      class trt blk mix;
      model y = trt mix trt*mix;
      lsmeans trt mix;
   ),
   error=poisson,
   link=log
);
run;


/*----------------*/
/*---Chapter 12---*/
/*----------------*/

/*---NOTE: before running the NLINMIX code you must first 
     %include the NLINMIX macro.  That is, submit
    
        %inc 'nlinmix.sas' / nosource;

     before running the code.---*/

/*---Data Set 12.4---*/

data tree;
   input tree time x y;
   datalines;
1 1  118   30
1 2  484   58
1 3  664   87
1 4 1004  115
1 5 1231  120
1 6 1372  142
1 7 1582  145
2 1  118   33
2 2  484   69
2 3  664  111
2 4 1004  156
2 5 1231  172
2 6 1372  203
2 7 1582  203
3 1  118   30
3 2  484   51
3 3  664   75
3 4 1004  108
3 5 1231  115
3 6 1372  139
3 7 1582  140
4 1  118   32
4 2  484   62
4 3  664  112
4 4 1004  167
4 5 1231  179
4 6 1372  209
4 7 1582  214
5 1  118   30
5 2  484   49
5 3  664   81
5 4 1004  125
5 5 1231  142
5 6 1372  174
5 7 1582  177
;
 
/*---produces Outputs 12.1 and 12.2 on pages 469-472 ---*/

%nlinmix(data=tree,
   response=y,
   subject=tree,
   model=%str(
      num = b1+u1;
      e = exp(b3*x);
      den = 1 + (b2+u2)*e;
      pred = num/den; 
   ),
   derivs=%str(
      d_b1 = 1/den;
      d_b2 = -num/den/den*e;
      d_b3 = -num/den/den*b2*x*e;
      d_u1 = d_b1;
      d_u2 = d_b2;
   ),
   parms=%str(b1=150 b2=10 b3=-.001),
   random=u1 u2,
   type=un,
   expand=zero
)


/*---page 473 of SAS System for Mixed Models---*/

%nlinmix(data=tree,
   response=y,
   subject=tree,
   model=%str(
      num = b1+u1;
      e = exp(b3*x);
      den = 1 + b2*e;
      pred = num/den; 
   ),
   derivs=%str(
      d_b1 = 1/den;
      d_b2 = -num/den/den*e;
      d_b3 = -num/den/den*b2*x*e;
      d_u1 = d_b1;
   ),
   parms=%str(b1=150 b2=10 b3=-.001),
   random=u1,
   expand=eblup
)


/*---produces Outputs 12.3 and 12.4 on pages 474-477---*/

%nlinmix(data=tree,
   method=ml,
   response=y,
   subject=tree,
   model=%str(
      num = b1;
      e = exp(b3*x);
      den = 1 + b2*e;
      pred = num/den; 
   ),
   derivs=%str(
      d_b1 = 1/den;
      d_b2 = -num/den/den*e;
      d_b3 = -num/den/den*b2*x*e;
   ),
   parms=%str(b1=200 b2=7.6 b3=-.0025),
   rtype=cs,
   weight=1/pred**2;
)


/*---page 477 of SAS System for Mixed Models---*/

data pom;
   input power m2ll;
   datalines;
-4     275.4207
-3.5   269.8219
-3     266.9001
-2.75  266.4461
-2.5   266.6548
-2.25  267.5017
-2     268.9451
-1     279.5383
 0     295.2636
run;

proc glm data=pom;
   model m2ll = power power*power;
run;


/*---Data Set 12.5---*/

data pheno;
   input indiv time dose weight apgar conc;
   retain cursub .;
   if cursub ne indiv then do;
      newsub = 1;
      cursub = indiv;
   end;
   else newsub = 0;
   if (apgar < 5) then apgarlow = 1;
   else apgarlow = 0;
   tlag = lag(time);
   if (newsub=1) then tlag = 0;
   drop apgar cursub;
   datalines;   
 1    0.    25.0    1.4      7     . 
 1    2.0    0.0    1.4      7   17.3
 1   12.5    3.5    1.4      7     . 
 1   24.5    3.5    1.4      7     . 
 1   37.0    3.5    1.4      7     . 
 1   48.0    3.5    1.4      7     . 
 1   60.5    3.5    1.4      7     . 
 1   72.5    3.5    1.4      7     . 
 1   85.3    3.5    1.4      7     . 
 1   96.5    3.5    1.4      7     . 
 1  108.5    3.5    1.4      7     . 
 1  112.5    0.0    1.4      7   31.0
 2    0.    15.0    1.5      9     . 
 2    2.0    0.0    1.5      9    9.7
 2    4.0    3.8    1.5      9     . 
 2   16.0    3.8    1.5      9     . 
 2   27.8    3.8    1.5      9     . 
 2   40.0    3.8    1.5      9     . 
 2   52.0    3.8    1.5      9     . 
 2   63.5    0.0    1.5      9   24.6
 2   64.0    3.8    1.5      9     . 
 2   76.0    3.8    1.5      9     . 
 2   88.0    3.8    1.5      9     . 
 2  100.0    3.8    1.5      9     . 
 2  112.0    3.8    1.5      9     . 
 2  124.0    3.8    1.5      9     . 
 2  135.5    0.0    1.5      9   33.0
 3    0.    30.0    1.5      6     . 
 3    1.5    0.0    1.5      6   18.0
 3   11.5    3.7    1.5      6     . 
 3   23.5    3.7    1.5      6     . 
 3   35.5    3.7    1.5      6     . 
 3   47.5    3.7    1.5      6     . 
 3   59.3    3.7    1.5      6     . 
 3   73.0    3.7    1.5      6     . 
 3   83.5    0.0    1.5      6   23.8
 3   84.0    3.7    1.5      6     . 
 3   96.5    3.7    1.5      6     . 
 3  108.5    3.7    1.5      6     . 
 3  120.0    3.7    1.5      6     . 
 3  132.0    3.7    1.5      6     . 
 3  134.3    0.0    1.5      6   24.3
 4    0.    18.6    0.9      6     . 
 4    1.8    0.0    0.9      6   20.8
 4   12.0    2.3    0.9      6     . 
 4   24.3    2.3    0.9      6     . 
 4   35.8    2.3    0.9      6     . 
 4   48.1    2.3    0.9      6     . 
 4   59.3    0.0    0.9      6   23.9
 4   59.8    2.3    0.9      6     . 
 4   71.8    2.3    0.9      6     . 
 4   83.8    2.3    0.9      6     . 
 4   95.8    2.3    0.9      6     . 
 4  107.8    2.3    0.9      6     . 
 4  119.8    2.3    0.9      6     . 
 4  130.8    0.0    0.9      6   31.7
 5    0.    27.0    1.4      7     . 
 5    2.0    0.0    1.4      7   14.2
 5   12.0    3.4    1.4      7     . 
 5   24.0    3.4    1.4      7     . 
 5   36.0    3.4    1.4      7     . 
 5   48.0    3.4    1.4      7     . 
 5   59.5    0.0    1.4      7   18.2
 5   60.0    3.4    1.4      7     . 
 5   72.0    3.4    1.4      7     . 
 5   84.0    3.4    1.4      7     . 
 5   96.0    3.4    1.4      7     . 
 5  108.0    3.4    1.4      7     . 
 5  120.0    3.4    1.4      7     . 
 5  132.0    0.0    1.4      7   20.3
 6    0.    24.0    1.2      5     . 
 6    1.8    0.0    1.2      5   19.0
 6   11.8    3.0    1.2      5     . 
 6   23.8    3.0    1.2      5     . 
 6   35.8    3.0    1.2      5     . 
 6   47.8    3.0    1.2      5     . 
 6   59.3    0.0    1.2      5   17.3
 6   59.8    3.0    1.2      5     . 
 6   71.8    3.0    1.2      5     . 
 6   83.8    3.0    1.2      5     . 
 6   95.8    3.0    1.2      5     . 
 6  107.8    3.0    1.2      5     . 
 6  120.1    3.0    1.2      5     . 
 6  131.8    3.0    1.2      5     . 
 6  142.8    0.0    1.2      5   32.5
 7    0.    19.0    1.0      5     . 
 7    2.0    0.0    1.0      5   17.9
 7   11.3    2.4    1.0      5     . 
 7   23.3    2.4    1.0      5     . 
 7   36.5    2.4    1.0      5     . 
 7   48.2    2.4    1.0      5     . 
 7   60.3    2.4    1.0      5     . 
 7   73.8    0.0    1.0      5   23.4
 7   75.8    2.4    1.0      5     . 
 7   84.3    2.4    1.0      5     . 
 7   96.3    2.4    1.0      5     . 
 7  108.3    2.4    1.0      5     . 
 7  120.3    2.4    1.0      5     . 
 7  132.3    2.4    1.0      5     . 
 7  144.5    2.4    1.0      5     . 
 7  165.3    0.0    1.0      5   25.8
 8    0.    24.0    1.2      7     . 
 8    1.7    0.0    1.2      7   25.8
 8   11.8    3.0    1.2      7     . 
 8   23.7    3.0    1.2      7     . 
 8   35.7    3.0    1.2      7     . 
 8   47.7    3.0    1.2      7     . 
 8   59.7    3.0    1.2      7     . 
 8   71.7    3.0    1.2      7     . 
 8   73.7    0.0    1.2      7   34.2
 8   83.7    3.0    1.2      7     . 
 8   95.7    3.0    1.2      7     . 
 8  107.7    3.0    1.2      7     . 
 8  119.7    3.0    1.2      7     . 
 8  131.7    3.0    1.2      7     . 
 8  143.7    3.0    1.2      7     . 
 8  146.7    0.0    1.2      7   36.1
 9    0.    27.0    1.4      8     . 
 9    1.1    0.0    1.4      8   22.1
 9   11.1    3.2    1.4      8     . 
 9   22.3    3.2    1.4      8     . 
 9   34.6    3.2    1.4      8     . 
 9   46.6    3.2    1.4      8     . 
 9   58.7    3.2    1.4      8     . 
 9   70.9    3.2    1.4      8     . 
 9   82.7    0.0    1.4      8   29.2
 9   83.2    3.2    1.4      8     . 
 9   94.6    3.2    1.4      8     . 
 9  106.6    3.2    1.4      8     . 
 9  118.6    3.2    1.4      8     . 
 9  130.6    3.2    1.4      8     . 
 9  142.1    0.0    1.4      8   34.2
 9  142.6    3.2    1.4      8     . 
 9  312.6    0.0    1.4      8   19.6
10    0.    27.0    1.4      7     . 
10    1.2    0.0    1.4      7   19.9
10   11.2    3.5    1.4      7     . 
10   23.2    3.5    1.4      7     . 
10   35.3    3.5    1.4      7     . 
10   47.2    3.5    1.4      7     . 
10   59.2    3.5    1.4      7     . 
10   70.7    0.0    1.4      7   23.4
10   71.2    3.5    1.4      7     . 
10   83.2    3.5    1.4      7     . 
10   95.2    3.5    1.4      7     . 
10  107.2    3.5    1.4      7     . 
10  119.2    3.5    1.4      7     . 
10  131.2    3.5    1.4      7     . 
10  142.2    0.0    1.4      7   30.9
11    0.    24.0    1.2      7     . 
11   11.5   24.0    1.2      7     . 
11   23.5    3.0    1.2      7     . 
11   35.5    3.0    1.2      7     . 
11   47.5    3.0    1.2      7     . 
11   57.5    0.0    1.2      7   24.3
12    0.    26.0    1.3      6     . 
12    2.0    0.0    1.3      6   17.0
12   12.0    3.3    1.3      6     . 
12   13.0    5.0    1.3      6     . 
12   24.5    3.3    1.3      6     . 
12   36.0    3.3    1.3      6     . 
12   48.5    3.3    1.3      6     . 
12   60.0    3.3    1.3      6     . 
12   72.0    3.3    1.3      6     . 
12   84.0    3.3    1.3      6     . 
12   96.0    3.3    1.3      6     . 
12  108.0    3.3    1.3      6     . 
12  120.0    3.3    1.3      6     . 
12  132.2    0.0    1.3      6   34.1
12  132.5    3.3    1.3      6     . 
12  302.5    0.0    1.3      6   16.0
13    0.    11.0    1.1      6     . 
13   12.0   11.0    1.1      6     . 
13   25.0    2.8    1.1      6     . 
13   36.5    0.0    1.1      6   24.1
13   37.0    2.8    1.1      6     . 
13   49.0    2.8    1.1      6     . 
13   61.0    2.8    1.1      6     . 
13   74.0    2.8    1.1      6     . 
13   85.0    2.8    1.1      6     . 
13   98.0    2.8    1.1      6     . 
13  110.0    2.8    1.1      6     . 
13  121.3    2.8    1.1      6     . 
13  134.0    2.8    1.1      6     . 
13  145.0    2.8    1.1      6     . 
13  157.0    2.8    1.1      6     . 
13  169.0    0.0    1.1      6   38.2
14    0.    22.0    1.1      7     . 
14    2.3    0.0    1.1      7   25.6
14   11.8    2.8    1.1      7     . 
14   23.8    2.8    1.1      7     . 
14   35.8    2.8    1.1      7     . 
14   47.8    2.8    1.1      7     . 
14   59.3    0.0    1.1      7   25.6
14   59.8    2.8    1.1      7     . 
14   71.8    2.8    1.1      7     . 
14   83.8    2.8    1.1      7     . 
14   95.8    2.8    1.1      7     . 
14  107.3    2.8    1.1      7     . 
14  119.8    2.8    1.1      7     . 
14  131.5    0.0    1.1      7   25.7
14  131.8    2.8    1.1      7     . 
14  143.8    2.8    1.1      7     . 
14  303.3    0.0    1.1      7   14.3
15    0.    26.0    1.3      7     . 
15   12.2    3.3    1.3      7     . 
15   22.2    0.0    1.3      7   19.3
15   24.2    3.3    1.3      7     . 
15   36.2    3.3    1.3      7     . 
15   47.8    3.3    1.3      7     . 
15   70.2    3.3    1.3      7     . 
15   85.6    3.3    1.3      7     . 
15   96.2    3.3    1.3      7     . 
15  108.2    3.3    1.3      7     . 
15  120.2    3.3    1.3      7     . 
15  132.2    3.3    1.3      7     . 
15  143.7    3.3    1.3      7     . 
15  145.7    0.0    1.3      7   29.7
16    0.    12.0    1.2      9     . 
16    9.0   12.0    1.2      9     . 
16   12.0    0.0    1.2      9   17.3
16   15.4    4.0    1.2      9     . 
16   21.3    3.0    1.2      9     . 
16   33.0    3.0    1.2      9     . 
16   45.0    3.0    1.2      9     . 
16   56.0    0.0    1.2      9   26.8
16   57.0    3.0    1.2      9     . 
16   69.0    3.0    1.2      9     . 
16   81.0    3.0    1.2      9     . 
16   93.0    3.0    1.2      9     . 
16  105.0    3.0    1.2      9     . 
16  117.0    3.0    1.2      9     . 
16  129.5    3.0    1.2      9     . 
16  141.5    3.0    1.2      9     . 
16  152.8    3.0    1.2      9     . 
16  153.5    0.0    1.2      9   38.4
17    0.    22.0    1.1      5     . 
17   12.0    2.8    1.1      5     . 
17   24.0    2.8    1.1      5     . 
17   32.0    0.0    1.1      5   21.3
17   35.5    2.8    1.1      5     . 
17   48.0    2.8    1.1      5     . 
17   60.0    2.8    1.1      5     . 
17   72.0    0.0    1.1      5   28.8
17   72.3    2.8    1.1      5     . 
17   84.3    2.8    1.1      5     . 
17   95.8    2.8    1.1      5     . 
17  108.0    2.8    1.1      5     . 
17  120.0    2.8    1.1      5     . 
17  132.0    2.8    1.1      5     . 
17  144.0    2.8    1.1      5     . 
17  155.0    0.0    1.1      5   34.9
18    0.    20.0    1.0      5     . 
18    2.8    0.0    1.0      5   21.9
18   11.8   20.0    1.0      5     . 
18   23.8    2.5    1.0      5     . 
18   35.8    2.5    1.0      5     . 
18   48.1    2.5    1.0      5     . 
18   59.3    2.5    1.0      5     . 
18   71.3    0.0    1.0      5   25.9
18   71.8    2.5    1.0      5     . 
18   82.8    2.5    1.0      5     . 
18   95.8    2.5    1.0      5     . 
18  107.8    2.5    1.0      5     . 
18  119.8    2.5    1.0      5     . 
18  131.8    2.5    1.0      5     . 
18  143.8    0.0    1.0      5   28.9
18  389.8    0.0    1.0      5    6.7
19    0.    10.0    1.0      1     . 
19    4.0   10.0    1.0      1     . 
19    9.5    0.0    1.0      1   18.9
19   13.0    2.5    1.0      1     . 
19   24.0    2.5    1.0      1     . 
19   35.9    3.0    1.0      1     . 
19   48.0    3.0    1.0      1     . 
19   59.9    3.0    1.0      1     . 
19   72.0    3.0    1.0      1     . 
19   83.5    0.0    1.0      1   23.2
19   84.3    3.0    1.0      1     . 
19   96.0    3.0    1.0      1     . 
19  108.3    3.0    1.0      1     . 
19  120.0    3.0    1.0      1     . 
19  132.0    3.0    1.0      1     . 
19  144.0    3.0    1.0      1     . 
19  158.0    0.0    1.0      1   32.9
20    0.    24.0    1.2      6     . 
20    2.0    0.0    1.2      6   23.1
20   12.0    3.0    1.2      6     . 
20   24.0    3.0    1.2      6     . 
20   36.0    3.0    1.2      6     . 
20   48.0    3.0    1.2      6     . 
20   60.5    3.0    1.2      6     . 
20   62.5    0.0    1.2      6   27.8
20   72.0    3.0    1.2      6     . 
20   84.0    3.0    1.2      6     . 
20   95.5    3.0    1.2      6     . 
20  108.0    3.0    1.2      6     . 
20  120.0    3.0    1.2      6     . 
20  132.0    3.0    1.2      6     . 
20  134.0    0.0    1.2      6   34.0
21    0.    17.5    1.8      7     . 
21    4.2   17.5    1.8      7     . 
21    8.3    0.0    1.8      7   21.1
21   15.8    4.5    1.8      7     . 
21   28.0    4.5    1.8      7     . 
21   39.8    4.5    1.8      7     . 
21   51.8    4.5    1.8      7     . 
21   63.8    4.5    1.8      7     . 
21   76.8    4.5    1.8      7     . 
21   88.3    4.5    1.8      7     . 
21  100.8    4.5    1.8      7     . 
21  112.3    0.0    1.8      7   29.1
21  112.8    4.5    1.8      7     . 
21  124.3    4.5    1.8      7     . 
21  136.3    4.5    1.8      7     . 
21  148.8    4.5    1.8      7     . 
21  260.6    0.0    1.8      7   21.1
22    0.    15.0    1.5      8     . 
22    4.0   15.0    1.5      8     . 
22    6.0    0.0    1.5      8   21.8
22   16.0    4.0    1.5      8     . 
22   28.0    4.0    1.5      8     . 
22   40.0    4.0    1.5      8     . 
22   51.0    0.0    1.5      8   25.0
23    0.    60.0    3.1      3     . 
23   11.0    0.0    3.1      3   22.3
23   11.5    7.5    3.1      3     . 
23   24.0    7.5    3.1      3     . 
23   35.5    7.5    3.1      3     . 
23   47.0    7.5    3.1      3     . 
23   59.5    7.5    3.1      3     . 
23   70.5    0.0    3.1      3   26.6
23   71.5    7.5    3.1      3     . 
23   84.0    7.5    3.1      3     . 
23   95.8    7.5    3.1      3     . 
23  107.5    7.5    3.1      3     . 
23  120.0    7.5    3.1      3     . 
23  132.5    7.5    3.1      3     . 
23  140.0    0.0    3.1      3   27.7
24    0.    63.0    3.2      2     . 
24    0.7   63.0    3.2      2     . 
24    2.0    0.0    3.2      2   37.3
24    6.5   32.0    3.2      2     . 
24   16.0   10.0    3.2      2     . 
24   28.0   10.0    3.2      2     . 
24   40.0   10.0    3.2      2     . 
24   52.7   10.0    3.2      2     . 
24   64.0   10.0    3.2      2     . 
24   76.0   10.0    3.2      2     . 
24   79.0    0.0    3.2      2   41.7
24   88.0   10.0    3.2      2     . 
24  100.0   10.0    3.2      2     . 
24  112.0   10.0    3.2      2     . 
24  124.0   10.0    3.2      2     . 
24  136.0   10.0    3.2      2     . 
24  147.5   10.0    3.2      2     . 
24  176.0    0.0    3.2      2   38.1
25    0.    15.0    0.7      1     . 
25    2.0    0.0    0.7      1   13.7
25   12.0    1.9    0.7      1     . 
25   18.5    7.5    0.7      1     . 
25   21.0    0.0    0.7      1   21.8
25   23.7    1.5    0.7      1     . 
25   35.8    1.5    0.7      1     . 
25   48.3    1.5    0.7      1     . 
25   60.5    1.5    0.7      1     . 
25   61.5    0.0    0.7      1   16.7
25   70.7    5.0    0.7      1     . 
25   72.0    2.0    0.7      1     . 
25   84.0    2.0    0.7      1     . 
25   90.5    0.0    0.7      1   29.8
25   95.8    2.0    0.7      1     . 
25  108.0    2.0    0.7      1     . 
25  120.0    2.0    0.7      1     . 
25  121.5    0.0    0.7      1   38.0
25  132.0    2.0    0.7      1     . 
25  138.0    0.0    0.7      1   31.3
26    0.    70.0    3.5      9     . 
26   11.5    9.0    3.5      9     . 
26   23.5    9.0    3.5      9     . 
26   35.5    9.0    3.5      9     . 
26   37.5    0.0    3.5      9   28.6
26   47.5    9.0    3.5      9     . 
26   59.5    9.0    3.5      9     . 
26   71.5    9.0    3.5      9     . 
26   83.5    9.0    3.5      9     . 
26   95.5    9.0    3.5      9     . 
26  107.5    9.0    3.5      9     . 
26  110.5    0.0    3.5      9   34.9
27    0.    35.0    1.9      5     . 
27    1.7    0.0    1.9      5   26.4
27   12.4    5.0    1.9      5     . 
27   23.7    5.0    1.9      5     . 
27   35.2    5.0    1.9      5     . 
27   48.0    5.0    1.9      5     . 
27   59.7    5.0    1.9      5     . 
27   71.7    5.0    1.9      5     . 
27   83.2    0.0    1.9      5   33.3
28    0.    60.0    3.2      9     . 
28    2.0    0.0    3.2      9   16.9
29    0.    20.0    1.0      7     . 
29   12.0    2.5    1.0      7     . 
29   23.5    2.5    1.0      7     . 
29   36.5    2.5    1.0      7     . 
29   47.5    0.0    1.0      7   22.9
30    0.    18.0    1.8      8     . 
30    2.2   18.0    1.8      8     . 
30    6.3    0.0    1.8      8   17.9
30   15.3    3.5    1.8      8     . 
30   26.3    3.5    1.8      8     . 
30   38.8    3.5    1.8      8     . 
30   50.8    3.5    1.8      8     . 
30   62.8    3.5    1.8      8     . 
30   75.3    3.5    1.8      8     . 
30   87.3    3.5    1.8      8     . 
30   98.8    3.5    1.8      8     . 
30  110.8    3.5    1.8      8     . 
30  123.3    3.5    1.8      8     . 
30  134.8    3.5    1.8      8     . 
30  226.3    0.0    1.8      8   16.5
31    0.    30.0    1.4      8     . 
31    1.0    0.0    1.4      8   25.3
32    0.    70.0    3.6      9     . 
32    6.5    0.0    3.6      9   12.7
32   12.0    7.5    3.6      9     . 
32   21.6   35.0    3.6      9     . 
32   24.0    0.0    3.6      9   22.1
32   24.3    7.5    3.6      9     . 
32   35.6    7.5    3.6      9     . 
32   48.0    7.5    3.6      9     . 
32   61.0    7.5    3.6      9     . 
32   72.0    7.5    3.6      9     . 
32   83.5    0.0    3.6      9   21.2
33    0.    17.0    1.7      8     . 
33    4.0   17.0    1.7      8     . 
33    5.5    0.0    1.7      8   21.2
33   16.0    4.3    1.7      8     . 
33   28.0    4.3    1.7      8     . 
33   40.3    4.3    1.7      8     . 
33   52.0    4.3    1.7      8     . 
33   65.0    0.0    1.7      8   27.4
34    0.    34.0    1.7      4     . 
34    1.8    0.0    1.7      4   22.1
34   11.8    4.3    1.7      4     . 
34   23.8    4.3    1.7      4     . 
34   47.8    4.3    1.7      4     . 
34   59.8    4.0    1.7      4     . 
34   71.8    4.0    1.7      4     . 
34   83.8    4.0    1.7      4     . 
34   86.8    0.0    1.7      4   28.7
35    0.    25.0    2.5      5     . 
35    3.5   25.0    2.5      5     . 
35   15.0    6.0    2.5      5     . 
35   19.0    0.0    2.5      5   25.2
35   27.0    6.0    2.5      5     . 
35   39.0    6.0    2.5      5     . 
35   51.0    6.0    2.5      5     . 
35   63.0    6.0    2.5      5     . 
35   75.0    6.0    2.5      5     . 
35   87.0    6.0    2.5      5     . 
35   99.0    0.0    2.5      5   38.0
36    0.    30.0    1.5      5     . 
36    2.0    0.0    1.5      5   23.2
36   12.0    4.0    1.5      5     . 
36   23.5    4.0    1.5      5     . 
36   36.0    4.0    1.5      5     . 
36   48.0    4.0    1.5      5     . 
36   60.0    4.0    1.5      5     . 
36   72.0    4.0    1.5      5     . 
36   85.0    4.0    1.5      5     . 
36   96.0    4.0    1.5      5     . 
36  108.0    4.0    1.5      5     . 
36  120.0    4.0    1.5      5     . 
36  132.0    4.0    1.5      5     . 
36  134.0    0.0    1.5      5   28.9
36  304.0    0.0    1.5      5   12.7
37    0.    24.0    1.2      9     . 
37    2.3    0.0    1.2      9   19.5
37   11.8    3.0    1.2      9     . 
37   24.3    3.0    1.2      9     . 
37   36.3    3.0    1.2      9     . 
37   48.3    3.0    1.2      9     . 
37   60.3    3.0    1.2      9     . 
37   72.8    3.0    1.2      9     . 
37   84.3    3.0    1.2      9     . 
37   96.3    3.0    1.2      9     . 
37  108.3    3.0    1.2      9     . 
37  119.8    3.0    1.2      9     . 
37  132.3    3.0    1.2      9     . 
37  144.3    3.0    1.2      9     . 
37  156.3    3.0    1.2      9     . 
37  159.8    0.0    1.2      9   33.4
38    0.    26.0    1.3      8     . 
38    1.8    0.0    1.3      8   17.9
38   11.6    3.0    1.3      8     . 
38   23.3    3.0    1.3      8     . 
38   35.3    3.0    1.3      8     . 
38   47.3    3.0    1.3      8     . 
38   59.3    3.0    1.3      8     . 
38   71.3    3.0    1.3      8     . 
38   83.3    3.0    1.3      8     . 
38   95.3    3.0    1.3      8     . 
38  107.3    3.0    1.3      8     . 
38  118.8    0.0    1.3      8   21.6
38  119.3    3.0    1.3      8     . 
38  131.3    3.0    1.3      8     . 
38  143.3    3.0    1.3      8     . 
38  155.3    3.0    1.3      8     . 
38  167.3    3.0    1.3      8     . 
38  183.3    0.0    1.3      8   30.5
38  310.3    0.0    1.3      8   13.0
39    0.    56.0    1.9     10     . 
39    1.4    0.0    1.9     10   30.0
39   12.7    5.0    1.9     10     . 
39   24.4    5.0    1.9     10     . 
39   36.4    5.0    1.9     10     . 
39   48.4    5.0    1.9     10     . 
39   60.4    5.0    1.9     10     . 
39   72.3    5.0    1.9     10     . 
39   84.8    5.0    1.9     10     . 
39   96.4    5.0    1.9     10     . 
39  108.4    5.0    1.9     10     . 
39  110.4    0.0    1.9     10   37.7
39  120.4    5.0    1.9     10     . 
39  132.4    5.0    1.9     10     . 
39  260.4    0.0    1.9     10   18.4
40    0.    19.0    1.1      3     . 
40    1.0    0.0    1.1      3   13.7
40    2.0    3.0    1.1      3     . 
40    3.8   12.0    1.1      3     . 
40    4.0    0.0    1.1      3   25.0
41    0.    34.0    1.7      7     . 
41    2.0    0.0    1.7      7   18.6
41    7.3    4.0    1.7      7     . 
41   12.0    4.0    1.7      7     . 
41   24.8    4.0    1.7      7     . 
41   33.9    4.0    1.7      7     . 
41   36.0    0.0    1.7      7   21.0
41   48.3    4.0    1.7      7     . 
41   58.7    4.0    1.7      7     . 
41   59.0    0.0    1.7      7   26.4
42    0.    28.0    2.8      9     . 
42   12.0   28.0    2.8      9     . 
42   14.0    0.0    2.8      9   13.3
42   23.7    7.0    2.8      9     . 
42   36.2    7.0    2.8      9     . 
42   47.8    7.0    2.8      9     . 
42   60.0    7.0    2.8      9     . 
42   72.0    7.0    2.8      9     . 
42   84.0    7.0    2.8      9     . 
42   95.5    0.0    2.8      9   13.9
43    0.    18.0    0.9      1     . 
43    2.0    0.0    0.9      1   22.3
44    0.    14.0    1.4      7     . 
44    5.0   14.0    1.4      7     . 
44   11.0    0.0    1.4      7   17.8
44   17.0    3.5    1.4      7     . 
44   29.0    3.5    1.4      7     . 
44   41.0    3.5    1.4      7     . 
44   54.5    3.5    1.4      7     . 
44   65.0    3.5    1.4      7     . 
44   77.5    3.5    1.4      7     . 
44   89.0    3.5    1.4      7     . 
44  101.0    3.5    1.4      7     . 
44  113.0    3.5    1.4      7     . 
44  125.0    0.0    1.4      7   27.6
44  125.5    3.5    1.4      7     . 
44  292.0    0.0    1.4      7   13.5
45    0.    16.0    0.8      2     . 
45    4.5    0.0    0.8      2   16.6
45   12.5    2.0    0.8      2     . 
45   24.5    2.0    0.8      2     . 
45   36.5    2.0    0.8      2     . 
45   48.3    0.0    0.8      2   20.2
45   48.5    2.0    0.8      2     . 
45   60.5    2.0    0.8      2     . 
45   72.5    2.0    0.8      2     . 
45   84.5    2.0    0.8      2     . 
45   96.5    2.0    0.8      2     . 
45  106.5    0.0    0.8      2   24.5
46    0.    11.0    1.1      8     . 
46    0.5   11.0    1.1      8     . 
46    2.0    0.0    1.1      8   20.1
47    0.    40.0    2.6      9     . 
47    9.3    6.7    2.6      9     . 
47   19.3    6.7    2.6      9     . 
47   33.3    6.7    2.6      9     . 
47   36.3    6.7    2.6      9     . 
47   38.3    0.0    2.6      9   25.1
48    0.    14.0    0.7      8     . 
48    2.8    0.0    0.7      8   12.9
48   11.3    1.7    0.7      8     . 
48   23.3    1.7    0.7      8     . 
48   28.8   10.0    0.7      8     . 
48   35.3    1.7    0.7      8     . 
48   47.5    1.7    0.7      8     . 
48   59.3    1.7    0.7      8     . 
48   65.8    0.0    0.7      8   41.1
48   71.8    1.7    0.7      8     . 
48   84.8    0.0    0.7      8   40.3
48  112.3    0.0    0.7      8   36.8
48  137.9    0.0    0.7      8   35.8
49    0.    26.0    1.3      8     . 
49    2.0    0.0    1.3      8   18.8
49   12.0    4.0    1.3      8     . 
49   24.0    4.0    1.3      8     . 
49   36.0    4.0    1.3      8     . 
49   48.0    4.0    1.3      8     . 
49   60.5    4.0    1.3      8     . 
49   72.0    4.0    1.3      8     . 
49   74.0    0.0    1.3      8   25.1
49   84.0    4.0    1.3      8     . 
49   96.0    4.0    1.3      8     . 
49  108.5    4.0    1.3      8     . 
49  120.0    4.0    1.3      8     . 
49  132.0    4.0    1.3      8     . 
49  144.0    4.0    1.3      8     . 
49  150.0    0.0    1.3      8   37.2
50    0.    20.0    1.1      6     . 
50    3.0    0.0    1.1      6   22.2
50   12.5    2.5    1.1      6     . 
50   24.5    2.5    1.1      6     . 
50   36.5    2.5    1.1      6     . 
50   48.0    2.5    1.1      6     . 
50   60.5    2.5    1.1      6     . 
50   72.5    2.5    1.1      6     . 
50   81.0    0.0    1.1      6   30.5
50   84.5    2.5    1.1      6     . 
50   88.0   30.0    1.1      6     . 
50   89.0    0.0    1.1      6   67.9
50   96.5    2.5    1.1      6     . 
50  108.5    2.5    1.1      6     . 
50  120.5    3.5    1.1      6     . 
50  132.5    3.5    1.1      6     . 
50  144.5    3.5    1.1      6     . 
50  157.0    3.5    1.1      6     . 
50  162.0    0.0    1.1      6   58.7
51    0.    18.0    0.9      9     . 
51    3.0    0.0    0.9      9   12.7
51   11.5    2.5    0.9      9     . 
51   12.5    9.0    0.9      9     . 
51   24.5    2.5    0.9      9     . 
51   36.5    2.5    0.9      9     . 
51   49.0    2.5    0.9      9     . 
51   60.0    0.0    0.9      9   31.3
51   60.5    2.5    0.9      9     . 
51   72.5    2.5    0.9      9     . 
51   84.5    2.5    0.9      9     . 
51   96.5    2.5    0.9      9     . 
51  108.5    2.5    0.9      9     . 
51  120.5    2.5    0.9      9     . 
51  132.0    0.0    0.9      9   31.1
52    0.     9.5    0.9      7     . 
52    2.0    0.0    0.9      7   14.3
52    4.0    9.5    0.9      7     . 
52   12.5    9.0    0.9      7     . 
52   35.5    2.5    0.9      7     . 
52   37.5    2.5    0.9      7     . 
52   59.5    2.5    0.9      7     . 
52   71.5    2.5    0.9      7     . 
52   83.0    0.0    0.9      7   38.1
52   83.5    2.5    0.9      7     . 
52   95.5    2.5    0.9      7     . 
52  107.5    2.5    0.9      7     . 
52  119.5    2.5    0.9      7     . 
52  131.5    2.5    0.9      7     . 
52  143.5    2.5    0.9      7     . 
52  155.0    0.0    0.9      7   31.2
53    0.    17.0    1.7      8     . 
53    4.0   17.0    1.7      8     . 
53    6.0    0.0    1.7      8   19.1
53   23.8    4.0    1.7      8     . 
53   27.0    7.5    1.7      8     . 
53   28.0    4.0    1.7      8     . 
53   39.5    4.0    1.7      8     . 
53   47.0    0.0    1.7      8   33.3
54    0.    18.0    1.8      8     . 
54    3.7   18.0    1.8      8     . 
54    9.7    0.0    1.8      8   25.5
54   15.7    4.4    1.8      8     . 
54   27.7    4.4    1.8      8     . 
54   29.7    0.0    1.8      8   29.4
54   39.7    4.4    1.8      8     . 
54   51.7    4.4    1.8      8     . 
54   63.2    0.0    1.8      8   29.5
54   63.7    4.4    1.8      8     . 
54   75.7    4.4    1.8      8     . 
54   87.7    4.4    1.8      8     . 
54   99.7    4.4    1.8      8     . 
54  111.3    0.0    1.8      8   37.9
55    0.    25.0    1.1      4     . 
55   12.0    3.0    1.1      4     . 
55   24.0    3.0    1.1      4     . 
55   36.0    3.0    1.1      4     . 
55   48.0    3.0    1.1      4     . 
55   60.0    3.0    1.1      4     . 
55   72.0    3.0    1.1      4     . 
55   74.0    0.0    1.1      4   20.8
56    0.    12.0    0.6      4     . 
56   12.7    1.5    0.6      4     . 
56   20.0    0.0    0.6      4   18.8
57    0.    20.0    2.1      6     . 
57    0.5   20.0    2.1      6     . 
57    1.7    0.0    2.1      6   20.2
57   12.2    5.0    2.1      6     . 
57   24.7    5.0    2.1      6     . 
57   37.2    5.0    2.1      6     . 
57   47.8    5.0    2.1      6     . 
57   60.2    5.0    2.1      6     . 
57   72.2    6.0    2.1      6     . 
57   84.2    6.0    2.1      6     . 
57   96.2    6.0    2.1      6     . 
57  109.0    0.0    2.1      6   27.8
58    0.    14.0    1.4      8     . 
58    0.5   14.0    1.4      8     . 
58    8.5    0.0    1.4      8   22.4
58   12.0    3.5    1.4      8     . 
58   24.3    3.5    1.4      8     . 
58   35.8    3.5    1.4      8     . 
58   47.5    0.0    1.4      8   27.9
58   48.0    3.5    1.4      8     . 
58   59.5    3.5    1.4      8     . 
58   72.0    3.5    1.4      8     . 
58   84.0    3.5    1.4      8     . 
58   96.3    3.5    1.4      8     . 
58  107.0    3.5    1.4      8     . 
58  120.3    3.5    1.4      8     . 
58  131.8    0.0    1.4      8   31.0
59    0.    22.8    1.1      6     . 
59    1.8    0.0    1.1      6   22.6
59   12.5    3.0    1.1      6     . 
59   24.3    3.0    1.1      6     . 
59   36.3    3.0    1.1      6     . 
59   48.8    3.0    1.1      6     . 
59   60.3    3.0    1.1      6     . 
59   72.3    3.0    1.1      6     . 
59   73.8    0.0    1.1      6   34.3
59   84.3    3.0    1.1      6     . 
59   96.0    3.0    1.1      6     . 
59  108.3    3.0    1.1      6     . 
59  120.5    3.0    1.1      6     . 
59  132.3    3.0    1.1      6     . 
59  144.8    3.0    1.1      6     . 
59  146.8    0.0    1.1      6   40.2
;                                    


/*---produces Outputs 12.5 and 12.6 on pages 482-485---*/

%nlinmix(data=pheno,
   response=conc,
   subject=indiv,
   model=%str(
      clear = beta1*weight*exp(u1);
      vol = beta2*weight*(1+beta3*apgarlow)*exp(u2);
      eterm = exp(-(time-tlag)*clear/vol);
      pred = dose/vol + plag[call]*eterm;
      plag[call] = pred;
      call = call + 1;
   ),
   modinit=%str(
      array plag{11} _temporary_;
      if (newsub=1) then do call = 1 to 11;
         plag[call] = 0;
      end;
      call = 1;
   ),
   parms=%str(beta1=.01 beta2=1 beta3=.1),
   random=u1 u2,
   expand=zero,
   weight=1/pred**2
)
run;











