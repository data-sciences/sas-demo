/*************** START CHAPTER 2 ********************************************/

/****************************************************************************/
/* 2.5 Sample Size Determination                                            */ 
/****************************************************************************/
proc power;
	onesamplemeans test = t
		mean = 63
		nullmean = 60
		std = 15
		sides = 1
		power = 0.8
		ntotal = . ;
title ‘One-Sample Test of a Mean’;
run;

proc power;
	twosamplemeans test = diff
		meandiff = 5
		stddev = 10
		sides = 2
		power = 0.9
		npergroup = . ;
title ‘Two-Sample Comparison of Means’;
run;

proc power;
	twosamplefreq test = pchi
		groupproportions = (0.25 0.35)
		nullproportiondiff = 0
		power = 0.8
		sides = 2
		npergroup = .;
title ‘Two-Sample Comparison of Proportions’;
run;

/*************** END CHAPTER 2 **********************************************/



/*************** START CHAPTER 3 ********************************************/

/****************************************************************************/
/* 3.3 Creating the Data Set TRIAL                                          */ 
/****************************************************************************/
options ls=85 ps=55; 
libname examp 'c:\bookfiles\examples\sas';
 
data examp.trial;
input trt $ center pat sex $ age score @@;
    resp = (score gt 0);
    /* resp = 0 (symptoms are absent), = 1 (symptoms are present)*/
    if (      score =   0) then sev = 0; /* "No Symptoms"        */
    if ( 1 le score le 30) then sev = 1; /* "Mild Symptoms"      */
    if (31 le score le 69) then sev = 2; /* "Moderate Symptoms"  */
    if (      score ge 70) then sev = 3; /* "Severe Symptoms"    */
    datalines;
A 1 101 M 55  5   A 1 104 F 27  0   A 1 106 M 31 35
A 1 107 F 44 21   A 1 109 M 47 15   A 1 111 F 69 70
A 1 112 F 31 10   A 1 114 F 50  0   A 1 116 M 32 20
A 1 118 F 39 25   A 1 119 F 54  0   A 1 121 M 70 38
A 1 123 F 57 55   A 1 124 M 37 18   A 1 126 F 41  0
A 1 128 F 48  8   A 1 131 F 35  0   A 1 134 F 28  0
A 1 135 M 27 40   A 1 138 F 42 12   A 2 202 M 58 68
A 2 203 M 42 22   A 2 206 M 26 30   A 2 207 F 36  0
A 2 210 F 35 25   A 2 211 M 51  0   A 2 214 M 51 60
A 2 216 F 42 15   A 2 217 F 50 50   A 2 219 F 41 35
A 2 222 F 59  0   A 2 223 F 38 10   A 2 225 F 32  0
A 2 226 F 28 16   A 2 229 M 42 48   A 2 231 F 51 45
A 2 234 F 26 90   A 2 235 M 42  0   A 3 301 M 38 28
A 3 302 M 41 20   A 3 304 M 65 75   A 3 306 F 64  0
A 3 307 F 30 30   A 3 309 F 64  5   A 3 311 M 39 80
A 3 314 F 57 85   A 3 315 M 61 12   A 3 318 F 45 95
A 3 319 F 34 26   A 3 321 M 39 10   A 3 324 M 27  0
A 3 325 F 56 35   B 1 102 M 19 68   B 1 103 F 51 10
B 1 105 M 45 20   B 1 108 F 44 65   B 1 110 M 32 25
B 1 113 M 61 75   B 1 115 M 45 83   B 1 117 F 21  0
B 1 120 F 19 55   B 1 122 F 38  0   B 1 125 M 37 72
B 1 127 F 53 40   B 1 129 M 48  0   B 1 130 F 36 80
B 1 132 M 49 20   B 1 133 F 28  0   B 1 136 F 34 45
B 1 137 F 57 95   B 1 139 F 47 40   B 1 140 M 29  0
B 2 201 F 63 10   B 2 204 M 36 49   B 2 205 M 36 16
B 2 208 F 48 12   B 2 209 F 42 40   B 2 212 F 32  0
B 2 213 M 24 88   B 2 215 M 40 59   B 2 218 M 31 24
B 2 220 F 45 72   B 2 221 F 27 55   B 2 224 M 56 70
B 2 227 F 41  0   B 2 228 F 24 65   B 2 230 M 44 30
B 2 232 M 37 32   B 2 233 F 33  0   B 3 303 M 40 26
B 3 305 M 46 15   B 3 308 M 59 82   B 3 310 F 62 38
B 3 312 M 52 40   B 3 313 F 33 40   B 3 316 M 62 87
B 3 317 M 52 60   B 3 320 F 32  2   B 3 322 F 43  0
B 3 323 F 51 35
;


**** OUTPUT 3.1;
proc sort data = examp.trial;
    by pat;
run;
proc print data = examp.trial;
    var pat trt center sex age resp sev score;
    title 'Printout of Data Set TRIAL, Sorted by PAT';
run;
 
**** OUTPUT 3.2;
proc sort data = examp.trial;
    by trt;
run;
proc means mean std n min max data = examp.trial;
    by trt;
    var score age;
    title "Summary Statistics for 'SCORE' and 'AGE' Variables";
run;
 
**** OUTPUT 3.3;
proc univariate data = examp.trial;
    by trt;
    var score;
    title "Expanded Summary Statistics for 'SCORE' ";
run;
 
**** OUTPUT 3.4;
proc sort data = examp.trial;
    by trt center;
run;
proc univariate noprint data = examp.trial;
    by trt center;
    var score;
    output out = summry
        n      = num
        mean   = avescore
        median = medscore;
run;
 
proc print data = summry;
    title "Summary Statistics for 'SCORE' by Treatment Group & Study Center";
run;
 
**** OUTPUT 3.5;
proc format;
    value $trtfmt 'A' = 'trt = A'  'B' = 'trt = B';
run;
proc univariate data=examp.trial noprint;
    class trt;
    histogram score / midpoints = 10 30 50 70 90 nrows = 2 cfill=ltgray;
    format trt $trtfmt.;
    title h=1 "Histogram of 'SCORE' by Treatment Group";
run;

**** OUTPUT 3.6; 
proc format;
    value rspfmt   0 = '0=Abs.'  1 = '1=Pres';
run;
 
proc freq data = examp.trial;
    tables trt*resp / nocol nopct;
    format resp rspfmt.;
    title 'Summary of Response Rates by Treatment Group';
run;
 
**** OUTPUT 3.7;
proc format;
    value sevfmt   0 = '0=None'
                   1 = '1=Mild'
                   2 = '2=Mod.'
                   3 = '3=Sev.' ;
run;
 
proc freq data = examp.trial;
    tables trt*sev / nocol nopct;
    format sev sevfmt.;
    title 'Severity Distribution by Treatment Group';
run;

**** OUTPUT 3.8; 
proc freq data = examp.trial;
    tables sex*trt*sev / nocol nopct;
    format sev sevfmt.;
    title 'Severity Distribution by Treatment Group and Sex';
run;


**** OUTPUT 3.9;
proc format;
    value $trtfmt 'A' = 'trt = A'  'B' = 'trt = B';
run;
proc univariate data=examp.trial noprint;
    class trt;
    histogram sev / midpoints = 0 1 2 3 nrows = 2 cfill=ltgray;
    format trt $trtfmt.;
    title h=1 "Histogram of 'SEV' by Treatment Group";
run;

/*************** END CHAPTER 3 **********************************************/


/*************** START CHAPTER 4 ********************************************/

/****************************************************************************/
/* Example 4.1                                                              */ 
/****************************************************************************/
options ls=85;
data diab;                               
    input patno wt_kg ht_cm @@;          
    bmi  = wt_kg / ((ht_cm/100)**2);     
    datalines;
 1 101.7 178      2  97.1 170 
 3 114.2 191      4 101.9 179 
 5  93.1 182      6 108.1 177 
 7  85.0 184      8  89.1 182 
 9  95.8 179     10  97.8 183 
11  78.7   .     12  77.5 172 
13 102.8 183     14  81.1 169 
15 102.1 177     16 112.1 180 
17  89.7 184 
;
		 	
proc print data = diab;                 
    var patno ht_cm wt_kg bmi;        
    format bmi 5.1;
    title1 'One Sample t Test';
    title2 'EXAMPLE 4.1: Body Mass Index Data';
run;

proc ttest h0=28.4 data=diab;           
    var bmi;
run;

/****************************************************************************/
/* Example 4.2                                                              */ 
/****************************************************************************/
options ls=85;
data obese;
    input subj wtpre wtpst @@;
    wtloss = wtpre - wtpst;                    
    datalines;
 1 165 160   2 202 200    3 256 259    4 155 156
 5 135 134   6 175 162    7 180 187    8 174 172
 9 136 138  10 168 162   11 207 197   12 155 155
13 220 205  14 163 153   15 159 150   16 253 255
17 138 128  18 287 280   19 177 171   20 181 170
21 148 154  22 167 170   23 190 180   24 165 154
25 155 150  26 153 145   27 205 206   28 186 184
29 178 166  30 129 132   31 125 127   32 165 169
33 156 158  34 170 161   35 145 152
;

 
proc print data = obese;                         
    var subj wtpre wtpst wtloss;               
    title1 'One Sample t Test';
    title2 'EXAMPLE 4.2: Paired Difference in Weight Loss';
run;
proc ttest data = obese;
    paired wtpre*wtpst;                            
run;

/*************** END CHAPTER 4 **********************************************/


/*************** START CHAPTER 5 ********************************************/

/****************************************************************************/
/* Example 5.1                                                              */ 
/****************************************************************************/
options ls=75;
data fev;
    input patno trtgrp $ fev0 fev6 @@;
    chg = fev6 - fev0;                
    if chg = . then delete;
    datalines;
101 A 1.35  .     103 A 3.22 3.55   106 A 2.78 3.15 
108 A 2.45 2.30   109 A 1.84 2.37   110 A 2.81 3.20 
113 A 1.90 2.65   116 A 3.00 3.96   118 A 2.25 2.97 
120 A 2.86 2.28   121 A 1.56 2.67   124 A 2.66 3.76 
102 P 3.01 3.90   104 P 2.24 3.01   105 P 2.25 2.47 
107 P 1.65 1.99   111 P 1.95  .     112 P 3.05 3.26 
114 P 2.75 2.55   115 P 1.60 2.20   117 P 2.77 2.56 
119 P 2.06 2.90   122 P 1.71  .     123 P 3.54 2.92
;

proc format;
    value $trt 'A' = 'ABC 123'
               'P' = 'PLACEBO'; 
run;

proc print data = fev;               
    var patno trtgrp fev0 fev6 chg;
    format trtgrp $trt.  fev0 fev6 chg 5.2;
    title1 'Two Sample t Test';
    title2 'EXAMPLE 5.1: FEV1 Changes';
run;

proc means mean std n t prt data = fev;      
    by trtgrp; 
    var fev0 fev6 chg;
    format trtgrp $trt.; 
run;

