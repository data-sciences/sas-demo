/*------------------------------------------------------------------- */
 /* Multivariate Data Reduction and Discrimination with SAS Software  */
 /*          by Ravindra Khattree and Dayanand N. Naik                */
 /*       Copyright(c) 2000 by SAS Institute Inc., Cary, NC, USA      */
 /*                   SAS Publications order # 56902                  */
 /*                        ISBN 1-58025-696-1                         */
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
 /* Date Last Updated: 27Jun00                                        */
 /*-------------------------------------------------------------------*/
 /* Questions or problem reports concerning this material may be      */
 /* addressed to the author:                                          */
 /*                                                                   */
 /* SAS Institute Inc.                                                */
 /* Books by Users                                                    */
 /* Attn: Ravindra Khattree and Dayanand Naik                         */
 /* SAS Campus Drive                                                  */
 /* Cary, NC   27513                                                  */
 /*                                                                   */
 /*                                                                   */
 /* If you prefer, you can send email to:  sasbbu@sas.com             */
 /* Use this for subject field:                                       */
 /*     Comments for Ravindra Khattree and Dayanand Naik              */
 /*                                                                   */
 /*-------------------------------------------------------------------*/




CHAPTER 2 (Principal Component Analysis) Programs and Data Sets:

/* Program 2.1 */

title1 "Output 2.1";
options ls=64 ps=45 nodate nonumber;

data score (type=corr);
_type_='corr';
input _name_ $ readsp readpow mathsp mathpow;
datalines;
readsp 1. .698 .264 .081
readpow .698 1. -.061 .092
mathsp .264 -.061 1. .594
mathpow .081 .092 .594 1.
;
/* Source: Hotelling (1933).  Reprinted by permission of
the American Psychological Association. */

title2 "Population Principal Components";
proc princomp data=score (type=corr);
run;      


/* Program 2.2 */

options ls=64 ps=45 nodate nonumber;
title1 "Output 2.2";
data track;
infile 'womentrack.dat' firstobs=3;
input m100 m200 m400 m800 m1500 m3000 marathon country$;
run;

proc princomp data=track out=pctrack;
var m100 m200 m400 m800 m1500 m3000 marathon;
title2 'PCA of National Track Data: Time';
run;

proc sort data=pctrack;
by prin1;
proc print;
id country;
var prin1;
title2 'Rankings by the First Principal Component: Time';
run;

data labels;
set pctrack;
retain xsys '2' ysys '2';
length text $12 function $8;
text=country;
y=prin2;
x=prin1;
size=1.2;
position='8';
function = 'LABEL';
run;
filename gsasfile "prog22a.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
title1 h=1.2 'Plots of the First Two Principal Components of Time';
title2 j=l 'Output 2.2';
proc gplot data=pctrack;
plot prin2*prin1/annotate=labels;
label prin1='First PC'
      prin2='Second PC';
symbol v=star;
run;

data track;
set track;
title1 'Output 2.2';
title2 'Speeds for the Track Events (Women)';
m800=m800*60;
m1500=m1500*60;
m3000=m3000*60;
marathon=marathon*60;
x1=100/m100;
x2=200/m200;
x3=400/m400;
x4=800/m800;
x5=1500/m1500;
x6=3000/m3000;
x7=42195/marathon;
run;

data speed;
set track;
keep country x1-x7;
proc print data=speed noobs label;
var country x1-x7;
format x1-x7 6.2;
label x1='100m'
x2='200m'
x3='400m'
x4='800m'
x5='1,500m'
x6='3,000m'
x7='marathon';
run;

proc princomp data=track cov out=pctrack;
var x1-x7;
title2 'PCA of National Track Data: Speeds';
run;

proc sort;
by prin1;
run;
proc print;
id country;
var prin1;
title2 'Rankings by the First Principal Component: Speed';
run;

data labels;
set pctrack;
retain xsys '2' ysys '2';
length text $12 function $8;
text=country;
y=prin2;
x=prin1;
size=1.2;
position='8';
function = 'LABEL';
run;
filename gsasfile "prog22b.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
title1 h=1.2 'Plots of the First Two Principal Components of Speed';
title2 j=l 'Output 2.2';
proc gplot data=pctrack;
plot prin2*prin1/annotate=labels;
label prin1='First PC'
      prin2='Second PC';
symbol v=star;
run;


/*WOMEN TRACK DATA SET: womentrack.dat*/

    11.61    22.94    54.50    2.15    4.43     9.79    178.52    Argentina
    11.20    22.35    51.08    1.98    4.13     9.08    152.37    Australia
    11.43    23.09    50.62    1.99    4.22     9.34    159.37    Austria
    11.41    23.04    52.00    2.00    4.14     8.88    157.85    Belgium
    11.46    23.05    53.30    2.16    4.58     9.81    169.98    Bermuda
    11.31    23.17    52.80    2.10    4.49     9.77    168.75    Brazil
    12.14    24.47    55.00    2.18    4.45     9.51    191.02    Burma
    11.00    22.25    50.06    2.00    4.06     8.81    149.45    Canada
    12.00    24.52    54.90    2.05    4.23     9.37    171.38    Chile
    11.95    24.41    54.97    2.08    4.33     9.31    168.48    China
    11.60    24.00    53.26    2.11    4.35     9.46    165.42    Columbia
    12.90    27.10    60.40    2.30    4.84    11.10    233.22    Cookis
    11.96    24.60    58.25    2.21    4.68    10.43    171.80    Costa
    11.09    21.97    47.99    1.89    4.14     8.92    158.85    Czech
    11.42    23.52    53.60    2.03    4.18     8.71    151.75    Denmark
    11.79    24.05    56.05    2.24    4.74     9.89    203.88    Dominican
    11.13    22.39    50.14    2.03    4.10     8.92    154.23    Finland
    11.15    22.59    51.73    2.00    4.14     8.98    155.27    France
    10.81    21.71    48.16    1.93    3.96     8.75    157.68    GDR
    11.01    22.39    49.75    1.95    4.03     8.59    148.53    FRG
    11.00    22.13    50.46    1.98    4.03     8.62    149.72    GB&NI
    11.79    24.08    54.93    2.07    4.35     9.87    182.20    Greece
    11.84    24.54    56.09    2.28    4.86    10.54    215.08    Guatemal
    11.45    23.06    51.50    2.01    4.14     8.98    156.37    Hungary
    11.95    24.28    53.60    2.10    4.32     9.98    188.03    India
    11.85    24.24    55.34    2.22    4.61    10.02    201.28    Indonesia
    11.43    23.51    53.24    2.05    4.11     8.89    149.38    Ireland
    11.45    23.57    54.90    2.10    4.25     9.37    160.48    Israel
    11.29    23.00    52.01    1.96    3.98     8.63    151.82    Italy
    11.73    24.00    53.73    2.09    4.35     9.20    150.50    Japan
    11.73    23.88    52.70    2.00    4.15     9.20    181.05    Kenya
    11.96    24.49    55.70    2.15    4.42     9.62    164.65    Korea
    12.25    25.78    51.20    1.97    4.25     9.35    179.17    DPRKorea
    12.03    24.96    56.10    2.07    4.38     9.64    174.68    Luxembou
    12.23    24.21    55.09    2.19    4.69    10.46    182.17    Malasiya
    11.76    25.08    58.10    2.27    4.79    10.90    261.13    Mauritius
    11.89    23.62    53.76    2.04    4.25     9.59    158.53    Mexico
    11.25    22.81    52.38    1.99    4.06     9.01    152.48    Netherlands
    11.55    23.13    51.60    2.02    4.18     8.76    145.48    NZealand
    11.58    23.31    53.12    2.03    4.01     8.53    145.48    Norway
    12.25    25.07    56.96    2.24    4.84    10.69    233.00    Guinea
    11.76    23.54    54.60    2.19    4.60    10.16    200.37    Philippi
    11.13    22.21    49.29    1.95    3.99     8.97    160.82    Poland
    11.81    24.22    54.30    2.09    4.16     8.84    151.20    Portugal
    11.44    23.46    51.20    1.92    3.96     8.53    165.45    Rumania
    12.30    25.00    55.08    2.12    4.52     9.94    182.77    Singapore
    11.80    23.98    53.59    2.05    4.14     9.02    162.60    Spain
    11.16    22.82    51.79    2.02    4.12     8.84    154.48    Sweden
    11.45    23.31    53.11    2.02    4.07     8.77    153.42    Switzerl
    11.22    22.62    52.50    2.10    4.38     9.63    177.87    Taipei
    11.75    24.46    55.80    2.20    4.72    10.28    168.45    Thailand
    11.98    24.44    56.45    2.15    4.37     9.38    201.08    Turkey
    10.79    21.83    50.62    1.96    3.95     8.50    142.72    USA
    11.06    22.19    49.19    1.89    3.87     8.45    151.22    USSR
    12.74    25.85    58.73    2.33    5.81    13.04    306.00    WSamoa

    /* Source: IAAF/ATFS Track and Field Statistics Handbook for the 1984
       Los Angeles Olympics. Reproduced by permission of the International
       Amateur Athletics Federation. */


/*WOMEN TRACK DATA SET (SPEEDS): wtrack.dat*/

  Argentin     8.61     8.72     7.34     6.20     5.64     5.11      3.94
  Australi     8.93     8.95     7.83     6.73     6.05     5.51      4.62
  Austria      8.75     8.66     7.90     6.70     5.92     5.35      4.41
  Belgium      8.76     8.68     7.69     6.67     6.04     5.63      4.46
  Bermuda      8.73     8.68     7.50     6.17     5.46     5.10      4.14
  Brazil       8.84     8.63     7.58     6.35     5.57     5.12      4.17
  Burma        8.24     8.17     7.27     6.12     5.62     5.26      3.68
  Canada       9.09     8.99     7.99     6.67     6.16     5.68      4.71
  Chile        8.33     8.16     7.29     6.50     5.91     5.34      4.10
  China        8.37     8.19     7.28     6.41     5.77     5.37      4.17
  Columbia     8.62     8.33     7.51     6.32     5.75     5.29      4.25
  Cookis       7.75     7.38     6.62     5.80     5.17     4.50      3.02
  Costa        8.36     8.13     6.87     6.03     5.34     4.79      4.09
  Czech        9.02     9.10     8.34     7.05     6.04     5.61      4.43
  Denmark      8.76     8.50     7.46     6.57     5.98     5.74      4.63
  Dominica     8.48     8.32     7.14     5.95     5.27     5.06      3.45
  Finland      8.98     8.93     7.98     6.57     6.10     5.61      4.56
  France       8.97     8.85     7.73     6.67     6.04     5.57      4.53
  GDR          9.25     9.21     8.31     6.91     6.31     5.71      4.46
  FRG          9.08     8.93     8.04     6.84     6.20     5.82      4.73
  GB&NI        9.09     9.04     7.93     6.73     6.20     5.80      4.70
  Greece       8.48     8.31     7.28     6.44     5.75     5.07      3.86
  Guatemal     8.45     8.15     7.13     5.85     5.14     4.74      3.27
  Hungary      8.73     8.67     7.77     6.63     6.04     5.57      4.50
  India        8.37     8.24     7.46     6.35     5.79     5.01      3.74
  Indonesi     8.44     8.25     7.23     6.01     5.42     4.99      3.49
  Ireland      8.75     8.51     7.51     6.50     6.08     5.62      4.71
  Israel       8.73     8.49     7.29     6.35     5.88     5.34      4.38
  Italy        8.86     8.70     7.69     6.80     6.28     5.79      4.63
  Japan        8.53     8.33     7.44     6.38     5.75     5.43      4.67
  Kenya        8.53     8.38     7.59     6.67     6.02     5.43      3.88
  Korea        8.36     8.17     7.18     6.20     5.66     5.20      4.27
  DPRKorea     8.16     7.76     7.81     6.77     5.88     5.35      3.93
  Luxembou     8.31     8.01     7.13     6.44     5.71     5.19      4.03
  Malasiya     8.18     8.26     7.26     6.09     5.33     4.78      3.86
  Mauritiu     8.50     7.97     6.88     5.87     5.22     4.59      2.69
  Mexico       8.41     8.47     7.44     6.54     5.88     5.21      4.44
  Netherla     8.89     8.77     7.64     6.70     6.16     5.55      4.61
  NZealand     8.66     8.65     7.75     6.60     5.98     5.71      4.83
  Norway       8.64     8.58     7.53     6.57     6.23     5.86      4.83
  Guinea       8.16     7.98     7.02     5.95     5.17     4.68      3.02
  Philippi     8.50     8.50     7.33     6.09     5.43     4.92      3.51
  Poland       8.98     9.00     8.12     6.84     6.27     5.57      4.37
  Portugal     8.47     8.26     7.37     6.38     6.01     5.66      4.65
  Rumania      8.74     8.53     7.81     6.94     6.31     5.86      4.25
  Singapor     8.13     8.00     7.26     6.29     5.53     5.03      3.85
  Spain        8.47     8.34     7.46     6.50     6.04     5.54      4.33
  Sweden       8.96     8.76     7.72     6.60     6.07     5.66      4.55
  Switzerl     8.73     8.58     7.53     6.60     6.14     5.70      4.58
  Taipei       8.91     8.84     7.62     6.35     5.71     5.19      3.95
  Thailand     8.51     8.18     7.17     6.06     5.30     4.86      4.17
  Turkey       8.35     8.18     7.09     6.20     5.72     5.33      3.50
  USA          9.27     9.16     7.90     6.80     6.33     5.88      4.93
  USSR         9.04     9.01     8.13     7.05     6.46     5.92      4.65
  WSamoa       7.85     7.74     6.81     5.72     4.30     3.83      2.30


                  
 /* Program 2.3 */

options ls=64 ps=45 nodate nonumber;
title1 "Output 2.3";
data talent;
input x1-x6@@;
sub=_n_;
datalines;
82 47 13 14 12 29 94 40 10 15 12 32
76 33 9 12 9 25 99 46 18 20 15 51
79 38 14 18 11 39 85 42 12 17 12 32
82 32 10 18 8 31 81 43 8 10 11 34
92 38 11 14 11 35 81 32 5 14 13 30
92 41 17 17 11 27 86 43 5 11 11 42
92 43 12 15 12 37 92 43 16 19 12 39
78 25 10 15 7 23 97 45 10 16 11 49
76 27 8 10 13 17 99 39 9 17 11 44
96 44 18 15 10 43 83 33 7 15 11 27
89 43 18 17 10 42 104 47 8 13 14 47
84 36 18 16 8 18 85 41 15 19 12 41
86 44 14 20 12 37 94 40 13 15 6 23
99 44 17 20 10 32 71 23 1 5 9 15
89 33 7 16 11 24 106 48 18 13 12 37
;
/* Source: Cooley and Lohnes (1971). Courtesy of
John Wiley and Sons, Inc. */

proc princomp data=talent;
var x1-x6;
title2 ' PCA Using Correlation Matrix';
title3 ' Methods for Selection of Number of PCs ';
run;

proc factor data=talent scree;
var x1-x6;
*Scree diagram using FACTOR procedure;
run;

proc princomp data=talent cov;
var x1-x6;
title2 ' PCA Using Covariance Matrix';
title3 ' Methods for Selection of Number of PCs ';
run;

proc factor data=talent cov scree;
var x1-x6;
*Scree diagram using FACTOR procedure;
run; 


/* Program 2.4 */

options ls=64 ps=45 nodate nonumber;
title1 "Output 2.4";
data leghorn (type=corr);
infile cards missover;
_type_='corr';
if _n_=1 then _type_='N';
input _name_ $ sl sb hl ul fl tl;
cards;
N 276
sl 1.0
sb .584 1.0
hl .615 .576 1.0
ul .601 .530 .940 1.0
fl .570 .526 .875 .877 1.0
tl .600 .555 .878 .886 .924 1.0
;
/* Source: Wright (1954).  Reprinted by permission of
the Iowa State University Press. */

proc print;
title2 'Determination of Size and Shape Factors Using PCA';
proc princomp data=leghorn(type=corr);
run; 


/* Program 2.5 */

options ls=64 ps=45 nodate nonumber;
title1 "Output 2.5";
title2 'Dimension Reduction and Selection of Variables in PCA';
data adelges(type=corr);
infile cards missover;
_type_='corr';
if _n_=1 then _type_='N';
input length width forwing hinwing spirac antseg1-antseg5 antspin;
input tarsus3 tibia3 femur3 rostrum ovipos ovspin fold hooks;
cards;
40

1.0

.934 1.0

.927 .941 1.0

.909 .944 .933 1.0

.524 .487 .543 .499 1.0

.799 .821 .856 .833 .703 1.0

.854 .865 .886 .889 .719 .923 1.0

.789 .834 .846 .885 .253 .699 .751 1.0

.835 .863 .862 .850 .462 .752 .793 .745 1.0

.845 .878 .863 .881 .567 .836 .913 .787 .805 1.0

-.458 -.496 -.522 -.488 -.174 -.317 -.383 -.497 -.356 -.371 1.0

.917 .942 .940 .945 .516 .846 .907 .861 .848 .902 -.465
1.0
.939 .961 .956 .952 .494 .849 .914 .876 .877 .901 -.447
.981 1.0
.953 .954 .946 .949 .452 .823 .886 .878 .883 .891 -.439
.971 .991 1.0
.895 .899 .882 .908 .551 .831 .891 .794 .818 .848 -.405
.908 .920 .921 1.0
.691 .652 .694 .623 .815 .812 .855 .410 .620 .712 -.198
.725 .714 .676 .720 1.0
.327 .305 .356 .272 .746 .553 .567 .067 .300 .384 -.032
.396 .360 .298 .378 .781 1.0
-.676 -.712 -.667 -.736 -.233 -.504 -.502 -.758 -.666 -.629 .492
 -.657 -.655 -.687 -.633 -.186 .169 1.0
.702 .729 .746 .777 .285 .499 .592 .793 .671 .668 -.425
 .696 .724 .731 .694 .287 -.026 -.775 1.0
;
/* Source: Jeffers (1967).  Reprinted by permission of
the Royal Statistical Society. */

proc princomp data=adelges n=5;
var _numeric_;
run; 


/* Program 2.6 */

options ls=64 ps=45 nodate nonumber;
title1 "Output 2.6";
title2 'Minimal Reduction in Dimension Using PCA';
data drug(type=corr);
infile cards missover;
_type_='corr';
if _n_=1 then _type_='N';
input _name_ $ Cigars Beer Wine Liquor Cocaine Tranquil Drugstor
Heroin Marijuan Hashish Inhalent Hallucin Amphetam;
cards;
N 1634
Cigars 1.0
Beer .447 1.0
Wine .422 .619 1.0
Liquor .435 .604 .583 1.0
Cocaine .114 .068 .053 .115 1.0
Tranquil .203 .146 .139 .258 .349 1.0
Drugstor .091 .103 .110 .122 .209 .221 1.0
Heroin .082 .063 .066 .097 .321 .355 .201 1.0
Marijuan .513 .445 .365 .482 .186 .315 .150 .154 1.0
Hashish .304 .318 .240 .368 .303 .377 .163 .219 .534 1.0
Inhalent .245 .203 .183 .255 .272 .323 .310 .288 .301 .302 1.0
Hallucin .101 .088 .074 .139 .279 .367 .232 .320 .204 .368 .340 1.0
Amphetam .245 .199 .184 .293 .278 .545 .232 .314 .394 .467 .392 .511 1.0
;
/* Source: Huba, Wingard, and Bentler (1981).  Reprinted by permission of
the American Psychological Association. */

proc princomp data=drug;
var _numeric_;
run; 


/* Program 2.7 */

options ls=64 ps=45 nodate nonumber;
title1 "Output 2.7";
title2 'Determination of Typical Points';
data simond;
input x1-x5;
cards;
.12 .16 .36 .68 1.06
.11 .12 .29 .74 1.24
.14 .18 .40 .87 1.40
.12 .14 .33 .82 1.38
.16 .20 .46 1.00 1.62
.12 .14 .34 .90 1.52
.17 .22 .51 1.17 1.90
;
/* Source: Simonds (1963).  Reprinted by permission of
the Optical Society of America. */

proc princomp data=simond cov out=b;
var x1-x5;
run;

proc print data=b;
var prin1-prin5;
title3 'Principal Component Scores';
format prin1-prin5 7.4;
run; 


/* Program 2.8 */

options ls=64 ps=45 nodate nonumber;
title1 "Output 2.8";

data percent;
input x1-x8;
array x{8} x1-x8;
array u{8} u1-u8;
array v{8} v1-v8;
do i=1 to 8;
u{i}=log(x{i});
end;
ub=mean(of u1-u8);
do i=1 to 8;
v{i}=u{i}-ub;
end;
datalines;
51.64 16.25 10.41 7.44 10.53 2.77 .52 .44
54.33 16.06 9.49 6.70 8.98 2.87 1.04 .53
54.49 15.74 9.49 6.75 9.30 2.76 .98 .49
55.07 15.72 9.40 6.27 9.25 2.77 1.13 .40
55.33 15.74 9.40 6.34 8.94 2.61 1.13 .52
58.66 15.31 7.96 5.35 7.28 3.13 1.58 .72
59.81 14.97 7.76 5.09 7.02 2.94 1.97 .45
62.24 14.82 6.79 4.27 6.09 3.27 2.02 .51
64.94 14.11 5.78 3.45 5.15 3.36 2.66 .56
65.92 14.00 5.38 3.19 4.78 3.13 2.98 .61
67.30 13.94 4.99 2.55 4.22 3.22 3.26 .53
68.06 14.20 4.30 1.95 4.16 3.58 3.22 .53
72.23 13.13 3.26 1.02 2.22 3.37 4.16 .61
75.48 12.71 1.85 .37 1.10 3.58 4.59 .31
75.75 12.70 1.72 .40 .83 3.44 4.80 .37
;
/* Source: Miesch (1976).  Courtesy: U.S. Department
of Interior. */

proc princomp data=percent n=4;
var v1-v8;
title2 'PCA on the Transformed Variables';
run;


/* Program 2.9 */

options ls=64 ps=45 nodate nonumber;
title1 "Output 2.9";
title2 'Selection of Principal Components for Prediction';
data skull;
infile 'skull.dat';
input id c f lp l b bp h hp oh lb;
y=log(c);
x1=log(f); x2=log(lp); x3=log(l);
x4=log(b); x5=log(bp); x6=log(h);
x7=log(hp); x8=log(oh); x9=log(lb);

proc reg data=skull;
model y=x3 x4 x7/p;
title2 'Prediction Equation Obtained by Rao and Shaw (1948)';
run;

proc princomp data=skull prefix=pcx out=pc1x;
var x1-x9;
run;

data pc1;
set pc1x;
keep y pcx1-pcx9;
run;

data pc1;
set pc1;
proc reg;
model y=pcx1-pcx9/selection= rsquare cp;
title2 'Selection of Principal Components for Prediction';
run;

proc reg data=pc1;
title2 'Principal component regression to get PRESS';
model y=pcx1 pcx2 pcx3/p;
model y=pcx1 pcx3 pcx4/p;
model y=pcx1-pcx4/p;
model y=pcx1-pcx5/p;
model y=pcx1-pcx4 pcx8/p;
run; 


/* SKULL DATA SET: skull.dat */

2  1512.5   181.5  187   186.5  145    96     137   136.5 117    103
3  1619.5   192.5  197   195    145    99.5   137   135.5 110.5  108.5
4  1595.5   199    201   202    149.5  97     133   132   111.4  104.5
5  1602     188    195   193    142.5  97.5   137.5 137.5 117.5  104
6  1497.5   194.5  197   196    141.5  96     136   135   112    101.5
7  1492.5   190.5  192   191.5  144    105.5  137   134   118.5  102.5
8  1605.5   194    199   197    154    101.5  133.5 134   121    110
9  1697     191.5  191   192    148    101.5  128   128   110    97.5
10 1579     187    187   187.5  147    97     126.5 127   109.3  97.5
11 1500     176    177   176.5  140    101.5  129   127.5 111.5  91
13 1481     191.5  196.5 196.5  149    106.5  128.5 126   114    103
14 1432.5   181    183.5 183.5  141    95.5   140   139   114.5  104.5
15 1670.5   186.5  183   186.5  154.5  106    140.5 138.5 113.8  104.5
16 1476     187    187   188    142    94     132.5 132   110.5  97
17 1590.5   190.5  195   192.5  145    95     139.5 139.5 116.3  105.5
18 1725     194    199   198    146.5  100    139.5 137   116    104.5
19 1613     189    188.5 189.5  142    99     134   134   111    103
20 1524     193    196   195.5  146    101    123.5 122   111    98
21 1345     179    179   180    144    102    127   125.5 115.5  99.5
22 1557.5   195.5  188.5 189    146.5  102    128   127   115.7  99.5
23 1632.5   184    187   185    149    104    130.5 130   113    97.5
24 1406     185    188   187.5  141.5  95     128   127.5 110.4  98
25 1726.5   191    193   191.5  145.5  94     136.5 136   120.5  102.5
27 1477     198.5  202.5 201.5  136    97     131.5 130.5 106.3  103.5
28 1296.5   182.5  191   190    134.5  85.5   128.5 127.5 107.2  102
30 1385.5   182    192   190.5  138    93     129.5 127.5 103.5  104
31 1359     180.5  181   181    140    100.5  129   127.5 106    90.5
32 1600.5   190    193   193.5  143.5  96.5   129   129   111.5  97.5
33 1521.5   182    186.5 185    144.5  99.5   132   131   110.3  101.5
34 1411     186.5  193   192.5  135.5  90.5   129.5 130.5 112.4  100
35 1502.5   185    193.5 193    140.5  95     128.5 128.5 107    99
36 1314     184    189.5 188.5  130.5  93.5   134   132   112.4  103.5
37 1309     182.5  186   185    137.5  100.5  130.5 131   109.5  105
38 1627     194    200   197.5  142.5  103    138.5 138   115.3  103
40 1478.5   185.5  184.5 185.5  142.5  102    133   133.5 114.4  104
41 1470.5   184    187.5 187    146    105    126   124.5 108.3  104.5
42 1519     185.5  184.5 184    148    97     136   137   114.7   97
43 1398     179.5  183   183.5  148    96.5   132.5 131.5 109.5  100.5
44 1292.5   180.5  188   187    137.5  87.5   122.5 122   105.3  104.5
47 1524     185.5  186   186.5  144    87.5   128.5 128.5 107.5  100
48 1600.5   192.5  199   198    148    97     122.5 121.5 102    98
49 1501.5   180    185   183    139    90.5   138   138   111.5  101
52 1554.5   187    186.5 187.5  149    92.5   135   133.5 110.5  97.5
53 1476     185    189   190    143    98.5   125   126   106    99.5
58 1229     177.5  182   182    136.5  93.5   122   122.5 102.5  95.5
63 1425     186.5  184.5 186    137    95     132   132   108.5  93
64 1241.5   171.5  175   174.5  141.5  95     123.5 122.5 104.4  101.5
67 1561     187.5  190   190.5  146    94.5   128.5 127.5 114.4  102.5
69 1549.5   187    190.5 191    148.5  101.5  128.5 127.5 97.6   95.5
70 1376.5   189    189   190.5  131    101    122.5 123.5 107    98.5
71 1248     187    188   188.5  129    98     122.5 122.5 101.3  101.5
74 1418.5   178    181   181    140    92     130.5 130   107.5  100
77 1476     190    189   191    138.5  97     127.5 127.5 112.7  96
83 1387     179.5  185   183    134    91.5   132   131   107    97.5
84 1568.5   180.5  183   182    147    96     138.5 138.5 115.2  94.5
85 1458     182.5  184   185.5  135    90.5   132.5 131.5 106.3  102
87 1283.5   178.5  183   182    130    89.5   123.5 123   99.5   96.5
88 1403.5   181.5  183   183    135    101    128   127.5 111.5  97.5
91 1359     184.5  189   188    141.5  93     126   126   104.7  93
92 1395.5   171    175   176    138    85     125   123.5 104.3  89.5
93 1581.5   192    197   196.5  137.5  101    134   133.5 111.5  107.5
94 1565     189.5  191   190.5  146    98     134   133.5 111.5  102.5
95 1212.5   178    184   185.5  133.5  94     116.5 118.5 93.5   100

/* Source: Hooke (1926).  Reprinted with permission from Biometrika.*/



 /* Program 2.10 */

options ls=64 ps=45 nodate nonumber;
title1 "Output 2.10";

data hemato;
infile 'haemato.dat';
input haemo pcv wbc lympho neutro lead@@;
lgwbc=log(wbc);
lglympho=log(lympho);
lgneutro=log(neutro);

proc princomp data=hemato prefix=pc out=b1;
var haemo pcv lgwbc lglympho lgneutro lead;
title2 "PCA for Detection of Outliers Using Rao's Method";
run;

proc princomp data=hemato std prefix=spc out=b2 noprint;
var haemo pcv lgwbc lglympho lgneutro lead;
title2 "PCA for Detection of Outliers Using Hawkins' Method";
run;

data c;
set b1;
set b2;
disq=uss(of pc5-pc6);
hisq=uss(of spc5-spc6);
title2 'Computation of Outlier Detection Statistics';
run;

data outlier;
set c;
set hemato;
proc print;
var haemo pcv wbc lympho neutro lead disq hisq;
title2 ' Detection of Outliers Using the Distances';
run;


/* HAEMATO DATA SET: haemato.dat */

13.4 39 4100 14 25 17 14.6 46 5000 15 30 20 13.5 42 4500 19 21 18
15.0 46 4600 23 16 18 14.6 44 5100 17 31 19 14.0 44 4900 20 24 19
16.4 49 4300 21 17 18 14.8 44 4400 16 26 29 15.2 46 4100 27 13 27
15.5 48 8400 34 42 36 15.2 47 5600 26 27 22 16.9 50 5100 28 17 23
14.8 44 4700 24 20 23 16.2 45 5600 26 25 19 14.7 43 4000 23 13 17
14.7 42 3400  9 22 13 16.5 45 5400 18 32 17 15.4 45 6900 28 36 24
15.1 45 4600 17 29 17 14.2 46 4200 14 25 28 15.9 46 5200  8 34 16
16.0 47 4700 25 14 18 17.4 50 8600 37 39 17 14.3 43 5500 20 31 19
14.8 44 4200 15 24 19 14.9 43 4300  9 32 17 15.5 45 5200 16 30 20
14.5 43 3900 18 18 25 14.4 45 6000 17 37 23 14.6 44 4700 23 21 27
15.3 45 7900 43 23 23 14.9 45 3400 17 15 24 15.8 47 6000 23 32 21
14.4 44 7700 31 39 23 14.7 46 3700 11 23 23 14.8 43 5200 25 19 22
15.4 45 6000 30 25 18 16.2 50 8100 32 38 18 15.0 45 4900 17 26 24
15.1 47 6000 22 33 16 16.0 46 4600 20 22 22 15.3 48 5500 20 23 23
14.5 41 6200 20 36 21 14.2 41 4900 26 20 20 15.0 45 7200 40 25 25
14.2 46 5800 22 31 22 14.9 45 8400 61 17 17 16.2 48 3100 12 15 18
14.5 45 4000 20 18 20 16.4 49 6900 35 22 24 14.7 44 7800 38 34 16
17.0 52 6300 19 21 16 15.4 47 3400 12 19 18 13.8 40 4500 19 23 21
16.1 47 4600 17 28 20 14.6 45 4700 23 22 27 15.0 44 5800 14 39 21
16.2 47 4100 16 24 18 17.0 51 5700 26 29 20 14.0 44 4100 16 24 18
15.4 46 6200 32 25 16 15.6 46 4700 28 16 16 15.8 48 4500 24 20 23
13.2 38 5300 16 26 20 14.9 47 5000 22 25 15 14.9 47 3900 15 19 16
14.0 45 5200 23 25 17 16.1 47 4300 19 22 22 14.7 46 6800 35 25 18
14.8 45 8900 47 36 17 17.0 51 6300 42 19 15 15.2 45 4600 21 22 18
15.2 43 5600 25 28 17 13.8 41 6300 25 27 15 14.8 43 6400 36 24 18
16.1 47 5200 18 28 25 15.0 43 6300 22 34 17 16.2 46 6000 25 25 24
14.8 44 3900  9 25 14 17.2 44 4100 12 27 18 17.2 48 5000 25 19 25
14.6 43 5500 22 31 19 14.4 44 4300 20 20 15 15.4 48 5700 29 26 24
16.0 52 4100 21 15 22 15.0 45 5000 27 18 20 14.8 44 5700 29 23 23
15.4 43 3300 10 20 19 16.0 47 6100 32 23 26 14.8 43 5100 18 31 19
13.8 41 8100 52 24 17 14.7 43 5200 24 24 17 14.6 44 9899 69 28 18
13.6 42 6100 24 30 15 14.5 44 4800 14 29 15 14.3 39 5000 25 20 19
15.3 45 4000 19 19 16 16.4 49 6000 34 22 17 14.8 44 4500 22 18 25
16.6 48 4700 17 27 20 16.0 49 7000 36 28 18 15.5 46 6600 30 33 13
14.3 46 5700 26 20 21

/* Source: Royston (1983) (Health Survey on 103 Paint Sprayers:
variables are haemoglobin concentration, packed cell volume,
white blood cell count, lymphocyte count, neutrophil count,
and serum lead concentration).  Reprinted by permission of the
Royal Statistical Society.*/



/* Program 2.11 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 2.11';
data track;
infile 'wtrack.dat';
input country$ m100 m200 m400 m800 m1500 m3000 marathon;
%include biplot;
%biplot( data = track,  var = m100 m200 m400 m800 m1500
m3000 marathon, id = country, factype=JK, std =MEAN);
filename gsasfile "prog211a.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=.75in vorigin=2in;
goptions hsize=7in vsize=8in;
proc gplot data=biplot;
plot dim2 * dim1/anno=bianno frame
                 href=0 vref=0 lvref=3 lhref=3
                 vaxis=axis2 haxis=axis1
                 vminor=1 hminor=1;
axis1 length=6 in order=(-3.5 to 1.5 by .5)
        offset=(2)
label = (h=1.3 'Dimension 1');
axis2 length=6 in order =(-.7 to .72 by .2)
        offset=(2)
label=(h=1.3 a=90 r=0  'Dimension 2');
  symbol v=none;
title1 h=1.2 'Biplot of Speeds for Women Track Records Data';
title2 j=l 'Output 2.11';
title3 'The choice (c): FACTYPE=JK';
run;

%biplot( data = track,  var = m100 m200 m400 m800 m1500
m3000 marathon, id = country, factype=GH, std =MEAN);
filename gsasfile "prog211b.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=.75in vorigin=2in;
goptions hsize=7in vsize=8in;
proc gplot data=biplot;
plot dim2 * dim1/anno=bianno frame
                 href=0 vref=0 lvref=3 lhref=3
                 vaxis=axis2 haxis=axis1
                 vminor=1 hminor=1;
axis1 length=6 in order=(-.5 to 4 by .5)
        offset=(2)
        label = (h=1.3 'Dimension 1');
  axis2 length=6 in order =(-1.5 to 1.5 by .2)
        offset=(2)
        label=(h=1.3 a=90 r=0  'Dimension 2');
  symbol v=none;
title1 h=1.2 'Biplot of Speeds for Women Track Records Data';
title2 j=l 'Output 2.11';
title3 'The choice (b): FACTYPE=GH';
run;


CHAPTER 3 (Canonical Correlation Analysis) Programs and Data Sets:

/* Program 3.1 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 3.1';

data livestok;
infile 'livestock.dat' firstobs=5;
input year priceb priceh consumpb consumph ;

proc cancorr data = livestok  b int out = cscores  outstat = canstat
                vprefix =priscor wprefix =conscor ;

var priceb priceh;
with consumpb consumph ;
title2 'Canonical Correlation Analysis: Prices and Meat Consumption' ;

proc print data = cscores;
title2 'Canonical Scores';

proc print data = canstat;
title2 'Canonical Correlation Statistics';
run;  

/* LIVESTOCK DATA SET: livestock.dat */

1921 8.41 8.73 55.7 65.0
1922 8.68 9.26 59.2 65.9
1923 8.22 6.60 59.8 74.5
1924  8.24 7.23 59.9 74.7
1925  8.64 10.04 60.0 67.3
1926 7.63 9.95 60.7 64.6
1927  9.50 8.32 54.9 68.2
1928 11.41 7.56 49.0 71.3
1929 10.49 7.93 49.8 69.8
1930 9.84 8.51 48.9 67.0
1931 9.20 7.03 48.5 68.3
1932 10.58 6.05 46.7 70.6
1933 8.92 6.48 51.4 69.9
1934 9.52 6.55 55.8 64.2
1935 12.76 11.53 53.5 48.6
1936 9.47 10.62 58.8 55.6
1937 11.37 9.93 55.3 55.9
1938 10.10 8.70 54.5 58.3
1939 9.88 6.66 54.5 64.4
1940 9.91 5.42 55.2 72.5

/* Source: F. W. Waugh (1942) (Livestock Prices and Meat
Consumption: variables are year priceb priceh consumpb
consumph). Reprinted by permission of the Econometric
Society.*/


/* Program 3.2 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 3.2';

data wheat(type = corr);
_type_='corr' ;
input _name_  $ x1 x2 x3 x4 x5 y1 y2 y3 y4 ;
lines;
x1 1.0      .  .  .  .  .  .  .  .
x2  .75409 1.0  .  .  .  .  .  .  .
x3  -.69048 -.71235 1.0  .  .  .  .  .  .
x4  -.44578 -.51483 .32326 1.0  .  .  .  .  .
x5  .69173 .41184 -.44393 -.33439 1.0  .  .  .  .
y1  -.60463 -.72236 .73742 .52744 -.38310 1.0  .  .  .
y2  -.47881 -.41878 .36132 .46092 -.50494 .25056 1.0  .  .
y3  .77978 .54245 -.54624 -.39266 .73666 -.48993 -.43361 1.0  .
y4  -.15205 -.10236 .17224 -.01873 -.14848 .24955 -.07851 -.16276 1.0
;
/*
Data from  Waugh (1942),
Reprinted with  permission from The Econometric Society.
*/
title2 'Wheat and Flour Characteristics in Canadian Wheat';
proc cancorr data = wheat edf = 137 vprefix =flour wprefix =wheat ;
var y1 y2 y3 y4 ;
with x1 x2 x3 x4 x5  ;
run; 


/* Program 3.3 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 3.3';
data livestok;
infile 'livestock.dat' firstobs=5;
input year priceb priceh consumpb consumph;

proc reg data =  livestok;
model priceb priceh consumpb consumph = year;
output out = regout r = y1 y2 x1 x2 ;
title2 'Prices and Meat Consumption: Residuals';

proc cancorr data = regout edf = 18 vprefix =v wprefix =w ;
var y1 y2;
with x1 x2;

proc cancorr data = livestok  b int  outstat = canstat
                vprefix =priscor wprefix =conscor ;
partial year ;
var priceb priceh;
with consumpb consumph ;
title2 'Prices and Meat Consumption: Partialing Out Year' ;
run;


/* Program 3.4 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 3.4';

data family ;
input crowding $ father mother child1 child2 child3 ;
over =(crowding eq 'high');
ok =(crowding eq 'medium');
under =(crowding eq 'low');
lines;
high  5 7 6 25 19
high  11 8 11 33 35
high  3 12 19 6 21
high  3 19 12 17 17
high  10 9 15 11 17
high  9 0 6 9 5
medium  11 7 7 15 13
medium  10 5 8 13 17
medium  5 4 3 18 10
medium  1 9 4 16 8
medium  5 5 10 16 20
medium 7 3 13 17 18
low 6 3 5 7 3
low 9 6 6 14 10
low 2 2 6 15 8
low 0 2 10 16 21
low 3 2 0 3 14
low 6 2 4 7 20
;
/*
Data from Armitage (1971),
reprinted with  permission from Blackwell Science Ltd.
*/

title2 'No. of Swabs positive for Pneumococcus';
proc cancorr data = family  b int  outstat = stat
vprefix =chscore wprefix =pscore ;
partial over ok under ;
var child1 child2 child3;
with father mother ;
run; 


/* Program 3.5 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 3.5';

data rainfrst;
input x1 x2 x3 x4 x5 x6 y1 y2 y3 y4 y5 y6 ;
lines;
43 10 22 45 42 59 84 4 20 18 40 8
9 5 49 11 74 23 23 10 4 23 17 88
43 12 37 17 63 46 78 6 10 21 30 48
24 4 86 7 28 25 36 10 5 77 31 15
29 2 71 9 32 48 18 11 7 68 16 33
53 12 28 34 29 55 51 7 48 15 61 20
55 1 6 23 72 6 94 2 13 9 21 7
62 58 14 22 34 1 8 34 7 7 84 28
10 95 7 4 9 6 15 67 3 21 43 23
9 8 91 24 16 -11 6 6 2 87 1 -3
67 8 36 15 42 30 67 6 11 6 63 -4
62 6 20 23 69 0 40 15 8 14 69 2
10 94 4 2 1 2 6 93 3 -4 20 -7
2 97 -1 1 2 2 3 99 2 4 -4 4
64 6 20 37 50 30 40 11 46 5 73 1
67 11 30 20 57 -2 62 18 9 10 51 -4
90 21 8 18 11 -1 16 17 7 10 94 5
2 98 1 1 1 3 5 95 3 1 14 -1
33 8 20 81 39 14 14 7 96 6 18 5
25 2 8 96 9 2 8 0 99 1 9 -1
28 87 5 6 3 2 6 82 4 22 27 16
79 14 24 17 18 38 46 12 9 13 84 7
91 15 4 17 17 16 44 21 5 16 74 12
18 8 28 68 49 38 24 2 96 4 6 3
27 5 32 45 72 21 84 7 31 23 26 19
;
/*
Data from Gittins (1980, p 305),
printed with permission from Springer Verlag
*/

title2 'Redundancy Analysis: Rain Forest Data from Guyana';
proc cancorr data = rainfrst redundancy
vprefix =seedvar wprefix =treevar ;
var y1 y2 y3 y4 y5 y6;
with x1 x2 x3 x4 x5 x6 ;
run;


/* Program 3.6 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 3.6';

data mental;
input i $ j $ freq ;
do k  = 1 to freq ;
x1=(i eq '1');
x2=(i eq '2');
x3=(i eq '3');
x4=(i eq '4');
x5=(i eq '5');
x6=(i eq '6');
y1=(j eq '1');
y2=(j eq '2');
y3=(j eq '3');
y4=(j eq '4');
output;
end;
lines;
1 1 64
1 2  94
1 3 58
1 4 46

2 1 57
2 2  94
2 3  54
2 4 40

3 1 57
3 2  105
3 3 65
3 4 60

4 1 72
4 2 141
4 3 77
4 4 94

5 1 36
5 2 97
5 3 54
5 4 78

6 1 21
6 2 71
6 3 54
6 4 71
;
/*
Data from Srole et. al (1978),
reprinted with permission from New York University Press.
*/

proc cancorr data = mental outstat = canstat
       vprefix =psstatus wprefix =mhstatus ;
var  x1 x2 x3 x4 x5 ;
with  y1 y2 y3 ;
title2 'Mental Health Status vs. Socioeconomic Status of Parents:';
run;


 /* Program 3.7 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 3.7';

data urisamp;
infile 'urine.dat' firstobs = 7;
input group y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 z1 z2 ;
g1 = group = '1';
g2 = group = '2';
g3 = group = '3';
g4 = group = '4';

proc cancorr data = urisamp short ;
var y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 g1 g2 g3 g4 ;
with g1 g2 g3 g4 z1 z2 ;
title2 'Partial Tests Using Canonical Correlation Analysis';
run;

proc reg data = urisamp ;
model y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 =  z1 z2 g1 g2 g3 g4 ;
mtest z1,z2;
title2 'Partial Tests Using MTEST Option of PROC REG';
run;


/* URINE DATA SET: urine.dat */

1 5.7  4.67  17.6  1.50  .104  1.50  1.88  5.15   8.40   7.5  .14  205  24
1 5.5  4.67  13.4  1.65  .245  1.32  2.24  5.75   4.50   7.1  .11  160  32
1 6.6  2.70  20.3  .90   .097   .89  1.28  4.35   1.20   2.3  .10  480  17
1 5.7  3.49  22.3  1.75  .174  1.50  2.24  7.55   2.75   4.0  .12  230  30
1 5.6  3.49  20.5  1.40  .210  1.19  2.00  8.50   3.30   2.0  .12  235  30
1 6.0  3.49  18.5  1.20  .275  1.03  1.84 10.25   2.00   2.0  .12  215  27
1 5.3  4.84  12.1  1.90  .170  1.87  2.40  5.95   2.60  16.8  .14  215  25
1 5.4  4.84  12.0  1.65  .164  1.68  3.00  6.30   2.72  14.5  .14  190  30
1 5.4  4.84  10.1  2.30  .275  2.08  2.68  5.45   2.40    .9  .20  190  28
1 5.6  4.48  14.7  2.35  .210  2.55  3.00  3.75   7.00   2.0  .21  175  24
1 5.6  4.48  14.8  2.35  .050  1.32  2.84  5.10   4.00    .4  .12  145  26
1 5.6  4.48  14.4  2.50  .143  2.38  2.84  4.05   8.00   3.8  .18  155  27
2 5.2  3.48  18.1  1.50  .153  1.20  2.60  9.00   2.35  14.5  .13  220  31
2 5.2  3.48  19.7  1.65  .203  1.73  1.88  5.30   2.52  12.5  .20  300  23
2 5.6  3.48  16.9  1.40  .074  1.15  1.72  9.85   2.45   8.0  .07  305  32
2 5.8  2.63  23.7  1.65  .155  1.58  1.60  3.60   3.75   4.9  .10  275  20
2 6.0  2.63  19.2  .90   .155   .96  1.20  4.05   3.30    .2  .10  405  18
2 5.3  2.63  18.0  1.60  .129  1.68  2.00  4.40   3.00   3.6  .18  210  23
2 5.4  4.46  14.8  2.45  .245  2.15  3.12  7.15   1.81  12.0  .13  170  31
2 5.6  4.46  15.6  1.65  .422  1.42  2.56  7.25   1.92   5.2  .15  235  28
2 5.3  2.80  16.2  1.65  .063  1.62  2.04  5.30   3.90  10.2  .12  185  21
2 5.4  2.80  14.1  1.25  .042  1.62  1.84  3.10   4.10   8.5  .30  255  20
2 5.5  2.80  17.5  1.05  .030  1.56  1.48  2.40   2.10   9.6  .20  265  15
2 5.4  2.57  14.1  2.70  .194  2.77  2.56  4.25   2.60   6.9  .17  305  26
2 5.4  2.57  19.1  1.60  .139  1.59  1.88  5.80   2.30   4.7  .16  440  24
2 5.2  2.57  22.5  .85   .046  1.65  1.20  1.55   1.50   3.5  .21  430  16
3 5.5  1.26  17.0  .70   .094   .97  1.24  4.55   2.90   1.9  .12  350  18
3 5.9  1.26  12.5  .80   .039   .80   .64  2.65   0.72    .7  .13  475  10
3 5.6  2.52  21.5  1.80  .142  1.77  2.60  6.50   2.48   8.3  .17  195  33
3 5.6  2.52  22.2  1.05  .080  1.17  1.48  4.85   2.20   9.3  .14  375  25
3 5.3  2.52  13.0  2.20  .215  1.85  3.84  8.75   2.40  13.0  .11  160  35
3 5.6  3.24  13.0  3.55  .166  3.18  3.48  5.20   3.50  18.3  .22  240  33
3 5.5  3.24  10.9  3.30  .111  2.79  3.04  4.75   2.52  10.5  .21  205  31
3 5.6  3.24  12.0  3.65  .180  2.40  3.00  5.85   3.00  14.5  .21  270  34
3 5.4  1.56  22.8  .55   .069  1.00  1.14  2.85   2.90   3.3  .15  475  16
4 5.3  1.56  16.5  2.05  .222  1.49  2.40  6.55   3.90   6.3  .11  430  31
4 5.2  1.56  18.4  1.05  .267  1.17  1.36  6.60   2.00   4.9  .11  490  28
4 5.8  4.12  12.5  5.90  .093  3.80  3.84  2.90   3.00  22.5  .24  105  32
4 5.7  4.12  8.7   4.25  .147  3.62  5.32  3.00   3.55  19.5  .20  115  25
4 5.5  4.12  9.4   3.85  .217  3.36  5.52  3.40   5.20   1.3  .31   97  28
4 5.4  2.14  15.0  2.45  .418  2.38  2.40  5.40   1.81  20.0  .17  325  27
4 5.4  2.14  12.9  1.70  .323  1.74  2.48  4.45   1.88   1.0  .15  310  23
4 4.9  2.03  12.1  1.80  .205  2.00  2.24  4.30   3.70   5.0  .19  245  25
4 5.0  2.03  13.2  3.65  .348  1.95  2.12  5.00   1.80   3.0  .15  170  26
4 4.9  2.03  11.5  2.25  .320  2.25  3.12  3.40   2.50   5.1  .18  220  34

/* Source: Smith, Gnanadesikan, and Hughes (1962).
(Data on urine samples from four groups of men:
y1-y11: response variables z1-z2: covariates
group: class variable.  Reproduced by permission of the
International Biometric Society.*/



CHAPTER 4 (Factor Analysis) Programs and Data Sets:


/* Program 4.1 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 4.1';
title2 "Factor Analysis of Spearman's Data";

data spearman (type=corr);
_type_='corr';
if _n_=1 then _type_='N';
infile cards missover;
input _name_ $ c f e m d mu;
lines;
n 33
c 1.0
f .83 1.0
e .78 .67 1.0
m .70 .67 .64 1.0
d .66 .65 .54 .45 1.0
mu .63 .57 .51 .51 .40 1.0
;
/* Source: Spearman (1904). */

proc factor data=spearman method=prin res scree;
var c f e m d mu;
title3 'Principal Component Method';
run;
proc factor data=spearman method=prin res nfact=2;
title3 'PC Method: Res matrix for nfact=2';
run;
proc factor data=spearman method=principal res nfact=3;
title3 'PC Method: RMS values for nfact=3';
run;
proc factor data=spearman method=principal res n=4;
title3 'PC Method: RMS values for nfact=4';
run;
proc factor data=spearman method=principal priors=smc res;
title3 'Principal Factor Method: Priors=SMC';
run;
proc factor data=spearman method=principal priors=smc
nfact=3 res;
title3 'Principal Factor Method: Priors=SMC, nfact=3';
run;
proc factor data=spearman method=principal priors=max res;
title3 'Principal Factor Method: Priors=MAX';
run;
proc factor data=spearman method=principal priors=max
nfact=3 res;
title3 'Principal Factor Method: Priors=MAX, nfact=3';
run;
proc factor data=spearman method=principal priors=asmc res;
title3 'Principal Factor Method: Priors=ASMC';
run;
proc factor data=spearman method=principal priors=asmc
nfact=3 res;
title3 'Principal Factor Method: Priors=ASMC, nfact=3';
run;

proc factor data=spearman method=image res;
title3 'Image Analysis: Method=Image';
run;

proc factor data=spearman method=harris res;
title3 'Canonical Factor Analysis: Method=Harris';
run;
proc factor data=spearman method=harris n=3 res;
title3 'Canonical Factor Analysis: Method=Harris, nfact=3';
run;

 
/* Program 4.2 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 4.2';
title2 'Factor Analysis of Ecology Data';

data ecology (type=corr);
infile cards missover;
_type_='corr';
if _n_=1 then _type_='N';
input _name_ $ grade moist dock acar chey glyc lars cryp psoc;
lines;
n 165
grade 1.0
moist .441 1.0
dock .441 .342 1.0
acar .107 .250 .040 1.0
chey .194 .323 .060 .180 1.0
glyc .105 .400 .082 .123 .220 1.0
lars .204 .491 .071 .226 .480 .399 1.0
cryp .197 .158 .051 .019 .138 -.114 .154 1.0
psoc -.236 -.220 -.073 -.199 -.084 -.304 -.134 -.096 1.00
;
/* Source: Sinha and Lee (1970). Reprinted by permission of
the Society for Population Ecology, Kyoto, Japan.*/

proc factor data=ecology method=ml nfact=1 res;
var grade moist dock acar chey glyc lars cryp psoc;
title3 'ML Method, nfact=1';
run;
proc factor data=ecology method=ml nfact=2 res;
var grade moist dock acar chey glyc lars cryp psoc;
title3 'ML Method, nfact=2';
run;
proc factor data=ecology method=ml nfact=3 res;
var grade moist dock acar chey glyc lars cryp psoc;
title3 'ML Method, nfact=3';
run;
proc factor data=ecology method=ml hey nfact=3 res;
var grade moist dock acar chey glyc lars cryp psoc;
title3 'ML Method, nfact=3, HEY option';
run;
proc factor data=ecology method=ml hey nfact=4 res;
var grade moist dock acar chey glyc lars cryp psoc;
title3 'ML Method, nfact=4, HEY option';
run;

proc factor data=ecology method=ml hey nfact=5 res;
var grade moist dock acar chey glyc lars cryp psoc;
title3 'ML Method, nfact=5, HEY option';
run;

proc factor data=ecology method=uls hey nfact=3 res;
var grade moist dock acar chey glyc lars cryp psoc;
title3 'ULS Method, nfact=3, HEY option';
run;

proc factor data=ecology method=prinit hey nfact=3 res;
var grade moist dock acar chey glyc lars cryp psoc;
title3 'PRINIT Method, nfact=3, HEY option';
run;

proc factor data=ecology method=alpha hey nfact=3 res;
var grade moist dock acar chey glyc lars cryp psoc;
title3 'Alpha Method, nfact=3, HEY option';
run;


/* Program 4.3 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 4.3';
title2 'Factor Analysis of the Ecology Data';

data ecology (type=corr);
infile cards missover;
_type_='CORR';
if _n_=1 then _type_='N';
input _name_ $ grade moist dock acar chey glyc lars cryp psoc;
lines;
n 165
grade 1.0
moist .441 1.0
dock .441 .342 1.0
acar .107 .250 .040 1.0
chey .194 .323 .060 .180 1.0
glyc .105 .400 .082 .123 .220 1.0
lars .204 .491 .071 .226 .480 .399 1.0
cryp .197 .158 .051 .019 .138 -.114 .154 1.0
psoc -.236 -.220 -.073 -.199 -.084 -.304 -.134 -.096 1.00
;

proc factor data=ecology method=prin priors=asmc
nfact=3 rotate=varimax;
title3 'Principal Factor Method, Varimax Rotation';
run;
proc factor data=ecology method=prin priors=asmc
nfact=3 rotate=quartimax;
title3 'Principal Factor Method, Quartimax Rotation';
run;
proc factor data=ecology method=prin priors=asmc
nfact=3 rotate=equamax;
title3 'Principal Factor Method, Equamax Rotation';
run;
proc factor data=ecology method=prin priors=asmc
nfact=3 rotate=parsimax;
title3 'Principal Factor Method, Parsimax Rotation';
run;

proc factor data=ecology method=ml hey nfact=3
rotate=varimax;
title3 'ML Method, Varimax Rotation';
run;
proc factor data=ecology method=ml hey nfact=3
rotate=quartimax;
title3 'ML Method, Quartimax Rotation';
run;
proc factor data=ecology method=ml hey nfact=3
rotate=equamax;
title3 'ML Method, Equamax Rotation';
run;
proc factor data=ecology method=ml hey nfact=3
rotate=parsimax;
title3 'ML Method, Parsimax Rotation';
run;

proc factor data=ecology method=prin mineigen=1
rotate=varimax;
title3 'Little Jiffy: PC method with Varimax Rotation';
run;

proc factor data=ecology method=prin priors=asmc
nfact=3 rotate=hk;
title3 'Principal Factor Method, Oblique Rotation (HK)';
run;
proc factor data=ecology method=prin priors=asmc
nfact=3 rotate=promax;
title3 'Principal Factor Method, Oblique Rotation (PROMAX)';
run;

proc factor data=ecology method=ml hey nfact=3 rotate=hk;
title3 'ML Method, Oblique Rotation (HK)';
run;
proc factor data=ecology method=ml hey nfact=3 rotate=promax;
title3 'ML Method, Oblique Rotation (PROMAX)';
run;


/* Program 4.4 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 4.4';
title2 'Factor Scores: World Bank Data';

data economy;
input country $ pop area gnp life radio tourist
food school;
lines;
Canada 25.6 9976 14120 76 758 12854 3404 98
USA 241.6 9363 17480 75 2133 20441 3632 99
Haiti 6.1 28 330 54 21 167 1906 48
Brazil 138.4 8512 1810 65 355 1420 2575 78
Austria 7.6 84 9990 74 475 14482 3479 80
Iceland .24 103 13410 77 593 78 3122 100
Spain 38.7 505 4860 76 274 25583 3325 97
UK 56.7 245 8870 75 986 12499 3210 96
Gambia 0.77 11 230 43 120 37 2217 34
India 781.4 3288 290 57 56 1305 2031 54
Malaysia 16.1 330 1830 69 415 1050 2569 77
Austrlia 16.0 7687 11920 78 1159 944 3044 89
;
/* Source: The World Bank World Development Report (1988).
Reprinted by permission of the World Bank Office of Publisher.*/