proc ttest data = fev; 
    class trtgrp; 
    var chg;
    format trtgrp $trt.;
run;

/*************** END CHAPTER 5 **********************************************/


/*************** START CHAPTER 6 ********************************************/

/****************************************************************************/
/* Example 6.1                                                              */ 
/****************************************************************************/
options ls=85;

data gad;
    input patno dosegrp $ hama @@;
    datalines;
101 LO 21  104 LO 18
106 LO 19  110 LO  .
112 LO 28  116 LO 22
120 LO 30  121 LO 27
124 LO 28  125 LO 19
130 LO 23  136 LO 22
137 LO 20  141 LO 19
143 LO 26  148 LO 35
152 LO  .  103 HI 16
105 HI 21  109 HI 31
111 HI 25  113 HI 23
119 HI 25  123 HI 18
127 HI 20  128 HI 18
131 HI 16  135 HI 24
138 HI 22  140 HI 21
142 HI 16  146 HI 33
150 HI 21  151 HI 17
102 PB 22  107 PB 26
108 PB 29  114 PB 19
115 PB  .  117 PB 33
118 PB 37  122 PB 25
126 PB 28  129 PB 26
132 PB  .  133 PB 31
134 PB 27  139 PB 30
144 PB 25  145 PB 22
147 PB 36  149 PB 32
;

proc sort data=gad;
    by dosegrp;
run;

proc means mean std n data = gad;
    by dosegrp;
    var hama;
    title1 'One Way ANOVA';
    title2 'EXAMPLE 6.1: HAM A Scores in GAD';
run;

ods graphics on;
proc glm data = gad plots= boxplot;
    class dosegrp;                                 
    model hama = dosegrp;                          
    means dosegrp / hovtest t dunnett('PB');
    contrast 'ACTIVE vs. PLACEBO' dosegrp 0.5 0.5 -1;
run;                      
ods graphics off;

/*************** END CHAPTER 6 **********************************************/


/*************** START CHAPTER 7 ********************************************/

/****************************************************************************/
/* Example 7.1                                                              */ 
/****************************************************************************/
options ls=85;
data hgbds;
    input trt $  type $  patno hgbch @@;
    datalines;
ACT C  1  1.7   ACT C  3 -0.2   ACT C  6  1.7
ACT C  7  2.3   ACT C 10  2.7   ACT C 12  0.4
ACT C 13  1.3   ACT C 15  0.6   ACT P 22  2.7
ACT P 24  1.6   ACT P 26  2.5   ACT P 28  0.5
ACT P 29  2.6   ACT P 31  3.7   ACT P 34  2.7
ACT P 36  1.3   ACT R 42 -0.3   ACT R 45  1.9
ACT R 46  1.7   ACT R 47  0.5   ACT R 49  2.1
ACT R 51 -0.4   ACT R 52  0.1   ACT R 54  1.0
PBO C  2  2.3   PBO C  4  1.2   PBO C  5 -0.6
PBO C  8  1.3   PBO C  9 -1.1   PBO C 11  1.6
PBO C 14 -0.2   PBO C 16  1.9   PBO P 21  0.6
PBO P 23  1.7   PBO P 25  0.8   PBO P 27  1.7
PBO P 30  1.4   PBO P 32  0.7   PBO P 33  0.8
PBO P 35  1.5   PBO R 41  1.6   PBO R 43 -2.2
PBO R 44  1.9   PBO R 48 -1.6   PBO R 50  0.8
PBO R 53 -0.9   PBO R 55  1.5   PBO R 56  2.1
;

proc format;
    value $typfmt 'C' = 'CERVICAL  '
                  'P' = 'PROSTATE  '
                  'R' = 'COLORECTAL' ;
run;

proc sort data = hgbds;
    by trt type;

proc means mean std n;
    var hgbch;
    by trt type;
    format type $typfmt.;
    title1 'Two-Way ANOVA';
    title2 'EXAMPLE 7.1: Hemoglobin Changes in Anemia';
run;

proc glm data = hgbds;
    class trt type;
    model hgbch = trt type trt*type / ss3;
    lsmeans type / pdiff stderr t lines;
    format type $typfmt.;
quit;
run;

/****************************************************************************/
/* Example 7.2                                                              */ 
/****************************************************************************/
options ls=85;
data memry;
    input dose $  center $  y @@;
    datalines;
 0 A  6   0 A  5   0 A  6   0 A  8   0 A  3
 0 A  4   0 A  5   0 A  6   0 A  5   0 A  5
 0 A  7   0 A  8   0 B  7   0 B  4   0 B  7
 0 B  6   0 B  7   0 B  8   0 B  5   0 B  9
 0 B 11   0 B  4   0 B  7  30 A  8  30 A 12
30 A  7  30 A  8  30 A  6  30 A  9  30 A  6
30 A 11  30 B  5  30 B  6  30 B  6  30 B  5
30 B  3  30 B  8  30 B  6  30 B  9  30 B 11
30 B  5  60 A 11  60 A  7  60 A  7  60 A 11
60 A  9  60 A 10  60 A 12  60 A  9  60 A 15
60 B  9  60 B 12  60 B 13  60 B  9  60 B 13
60 B 12  60 B 14  60 B 15  60 B 12
;

ods graphics on;
proc glm data = memry plots(only)=intplot;
    class dose center;
    model y = dose center center*dose;
    lsmeans dose/pdiff stderr;
    title1 'Two-Way ANOVA';
    title2 'EXAMPLE 7.2: Memory Function';
    label y      = 'Number Recalled'
          center = 'Center'
          dose   = 'Dose';
run;
quit;
ods graphics off;

/****************************************************************************/
/* Example 7.2 Using PROC MIXED (fixed effects model) for output 7.6        */ 
/****************************************************************************/
proc mixed data = memry;
    class dose center;
    model y = dose center dose*center;    
    lsmeans dose*center / diff;         
    title3 '--- Analysis Using PROC MIXED ---';
run;

/****************************************************************************/
/* Example 7.2 Using PROC MIXED (mixed model) for output 7.7                */ 
/****************************************************************************/
proc mixed data = memry;
    class dose center;
    model y = dose;
    random center dose*center;               
    lsmeans dose / diff; 
    title3 'Mixed Model Using PROC MIXED';
run;

/*************** END CHAPTER 7 **********************************************/


/*************** START CHAPTER 8 ********************************************/

/****************************************************************************/
/* Example 8.1                                                              */ 
/****************************************************************************/
options ls=85;
data arthr;
    input vacgrp $  pat mo1 mo2 mo3 ;
    datalines;
ACT 101 6 3 0
ACT 103 7 3 1
ACT 104 4 1 2
ACT 107 8 4 3
PBO 102 6 5 5
PBO 105 9 4 6
PBO 106 5 3 4
PBO 108 6 2 3
;

data discom; set arthr;
    keep vacgrp pat visit score;
    score = mo1; visit = 1; output;
    score = mo2; visit = 2; output;
    score = mo3; visit = 3; output;
run;

proc print data = discom;           
    var vacgrp pat visit score;
    title1 'Repeated Measures ANOVA';
    title2 'Example 8.1: Arthritic Discomfort Following Vaccine';
run;

proc glm data = discom;
    class vacgrp pat visit;                   
    model score = vacgrp pat(vacgrp) visit vacgrp*visit/ss3;
    random pat(vacgrp);
    test h=vacgrp e=pat(vacgrp);          
    quit;
run;
quit;

/****************************************************************************/
/* Example 8.1 for 'Unstructured Covariance' output 8.2                     */ 
/****************************************************************************/
proc mixed data = discom;
    class vacgrp pat visit;               
    model score = vacgrp visit vacgrp*visit;         
    repeated visit / subject=pat(vacgrp) type=un; 
title3 ‘PROC MIXED with Unstructured Covariance’;
run;

/****************************************************************************/
/* Example 8.2                                                              */ 
/****************************************************************************/
data wdvis;
input treatmnt $ pat sex $ wd0 wd1 wd2 wd3 wd4;
datalines;
ACT 101 M  190 212 213 195 248
ACT 105 M   98 137 185 215 225
ACT 109 M  155 145 196 189 176
ACT 112 M  245 228 280 274 260
ACT 117 M  182 205 218 194 193
ACT 122 M  140 138 187 195 205
ACT 123 M  196 185 185 227 180
ACT 128 M  162 176 192 230 215
ACT 129 M  195 232 199 185 200
ACT 132 M  167 187 228 192 210
ACT 134 M  123 165 145 185 215
ACT 136 M  105 144 119 168 165
ACT 103 F  161 177 162 185 192
ACT 107 F  255 242 330 284 319
ACT 108 F  144 195 180 184 213
ACT 113 F  180 218 224 165 200
ACT 115 F  126 145 173 175 140
ACT 119 F  175 155 154 164 154
ACT 124 F  227 218 245 235 257
ACT 126 F  175 197 195 182 193
PBO 104 M  187 177 200 190 206
PBO 111 M  205 230 172 196 232
PBO 114 M  165 142 195 185 170
PBO 118 M  256 232 252 326 292
PBO 125 M  197 182 160 210 185
PBO 127 M  134 115 150 165 170
PBO 131 M  196 166 166 188 205
PBO 133 M  167 144 176 155 158
PBO 135 M   98 102  89 128 130
PBO 102 F  167 175 122 162 125
PBO 106 F  123 136 147 130 135
PBO 110 F   95 102 154 105 112
PBO 116 F  181 177 140 212 230
PBO 120 F  237 232 245 193 245
PBO 121 F  144 172 163 158 188
PBO 130 F  182 202 254 185 173
PBO 137 F  165 140 153 180 155
PBO 138 F  196 195 204 188 178
;
run;

data wduni; set wdvis;
keep treatmnt pat sex month wd;
  wd = wd0; month = 0; output;
  wd = wd1; month = 1; output;
  wd = wd2; month = 2; output;
  wd = wd3; month = 3; output;
  wd = wd4; month = 4; output;
run;

*** output 8.3;
proc mixed data = wduni;
  class treatmnt sex month pat;
  model wd = treatmnt sex treatmnt*sex month treatmnt*month;
  repeated month / subject=pat(treatmnt) type=un r rcorr;  
  title1 'Repeated-Measures ANOVA';
  title2 'Example 8.2:  Treadmill Walking Distance in Intermittent Claudication';
  title3 'PROC MIXED using Unstructured Covariance';
run;

*** output 8.4 - compound symmetry;
proc mixed data = wduni;
  class treatmnt sex month pat;
  model wd = treatmnt sex treatmnt*sex month treatmnt*month;
  repeated month / subject=pat(treatmnt) type=cs r; 
      lsmeans treatmnt*month / slice=month;
	  estimate 'Month 4 Change from Baseline: ACT v. PBO' treatmnt*month -1 0 0 0 1 1 0 0 0 -1;
  title3 'PROC MIXED using Compound Symmetric Covariance';
run;

/****************************************************************************/
/* Example 8.3                                                              */ 
/****************************************************************************/
options ls=85;
data alzhmrs;
    input treat $ pat adas02 adas04 adas06 adas08 adas10 adas12;
    datalines;