proc factor data=economy method=prin prior=asmc
nfact=3 rotate=varimax out=fscore;
var pop area gnp life radio tourist food school;
run;

proc print data=fscore;
run;

data labels;
set fscore;
retain xsys '2' ysys '2';
length text $8 function $8;
text=country;
y=factor2;
x=factor1;
size=1.2;
position='8';
function = 'LABEL';
run;
filename gsasfile "prog44a.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
title1 h=1.2 'World Bank Data: Plot of Scores on the
First and Second Factors';
title2 j=l 'Output 4.4';
proc gplot data=fscore;
plot factor2*factor1/annotate=labels vaxis=axis2 haxis=axis1;
axis1 label=(h=1.2 'First Factor');
axis2 label=(h=1.2 a=90 r=0  'Second Factor');
run;

data labels;
set fscore;
retain xsys '2' ysys '2';
length text $8 function $8;
text=country;
y=factor3;
x=factor1;
size=1.2;
position='8';
function = 'LABEL';
run;
filename gsasfile "prog44b.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
title1 h=1.2 'World Bank Data: Plot of Scores on the
First and Third Factors';
title2 j=l 'Output 4.4';
proc gplot data=fscore;
plot factor3*factor1/annotate=labels vaxis=axis2 haxis=axis1;
axis1 label=(h=1.2 'First Factor');
axis2 label=(h=1.2 a=90 r=0  'Third Factor');
run;


/* Program 4.5 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 4.5';
title2 'Factor Analysis of Residuals';
data crime;
input x1 x2 x3 comma5. x4-x12;
input x13-x18;
array x{18} x1-x18;
array u{18} u1-u18;
do i=1 to 18;
u{i}=log(x{i});
end;
year =_n_;
year_s=year*year;
cards;
529 5258 4,416 8178 92839 1021 301078 25333 7586 4518 3790 118
20844 9477 24616 49007 2786 3126
455 5619 4,876 9223 95946 800 355407 27216 9716 4993 3378 74
19963 10359 21122 55229 2739 4595
555 5980 5,443 9026 97941 1002 341512 27051 9188 5003 4173 120
19056 9108 23339 55635 2598 4145
456 6187 5,680 10107 88607 980 308578 27763 7786 5309 4649 108
17772 9278 19919 55688 2639 4551
487 6586 6,357 9279 75888 812 285199 26267 6468 5251 4903 104
17379 9176 20585 57011 2587 4343
448 7076 6,644 9953 74907 823 295035 22966 7016 2184 4086 92
17329 9460 19197 57118 2607 4836
477 8433 6,196 10505 85768 965 323561 23029 7215 2559 4040 119
16677 10997 19064 63289 2311 5932
491 9774 6,327 11900 105042 1194 360985 26235 8619 2965 4689 121
17539 12817 19432 71014 2310 7148
453 10945 5,471 11823 131132 1692 409388 29415 10002 3607 5376 164
17344 14289 24543 69864 2371 9772
434 12707 5,732 13864 133962 1900 445888 34061 10254 4083 5598 160
18047 14118 26853 69751 2544 11211
492 14391 5,240 14304 151378 2014 489258 36049 11696 4802 6590 241
18801 15866 31266 74336 2719 12519
459 16197 5,605 14376 164806 2349 531430 39651 13777 5606 6924 205
18525 16399 29922 81753 2820 13050
504 16430 4,866 14788 192302 2517 588566 44138 15783 6256 7816 250
16449 16852 34915 89709 2614 14141
510 18655 5,435 14722 219138 2483 635627 45923 17777 6935 8634 257
15918 17003 40434 89149 2777 22896
;
/* Source: Ahamad (1967). Reprinted by permission of
the Royal Statistical Society.*/

proc factor data=crime cov prior=max rotate=quartimax nfact=3;
var u1-u18;
partial year year_s;
run;


/* Program 4.6 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 4.6';
title2 'Factor Analysis of Sleep in Mammals';

data sleep (type=corr);
infile cards missover;
_type_='CORR';
if _n_=1 then _type_='N';
input _name_ $ sws ps l wb wbr tg p s d;
lines;
n 39
sws 1.000
ps .582 1.000
l -.377 -.342 1.000
wb -.712 -.370 .685 1.000
wbr -.679 -.435 .777 .945 1.000
tg -.589 -.651 .682 .692 .781 1.000
p -.369 -.536 .018 .253 .192 .158 1.000
s -.580 -.591 .518 .662 .624 .588 .680 1.000
d -.542 -.686 .226 .432 .377 .363 .930 .819 1.00
;
/* Source: Allison and Cicchetti (1976).  Reprinted by
permission of American Association for the Advancement of
Science.*/

proc factor method=principal mineigen=1 rotate=varimax;
var sws ps l wb wbr tg p s d;
run;


/* Program 4.7 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 4.7';
title2 'Factor Analysis of Photographic Data';

data density (type=cov);
infile cards missover;
_type_='cov';
if _n_=1 then _type_='N';
input _name_ $ x1-x14;
cards;
n 232
x1 6.720
x2 6.669 6.856
x3 6.504 6.862 7.260
x4 6.329 6.876 7.586 8.387
x5 5.769 6.490 7.477 8.591 9.238
x6 4.866 5.648 6.767 8.046 8.919 8.929
x7 3.526 4.239 5.299 6.534 7.451 7.649 6.875
x8 2.276 2.807 3.634 4.635 5.431 5.738 5.348 4.464
x9 1.117 1.442 1.998 2.678 3.249 3.546 3.409 2.956 2.108
x10 .498 .662 .967 1.350 1.695 1.892 1.876 1.682 1.239 .811
x11 .167 .215 .323 .486 .652 .781 .825 .822 .654 .450 .321
x12 -.015 -.022 .003 .073 .155 .254 .330 .408 .369 .281 .223 .208
x13 -.061 -.091 -.111 -.094 -.062 .007 .091 .224 .251 .216 .198 .179 .211
x14 -.152 -.200 -.256 -.278 -.277 -.204 -.095 .083 .158 .157 .175 .176 .192 .219
;
/* Source: Jackson and Bradley (1966, p. 515). Reprinted by permission of
the Academic Press.*/

proc factor data=density (type=cov) cov method=prin mineigen=1
rotate=varimax outstat=saveall;
var x1-x14;
run;
proc print data=saveall;
run;
data temp1(type=factor);
set saveall;
if _type_='PATTERN' then output;
run;
proc transpose data=temp1 out=temp2;
run;
data fin;
set temp2;
obser=_n_;
run;
filename gsasfile "prog47.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
title1 h=1.2 'Plots of Factor Loadings for Photographic Data';
title2 j=l 'Output 4.7';
proc gplot data=fin;
plot factor1*obser factor2*obser factor3*obser/overlay
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'The Factor Loadings');
axis2 offset=(2) label=(h=1.2 'Photo Sequence');
symbol1 i=join v=star c=red;
symbol2 i=join v=+ c=blue;
symbol3 i=join v=x c=green;
legend1 across=3;
run;


/* Program 4.8 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 4.8';
title2 'Factor Analysis of Marketing Data';

data diab;
infile 'diabetic.dat' firstobs=3 obs=125;
input id $ x1-x25;
run;
proc factor data=diab n=5 method=prin priors=asmc
rotate=varimax;
var x1-x25;
run;

 /* DIABETICS DATA SET: diabetic.dat */

 188 5 1 5 1 2 4 2 5 2 5 4 5 4 4 2 5 2 4 3 4 2 5 1 5 5
 200 5 1 4 1 4 5 2 5 1 4 1 1 4 5 4 4 5 4 1 5 1 4 2 5 4
 202 5 1 1 1 5 3 1 3 4 1 1 4 2 4 2 1 1 2 1 5 4 1 5 5 1
 204 5 1 4 1 4 4 1 5 4 1 4 1 2 5 1 5 4 3 4 5 1 4 2 5 3
 213 5 1 2 1 3 4 1 5 1 3 3 1 3 5 4 5 4 3 3 3 1 3 3 5 2
 124 5 2 5 2 2 4 2 5 3 3 5 5 2 4 2 2 5 4 3 3 1 5 2 5 4
 126 5 1 5 1 4 4 1 5 2 5 2 1 5 5 4 1 5 5 5 5 1 3 4 5 5
 129 5 4 5 2 2 4 1 5 3 5 5 5 1 4 1 1 5 5 5 4 1 5 2 5 5
 150 5 2 5 2 1 2 5 2 2 4 4 4 1 5 2 1 5 5 3 5 4 5 2 5 2
 152 5 1 2 1 5 4 1 4 2 3 4 1 2 5 2 2 1 2 1 3 2 4 3 5 4
 121 5 1 5 1 1 5 2 5 5 2 2 2 4 5 5 5 3 4 4 4 1 5 1 5 5
 122 4 1 1 1 5 5 3 1 1 1 1 1 1 5 1 1 5 3 1 5 1 5 4 5 2
 123 5 1 1 1 1 1 1 5 5 1 4 1 2 5 4 5 5 5 3 2 4 4 3 5 5
 102 5 1 5 1 3 5 3 5 2 1 5 1 4 5 4 3 2 4 2 5 1 1 1 5 2
 104 5 1 5 1 2 5 1 5 1 1 4 5 4 4 4 1 4 4 5 1 4 4 2 5 4
 106 5 1 3 1 3 5 4 5 2 4 5 1 1 5 5 5 5 5 5 5 1 4 2 5 4
 108 5 2 4 1 4 5 1 5 1 3 2 5 5 5 5 2 4 2 5 3 1 5 2 5 5
 214 5 2 5 1 2 5 3 5 1 2 2 4 2 5 2 1 5 2 2 2 2 3 2 5 2
 215 5 5 4 1 2 5 1 4 4 5 5 2 1 5 4 5 5 4 5 5 1 5 1 5 4
 217 5 1 5 1 1 5 2 5 4 5 5 4 2 5 5 5 5 5 3 5 1 5 2 5 5
 154 5 1 5 4 1 4 1 4 3 4 5 4 1 5 1 1 5 4 4 3 3 4 2 5 4
 157 5 2 5 2 4 4 4 4 4 3 5 5 5 5 4 5 4 4 3 5 2 3 2 5 3
 165 5 1 5 2 1 2 2 5 2 5 3 2 2 5 3 1 3 5 3 4 3 4 2 5 5
 168 5 1 5 1 1 3 5 5 1 5 3 5 1 3 3 3 4 5 4 1 2 3 2 5 1
 169 5 1 5 1 2 2 1 3 1 2 2 1 3 5 1 3 4 4 1 5 5 1 5 5 1
 170 5 1 5 2 2 2 3 2 2 5 4 5 4 2 2 1 5 5 1 2 4 3 2 4 2
 171 3 1 1 1 5 5 5 1 2 . 1 1 5 5 5 3 5 1 1 1 5 2 1 5 5
 172 5 2 5 4 2 2 3 4 3 5 5 5 3 3 3 2 2 1 3 3 2 3 2 5 2
 178 5 3 4 1 4 4 5 4 4 5 5 4 5 5 3 5 5 5 5 5 4 5 2 5 5
 187 5 3 3 1 4 4 5 2 4 1 3 4 1 5 5 3 4 5 3 2 4 2 4 5 4
 219 5 1 4 1 4 4 2 4 3 3 4 2 2 4 2 2 2 4 1 2 3 4 2 5 3
 221 5 1 1 1 5 4 1 4 4 2 2 2 1 5 5 1 5 4 3 4 3 5 2 5 3
 222 5 3 4 1 2 3 3 3 5 3 4 4 3 4 3 4 3 5 3 4 3 2 3 5 3
 109 5 1 3 1 5 5 2 5 1 4 5 2 2 4 3 3 5 1 2 2 1 4 2 5 4
 110 5 1 5 1 1 5 1 5 4 5 5 2 3 4 4 5 5 2 3 2 2 4 3 5 4
 111 5 3 3 1 5 5 1 5 1 5 3 1 4 5 4 5 5 4 3 5 2 5 2 5 4
 112 5 1 5 1 2 3 5 4 2 1 4 1 2 5 4 1 2 3 4 2 2 4 2 5 3
 113 5 1 3 1 5 4 2 4 1 3 1 1 1 5 1 1 5 1 1 4 3 3 5 5 3
 114 5 4 5 1 2 5 1 5 1 5 5 1 1 5 5 2 5 4 3 2 1 5 1 5 4
 116 5 2 4 1 3 5 1 5 1 3 3 1 2 5 4 5 5 3 3 4 2 5 3 5 4
 151 5 2 4 1 3 5 2 4 2 1 4 1 3 5 4 4 5 5 3 3 5 4 1 5 5
 153 5 1 3 1 2 4 1 5 4 1 3 1 5 5 5 2 4 5 1 5 2 4 3 5 5
 216 5 5 4 1 4 4 4 4 4 5 5 5 5 4 4 3 5 5 4 3 4 4 2 5 3
 131 5 3 3 1 1 2 3 3 3 3 4 1 4 5 1 3 4 4 . 3 3 3 4 5 3
 132 5 3 5 1 1 5 1 5 1 5 2 1 1 5 5 5 5 5 . 3 2 5 1 5 5
 133 5 5 5 1 1 5 1 5 1 4 5 5 5 5 4 5 5 5 3 4 4 5 2 4 5
 135 5 4 3 1 4 3 5 2 1 3 2 4 3 4 3 1 1 3 3 3 4 2 4 5 1
 136 5 1 5 1 2 4 3 1 3 4 2 1 3 3 4 1 1 5 3 4 2 5 2 5 1
 137 5 2 1 1 4 5 1 1 1 1 1 1 1 5 5 1 5 1 5 1 1 5 3 5 5
 103 5 1 5 1 1 4 5 4 5 4 4 1 4 5 3 5 5 5 3 5 4 5 5 5 3
 101 5 2 1 1 4 5 1 4 4 3 2 2 4 4 5 5 5 4 3 5 1 5 1 5 5
 105 5 1 5 1 1 4 3 3 3 5 5 3 5 4 3 4 4 5 3 4 3 3 3 5 4
 117 5 1 1 1 1 1 2 2 1 1 1 1 1 5 3 5 4 1 1 2 1 2 2 1 4
 118 5 3 5 1 2 3 5 5 5 4 5 1 4 5 4 1 4 5 1 3 1 5 1 5 5
 119 5 1 3 1 3 5 5 3 1 1 3 2 4 5 1 4 3 3 5 3 2 2 5 5 2
 120 5 1 5 1 4 5 1 5 4 2 4 1 3 5 3 2 3 4 1 3 4 5 2 5 5
 127 5 2 4 1 3 5 4 4 4 3 5 1 4 5 5 3 3 5 3 3 1 4 1 5 5
 125 5 1 5 1 4 5 4 5 4 5 5 4 5 5 5 2 5 5 3 1 4 5 1 5 4
 212 5 1 5 1 1 4 5 4 3 1 3 1 4 . 4 3 5 4 4 4 3 3 3 5 3
 185 5 3 4 1 2 4 3 4 4 3 4 1 2 5 3 2 4 5 3 5 2 3 2 5 4
 186 5 1 5 1 2 3 4 4 2 1 2 4 1 4 4 3 5 4 3 4 1 4 2 4 4
 189 5 2 5 1 4 4 3 5 4 3 5 1 3 5 4 3 5 5 5 4 1 5 1 5 5
 191 5 3 3 1 1 3 3 5 5 1 5 1 3 5 3 1 1 5 3 5 5 4 5 5 3
 193 5 1 5 1 1 4 4 4 1 1 4 4 2 2 1 2 5 5 3 4 4 2 4 5 1
 180 5 3 2 1 4 4 3 3 4 3 3 1 4 3 1 4 4 5 3 5 3 2 3 5 2
 181 5 1 4 1 2 4 1 5 2 3 2 2 1 5 3 3 4 5 3 4 1 5 1 5 4
 182 5 1 4 1 4 5 1 5 1 4 4 1 1 5 5 1 5 1 4 3 2 4 1 5 5
 183 5 1 5 1 1 5 5 5 2 3 5 2 3 5 4 2 4 5 2 4 1 5 2 5 5
 184 5 2 3 1 2 3 3 3 3 1 4 1 4 5 4 3 4 1 3 5 3 2 3 5 4
 138 5 1 5 1 2 5 1 5 3 4 4 1 5 4 5 5 5 5 3 5 1 5 1 5 5
 139 5 4 2 5 5 3 4 5 4 2 2 5 5 3 5 2 5 2 . 5 2 4 2 5 4
 140 5 1 2 3 3 4 1 5 5 5 3 2 2 4 4 5 5 5 4 5 4 5 1 5 5
 146 5 1 1 1 1 5 1 4 1 1 1 1 1 5 1 1 5 1 4 5 5 4 2 5 4
 130 5 1 5 1 1 5 1 5 1 1 1 2 1 5 1 5 5 4 5 5 2 5 2 5 5
 145 5 1 3 2 1 3 2 4 4 5 4 3 3 3 4 3 4 5 3 5 3 3 3 5 3
 211 5 4 4 2 1 5 4 2 1 2 3 1 3 5 3 3 5 4 3 5 3 3 4 5 3
 161 5 1 3 1 5 1 3 3 1 1 1 1 4 3 1 1 2 1 1 1 1 1 1 5 4
 162 5 2 3 1 5 5 1 5 1 1 4 1 4 4 2 5 5 4 3 5 1 5 1 5 5
 164 5 5 3 3 2 2 3 3 4 4 4 2 4 2 4 5 4 4 1 4 3 3 3 4 3
 173 5 1 1 1 4 2 5 5 3 1 1 4 1 5 1 1 1 3 3 1 1 1 3 5 1
 218 4 1 5 1 1 3 3 5 5 5 5 1 3 5 1 3 5 5 3 5 5 5 5 5 5
 220 4 3 4 2 2 3 4 2 2 1 2 1 3 3 2 2 3 1 3 3 4 2 4 4 2
 107 4 5 5 2 1 4 4 1 3 1 1 3 4 3 1 1 1 1 1 3 1 1 5 4 1
 115 5 3 5 1 3 3 1 5 3 5 3 1 3 3 3 5 3 3 3 5 3 5 1 5 5
 128 5 1 1 1 2 5 1 5 2 1 2 1 1 5 1 1 5 1 5 4 1 5 1 5 4
 134 5 4 5 1 2 5 1 4 4 5 5 5 5 5 5 5 5 5 5 4 4 5 4 5 5
 141 5 1 5 1 1 5 1 5 1 3 5 1 5 5 5 1 5 5 5 5 1 5 1 5 5
 142 5 3 4 1 3 4 2 4 1 3 4 1 4 5 5 3 5 1 3 3 1 3 1 5 4
 143 5 2 5 1 3 5 5 5 1 5 5 5 2 5 5 5 5 2 2 1 1 4 4 5 5
 144 5 1 3 1 5 3 2 4 4 4 4 1 4 3 3 1 5 1 3 1 4 3 2 5 3
 210 5 2 3 1 3 1 1 3 2 1 1 1 1 5 3 1 2 1 1 1 5 1 5 5 3
 179 5 1 2 1 5 4 2 4 1 5 2 1 1 5 2 4 4 5 . 5 4 4 2 5 5
 190 5 1 5 1 3 4 4 3 1 3 3 2 3 5 3 5 5 3 3 5 1 5 3 5 4
 192 5 1 5 1 3 4 3 5 2 3 5 5 4 4 2 2 5 4 4 4 1 4 2 5 5
 194 5 1 1 1 4 4 1 1 1 1 4 1 1 5 4 1 5 5 . 4 3 5 3 5 5
 195 5 1 3 1 4 5 1 2 1 1 1 1 1 5 1 1 . 2 . 1 5 5 1 5 3
 196 5 4 5 4 4 5 1 5 4 4 4 5 5 4 3 5 5 4 5 5 1 5 4 5 5
 197 5 1 1 1 4 5 5 1 1 4 1 5 1 5 1 4 3 5 . 3 1 1 5 5 4
 198 4 2 5 1 3 4 3 4 4 4 5 1 5 5 4 4 5 4 5 3 1 5 2 5 5
 199 5 1 1 1 5 4 1 5 2 2 3 1 3 5 3 5 5 3 5 5 1 4 2 5 4
 201 5 1 5 1 2 4 1 5 1 5 4 1 4 5 1 4 5 4 4 5 1 5 2 5 4
 203 5 1 4 1 4 5 1 5 4 1 4 1 4 5 1 4 2 4 4 5 1 3 2 5 4
 205 5 1 3 1 4 4 3 4 3 3 4 1 3 4 5 5 3 1 . 5 1 3 2 5 5
 206 5 2 4 4 2 4 4 4 2 3 4 4 5 4 3 5 5 3 . 5 3 2 3 5 5
 207 5 1 5 1 3 5 2 4 1 1 4 1 5 4 3 5 3 5 3 5 2 4 2 5 4
 208 5 1 4 1 1 5 1 5 3 1 1 1 1 4 5 5 5 4 4 3 1 4 1 5 5
 209 5 1 3 1 3 5 2 2 3 2 3 1 3 5 3 3 5 5 5 3 3 3 3 5 3
 177 5 3 2 1 5 5 1 2 1 2 1 1 2 5 2 1 5 3 4 2 5 3 4 5 3
 147 5 1 2 1 5 2 2 3 2 1 1 1 2 4 4 1 1 2 2 2 3 3 5 5 3
 148 5 1 5 1 4 5 4 5 1 1 5 4 4 5 4 4 1 5 4 2 5 5 5 5 5
 149 5 2 5 1 2 5 3 5 2 5 5 4 3 5 4 5 3 5 3 3 2 5 2 5 5
 155 5 1 5 1 3 3 2 5 4 1 5 1 4 4 4 2 4 4 1 5 1 5 1 5 5
 156 5 3 5 1 3 5 3 4 1 5 5 4 5 5 5 5 3 5 . 1 1 4 1 5 5
 158 5 1 5 1 3 5 3 3 1 3 3 3 3 5 3 3 3 1 5 3 1 3 3 5 3
 159 5 1 5 1 2 3 1 5 4 5 5 1 2 1 4 1 5 5 2 2 2 5 1 5 2
 160 5 1 2 1 3 4 3 4 2 1 4 1 2 5 4 1 2 4 3 3 2 5 2 5 5
 163 5 4 5 2 1 3 5 5 5 4 5 4 4 4 4 3 5 5 4 3 4 4 3 5 5
 166 5 1 3 1 2 5 1 5 2 2 4 2 1 5 2 4 5 4 4 4 2 5 2 5 5
 167 5 1 5 1 3 3 4 4 2 4 3 1 4 4 3 2 3 3 3 2 4 3 4 5 2
 174 5 3 4 1 2 4 2 4 1 3 2 3 1 5 5 3 5 3 1 5 1 3 4 5 3
 175 5 1 5 4 3 5 2 5 3 4 2 1 3 5 5 2 4 4 2 5 2 4 2 5 4
 176 3 1 4 1 2 5 2 3 1 2 4 1 1 5 3 4 4 4 4 4 4 2 . 5 5

/* Data courtesy of Dr. G. R. Patwardhan, Strategic
Marketing Corporation.  These data are on diabetic
patients' attitudes toward the disease.  There are 122
patients and their opinions on 25 questions are recorded
in a five-point scale.  Scales: 1 (Strongly disagree),
2 (Somewhat disagree), 3 (Neither disagree nor agree)
4 (Somewhat agree), 5 (Strongly agree). */


/* Program 4.9 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 4.9';

data mice1;
infile 'mice.dat' firstobs=3 obs=13;
input x1-x7;
run;
proc factor data=mice1 cov method=prin nfact=3 rotate=varimax
outstat=save1;
title2 'Factor Loadings of Group 1 Data';
run;
data temp1(type=factor);
set save1;
if _type_='PATTERN' then output;
run;
proc transpose data=temp1 out=out1;
run;

data mice2;
infile 'mice.dat' firstobs=16 obs=25;
input x1-x7;
run;
proc factor data=mice2 cov method=prin nfact=3 rotate=varimax
outstat=save2;
title2 'Factor Loadings of Group 2 Data';
run;
data temp2(type=factor);
set save2;
if _type_='PATTERN' then output;
run;
proc transpose data=temp2 out=out2;
run;
data mice3;
infile 'mice.dat' firstobs=28 obs=39;
input x1-x7;
run;
proc factor data=mice3 cov method=prin nfact=3 rotate=varimax
outstat=save3;
title2 'Factor Loadings of Group 3 Data';
run;
data temp3(type=factor);
set save3;
if _type_='PATTERN' then output;
run;
proc transpose data=temp3 out=out3;
run;

data plot;
set out1 out2 out3;
pos=mod(_n_-1,7);
proc sort;
by pos;
run;
data plot;
set plot;
obser=_n_-1;
pos_env=factor1**2;
pre_env=factor2**2;
genetic=factor3**2;
run;
proc print data=plot;
var obser pos_env pre_env genetic;
title2 'Squared Factor Loadings from the Three Groups';
run;

filename gsasfile "prog49.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
title1 h=1.2 'Plots of Squares of Factor Loadings for Mice Data';
title2 j=l 'Output 4.9';
proc gplot data=plot;
plot pos_env*obser pre_env*obser genetic*obser/overlay
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'Proportion of Variation of Weight');
axis2 offset=(2) label=(h=1.2 'Number of Days After Birth');
symbol1 v=none i=sm65 v=star c=red;
symbol2 v=none i=sm65 v=+ c=blue;
symbol3 v=none i=sm65 v=x c=green;
legend1 across=3;
run;


/* MICE DATA SET: mice.dat */

.120 .138 .258 .408 .549 .659 .642
.150 .287 .475 .628 .800 .894 .941
.151 .270 .452 .600 .663 .800 .954
.127 .260 .459 .648 .802 .902 1.000
.152 .242 .410 .570 .668 .768 .855
.149 .240 .402 .573 .742 .870 .855
.141 .260 .472 .662 .760 .885 .878
.154 .271 .430 .593 .689 .775 .920
.170 .300 .499 .519 .599 .600 .750
.160 .283 .365 .430 .618 .719 .813
.164 .240 .397 .547 .702 .802 .865


.180 .329 .516 .521 .710 .780 .850
.169 .268 .429 .548 .689 .750 .844
.162 .300 .512 .682 .753 .845 .831
.180 .292 .454 .616 .716 .730 .880
.175 .327 .513 .661 .765 .795 .870
.180 .349 .504 .600 .660 .700 .762
.163 .327 .530 .730 .779 .801 .877
.181 .350 .571 .719 .812 .827 .872
.192 .330 .520 .703 .796 .860 .938
.180 .328 .493 .631 .774 .821 .968

0.190 0.388 0.621 0.823 1.078 1.132 1.191
0.218 0.393 0.568 0.729 0.839 0.852 1.004
0.141 0.260 0.472 0.662 0.760 0.885 0.878
0.211 0.394 0.549 0.700 0.783 0.870 0.925
0.209 0.419 0.645 0.850 1.001 1.026 1.069
0.193 0.362 0.520 0.530 0.641 0.640 0.751
0.201 0.361 0.502 0.530 0.657 0.762 0.888
0.202 0.370 0.498 0.650 0.795 0.858 0.910
0.190 0.350 0.510 0.666 0.819 0.879 0.929
0.219 0.399 0.578 0.699 0.709 0.822 0.953
0.225 0.400 0.545 0.690 0.796 0.825 0.836
0.224 0.381 0.577 0.756 0.869 0.929 0.999

/* Source: A.J.Izenman and J.S.Williams (1989).  Reproduced
by permission of the International Biometric Society.
(Ref: Biometrics, 45,831-849, "A class of linear spectral
models and analyses for the study of longitudinal data."
Data are weights of 33 male mice measured over the 21 days
(in three groups) from birth to weaning.  Data in this first
block represent weights of 11 mice at ages 0, 3, 6, 9, 12, 15,
and 18 days following birth. This is Group 1.  Data in the
second block  represent weights of 10 mice at ages 1, 4, 7,
10, 13, 16, and 19 days following birth. This is Group 2.
Finally data in the third block represent weights of 12 mice
at ages 2, 5, 8, 11, 14, 17, and 20 days following birth.
This is Group 3. */


/* Program 4.10 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 4.10';
title2 'Factor Analysis of Sediments Data';
data phi;
infile 'sedimnt.dat' firstobs=3 obs=93;
input id season$ tide$ station$ x1-x7;
run;
data phi;
set phi;
proc sort;
by season tide;
run;
proc factor data=phi cov method=prin n=3 rotate=varimax
outstat=save1;
var x1-x7;
by season tide;
run;
data temp1(type=factor);
set save1;
if _type_='PATTERN' and tide='high' then output;
run;
data temp1;
set temp1;
proc sort;
by season;
run;
proc transpose data=temp1 out=out1;
by season;
run;
data plot;
set out1;
obser=mod(_n_-1,7);
if season='Apr_83' then April=factor1;
if season='Jul_83' then July=factor1;
if season='Sep_83' then Sept=factor1;
run;
filename gsasfile "prog410a.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
title1 h=1.2 'Plot of Loadings for Factor 1: High Tide';
title2 j=l 'Output 4.10';
proc gplot data=plot;
plot April*obser July*obser Sept*obser/overlay
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'Factor 1: Loadings');
axis2 offset=(2) label=(h=1.2 'Grain Size: High Tide');
symbol1 i=join v=star c=red;
symbol2 i=join v=dot c=blue;
symbol3 i=join v=x c=green;
legend1 across=3;
footnote j=l 'Sedimentology Data: Courtesy: Dr. G. N. Nayak';
run;
data temp2(type=factor);
set save1;
if _type_='PATTERN' and tide='mid' then output;
run;
data temp2;
set temp2;
proc sort;
by season;
run;
proc transpose data=temp2 out=out2;
by season;
run;
data plot;
set out2;
obser=mod(_n_-1,7);
if season='Apr_83' then April=factor1;
if season='Jul_83' then July=factor1;
if season='Sep_83' then Sept=factor1;
run;
filename gsasfile "prog410b.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
title1 h=1.2 'Plot of Loadings for Factor 1: Middle Tide';
title2 j=l 'Output 4.10';
proc gplot data=plot;
plot April*obser July*obser Sept*obser/overlay
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'Factor 1: Loadings');
axis2 offset=(2) label=(h=1.2 'Grain Size: Middle Tide');
symbol1 i=join v=star c=red;
symbol2 i=join v=dot c=blue;
symbol3 i=join v=x c=green;
legend1 across=3;
footnote j=l 'Sedimentology Data: Courtesy: Dr. G. N. Nayak';
run;
data temp3(type=factor);
set save1;
if _type_='PATTERN' and tide='low' then output;
run;
data temp3;
set temp3;
proc sort;
by season;
run;
proc transpose data=temp3 out=out3;
by season;
run;
data plot;
set out3;
obser=mod(_n_-1,7);
if season='Apr_83' then April=factor1;
if season='Jul_83' then July=factor1;
if season='Sep_83' then Sept=factor1;
run;
filename gsasfile "prog410c.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
title1 h=1.2 'Plot of Loadings for Factor 1: Low Tide';
title2 j=l 'Output 4.10';
proc gplot data=plot;
plot April*obser July*obser Sept*obser/overlay
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'Factor 1: Loadings');
axis2 offset=(2) label=(h=1.2 'Grain Size: Low Tide');
symbol1 i=join v=star c=red;
symbol2 i=join v=dot c=blue;
symbol3 i=join v=x c=green;
legend1 across=3;
footnote j=l 'Sedimentology Data: Courtesy: Dr. G. N. Nayak';
run;


     /* SEDIMENTOLOGY DATA SET: sedimnt.dat */

      1  Apr_83  high  1    19.00   6.26  12.74  20.92  32.24   8.84  0.00
      2  Apr_83  high  2     0.00   0.42   6.74  42.63  42.24   7.97  0.00
      3  Apr_83  high  3     0.00   0.18  16.52  51.49  28.36   3.45  0.00
      4  Apr_83  high  4     0.00  16.47  45.37  29.65   7.18   1.33  0.00
      5  Apr_83  high  5    11.13  29.28  43.36  13.87   2.20   0.16  0.00
      6  Apr_83  high  6     0.04   3.58  36.83  38.37  21.18   0.00  0.00
      7  Apr_83  high  7     0.00   0.00  25.74  25.95  43.13   4.84  0.34
      8  Apr_83  high  8     0.00   0.00   5.64   6.71  61.77  23.67  2.21
      9  Apr_83  high  9     0.00   0.00   1.00   5.98  72.50  19.65  0.87
     10  Apr_83  high  10    0.00   0.00   5.62  13.76  62.93  16.89  0.80
     11  Apr_83  med   1    18.60   6.23  12.17  26.80  24.66  11.54  0.00
     12  Apr_83  med   2     0.00   0.28   2.27  10.82  44.82  41.81  0.00
     13  Apr_83  med   3     0.00   2.14  19.66  42.23  30.96   5.01  0.00
     14  Apr_83  med   4     0.00   6.09  24.26  45.82  21.18   2.65  0.00
     15  Apr_83  med   5    11.18  22.04  36.52  30.26   0.00   0.00  0.00
     16  Apr_83  med   6     3.88  20.20  28.30  16.77  30.85   0.00  0.00
     17  Apr_83  med   7     0.00   0.00  16.43  16.52  54.21  11.99  0.85
     18  Apr_83  med   8     0.00   0.00  16.46   8.05  52.59  21.63  1.27
     19  Apr_83  med   9     0.00   0.00   3.21   8.12  62.01  25.31  1.35
     20  Apr_83  med   10    0.00   0.00   1.73   2.97  54.15  37.64  3.60
     21  Apr_83  low   1    50.60   2.07   3.71  13.85  18.61  11.16  0.00
     22  Apr_83  low   2     0.00   6.68  14.02  20.38  33.17  25.75  0.00
     23  Apr_83  low   3     0.00   6.85  27.37  34.38  25.78   5.62  0.00
     24  Apr_83  low   4     0.00  12.96  23.33  31.53  23.93   8.25  0.00
     25  Apr_83  low   5    48.89  21.18  14.60   8.84   5.59   0.90  0.00
     26  Apr_83  low   6     2.28  16.10  28.50  21.86  31.26   0.00  0.00
     27  Apr_83  low   7     0.00   0.00   7.41  13.74  61.81  15.53  1.51
     28  Apr_83  low   8     0.00   0.00   0.67   1.69  69.05  26.60  1.99
     29  Apr_83  low   9     0.00   0.00   0.16   2.51  67.24  28.25  1.84
     30  Apr_83  low   10    0.00   0.00   6.96   4.33  63.98  23.37  1.36
     31  Jul_83  high  1     0.00   6.07  25.05  30.62  22.50  15.76  0.00
     32  Jul_83  high  2     0.00   0.00   3.07  30.26  50.76  14.78  1.13
     33  Jul_83  high  3     0.00   9.15  49.60  33.54   6.14   1.57  0.00
     34  Jul_83  high  4     0.00   1.41  28.16  47.89  15.89   6.67  0.00
     35  Jul_83  high  5     4.73  24.22  52.31  16.95   1.79   0.00  0.00
     36  Jul_83  high  6     0.00   0.95  21.63  43.32  34.10   0.00  0.00
     37  Jul_83  high  7     0.00   0.00  16.28  38.86  41.86   2.81  0.19
     38  Jul_83  high  8     0.00   0.00  23.60  18.64  41.40  14.84  1.52
     39  Jul_83  high  9     0.00   0.00   0.55   3.13  40.65  49.83  5.84
     40  Jul_83  high  10    0.00   0.00   4.29  17.86  49.08  22.88  5.89
     41  Jul_83  med   1     0.00  13.43  37.74  24.28  16.06   8.49  0.00
     42  Jul_83  med   2     0.00   0.00   6.44  41.36  42.00   9.06  1.14
     43  Jul_83  med   3     0.00  26.69  48.82  20.74   3.25   0.50  0.00
     44  Jul_83  med   4     0.00   8.67  39.18  40.61   9.94   1.60  0.00
     45  Jul_83  med   5     0.11   4.19  37.63  44.87  13.20   0.00  0.00
     46  Jul_83  med   6     0.00   0.84  27.12  45.58  23.17   3.29  0.00
     47  Jul_83  med   7     0.00   0.00   9.61  39.08  49.33   1.24  0.74
     48  Jul_83  med   8     0.00   0.00  51.00   7.30  27.23  12.91  1.56
     49  Jul_83  med   9     0.00   0.00   1.37   1.59  30.88  58.22  7.95
     50  Jul_83  med   10    0.00   0.00  20.86  26.60  38.90  13.28  0.36
     51  Jul_83  low   1     0.00  20.23  48.92  22.19   6.14   2.52  0.00
     52  Jul_83  low   2     0.00   0.00   7.42  36.27  46.76   6.60  2.95
     53  Jul_83  low   3     0.00   4.21  25.35  49.01  18.98   2.45  0.00
     54  Jul_83  low   4     9.38  18.10  37.76  25.72   8.19   0.85  0.00
     55  Jul_83  low   5    45.12  24.36  21.41   6.98   2.13   0.00  0.00
     56  Jul_83  low   6     0.00   1.90  20.53  35.97  34.79   6.81  0.00
     57  Jul_83  low   7     0.00   0.00   0.77  17.18  72.24   9.76  0.05
     58  Jul_83  low   8     0.00   0.00  45.11   3.96  27.38  20.45  3.10
     59  Jul_83  low   9     0.00   0.00   3.25   5.91  47.85  39.96  3.03
     60  Jul_83  low   10    0.00   0.00  38.44  18.00  29.33  13.03  1.20
     61  Sep_83  high  1     0.00   3.59  21.76  43.03  25.80   5.82  0.00
     62  Sep_83  high  2     0.00   0.00   1.41  30.37  51.83  14.69  1.70
     63  Sep_83  high  3     0.00   2.13  43.29  46.32   7.81   0.45  0.00
     64  Sep_83  high  4     0.00   0.03  30.33  45.95  17.82   5.87  0.00
     65  Sep_83  high  5     3.78  17.27  48.65  25.68   4.62   0.00  0.00
     66  Sep_83  high  6     0.00   0.16   0.73  17.27  60.01  21.83  0.00
     67  Sep_83  high  7     0.00   0.00   0.17  21.50  61.20  16.95  0.18
     68  Sep_83  high  8     0.00   0.00   7.68   9.76  62.36  18.55  1.65
     69  Sep_83  high  9     0.00   0.00   0.38   0.79  29.99  60.09  8.75
     70  Sep_83  high  10    0.00   0.00   9.75  26.73  48.52  12.26  2.74
     71  Sep_83  med   1     0.00   9.96  27.07  40.04  17.88   5.05  0.00
     72  Sep_83  med   2     0.00   0.00   4.63  32.35  41.95  18.59  2.48
     73  Sep_83  med   3     0.00   8.16  43.41  36.72  10.63   1.08  0.00
     74  Sep_83  med   4     0.00  20.14  42.98  28.35   8.48   0.05  0.00
     75  Sep_83  med   5     3.40  11.67  33.41  29.65  16.93   4.94  0.00
     76  Sep_83  med   6     0.00   0.00   0.00   0.00   0.00   0.00  0.00
     77  Sep_83  med   7     0.00   0.00  16.02  28.99  47.60   6.95  0.44
     78  Sep_83  med   8     0.00   0.00  12.71   2.03  37.32  42.56  5.38
     79  Sep_83  med   9     0.00   0.00   9.95   7.54  40.85  37.67  3.99
     80  Sep_83  med   10    0.00   0.00  72.70   7.21  11.37   7.98  0.74
     81  Sep_83  low   1    41.10  11.19  13.21  12.61  19.92   1.97  0.00
     82  Sep_83  low   2     0.00   0.00   2.98  21.56  40.99  29.04  5.43
     83  Sep_83  low   3    16.07  39.34  30.76  10.10   3.22   0.51  0.00
     84  Sep_83  low   4    36.86  15.31  18.45  18.00   9.94   1.44  0.00
     85  Sep_83  low   5     6.23  11.96  31.35  32.73  17.73   0.00  0.00
     86  Sep_83  low   6     0.34   3.74  23.84  27.23  34.37  10.48  0.00
     87  Sep_83  low   7     0.00   0.00   4.69  16.99  58.91  17.79  1.62
     88  Sep_83  low   8     0.00   0.00   1.84   1.80  41.00  49.45  5.91
     89  Sep_83  low   9     0.00   0.00   2.18   3.60  38.32  49.39  6.51
     90  Sep_83  low   10    0.00   0.00  16.85   6.26  40.08  33.29  3.52

/* Data courtesy of Dr. G. N. Nayak, Gao University, India.  The variables
are: id, season, tide, station, x1-x7. */


CHAPTER 5 (Discriminant Analysis) Programs and Data Sets:


/* Program 5.1 */

filename gsasfile "prog51.graph";
goptions reset=all gaccess=gsasfile gsfmode = append
autofeed dev = pslmono;
goptions horigin =1in vorigin = 2in;
goptions hsize=6in vsize = 8in;
options ls = 64 ps=45 nodate nonumber;

title1 ' ';
title2 j = l  'Output 5.1';
data beetles;
infile 'beetle.dat' firstobs=7;
input species  x1 x2;

proc format;
value specname
1 = 's1'
2 = 's2'
3 = 's3' ;
value specchar
1 = '1'
2 = '2'
3 = '3' ;
run;

proc gchart data = beetles;
by species ;
vbar x1 /subgroup = species midpoints = 115 to 160 ;
format species specchar. ;
title1 h = 1.2 'Histogram for X1';
title2 j = l 'Output 5.1';
run;

proc gchart data = beetles;
vbar x1 /subgroup = species midpoints = 115 to 160 ;
format species specchar. ;
title1 h = 1.2 'Histogram for X1';
title2 j = l 'Output 5.1';
run;

proc gchart data = beetles;
by species ;
vbar x2 /subgroup = species midpoints = 7 to 21 ;
format species specchar. ;
title1 h = 1.2 'Histogram for X2';
title2 j = l 'Output 5.1';
run;

proc gchart data = beetles;
vbar x2 /subgroup = species midpoints = 7 to 21 ;
format species specchar. ;
title1 h = 1.2 'Histogram for X2';
title2 j = l 'Output 5.1';
run;


/* Graphical Test for multivariate Normality */

data s1;set beetles;if species = 1 ;
data s2;set beetles;if species = 2 ;
data s3;set beetles;if species = 3 ;

proc princomp data=s1 n= 2 cov std out=b1 noprint;
var x1 x2;
data chiq1;
set b1;
dsq=uss(of prin1-prin2);
proc sort;
by dsq;
proc means noprint;
var dsq;
output out=chiq1n n=totn;
data chiqq1;
if(_n_=1) then set chiq1n;
set chiq1;

novar=2; /* novar=number of variables. */
chisq=cinv(((_n_-.5)/ totn),novar);
if mod(_n_,2)=0 then chiline=chisq;

proc gplot;
plot dsq*chisq chiline*chisq/overlay vaxis = axis1 haxis = axis2 ;
     axis1 label = (a = 90 h= 1.2 'Mahalanobis D Square');
axis2 offset = (2) label = (h= 1.2 'Chi-Square Quantile');
symbol1 v=star;
symbol2 i=join v=+;
title1 h=1.2 'Q-Q Plot for Assessing Normality';
title2 j = l 'Output 5.1';
title3 'SPECIES = 1';
run;

proc princomp data=s2 n= 2 cov std out=b2 noprint;
var x1 x2;
data chiq2;
set b2;

dsq=uss(of prin1-prin2);
proc sort;
by dsq;
proc means noprint;
var dsq;
output out=chiq2n n=totn;
data chiqq2;
if(_n_=1) then set chiq2n;
set chiq2;
novar=2; /* novar=number of variables. */
chisq=cinv(((_n_-.5)/ totn),novar);
if mod(_n_,2)=0 then chiline=chisq;

proc gplot;
plot dsq*chisq chiline*chisq/overlay vaxis = axis1 haxis = axis2 ;
     axis1 label = (a = 90 h= 1.2 'Mahalanobis D Square');
axis2 offset = (2) label = (h= 1.2 'Chi-Square Quantile');
symbol1 v=star;
symbol2 i=join v=+;
title1 h=1.2 'Q-Q Plot for Assessing Normality';
title2 j = l 'Output 5.1';
title3 'SPECIES = 2';
run;

proc princomp data=s3 n= 2 cov std out=b3 noprint;
var x1 x2;
data chiq3;
set b3;

dsq=uss(of prin1-prin2);
proc sort;
by dsq;
proc means noprint;
var dsq;
output out=chiq3n n=totn;
data chiqq3;
if(_n_=1) then set chiq3n;
set chiq3;

novar=2; /* novar=number of variables. */
chisq=cinv(((_n_-.5)/ totn),novar);
if mod(_n_,2)=0 then chiline=chisq;


proc gplot;
plot dsq*chisq chiline*chisq/overlay vaxis = axis1 haxis = axis2 ;
     axis1 label = (a = 90 h= 1.2 'Mahalanobis D Square');
axis2 offset = (2) label = (h= 1.2 'Chi-Square Quantile');
symbol1 v=star;
symbol2 i=join v=+;
title1 h=1.2 'Q-Q Plot for Assessing Normality';
title2 j = l 'Output 5.1';
title3 'SPECIES = 3';
run;

/* In this program we are testing for the multivariate
normality of Beetles Data using the Mardia's skewness
and kurtosis measures */

title1 'Output 5.1';
title2 h = 1.5 "Mardia's Tests for Skewness and Kurtosis";
title3 ' ';
proc iml ;
y1 ={
150 15,
147 13, 144 14, 144 16, 153 13,
140 15, 151 14, 143 14, 144 14,
142 15, 141 13, 150 15, 148 13,
154 15, 147 14, 137 14, 134 15,
157 14, 149 13, 147 13, 148 14
} ;

y2 ={
120 14,
123 16, 130 14, 131 16, 116 16,
122 15, 127 15, 132 16, 125 14,
119 13, 122 13, 120 15, 119 14,
123 15, 125 15, 125 14, 129 14,
130 13, 129 13, 122 12, 129 15,
124 15, 120 13, 119 16, 119 14,
133 13, 121 15, 128 14, 129 14
} ;