L  1  22  30   .  33  28  30
L  5  34  35  46  37  31  35
L  8  40  41  41  46  52  48
L 12  24   .  21  28  30  27
L 13  29  26  29  26   .  36
L 15  31  36  41  46  52  57
L 19  22  27  28  24  27  28
L 21  43  49  42  48  48  46
L 24  18  28  29   .  25  28
L 28  25  24  27  18  21  22
L 31  37  35  35  38  42   .
L 34  24  27  28  24  27  25
L 37  45  50  58  59  60  58
L 40  33  32  35  30  31  35
L 44  34  37  43  44  39  38
L 47  25  27  29  28  31   .
L 51  30   .  36  32  34  38
L 54  23   .  33  28  32  32
L 57  35  37  39  38  41  43
L 59  44  48  48  45  50  52
L 63  28  30  32  31  35  32
L 67  24  22  23  24  27  30
L 68   .  49  51  48  55  54
L 73  26  28  30  27  30  33
L 76  30  32  35  35  36  38
L 78  40  42  44  43  45  46
H  2  31  36  35  31  31  31
H  6  24  27  28  21  27  26
H  7  31  31  39  37  41   .
H 14  45  48  46  52  48  42
H 17  24  28  26  23  24  29
H 20  21  32  39  36  33  30
H 22  32  34  45  42  37  32
H 25  18  22  26  26  27  24
H 27  51  47   .  43  43  43
H 33  20  22  29  24  29  30
H 38  41  34  37  29  35  33
H 42  24  35  39  32  24   .
H 45  23   .  33  36  33  30
H 50  25  28  25  28  28  30
H 52  31  34   .  33  34  35
H 56  27  31  26  33  33  34
H 60  37  43  39  42  43  36
H 62  41  42  51  45  46  51
H 66  35  33  34  35  36  41
H 69  30  31  27  34  33  36
H 72  54  60  55  58   .  65
H 75  35  37  39  41  39  44
H 79  18  21  19  19  20  27
H 80  40  35  33  39  38  41
P  3  31  36  37  41  39  44
P  4  20  26  32  35  25  29
P  9  33  33  29  33  39  41
P 10  35  39  40  38  40  38
P 11  26  24  31  42  50   .
P 16  44  48  44  37  36  47
P 18  25  31  21  27  41  32
P 23  28  34  26  26  36  35
P 26  27   .  28  35  40   .
P 29  20  30  30  27  33  29
P 30  49   .  43  48  44  53
P 32  26  29  31  30  35  38
P 35  30  33  41  .   41  44
P 36  31  34  44  44  50  56
P 39  42  46  36  43  48  48
P 41  31  30  31   .  41  38
P 43  27  22  36  45  54  60
P 46  24  37  41  31  36  44
P 48  33  31  38  41  31   .
P 49  27  30  36  36  32  33
P 53  35  34  45  44  38  40
P 55  39  40  38  44  43  44
P 58  32  34  40  45  36  38
P 61  45  50   .  54  50  53
P 64  21  23  31  34  27  27
P 65  26  30  37  37  30  32
P 70  53  50  55  57   .   .
P 71  32  34  27  30  36  35
P 74   .  50  52  56  52  54
P 77  24  32  31  37  35  30
;
 
data unialz; set alzhmrs;
    keep treat pat month adascog;
    month =  2; adascog = adas02; output;
    month =  4; adascog = adas04; output;
    month =  6; adascog = adas06; output;
    month =  8; adascog = adas08; output;
    month = 10; adascog = adas10; output;
    month = 12; adascog = adas12; output;
run;
 
**** output 8.5;
proc mixed data = unialz;
    class treat month pat;
    model adascog = treat month treat*month;
      repeated / subject=pat(treat) type=cs rcorr ; 
title1 'Repeated-Measures ANOVA';
title2 "  ";
title3 "Example 8.3: Disease Progression in Alzheimer’s";
title4 'PROC MIXED Using Compound Symmetric Covariance (CS)';
run;


ods select Mixed.ModelInfo
           Mixed.Dimensions
           Mixed.FitStatistics
           Mixed.LRT
           Mixed.Tests3 ;
**** output 8.6;
proc mixed data = unialz;
    class treat month pat;
    model adascog = treat month treat*month;
      repeated / subject=pat(treat) type=ar(1);
title1 'Repeated-Measures ANOVA';
title2 "  ";
title3 "Example 8.3: Disease Progression in Alzheimer’s";
title4 'PROC MIXED Using First-Order Auto-Regressive Covariance (AR(1))';
run;

ods select Mixed.ModelInfo
           Mixed.Dimensions
           Mixed.FitStatistics
           Mixed.LRT
           Mixed.Tests3 ;
**** output 8.7;
proc mixed data = unialz;
    class treat month pat;
    model adascog = treat month treat*month;
      repeated / subject=pat(treat) type=toep;
title1 'Repeated-Measures ANOVA';
title2 "  ";
title3 "Example 8.3: Disease Progression in Alzheimer’s";
title4 'PROC MIXED Using Toeplitz Covariance (TOEP)';
run;

ods select Mixed.ModelInfo
           Mixed.Dimensions
           Mixed.FitStatistics
           Mixed.LRT
           Mixed.Tests3 ;
**** output 8.8;
proc mixed data = unialz;
    class treat month pat;
    model adascog = treat month treat*month;
      repeated / subject=pat(treat) type=arma(1,1); 
title1 'Repeated-Measures ANOVA';
title2 "  ";
title3 "Example 8.3: Disease Progression in Alzheimer’s";
title4 'PROC MIXED Using 1st-Order Auto-Regressive Moving Average Covariance (ARMA(1,1))';
run;

ods select Mixed.ModelInfo
           Mixed.Dimensions
           Mixed.FitStatistics
           Mixed.LRT
           Mixed.Tests3 
           Mixed.RCorr;
**** output 8.9;
proc mixed data = unialz;
    class treat month pat;
    model adascog = treat month treat*month;
      repeated / subject=pat(treat) type=un rcorr;
title1 'Repeated-Measures ANOVA';
title2 "  ";
title3 "Example 8.3: Disease Progression in Alzheimer’s";
title4 'PROC MIXED Using Unstructured Covariance (UN)';
run;

**** output 8.10 - PROC GENMOD;
ods select genmod.type3;
proc genmod data = unialz;
    class treat month pat;
    model adascog = treat month treat*month / dist=normal type3;
    repeated subject=pat / type=ar(1);
title4 'GEE Analysis Using PROC GENMOD';
title5 'Autoregressive Correlation (AR(1)) Working Correlation';
run;

/*************** END CHAPTER 8 **********************************************/


/*************** START CHAPTER 9 ********************************************/

/****************************************************************************/
/* Example 9.1                                                              */ 
/****************************************************************************/
options ls=85;
data xover;
    input pat seq $ trt $ pd y @@;
    datalines;
 1 AB A 1  6    3 AB A 1  8    5 AB A 1 12    6 AB A 1  7
 9 AB A 1  9   10 AB A 1  6   13 AB A 1 11   15 AB A 1  8
 1 AB B 2  4    3 AB B 2  7    5 AB B 2  6    6 AB B 2  8
 9 AB B 2 10   10 AB B 2  4   13 AB B 2  6   15 AB B 2  8
 2 BA A 2  7    4 BA A 2  6    7 BA A 2 11    8 BA A 2  7
11 BA A 2  8   12 BA A 2  4   14 BA A 2  9   16 BA A 2 13
 2 BA B 1  5    4 BA B 1  9    7 BA B 1  7    8 BA B 1  4
11 BA B 1  9   12 BA B 1  5   14 BA B 1  8   16 BA B 1  9
;

proc mixed data = xover;
    class seq trt pd pat;  
    model y = seq trt pd;  
	lsmeans trt /diff;
    random pat(seq);          
    title1 'Crossover Design';
    title2 ‘Example 9.1: Diaphoresis Following Cardiac Medication’;    
run;

/****************************************************************************/
/* Example 9.2                                                              */ 
/****************************************************************************/     
options ls=85;
data inhal1;      
    input seqgrp $ pat auc1 auc2 auc3 auc4  @@;
    datalines;
ABDC 102  2.31  3.99 11.75  4.78
ABDC 106  3.95  2.07  7.00  4.20
ABDC 109  4.40  6.40  9.76  6.12
BCAD 104  6.81  8.38  1.26 10.56
BCAD 105  9.05  6.85  4.79  4.86
BCAD 111  7.02  5.70  3.14  7.65
CDBA 101  6.00  4.79  2.35  3.81
CDBA 108  5.25 10.42  5.68  4.48
CDBA 112  2.60  6.97  3.60  7.54
DACB 103  8.15  3.58  8.79  4.94
DACB 107 12.73  5.31  4.67  5.84
DACB 110  6.46  2.42  4.58  1.37
;

data inhal2; set inhal1;
  dose = substr(seqgrp,1,1); per = 1; auc = auc1; output;
  dose = substr(seqgrp,2,1); per = 2; auc = auc2; output;
  dose = substr(seqgrp,3,1); per = 3; auc = auc3; output;
  dose = substr(seqgrp,4,1); per = 4; auc = auc4; output;
run;

proc sort data = inhal2; by pat per;

data inhal; set inhal2;
  keep pat seqgrp dose per auc co;
  co = lag(dose); if per = 1 then co = '0';
run;

proc sort data = inhal; by seqgrp per pat;
proc print data = inhal;
  title1 'CrossOver Design';
  title2 'Example 9.2: Antibiotic Blood Levels Following Aerosol Inhalation';
run;

proc mixed data = inhal;
  class seqgrp dose per co;
  model auc = seqgrp dose per co;
  random pat(seqgrp);
  lsmeans dose / diff;           
run;
quit;

/*************** END CHAPTER 9 **********************************************/


/*************** START CHAPTER 10 *******************************************/

/****************************************************************************/
/* Example 10.1                                                             */ 
/****************************************************************************/
data angina;
    input pat x_dur y_impr @@;
    datalines;
 1 1  40     2 1  90     3 3  30     4 2  30
 5 1  80     6 5  60     7 1  10     8 4 -10
 9 2  50    10 6  40    11 1  60    12 4   0
13 2  50    14 2 110    15 3  20    16 3  70
17 5 -30    18 3  20    19 1  40    20 6   0
;

proc sort data = angina; by x_dur y_impr;
proc print data = angina;                       
    var pat x_dur y_impr;
    title1 'Linear Regression & Correlation';
    title2 'Example 10.1: Improvement in Angina vs. Disease Duration';
run;

proc means mean std n;   
    var x_dur y_impr;
run;

ods graphics on;
proc glm data = angina plots=all;  
    model y_impr = x_dur / p clm ss1;
run;
quit;
ods graphics off;

/****************************************************************************/
/* Example 10.2                                                             */ 
/****************************************************************************/
options ls=85;
data dehyd;
    input pat y dose age wt @@;
    datalines;
 1  77 0.0  4 28   2  65 1.5  5 35   3  75 2.5  8 55
 4  63 1.0  9 76   5  75 0.5  5 31   6  82 2.0  5 27
 7  70 1.0  6 35   8  90 2.5  6 47   9  49 0.0  9 59