y3 ={
124 13, 129 14, 145 8, 140 11,
140 11, 131 10, 139 11, 139 10,
136 12, 129 11, 140 10, 137 9,
141 11, 138 9, 143 9, 142 11,
144 10, 138 10, 140 10, 130 9,
137 11, 137 10, 136 9, 140 10
};
do times = 1 to 3;
if times = 1 then do ;
n = nrow(y1) ;
p = ncol(y1) ;
dfchi = p*(p+1)*(p+2)/6 ;
q = i(n) - (1/n)*j(n,n,1) ;
s = (1/(n))*y1`*q*y1 ;
s_inv = inv(s) ;
g_matrix = q*y1*s_inv*y1`*q ;
end ;
else if times = 2 then do ;
n = nrow(y2) ;
p = ncol(y2) ;
dfchi = p*(p+1)*(p+2)/6 ;
q = i(n) - (1/n)*j(n,n,1) ;
s = (1/(n))*y2`*q*y2 ;
s_inv = inv(s) ;
g_matrix = q*y2*s_inv*y2`*q ;
end ;
else if times = 3 then do ;
n = nrow(y3) ;
p = ncol(y3) ;
dfchi = p*(p+1)*(p+2)/6 ;
q = i(n) - (1/n)*j(n,n,1) ;
s = (1/(n))*y3`*q*y3 ;
s_inv = inv(s) ;
g_matrix = q*y3*s_inv*y3`*q ;
end ;
beta1hat = (  sum(g_matrix#g_matrix#g_matrix)  )/(n*n)  ;
beta2hat =trace(  g_matrix#g_matrix  )/n ;
kappa1 = n*beta1hat/6 ;
kappa2 = (beta2hat - p*(p+2) ) /sqrt(8*p*(p+2)/n) ;
pvalskew = 1 - probchi(kappa1,dfchi) ;
pvalkurt = 2*( 1 - probnorm(abs(kappa2))  ) ;

print 'Species = ' times ;
print s ;
print s_inv ;
print beta1hat kappa1  pvalskew ;
print beta2hat  kappa2  pvalkurt ;
end ;

/* BEETLE DATA SET: beetle.dat */

1 150 15
1 147 13
1 144 14
1 144 16
1 153 13
1 140 15
1 151 14
1 143 14
1 144 14
1 142 15
1 141 13
1 150 15
1 148 13
1 154 15
1 147 14
1 137 14
1 134 15
1 157 14
1 149 13
1 147 13
1 148 14

2 120 14
2 123 16
2 130 14
2 131 16
2 116 16
2 122 15
2 127 15
2 132 16
2 125 14
2 119 13
2 122 13
2 120 15
2 119 14
2 123 15
2 125 15
2 125 14
2 129 14
2 130 13
2 129 13
2 122 12
2 129 15
2 124 15
2 120 13
2 119 16
2 119 14
2 133 13
2 121 15
2 128 14
2 129 14
2 124 13
2 129 14
3 145 8
3 140 11
3 140 11
3 131 10
3 139 11
3 139 10
3 136 12
3 129 11
3 140 10
3 137 9
3 141 11
3 138 9
3 143 9
3 142 11
3 144 10
3 138 10
3 140 10
3 130 9
3 137 11
3 137 10
3 136 9
3 140 10

/* Source: Lubischew (1962, Biometrics).
(Variables: species, x1, x2).  Reproduced by
permission of the International Biometric Society.*/ 


/* Program 5.2 */

filename gsasfile "prog52.graph";
goptions reset=all gaccess=gsasfile gsfmode = append
autofeed dev = pslmono;
goptions horigin =1in vorigin = 2in;
goptions hsize=6in vsize = 8in;

options ls = 64 ps=45 nodate nonumber;
title1 ' ';
title2 j = l  'Output 5.2';

data urine;
infile 'urine.dat' firstobs=7;
input crystals $ sg ph mosm mmho urea calcium ;
patient = _n_ ;
sg100 = 100*sg;
ph10=100*ph;
mmho10 =10*mmho ;
cal100=100*calcium ;

proc format;
value specchar
1 = 'yes'
0 = 'no'
run;

proc gchart data = urine ;by crystals ;
vbar calcium /subgroup = crystals midpoints = 0 to 15 ;
title1 h= 1.2 ' Urine Data: Univariate Frequency Chart for Calcium' ;
title2 j = l 'Output 5.2';
run;

proc gchart data = urine ;by crystals ;
vbar ph /subgroup = crystals midpoints = 4 to 8 by .5;
title1 h= 1.2 ' Urine Data: Univariate Frequency Chart for pH' ;
title2 j = l 'Output 5.2';
run;

proc gchart data = urine ;by crystals ;
vbar urea /subgroup = crystals midpoints = 100 to 500 by 25;
title1 h = 1.2 ' Urine Data: Univariate Frequency Chart for Urea' ;
title2 j = l 'Output 5.2';
run;


/* CRYSTALS IN URINE DATA: urine.dat */

no 1.021 4.91 725 . 443 2.45
no 1.017 5.74 577 20 296 4.49
no 1.008 7.2 321 14.9 101 2.36
no 1.011 5.51 408 12.6 224 2.15
no 1.005 6.52 187 7.5 91 1.16
no 1.020 5.27 668 25.3 252 3.34
no 1.012 5.62 461 17.4 195 1.40
no 1.029 5.67 1107 35.9 550 8.48
no 1.015 5.41 543 21.9 170 1.16
no 1.021 6.13 779 25.7 382 2.21
no 1.011 6.19 345 11.5 152 1.93
no 1.025 5.53 907 28.4 448 1.27
no 1.006 7.12 242 11.3 64 1.03
no 1.007 5.35 283 9.9 147 1.47
no 1.011 5.21 450 17.9 161 1.53
no 1.018 4.90 684 26.1 284 5.09
no 1.007 6.63 253 8.4 133 1.05
no 1.025 6.81 947 32.6 395 2.03
no 1.008 6.88 395 26.1 95 7.68
no 1.014 6.14 565 23.6 214 1.45
no 1.024 6.30 874 29.9 380 5.16
no 1.019 5.47 760 33.8 199 0.81
no 1.014 7.38 577 30.1 87 1.32
no 1.020 5.96 631 11.2 422 1.55
no 1.023 5.68 749 29.0 239 1.52
no 1.017 6.76 455 8.8 270 0.77
no 1.017 7.61 527 25.8 75 2.17
no 1.010 6.61 225 9.8 72 0.17
no 1.008 5.87 241 5.1 159 0.83
no 1.020 5.44 781 29.0 349 3.04
no 1.017 7.92 680 25.3 282 1.06
no 1.019 5.98 579 15.5 297 3.93
no 1.017 6.56 559 15.8 317 5.38
no 1.008 5.94 256 8.1 130 3.53
no 1.023 5.85 970 38.0 362 4.54
no 1.020 5.66 702 23.6 330 3.98
no 1.008 6.40 341 14.6 125 1.02
no 1.020 6.35 704 24.5 260 3.46
no 1.009 6.37 325 12.2 97 1.19
no 1.018 6.18 694 23.3 311 5.64
no 1.021 5.33 815 26.0 385 2.66
no 1.009 5.64 386 17.7 104 1.22
no 1.015 6.79 541 20.9 187 2.64
no 1.010 5.97 343 13.4 126 2.31
no 1.020 5.68 876 35.8 308 4.49
yes 1.021 5.94 774 27.9 325 6.96
yes 1.024 5.77 698 19.5 354 13.00
yes 1.024 5.60 866 29.5 360 5.54
yes 1.021 5.53 775 31.2 302 6.19
yes 1.024 5.36 853 27.6 364 7.31
yes 1.026 5.16 822 26.0 301 14.34
yes 1.013 5.86 531 21.4 197 4.74
yes 1.010 6.27 371 11.2 188 2.50
yes 1.011 7.01 443 21.4 124 1.27
yes 1.022 6.21 . 20.6 398 4.18
yes 1.011 6.13 364 10.9 159 3.10
yes 1.031 5.73 874 17.4 516 3.01
yes 1.020 7.94 567 19.7 212 6.81
yes 1.040 6.28 838 14.3 486 8.28
yes 1.021 5.56 658 23.6 224 2.33
yes 1.025 5.71 854 27.0 385 7.18
yes 1.026 6.19 956 27.6 473 5.67
yes 1.034 5.24 1236 27.3 620 12.68
yes 1.033 5.58 1032 29.1 430 8.94
yes 1.015 5.98 487 14.8 198 3.16
yes 1.013 5.58 516 20.8 184 3.30
yes 1.014 5.90 456 17.8 164 6.99
yes 1.012 6.75 251 5.1 141 .65
yes 1.025 6.90 945 33.6 396 4.18
yes 1.026 6.29 833 22.2 457 4.45
yes 1.028 4.76 312 12.4 10 .27
yes 1.027 5.40 840 24.5 395 7.64
yes 1.018 5.14 703 29.0 272 6.63
yes 1.022 5.09 736 19.8 418 8.53
yes 1.025 7.90 721 23.6 301 9.04
yes 1.017 4.81 410 13.3 195 0.58
yes 1.024 5.40 803 21.8 394 7.82
yes 1.016 6.81 594 21.4 255 12.20
yes 1.015 6.03 416 12.8 178 9.39

/* Data courtesy of Dr. D. P. Byar formerly of National
Cancer Institute.  Also available in Andrews and
Herzberg's Data (1985).  (Physical characteristics of
urine with and without crystals;  Variables: crystals
sg ph mosm mmho urea calcium). */


/* Program 5.3 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.3';

data beetles;
infile 'beetle.dat' firstobs=7;
input species  x1 x2 ;

proc discrim data = beetles method = normal pool =test
                                 wcov pcov bcov manova ;
class species ;
var x1 x2 ;
title2 'Testing the Equality of Normal Population Parameters';
run; 



/* Program 5.4 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.4';

/* Following program tests the equality of  means
assuming unequal Covariance Matrices */

data admsion;
infile 'admission.dat' firstobs=7;
input status $ gpa gmat ;

*Here we test the Equality of Covariance matrices
assuming multivariate normality for each of the
three populations ;

proc discrim data = admsion method = normal pool =test wcov pcov bcov ;
class status ;
var gpa gmat ;
prior equal ;
title2 'Test the Equality of Covariance Matrices' ;
run;

* Here we test the Equality of mean vectors assuming
the Unequal Covariance Matrices, using the
Anderson's (1963) test under multivariate normality of
the populations;

title2 'Test the Equality of Mean vectors' ;
proc sort data = admsion ;
by status;
proc means data = admsion;
by status;
var gpa gmat;

data yes;
set admsion ;
if status = 'yes';
ygpa = gpa;
ygmat = gmat;
sr=_n_;
drop gpa gmat;
run;

data no;
set admsion ;
if status = 'no';
ngpa = gpa;
ngmat = gmat;
sr=_n_;
drop gpa gmat;
run;

data border;
set admsion ;
if status = 'border';
bgpa = gpa;
bgmat = gmat;
sr=_n_;
drop gpa gmat;
run;

proc sort data = yes ;
by sr;

proc sort data = no ;
by sr;

proc sort data = border ;
by sr;

data all;
set yes;
set no;
set border;
run;

data all;
set all;
n1 = 31;
n2=28;
n3 = 26;
smallest = min(n1,n2,n3) ;

y_tave1 = 340.3871 ;
y_tave2 = 561.2258 ;

y_pave1 = 337.5000 ;
y_pave2 = 561.3846 ;

yes1 =
bgpa -(sqrt(smallest/n1))*( ygpa - y_tave1
+ (sqrt(n1/smallest))*y_tave2  ) ;
yes2 =
bgmat-(sqrt(smallest/n1))*( ygmat - y_pave1
+ (sqrt(n1/smallest))*y_pave2  ) ;

n_tave1 = 248.2500 ;
n_tave2 = 447.0714 ;

n_pave1 = 245.2308 ;
n_pave2 = 452.0385 ;

no1 =
bgpa -(sqrt(smallest/n2))*( ngpa - n_tave1
+ (sqrt(n2/smallest))*n_tave2  ) ;
no2 =
bgmat-(sqrt(smallest/n2))*( ngmat - n_pave1
+ (sqrt(n2/smallest))*n_pave2  ) ;
run;

proc glm data = all; class status;
model yes1 yes2 no1 no2 = /nouni;
manova h = intercept/ printe printh;
title2 'Test the Equality of Mean Vectors: Unequal Covariance' ;
run; 

/* ADMISSION DATA SET: admission.dat */

yes 296 596
yes 314 473
yes 322 482
yes 329 527
yes 369 505
yes 346 693
yes 303 626
yes 319 663
yes 363 447
yes 359 588
yes 330 563
yes 340 553
yes 350 572
yes 378 591
yes 344 692
yes 348 528
yes 347 552
yes 335 520
yes 339 543
yes 328 523
yes 321 530
yes 358 564
yes 333 565
yes 340 431
yes 338 605
yes 326 664
yes 360 609
yes 337 559
yes 380 521
yes 376 646
yes 324 467

no 254 446
no 243 425
no 220 474
no 236 531
no 257 542
no 235 406
no 251 412
no 251 458
no 236 399
no 236 482
no 266 420
no 268 414
no 248 533
no 246 509
no 263 504
no 244 336
no 213 408
no 241 469
no 255 538
no 231 505
no 241 489
no 219 411
no 235 321
no 260 394
no 255 528
no 272 399
no 285 381
no 290 384

border 286 494
border 285 496
border 314 419
border 328 371
border 289 447
border 315 313
border 350 402
border 289 485
border 280 444
border 313 416
border 301 471
border 279 490
border 289 431
border 291 446
border 275 546
border 273 467
border 312 463
border 308 440
border 303 419
border 300 509
border 303 438
border 305 399
border 285 483
border 301 453
border 303 414
border 304 446

/* Source: Johnson and Wichern (1998).
(Variables are Admission status, GPA and GMAT
scores of students).  Reproduced by permission
of Prentice Hall International, Inc. */


/* Program 5.5 */

options ls = 64 ps=45 nodate nonumber;
title1 'Output 5.5';

data beetles;
infile 'beetle.dat' firstobs=7;
input species  x1 x2 ;

/* Here we perform Fisher's discriminant analysis for
two groups of species  namely species 1 and 2 */

proc sort data = beetles; by species;
data fishrldf;set beetles; if species ne 3 ;

proc discrim data = fishrldf out = fout outstat =fstat
method = normal list pool =yes pcov manova ;
class species ;
priors equal ;
var x1 x2 ;
title2 'Discriminant Analysis of Beetles Data: Two Groups';

proc print data = fout;
title2 'Classification Details';

proc print data = fstat;
title2 'Summary Statistics: Two Group Discriminant Analysis';


/* Program 5.6 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.6';

data beetles;
infile 'beetle.dat' firstobs=7;
input species  x1 x2 ;

/* y = n2/(n1+n2) for species 1 */
if species = 1 then y = 31/52;

/* y =-n1/(n1+n2) for species 2 */
if species = 2 then y = -21/52;

proc sort data = beetles; by species;
data fishrldf;set beetles; if species ne 3 ;

proc reg data =beetles;
model y = x1 x2;
output out = b p=yhat;
title2 'Regression Approach to Discrimination: Beetles Data';

proc print data = b;
title2 'Classification: Dummy Response Variable'; 


/* Program 5.7 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.7';

data beetles;
infile 'beetle.dat' firstobs=7;
input species  x1 x2 ;

/* Here we use LDF for the discriminant analysis on
the three groups of Flea Beetles */

proc discrim data = beetles out = beetout outstat =bstat
method = normal list pool =yes pcov manova ;
class species ;
priors prop ;
var x1 x2 ;
title2 'Discriminant Analysis of Beetles Data: Three Groups';

data grid;
do x1 = 110 to  160 by .1;
do x2 = 6 to 20 by .05 ;
output;end;end;

title2 h = 1.5 'Linear Discriminant Functions: Beetles Data';
proc discrim data = beetles method = normal pool = yes
            testdata = grid testout = plotc short noclassify;
class species;
var x1 x2;
priors prop;
run;

proc plot data = plotc;
 plot x1*x2 = _into_ ;
title2 h = 1.5 'Linear Discriminant Functions: Beetles Data';


/* Program 5.8 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.8';

data cushing;
infile 'cushing.dat' firstobs = 7;
input type $ tetra preg ;
logtetra = log(tetra);logpreg =log(preg);

data undgnosd;
input tetra preg ;
logtetra = log(tetra);logpreg =log(preg);
lines;
5.1 0.4
12.9 5.0
13.0 0.8
2.6 0.1
30.0 0.1
20.5 0.8
;
/*
Data from Aitchison and Dunsmore (1975),
reprinted with permission from Cambridge University Press
*/

proc discrim data = Cushing pool=test out = cushout
outstat = cushstat method = normal testdata = undgnosd
list testlist wcov;
class type ;
priors prop ;
var logtetra logpreg ;
title2 'Cushing Syndrome Data: Quadratic Discrimination';

data grid;
do logtetra = 0 to log(56) by .1;
do logpreg = log(.1) to log(18) by .05 ;
output;end;end;

title2 h = 1.5 'Quadratic Discriminant Functions: Cushing Data';
proc discrim data = cushing method = normal pool = no
testdata = grid testout = plotc short noclassify;
class type;
var logtetra logpreg;
priors prop;
run;

proc plot data = plotc;
plot logtetra * logpreg = _into_ ;
run;

title2 h = 1.5 'Linear Discriminant Functions: Cushing Data';
proc discrim data = cushing method = normal pool = yes
testdata = grid testout = plotclin short noclassify;
class type;
var logtetra logpreg;
priors prop;
run;

proc plot data = plotclin;
plot logtetra * logpreg = _into_ ; 


/* CUSHING SYNDROME DATA SET: cushing.dat */

a 3.1 11.7
a 3.0 1.3
a 1.9 .1
a 3.8 .04
a 4.1 1.1
a 1.9 .4
b  8.3 1
b  3.8 .2
b  3.9 .6
b  7.8 1.2
b  9.1 .6
b  15.4 3.6
b  7.7 1.6
b  6.5 .4
b  5.7 .4
b  13.6 1.6
c 10.2 6.4
c 9.2 7.9
c 9.6 3.1
c 53.8 2.5
c 15.8 7.6

/* Source: Aitchison and Dunsmore (1975).
(Variables are type of syndromes and two measurements on
urinary extraction rates namely, Tetrahydrocortisone
(tetra) and Pregnanetriol ( preg)).  Reprinted by
permission of Cambridge University Press. */ 


/* Program 5.9 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.9';

data Shumway;
infile 'earthquake.dat' firstobs = 7;
input popn $  body surface;
if popn = 'equake' then populatn = 'q';
if popn = 'explosn' then populatn = 'x';

proc discrim data = shumway method = normal pool =test wcov list;
class popn ;
var body surface;
priors 'equake' = .5714 'explosn' = .4286 ;
title2 "Discriminant Analysis with Cost Considerations";
title3 "Earth Quakes vs. Nuclear Explosions";

proc sort data = shumway ; by populatn;

data grid;
do body = 5 to 10 by .1;
do surface = 3 to 6 by .1 ;
output;end;end;

title2 h = 1.5 'Quadratic Discriminant Functions';
title3 h = 1.5 'Earth Quakes vs. Nuclear Explosions';

proc discrim data = shumway method = normal pool = no
testdata = grid testout = plotc short noclassify;
class populatn;
var body surface;
priors 'q' = .5714 'x' = .4286 ;
run;

proc plot data = plotc;
plot surface * body = _into_ ;
title2 h = 1.5 'Plot of Quadratic Discriminant Regions';
title3 h = 1.5 'Earth Quakes vs. Nuclear Explosions';


/* EARTHQUAKE DATA: earthquake.dat */

equake 5.60 4.25
equake 5.18 3.93
equake 6.31 6.30
equake 5.36 4.49
equake 5.96 6.39
equake 5.26 4.42
equake 5.17 5.10
equake 4.75 4.40
equake 5.35 5.49
equake 5.01 4.48
equake 5.27 4.41
equake 5.27 4.69
equake 4.98 3.66
equake 5.22 3.99
equake 5.06 4.58
equake 5.09 4.90
equake 5.15 4.82
equake 4.56 4.08
equake 5.00 4.94
equake 5.43 5.48
explosn 6.04 4.33
explosn 5.97 4.39
explosn 5.84 4.35
explosn 5.79 4.14
explosn 5.87 3.90
explosn 6.51 4.49
explosn 5.74 4.22
explosn 5.98 4.08
explosn 6.07 4.30

/* Source: Shumway (1988).
(Variables are the population (Nuclear explosion vs.
Earthquake) and two seismological features namely body
wave magnitude and surface wave magnitude).  Reproduced
by permission of the Prentice Hall International, Inc. */


/* Program 5.10 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.10';

data v_accep(type=cov) ;
infile cards missover;

input l a b ;
length _name_ _type_ $  8.;
_type_ = 'cov' ;
if _n_ = 1 then _name_ = 'l' ;
if _n_ = 2 then _name_ = 'a' ;
if _n_ = 3 then _name_ = 'b' ;
if _n_=4 then _type_='n';
else if _n_=5 then _type_='mean'; else _type_='cov';
lines;
.102
.018 .229
-.029 .039 .093
40 40 40
-.146 -.543 -.073
;

data v_unacce(type=cov) ;
infile cards missover;
input l a b ;
length _name_ _type_ $  8.;
_type_ = 'cov' ;
if _n_ = 1 then _name_ = 'l' ;
if _n_ = 2 then _name_ = 'a' ;
if _n_ = 3 then _name_ = 'b' ;
if _n_=4 then _type_='n';
 else if _n_=5 then _type_='mean'; else _type_='cov';
lines;
.337
.338 .879
.034 .077 .271
71 71 71
-.248 -.622 -.004
;
/*
Data from Vance (1983),
printed with permission from Modern Paint and Coatings,
Intertec Publishing Corp., Atlanta.
*/

data concat; set v_accep(in = gp1) v_unacce(in = gp2);
if gp1 then group = 'grp1';
else group = 'grp2';

proc print data=concat;
title2 'Summary Statistics on both Groups';

proc discrim data=concat(type=cov) method=normal pool=test
outstat = c_stat;
class group ;
priors equal ;
var l a b  ;
title2 'Discriminant Analysis for Numerical Color Tolerances';

proc print data = c_stat;
title2 'Coefficients for the Quadratic Discriminant function';


/* Program 5.11 */

filename gsasfile "prog511.graph";
goptions reset=all gaccess=gsasfile gsfmode = append
autofeed dev = pslmono;
goptions horigin =1in vorigin = 2in;
goptions hsize=6in vsize = 8in;
options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.11';

data fox;
infile 'satellite.dat' firstobs = 7;
input smpltype $ tm1 tm2 tm3 tm4 tm5 tm7 ;

if smpltype = 'limeston' then mark = 'L';
if smpltype = 'gypsum' then mark = 'G';
if smpltype = 'sandston' then mark = 'S';
if smpltype = 'carbonat' then mark = 'C';
if smpltype = 'm_basalt' then mark = 'M';
if smpltype = 'i_dacite' then mark = 'I';

proc candisc data = fox out = outcan bsscp pcov pcorr ;
class smpltype;
var tm1 tm2 tm3 tm4 tm5 tm7 ;
title2 'Canonical Discriminant Analysis: Landsat Thematic Mapper Data';

proc sort data = outcan;
by mark;
proc print data = outcan ;
var smpltype mark can1 can2 can3 can4 can5;
title2 'Scores on Canonical Variables: Landsat Thematic Mapper Data';
run;

symbol1 value = C ;
symbol2 value = G ;
symbol3 value = I ;
symbol4 value = L ;
symbol5 value = M ;
symbol6 value = S ;

proc gplot data = outcan;
where mark = "C" or mark = "G" or mark = "I" or
mark = "L" or mark = "M" or mark = "S";
plot  can2*can1 = mark;
title1 h = 1.2 'Plot of First Two Canonical Variables';
title2 j= l 'Output 5.11';
run;

proc gplot data = outcan;
where mark = "C" or mark = "G" or mark = "I" or
mark = "L" or mark = "M" or mark = "S";plot can3*can1 = mark ;
title1 h = 1.2 'Plot of First and Third Canonical Variables';
title2 j= l 'Output 5.11';
run;

proc gplot data = outcan;
where mark = "C" or mark = "G" or mark = "I" or
mark = "L" or mark = "M" or mark = "S";
plot can4*can1 = mark ;
title1 h = 1.2 'Plot of First and Fourth Canonical Variables';
title2 j= l 'Output 5.11';
run;

proc gplot data = outcan;
where mark = "C" or mark = "G" or mark = "I" or
mark = "L" or mark = "M" or mark = "S";
plot can3*can2 = mark ;
title1 h = 1.2 'Plot of Second and Third Canonical Variables';
title2 j= l 'Output 5.11';
run;

proc gplot data = outcan;
where mark = "C" or mark = "G" or mark = "I" or
mark = "L" or mark = "M" or mark = "S";
plot can4*can2 = mark ;
title1 h = 1.2 'Plot of Second and Fourth Canonical Variables';
title2 j= l 'Output 5.11';
run;

proc gplot data = outcan;
where mark = "C" or mark = "G" or mark = "I" or
mark = "L" or mark = "M" or mark = "S";
plot can4*can3 = mark ;
title1 h = 1.2 'Plot of Third and Fourth Canonical Variables';
title2 j= l 'Output 5.11';
run; 

/* LANDSAT SATELLITE DATA: satellite.dat */

limeston 158 82 114 108 250 139
limeston 159 81 114 109 255 148
limeston 136 64 84 74 174 102
limeston 189 100 140 130 254 131
limeston 177 91 121 110 249 143
limeston 190 104 139 120 248 141
limeston 184 99 133 116 241 134
limeston 213 119 158 136 254 136
limeston 225 122 159 136 253 132
limeston 182 97 141 129 255 152
limeston 184 99 142 128 238 138
limeston 183 96 141 125 216 128

gypsum 223 119 160 141 208 79
gypsum 228 125 172 152 234 98
gypsum 223 119 161 141 223 92
gypsum 221 118 162 142 223 96
gypsum 234 124 165 144 238 93
gypsum 216 115 158 138 228 102
gypsum 220 117 156 137 238 104
gypsum 212 111 148 129 207 85

sandston 144 73 108 95 171 100
sandston 152 77 111 100 198 117
sandston 153 77 105 102 245 149
sandston 142 72 99 88 155 96
sandston 142 71 97 85 158 98
sandston 139 80 140 131 233 136
sandston 141 79 132 123 235 138
carbonat 251 144 190 165 251 162
carbonat 242 133 180 153 255 162
carbonat 198 116 166 150 255 168
carbonat 240 136 187 163 255 171
carbonat 246 141 188 164 255 164
carbonat 235 131 180 157 255 166
carbonat 194 110 161 147 254 166

m_basalt 121 54 64 53 134 93
m_basalt 117 51 61 50 75 41
m_basalt 111 49 65 59 127 81
m_basalt 111 46 55 44 72 39
m_basalt 114 48 58 47 77 43
m_basalt 119 53 66 54 84 49
m_basalt 127 60 76 62 91 53
m_basalt 123 55 69 56 90 52

i_dacite 132 62 83 78 215 131
i_dacite 121 56 75 70 178 114
i_dacite 152 72 95 84 201 124
i_dacite 123 56 76 72 168 108
i_dacite 165 81 98 80 132 60
i_dacite 167 87 108 91 157 73
i_dacite 123 58  75 65 138 88
i_dacite 177 91 119 105 170 81
i_dacite 125 58 74 62 129 80

Source: Fox (1993, Landsat Thematic Mapper satellite data).
(Variables are type of rock/mineral and six geological
measurements).


/* Program 5.12 */

options ls = 64 ps=45 nodate nonumber;
title1 j=l 'Output 5.12';

data horton;
infile 'soil.dat' firstobs = 7;
input soil_grp $ ph_value nitro bulk_dct phospho
ca mg k na condctvt;

proc stepdisc data = horton bcov pcov pcorr method = backward
slstay =.15;
class soil_grp ;
var ph_value nitro phospho bulk_dct ca mg k na condctvt;
title2 "Backward Selection of Variables: Soil Data" ;
run;


/* SOIL DATA: soil.dat */

1 5.40 .188 .92 215 16.35 7.65 .72 1.14 1.09
1 5.65 .165 1.04 208 12.25 5.15 .71 .94 1.35
1 5.14 .260 .95 300 13.02 5.68 .68 .60 1.41
1 5.14 .169 1.10 248 11.92 7.88 1.09 1.01 1.64
2 5.14 .164 1.12 174 14.17 8.12 .70 2.17 1.85
2 5.10 .094 1.22 129 8.55 6.92 .81 2.67 3.18
2 4.70 .100 1.52 117 8.74 8.16 .39 3.32 4.16
2 4.46 .112 1.47 170 9.49 9.16 .70 3.76 5.14
3 4.37 .112 1.07 121 8.85 10.35 .74 5.74 5.73
3 4.39 .058 1.54 115 4.73 6.91 .77 5.85 6.45
3 4.17 .078 1.26 112 6.29 7.95 .26 5.30 8.37
3 3.89 .070 1.42 117 6.61 9.76 .41 8.30 9.21
4 3.88 .077 1.25 127 6.41 10.96 .56 9.67 10.64
4 4.07 .046 1.54 91 3.82 6.61 .50 7.67 10.07
4 3.88 .055 1.53 91 4.98 8.00 .23 8.78 11.26
4 3.74 .053 1.40 79 5.86 10.14 .41 11.04 12.15
5  5.11 .247 .94 261 13.25 7.55 .61 1.86 2.61
5  5.46 .298 .96 300 12.30 7.50 .68 2.00 1.98
5  5.61 .145 1.10 242 9.66 6.76 .63 1.01 .76
5  5.85 .186 1.20 229 13.78 7.12 .62 3.09 2.85
6  4.57 .102 1.37 156 8.58 9.92 .63 3.67 3.24
6  5.11 .097 1.30 139 8.58 8.69 .42 4.70 4.63
6  4.78 .122 1.30 214 8.22 7.75 .32 3.07 3.67
6  6.67 .083 1.42 132 12.68 9.56 .55 8.30 8.10
7  3.96 .059 1.53 98 4.80 10.00 .36 6.52 7.72
7  4.00 .050 1.50 115 5.06 8.91 .28 7.91 9.78
7  4.12 .086 1.55 148 6.16 7.58 .16 6.39 9.07
7  4.99 .048 1.46 97 7.49 9.38 .40 9.70 9.13
8  3.80 .049 1.48 108 3.82 8.80 .24 9.57 11.57
8  3.96 .036 1.28 103 4.78 7.29 .24 9.67 11.42
8  3.93 .048 1.42 109 4.93 7.47 .14 9.65 13.32
8  4.02 .039 1.51 100 5.66 8.84 .37 10.54 11.57
9  5.24 .194 1.00 445 12.27 6.27 .72 1.02 .75
9  5.20 .256 .78 380 11.39 7.55 .78 1.63 2.20
9  5.30 .136 1.00 259 9.96 8.08 .45 1.97 2.27
9  5.67 .127 1.13 248 9.12 7.04 .55 1.43 .67
10  4.46 .087 1.24 276 7.24 9.40 .43 4.17 5.08
10  4.91 .092 1.47 158 7.37 10.57 .59 5.07 6.37
10  4.79 .047 1.46 121 6.99 9.91 .30 5.15 6.82
10  5.36 .095 1.26 195 8.59 8.66 .48 4.17 3.65
11  3.94 .054 1.60 148 4.85 9.62 .18 7.20 10.14
11  4.52 .051 1.53 115 6.34 9.78 .34 8.52 9.74
11  4.35 .032 1.55 82 5.99 9.73 .22 7.02 8.60
11  4.64 .065 1.46 152 4.43 10.54 .22 7.61 9.09
12 3.82 .038 1.40 105 4.65 9.85 .18 10.15 12.26
12 4.24 .035 1.47 100 4.56 8.95 .33 10.51 11.29
12 4.22 .030 1.56 97 5.29 8.37 .14 8.27 9.51
12 4.41 .058 1.58 130 4.58 9.46 .14 9.28 12.69

/* Source: Horton, Russell, and Moore (1968).
(Variables are soil group, pH value, Nitrogen percentage,
Bulk density, Phosphorus in ppm, calcium, magnesium, potassium,
sodium, and conductivity).  Reproduced by permission of the
International Biometric Society. */ 


/* Program 5.13 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.13';

data horton;
input soil_grp $ ph_value nitro bulk_dct phospho
ca mg k na condctvt;
lines;
1 5.40 .188 .92 215 16.35 7.65 .72 1.14 1.09
1 5.65 .165 1.04 208 12.25 5.15 .71 .94 1.35

2 5.14 .164 1.12 174 14.17 8.12 .70 2.17 1.85
2 5.10 .094 1.22 129 8.55 6.92 .81 2.67 3.18

3 4.37 .112 1.07 121 8.85 10.35 .74 5.74 5.73
3 4.39 .058 1.54 115 4.73 6.91 .77 5.85 6.45

4 3.88 .077 1.25 127 6.41 10.96 .56 9.67 10.64
4 4.07 .046 1.54 91 3.82 6.61 .50 7.67 10.07
;
/*
Data from Horton et. al (1968),
reprinted with permission from International Biometric Society
*/

proc candisc data = horton out =a1 ncan =1;
class soil_grp;

var ph_value nitro bulk_dct ;
title2 'Discrimination of Soil Layers';
title3 "Statistics from Subset 1";

proc candisc data = horton out =a2 ncan =1;
class soil_grp;
var phospho ca mg ;
title2 'Discrimination of Soil Layers';
title3 "Statistics from Subset 2";

proc candisc data = horton out =a3 ncan =1;
class soil_grp;
var k na condctvt ;
title2 'Discrimination of Soil Layers';
title3 "Statistics from Subset 3";

data a1;
set a1;
d1 =can1;
keep soil_grp  d1;

data a2;
set a2;
d2 = can1;
keep soil_grp  d2;

data a3;
set a3;
d3 = can1;
keep soil_grp  d3;

data stage2;
merge a1 a2 a3 ;
by soil_grp;

proc discrim data = stage2
method =normal pool=yes short outstat = statall out = results;
class soil_grp;
var d1 d2 d3 ;
title2
'Discrimination Using 1st Canonical Variables';
title3 " ";
proc print data = results;
proc print data = statall;


/* Program 5.14 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.14';

data horton;
input soil_grp $ ph_value nitro bulk_dct phospho
ca mg k na condctvt;
z1 =ph_value;
z2= nitro;
z3 = bulk_dct;
z4=phospho;
z5 =ca;
z6 =mg;
z7 = k;
z8 =na;
z9 =condctvt;
lines;
1 5.40 .188 .92 215 16.35 7.65 .72 1.14 1.09
1 5.65 .165 1.04 208 12.25 5.15 .71 .94 1.35

2 5.14 .164 1.12 174 14.17 8.12 .70 2.17 1.85
2 5.10 .094 1.22 129 8.55 6.92 .81 2.67 3.18

3 4.37 .112 1.07 121 8.85 10.35 .74 5.74 5.73
3 4.39 .058 1.54 115 4.73 6.91 .77 5.85 6.45

4 3.88 .077 1.25 127 6.41 10.96 .56 9.67 10.64
4 4.07 .046 1.54 91 3.82 6.61 .50 7.67 10.07
;
/*
Data from Horton et. al (1968),
reprinted with permission from International Biometric Society.
*/

proc sort data = horton;
by soil_grp;
proc standard data = horton mean = 0 out =pc;
by soil_grp;
var z1-z9;
Title2 'Data on Nine Variables: Standardized for Group Means';
proc princomp data = pc cov out = pcoutput;
var z1-z9;

data horton;
set horton;
pc1 = -.002049*ph_value+  0.001392*nitro -.005503*bulk_dct
+ 0.990179*phospho+0.117297*ca+0.073206*mg-.000844*k
+0.014601*na -.013352*condctvt;

pc2=  -.028268*ph_value + 0.006893*nitro -.066610*bulk_dct
-.137925*phospho + 0.760426*ca + 0.624900*mg + 0.000041*k
+ 0.005790*na -.083135 *condctvt;

proc discrim data =horton
method =normal pool=yes short outstat = statall out = results;
class soil_grp;
var pc1 pc2 ;
title2
'Discrimination Using First Two Principal Components';
proc print data = results;
proc print data = statall;


/* Program 5.15 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.15';

data urine;
infile 'urine.dat' firstobs=7;
input presence $ sg ph mosm mmho urea calcium ;
patient = _n_ ;
if presence = 'yes' then crystals  = 1;
if presence = 'no' then crystals  = 0;

proc logistic data = urine descending outest = est
covout nosimple ;
model crystals = sg ph mosm mmho urea calcium
/ risklimits link=logit covb ctable pprob=.5 ;
output out=predict predprobs = cross p = phat lower = lcl
upper = ucl  / alpha =.05;
title2 'Logistic Regression: Crystals Data';
run;

proc print data = predict ;
*var presence phat lcl ucl;
title2 'Predicted Probabilities: Logistic Regression';
title3 ' Crystals Data';
run;




/* Program 5.16 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.16';

data urine;
infile 'urine.dat' firstobs=7;
input presence $ sg ph mosm mmho urea calcium ;
patient = _n_ ;

sg100 = 100*sg;
ph10=100*ph;
mmho10 =10*mmho;
cal100=100*calcium ;

if presence = 'no' then crystals  = 0;
if presence = 'yes' then crystals  = 1;

proc logistic data = urine descending nosimple ;
model crystals = sg ph mosm mmho urea calcium
/ risklimits link=logit ctable pprob=.5 ;
output out=predict predprobs = cross p = phat
dfbetas = dfbeta0  dfbeta1  dfbeta2  dfbeta3
dfbeta4  dfbeta5  dfbeta6 ;

title2 'Logistic Regression: Crystals Data';

data predict;
set predict;
p_prob =.5;
if (xp_1 > p_prob and crystals = 1)
 then decision = 'true_pos';
if (xp_1 <= p_prob and crystals = 1)
 then decision = 'fals_neg';
if (xp_1 <= p_prob and crystals = 0)
 then decision = 'true_neg';
if (xp_1 > p_prob and crystals = 0)
 then decision = 'fals_pos';

proc print data = predict ;
var phat xp_1 xp_0 presence decision  ;
title2 'Predicted Probabilities: Logistic Regression';
title3 ' Crystals Data';
run;


/* Program 5.17 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.17';

data urine;
infile 'urine.dat' firstobs=7;
input presence $ sg ph mosm mmho urea calcium ;
patient = _n_ ;

sg100 = 100*sg; ph10=100*ph;  mmho10 =10*mmho ;cal100=100*calcium ;

if presence = 'no' then crystals  = 0;
if presence = 'yes' then crystals  = 1;

proc logistic data = urine descending outest = betacoef covout nosimple ;
model  crystals = sg ph mosm mmho urea calcium
/ selection =backward ctable pprob =.5 link=logit slstay =.15 details ;
title2 'Backward Variable Selection; Logistic Regression';
run;

proc logistic data = urine ;
model  crystals = sg ph mosm mmho urea calcium
/ selection =score best =2 link=logit ;
title2 'Selection of Variables in Logistic Regression';
run;

proc logistic data = urine descending nosimple;
model crystals = sg mosm calcium ;
title2 'The Logistic Model Selected: Score Statistics';
run;


/* Program 5.18 */

filename gsasfile "prog518.graph";
goptions reset=all gaccess=gsasfile gsfmode = append
autofeed dev = pslmono;
goptions horigin =1in vorigin = 2in;
goptions hsize=6in vsize = 8in;
options ls = 64 ps=45 nodate nonumber;
title1 ' ';
title2 j = l  'Output 5.18' ;

data aids; input group $ s1-s13;
x1 =log(s1) ;
x2 = log(s2);
x3= log(s3);
x4 = log(s4);
lines;
a 8 8 20 10 9 5 3 1 4 1 1 3 0
a 2 11 10 12 5 3 2 2 2 3 0 0 0
a 18 12 10 18 14 10 8 5 1 3 2 2 0
a 19 12 7 11 9 6 3 1 3 1 2 1 0
a 14 17 8 8 2 4 3 3 1 3 1 2 0
a 10 16 9 4 6 4 0 1 2 0 0 0 0
a 3 1 4 3 3 2 2 0 2 0 2 1 1
a 27 22 16 7 6 5 2 2 4 2 0 0 0
a 12 16 16 17 9 7 4 5 1 2 0 0 1
a 10 14 10 10 7 3 1 0 0 2 1 1 0
a 2 3 12 7 4 9 6 2 3 3 2 3 1
o 21 19 9 4 3 2 1 0 0 0 0 0 0
o 20 17 11 7 2 6 1 0 1 0 0 0 0
o 16 27 22 12 9 2 3 3 2 4 2 0 0
o 11 15 13 14 9 9 5 2 2 0 0 1 0
o 10 13 5 12 5 9 5 1 1 2 3 3 0
o 23 13 14 8 4 6 2 3 1 1 2 1 2
o 15 14 15 10 7 12 5 4 0 1 1 2 0
o 14 15 13 11 7 4 1 2 1 0 0 0 0
o 10 19 16 19 8 3 4 1 1 1 1 1 0
;

/*
Data from Everitt (1993, p 34),
Reprinted with permission from Edward Arnold, London.
*/

proc sort data = aids ;
by group;

proc gchart data = aids ;
by group ;
vbar s1 /subgroup = group midpoints = 0 to 30 by 3;
title1 h = 1.2 'Histogram for s1' ;
title2 j = l 'Output 5.18';
run;

proc discrim data = aids method = npar kernel =epa r = .3 pool =no
metric =full testdata = aids testout =aidsout testoutd =density;
class group ;
var x1-x4;
title1 'Output 5.18';
title2 'AIDS Data: Nonparametric Discrimination using EPA Kernel';
run;

proc print data = density;
var group s1 s2 s3 s4 a o ;
title1 'Output 5.18';
title2 'Density Estimates for (x1,x2,x3,x4) with x=log(s) ';
title3 'using EPA Kernel';
run;


/* Program 5.19 */

options ls = 64 ps=45 nodate nonumber;
title1  'Output 5.19';

data cushing;
infile 'cushing.dat' firstobs = 7;
input type $ tetra preg ;
logtetra = log(tetra);
logpreg =log(preg);

data undgnosd;
input tetra preg ;
logtetra = log(tetra);
logpreg =log(preg);
lines;
5.1 0.4
12.9 5.0
13.0 0.8
2.6 0.1
30.0 0.1
20.5 0.8
;
/*
Data from Aitchison and Dunsmore (1975),
reprinted with permission from Cambridge University Press.
*/

proc discrim data = cushing method = npar k= 3 pool =yes
metric =full testdata = undgnosd testout =cushout;
class type ;
var logtetra logpreg;
title2 'Nonparametric Discrimination using k-NN Method';
title3 'with k=3';
run;

proc print data = cushout;
title2 'k-NN Classifications for the Undiagnosed Data';
title3 ' with k =3' ;


CHAPTER 6 (Cluster Analysis) Programs and Data Sets:

/* Program 6.1 */

options ls=64 ps=45 nodate nonumber;
filename gsasfile "prog61.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;

symbol1 i=join v=c;
symbol2 i=join v=g;
symbol3 i=join v=i;
symbol4 i=join v=l;
symbol5 i=join v=m;
symbol6 i=join v=s;
legend1 across=3;

title1 h = 1.2  'Mean Profiles: Satellite Data';
title2 j = l  'Output 6.1';
data meanfox;
infile 'meanfox.dat' firstobs = 7;
input group $ tm1 tm2 tm3 tm4 tm5 tm7;

proc transpose data=meanfox
out=meanfox2 name=measure;
by group;
run;

proc gplot data=meanfox2(rename=(col1=values));
plot values*measure=group/
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'Mean Values');
axis2 offset=(2) label=(h=1.2 'Rock/Mineral Measurements');
run;


/* MEANS FOR SIX GROUPS IN SATELITE DATA: meanfox.dat */

carbonat 229.4285714 130.1428571 178.8571429 157.0000000 254.2857143
165.5714286
gypsum  222.1250000 118.5000000 160.2500000 140.5000000 224.8750000
93.6250000
i_dacite 142.7777778 69.0000000 89.2222222 78.5555556 165.3333333
95.4444444
limeston 181.6666667 96.1666667 32.1666667 118.4166667 240.5833333
135.3333333
m_basalt 117.8750000 52.0000000 64.2500000 53.1250000 93.7500000
56.3750000
sandston 144.7142857 75.5714286 113.1428571 103.4285714 199.2857143
119.1428571

/* Raw data from Fox (1993). Means on six variables for six
Rock/Mineral groups.
Variables: group, tm1, tm2, tm3, tm4, tm5,
tm7. */


/* Program 6.2 */

options ls = 64 ps = 45 nodate nonumber ;

data meanfox;
infile 'meanfox.dat' firstobs= 7;
input group$ tm1 tm2 tm3 tm4 tm5 tm7;

filename gsasfile "prog62.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono
gsfmode=append;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;

data andrews;
set meanfox;
pi=3.14159265;
s=1/sqrt(2);
inc=2*pi/100;
do t=-pi to pi by inc;

z=s*tm1+sin(t)*tm2+cos(t)*tm3+sin(2*t)*tm4+cos(2*t)*tm5+sin(3*t)*tm7;

mz=s*(tm1+(sin(t)+cos(t))*tm2+(sin(t)-cos(t))*tm3+(sin(2*t)+cos(2*t))*tm4
+(sin(2*t)-cos(2*t))*tm5+(sin(3*t)+cos(3*t))*tm7);
output;
end;

symbol1 i=join v=none l=1;
symbol2 i=join v=none l=2;
symbol3 i=join v=none l=3;
symbol4 i=join v=none l=4;
symbol5 i=join v=none l=5;
symbol6 i=join v=none l=6;

proc gplot data=andrews;
plot z*t=group/vaxis=axis1 haxis=axis2 ;
axis1 label=(a=90 h=1.5 f=duplex 'Andrews Function');
axis2 label=(h=1.5 f=duplex 't') offset=(2);
title1 h = 1.2 'Andrews Plots: Satellite Data';
title2 j = l 'Output 6.2';
run;

proc gplot data=andrews;
plot mz*t=group/vaxis=axis1 haxis=axis2;* anno=labels;
axis1 label=(a=90 h=1.5 f=duplex 'Modified Andrews Function');
axis2 label=(h=1.5 f=duplex 't') offset=(2);
title1 h = 1.2 'Modified Andrews Plots: Satellite Data';
title2 j = l 'Output 6.2';
run;


/* Program 6.3 */

options ls = 64 ps = 45 nodate nonumber;
title1 'Output 6.3';
title2 'Distance Matrix: Acidosis Data';
/* Computation of Distance Matrix */

proc iml;
x = {
39.8 38.0 22.2 23.2,
53.7 37.2 18.7 18.5,
47.3 39.8 23.3 22.1,
41.7 37.6 22.8 22.3,
44.7 38.5 24.8 24.4,
47.9 39.8 22.0 23.3
};
/*
Data on Acidosis patients. Source: Everitt (1989),
Reprinted with permission from Edward Arnold, 1989.
*/

nrow = nrow(x);
xpx = x*t(x);
vdiag = vecdiag(xpx);
xi = j(1,nrow,1)@vdiag;
dist =sqrt(t(xi) - 2*xpx + xi);
print dist;


/* Program 6.4 */

options ls = 64 ps = 45 nodate nonumber;

title1 'Output 6.4';
data acidosis(type = distance);
input patient1 patient2 patient3 patient4 patient5 patient6 patient $  ;
lines;
          0 15.105959 7.8682908 2.2226111 5.6973678 8.3006024 patient1
  15.105959         0 9.0465463 13.244244 12.438247 8.6214848 patient2
  7.8682908 9.0465463         0 6.0406953 3.9987498 1.8681542 patient3
  2.2226111 13.244244 6.0406953         0 4.2684892 6.7022384 patient4
  5.6973678 12.438247 3.9987498 4.2684892         0  4.580393 patient5
  8.3006024 8.6214848 1.8681542 6.7022384  4.580393         0 patient6
;

/*
Distance matrix Computed from data on Acidosis patients
(Everitt, Statistical methods for medical Investigations,
London, Edward Arnold, 1989.
*/

proc cluster data = acidosis noeigen method = single
nonorm out =tree1;
id patient;
var patient1 patient2 patient3 patient4 patient5 patient6 ;
title2 'Acidosis Patient Data: Single Linkage Clustering';
run;

filename gsasfile "prog64tree.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc tree data = tree1 out = acid_out nclusters = 3;
id patient;
title1 h = 1.2 'Dendrogram: Single Linkage Method';
title2 j = l 'Output 6.4';
run;

proc sort data = acid_out;
by cluster ;
run;

proc print data = acid_out;
by cluster ;
title1 "Output 6.4";
title2 "3-Clusters Solution: Single Linkage Clustering" ;
title3 "Unstandardized Data: Using Euclidean Distance Matrix";
run;


/* Program 6.5 */

options ls = 64 ps = 45 nodate nonumber;

title1 'Output 6.5';
data acidosis;
input patient x1-x4;
lines;
1 39.8 38.0 22.2 23.2
2 53.7 37.2 18.7 18.5
3 47.3 39.8 23.3 22.1
4 41.7 37.6 22.8 22.3
5 44.7 38.5 24.8 24.4
6 47.9 39.8 22.0 23.3
;
/*
Data on Acidosis patients. Source: Everitt (1989),
Reprinted with permission from Edward Arnold, 1989.
*/

proc cluster data = acidosis
simple noeigen method = ward
rmsstd rsquare nonorm out =tree1;
id patient;
var x1 x2 x3 x4 ;
title2 "Acidosis Data: Ward's Clustering";
title3 "Unstandardized Data";
run;

filename gsasfile "prog65tree1.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc tree data = tree1 out = un_acid2 nclusters = 3;
id patient;
copy x1 x2 x3 x4;
title1 h = 1.2 "Dendrogram: Ward's Method";
title2 j = l "Output 6.5";
run;

proc sort data = un_acid2;
by cluster ;
run;

proc print data = un_acid2;
by cluster ;
var patient x1 x2 x3 x4 ;
title1 'Output 6.5';
title2 "3-Clusters Solution: Ward's Approach" ;
title3 "Unstandardized Data";
run;

proc cluster data = acidosis
simple noeigen method = flexible beta = -.3 standard
rmsstd rsquare nonorm out =tree2;
id patient;
var x1 x2 x3 x4 ;
title1 'Output 6.5';
title2 'Acidosis Data: Flexible-Beta Clustering';
title3 "Standardized data";
run;

filename gsasfile "prog65tree2.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc tree data = tree2 out = si_acid2 nclusters = 3;
id patient;
copy x1 x2 x3 x4;
title1 h = 1.2 "Dendrogram: Flexible-Beta Method";
title2 j = l "Output 6.5";
run;

proc sort data = si_acid2;
by cluster ;
run;

proc print data = si_acid2;
by cluster ;
var patient x1 x2 x3 x4 ;
title2 "3-Clusters Solution: Flexible-Beta Approach" ;
title2 "Standardized Data";
title3 ' ';
run;

filename gsasfile "prog65.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions gsfmode=append;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;

proc sort data = tree1;
by _ncl_;

data graph1;
set tree1;
tot_obs = 6;
if _ncl_ < tot_obs;
proc print data = graph1;
*var  _ncl_  _rsq_ ;

symbol1 i=join v=star;
legend1 across=3;

proc gplot data = graph1 ;
plot _sprsq_*_ncl_ /
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'Semi-Partial R**2');
axis2 offset=(2) label=(h=1.2 'No. of Clusters');
title1 h = 1.2 'Semi-Partial R**2 vs. No. of Clusters';
title2 j = l  'Output 6.5';
run;

proc gplot data = graph1 ;
plot _rsq_*_ncl_ /
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 ' R**2');
axis2 offset=(2) label=(h=1.2 'No. of Clusters');
title1 h = 1.2 ' R**2 vs. No. of Clusters';
title2 j = l  'Output 6.5';
run;

proc gplot data = graph1 ;
plot _height_*_ncl_ /
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'BSS');
axis2 offset=(2) label=(h=1.2 'No. of Clusters');
title1 h = 1.2 'BSS vs. No. of Clusters';
title2 j = l  'Output 6.5';
run;

proc gplot data = graph1 ;
plot _rmsstd_*_ncl_ /
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'RMSSTD');
axis2 offset=(2) label=(h=1.2 'No. of Clusters');
title1 h = 1.2 'RMSSTD vs. No. of Clusters';
title2 j = l  'Output 6.5';
run; 


/* Program 6.6 */

options ls = 64 ps = 45 nodate nonumber;

title1 'Output 6.6';
data track(type = corr);
input
m100 m200 m400 m800 m1500 m3000 marathon  race $;
_type_ = 'corr';
lines;
1.0000  0.9528  0.8347  0.7277  0.7284  0.7417   0.6863 m100
0.9528  1.0000  0.8570  0.7241  0.6984  0.7099   0.6856 m200
0.8347  0.8570  1.0000  0.8984  0.7878  0.7776   0.7054 m400
0.7277  0.7241  0.8984  1.0000  0.9016  0.8636   0.7793 m800
0.7284  0.6984  0.7878  0.9016  1.0000  0.9692   0.8779 m1500
0.7417  0.7099  0.7776  0.8636  0.9692  1.0000   0.8998 m3000
0.6863  0.6856  0.7054  0.7793  0.8779  0.8998   1.000 marathon
;

data arcosine(type = distance);
set track;
m100 = arcos(m100);
m200 = arcos(m200);
m400 = arcos(m400);
m800 = arcos(m800);
m1500 = arcos(m1500);
m3000 = arcos(m3000);
marathon = arcos(marathon);
_type_ = 'distance';
race = race;

proc print data = arcosine;
title1 'Output 6.6';
title2 'Dissimilarity matrix: Arc Cos(Corr)';
run;

proc cluster data = arcosine
noeigen method = centroid rmsstd rsquare nonorm out =tree;
id race;
var  m100 m200 m400 m800 m1500 m3000 marathon;
title2 'Variable Clustering : Arc Cosine Transformed Correlations';
title3 'National Track Record Data';
run;

filename gsasfile "prog66tree.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc tree data = tree out = trackout nclusters = 3;
id race;
title1 h = 1.2 'Dendrogram: Variable Clustering';
title2 j = l 'Output 6.6';
run;

proc sort;  by cluster ;

proc print data = trackout; by cluster ;
title1 "Output 6.6";
title2 "3-Clusters Solution: Centroid Method" ;
title3 'National Track Record Data';

proc factor data=track method=prin nfact=3 rotate=hk;
title1 'Output 6.6';
title2 'Clustering: Principal Factor, H-K Rotation';
title3 'National Track Record Data';
run;

proc varclus data = track maxc= 3 trace;
title1 'Output 6.6';
title2 'Cluster Component Analysis';
title3 'National Track Record Data';
run;


/* Program 6.7 */

options ls = 64 ps = 45 nodate nonumber;
filename gsasfile "prog67.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions gsfmode=append;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;

symbol1 value =1 ;
symbol2 value =2 ;
symbol3 value =3 ;
symbol4 value =4 ;
symbol5 value =5 ;
symbol6 value =6;
symbol7 value =7;
symbol8 value =8;

data mfunds;
infile 'm_funds.dat' firstobs = 7;
input fund $ 1-33
price war39 wd39 wk4 wk8 wk12 ytd drawdown;

proc cluster data = mfunds method = ward noprint
noeigen nonorm std outtree = tree ;
var  wk4 wk8 wk12 ytd;
id fund;
title1  'Output 6.7';
title2 "Cluster Analysis Using Ward's Approach";
run;

proc tree data = tree out = newdata nclusters = 8 noprint;
id fund;
copy  wk4 wk8 wk12 ytd;
title1 'Output 6.7';
title2 "Tree Diagram of Clustering: Ward's Method";
run;

proc sort data = newdata;
by cluster;
run;

proc means data = newdata noprint;
by cluster;
output out = myseeds mean = wk4 wk8 wk12 ytd;
var wk4 wk8 wk12 ytd;
run;

proc fastclus data = mfunds maxiter = 20 maxclusters = 8 distance
radius = .001 replace = full seed = myseeds out = clus_out;
var wk4 wk8 wk12 ytd ;
id fund;
title1 'Output 6.7';
title2 'Seed Point Clustering of Mutual Funds: Seeds Supplied';
run;

proc sort data = clus_out;
by cluster distance;
run;

proc gplot data = clus_out;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8;
plot wk8*wk4 = cluster ;
title1 h = 1.2 'Clusters in WK8 vs.WK4 Plots: Seeds Supplied';
title2 j = l 'Output 6.7';
run;

proc gplot data = clus_out;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8;
plot ytd*wk12 = cluster ;
title1 h = 1.2 'Clusters in YTD vs.WK12 Plots: Seeds Supplied';
title2 j = l 'Output 6.7';
run;

proc print data = clus_out;
by cluster;
var fund wk4 wk8 wk12 ytd ;
title1 'Output 6.7';
title2 'Clustering Details: Seeds Supplied';
run;

proc fastclus data = mfunds maxiter = 20 maxclusters = 8 distance
radius = .001 replace = full out = c_out;
var wk4 wk8 wk12 ytd ;
id fund;
title1 'Output 6.7';
title2 'Clustering of Mutual Funds: Seeds from Data';
run;

proc sort data = c_out;
by cluster;
run;

proc gplot data = c_out;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8;
plot wk8*wk4 = cluster ;
title1 h = 1.2 'Clusters in WK8 vs.WK4 Plots: Seeds as First k Obs';
title2 j = l 'Output 6.7';
run;

proc gplot data = c_out;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8;
plot ytd*wk12 = cluster ;
title1 h = 1.2 'Clusters in YTD vs.WK12 Plots: Seeds as First k Obs.';
title2 j = l 'Output 6.7';
run;

proc print data = c_out;
by cluster;
var fund wk4 wk8 wk12 ytd ;
title1 'Output 6.7';
title2 'Seeds Taken from Data';
run;

proc princomp data = mfunds cov out = pc_out;
var wk4 wk8 wk12 ytd ;
run;

proc cluster data = pc_out method = ward noprint
noeigen nonorm std outtree = pctree ;
var prin1 prin2 ;
id fund;
title1 'Output 6.7';
title2 "Cluster Analysis (PC) Using Ward's Approach";
run;

proc sort data = pctree;
by _ncl_;

data pc_ccc;
set pctree;
if _ncl_ < = 20;

proc print data = pc_ccc;
var _ncl_ _freq_ _ccc_ _rmsstd_ _sprsq_;

proc fastclus data = pc_out maxiter = 20 maxclusters = 8 distance
radius = .001 replace = random random = 1229447 out = pc_clus;
var prin1 prin2 ;
id fund;
title1 'Output 6.7';
title2 'Seed point Clustering of Mutual Funds: First 2 PC Used';
run;

proc sort data = pc_clus;
by cluster;
run;

proc gplot data = pc_clus;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8;
plot prin2*prin1 = cluster ;
title1 h = 1.2 'Clustering Using First Two PCs';
title2 j = l 'Output 6.7';
run;

proc gplot data = pc_clus;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8;
plot wk8*wk4 = cluster ;
title1 h = 1.2 'Clusters (Using PC) in WK8 vs.WK4 Plots';
title2 j = l 'Output 6.7';
run;

proc gplot data = pc_clus;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8;
plot ytd*wk12 = cluster ;
title1 h = 1.2 'Clusters (Using PC) in YTD vs.WK12 Plots ';
title2 j = l 'Output 6.7';
run;


/* MUTUAL FUNDS DATA: m_funds.dat */

Amer Century Ultra               36.91 35.66 3.50 1.60 -3.68 0.90 10.48 -10.46
Babson Enterprise II             23.79 22.35 6.46 -2.02 -4.00 2.54 4.71 -9.32
Baron Asset                      54.50 54.52 -0.04 -3.08 -8.57 -6.98 7.84 -12.91
Berger Small Compan Growth        4.65 4.01 16.00 3.10 1.31 12.86 23.02 -12.72
Dreyfus New Leaders              47.45 44.14 7.50 0.02 -2.81 0.49 15.19 -10.09
Fidelity Capital Appreciation    25.53 24.00 6.38 0.47 -2.85 2.16 15.83 -9.54
Fidelity Fifty                   19.49 18.38 6.05 1.36 -2.90 0.59 24.65 -11.97
Fidlty Low-Prcd Stck             23.50 22.86 2.81 -3.17 -4.55 -0.51 2.84 -9.86
Founders Discovery               31.80 26.71 19.08 -1.70 1.63 13.90 30.49 -10.55
Invesco Dynamics                 19.54 17.51 11.62 0.77 -2.06 4.83 23.67 -10.67
Invesco Small Company            13.52 11.98 12.83 -0.66 0.30 9.74 16.75 -11.62
Janus Olympus                    35.05 32.11 9.14 2.25 -1.74 4.35 27.08 -10.16
Kaufmann Fund                     5.40 5.37 0.60 -2.17 -4.76 2.27 -4.93 -11.05
Managers Special Equity          68.67 61.65 11.38 0.38 0.13 8.48 12.17 -10.30
Oakmark Small Cap                14.36 14.49 -0.88 -5.90 -7.30 -4.14 -2.78 -11.26
Emerging Growth                  23.03 21.91 5.11 1.05 -1.92 6.52 -3.84 -10.65
Price Small Cap Stock            21.46 20.31 5.69 -1.24 -2.63 3.62 3.22 -9.55
Profund Ultra OTC (sold 2/8/99)  44.35 36.11 22.82 10.90 2.02 25.21 48.78 -14.87
Rob Stephens Em Growth           35.60 29.15 22.13 5.42 1.19 14.25 55.12 -14.32
Rob Stephens Value + Gwth        28.76 27.62 4.14 0.77 -2.57 5.74 10.96 -8.84
Rydex OTC                        54.16 47.17 14.83 6.01 2.36 14.05 30.95 -7.46
Safeco Growth                    20.32 21.11 -3.74 -1.45 -5.00 -2.68 -10.48 -11.68
Schwab Small Cap Index           17.13 16.26 5.35 -1.78 -3.44 2.15 5.42 -10.67
Scudder Development              39.41 39.15 0.67 -2.23 -7.75 -3.17 4.65 -10.00
SteinRoe Capital Opportunities   28.72 28.73 -0.03 -1.71 -7.06 -2.35 -2.18 -13.46
US Global Bonnel Growth          22.90 20.54 11.48 4.28 0.97 10.20 17.08 -8.54
Value Line Leveraged Growth      54.14 51.64 4.84 1.61 -2.73 3.64 11.81 -11.50
Warburg Pincus Emerging Grth     41.12 39.23 4.82 -1.08 -3.86 3.94 2.88 -10.55
Wasatch Micro-cap                 4.38 3.98 10.12 -1.35 0.92 12.02 9.77 -10.09
Amer Cent Bnhm Eq Gwth           24.23 23.06 5.08 1.25 -1.42 4.13 7.77 -9.31
Baron Growth                     29.44 27.52 6.99 -2.03 -4.57 -1.44 18.38 -13.63
Bramwell Growth                  25.25 24.63 2.50 0.56 -4.32 1.24 4.68 -8.11
Columbia Growth                  46.78 45.30 3.26 -0.47 -5.02 0.75 10.04 -10.13
Dreyfus Appreciation             44.92 43.41 3.47 2.96 -1.06 2.53 6.77 -8.19
Dreyfus Core Value               32.38 31.24 3.64 -0.03 -5.98 -2.88 12.25 -8.91
Dreyfus Third Century            13.58 12.94 4.97 1.34 -2.79 3.82 10.76 -10.55
Fidelity Blue Chip Growth        54.28 52.33 3.72 2.03 -2.02 2.92 7.83 -8.14
Fidelity Contrafund (clsd)       61.13 59.39 2.93 -1.18 -3.97 0.28 8.85 -8.73
Fidelity Dividend Growth         31.14 30.18 3.18 0.00 -4.33 0.32 8.39 -7.47
Fidelity Aggrssv Gw              44.01 36.94 19.14 6.92 3.43 14.28 42.00 -9.31
Fidelity Growth Company          64.80 55.71 16.32 6.00 5.47 13.82 28.13 -9.65
Fidelity Magellan (clsd)         126.31 121.12 4.29 0.73 -3.84 1.50 11.07 -9.23
Fidelity New Millenium (clsd)    35.97 32.72 9.95 0.22 -3.67 4.20 37.25 -9.32
Fidelity OTC                     52.22 47.88 9.07 1.34 -1.21 5.54 19.69 -8.97
Fidelity Spartan Market Index    93.27 89.29 4.46 1.58 -2.92 1.79 10.44 -8.33
Fidelity Stock Selector          32.54 30.32 7.31 0.96 -0.46 5.07 13.34 -8.84
Fidelity Value                   53.37 50.31 6.09 -1.98 -6.65 -3.63 15.15 -8.09
Founders Growth                  22.34 21.61 3.38 2.06 -3.16 2.34 9.46 -10.27
Fremont Growth                   16.63 16.03 3.75 1.53 -4.04 2.40 8.34 -9.95
Invesco Blue Chip Gw              7.07 6.74 4.89 4.74 -1.26 4.28 9.44 -7.99
Janus Enterprise                 49.02 41.83 17.18 5.46 3.00 9.44 35.34 -8.81
Janus Fund                       39.30 36.92 6.44 0.43 -3.53 3.20 16.79 -8.32
Janus Mercury                    32.05 28.67 11.80 4.19 -1.75 6.55 32.93 -9.78
Janus Twenty                     62.22 59.56 4.46 3.00 -2.87 2.44 16.74 -9.15
Longleaf Partners                26.99 27.04 -0.17 -1.85 -9.25 -8.20 10.66 -8.50
Montgomery Growth                22.99 22.02 4.41 -2.09 -6.28 -1.75 11.49 -9.36
Neuberger & Berman Manhattan     12.24 11.74 4.28 1.41 -3.47 4.79 2.43 -11.70
Neuberger & Berman Partners      26.94 26.85 0.34 -2.32 -7.83 -4.97 5.65 -9.81
Oakmark Fund                     37.05 37.15 -0.26 -3.21 -7.00 -5.61 3.43 -9.54
Price Growth Stock               33.98 32.97 3.07 0.65 -3.66 1.04 5.96 -10.26
Price Midcap Growth Stock        36.84 34.98 5.30 -3.10 -4.21 0.99 8.10 -10.42
Rydex Nova (sold 8/5/99)         36.91 35.30 4.55 2.13 -5.12 1.54 11.07 -12.75
Schwab 1000                      36.50 35.23 3.62 1.05 -3.49 1.00 8.92 -8.57
Schwab S&P 500                   20.92 20.05 4.32 1.55 -2.92 1.75 10.34 -8.35
Scudder Large Co Value           29.98 29.19 2.70 -0.23 -5.40 -1.19 9.06 -9.02
SIT Large Cap Growth             52.26 50.64 3.20 2.39 -2.93 3.24 7.44 -9.94
Strong Opportunity               43.63 40.74 7.08 -2.44 -3.35 0.53 16.53 -9.36
Transamerica Equity Growth       26.48 26.64 -0.59 -0.71 -6.30 -0.79 6.86 -10.27
Tweedy Browne American Value     24.22 23.34 3.78 -0.90 -5.09 0.00 6.51 -8.68
Vanguard Index Trust 500         124.82 119.50 4.45 1.60 -2.90 1.82 10.56 -8.33
Vanguard/Primecap (clsd)          57.18 51.48 11.08 1.85 0.95 8.13 21.50 -7.59
Vanguard US Growth                39.55 38.36 3.10 2.41 -2.80 2.94 5.49 -7.84
Warburg Pincus Capital App        24.46 23.26 5.18 0.87 -1.53 4.04 11.38 -9.62
Amer Cent Eq Income                6.60 6.30 4.77 -0.90 -2.51 0.91 6.44 -2.61
American Century Value             6.60 6.26 5.39 -1.35 -4.07 -2.08 9.79 -5.35
Amer Cent Benhm Incm & Gwth       31.50 30.13 4.54 1.29 -2.33 2.98 8.56 -8.61
Babson Value                      49.42 48.12 2.71 -0.62 -5.31 -4.13 8.37 -10.90
Berger Growth and Income          15.67 14.66 6.87 0.19 -2.43 4.82 17.37 -8.22
Columbia Common Stock             26.92 25.89 3.97 0.19 -4.06 1.09 10.45 -9.56
Fidelity Equity-Income            59.51 57.54 3.43 -0.58 -4.62 -0.95 9.44 -9.40
Fidelity Equity-Income II         31.03 30.57 1.52 0.10 -4.04 -0.47 4.92 -8.80
Fidelity Fund                     36.91 36.08 2.31 0.13 -4.20 -0.07 7.33 -8.02
Fidelity Growth & Income (clsd)   47.54 46.68 1.85 0.57 -3.59 0.41 4.18 -8.58
Founders Grwth & Incm              7.38 7.31 0.95 1.23 -3.40 0.96 0.82 -7.83
Invesco Industrial Income         16.24 15.69 3.50 -0.43 -3.62 1.37 8.67 -6.75
Janus Equity Income               21.42 20.52 4.39 -1.02 -3.82 0.51 14.80 -7.63
Janus Growth & Income             33.43 31.74 5.33 0.91 -3.30 2.74 14.95 -8.93
Lexington Corporate Leaders       17.58 16.59 5.94 1.91 -1.79 0.57 12.74 -8.19
Lexington Gwth & Incm             22.38 22.26 0.52 -0.58 -5.09 -0.84 2.15 -10.03
Price Equity-Income               28.14 27.14 3.67 -1.12 -4.19 -1.81 8.91 -6.00
Price Growth & Income             28.06 27.25 2.99 -1.27 -4.78 -1.48 8.22 -7.75
Rob Stephs Mid Cap Opprtnties     16.72 15.52 7.75 -1.01 -4.95 1.39 19.00 -11.49
Safeco Equity                     25.32 24.30 4.21 1.28 -1.78 0.83 9.39 -8.25
Safeco Income                     22.10 22.87 -3.37 -2.86 -6.79 -4.75 -4.60 -9.85
Scudder Growth & Income           27.54 27.09 1.68 -1.64 -5.78 -3.13 5.95 -9.24
Selected American Shares          34.61 33.09 4.58 0.29 -5.26 0.99 12.01 -9.97
Vanguard Equity Income            25.65 25.13 2.06 -0.77 -4.11 -1.53 4.97 -6.24
Vanguard Growth and Income        34.49 32.72 5.41 1.74 -2.76 3.08 12.59 -9.06
Vanguard Windsor II               30.96 31.00 -0.14 -1.09 -6.78 -4.55 4.69 -8.06
Weiss Peck & Greer Gwth & Incm    40.09 39.55 1.37 1.96 -1.47 1.77 -1.13 -10.30