10  72 3.0  8 50  11  67 2.0  7 50  12 100 2.5  7 46
13  75 1.5  4 33  14  58 3.0  8 59  15  58 1.5  6 40
16  55 0.0  8 58  17  80 1.0  7 55  18  55 2.0 10 76
19  44 0.5  9 66  20  62 1.0  6 43  21  60 1.0  6 48
22  75 2.5  7 50  23  77 1.5  5 29  24  80 2.5 11 64
25  68 3.0  9 61  26  71 2.5 10 71  27  90 1.5  4 26
28  80 2.0  3 27  29  70 0.0  9 56  30  58 2.5  8 57
31  88 1.0  3 22  32  68 0.5  5 37  33  60 0.5  6 44
34  90 3.0  5 45  35  79 1.5  8 53  36  90 2.0  4 29
;

proc print data = dehyd;   
    var pat y dose age wt;
    title1 'Multiple Linear Regression';
    title2 'Example 10.2: Recovery in Pediatric Dehydration';
run;

ods graphics on;
proc reg corr data = dehyd;                          
    model y = dose age wt / ss1 ss2 vif collinoint;
    model y = dose       ;
    model y = dose age   ;                         
    model y = dose wt    ;                        
run;
quit;
ods graphics off;

/*************** END CHAPTER 10 *********************************************/


/*************** START CHAPTER 11 *******************************************/

/****************************************************************************/
/* Example 11.1                                                             */ 
/****************************************************************************/
options ls=85;
data tri;
    input trt $ pat hgba1c trichg @@;
    datalines;
FIB  2 7.0   5   FIB  4 6.0  10   FIB  7 7.1  -5
FIB  8 8.6 -20   FIB 11 6.3   0   FIB 13 7.5 -15
FIB 16 6.6  10   FIB 17 7.4 -10   FIB 19 5.3  20
FIB 21 6.5 -15   FIB 23 6.2   5   FIB 24 7.8   0
FIB 27 8.5 -40   FIB 28 9.2 -25   FIB 30 5.0  25
FIB 33 7.0 -10   GEM  1 5.1  10   GEM  3 6.0  15
GEM  5 7.2 -15   GEM  6 6.4   5   GEM  9 5.5  10
GEM 10 6.0 -15   GEM 12 5.6  -5   GEM 14 5.5 -10
GEM 15 6.7 -20   GEM 18 8.6 -40   GEM 20 6.4  -5
GEM 22 6.0 -10   GEM 25 9.3 -40   GEM 26 8.5 -20
GEM 29 7.9 -35   GEM 31 7.4   0   GEM 32 5.0   0
GEM 34 6.5 -10 
;

proc sort data = tri;
    by trt hgba1c trichg;
 
/* Print data set */
proc print data = tri;                            
    var trt pat hgba1c trichg;
    title1 'Analysis of Covariance';
    title2 'Example 11.1: Triglyceride Changes Adjusted for Glycemic Control';
run;

/* Obtain summary statistics for each group */
proc means mean std n data = tri;                
    by trt;
    var hgba1c trichg;
run;

/* Use glycemic control as covariate */
ods graphics on;
proc glm data = tri plots=ancovaplot;
    class trt;
    model trichg = trt hgba1c / solution;       
          lsmeans trt/pdiff stderr cl;                
run;
quit;
ods graphics off;

/* Compare groups with ANOVA, ignoring the covariate */
proc glm data = tri;                            
    class trt;
    model trichg = trt / ss3;
run;
quit;

/****************************************************************************/
/* Example 11.2                                                             */ 
/****************************************************************************/
options ls=85;
data bp;
    input trt $ pat age bpdia0 bpdiach @@;
    center = int(pat/100);
    datalines;
SOLE 101 55 102  -6   SOLE 103 68 115 -10
SOLE 104 45  97  -2   SOLE 106 69 107  -5
SOLE 109 54 115  -7   SOLE 202 58  99  -4
SOLE 203 62 119 -11   SOLE 204 51 107  -9
SOLE 206 47  96   0   SOLE 208 61  98  -6
SOLE 211 40 110   5   SOLE 212 36 103  -3
SOLE 214 58 109  10   SOLE 216 64 119 -12
SOLE 217 55 104   4   SOLE 219 54  97  -5
SOLE 223 39  95  -8   SOLE 301 49 115  -3
SOLE 302 46 105   4   SOLE 304 59 116 -10
SOLE 307 42 108  -5   SOLE 308 65 101  -7
SOLE 311 68 102  -5   SOLE 313 57 110  -8
SOLE 402 73 119 -12   SOLE 404 48  99  -7
SOLE 406 53 117   0   SOLE 407 46  96   4
SOLE 409 60 118 -15   SOLE 412 66 104  -3
SOLE 414 59 115  -4   SOLE 415 41 109   3
SOLE 418 53 116 -10   SOLE 421 57 100  -8
SOLE 424 52 103   0   SOLE 425 41  95   9
COMB 102 68 112 -10   COMB 105 64 105  -4
COMB 107 48 107  -9   COMB 108 60 107  -5
COMB 201 44 109  -7   COMB 205 53  99   0
COMB 207 48 107  -9   COMB 209 65 106  -3
COMB 210 79 108  -6   COMB 213 45 110  -9
COMB 215 44  93   0   COMB 218 62  99  -5
COMB 220 59 119 -14   COMB 221 50 104  -6
COMB 222 61 107 -14   COMB 224 36  95   3
COMB 225 34  95  -9   COMB 303 49 115  -8
COMB 305 57 115   7   COMB 306 58 116 -20
COMB 309 43 108  -7   COMB 310 66 101  -5
COMB 312 55 102  -9   COMB 314 70 110 -16
COMB 315 52 104  -8   COMB 401 42 119 -15
COMB 403 49 109  -6   COMB 405 53 117   4
COMB 408 55  96   6   COMB 410 65  98  -8
COMB 411 75 108  -7   COMB 413 59 104 -10
COMB 416 60 115 -16   COMB 417 53 109   3
COMB 419 43  96 -14   COMB 420 77 100  -5
COMB 422 55 103  -8   COMB 423 66 115 -14
COMB 426 38 105  -3
;

proc print data = bp;                                
    title1 'Analysis of Covariance';
    title2 'Example 11.2: ANCOVA in Multi-Center Hypertension Study';
run;

proc sort data = bp;
    by trt center;

proc means mean std n min max data = bp;             
    by trt;
    var age bpdia0 bpdiach;
run;

proc mixed data = bp;
    classes trt center;                              
    model bpdiach = trt center age bpdia0 / solution;
    lsmeans trt / diff;
run;


*** output 11.3;
proc mixed data = bp;
    classes trt center;
    model bpdiach = trt age bpdia0 / solution;
    random center;
    lsmeans trt / diff;
run;

/*************** END CHAPTER 11 *********************************************/


/*************** START CHAPTER 12 *******************************************/

/****************************************************************************/
/* Example 12.1                                                             */ 
/****************************************************************************/
options ls=85;
data kcs;
    input pat hypotear okerinse @@;
    diff = hypotear - okerinse;
    datalines;
 1 15  8     2 10  3     3  6  7     4  5 13
 5 10  2     6 15 12     7  7 14     8  5  8
 9  8 13    10 12  3    11  4  9    12 13  3
13  8 10    14 10  2    15 11  4    16 13  7
17  6  1    18  6 11    19  9  3    20  5  5
21 10  2    22  9  8    23 11  5    24  8  8
;

proc univariate normal data = kcs;
    var diff;
    title1 'The Wilcoxon-Signed-Rank Test';
    title2 'Example 12.1:  Rose Bengal Staining in KCS';
run;

/*************** END CHAPTER 12 *********************************************/


/*************** START CHAPTER 13 *******************************************/

/****************************************************************************/
/* Example 13.1                                                             */ 
/****************************************************************************/
options ls=85;

data rnksm;
    input trt $ pat score @@;
    datalines;
SER  2  0   SER  3  2   SER  5  3   SER  6  3
SER  8 -2   SER 10  1   SER 12  3   SER 14  3
SER 16 -1   SER 17  2   SER 20 -3   SER 21  3
SER 22  3   SER 24  0   SER 26  2   SER 27 -1
PBO  1  3   PBO  4 -1   PBO  7  2   PBO  9  3
PBO 11 -2   PBO 13  1   PBO 15  0   PBO 18 -1
PBO 19 -3   PBO 23 -2   PBO 25  1   PBO 28  0
;

proc npar1way wilcoxon data = rnksm;
    class trt; var score;
    title1 'The Wilcoxon Rank Sum Test';
    title2 'Example 13.1:  Seroxatene in Back Pain';
run;

/*************** END CHAPTER 13 *********************************************/


/*************** START CHAPTER 14 *******************************************/

/****************************************************************************/
/* Example 14.1                                                             */ 
/****************************************************************************/
options ls=85;
data psor;
    input dose $ pat score @@;
    datalines;
0.1  1  5   0.1  6  4   0.1  9  1   0.1 12  7
0.1 15  4   0.1 19  3   0.1 20  6   0.1 23  7
0.1 27  8   0.1 32  7   0.2  3  5   0.2  5  8
0.2  7  2   0.2 10  8   0.2 14  7   0.2 18  4
0.2 22  5   0.2 26  4   0.2 28  6   0.2 31  4
PBO  2  5   PBO  4  3   PBO  8  7   PBO 11  1
PBO 13  2   PBO 16  4   PBO 17  2   PBO 21  1
PBO 24  4   PBO 25  5   PBO 29  4   PBO 30  5
;

ods graphics on;
proc npar1way wilcoxon data = psor plots=wilcoxon;
    class dose;                        
    var score;
    title1 'The Kruskal Wallis Test'; 
    title2 'Example 14.1: Psoriasis Evaluation in Three Groups';
run;
ods graphics off;

*** output 14.2;
proc rank data = psor out = rnk;
    var score;
    ranks rnkscore;
run;

proc glm data = rnk; 
    class dose;
    model rnkscore = dose / ss3;
run;
quit; 

/*************** END CHAPTER 14 *********************************************/


/*************** START CHAPTER 15 *******************************************/

/****************************************************************************/
/* Example 15.1                                                             */ 
/****************************************************************************/
options ls=85;
data gwart;
    input patient $ cured $ @@;
    datalines;
1  YES    8   YES    15  YES    22  YES
2  _NO    9   _NO    16  _NO    23  _NO
3  YES    10  _NO    17  _NO    24  YES
4  _NO    11  YES    18  YES    25  YES
5  YES    12  _NO    19  YES
6  YES    13  YES    20  _NO
7  _NO    14  _NO    21  YES
;
run;

proc freq data=gwart;
    tables cured / binomialc (p = 0.4) alpha=0.05;
    exact binomial;                                  
    title1 "Binomial Test";
    title2 "Example 15.1: Genital Warts Cure Rate";