/* Source:  Fabian Premium Investment Resource (1999).
Variables: Fundname read in columns 1-33, x1-x8.
Reproduced by permission of Fabian Premium Investment Resource. */ 


/* Program 6.8 */

title1 'Output 6.8';

options ls = 64 ps = 45 nodate nonumber;

filename gsasfile "prog68.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions gsfmode=append;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;

data mfunds;
infile 'm_funds.dat' firstobs = 7;
input fund $ 1-33
price war39 wd39 wk4 wk8 wk12 ytd drawdown;

proc aceclus data = mfunds maxiter = 30 out = ace
p = .02;
var wk4 wk8 wk12 ytd ;
title1 'Output 6.8';
title2 'Estimation of Common Within Cluster Covariance Matrix';
run;

proc fastclus data = ace maxiter = 20 maxclusters = 8 distance
radius = .001 replace = full out = clus_ace ;
var can1 can2 can3 can4;
id fund;
title1 'Output 6.8';
title2 'Clustering Using Canonical Variables';
run;

proc sort data = clus_ace;
by cluster distance;
run;

symbol1 value = 1;
symbol2 value = 2;
symbol3 value = 3;
symbol4 value = 4;
symbol5 value = 5;
symbol6 value = 6;
symbol7 value = 7;
symbol8 value = 8;

proc gplot data = clus_ace;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8 ;
plot can2*can1 = cluster ;
title1 h = 1.2 'Clustering Plot in First Two Canonical Variables';
title2  j = l 'Output 6.8';
run;

proc gplot data = clus_ace;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8 ;
plot wk8*wk4 = cluster ;
title1 h = 1.2 'Clusters in WK8 vs.WK4 Plots: Canonical Variables';
title2 j = l 'Output 6.8';
run;

proc gplot data = clus_ace;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8 ;
plot ytd*wk12 = cluster ;
title1 h = 1.2 'Clusters in YTD vs.WK12 Plots: Canonical Variables';
title2 j = l  'Output 6.8';
run;

title1 'Output 6.8';
title2 ' ';

proc iml;
a = {
0.822298      0.584999      1.097001      0.452214,
0.584999      0.597609       0.91999      0.650016,
1.097001       0.91999      1.990096      1.726587,
0.452214      0.650016      1.726587      7.530282};

cov = {
6.031519      4.783282      9.437347      16.60669,
4.783282      6.884532        12.236      17.19683,
9.437347        12.236      26.78831      37.77468,
16.60669      17.19683      37.77468      114.0149};

call eigen(lam, p, a);
lhalfinv =inv( root(diag(lam)));
ahalfinv =  p*lhalfinv*t(p);

use mfunds;
read all into mmtx;
read all var {wk4 wk8 wk12 ytd} into mmtx;

mmtx2 = mmtx*p;
create newdata from  mmtx2;
append from mmtx2;
close newdata;

data newdata2;
merge newdata mfunds;
keep fund col1 col2 col3 col4 wk4 wk8 wk12 ytd;

proc standard data = newdata2 out = newdata2 m = 0 ;
var col1 col2 col3 col4;

proc fastclus data = newdata2 maxiter = 20 maxclusters = 8 distance
radius = .001 replace = full out = newout ;
var col1 col2 col3 col4;
id fund;
title1 'Output 6.8';
title2 'Clustering Using (Within Covariance) PC Scores';
run;

proc sort data = newout;
by cluster distance;
run;

proc gplot data = newout;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8 ;
plot wk8*wk4 = cluster ;
title1 h = 1.2  'Clusters in WK8 vs.WK4 Plots: Within Covariance PC Scores';
title2 j = l  'Output 6.8';
run;

proc gplot data = newout;
where
cluster = 1 or cluster = 2 or cluster = 3 or
cluster = 4 or cluster = 5 or cluster = 6 or
cluster = 7 or cluster = 8 ;
plot ytd*wk12 = cluster ;
title1 h= 1.2 'Clusters in YTD vs.WK12 Plots: Within Covariance PC Scores';
title2 j = l  'Output 6.8';
run; 


/* Program 6.9 */

options ls = 64 ps = 45 nodate nonumber;
data fox;
infile 'satellite.dat' firstobs = 7;
input group $ tm1 tm2 tm3 tm4 tm5 tm7;

proc cluster data = fox method = ward noprint
noeigen nonorm std outtree = tree ;
var  tm1 tm2 tm3 tm4 tm5 tm7;
id group;
title1 'Output 6.9';
title2   'Cluster Analysis: Satellite Data';
run;

proc sort data = tree;
by _ncl_;

data cccgraph;
set tree;
if _ncl_ < = 10;

proc print data = cccgraph;
var _ncl_  _rsq_ _sprsq_ _rmsstd_ _ccc_ ;
title1 'Output 6.9';
title2 'Criteria to Decide # Clusters: Satellite Data';
run;

filename gsasfile "prog69.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions gsfmode=append;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;

symbol1 i=join v=star;
legend1 across=3;

proc gplot data = cccgraph ;
plot _ccc_*_ncl_  /
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'CCC Values');
axis2 offset=(2) label=(h=1.2 'No. of Clusters');
title1 h = 1.2 'CCC Values vs. No. of Clusters:Satellite Data';
title2 j = l  'Output 6.9';
run;

data mfunds;
infile 'm_funds.dat' firstobs = 7;
input fund $ 1-33
price war39 wd39 wk4 wk8 wk12 ytd drawdown;

proc cluster data = mfunds method = ward noprint
noeigen nonorm std outtree = treem;
var  wk4 wk8 wk12 ytd;
id fund;
title1 'Output 6.9';
title2 "Cluster Analysis: Mutual Funds Data";
run;

proc sort data = treem;
by _ncl_;

data ccgraph1;
set treem;
if _ncl_ < = 20;

proc print data = ccgraph1;
var _ncl_  _rsq_ _sprsq_ _rmsstd_ _ccc_ ;
title1 'Output 6.9';
title2 'Criteria to Decide # Clusters: Mutual Funds Data';

proc gplot data = ccgraph1 ;
plot _ccc_*_ncl_  /
vaxis=axis1 haxis=axis2 legend=legend1;
axis1 label=(a=90 h=1.2 'CCC Values');
axis2 offset=(2) label=(h=1.2 'No. of Clusters');
title1 h= 1.2 'CCC Values vs. No. of Clusters: Mutual Funds Data';
title2 j = l  'Output 6.9';
run;


/* Program 6.10 */

options ls = 64 ps = 45 nodate nonumber;

title1 'Output 6.10';

data mfunds;infile 'm_funds.dat' firstobs = 7;
input fund $ 1-33
price war39 wd39 wk4 wk8 wk12 ytd drawdown;

proc modeclus data = mfunds method = 2 k =  5 r = .6
std  test out = output;
var wk4 wk8 wk12 ytd;
id fund;
title1 'Output 6.10';
title2 'Nonparametric Clustering of Mutual Funds Data';
run;

proc sort data = output;
by _k_ _r_;

filename gsasfile "prog610.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions gsfmode=append;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;

symbol1 value = 1;
symbol2 value = 2;
symbol3 value = 3;
symbol4 value = 4;

proc gplot data = output;
where
cluster = 1 or cluster = 2 or
cluster = 3 or cluster = 4;
plot wk8*wk4 = cluster ;
by _k_ _r_;
title1 h = 1.2 'Mutual Funds Data: Clustering in WK8 vs. WK4 Plot';
title2 j = l 'Output 6.10';
run;

proc gplot data = output;
where
cluster = 1 or cluster = 2 or
cluster = 3 or cluster = 4;
plot ytd*wk12 = cluster ;
by _k_ _r_;
title1 h = 1.2 'Mutual Funds Data: Clustering in YTD vs. WK12 Plot';
title2 j = l 'Output 6.10';
run;

proc sort data = output;
by cluster;
run;

proc print data = output ;
by  cluster;
var fund wk4 wk8 wk12 ytd;
title1 'Output 6.10';
title2 'Clusters of Mutual Funds';
run; 


/*Program 6.11 */

options ls=64 ps=45 nodate nonumber;

title1 'Output 6.11';

data hospital;
infile 'hospital.dat' firstobs = 7;
input Rank Hospital $ 6-31
index Reput Mortalit COTH $ techscor discharg  rn_bed;

data bin;
set hospital;
if reput < = 30 then x1 = 0;
if reput > 30 then x1 =1;
if mortalit <  .75 then x2 = 1;
if mortalit > = .75 then x2 = 0;
if  techscor < = 6 then x3 = 0;
if techscor > 6 then x3 = 1;
if discharg < = 1000 then x4 = 0;
if discharg > 1000 then x4 = 1;
if rn_bed < = 1.5 then x5 = 0;
if rn_bed > 1.5 then x5 = 1;
drop reput mortalit techscor discharg rn_bed index coth rank;

data jacc(type = distance);
array d(*) d1-d50;
retain d1-d50 .;

do row = 1 to 50;
set bin point = row;
array scores(*) x1--x5;
array save(*) save1-save5;

do g = 1 to 5;
save(g) =scores(g);
end;

do col = 1 to row;
set bin(drop = hospital) point = col;
num = 0;
den = 0;
do g = 1 to 5;
num = num+(scores(g) & save(g));
den = den+(scores(g) | save(g));
end;
if den then d(col) = 1 - num/den;
else d(col) =1;
end;
output;
end;
stop;
keep hospital d1-d50;
run;

proc print data = jacc;

proc cluster data = jacc
noeigen method = flexible beta = -0.5   nonorm out =tree1;
id hospital;
var d1-d50;
title2 'Clustering of Hospitals: Flexible-Beta (= -0.5) Approach';
proc tree data = tree1 out = output noprint nclusters = 4 ;
id hospital;

proc sort data = output;
by hospital;

proc sort data = bin;
by hospital;

proc sort data = hospital;
by hospital;

data all; merge hospital bin output;
by hospital;
run;

proc sort data = all;
by cluster;
run;

proc print data = all;
id hospital;
var x1-x5 reput mortalit techscor discharg rn_bed;
by cluster ;
title2 "4-Clusters Solution: Hospital Data" ;
run;


/* HOSPITAL DATA SET: hospital.dat */

  1   Sloan-Ketterning          100.0   73.0  1.05  Yes  6.0  3544 1.85
  2   M. D. Anderson             99.7   67.5  0.78  Yes  6.0  3683 1.87
  3   Johns Hopkins              65.6   33.4  0.70  Yes  7.0  1278 1.33
  4   Mayo Clinic                60.4   26.0  0.57  Yes  7.0  2589 1.10
  5   U. Wash. Medical           39.0    9.1  0.67  Yes  6.0   606 2.03
  6   Duke U Medical             38.6   10.7  0.82  Yes  7.0  2523 1.63
  7   University of Chicago      37.2    6.6  0.68  Yes  7.0  1116 1.26
  8   Fox Chase Cancer           35.5    5.7  0.54  Yes  4.0   872 1.88
  9   U. Michigan Medical        35.2    1.3  0.56  Yes  7.0  1221 1.46
 10   Roswell Park Cancer        34.9    8.4  0.81  Yes  5.5  1481 2.34
 11   U. Pittsburgh Medical      33.3    3.0  0.69  Yes  7.0  1730 1.34
 12   U. Virginia Health         32.9    0.0  0.54  Yes  6.0  1026 1.91
 13   UCLA Medical Center        32.2    8.9  0.80  Yes  6.0   825 0.91
 14   Clarian Health             32.1    4.2  0.78  Yes  7.0  1139 1.48
 15   Barnes-Jewish              31.2    3.3  0.77  Yes  6.5  1872 1.52
 16   Vanderbilt U.              31.2    1.4  0.71  Yes  7.0   779 1.88
 17   U. Kentucky                31.1    0.0  0.63  Yes  6.0   698 1.85
 18   Massachusetts Gen.         30.6    6.3  0.94  Yes  7.0  1547 1.35
 19   Arthur James Cancer        30.0    0.4  0.50  Yes  5.0  1611 1.10
 20   Allegheny U-Hos.           29.9    0.3  0.64  Yes  5.0   885 1.89
 21   Loyola U.                  29.9    0.5  0.63  Yes  6.0   683 1.39
 22   U. Pennsylvania            29.4    5.5  0.96  Yes  6.0  1431 1.98
 23   U. Florida                 29.3    0.5  0.46  Yes  7.0   561 0.60
 24   Cleveland Clinic           29.0    2.4  0.86  Yes  7.0  1686 1.69
 25   Stanford U. Hos.           28.5    9.5  0.83  Yes  5.3   869 1.10
 26   Lutheran Gen.              28.5    0.4  0.60  Yes  5.0   935 0.92
 27   Emory University           28.5    0.0  0.61  Yes  5.5   762 0.98
 28   Luke's Medical             28.5    0.0  0.67  Yes  7.0   820 1.01
 29   U. Hos. Columbia MO        28.4    0.0  0.66  Yes  6.0   791 1.26
 30   Kettering, Ohio            28.3    0.0  0.57  Yes  6.0   512 0.94
 31   Baltimore Medical          28.3    0.0  0.54  Yes  4.0   903 1.47
 32   U. Iowa Hos.               28.1    0.9  0.75  Yes  7.0  1138 1.12
 33   Harper Hos. Detroit        28.0    0.4  0.68  Yes  5.5  1348 1.10
 34   H. Lee Moffitt Cancer      27.8    0.8  0.61  Yes  3.0   980 1.43
 35   Carolina Hospitals         27.7    0.0  0.69  Yes  6.0   751 1.49
 36   Evanston Hospital          27.7    0.0  0.61  Yes  5.0   914 0.81
 37   Baylor U.                  27.6    1.9  0.82  Yes  6.0  1392 1.53
 38   U. Hos. Portland OR        27.4    0.0  0.63  Yes  6.0   569 0.90
 39   Brigham and Women's        27.3    2.9  0.80  Yes  6.0   939 1.30
 40   U. Wis. Madison            27.2    1.2  0.77  Yes  7.0   759 1.19
 41   Nebraska Health            26.6    0.0  0.74  Yes  7.0   648 1.28
 42   U. Hos. Cleveland          26.4    0.0  0.81  Yes  7.0  1414 1.26
 43   Yale Hospital              26.3    1.0  0.77  Yes  6.5  1296 0.84
 44   Meritcare Health Fargo     26.2    0.4  0.64  Yes  6.0   627 0.41
 45   NY Presbyterian            25.9    3.9  1.01  Yes  7.0  1923 1.13
 46   Loma Linda                 25.6    0.0  0.64  Yes  4.8   768 1.79
 47   Jefferson U.               25.4    0.0  0.81  Yes  6.0  1310 1.47
 48   UC-Davis                   25.3    0.0  0.84  Yes  7.0   543 1.89
 49   NC Baptist Hospital        25.2    0.5  0.83  Yes  6.0  1364 1.34
 50   SW Hos. Temple TX          25.1    0.0  0.60  Yes  3.5   716 0.92

/* Source: US News and World Report 7/19/99 (best hospitals for cancer).
Variables are: Rank, Hospital (read in 6-31 columns in the data set),
index, Reput, Mortalit, COTH (yes), techscor, discharg, and  rn_bed.
Reproduced by permission of US News and World Report, Inc. */ 


CHAPTER 7 (Correspondence Analysis) Programs and Data Sets:


/* Program 7.1 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 7.1';
title2 'Correspondence Analysis of Headache Type by Age';
data headache;
length age_gp$ 10;
input age_gp$ NDiagno Tension Migraine;
cards;
 Age:0-19         77          52        20
Age:20-29         66          82        68
Age:30-39         31          49        37
Age:40-49         20          44        31
Age:50-59         27          52        25
run;
/* Source: Diehr et~al. (1981). Reprinted by permission of
the Pergamon Press. */

proc corresp data=headache observed rp cp short;
var _numeric_;
id age_gp;
run;

*Asymmetric plot of the age groups;
proc corresp data=headache out=plot profile=row noprint;
var _numeric_;
id age_gp;
label ndiagno='No Diagnosis' tension='Tension Headache'
migraine='Migraine';
run;

data plotprint;
set plot;
if dim1=. then delete;
run;
proc print data=plotprint label noobs;
var age_gp dim1 dim2;
label age_gp='Category';
title3 'Results for Asymmetric Display';
run;

data labels;
set plotprint;
x=dim1;
y=dim2;
retain xsys '2' ysys '2';
function='LABEL';
text=age_gp;
position='8';
run;
filename gsasfile "prog71a.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc gplot data=plotprint;
plot dim2 * dim1/anno=labels frame
        href=0 vref=0 lvref=3 lhref=3 vaxis=axis2 haxis=axis1
        vminor=1 hminor=1;
axis1 length=5 in order=(-1.5 to 1.5 by .5)  offset=(2)
        label = (h=1.2 'Dimension 1');
axis2 length=5 in order =(-1.5 to 1.5 by .5) offset=(2)
    label=(h=1.2 a=90 r=0  'Dimension 2');
symbol v=star;
title1 h=1.2 'Correspondence Analysis of Headache Type by Age';
title2 j=l 'Output 7.1';
title3 f=duplex 'Asymmetric Plot of Age Groups';
run;

*Symmetric plot of the age groups;
proc corresp data=headache out=plot2 profile=both noprint;
var _numeric_;
id age_gp;
label ndiagno='No Diagnosis' tension='Tension Headache'
migraine='Migraine';
run;

data plotprint2;
set plot2;
if dim1=. then delete;
run;
proc print data=plotprint2 label noobs;
var age_gp dim1 dim2;
label age_gp='Category';
title3 'Results for Symmetric Display';
run;

data label;
set plotprint2;
x=dim1;
y=dim2;
retain xsys '2' ysys '2';
function='LABEL';
text=age_gp;
position='8';
run;
filename gsasfile "prog71b.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc gplot data=plotprint2;
plot dim2 * dim1/anno=label frame
        href=0 vref=0 lvref=3 lhref=3 vaxis=axis2 haxis=axis1
        vminor=1 hminor=1;
axis1 length=5 in order=(-.5 to .5 by .1)  offset=(2)
        label = (h=1.2 'Dimension 1');
axis2 length=5 in order =(-.2 to .2 by .05) offset=(2)
    label=(h=1.2 a=90 r=0  'Dimension 2');
symbol v=star;
title1 h=1.2 'Correspondence Analysis of Headache Type by Age';
title2 j=l 'Output 7.1';
title3 f=duplex 'Symmetric Plot of Age Groups';
run;


/* Program 7.2 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 7.2';
title2 'Correspondence Analysis of Socioeconomic Status';
title3  'by Mental Health of Children';
data status;
length sestatus$8;
input sestatus$ Well Mild Moderate Impaired ;
lines;
1 64 94  58 46
2 57 94  54 40
3 57 105 65 60
4 72 141 77 94
5 36 97  54 78
6 21 71  54 71
;
/* Source: Srole et~al. (1978). Reprinted by permission of
the New York University Press. */

* Asymmetric plot of socioeconomic status;
proc corresp data=status out=plot short rp cp profile=row;
var well mild moderate impaired;
id sestatus;
run;

data plotprint;
set plot;
if dim1=. then delete;
run;
proc print data=plotprint label noobs;
var sestatus dim1 dim2;
label sestatus='Category';
title4 'Results for Asymmetric Display';
run;

data labels;
set plotprint;
x=dim1;
y=dim2;
retain xsys '2' ysys '2';
function='LABEL';
text=sestatus;
position='8';
run;

filename gsasfile "prog72a.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc gplot data=plotprint;
plot dim2 * dim1/anno=labels frame href=0 vref=0
lvref=3 lhref=3 vaxis=axis2 haxis=axis1 vminor=1 hminor=1;
axis1 length=5 in order=(-2 to 2 by .5)  offset=(2)
        label = (h=1.2 'Dimension 1');
axis2 length=5 in order =(-.7 to 2 by .5) offset=(2)
    label=(h=1.2 a=90 r=0  'Dimension 2');

symbol v=star;
title1 h=1.2 'Correspondence Analysis of Socioeconomic
Status';
title2 'by Mental Health of Children';
title3 j=l 'Output 7.2';
title4 f=duplex 'Asymmetric Display of the Categories';
run;

*Symmetric plot of socioeconomic status data;
proc corresp data=status out=plot2 profile=both noprint;
var well mild moderate impaired;
id sestatus;
run;

data plotprint2;
set plot2;
if dim1=. then delete;
run;
proc print data=plotprint2 label noobs;
var sestatus dim1 dim2;
label sestatus='Category';
title4 'Results for Symmetric Display';
run;

data label;
set plotprint2;
x=dim1;
y=dim2;
retain xsys '2' ysys '2';
function='LABEL';
text=sestatus;
position='8';
run;

filename gsasfile "prog72b.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc gplot data=plotprint2;
plot dim2 * dim1/anno=label frame href=0 vref=0
lvref=3 lhref=3 vaxis=axis2 haxis=axis1 vminor=1 hminor=1;
axis1 length=5 in order=(-.3 to .3 by .1)  offset=(2)
        label = (h=1.2 'Dimension 1');
axis2 length=5 in order =(-.05 to .07 by .02) offset=(2)
    label=(h=1.2 a=90 r=0  'Dimension 2');
symbol v=star;
title1 h=1.2 'Correspondence Analysis of Socioeconomic
Status';
title2 'by Mental Health of Children';
title3 j=l 'Output 7.2';
title4 f=duplex 'Symmetric Plot of Age Groups';
run; 


/* Program 7.3 */

options ls=64 ps=45 nodate nonumber;

title1 'Output 7.3';
title2 'Correspondence Analysis Results';
title3 "Rating of Drug's Efficacy: Analgesic Drugs Data";
data rate;
input Drug$     Poor   Fair   Good   V_good   Excellnt;
cards;
Z100             5      1      10       8           6
EC4              5      3       3       8          12
C60             10      6      12       3           0
C15              7     12       8       1           1
;
/* Source: Calimlim et al. (1982).  Reprinted by permission of
the National Heart and Lung Institute, London, England. */

*Results for Asymmetric Plot;
proc corresp data=rate out=plot short profile=row;
var _numeric_;
id drug;
run;

data plotprint;
set plot;
if dim1=. then delete;
run;
proc print data=plotprint noobs label;
var drug dim1 dim2;
label drug='Category';
title4 'Results for Asymmetric Display';
run;

data labels;
set plotprint;
x=dim1;
y=dim2;
retain xsys '2' ysys '2';
function='LABEL';
text=drug;
position='8';
run;

filename gsasfile "prog73a.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc gplot data=plotprint;
plot dim2 * dim1/anno=labels frame href=0 vref=0
lvref=3 lhref=3 vaxis=axis2 haxis=axis1 vminor=1 hminor=1;
axis1 length=5 in order=(-1.75 to 1.25 by .5)  offset=(2)
        label = (h=1.2 'Dimension 1');
axis2 length=5 in order =(-1.25 to 1.75 by .5) offset=(2)
    label=(h=1.2 a=90 r=0  'Dimension 2');
symbol v=star;
title1 h=1.2 'Correspondence Analysis of Drug Efficacy Ratings Data';
title2 j=l 'Output 7.3';
title3 f=duplex 'Asymmetric Plot of Analgesic Drugs';
run;

title1 'Output 7.3';
title2 'Multiple Correspondence Analysis Results';
title3 "Rating of Drug's Efficacy: Analgesic Drugs Data";
data burt;
input row$ Z100  EC4  C60  C15  POOR  FAIR  GOOD  V_GOOD  EXCELLNT;
cards;
 Z100      30     0    0    0     5     1    10      8        6
 EC4        0    31    0    0     5     3     3      8       12
 C60        0     0   31    0    10     6    12      3        0
 C15        0     0    0   29     7    12     8      1        1
 POOR       5     5   10    7    27     0     0      0        0
 FAIR       1     3    6   12     0    22     0      0        0
 GOOD      10     3   12    8     0     0    33      0        0
 V_GOOD     8     8    3    1     0     0     0     20        0
 EXCELLNT   6    12    0    1     0     0     0      0       19
run;

proc corresp data=burt nvars=2 mca out=mplot;
var z100 ec4 c60 c15 poor fair good v_good excellnt;
run;

data mplotprint;
set mplot;
if dim1=. then delete;
run;
proc print data=mplotprint noobs label;
var _name_ dim1 dim2;
label _name_='Category';
title4 'Display of MCA Results';
run;

data mlabel;
set mplotprint;
x=dim1;
y=dim2;
retain xsys '2' ysys '2';
function='LABEL';
text=_name_;
position='8';
run;

filename gsasfile "prog73b.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc gplot data=mplotprint;
plot dim2 * dim1/anno=mlabel frame
        href=0 vref=0 lvref=3 lhref=3 vaxis=axis2 haxis=axis1
        vminor=1 hminor=1;
axis1 length=5 in order=(-1. to 2 by .5)  offset=(2)
        label = (h=1.2 'Dimension 1');
axis2 length=5 in order =(-1.5 to 1.5 by .5) offset=(2)
    label=(h=1.2 a=90 r=0  'Dimension 2');
symbol v=star;
title1 h=1.2 'MCA of Drug Efficacy Ratings Data';
title2 j=l 'Output 7.3';
title3 f=duplex 'Plot of Drugs and Ratings';
run;


/* Program 7.4 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 7.4';
title2 'Multiple Correspondence Analysis';
title3 "Environmental Factors and Farm Management Data";

data farm;
input moisture$ managmnt$ grassuse$ manuare$;
cards;
Moist1 Sf Gu2 Manu4
Moist1 Bf Gu2 Manu2
Moist2 Sf Gu2 Manu4
Moist2 Sf Gu2 Manu4
Moist1 Hf Gu1 Manu2
Moist1 Hf Gu2 Manu2
Moist1 Hf Gu3 Manu3
Moist5 Hf Gu3 Manu3
Moist4 Hf Gu1 Manu1
Moist2 Bf Gu1 Manu1
Moist1 Bf Gu3 Manu1
Moist4 Sf Gu2 Manu2
Moist5 Sf Gu2 Manu3
Moist5 Nm Gu3 Manu0
Moist5 Nm Gu2 Manu0
Moist5 Sf Gu3 Manu3
Moist2 Nm Gu1 Manu0
Moist1 Nm Gu1 Manu0
Moist5 Nm Gu1 Manu0
Moist5 Nm Gu1 Manu0
run;
/* Source: Jongman, Ter Braak and Van Tongeren (1997).
Reprinted by permission of Cambridge Universtiy Press.*/

proc corresp data=farm mca short observed out=plot;
tables moisture managmnt grassuse manuare;
run;

data plotprint;
set plot;
if dim1=. then delete;
run;
proc print data=plotprint noobs label;
var _name_ dim1 dim2;
label _name_='Category';
title4 'Display of MCA Results';
run;

data labels;
set plotprint;
x=dim1;
y=dim2;
retain xsys '2' ysys '2';
function='LABEL';
text=_name_;
position='8';
run;
filename gsasfile "prog74.graph";
goptions reset=all gaccess=gsasfile autofeed dev=psl;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
proc gplot data=plotprint;
plot dim2 * dim1/anno=labels frame
        href=0 vref=0 lvref=3 lhref=3 vaxis=axis2 haxis=axis1
        vminor=1 hminor=1;
axis1 length=5 in order=(-1.5 to 1.5 by .5)  offset=(2)
        label = (h=1.2 'Dimension 1');
axis2 length=5 in order =(-2 to 1.5 by .5) offset=(2)
    label=(h=1.2 a=90 r=0  'Dimension 2');
symbol v=star;
title1 h=1.2 'Multiple Correspondence Analysis: Farm Data';
title2 j=l 'Output 7.4';
title3 f=duplex "Plot of the Variables' Categories";
run;


    /* Program 7.5 */

    options ls=64 ps=45 nodate nonumber;

    title1 'Output 7.5';
    title2 'Correspondence Analysis Results';
    title3 "Rating of Drug's Efficacy: Analgesic Drugs Data";
    data rate;
    input Drug$     Poor   Fair   Good   V_good   Excellnt;
    cards;
    Z100             5      1      10       8           6
    EC4              5      3       3       8          12
    C60             10      6      12       3           0
    C15              7     12       8       1           1
    ;

    proc corresp data=rate short;
    var _numeric_;
    id drug;
    run;

    title2 'Canonical Correlation Analysis Results';
    title3 "Rating of Drug's Efficacy: Analgesic Drugs Data";
    data cancor (type=cov);
    _type_='cov';
    input _name_$ Z100  EC4  C60  C15  POOR  FAIR  GOOD  V_GOOD  EXCELLNT;
    cards;
     Z100      30     0    0    0     5     1    10      8        6
     EC4        0    31    0    0     5     3     3      8       12
     C60        0     0   31    0    10     6    12      3        0
     C15        0     0    0   29     7    12     8      1        1
     POOR       5     5   10    7    27     0     0      0        0
     FAIR       1     3    6   12     0    22     0      0        0
     GOOD      10     3   12    8     0     0    33      0        0
     V_GOOD     8     8    3    1     0     0     0     20        0
     EXCELLNT   6    12    0    1     0     0     0      0       19
    run;

    proc cancorr data=cancor(type=cov);
    var z100 ec4 c60 c15;
    with poor fair good v_good excellnt;
    run;


/* Program 7.6 */

options ls=64 ps=45 nodate nonumber;

title1 'Output 7.6';
*title2 'Modified Andrews Plots for Socioeconomic Status';
*title3  'by Mental Status of Children Data';
data status;
length sestatus$8;
input sestatus$ Well Mild Moderate Impaired ;

lines;
1 64 94  58 46
2 57 94  54 40
3 57 105 65 60
4 72 141 77 94
5 36 97  54 78
6 21 71  54 71
;

proc corresp data=status out=plot short rp cp profile=both dim=3;
var well mild moderate impaired;
id sestatus;
run;

data andrew;
set plot;
y1=dim1; y2=dim2; y3=dim3;
if y1=. then delete;
keep sestatus y1 y2 y3;
run;

filename gsasfile "prog76a.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;

data andrews;
set andrew;
Row_Col=_n_;
pi=3.14159265;
s=1/sqrt(2);
inc=2*pi/100;
do t=-pi to pi by inc;
mz1=s*(y1+(sin(t)+cos(t))*y2+(sin(t)-cos(t))*y3);
output;
end;

symbol1 i=join v=none l=1;
symbol2 i=join v=none l=1;
symbol3 i=join v=none l=1;
symbol4 i=join v=none l=1;
symbol5 i=join v=none l=1;
symbol6 i=join v=none l=1;
symbol7 i=join v=none l=20;
symbol8 i=join v=none l=20;
symbol9 i=join v=none l=20;
symbol10 i=join v=none l=20;

title1 h=1.2 'Modified Andrews Plot';
title2 j=l 'Output 7.6';
title3 'Mental Health vs. Socioeconomic Status';
footnote1 j=l 'Solid line: Rows; Broken line: Columns';
footnote2 j=l ' ';
footnote3 j=l 'Coeff. of y1 is=1/sqrt(2)';

data labels;
set andrews;
retain xsys '2' ysys '2';
x=3.25;
y=s*(y1+(sin(x)+cos(x))*y2+(sin(x)-cos(x))*y3);
function='LABEL';
text=sestatus;
proc gplot data=andrews;
plot mz1*t=Row_Col/vaxis=axis1 haxis=axis2 nolegend anno=labels;
axis1 label=(a=90 h=1.2 f=duplex 'Modified Function: g(t)');
axis2 label=(h=1.2 f=duplex 't') offset=(2);
run;

data andrews2;
set andrew;
Row_Col=_n_;
pi=3.14159265;
s=1/sqrt(2);
inc=2*pi/100;
do t=-pi to pi by inc;
mz2=s*(y2+(sin(t)+cos(t))*y1+(sin(t)-cos(t))*y3);
output;
end;

filename gsasfile "prog76b.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
symbol1 i=join v=none l=1;
symbol2 i=join v=none l=1;
symbol3 i=join v=none l=1;
symbol4 i=join v=none l=1;
symbol5 i=join v=none l=1;
symbol6 i=join v=none l=1;
symbol7 i=join v=none l=20;
symbol8 i=join v=none l=20;
symbol9 i=join v=none l=20;
symbol10 i=join v=none l=20;
title1 h=1.2 'Modified Andrews Plot';
title2 j=l 'Output 7.6';
title3 'Mental Health vs. Socioeconomic Status';
footnote1 j=l 'Solid line: Rows; Broken line: Columns';
footnote2 j=l ' ';
footnote3 j=l 'Coeff. of y2 is=1/sqrt(2)';
data label;
set andrews2;
retain xsys '2' ysys '2';
x=3.25;
y=s*(y2+(sin(x)+cos(x))*y1+(sin(x)-cos(x))*y3);
function='LABEL';
text=sestatus;
proc gplot data=andrews2;
plot mz2*t=Row_Col/vaxis=axis1 haxis=axis2 nolegend anno=label;
 axis1 label=(a=90 h=1.2 f=duplex 'Modified Function: g(t)');
 axis2 label=(h=1.2 f=duplex 't') offset=(2);
run; 


/* Program 7.7 */

options ls=64 ps=45 nodate nonumber;

title1 'Output 7.7';
title2 'Modified Andrews Plot';
title3 'Agreement w.r.t. No. of Diseased Vessels';

data cass;
input ser$ a b c d e;
lines;
1 13  8   1   0   0
2  6 43  19   4   5
3  1  9 155  54  24
4  0  2  18 162  68
5  0  0  11  27 240
;
/* Source: Fisher et al. (1982).  Courtesy: Wiley-Liss, Inc. */

proc corresp data=cass out=plot rp cp short dim=4;
var a b c d e;
id ser;
run;

data andrew;
set plot;
y1=dim1; y2=dim2; y3=dim3; y4=dim4;
if y1=. then delete;
keep ser y1 y2 y3 y4;
run;

data andrews;
set andrew;
Row_Col=_n_;
pi=3.14159265;
s=1/sqrt(2);
inc=2*pi/100;
do t=-pi to pi by inc;
mz1=s*(y1+(sin(t)+cos(t))*y2+(sin(t)-cos(t))*y3+(sin(2*t)+cos(2*t))*y4);
output;
end;
filename gsasfile 'prog77.graph';
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
symbol1 i=join v=none l=1;
symbol2 i=join v=none l=1;
symbol3 i=join v=none l=1;
symbol4 i=join v=none l=1;
symbol5 i=join v=none l=1;
symbol6 i=join v=none l=20;
symbol7 i=join v=none l=20;
symbol8 i=join v=none l=20;
symbol9 i=join v=none l=20;
symbol10 i=join v=none l=20;
title1 h=1.2 'Modified Andrews Plot';
title2 j=l 'Output 7.7';
title3 f=duplex 'Agreement w.r.t. No. of Diseased Vessels';
footnote1 j=l 'Solid line: Rows; Broken line: Columns';
footnote2 j=l ' ';

data label;
set andrews;
retain xsys '2' ysys '2';
x=3.25;
y=s*(y1+(sin(x)+cos(x))*y2+(sin(x)-cos(x))*y3+(sin(2*x)+cos(2*x))*y4);
function='LABEL';
text=ser;
proc gplot data=andrews;
plot mz1*t=Row_Col/vaxis=axis1 haxis=axis2 nolegend anno=label;
axis1 label=(a=90 h=1.5 f=duplex 'Modified Function: g(t)');
axis2 label=(h=1.5 f=duplex 't') offset=(2);
footnote3 j=l 'Coeff. of y1 is=1/sqrt(2)';
run;

/* Program 7.8 */

options ls=64 ps=45 nodate nonumber;

title1 'Output 7.8';
title2 'Correspondence Analysis using Hellinger Distance';
title3 "Rating of Drug's Efficacy: Analgesic Drugs Data";

data d1;
input Drug$     Poor   Fair   Good   V_good   Excellnt;
cards;
Z100             5      1      10       8           6
EC4              5      3       3       8          12
C60             10      6      12       3           0
C15              7     12       8       1           1
;

proc iml;
use d1;
read all var{Poor,Fair,Good,V_good,Excellnt} into Y;
read all var{drug} into id;
close d1;
vars={"Poor", "Fair", "Good", "V_good", "Excellnt"};
id=id//vars;
a=4;
b=5;
one=j(a,1,1);
n=y[+,+];
P=Y/n;
r_sum=j(a,1,0);
do i=1 to a;
r_sum[i,1]=y[i,+]/n;
end;
c_sum=j(1,b,0);
do i=1 to b;
c_sum[1,i]=y[+,i]/n;
end;

D_r=diag(r_sum);
R=inv(D_r)*P;
Drhalf=sqrt(D_r);
eta=sqrt(t(R))*r_sum;
*svd_mat=Drhalf*(sqrt(R)-j(a,1,1)*t(eta));
svd_mat=Drhalf*(sqrt(R)-j(a,1,1)*sqrt(c_sum));
call svd(u_rmat,lambda_r,v_rmat,svd_mat);

lsquare=lambda_r#lambda_r;
sumlsq=lsquare[+];
ratio=lsquare/sumlsq;

print lsquare, sumlsq, ratio;

m=min(a,b);
D_l=diag(lambda_r[1:m]);
row_prof=inv(Drhalf)*(u_rmat[,1:m])*D_l;
delta=sqrt(diag((t(svd_mat)*svd_mat)));
std_cpt=inv(delta)*v_rmat[,1:m]*d_l;
dim=2;
rplot=row_prof[,1:dim];
cpoint=std_cpt[,1:dim];
out=rplot//cpoint;
cvar = concat(shape({"DIM"},1,dim),char(1:dim,1.));
create plot from out[rowname=id colname=cvar];
append from out[rowname=id];
close plot;
run;
data labels;
set plot;
x=dim1;
y=dim2;
retain xsys '2' ysys '2';
function='LABEL';
text=id;
position='8';

filename gsasfile "prog78.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
    proc gplot data=plot;
    plot dim2 * dim1/anno=labels frame
        href=0 vref=0 lvref=3 lhref=3 vaxis=axis2 haxis=axis1
        vminor=1 hminor=1;
    axis1 length=5 in order=(-1 to 1 by .2)  offset=(2)
        label = (h=1.3 'Dimension 1');
    axis2 length=5 in order =(-.8 to .8 by .2) offset=(2)
    label=(h=1.3 a=90 r=0  'Dimension 2');
    symbol v=star;
title1 h=1.2 'Correspondence Analysis Using Hellinger Distance';
title2 j=l 'Output 7.8';
title3 f=duplex 'Plot of Different Drugs';
    run;


/* Program 7.9 */

options ls=64 ps=45 nodate nonumber;
title1 'Output 7.9';
title2 'Plot Based on Hellinger Distance';
title3 'Agreement w.r.t. No. of Diseased Vessels';

data d1;
input ser$ a b c d e;
lines;
1 13  8   1   0   0
2  6 43  19   4   5
3  1  9 155  54  24
4  0  2  18 162  68
5  0  0  11  27 240
;

proc iml;
use d1;
read all var{a,b,c,d,e} into Y;
read all var{ser} into id;
close d1;
vars={"a", "b", "c", "d", "e"};
id=id//vars;

a=5;
b=5;
one=j(a,1,1);
n=y[+,+];
P=Y/n;
r_sum=j(a,1,0);
do i=1 to a;
r_sum[i,1]=y[i,+]/n;
end;
c_sum=j(1,b,0);
do i=1 to b;
c_sum[1,i]=y[+,i]/n;
end;

D_r=diag(r_sum);
R=inv(D_r)*P;
Drhalf=sqrt(D_r);
eta=sqrt(t(R))*r_sum;
*svd_mat=Drhalf*(sqrt(R)-j(a,1,1)*t(eta));
svd_mat=Drhalf*(sqrt(R)-j(a,1,1)*sqrt(c_sum));
call svd(u_rmat,lambda_r,v_rmat,svd_mat);

lsquare=lambda_r#lambda_r;
sumlsq=lsquare[+];
ratio=lsquare/sumlsq;

print lsquare, sumlsq, ratio;

m=min(a,b);
D_l=diag(lambda_r[1:m]);
row_prof=inv(Drhalf)*(u_rmat[,1:m])*D_l;
delta=sqrt(diag((t(svd_mat)*svd_mat)));
std_cpt=inv(delta)*v_rmat[,1:m]*d_l;
dim=2;
rplot=row_prof[,1:dim];
cpoint=std_cpt[,1:dim];
out=rplot//cpoint;
cvar = concat(shape({"DIM"},1,dim),char(1:dim,1.));
create plot from out[rowname=id colname=cvar];
append from out[rowname=id];
close plot;
run;
data labels;
set plot;
x=dim1;
y=dim2;
retain xsys '2' ysys '2';
function='LABEL';
text=id;
position='5';

filename gsasfile "prog79.graph";
goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
goptions horigin=1in vorigin=2in;
goptions hsize=6in vsize=8in;
    proc gplot data=plot;
    plot dim2 * dim1/anno=labels frame
        href=0 vref=0 lvref=3 lhref=3 vaxis=axis2 haxis=axis1
        vminor=1 hminor=1;
    axis1 length=5 in order=(-1 to 1 by .2)  offset=(2)
        label = (h=1.3 'Dimension 1');
    axis2 length=5 in order =(-.8 to .8 by .2) offset=(2)
        label=(h=1.3 a=90 r=0  'Dimension 2');
    symbol v=none;
title1 h=1.2 'Correspondence Analysis Using Hellinger Distance';
title2 j=l 'Output 7.9';
title3 f=duplex 'Agreement w.r.t. No. of Diseased Vessels';
    run;


 /* Program 7.10 */

options ls=64 ps=45 nodate nonumber;

title1 'Output 7.10';
title2 'Canonical Correspondence Analysis';
title3 'Hunting Spider Abundance Data';

data c1;
*Species abundance (y1 to y12) at 28 sites;
input y1-y12;
cards;
0  2  1  0  0  0  5  0  0  0  0  0
0  3  1  1  0  0  4  1  0  0  0  0
0  3  1  0  0  0  4  1  0  0  0  0
0  2  2  1  0  0  5  1  0  0  0  0
0  1  1  0  0  0  4  0  0  0  0  0
0  2  0  0  0  0  5  1  0  0  0  0
0  1  3  3  6  5  8  1  1  0  0  0
0  7  1  1  1  2  5  3  1  0  0  0
0  4  1  0  1  0  4  1  1  0  0  0
1  1  4  9  8  3  9  4  1  1  0  0
2  0  5  5  4  2  7  2  3  0  0  0
1  1  5  3  8  2  9  1  3  0  0  0
1  1  5  5  9  4  9  2  2  1  0  0
3  1  4  9  9  4  9  2  5  1  0  0
1  1  4  7  8  4  9  6  4  1  1  0
1  1  1  4  6  3  8  4  5  3  1  0
0  0  2  3  6  2  7  3  7  5  0  0
0  0  0  1  1  0  1  1  5  1  0  0
0  0  0  1  2  0  3  3  9  4  0  0
0  1  2  2  0  1  4  1  3  3  3  0
0  0  0  0  1  1  2  1  9  3  1  0
0  0  0  0  0  0  1  0  4  1  1  0
0  0  0  0  0  0  1  0  2  3  3  1
0  1  0  0  0  0  1  0  2  4  3  2
0  0  0  0  0  0  1  0  1  2  4  1
0  0  0  0  0  0  0  0  1  5  3  2
0  0  0  0  0  0  0  0  1  3  4  2
0  0  0  0  0  0  1  0  0  1  2  4
run;
data c2;
*Data on Environmental Variables (z1 to z6) on 28 sites;
input z1-z6;
cards;
9  0  1  1  9  5
7  0  3  0  9  2
8  0  1  0  9  0
8  0  1  0  9  0
9  0  1  2  9  5
8  0  0  2  9  5
8  0  2  3  3  9
6  0  2  1  9  6
7  0  1  0  9  2
8  0  0  5  0  9
9  5  5  1  7  6
8  0  4  2  0  9
6  0  5  6  0  9
8  0  1  5  0  9
9  3  1  7  3  9
6  0  5  8  0  9
5  0  7  8  0  9
5  0  9  7  0  6
6  0  8  8  0  8
3  7  2  5  0  8
4  0  9  8  0  7
4  8  7  8  0  5
0  7  8  8  0  6
0  6  9  9  0  6
1  7  9  8  0  0
0  5  8  8  0  6
2  7  9  9  0  5
0  9  4  9  0  2
run;
/* Source for both of these data sets: Van der Aart
and Smeek-Enserink (1975).  Reprinted by permission
of Brill Academic Publishers, Inc.*/

data a;
merge c1;
merge c2;

proc print data=a noobs;
run;

* PROC IML is used to do all the calculations;

*Create Data and Other Matrices;
proc iml;
use a;
read all var{y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12} into Y;
read all var{z1,z2,z3,z4,z5,z6} into Z;
close a;

m=12; /*Number of species */
q=6; /*Number of environmental variables */
n=28; /*Number of sites */

one=j(n,1,1);

sum1=j(m,1,0);
do i=1 to m;
sum1[i,1]=y[+,i];
end;
S11=diag(sum1);

r1=j(n,1,0);
do i=1 to n;
r1[i,1]=y[i,+];
end;
R=diag(r1);
R_star=R/y[+,+];

*Standardize (Weighted Mean=0, SD=1) environmental
variables;
Z=Z-j(n,n,1)*R_star*Z;
temp1=Z`*R_star*Z;
temp2=diag(temp1);
temp2=sqrt(temp2);
scalem=inv(temp2);
Z=Z*scalem;

*Create W, the fundamental matrix for the analysis;
S12=Y`*Z;
S22=Z`*R*Z;
* Find S11^(1/2) and S11^(-1/2);
s11_hf=j(m,m,0);
s11_nhf=j(m,m,0);
do i=1 to m;
s11_hf[i,i]=sqrt(S11[i,i]);
s11_nhf[i,i]=1/sqrt(S11[i,i]);
end;

* Find S22^(1/2) and S22^(-1/2);
call eigen(lambd,ev,S22);
lambda=diag(lambd);
lmda_hf=j(q,q,0);
lmda_nhf=j(q,q,0);
do i=1 to q;
lmda_hf[i,i]=sqrt(lambda[i,i]);
lmda_nhf[i,i]=1/sqrt(lambda[i,i]);
end;
s22_hf=ev*lmda_hf*ev`;
s22_nhf=ev*lmda_nhf*ev`;
W=s11_nhf*S12*s22_nhf;
print 'The Fundamental Matrix W';
print W;

*The SVD of the fundamental matrix W ;
call svd(P_mat,Lambda,Q_mat,W);
D=diag(Lambda);
*The diagonal elements of D matrix are the eigenvalues;
D=D*D;
print 'Eigenvalues';
print D;
print 'Eigenvectors';
print P_mat Q_mat;
print ' ';

*Solutions to Canonical Correspondence Analysis;
u_mat=s11_nhf*P_mat;
beta_mat=s22_nhf*Q_mat;
print 'Solutions to Canonical Correspondence Analysis';
print u_mat beta_mat;

*Sample Scores: Linear combinations of environmental variables;
X=Z*beta_mat;

*Species scores;
U_hat=inv(s11)*Y`*X*diag(1/lambda); * Assuming alpha=0;
print 'Species scores';
print U_hat;

*Standardize (Weighted Mean=0, SD=1) the X matrix;
X=X-j(n,n,1)*R_star*X;
temp1=X`*R_star*X;
temp2=diag(temp1);
temp2=sqrt(temp2);
scalem=inv(temp2);
X=X*scalem;
print 'Sample Scores: Linear combinations of environmental
variables';
print X;

*Canonical Coefficients corresponding to eigenvectors;
B_hat=inv(Z`*Z)*Z`*X;
print 'Canonical Coefficients corresponding to eigenvectors';
print B_hat;

* Biplot scores of environmental variables;
*COEVO=Z`*R_star*X;
*print COEVO;

*Species scores;
U_hat=inv(s11)*Y`*X; * Assuming alpha=0;
print 'Species scores';
print U_hat;

*Sample Scores;
X_star=inv(R)*Y*U_hat*inv(D);
print 'Sample Scores';
print X_star;

*Standardize (Weighted Mean=0, SD=1) the X_star matrix;
X_star=X_star-j(n,n,1)*R_star*X_star;
temp1=X_star`*R_star*X_star;
temp2=diag(temp1);
temp2=sqrt(temp2);
scalem=inv(temp2);
X_star=X_star*scalem;

*Correlation of an Environmental variable with an
ordination axis;
EOCORR=Z`*R_star*X_star;
print 'Correlation of an Environmental variable with
an ordination axis';
print 'OR Inter set Correlations';
print EOCORR;

*Species-Environment Correlations;
SECORR=X`*R_star*X_star;
SECORR=diag(secorr);
print 'Species-Environment Correlations';
print SECORR;

*Biplots;
print ' ';
print 'Biplot Information';

id={'Arct_lute', 'Pard_lugu', 'Zora_spin', 'Pard_nigr',
    'Pard_pull', 'Aulo_albi', 'Troc_terr', 'Alop_cune',
    'Pard_mont', 'Alop_acce', 'Alop_fabr',  'Arct_peri'};

vars={"WATER_CONTENT" "BARE_SAND" "COVER_MOSS"
"LIGHT_REFL" "FALLEN_TWIGS" "COVER_HERBS"};

reset fw=8 noname;
percent = 100*lambda##2 / lambda[##];
*Cumulate by multiplying by lower triangular matrix of 1's;
j = nrow(lambda);
tri = (1:j)` * repeat(1,1,j) >= repeat(1,j,1)*(1:j);
cum = tri*percent;
Print "Singular values and variance accounted for",,
    Lambda [colname={'Singular Values'} format=9.4]
    percent [colname={'Percent'} format=8.2]
    cum [colname={'cum % '} format = 8.2];

dim=2;
power=0;
scale=0.01;
U=s11_nhf*P_mat;
V=s22_hf*Q_mat;
U=U[,1:dim];
V=V[,1:dim];
Lambda=Lambda[1:dim];

*Scale the vectors by DL ,DR;
DL= diag(Lambda ## power);
DR= diag(Lambda ## (1-power));
A = U * DL;
B = V * DR # scale;

OUT=A // B;
*Create observation labels;
id = id // vars`;

type = repeat({"OBS "},m,1) // repeat({"VAR "},q,1);
       id  = concat(type,id);
   cvar = concat(shape({"DIM"},1,dim),char(1:dim,1.));
    * Create sas data set BIPLOT;
create plot from out[rowname=id colname=cvar];
append from out[rowname=id];
close plot;
*proc print;
run;

*Split id into _type_ and _Name_;
    data plot;
    set plot;
    drop id;
    length _type_  $3 _name_ $16;
    _type_ = scan(id,1);
    _name_ = scan(id,2);
    run;

*Annotate observation labels and variable vectors;
    data label;
    set plot;
    length text $16;
    xsys='2'; ysys='2';
    text=_name_;
    if _type_='OBS' then do;
    x = dim1;
    y = dim2;
    position='5';
    function='LABEL';
    output;
    end;
* Draw line from the origin to the variable point;
    if _type_ ='VAR' then do;
    x=0; y=0;
    function ='MOVE';
    output;
    x=dim1;
    y=dim2;
    function ='DRAW';
    output;
    if dim1>=0 then position ='6';  /*left justify*/
    else position ='2';             /*right justify*/
    function='LABEL';               /*variable name*/
    output;
    end;
    run;

* Plot the biplot using proc gplot;
    filename gsasfile "prog710.graph";
    goptions reset=all gaccess=gsasfile autofeed dev=pslmono;
    goptions horigin=1in vorigin=2in;
    goptions hsize=6in vsize=8in;

    proc gplot data=plot;
    plot dim2*dim1/anno=label frame href=0 vref=0
    lvref=3 lhref=3 vaxis=axis2 haxis=axis1 vminor=1 hminor=1;
    axis1 length=5 in order=(-.20 to .20 by .05)  offset=(2)
        label = (h=1.2 'Dimension 1');
    axis2 length=5 in order =(-.15 to .15 by .05) offset=(2)
    label=(h=1.2 a=90 r=0  'Dimension 2');
    symbol v=none;
    title1 h=1.2 'Biplot of Hunting Spider Data ';
    title2 j=l 'Output 7.10';
    title3 f=duplex 'Observations are points,
                           Variables are vectors';
    run;

 