run;

/*************** END CHAPTER 15 *********************************************/


/*************** START CHAPTER 16 *******************************************/

/****************************************************************************/
/* Example 16.1                                                             */ 
/****************************************************************************/
data adr;
    input grp resp $ cnt @@;
    datalines;
1 YES 22   1 _NO 44
2 YES 28   2 _NO 24
;
 
/* grp 1 = Test Drug,  grp 2 = Control */
proc freq data = adr;
    tables grp*resp / chisq nopercent nocol;
    weight cnt;
    title1 'The Chi-Square Test';
    title2 'Example 16.1: ADR Frequency with Antibiotic Treatment';
run;

*** output 16.2;
data g_by_r;
    input tbl group $ resp $ cnt @@;
    datalines;
1 A 1 10   1 A 2 15   1 A 3  5
1 B 1 10   1 B 2 10   1 B 3 10
1 C 1 10   1 C 2  5   1 C 3 15
2 A 1 15   2 A 2 10   2 A 3  5
2 B 1  5   2 B 2 10   2 B 3 15
2 C 1 10   2 C 2 10   2 C 3 10
3 A 1 15   3 A 2 10   3 A 3  5
3 B 1 10   3 B 2 10   3 B 3 10
3 C 1  5   3 C 2 10   3 C 3 15
;

ods select cmh; 
proc freq order = data data = g_by_r;
    by tbl;
    tables group*resp / cmh nopercent nocol;
    weight cnt;
    title1 'Chi-Square Test for 3-by-3 Table';
run; 

/****************************************************************************/
/* Example 16.2                                                             */ 
/****************************************************************************/
data dorate;
    input dose_mg resp $ cnt @@;
    datalines;
10 YES 5   10 _NO 35
20 YES 6   20 _NO 29
40 YES 10  40 _NO 28
80 YES 12  80 _NO 27
;
 
proc freq data = dorate;
    tables dose_mg*resp / chisq cmh trend nopercent nocol;
    weight cnt;
    title1 'The Chi-Square Test';
    title2 'Example 16.2: Comparison of Dropout Rates for 4 Dose Groups';
run;


/****************************************************************************/
/* Example 16.3                                                             */ 
/****************************************************************************/
data multi;
    input trt $ resp $ cnt @@;
    datalines;
ACT NONE 16  ACT PART 26  ACT FULL 29
PBO NONE 24  PBO PART 26  PBO FULL 18
;

proc freq order = data data = multi;
    tables trt*resp / cmh chisq trend nopercent nocol;
    weight cnt;
    title1 'The Chi-Square Test';
    title2 'Example 16.3: Active vs. Placebo Comparison of Degree of Response';
run;

/*************** END CHAPTER 16 *********************************************/


/*************** START CHAPTER 17 *******************************************/

/****************************************************************************/
/* Example 17.1                                                             */ 
/****************************************************************************/
data cabg;
    input grp resp $ cnt  @@;
    datalines;
1 YES  2   1 _NO 33   
2 YES  5   2 _NO 15
;

/* grp 1 = Active Group,  grp 2 = Placebo */
proc freq data = cabg;
    tables grp*resp / fisher nopercent nocol;   
    weight cnt;                               
    title1 "Fisher's Exact Test";
    title2 'Example 17.1:  CHF Incidence in CABG after ARA';
run;

/*************** END CHAPTER 17 *********************************************/


/*************** START CHAPTER 18 *******************************************/

/****************************************************************************/
/* Example 18.1                                                             */ 
/****************************************************************************/
proc format;
    value rsltfmt 0 = 'N'  1 = 'Y';
run;

data bili;
    input pat pre pst @@;
    datalines;
 1 0 0  2 0 0  3 0 0  4 0 0  5 0 0  6 0 1
 7 1 1  8 0 0  9 0 0 10 0 0 11 0 0 12 1 0
13 0 0 14 0 1 15 0 0 16 0 0 17 0 0 18 0 0
19 0 0 20 0 1 21 0 0 22 1 0 23 0 0 24 0 0
25 1 0 26 0 0 27 0 0 28 1 1 29 0 1 30 0 1
31 0 0 32 0 0 33 1 0 34 0 0 35 0 0 36 0 0
37 0 0 38 0 1 39 0 1 40 0 0 41 0 0 42 0 1
43 0 0 44 1 0 45 0 0 46 0 0 47 1 1 48 0 0
49 0 0 50 0 1 51 1 0 52 0 0 53 0 1 54 0 0
55 1 1 56 0 0 57 0 0 58 0 0 59 0 0 60 0 0
61 0 0 62 0 0 63 0 0 64 0 0 65 0 0 66 0 0
67 0 0 68 0 0 69 0 1 70 0 1 71 1 1 72 0 0
73 0 0 74 0 1 75 0 0 76 0 1 77 0 0 78 0 0
79 0 0 80 0 0 81 1 1 82 0 0 83 0 0 84 0 0
85 0 0 86 0 0
;

ods exclude
    simplekappa;
proc freq data = bili;
    tables pre*pst / agree norow nocol;
    exact mcnem;
    format pre pst rsltfmt.;
    title1 "McNemar's Test";
    title2 'Example 18.1: Bilirubin Abnormalities Following Drug Treatment';
run;

/****************************************************************************/
/* Example 18.2                                                             */ 
/****************************************************************************/
data diet;
    input pre wk2 cnt @@;
    datalines;
0 0 14   0 1  6   0 2  4
1 0  9   1 1 17   1 2  2
2 0  6   2 1 12   2 2  8
; 
run;

proc catmod data=diet;
    weight cnt;
    response marginals;
    model pre*wk2=_response_ / freq;
    repeated TIME 2;
    title1 "Bhapkar's Test";
    title2 "Example 18.2: Craving Level Following Diet";
run;
quit;

/*************** END CHAPTER 18 *********************************************/


/*************** START CHAPTER 19 *******************************************/

/****************************************************************************/
/* Example 19.1                                                             */ 
/****************************************************************************/
options ls=85;

data ulcr;
    input cntr $ trt $ resp $ frq @@;
    datalines;
1 ACT YES 26  1 CTL YES 18
1 ACT _NO  4  1 CTL _NO 11
2 ACT YES  8  2 CTL YES  7
2 ACT _NO  3  2 CTL _NO  5
3 ACT YES  7  3 CTL YES  4
3 ACT _NO  5  3 CTL _NO  6
4 ACT YES 11  4 CTL YES  9
4 ACT _NO  6  4 CTL _NO  5
;

/* Analysis using CNTR as stratification factor */
ods exclude
    CommonRelRisks;
proc freq data = ulcr;
    tables cntr*trt*resp / cmh nopercent nocol; 
    weight frq;
    title1 'The Cochran-Mantel-Haenszel Test';
    title2 'Example 19.1:  Response to Dermotel in Diabetic Ulcers';
run;

/* Analysis without stratification (ignoring CNTR) */
proc freq data = ulcr;        
    tables trt*resp / chisq nopercent nocol;
    weight frq;
run;

/****************************************************************************/
/* Example 19.2                                                             */ 
/****************************************************************************/
options ls=85;
data fmpain;
input hxdep $ trt $ imprv  cnt @@;
    datalines;
_NO FLEX -1  4  _NO FLEX  0 11  _NO FLEX  1 14  _NO FLEX  2  9
_NO NORB -1  5  _NO NORB  0 13  _NO NORB  1 15  _NO NORB  2  8
_NO PLAC -1  7  _NO PLAC  0 14  _NO PLAC  1 14  _NO PLAC  2  4
YES FLEX -1  4  YES FLEX  0  7  YES FLEX  1  9  YES FLEX  2  5
YES NORB -1  3  YES NORB  0  6  YES NORB  1 11  YES NORB  2  3
YES PLAC -1  5  YES PLAC  0  9  YES PLAC  1  6  YES PLAC  2  3
;

proc format;
	value imprv
		   2 = "much improved"
           1 = "somewhat improved"
           0 = "no change"
          -1 = "worse";
run;
 
ods graphics on / width=3in height=4in;;
proc freq data = fmpain;
    weight cnt;
    tables hxdep*trt*imprv / 
           cmh nopercent nocol scores = modridit;
	format imprv imprv.;
    title1 "Extended Cochran-Mantel-Haenszel Test";
    title2 "Example 19.2:  Flexisyl in Fibromyalgia Pain";
run;
ods graphics off;

/* Analysis using PROC CATMOD */
proc catmod data = fmpain;
    weight cnt;
    response means;
    model imprv = hxdep trt; 
    title3 " ";
    title4 "WLS Using CATMOD: comparison of means";
run;
quit;

/*************** END CHAPTER 19 *********************************************/


/*************** START CHAPTER 20 *******************************************/

/****************************************************************************/
/* Example 20.1                                                             */ 
/****************************************************************************/
data aml;
    input pat group $  x  relapse $ @@;
    datalines;
  1 ACT  3 NO     2 ACT  3 YES    4 ACT  3 YES
  6 ACT  6 YES    7 ACT 15 NO    10 ACT  6 YES
 11 ACT  6 YES   14 ACT  6 YES   15 ACT 15 NO 
 17 ACT 15 NO    20 ACT 12 NO    21 ACT 18 NO 
 22 ACT  6 YES   25 ACT 15 NO    26 ACT  6 YES
 28 ACT 15 NO    29 ACT 12 YES   32 ACT  9 NO 
 33 ACT  6 YES   36 ACT  6 NO    39 ACT  6 NO 
 42 ACT  6 NO    44 ACT  3 YES   46 ACT 18 NO 
 49 ACT  9 NO    50 ACT 12 YES   52 ACT  6 NO 
 54 ACT  9 YES   56 ACT  9 YES   58 ACT  3 NO 
 60 ACT  9 YES   62 ACT 12 NO    63 ACT 12 NO 
 66 ACT  3 NO    67 ACT 12 NO    69 ACT 12 NO 
 71 ACT 12 NO    73 ACT  9 YES   74 ACT  6 YES
 77 ACT 12 NO    79 ACT  6 NO    81 ACT 15 YES
 83 ACT  9 NO    85 ACT  3 YES   88 ACT  9 NO 
 90 ACT  9 NO    92 ACT  9 NO    94 ACT  9 NO 
 95 ACT  9 YES   98 ACT 12 YES   99 ACT  3 YES
102 ACT  6 YES    3 PBO  9 YES    5 PBO  3 NO 
  8 PBO 12 YES    9 PBO  3 YES   12 PBO  3 YES
 13 PBO 15 YES   16 PBO  9 YES   18 PBO 12 YES
 19 PBO  3 YES   23 PBO  9 YES   24 PBO 15 YES
 27 PBO  9 YES   30 PBO  6 YES   31 PBO  9 YES
 34 PBO  6 YES   35 PBO 12 NO    37 PBO  9 NO 
 38 PBO 15 NO    40 PBO 15 YES   41 PBO  9 NO 
 43 PBO  9 NO    45 PBO 12 YES   47 PBO  3 YES
 48 PBO  6 YES   51 PBO  6 YES   53 PBO 12 NO 
 55 PBO 12 NO    57 PBO 12 YES   59 PBO  3 YES
 61 PBO 12 YES   64 PBO  3 YES   65 PBO 12 YES
 68 PBO  6 YES   70 PBO  6 YES   72 PBO  9 YES
 75 PBO 15 NO    76 PBO 15 NO    78 PBO 12 NO 
 80 PBO  9 NO    82 PBO 12 NO    84 PBO 15 NO 
 86 PBO 18 YES   87 PBO 12 NO    89 PBO 15 YES
 91 PBO 15 NO    93 PBO 15 NO    96 PBO 18 NO 
 97 PBO 18 YES  100 PBO 18 NO   101 PBO 18 NO 
;

ods graphics on;
proc logistic data = aml 
    plots(only) = (effect oddsratio);
    class group(ref="PBO") / param=ref;
    model relapse (event="YES")= group x;
    oddsratio group;
    oddsratio x;
    title1 'Logistic Regression';
    title2 'Example 20.1:  Relapse Rate Adjusted for Remission Time in AML';
    run;
ods graphics off;

proc freq data = aml;
    tables group*relapse / chisq nocol nopercent nocum;
    title3 'Chi-Square Test Ignoring the Covariate';
run; 

/****************************************************************************/
/* Example 20.2                                                             */ 
/****************************************************************************/
data gi;
    input pat  rx $  hist  resp  @@;
    /* A = new treatment, B = untreated                    */   
    /* hist = 0 if no prior episodes, hist = 1 if one      */
    /* prior episode, HIST = 2 if >1 prior episodes        */
    /* resp = 1 (none), 2 (some), 3 (marked), 4 (complete) */
    datalines;
101 A 1 3   102 A 2 3   103 B 1 3   104 A 1 2
105 B 1 3   106 A 0 4   107 B 1 2   108 A 2 1
109 A 0 4   110 B 2 3   111 B 2 1   112 B 0 4
113 A 1 3   114 A 1 4   115 A 0 4   116 A 2 2
117 A 1 3   118 B 0 3   119 B 2 2   120 B 1 1
121 A 2 1   122 B 2 1   123 B 1 4   124 A 1 4
125 A 1 2   126 B 0 2   127 A 2 4   128 A 0 3
129 B 2 2   130 A 1 4   131 B 1 3   132 A 1 3
133 A 1 1   134 B 1 2   135 A 1 4   136 B 2 3
137 A 0 3   138 B 2 1   139 B 0 4   140 A 2 4
141 B 1 3   142 B 2 4   143 A 1 3   144 A 2 3
145 A 2 2   146 B 1 2   147 A 1 4   148 B 1 1
149 A 2 1   150 B 1 2   151 A 2 4   152 B 1 3
153 A 1 2   154 A 1 2   155 A 1 4
; 

proc logistic descending data = gi;
    class rx(ref="B") / param = ref;                 
    model resp(descending) = rx hist;
    title1 'Logistic Regression';
    title2 'Example 20.2: Symptom Relief in Severe Gastroparesis';
run;

/****************************************************************************/
/* Example 20.3                                                             */ 
/****************************************************************************/
data diary;
    input pat trt age succ attpt @@;
    /* trt = 1 for new drug, trt = 0 for reference control */
    if attpt = 0 then delete;
    datalines;
 1 0 41  3  6    3 0 44  5 15    5 0 62  0  4    6 0 44  1  2
 8 0 70  3  8   11 0 35  4  8   13 0 72  1  6   15 0 34  5 15
18 0 61  1  7   22 0 35  5  5   24 0 52  6  8   25 0 66  1  7
27 0 35  4 10   30 0 61  4  8   31 0 55  2  5   34 0 41  7  9
37 0 53  2  4   39 0 72  4  6   40 0 68  0  0   41 0 56 12 17
44 0 53  8 15   45 0 45  3  4   48 0 40 14 20    2 1 57  3  8
 4 1 54 10 12    7 1 65  0  0    9 1 51  5  8   10 1 53  8 10
12 1 44 17 22   14 1 66  2  3   16 1 55  9 11   17 1 37  6  8
19 1 40  2  4   20 1 44  9 16   21 1 64  5  9   23 1 78  1  3
26 1 51  6 12   28 1 67  5 11   29 1 44  3  3   32 1 65  7 18
33 1 69  0  2   35 1 53  4 14   36 1 49  5  8   38 1 74 10 15
42 1 39  4  9   43 1 35  8 10   46 1 47  4  5   47 1 46  6  7
;

proc logistic data = diary; 
    class trt(ref='0') / param = ref;
    model succ/attpt = trt age / scale = williams;         
    title1 'Logistic Regression'; 
    title2 'Example 20.3: Intercourse Success Rate in Erectile Dysfunction';
run;

/*************** END CHAPTER 20 *********************************************/


/*************** START CHAPTER 21 *******************************************/

/****************************************************************************/
/* Example 21.1                                                             */ 
/****************************************************************************/
data hsv;
    input vac $ pat wks x @@;
    cens = (wks < 1);
    wks  = abs(wks);
    trt = (vac = 'GD2');    /* used in Example 22.1 */
    datalines;
GD2  1   8 12  GD2  3 -12 10  GD2  6 -52  7
GD2  7  28 10  GD2  8  44  6  GD2 10  14  8
GD2 12   3  8  GD2 14 -52  9  GD2 15  35 11
GD2 18   6 13  GD2 20  12  7  GD2 23  -7 13
GD2 24 -52  9  GD2 26 -52 12  GD2 28  36 13
GD2 31 -52  8  GD2 33   9 10  GD2 34 -11 16
GD2 36 -52  6  GD2 39  15 14  GD2 40  13 13
GD2 42  21 13  GD2 44 -24 16  GD2 46 -52 13
GD2 48  28  9  PBO  2  15  9  PBO  4 -44 10
PBO  5  -2 12  PBO  9   8  7  PBO 11  12  7
PBO 13 -52  7  PBO 16  21  7  PBO 17  19 11
PBO 19   6 16  PBO 21  10 16  PBO 22 -15  6
PBO 25   4 15  PBO 27  -9  9  PBO 29  27 10
PBO 30   1 17  PBO 32  12  8  PBO 35  20  8
PBO 37 -32  8  PBO 38  15  8  PBO 41   5 14
PBO 43  35 13  PBO 45  28  9  PBO 47   6 15
;

proc sort data = hsv; 
    by vac pat; 

proc print data = hsv;
    var vac pat wks cens x;
    title1 'The Log-Rank Test';
    title2 'Example 21.1: HSV-2 Episodes with gD2 Vaccine';
run;

ods exclude
    productlimitestimates;
ods graphics on;
proc lifetest data = hsv 	
     plots=(survival(atrisk=5 10 15 20 25 30 35 40 45 50 55 60) ls);
    time wks*cens(1); 
    strata vac;   
run;
ods graphics off;

/*************** END CHAPTER 21 *********************************************/


/*************** START CHAPTER 22 *******************************************/

/****************************************************************************/
/* Example 22.1                                                             */ 
/****************************************************************************/
data hsv;
    input vac $ pat wks x @@;
    cens = (wks < 1);
    wks  = abs(wks);
    trt = (vac = 'GD2');    /* used in Example 22.1 */
    datalines;
GD2  1   8 12  GD2  3 -12 10  GD2  6 -52  7
GD2  7  28 10  GD2  8  44  6  GD2 10  14  8
GD2 12   3  8  GD2 14 -52  9  GD2 15  35 11
GD2 18   6 13  GD2 20  12  7  GD2 23  -7 13
GD2 24 -52  9  GD2 26 -52 12  GD2 28  36 13
GD2 31 -52  8  GD2 33   9 10  GD2 34 -11 16
GD2 36 -52  6  GD2 39  15 14  GD2 40  13 13
GD2 42  21 13  GD2 44 -24 16  GD2 46 -52 13
GD2 48  28  9  PBO  2  15  9  PBO  4 -44 10
PBO  5  -2 12  PBO  9   8  7  PBO 11  12  7
PBO 13 -52  7  PBO 16  21  7  PBO 17  19 11
PBO 19   6 16  PBO 21  10 16  PBO 22 -15  6
PBO 25   4 15  PBO 27  -9  9  PBO 29  27 10
PBO 30   1 17  PBO 32  12  8  PBO 35  20  8
PBO 37 -32  8  PBO 38  15  8  PBO 41   5 14
PBO 43  35 13  PBO 45  28  9  PBO 47   6 15
;

proc phreg data = hsv;
   class vac(ref="PBO") / param = ref;
   model wks*cens(1) = vac x / ties = exact; 
   title1 "Cox Proportional Hazards Model";
   title2 "Example 22.1: HSV-2 Episodes with gD2 Vaccine - cont'd." ;
run;

/****************************************************************************/
/* Example 22.2                                                             */ 
/****************************************************************************/
options ls=80;

data vitclear; 
    input pat age rsptim trt $ center $ dens inftim @@; 
    cens   = (rsptim ge 0);                
    rsptim = abs(rsptim); 
    /* rsptim = time (wks) from randomization to response 
              (RSPTIM is censored if negative)           */ 
    /* trt    = HYA for Hyalurise, TRT = SAL for Saline      */ 
    /* center = study center (A, B, or C)                */ 
    /* dens   = 3, 4 for Grade 3 or 4, respectively      */ 
    /* inftim = time (wks) from randomization to onset of 
               infection or other complications          */ 
    datalines; 
101 72  32 HYA A 3  .   102 55  20 HYA A 4 10   103 80 -52 SAL A 3  . 
104 46   4 SAL A 4  .   105 72  24 HYA A 4 52   106 77  41 HYA A 3  . 
107 68  32 SAL A 4 12   108 77  32 HYA A 4  .   109 66  25 SAL A 3  . 
110 59 -10 HYA A 3  .   111 64   8 SAL A 3  .   112 68  32 HYA A 4  . 
113 65 -52 SAL A 4 38   114 82  45 HYA A 3 36   115 59 -14 SAL A 4  . 
116 49   6 HYA A 3  .   117 69 -52 HYA A 4  .   118 61   9 SAL A 4 28 
119 54  13 HYA A 3  .   120 69  36 SAL A 4  .   121 72   6 HYA A 4  . 
122 68 -42 SAL A 4  .   123 77  44 HYA A 3 28   124 67 -52 SAL A 3  . 
125 72  23 HYA A 4  .   126 59  30 HYA A 3  .   127 61  16 SAL A 3  . 
128 58   2 HYA A 3  .   129 61  21 SAL A 3  6   130 60  26 HYA A 4  . 
131 60   8 SAL A 3  .   132 72  46 HYA A 4 18   133 75  21 HYA A 4  . 
134 65  14 HYA A 3  .   135 73 -52 SAL A 3  .   136 72 -24 HYA A 3  . 
137 78 -22 SAL A 3  .   138 66 -35 SAL A 3  .   139 48  19 HYA A 3  . 
140 59  24 HYA A 4 20   141 69  31 HYA A 3 12   142 52  28 SAL A 4  . 
143 67 -52 SAL A 4 34   144 71 -52 HYA A 3  .   145 59  35 SAL A 3  . 
146 80  40 HYA A 4  .   147 43   4 SAL A 3  .   148 71   7 HYA A 4 24 
149 46  -2 SAL A 4  .   150 49  16 HYA A 4  .   151 69  36 HYA A 3  4 
152 54  12 SAL A 3  .   153 58  28 HYA A 3  .   154 77  48 SAL A 3 42 
155 66 -38 HYA A 3  .   156 51   9 HYA A 3  .   157 60  11 SAL A 3  . 
158 76  20 SAL A 4  .   159 63  30 HYA A 4  .   160 50   6 HYA A 4  . 
201 61 -15 SAL B 3  .   202 52  -4 HYA B 3  .   203 53  10 HYA B 4  . 
204 57  10 SAL B 4  .   205 57   8 SAL B 3  .   206 58  11 HYA B 3  . 
207 67 -52 HYA B 4  .   208 61  12 HYA B 3  .   209 67  20 SAL B 3  . 
210 77  46 HYA B 4  .   211 72  32 SAL B 4 44   212 61  10 HYA B 3  . 
213 71  42 SAL B 3  .   214 78  31 HYA B 4 20   215 62   4 HYA B 4  . 
216 67 -24 SAL B 3  .   217 67  20 HYA B 3 33   218 53  16 SAL B 3  . 
219 57   2 HYA B 3  .   220 68  25 HYA B 4  .   221 68  11 SAL B 4  . 
222 75 -52 SAL B 4  .   223 62  20 HYA B 4  .   224 63   9 HYA B 3  . 
225 74  22 HYA B 3  .   226 55  23 HYA B 3  .   227 47  11 SAL B 3  . 
228 71  13 HYA B 3  .   229 51  -7 SAL B 4  .   230 59   8 HYA B 4  . 
231 69  37 HYA B 4  .   232 54  32 SAL B 4 26   233 77  24 HYA B 3 10 
234 70 -52 HYA B 4  .   235 76  20 SAL B 4  .   236 82  34 SAL B 4  . 
237 55  27 HYA B 3  .   301 48  10 HYA C 3  .   302 74 -10 SAL C 4  8 
303 75  32 HYA C 4  .   304 65  14 HYA C 4 20   305 71  24 SAL C 3  . 
306 64  14 HYA C 4  .   307 71  36 SAL C 3  .   308 69 -52 SAL C 3  . 
309 67   7 HYA C 3  .   310 62   6 SAL C 4  .   311 65   5 HYA C 3  . 
312 63   9 HYA C 3  .   313 66  12 HYA C 4  .   314 59  21 SAL C 3  . 
315 69  10 HYA C 3  .   316 57  26 SAL C 4 36   317 80 -52 HYA C 4  . 
318 52  10 HYA C 3  .   319 64  27 SAL C 4 12   320 70   5 HYA C 3  . 
321 88  34 HYA C 3 16   322 52  14 SAL C 4  .   323 69   6 HYA C 3  . 
324 47  22 HYA C 4  .   325 77  45 SAL C 4 12   326 67  16 SAL C 3  . 
327 59  15 HYA C 3 30   328 73  33 SAL C 4 22   329 64  20 HYA C 3  . 
330 79 -52 HYA C 3 30   331 50   5 SAL C 4  .   332 57  10 HYA C 3  . 
333 62  16 SAL C 3  .   334 60  -2 HYA C 4  .   335 59  17 SAL C 4  . 
336 56  16 SAL C 4  .   337 63  16 HYA C 3  .   338 54  33 HYA C 3 20 
339 63  24 SAL C 3 11   340 55  12 HYA C 3  .   341 63  27 HYA C 4 18 
342 60   2 HYA C 4  .   343 49  -6 SAL C 4  .   344 66 -20 HYA C 4  . 
345 58  14 SAL C 3  .   346 59   3 HYA C 3  .              
; 
  
proc phreg data = vitclear;
   class trt(ref="SAL") center(ref="C") / param = ref; 
   model rsptim*cens(0) = trt center age dens infctn / ties = exact;    
   if inftim gt rsptim or inftim = . then infctn = 0;      
        else infctn = 1; 
   title1 'Cox Proportional Hazards Model'; 
   title2 'Example 22.2: Hyalurise in Vitreous Hemorrhage' ; 
run;  
 
/*************** END CHAPTER 22 *********************************************/


/*************** START APPENDIX C *******************************************/
 
** Example C.1;
 
** (note: the SAS code is not included in the book -- the code below was
          used to generate ANOVA tables for Appendix C )**; 
data bwt;
input treat $ sex $ wt  @@;
datalines;
A F 110  A F 101  A F 124  A F 120  A F 111
A F 117  A F 120  A F 131  A M 185  A M 181
A M 173  A M 190  A M 181  A M 202  A M 175
B F 121  B F 116  B F 144  B F 125  B F 115
B F 118  B F 127  B M 205  B M 193  B M 196
B M 189  B M 180  B M 193  B M 210  B M 189
B M 179
;
run;
 
proc glm data = bwt;
    class treat;
    model wt = treat / ss3;
title 'Example C.1 (Table C.2)';
run;
 
proc glm data = bwt;
    classes treat sex;
    model wt = treat sex / ss3;
title 'Example C.1 (Table C.3)';
run;
 
proc glm data = bwt;
    classes treat sex;
    model wt = treat sex treat*sex / ss3;
title 'Example C.1 (Table C.5)';
run;

/*************** END APPENDIX C *********************************************/

 
/*************** START APPENDIX E *******************************************/
 
*** Example E.1;
 
options ls=85 ps=55;
data mc;
    input trt $ y @@;
    datalines;
A 21  A 13  A 25  A 18  A 17  A 23  A 16  A 12  B 27  B 28 
B 31  B 24  B 20  B 19  B 18  B 24  B 27  B 29  C 25  C 19 
C 22  C 24  C 34  C 26  C 29  C 28  C 32  D 23  D 18  D 22
D 19  D 24  D 14  D 20  D 29  E 14  E 17  E 21  E 20  E 13
E 23  E 27  E 12  E 16
;

proc glm data = mc;
    class trt;
    model y = trt / ss3;
    lsmeans trt / pdiff adjust=t;
title1 'EXAMPLE E.1: Multiple Comparisons';
title2 'All-Pairwise Comparisons of Means';
run;
quit;

 
/* Output E.4 */
proc multtest bonferroni sidak holm hoc 
    noprint out=newmc data=mc;    
    class trt;             
    test mean(y);       
        contrast 'A v B' -1  1  0  0  0;
        contrast 'A v C' -1  0  1  0  0;
        contrast 'A v D' -1  0  0  1  0;
        contrast 'A v E' -1  0  0  0  1;
        contrast 'B v C'  0 -1  1  0  0;
        contrast 'B v D'  0 -1  0  1  0;
        contrast 'B v E'  0 -1  0  0  1;
        contrast 'C v D'  0  0 -1  1  0;
        contrast 'C v E'  0  0 -1  0  1;
        contrast 'D v E'  0  0  0 -1  1;
run;

proc print data=newmc;
    title1 'EXAMPLE E.1: Multiple Comparisons';
    title2 'p-Value Adjustment Procedures';
run;

 
/* Output E.5 */
data adjst;
    input test raw_p @@;
    datalines;
1 0.0004  2 0.0006  3 0.0039  4 0.0051  5 0.0216
6 0.1147  7 0.1919  8 0.2066  9 0.3926 10 0.9951
;

proc multtest bonferroni sidak holm hoc pdata = adjst;
    title 'DATA SET ADJST';
run;
 
 
** Example E.2;
 ata rr;
    input trt $ resp count @@;
    /* resp=0 is “non-response”, resp=1 is “response” */
    datalines;
A 0 24   A 1  9    B 0 17   B 1 14
C 0 11   C 1 23    D 0 25   D 1 10
E 0 30   E 1  5
;

ods select
    Multtest.pValues;
proc multtest order = data permutation 
    nsample=20000 seed=28375 data = rr;  
/* (prespecify the seed value so results can be duplicated) */
    class trt;
    test fisher(resp); 
    freq count;
        contrast 'A vs B' -1  1  0  0  0;
        contrast 'A vs C' -1  0  1  0  0;
        contrast 'A vs D' -1  0  0  1  0;
        contrast 'A vs E' -1  0  0  0  1;
        contrast 'B vs C'  0 -1  1  0  0;
        contrast 'B vs D'  0 -1  0  1  0;
        contrast 'B vs E'  0 -1  0  0  1;
        contrast 'C vs D'  0  0 -1  1  0;
        contrast 'C vs E'  0  0 -1  0  1;
        contrast 'D vs E'  0  0  0 -1  1;
    title1 'EXAMPLE E.2: Multiple Comparisons of Proportions';
    title2 'Permutation Resampling Method';
run;


data binp;
    input test raw_p @@;
    datalines;
1 0.1932   2 0.0014   3 1.0000   4 0.2365   5 0.0831
6 0.2038   7 0.0072   8 0.0017   9 0.0001  10 0.2436
;
 
proc multtest bonferroni sidak holm hoc pdata = binp;
run;

/*************** END APPENDIX E *********************************************/

 
/*************** START APPENDIX G *******************************************/

libname examp 'c:\bookfiles\examples\sas';
options nodate nonumber ls=85 ps=55;

*======================================================*
|   STATISTICAL ANALYSES for Response Variable = "score"| 
|      (continuous numeric response variable)           |
*=======================================================* ;

/* ANALYSIS #1: Two-Sample t-Test */
proc ttest data = examp.trial;
    class trt;
    var score;
    title 'ANALYSIS #1: Two-Sample t-Test';
run;


/* ANALYSIS #2: Wilcoxon Rank-Sum Test */
proc npar1way wilcoxon data = examp.trial;
    class trt;
    var score;
    title 'ANALYSIS #2: Wilcoxon Rank-Sum Test';
run;


/* ANALYSIS #3: One-Way ANOVA */
proc glm data = examp.trial;
    class trt;
    model score = trt;
        means trt;
    title 'ANALYSIS #3: One-Way ANOVA';
run;


 
/* ANALYSIS #4: Two-Way ANOVA with Interaction */
proc glm data = examp.trial;
    class trt center;
    model score = trt center trt*center;
        lsmeans trt / stderr pdiff;
    title 'ANALYSIS #4: Two-Way ANOVA With Interaction';
run;
quit;


/* ANALYSIS #5: Two-Way ANOVA without Interaction */
proc glm data = examp.trial;
    class trt center;
        model score = trt center;
    title 'ANALYSIS #5: Two-Way ANOVA Omitting Interaction';
run;
quit;


/* ANALYSIS #6: Three-Way ANOVA, with All Interactions */
proc glm data = examp.trial;
    class trt center sex;
    model score = trt | center | sex;
        lsmeans trt / stderr pdiff;
    title 'ANALYSIS #6: Three-Way ANOVA - all Interactions';
run;
quit;


/* ANALYSIS #7: Three-Way Main Effects ANOVA */
proc glm data = examp.trial;
    class trt center sex;
        model score = trt center sex;
    title 'ANALYSIS #7: Three-Way Main Effects ANOVA';
run;
quit;


/* ANALYSIS #8: Regression of Score on Age */
ods graphics on;  
/* score by age plot found in “fitplot” ods graph*/
proc glm data = examp.trial;
    model score = age / solution;
    title 'Linear Regression of Score on Age';
run;
quit;
ods graphics off;


/* ANALYSIS #9: Analysis of Covariance - Test for Equal Slopes */
proc glm data = examp.trial;
    class trt;
    model score = trt age trt*age;
    /* use interaction to check for equal slopes */
    title1 'ANALYSIS #9: ANCOVA Using Age as Covariate,';
    title2 'Test for Equal Slopes';
run;
quit;
 
/* ANALYSIS #10: Analysis of Covariance - Assuming Equal Slopes */
ods graphics on;
/* plot of score by age for each treatment 
   found in “ancovaplot” ODS graph*/
proc glm data = examp.trial;
    class trt;
    model score = trt age / solution;
        lsmeans trt / stderr pdiff;
    title 'ANALYSIS #10: ANCOVA Using Age as Covariate';
run;
quit;
ods graphics off;


/* ANALYSIS #11: Stratified ANCOVA */
proc glm data = examp.trial;
    class trt center;
    model score = trt center age / solution;
    title1 'ANALYSIS #11: ANCOVA -- using Age as covariate,';
    title2 'Stratified by Center';
run;
quit;


*=======================================================*
|   STATISTICAL ANALYSES for Response Variable = "resp" | 
|             (dichotomous response variable)           |
*=======================================================*  ;

/* format used in ANALYSES 12-14 */
proc format;
    value rspfmt 0 = 'NO ' 1 = 'YES';
run;


/* ANALYSES #12 and #13: Chi-Square and Fishers Exact Test
                         -- Dichotomous Response */
proc freq data = examp.trial;
    tables trt*resp / chisq nocol nopct;
    format resp rspfmt.;
    title1 'ANALYSIS #12:  Chi-Square Test';
    title2 'ANALYSIS #13:  Fishers Exact Test';
run;


/* ANALYSIS #14: Stratified CMH Test for Response Rate Analysis */
proc freq data = examp.trial;
    tables center*trt*resp / cmh nocol nopct;
    format resp rspfmt.;
    title 'ANALYSIS #14: CMH Test Controlling for Center';
run;


 
/* ANALYSIS #15: Logistic Regression - Dichotomous Response */
proc logistic data = examp.trial;
    class trt / param = ref;
    model resp = trt;
    title1 'ANALYSIS #15: Logistic Regression Analysis for';
    title2 'Treatment Group Differences Using Dichotomized Response';
run;


/* ANALYSIS #16: Logistic Regression - Dichotomous Response, 
                 Adjusted for Age  */
proc logistic data = examp.trial;
    class trt / param = ref;
    model resp = trt age;
    title1 'ANALYSIS #16: Logistic Regression Analysis for';
    title2 'Treatment Group Differences Using Dichotomized Response';
    title3 'Adjusted for Age';
run;


/* ANALYSIS #17: Logistic Regression - Dichotomous Response, 
                 Adjusted for Age, Sex, Center  */
proc logistic data = examp.trial;
    class trt sex center / param = ref;
    model resp = trt age sex center trt*center;
    title1 'ANALYSIS #17: Logistic Regression Analysis for';
    title2 'Treatment Group Differences Using Dichotomized Response';
    title3 'Adjusted for Age, Sex, Center & Interactions';
run;


*=======================================================*
|   STATISTICAL ANALYSES for Response Variable = "sev"  | 
|         (ordinal categorical response variable)       |
*=======================================================*   ;

/* Obtain Severity Distributions based on the Response = "sev" */

/* formats used for ANALYSES 18, 19, 20, 21, 23, and 24 */
proc format;
  value sev1fmt  0 = '0 = None'      1 = '1 = Mild'
                 2 = '2 = Mod '      3 = '3 = Sev '     ;

  value sev2fmt  0 = '0 = None    '  1 = '1.036 = Mild'
                 2 = '2.185 = Mod '  3 = '3 = Sev     ' ;

  value sev3fmt  0 = 'None'          1 = 'Mild'
                 2 = 'Mod.'          3 = 'Sev.'         ;
run;


/* ANALYSES #18 and #19: Chi-Square / Fishers Exact Test -- 
                         Multinomial Response */
proc freq data = examp.trial;
    tables trt*sev / chisq exact nocol nopct;
    format sev sev1fmt.;
    title1 'ANALYSIS #18: Chi-Square Test';
    title2 'ANALYSIS #19: Generalized Fishers Exact Test';
run;


/* ANALYSIS #20: CMH Test for Comparing Severity Distributions - 
                 Using Table Scores */
proc freq data = examp.trial;
    tables trt*sev / cmh nocol nopct;
    format sev sev1fmt.;
    title1 'ANALYSIS #20: Mantel-Haenszel Test on Severity';
    title2 '(Using Table Scores)';
run;


/* ANALYSIS #21: CMH Test for Comparing Severity Distributions
                 - Using Modified Ridit Scores */
proc freq data = examp.trial;
    tables trt*sev / cmh scores = modridit nocol nopct;
    format sev sev2fmt.;
    title1 'ANALYSIS #21: Mantel-Haenszel Test on Severity';
    title2 '(Using Modified Ridit Scores)';
run;


/* ANALYSES #22: Wilcoxon Rank-Sum Test on Response = "SEV" */
proc npar1way wilcoxon data = examp.trial;
    class trt;
    var sev;
    title 'ANALYSIS #22: Wilcoxon Rank-Sum Test on "SEV" Response';
run;


/* ANALYSIS #23: Stratified CMH Test for Comparing Severity 
                 Distributions - Using Table Scores */
proc freq data = examp.trial;
    tables center*trt*sev / cmh nocol nopct;
    format sev sev3fmt.;
    title1 'ANALYSIS #23: CMH Test on Severity Distributions';
    title2 '(Using Table Scores), Controlling for Center';
run;


/* ANALYSIS #24: Stratified CMH Test for Comparing Severity
                 Distributions - Using Modified Ridit Scores */
proc freq data = examp.trial;
    tables center*trt*sev / cmh scores = modridit nocol nopct;
    format sev sev3fmt.;
    title1 'ANALYSIS #24: CMH Test on Severity Distributions';
    title2 '(Using Modified Ridit Scores), Controlling for Center';
run;


 
/* ANALYSIS #25: Logistic Regression: Proportional Odds Model */
proc logistic data = examp.trial;
    class trt / param = ref;
    model sev = trt;
    title1 'ANALYSIS #25: Proportional Odds Model for Treatment';
    title2 'Differences Using Ordinal Response Categories';
run;


/* ANALYSIS #26: Logistic Regression: Proportional Odds Model, 
                 Adjusted for Age */
proc logistic data = examp.trial;
    class trt / param = ref;
    model sev = trt age;
    title1 'ANALYSIS #26: Proportional Odds Model for Treatment';
    title2 'Differences Using Ordinal Response Categories';
    title3 'Adjusted for Age';
run;


/* ANALYSIS #27: Logistic Regression: Proportional Odds Model,
                 Adjusted for Age, Sex, Center */
proc logistic data = examp.trial;
    class trt sex center;
    model sev = trt age sex center;
    title1 'ANALYSIS #27: Proportional Odds Model for Treatment';
    title2 'Group Differences Using Ordinal Response Categories';
    title3 'Adjusted for Age, Sex & Center';
run;

/*************** END APPENDIX G *********************************************/

 
/*************** START APPENDIX H *******************************************/

/****************************************************************************/
/* Example H.1                                                              */ 
/****************************************************************************/
title "Pocock's Approach with Five Analyses";
proc seqdesign boundaryscale=pvalue;
  TwoSidedPocock: design method=poc nstages=5 alt=twosided stop=reject;
  ods output boundary=bv; 
run; 
 
data bv; 
   set bv; 
   reduced_alpha=2*bound_la; 
run;

proc print data=bv label; 
var bound_la bound_ua reduced_alpha;
label bound_la      = "Boundary Lower Alpha"
      bound_ua      = "Boundary Upper Alpha"
      reduced_alpha = "Pocock Reduced Alpha";
run;

/****************************************************************************/
/* Example H.2                                                              */ 
/****************************************************************************/
title "O'Brien-Fleming Approach with Five Analyses";
proc seqdesign boundaryscale=pvalue;
  TwoSidedOBrienFleming: design method=obf nstages=5 alt=twosided stop=reject;
  ods output boundary=bv; 
run; 
 
data bv; 
   set bv; 
   reduced_alpha=2*bound_la; 
run;

proc print data=bv label; 
var bound_la bound_ua reduced_alpha;
label bound_la      = "Boundary Lower Alpha"
      bound_ua      = "Boundary Upper Alpha"
      reduced_alpha = "O'Brien-Fleming Reduced Alpha";
run;

/****************************************************************************/
/* Example H.3                                                              */ 
/****************************************************************************/
title  "Cumulative Lan-DeMets Alpha Spending Function for the";
title2 "O'Brien-Fleming Spending Function, Two-Tailed Test at Alpha=0.05";
proc seqdesign  errspend boundaryscale=pvalue; 
     TwoSidedErrorSpending:  design method=errfuncobf 
                             nstages=14  alpha=0.05 
                             alt=twosided  stop=reject 
                             info=cum(0.1 0.2 0.25 0.3 0.333 0.4 0.5 0.6 0.667 0.7 0.75 0.8 0.9 1.0) 
                             ; 
     ods output errspend=es; 
run; 
 
data es; 
   set es; 
   cumulative_alpha = alpha_l + alpha_u; 
run; 

proc print data=es label; 
var alpha_l alpha_u cumulative_alpha;
label alpha_l = "Cumulative Alpha Lower"
      alpha_u = "Cumulative Alpha Upper"
      cumulative_alpha = "Cumulative Alpha";
run; 

/****************************************************************************/
/* Example H.4                                                              */ 
/****************************************************************************/
title "Lan-Demets Alpha Using O'Brien-Fleming Spending Function";

proc seqdesign boundaryscale=pvalue; 
     TwoSidedErrorSpending: design 
                            method=errfuncobf 
                            nstages=5 
                            alt=twosided 
                            stop=reject 
                            alpha=0.05 
                            ; 
     ods output boundary=bv; 
run; 
 

data bv; set bv; 
   reduced_alpha=2*bound_la; 
run;

proc print data=bv label; 
var bound_la bound_ua reduced_alpha;
label bound_la      = "Boundary Lower Alpha"
      bound_ua      = "Boundary Upper Alpha"
      reduced_alpha = "Lan-DeMets Reduced Alpha";
run;

/*************** END APPENDIX H *********************************************/

