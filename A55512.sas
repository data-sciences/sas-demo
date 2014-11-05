/*-------------------------------------------------------------*/
/* Forecasting Examples for Business and Economics Using the   */
/* SAS(R) System                                               */
/*                                                             */
/* SAS Publications order # 55512                              */
/* ISBN 1-55544-763-5                                          */
/* Copyright 1996 by SAS Institute Inc., Cary, NC, USA.        */
/*                                                             */
/*-------------------------------------------------------------*/





/* -------------------------- */
/* INTRODUCTION               */
/* -------------------------- */

/* The following programs are found on pp. 1-25     */
/* in Forecasting Examples for Business and         */
/* Economics Using the SAS System.                  */

/* p. 2 */
data almon;
   input y x @@;
   retain date '1oct52'd;
   date=intnx('qtr',date,1);
   format date yyq.;
   qtr = mod( _n_-1, 4 ) + 1;
   q1  = qtr=1;
   q2  = qtr=2;
   q3  = qtr=3;
   label y='Capital Expenditures'
         x='Appropriations';
   title 'National Industrial Conference Board Data';
   datalines;
2071 1660   2077 1926   2078 2181   2043 1897   2062 1695
2067 1705   1964 1731   1981 2151   1914 2556   1991 3152
2129 3763   2309 3903   2614 3912   2896 3571   3058 3199
3309 3262   3446 3476   3466 2993   3435 2262   3183 2011
2697 1511   2338 1631   2140 1990   2012 1993   2071 2520
2192 2804   2240 2919   2421 3024   2639 2725   2733 2321
2721 2131   2640 2552   2513 2234   2448 2282   2429 2533
2516 2517   2534 2772   2494 2380   2596 2568   2572 2944
2601 2629   2648 3133   2840 3449   2937 3764   3136 3983
3299 4381   3514 4786   3815 4094   4093 4870   4262 5344
4531 5433   4825 5911   5160 6109   5319 6542   5574 5785
5749 5707     .  5412     .  5465     .  5550     .  5465
;

/* p. 3 */
data ces;
   input id k l q @@;
   label k ='Capital Input'
         l ='Labor Input'
         q ='Output';
   datalines;
01 8 23 106.00  02 9 14  81.08  03 4 38  72.80  04 2 97  57.34
05 6 11  66.79  06 6 43  98.23  07 3 93  82.68  08 6 49  99.77
09 8 36 110.00  10 8 43 118.93  11 4 61  95.05  12 8 31 112.83
13 3 57  64.54  14 6 97 137.22  15 4 93  86.17  16 2 72  56.25
17 3 61  81.10  18 3 97  65.23  19 9 89 149.56  20 3 25  65.43
21 1 81  36.06  22 4 11  56.92  23 2 64  49.59  24 3 10  43.21
25 6 71 121.24
;
 
/* pp. 3-6 */
data constr;
  input date:monyy5. contrcts intrate hstarts @@;
  format date monyy5.;
  title 'Construction Data';
  datalines;
JAN83 11358 13.00   91.3   FEB83 11355 12.62   96.3
MAR83 16100 12.97  134.6   APR83 16315 12.02  135.8
MAY83 19205 12.21  174.9   JUN83 20263 11.90  173.2
JUL83 16885 12.02  161.6   AUG83 19441 12.01  176.8
SEP83 17379 12.08  154.9   OCT83 16028 11.80  159.3
NOV83 15401 11.82  136.0   DEC83 13518 11.94  108.3
JAN84 14023 11.80  109.1   FEB84 14442 11.78  130.0
MAR84 17916 11.56  137.5   APR84 17655 11.55  172.7
MAY84 21990 11.68  180.7   JUN84 20036 11.61  184.0
JUL84 19224 11.91  162.1   AUG84 19367 11.89  147.4
SEP84 16923 12.03  148.5   OCT84 18413 12.27  152.3
NOV84 16616 12.27  126.2   DEC84 14220 12.05   98.9
JAN85 15154 11.77  105.4   FEB85 13652 11.74   95.8
MAR85 20004 11.42  145.2   APR85 20692 11.55  176.0
MAY85 22532 11.55  170.5   JUN85 20043 11.31  163.4
JUL85 22047 10.94  160.7   AUG85 21055 10.78  160.7
SEP85 20541 10.69  147.7   OCT85 21715 10.64  173.0
NOV85 17691 10.55  124.1   DEC85 16276 10.47  120.5
JAN86 15417 10.40  115.6   FEB86 16152 10.21  107.2
MAR86 19617 10.04  151.0   APR86 23754  9.87  188.2
MAY86 23050  9.84  186.6   JUN86 23740  9.74  183.6
JUL86 23621  9.89  172.0   AUG86 21884  9.84  163.8
SEP86 21763  9.74  154.0   OCT86 21862  9.57  154.8
NOV86 17998  9.45  115.6   DEC86 17982  9.28  113.0
JAN87 16694  9.14  105.1   FEB87 15729  8.87  102.8
MAR87 22622  8.77  141.2   APR87 23077  8.84  159.3
MAY87 22054  8.99  158.0   JUN87 25703  9.05  162.9
JUL87 24567  9.01  152.4   AUG87 23836  9.01  143.6
SEP87 22418  9.03  152.0   OCT87 23360  8.86  139.1
NOV87 18663  8.92  118.8   DEC87 19224  8.78   85.4
JAN88 15113  8.75   78.2   FEB88 17496  8.76   90.2
MAR88 22257  8.77  128.8   APR88 22344  8.76  153.2
MAY88 24138  8.59  140.2   JUN88 26940  8.90  150.2
JUL88 22309  8.80  137.0   AUG88 24826  8.68  136.8
SEP88 22670  8.90  131.1   OCT88 22223  8.77  135.1
NOV88 19767  9.05  113.0   DEC88 19125  9.04   94.2
JAN89 15776  9.20  100.1   FEB89 15086  9.46   85.8
MAR89 21080  9.63  117.8   APR89 21725  9.88  129.4
MAY89 23796  9.82  131.7   JUN89 24650 10.09  143.2
JUL89 22330 10.06  134.7   AUG89 24128  9.83  122.4
SEP89 23371  9.87  109.3   OCT89 22669  9.77  130.1
;

goptions cback=white colors=(black) border reset=(axis symbol);

axis1 offset=(1 cm)
      label=('Year') minor=none
      order=('01jan83'd to '01jan90'd by year);
axis2 label=(angle=90 'Construction Contracts')
      order=(10000 to 30000 by 5000);

symbol1 i=join;

proc gplot data=constr;
   format date year4.;
   plot contrcts*date / haxis=axis1
                        vaxis=axis2
                        vminor=1;
   title2 'Construction Contracts';
run;

axis2 label=(angle=90 'Interest Rate')
      order=(8.0 to 14.0 by 1);

proc gplot data=constr;
   format date year4.;
   plot intrate*date / haxis=axis1
                       vaxis=axis2
                       vminor=1;
   title2 'Interest Rates';
run;

axis2 label=(angle=90 'Housing Starts')
      order=(75 to 200 by 25);

proc gplot data=constr;
   format date year4.;
   plot hstarts*date / haxis=axis1
                       vaxis=axis2
                       vminor=0;
   title2 'Housing Starts';
run;

/* pp. 7-8 */
data consume;
   format date monyy.;
   input date:monyy5. di_n c_n cpi @@;
      c = c_n/cpi;
     di = di_n/cpi;
    c_1 = lag(c);
   label di='Real Disposable Income in Billions 1982$'
         c='Real Consumption in Billions of 1982$'
         c_1='1 Month Lagged Real C in Billions 1982$';
   title 'Consume Data';
   datalines;
SEP82 2283.2 2140.1  .979  OCT82 2299.8 2157.9  .982
NOV82 2321.7 2178.7  .980  DEC82 2332.7 2188.1  .976
JAN83 2344.3 2196.9  .978  FEB83 2339.2 2202.4  .979
MAR83 2353.7 2219.3  .979  APR83 2382.0 2249.9  .986
MAY83 2397.4 2276.9  .992  JUN83 2406.9 2296.3  .995
JUL83 2438.6 2318.1  .999  AUG83 2433.2 2329.8 1.002
SEP83 2457.7 2332.4 1.007  OCT83 2499.1 2366.2 1.010
NOV83 2528.7 2378.4 1.012  DEC83 2555.9 2402.9 1.013
JAN84 2585.2 2437.2 1.019  FEB84 2614.3 2414.2 1.024
MAR84 2635.9 2440.8 1.026  APR84 2637.8 2469.6 1.031
MAY84 2637.0 2489.7 1.034  JUN84 2653.5 2510.7 1.037
JUL84 2675.9 2508.1 1.041  AUG84 2688.0 2522.3 1.045
SEP84 2709.4 2547.3 1.050  OCT84 2710.9 2540.7 1.053
NOV84 2725.5 2585.2 1.053  DEC84 2749.5 2588.1 1.053
JAN85 2771.2 2620.3 1.055  FEB85 2764.6 2633.6 1.060
MAR85 2757.9 2653.6 1.064  APR85 2832.9 2654.0 1.069
MAY85 2890.2 2701.1 1.073  JUN85 2829.2 2693.7 1.076
JUL85 2835.1 2709.8 1.078  AUG85 2837.4 2742.1 1.080
SEP85 2847.5 2788.4 1.083  OCT85 2877.2 2764.0 1.087
NOV85 2887.5 2781.1 1.090  DEC85 2933.7 2818.2 1.093
JAN86 2944.9 2828.6 1.096  FEB86 2958.1 2819.2 1.093
MAR86 2974.6 2822.1 1.088  APR86 3010.6 2837.0 1.086
MAY86 3004.5 2859.1 1.089  JUN86 3004.2 2858.3 1.095
JUL86 3013.5 2882.5 1.095  AUG86 3022.2 2903.4 1.097
SEP86 3037.0 2967.1 1.102  OCT86 3047.4 2937.4 1.103
NOV86 3061.2 2944.5 1.104  DEC86 3081.4 3002.4 1.105
JAN87 3112.3 2965.1 1.112  FEB87 3149.5 3030.0 1.116
MAR87 3157.6 3039.5 1.121  APR87 3044.2 3065.0 1.127
MAY87 3163.6 3073.4 1.131  JUN87 3169.2 3101.3 1.135
JUL87 3192.5 3123.5 1.138  AUG87 3213.9 3158.9 1.144
SEP87 3227.0 3152.5 1.150  OCT87 3293.7 3158.5 1.153
NOV87 3281.6 3165.5 1.154  DEC87 3331.6 3193.7 1.154
JAN88 3341.9 3225.3 1.157  FEB88 3381.4 3235.1 1.160
MAR88 3412.6 3266.2 1.165  APR88 3399.3 3268.6 1.171
MAY88 3441.8 3295.5 1.175  JUN88 3477.0 3331.8 1.180
JUL88 3507.4 3345.2 1.185  AUG88 3516.8 3370.1 1.190
SEP88 3536.0 3374.3 1.198  OCT88 3585.0 3414.8 1.202
NOV88 3560.8 3427.8 1.203  DEC88 3590.8 3448.6 1.205
JAN89 3618.6 3460.8 1.211  FEB89 3669.1 3475.7 1.216
MAR89 3697.5 3479.4 1.223  APR89 3676.5 3518.9 1.231
MAY89 3696.2 3527.5 1.238  JUN89 3719.3 3539.0 1.241
JUL89 3740.1 3569.0 1.244  AUG89 3741.0 3597.8 1.246
SEP89 3749.0 3599.6 1.250  OCT89 3772.9 3605.0 1.256
NOV89 3802.1 3618.1 1.259  DEC89 3823.9 3653.4 1.261
JAN90 3861.2     .  1.274  FEB90 3886.1     .  1.280
MAR90 3915.9     .  1.287  APR90 3915.5     .  1.289
MAY90 3927.7     .  1.292  JUN90 3945.7     .  1.299
;

/* pp. 9-10 */
data djm;
   input date:monyy5. djiam @@;
   format date monyy5.;
   title 'Dow Jones Index Data';
   title2 'Monthly Average';
   datalines;
jan84 1258.89 feb84 1164.46 mar84 1161.97 apr84 1152.71
may84 1143.42 jun84 1121.14 jul84 1113.27 aug84 1212.82
sep84 1213.51 oct84 1199.30 nov84 1211.30 dec84 1188.96
jan85 1238.16 feb85 1283.23 mar85 1268.83 apr85 1266.36
may85 1279.40 jun85 1314.00 jul85 1343.17 aug85 1326.18
sep85 1317.95 oct85 1351.58 nov85 1432.88 dec85 1517.02
jan86 1534.86 feb86 1652.73 mar86 1757.35 apr86 1807.05
may86 1801.80 jun86 1867.70 jul86 1809.92 aug86 1843.45
sep86 1813.47 oct86 1817.04 nov86 1883.65 dec86 1924.07
jan87 2065.13 feb87 2202.34 mar87 2292.61 apr87 2302.64
may87 2291.11 jun87 2384.02 jul87 2481.72 aug87 2655.01
sep87 2570.80 oct87 2224.59 nov87 1931.86 dec87 1910.07
jan88 1947.35 feb88 1980.65 mar88 2044.31 apr88 2036.13
may88 1988.91 jun88 2104.94 jul88 2104.22 aug88 2051.29
sep88 2080.06 oct88 2144.31 nov88 2099.04 dec88 2148.58
jan89 2234.68 feb89 2304.30 mar89 2283.11 apr89 2348.91
may89 2439.55 jun89 2494.90 jul89 2554.03 aug89 2691.11
sep89 2693.41 oct89 2692.01 nov89 2642.49 dec89 2728.47
jan90 2679.24 feb90 2614.18 mar90 2700.13 apr90 2708.26
may90 2793.81 jun90 2894.82 jul90 2934.23 aug90 2681.89
sep90 2550.69 oct90 2460.54 nov90 2518.56 dec90 2610.92
jan91 2587.60 feb91 2863.04 mar91 2920.11 apr91 2925.53
may91 2928.42 jun91 2968.13 jul91 2978.18 aug91 3006.08
sep91 3010.35 oct91 3019.73 nov91 2986.12 dec91 2958.64
jan92 3227.06 feb92 3257.27 mar92 3247.41 apr92 3294.08
may92 3376.78 jun92 3337.79 jul92 3329.40 aug92 3307.45
sep92 3293.92 oct92 3198.69 nov92 3238.49 dec92 3303.15
jan93 3277.71 feb93 3367.26 mar93 3440.73 apr93 3423.62
may93 3478.17 jun93 3513.81 jul93 3529.43 aug93 3597.01
sep93 3592.28 oct93 3625.80 nov93 3674.69 dec93 3743.62
jan94 3868.36 feb94 3905.61
;

goptions cback=white colors=(black) border reset=(axis symbol);

axis1 offset=(1 cm)
      label=('Year') minor=none
      order=('01jan84'd to '01jan95'd by year);
axis2 label=(angle=90 'Dow Jones Index')
      order=(1000 to 4000 by 500);

symbol1 i=join;

proc gplot data=djm;
   format date year4.;
   plot djiam*date / haxis=axis1
                     vaxis=axis2
                     vminor=1;
run;

/* pp. 11-12 */
data drivers;
   format date monyy.;
   input date:monyy5. injuries @@;
   beltlaw = (date ge '01jan83'd);
   title 'Driver Casualties Data';
   title2 'monthly totals';
   datalines;
jan80  1665  feb80  1361  mar80  1506  apr80  1360  
may80  1453  jun80  1522  jul80  1460  aug80  1552
sep80  1548  oct80  1827  nov80  1737  dec80  1941
jan81  1474  feb81  1458  mar81  1542  apr81  1404
may81  1522  jun81  1385  jul81  1641  aug81  1510
sep81  1681  oct81  1938  nov81  1868  dec81  1726
jan82  1456  feb82  1445  mar82  1456  apr82  1365
may82  1487  jun82  1558  jul82  1488  aug82  1684
sep82  1594  oct82  1850  nov82  1998  dec82  2079
jan83  1494  feb83  1057  mar83  1218  apr83  1168
may83  1236  jun83  1076  jul83  1174  aug83  1139
sep83  1427  oct83  1487  nov83  1483  dec83  1513
jan84  1357  feb84  1165  mar84  1282  apr84  1110
may84  1297  jun84  1185  jul84  1222  aug84  1284
sep84  1444  oct84  1575  nov84  1737  dec84  1763
jan85  .     feb85  .     mar85  .     apr85  .
may85  .     jun85  .     jul85  .     aug85  .
sep85  .     oct85  .     nov85  .     dec85  .
;

goptions cback=white colors=(black) border reset=(axis symbol);

axis1 offset=(1 cm) label=('Year')
      order=('01jan80'd to '01jan85'd by year);
axis2 label=(angle=90 'Casualties')
      order=(800 to 2200 by 200);

symbol1 i=join l=1 v=star;

proc gplot data=drivers;
   format date year4.;
   plot injuries*date=1 / haxis=axis1
                          vaxis=axis2
                          vminor=1
                          href='01jan83'd
                          lh=2;
run;

/* pp. 12-14 */
data electric;
   input date:monyy5. elecprod @@;
   format date monyy5.;
   title 'Electricity Production Data';
   title2 '(millions of kilowatt hours)';
   datalines;
jan80 200005 feb80 188715 mar80 187464 apr80 168720 
may80 175734 jun80 189430 jul80 216776 aug80 215393
sep80 191485 oct80 178555 nov80 178550 dec80 195613
jan81 206467 feb81 179613 mar81 185553 apr81 172545
may81 177806 jun81 202702 jul81 220373 aug81 210403
sep81 186838 oct81 181352 nov81 175570 dec81 195590
jan82 209403 feb82 180299 mar82 187687 apr82 172580
may82 177147 jun82 186128 jul82 210584 aug82 205656
sep82 180662 oct82 172966 nov82 173377 dec82 184722
jan83 195579 feb83 172479 mar83 182488 apr83 170372
may83 174392 jun83 191048 jul83 220165 aug83 229957
sep83 195604 oct83 182931 nov83 182949 dec83 212319
jan84 216632 feb84 189564 mar84 200107 apr84 181084
may84 192217 jun84 209649 jul84 221245 aug84 229296
sep84 195198 oct84 190936 nov84 190380 dec84 199996
jan85 227856 feb85 198242 mar85 194970 apr85 184877
may85 196790 jun85 205363 jul85 226722 aug85 226050
sep85 202499 oct85 194789 nov85 192427 dec85 219255
jan86 217470 feb86 192336 mar86 196834 apr86 186074
may86 197315 jun86 215015 jul86 242672 aug86 225166
sep86 206692 oct86 197754 nov86 196432 dec86 213551
jan87 222749 feb87 194034 mar87 201849 apr87 189496
may87 206074 jun87 225589 jul87 247915 aug87 247645
sep87 213008 oct87 203009 nov87 200258 dec87 220500
jan88 237600 feb88 216702 mar88 213838 apr88 195809
may88 208180 jun88 232507 jul88 257235 aug88 267408
sep88 220023 oct88 210377 nov88 209394 dec88 232550
jan89 231343 feb89 219066 mar89 226436 apr89 207749
may89 219803 jun89 235397 jul89 256744 aug89 258335
sep89 226848 oct89 219587 nov89 218980 dec89 258637
jan90 237339 feb90 212708 mar90 225254 apr90 211088
may90 222908 jun90 248935 jul90 266228 aug90 268483
sep90 237869 oct90 224794 nov90 213596 dec90 237257
jan91 247984 feb91 210496 mar91 221117 apr91 208936
may91 233991 jun91 248165 jul91 271492 aug91 267698
sep91 233897 oct91 223180 nov91 221029
;

goptions cback=white colors=(black) border reset=(axis symbol);

axis1 offset=(1 cm)
      label=('Year') minor=none
      order=('01jan80'd to '01jan92'd by year);
axis2 label=(angle=90 'Electricity Production')
      order=(150000 to 300000 by 50000);

symbol1 i=join;

proc gplot data=electric;
   format date year4.;
   plot elecprod*date / haxis=axis1
                        vaxis=axis2
                        vminor=1;
run;

/* pp. 16-17 */
data exch1;
   input year rate_fr rate_wg rate_it cpi_us cpi_fr cpi_wg cpi_it
         imn_fr / imn_wg imn_it mm_us mm_fr mm_wg mm_it prod_us
         prod_fr prod_wg prod_it;
         ius = 100*dif(cpi_us)/lag(cpi_us);
         ifr = 100*dif(cpi_fr)/lag(cpi_fr);
         iwg = 100*dif(cpi_wg)/lag(cpi_wg);
         iit = 100*dif(cpi_it)/lag(cpi_it);
       im_fr = imn_fr/cpi_us;
       im_wg = imn_wg/cpi_us;
       im_it = imn_it/cpi_us;
       di_fr = ius - ifr;
       di_wg = ius - iwg;
       di_it = ius - iit;
       dr_fr = (mm_fr-ifr)-(mm_us-ius);
       dr_wg = (mm_wg-iwg)-(mm_us-ius);
       dr_it = (mm_it-iit)-(mm_us-ius);
   label im_fr = 'Imports to US from France in 1984 $'
         im_wg = 'Imports to US from WG in 1984 $'
         im_it = 'Imports to US from Italy in 1984 $'
         di_fr = 'Difference in Inflation Rates US-France'
         di_wg = 'Difference in Inflation Rates US-WG'
         di_it = 'Difference in Inflation Rates US-Italy'
         dr_fr = 'Difference in Real MM Rates US-France'
         dr_wg = 'Difference in Real MM Rates US-WG'
         dr_it = 'Difference in Real MM Rates US-Italy';
   datalines;
1977 4.9161 2.3236  882.78 0.606 0.527 0.769 0.401  3032
   7238  3037   .     .     .     .    78.2  92    88.0  83.8
1978 4.5091 2.0096  849.13 0.652 0.575 0.790 0.451  4051
   9962  4102  7.93  8.16  3.70 11.49  82.6  94    90.4  85.4
1979 4.2567 1.8342  831.11 0.726 0.636 0.823 0.521  4768
  10955  4917 11.20  9.48  6.69 11.86  85.7  99    94.7  91.1
1980 4.2251 1.8175  856.21 0.824 0.723 0.868 0.635  5265
  11693  4325 13.36 12.20  9.10 17.17  84.1  98.9  95.0  96.2
1981 5.4397 2.2631 1138.58 0.909 0.820 0.922 0.753  5851
  11379  5189 16.38 15.26 12.11 19.60  85.7  98.3  93.2  94.7
1982 6.5794 2.4280 1354.00 0.965 0.916 0.970 0.877  5545
  11975  5301 12.26 14.73  8.88 20.18  81.9  97.3  90.3  91.7
1983 7.6204 2.5539 1519.32 0.996 1.005 1.003 1.008  6025
  12695  5455  9.09 12.63  5.78 18.44  84.9  96.5  90.9  88.9
1984 8.7356 2.8454 1756.11 1.039 1.079 1.027 1.115  8113
  16996  7935 10.23 11.88  5.55 17.27  92.8  97.1  93.5  91.8
1985 8.9800 2.9419 1908.88 1.076 1.142 1.048 1.211  9482
  20239  9674  8.10 10.08  5.20 15.25  94.4  97.2  97.7  92.9
1986 6.9257 2.1704 1491.16 1.096 1.172 1.047 1.285 10129
  25124 10607  6.81  7.74  4.60 13.41  95.3  98.0  99.6  96.2
1987 6.0122 1.7981 1297.03 1.136 1.209 1.049 1.344 10730
  27069 11040  6.66  7.98  3.70 11.51 100.0 100.0 100.0 100.0
1988 5.9595 1.7569 1302.39 1.183 1.242 1.063 1.411 12228
  26503 11611  7.61  7.52  4.00 11.29 104.4 104.6 103.9 105.9
1989 6.3802 1.8808 1372.28 1.240 1.286 1.092 1.504 13014
  24971 11933  9.22  9.07  6.59 12.69 106.0 108.9 108.8 109.2
1990 5.4467 1.6166 1198.27 1.307 1.330 1.121 1.595 13153
  28162 12751  8.10  9.85  7.92 12.38 106.0 111.0 114.5 109.4
1991 5.6468 1.6610 1241.28 1.362 1.372 1.160 1.698 13333
  26137 11764  5.70  9.49  8.84 12.18 104.3 111.0 117.9 108.4
1992  .      .         .   1.403 1.406 1.206 1.788 14797
  28829 12314  3.52 10.35  9.42 13.97 107.6 109.7 115.6 108.2
1993  .      .         .   1.445 1.435 1.256 1.863 15244
  28605 13223  3.02  8.75  7.49 10.20 112.0 105.6 107.2 105.4
;

/* pp. 18-19 */
data finance;
   format date date7.;
   input date : monyy5. djiam gold aaa @@;
   label djiam='DJIA Index Price'
         gold='Gold Price per Troy Ounce'
         aaa='Moody''s AAA Bond Yields';
   title 'Finance Data';
   datalines;
jan89 2234.68 404.014 9.62  feb89 2304.30 387.776 9.64
mar89 2283.11 390.143 9.80  apr89 2348.91 384.400 9.79
may89 2439.55 371.316 9.57  jun89 2494.90 367.598 9.10
jul89 2554.03 374.978 8.93  aug89 2691.11 364.928 8.96
sep89 2693.41 361.890 9.01  oct89 2692.01 366.884 8.92
nov89 2642.49 392.320 8.89  dec89 2728.47 409.150 8.86
jan90 2679.24 415.596 8.99  feb90 2614.18 416.826 9.22
mar90 2700.13 393.059 9.37  apr90 2708.26 374.265 9.46
may90 2793.81 369.191 9.47  jun90 2894.82 352.331 9.26
jul90 2934.23 362.531 9.24  aug90 2681.89 395.033 9.41
sep90 2550.69 389.458 9.56  oct90 2460.54 380.739 9.53
nov90 2518.56 381.718 9.30  dec90 2610.92 378.163 9.05
jan91 2587.60 383.640 9.04  feb91 2863.04 363.830 8.83
mar91 2920.11 363.340 8.93  apr91 2925.53 358.390 8.86
may91 2928.42 356.820 8.86  jun91 2968.13 366.720 9.01
jul91 2978.18 367.510 9.00  aug91 3006.08 356.230 8.75
sep91 3010.35 348.790 8.61  oct91 3019.73 358.680 8.55
nov91 2986.12 359.530 8.48  dec91 2958.64 361.060 8.31
jan92 3227.06 354.450 8.20  feb92 3257.27 353.890 8.29
mar92 3247.41 344.340 8.35  apr92 3294.08 338.500 8.33
may92 3376.78 337.240 8.28  jun92 3337.79 340.810 8.22
jul92 3329.40 353.050 8.07  aug92 3307.45 342.960 7.95
sep92 3293.92 345.550 7.92  oct92 3198.69 344.380 7.99
nov92 3238.49 335.080 8.10  dec92 3303.15 343.740 7.98
jan93 3277.71 329.010 7.91  feb93 3367.26 329.390 7.71
mar93 3440.73 329.010 7.58  apr93 3423.62 341.910 7.46
may93 3478.17 366.720 7.43  jun93 3513.81 371.890 7.33
jul93 3529.43 392.400 7.17  aug93 3597.01 378.460 6.85
sep93 3592.28 354.850 6.66  oct93 3625.80 364.180 6.67
nov93 3674.69 373.490 6.93  dec93 3743.62 383.690 6.93
jan94 3868.36 387.020 6.92  feb94 3905.61 382.010 7.08
;

goptions cback=white colors=(black) border reset=(axis symbol);

axis1 offset=(1 cm)
      label=('Year') minor=none
      order=('01jan89'd to '01jan95'd by year);
axis2 label=(angle=90 'Gold Price')
      order=(325 to 425 by 25);

symbol1 i=join;

proc gplot data=finance;
   format date year4.;
   plot gold*date / haxis=axis1
                    vaxis=axis2
                    vminor=0;
   title2 'Gold Prices';
run;

axis2 label=(angle=90 'AAA Bond Yields')
      order=(6.5 to 10.0 by .5);

proc gplot data=finance;
   format date year4.;
   plot aaa*date / haxis=axis1
                   vaxis=axis2
                   vminor=0;
   title2 'AAA Bond Yields';
run;

/* pp. 20-21 */
data leadprd;
   input date:monyy5. leadprod @@;
   format date monyy5.;
   title 'Lead Production Data';
   title2 '(in tons)';
   datalines;
jan86 47400 feb86 41600 mar86 49400 apr86 40200
may86 40200 jun86 26500 jul86 16900 aug86 31300
sep86 27500 oct86 28600 nov86 28500 dec86 30100
jan87 38800 feb87 33600 mar87 36000 apr87 33200
may87 34200 jun87 29500 jul87 28800 aug87 30900
sep87 33400 oct87 37600 nov87 39500 dec87 36500
jan88 34300 feb88 35400 mar88 39100 apr88 34300
may88 36200 jun88 34800 jul88 31800 aug88 25300
sep88 32100 oct88 49600 nov88 40000 dec88 39300
jan89 41000 feb89 36000 mar89 39000 apr89 34000
may89 36200 jun89 35500 jul89 35700 aug89 38000
sep89 39300 oct89 34700 nov89 35300 dec89 32300
jan90 38500 feb90 37900 mar90 36900 apr90 38600
may90 36400 jun90 33300 jul90 34000 aug90 38000
sep90 37400 oct90 42300 nov90 36900 dec90 34800
jan91 33900 feb91 34000 mar91 37200 apr91 33300
may91 29800 jun91 24700 jul91 30800 aug91 31100
sep91 32400 oct91 32900 nov91 29100 dec91 31800
jan92 32100 feb92 30500 mar92 36800 apr92 30300
may92 29500 jun92 24700 jul92 27600 aug92 23800
sep92 21400
;

goptions cback=white colors=(black) border reset=(axis symbol);

axis1 offset=(1 cm)
      label=('Year') minor=none
      order=('01jan86'd to '01jan93'd by year);
axis2 label=(angle=90 'Lead Production')
      order=(15000 to 50000 by 5000);

symbol1 i=join;

proc gplot data=leadprd;
   format date year4.;
   plot leadprod*date / haxis=axis1
                        vaxis=axis2
                        vminor=1;
run;

/* pp. 22-23 */
data returns;
   input date r_m r_f r_ibm r_wyr @@;
   format date monyy.;
   informat date monyy.;
   mkt = r_m - r_f;
   ibm = r_ibm - r_f;
   wyr = r_wyr - r_f;
   label mkt='Risk Premium for Market'
         r_f='Risk-Free Rate of Return'
         ibm='Risk Premium for IBM'
         wyr='Risk Premium for Weyerhauser';
   title 'Returns Data';
   datalines;
JAN78 -0.045 0.00487 -0.029 -0.116  FEB78  0.010 0.00494 -0.043 -0.135
MAR78  0.050 0.00526 -0.063  0.084  APR78  0.063 0.00491  0.130  0.144
MAY78  0.067 0.00513 -0.018 -0.031  JUN78  0.007 0.00527 -0.004  0.005
JUL78  0.071 0.00528  0.092  0.164  AUG78  0.079 0.00607  0.049  0.039
SEP78  0.002 0.00645 -0.051 -0.021  OCT78 -0.189 0.00685 -0.046 -0.090
NOV78  0.084 0.00719  0.031 -0.033  DEC78  0.015 0.00690  0.108 -0.034
JAN79  0.058 0.00761  0.034  0.203  FEB79  0.011 0.00761 -0.017 -0.038
MAR79  0.123 0.00769  0.052  0.097  APR79  0.026 0.00764 -0.004 -0.069
MAY79  0.014 0.00772 -0.022 -0.013  JUN79  0.075 0.00715 -0.035  0.053
JUL79 -0.013 0.00728 -0.049  0.000  AUG79  0.095 0.00789  0.016  0.165
SEP79  0.039 0.00802 -0.032 -0.015  OCT79 -0.097 0.00913 -0.079 -0.083
NOV79  0.116 0.00819  0.060 -0.065  DEC79  0.086 0.00747 -0.013  0.104
JAN80  0.124 0.00883  0.066  0.069  FEB80  0.112 0.01073 -0.062  0.033
MAR80 -0.243 0.01181 -0.122 -0.129  APR80  0.080 0.00753 -0.016  0.027
MAY80  0.062 0.00630  0.025  0.089  JUN80  0.086 0.00503  0.061 -0.026
JUL80  0.065 0.00602  0.111  0.140  AUG80  0.025 0.00731  0.017 -0.041
SEP80  0.015 0.00860 -0.021 -0.064  OCT80  0.006 0.00895  0.039  0.017
NOV80  0.092 0.01137  0.035  0.015  DEC80 -0.056 0.00977 -0.004  0.007
JAN81 -0.014 0.01092 -0.052  0.028  FEB81 -0.009 0.01096  0.011  0.025
MAR81  0.067 0.01025 -0.029  0.088  APR81 -0.008 0.01084 -0.060 -0.050
MAY81  0.064 0.01255  0.017 -0.031  JUN81 -0.003 0.01128 -0.015  0.021
JUL81 -0.033 0.01154 -0.030 -0.081  AUG81 -0.031 0.01169 -0.002 -0.061
SEP81 -0.164 0.01054 -0.018 -0.113  OCT81  0.062 0.01003 -0.048 -0.020
NOV81  0.069 0.00816  0.075  0.179  DEC81 -0.039 0.00740  0.044 -0.072
JAN82 -0.079 0.00949  0.119 -0.079  FEB82 -0.101 0.00946 -0.014  0.014
MAR82 -0.028 0.01067 -0.034 -0.009  APR82  0.041 0.00972  0.075  0.059
MAY82  0.003 0.00908 -0.029 -0.086  JUN82 -0.078 0.00914 -0.014 -0.015
JUL82 -0.006 0.00714  0.082 -0.012  AUG82  0.122 0.00503  0.087  0.221
SEP82  0.008 0.00563  0.041 -0.029  OCT82  0.136 0.00620  0.089  0.150
NOV82  0.049 0.00614  0.094  0.141  DEC82  0.014 0.00648  0.113 -0.040
JAN83  0.065 0.00646  0.027  0.023  FEB83  0.028 0.00599  0.010  0.065
MAR83  0.043 0.00686  0.028 -0.023  APR83  0.097 0.00652  0.150  0.091
MAY83  0.080 0.00649 -0.041 -0.067  JUN83  0.048 0.00673  0.081 -0.013
JUL83 -0.017 0.00714  0.001 -0.071  AUG83 -0.034 0.00668  0.001 -0.011
SEP83  0.000 0.00702  0.062 -0.033  OCT83 -0.082 0.00678 -0.001 -0.046
NOV83  0.066 0.00683 -0.066  0.151  DEC83 -0.012 0.00693  0.039 -0.069
JAN84 -0.029 0.00712 -0.065 -0.039  FEB84 -0.030 0.00672 -0.026 -0.093
MAR84  0.003 0.00763  0.034  0.094  APR84 -0.003 0.00741 -0.002 -0.088
MAY84 -0.058 0.00627 -0.044 -0.087  JUN84  0.005 0.00748 -0.019  0.019
JUL84 -0.058 0.00771  0.047  0.036  AUG84  0.146 0.00852  0.127  0.055
SEP84  0.000 0.00830  0.004 -0.069  OCT84 -0.035 0.00688  0.012  0.035
NOV84 -0.019 0.00602 -0.023  0.032  DEC84 -0.001 0.00612  0.011  0.026
JAN85  0.097 0.00606  0.108  0.084  FEB85  0.012 0.00586 -0.009 -0.016
MAR85  0.008 0.00650 -0.052 -0.081  APR85 -0.010 0.00601 -0.004  0.003
MAY85  0.019 0.00512  0.025  0.031  JUN85 -0.003 0.00536 -0.038 -0.004
JUL85  0.012 0.00562  0.062  0.020  AUG85  0.005 0.00545 -0.028 -0.013
SEP85 -0.055 0.00571 -0.022 -0.074  OCT85  0.026 0.00577  0.048  0.008
NOV85  0.059 0.00540  0.085  0.171  DEC85  0.013 0.00479  0.113 -0.004
JAN86 -0.009 0.00548 -0.026  0.072  FEB86  0.049 0.00523  0.003  0.123
MAR86  0.048 0.00508  0.004  0.051  APR86 -0.009 0.00444  0.031 -0.037
MAY86  0.049 0.00469 -0.018  0.010  JUN86  0.004 0.00478 -0.039 -0.061
JUL86 -0.076 0.00458 -0.096 -0.048  AUG86  0.049 0.00343  0.055  0.122
SEP86 -0.047 0.00416 -0.031 -0.058  OCT86  0.018 0.00418 -0.081  0.135
NOV86  0.000 0.00420  0.037  0.006  DEC86 -0.005 0.00382 -0.056 -0.041
JAN87  0.148 0.00454   .      .     FEB87  0.065 0.00437   .      .
MAR87  0.037 0.00423   .      .     APR87 -0.025 0.00207   .      .
MAY87  0.004 0.00438   .      .     JUN87  0.038 0.00402   .      .
JUL87  0.055 0.00455   .      .     AUG87  0.015 0.00460   .      .
SEP87 -0.015 0.00520   .      .     OCT87 -0.260 0.00358   .      .
NOV87 -0.070 0.00288   .      .     DEC87  0.073 0.00277   .      .
;

/* pp. 24-25 */
data steel;
   input date:monyy5. steelshp @@;
   format date monyy5.;
   title 'U.S. Steel Shipments Data';
   title2 '(thousands of net tons)';
   datalines;
JAN84 5980 FEB84 6150 MAR84 7240 APR84 6472 MAY84 6948 JUN84 6686 
JUL84 5820 AUG84 6033 SEP84 5454 OCT84 6087 NOV84 5317 DEC84 4867 
JAN85 6017 FEB85 5598 MAR85 6344 APR85 6425 MAY85 6519 JUN85 6125 
JUL85 5710 AUG85 6064 SEP85 5848 OCT85 6308 NOV85 5654 DEC85 5821 
JAN86 6437 FEB86 5799 MAR86 6142 APR86 6283 MAY86 6212 JUN86 6007 
JUL86 5815 AUG86 5364 SEP86 5608 OCT86 5923 NOV86 4899 DEC86 5199 
JAN87 5664 FEB87 5527 MAR87 6234 APR87 6312 MAY87 6247 JUN87 6656 
JUL87 6295 AUG87 6364 SEP87 6726 OCT87 7077 NOV87 6606 DEC87 6977 
JAN88 6608 FEB88 6848 MAR88 7693 APR88 7082 MAY88 7187 JUN88 7422 
JUL88 6325 AUG88 7035 SEP88 6922 OCT88 6912 NOV88 6712 DEC88 6738
JAN89 7278 FEB89 6832 MAR89 7824 APR89 7164 MAY89 7446 JUN89 7331 
JUL89 6387 AUG89 7224 SEP89 6779 OCT89 7174 NOV89 6652 DEC89 6053 
JAN90 6863 FEB90 6502 MAR90 7569 APR90 7023 MAY90 7523 JUN90 7493 
JUL90 6890 AUG90 7366 SEP90 6893 OCT90 7366 NOV90 6907 DEC90 6187 
JAN91 6786 FEB91 6039 MAR91 5966 APR91 6450 MAY91 6762 JUN91 6623 
JUL91 6420 AUG91 6954 SEP91 6747 OCT91 7499 NOV91 6427 DEC91 6118
;

goptions cback=white colors=(black) border reset=(axis symbol);

axis1 offset=(1 cm)
      label=('Year') minor=none
      order=('01jan84'd to '01jan92'd by year);
axis2 label=(angle=90 'Steel Shipments')
      order=(4500 to 8500 by 1000);

symbol1 i=join;

proc gplot data=steel;
   format date year4.;
   plot steelshp*date / haxis=axis1
                        vaxis=axis2
                        vminor=1;
run;


/* -------------------------- */
/* EXAMPLE 1                  */
/* -------------------------- */

/* The following program is found on pp. 29-38 of   */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

/* p. 29 */
proc arima data=leadprd;
   i var=leadprod nlag=15;
run;

/* p. 32 */
   e p=1;
run;

/* p. 35 */
   f lead=12;
run;

/* pp. 36-37 */
proc forecast data=leadprd
              ar=1            /* number of AR parameters to estimate  */
              interval=month  /* frequency of input time series       */
              trend=1         /* fit a constant trend model           */
              method=stepar   /* use stepwise autoregressive method   */
              out=leadout1    /* create output data set for forecasts */
              lead=12         /* number of forecast periods           */
              outlimit
              outstd;
   var leadprod;
   id date;                   /* identification variable              */
run;

proc print data=leadout1;
run;

/* p. 38 */
proc autoreg data=leadprd;
   model leadprod = / nlag=1 godfrey;
run;

/* -------------------------- */
/* EXAMPLE 2                  */
/* -------------------------- */

/* The following program is found on pp. 43-50 of   */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

/* p. 43 */
proc arima data=djm;
   i var=djiam;
run;

/* pp. 44-45 */
   i var=djiam(1) center;
run;

   e q=1 noconstant;
run;

   f lead=12;
run;

/* p. 50 */
proc forecast data=djm
              interval=month
              trend=2         /* fit a linear trend model          */
              method=expo     /* use exponential smoothing method  */
              out=djmout1
              lead=12
              outstd;
   var djiam;
   id date;
run;

proc print data=djmout1;
run;

/* -------------------------- */
/* EXAMPLE 3                  */
/* -------------------------- */

/* The following program is found on pp. 55-63 of   */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

/* p. 55 */
proc arima data=steel;
   i var=steelshp;
run;

/* p. 57 */
   e p=(2)(12) q=(1 3);
run;

/* p. 59 */
   f lead=12;
run;

/* pp. 60-61 */
   f lead=12
     out=steel2
     id=date
     interval=month
     noprint;
run;

data steel3;
   set steel2;
   if date lt '01jan92'd then do;
      forecast=.;
      l95=.;
      u95=.;
   end;
run;

goptions cback=white colors=(black) border reset=(axis symbol);

axis1 offset=(1 cm)
      label=('Year') minor=none
      order=('01jan84'd to '01jan93'd by year);
axis2 label=(angle=90 'Steel Shipments')
      order=(4500 to 8500 by 1000);

symbol1 i=join l=1 h=2 pct v=star;
symbol2 i=join l=1 h=3 pct v=F;
symbol3 i=join l=20;

proc gplot data=steel3;
   format date year4.;
   plot steelshp*date=1
        forecast*date=2
        l95*date=3
        u95*date=3 / overlay
                     haxis=axis1
                     vaxis=axis2
                     vminor=1;
run;

/* p. 63 */
proc forecast data=steel
              interval=month
              method=winters   /* use Winters seasonal method  */
              seasons=month    /* specify seasonality          */
              out=steelout
              lead=12
              outstd;
   var steelshp;
   id date;
run;

proc print data=steelout;
run;

/* -------------------------- */
/* EXAMPLE 4                  */
/* -------------------------- */

/* The following program is found on pp. 69-80 of   */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

/* p. 69 */
proc x11 data=electric;
   monthly date=date;
   tables d10       /* final seasonal factors           */
          d11       /* final seasonally adjusted series */
          d12       /* final trend cycle                */
          d13;      /* final irregular series           */
   output out=adjelec b1=original
                      d10=seasonal
                      d11=adjusted
                      d12=trend
                      d13=irreg;
   var elecprod;
run;

proc print data=adjelec(obs=15);
run;

/* p. 74 */
proc x11 data=electric;
   monthly date=date printout=none charts=none;
   var elecprod;
   sspan;
run;

/* pp. 79-80 */
proc x11 data=electric
         outextrap
         noprint;
   monthly date=date;
   var elecprod;
   output out=adjelec2 b1=original
                       d10=seasonal
                       d11=adjusted
                       d12=trend
                       d13=irreg;
   arima;
run;

proc print data=adjelec2(firstobs=132);
run;

/* -------------------------- */
/* EXAMPLE 5                  */
/* -------------------------- */

/* The following program is found on pp. 86-96 of   */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

/* p. 86 */
proc arima data=constr;
   i var=hstarts nlag=15;
   i var=contrcts nlag=15;
   i var=intrate nlag=15;
run;

/* p. 88 */
   i var=contrcts(12) /* Take a span-12 difference of the CONTRCTS variable */
     noprint;         /* Suppress printing the identification phase output  */
   e p=(2,3)          /* Fit a subset AR(3) model with two parameters       */
     method=ml        /* Use the maximum likelihood method                  */
     noprint;         /* Suppress printing the estimation phase output      */

   i var=intrate(1)   /* Take first differences of the INTRATE variable     */
     noprint;
   e q=(2)            /* Fit a subset MA(2) model with one parameter        */
     method=ml
     noprint;
run;

   i var=hstarts(12) crosscor=(contrcts(12) intrate(1)) nlag=12;
run;

/* p. 92 */
   e input=(/(1) contrcts)
     method=ml
     plot;
run;

/* p. 96 */
   e p=2 input=(/(1) contrcts) method=ml;
run;

   forecast lead=12;
run;

/* -------------------------- */
/* EXAMPLE 6                  */
/* -------------------------- */

/* The following program is found on pp. 103-109 of   */
/* Forecasting Examples for Business and              */
/* Economics Using the SAS System                     */

/* pp. 103-104 */
%dftest(drivers,injuries,dlag=12)
%put &dfpvalue;

proc arima data=drivers;
   i var=injuries crosscorr=beltlaw noprint;
   e input=beltlaw plot;
run;

/* p. 106 */
   e input=beltlaw p=(1)(2 12);
run;

/* p. 108 */
   f lead=12 out=fore2
             id=date
             interval=month;
run;

/* p. 109 */
goptions cback=white colors=(black) border reset=(axis symbol);

axis1 offset=(1 cm) label=('Year')
      order=('01jan80'd to '01jan86'd by year);
axis2 label=(angle=90 'Casualties')
      order=(750 to 2250 by 500);

symbol1 i=join l=1;
symbol2 h=2 pct v=F;
symbol3 l=20 i=join;

proc gplot data=fore2;
   format date year4.;
   plot injuries*date=1
        forecast*date=2
        l95*date     =3
        u95*date     =3 / overlay
                          haxis=axis1
                          vaxis=axis2
                          vminor=4
                          href='01jan83'd
                          lh=2;
run;

/* -------------------------- */
/* EXAMPLE 7                  */
/* -------------------------- */

/* The following program is found on pp. 113-122 of   */
/* Forecasting Examples for Business and              */
/* Economics Using the SAS System                     */

/* pp. 113-114 */
%dftest(finance,djiam)
%put &dfpvalue;
%dftest(finance,gold)
%put &dfpvalue;
%dftest(finance,aaa)
%put &dfpvalue;

%dftest(finance,djiam,dif=(1))
%put &dfpvalue;
%dftest(finance,gold,dif=(1))
%put &dfpvalue;
%dftest(finance,aaa,dif=(1))
%put &dfpvalue;

proc statespace data=finance
                lead=12         /* number of forecasts to produce     */
                interval=month  /* time interval between observations */
                out=finout1(rename=(for1=djia_f1
                                    for2=gold_f1
                                    for3=aaa_f1));
   var djiam(1) gold(1) aaa(1);
   id date;
run;

proc print data=finout1(firstobs=60);
   var date djiam djia_f1 gold gold_f1 aaa aaa_f1;
   title2 'State Space Model Forecasts';
run;

/* p. 120 */
proc statespace data=finance
                lead=12
                interval=month
                out=finout2(rename=(for1=djia_f2
                                    for2=gold_f2
                                    for3=aaa_f2));
   var djiam(1) gold(1) aaa(1);
   form djiam 1 aaa 2;
   id date;
run;

/* p. 122 */
proc statespace data=finance
                lead=12
                interval=month
                out=finout3(rename=(for1=djia_f3
                                    for2=gold_f3
                                    for3=aaa_f3));
   var djiam(1) gold(1) aaa(1);
   id date;
   restrict f(1,1)=0;
run;

/* -------------------------- */
/* EXAMPLE 8                  */
/* -------------------------- */

/* The following program is found on pp. 126-131 of   */
/* Forecasting Examples for Business and              */
/* Economics Using the SAS System                     */

/* pp. 126-127 */
data steel1;
   input date:monyy. steelshp @@;
   format date monyy.;
   title 'U.S. Steel Shipments Data';
   title2 '(with missing values)';
   datalines;
JAN89 7278 FEB89 6832 MAR89 7824 APR89 7164
MAY89 7446 JUN89 7331 JUL89 6387 AUG89 7224
SEP89 .    OCT89 7174 NOV89 6652 DEC89 6053
JAN90 6863 FEB90 6502 MAR90 7569 APR90 7023
MAY90 7523 JUN90 7493 JUL90 6890 AUG90 .
SEP90 6893 OCT90 .    NOV90 6907 DEC90 6187
JAN91 6786 FEB91 6039 MAR91 .    APR91 6450
MAY91 6762 JUN91 6623 JUL91 6420 AUG91 6954
SEP91 6747 OCT91 7499 NOV91 6427 DEC91 6118
;

proc expand data=steel1
            out=steel2
            from=month;
   convert steelshp=steelcon / observed=total;
   id date;
run;

data steel2;
   set steel2;
   steelcon=round(steelcon);
run;

proc print data=steel2;
run;

/* p. 128 */
proc expand data=steel1
            out=steel3
            from=month
            to=qtr;
   convert steelshp=steelqtr / observed=total
                               method=join;
   id date;
run;

data steel3;
   set steel3;
   steelqtr=round(steelqtr);
run;

proc print data=steel3;
run;

/* pp. 129-130 */
proc expand data=steel3
            out=steel4
            from=qtr
            to=month;
   convert steelqtr=steelmon /
                              observed=(total,average);
   id date;
run;

data steel4;
   set steel4;
   steelmon=round(steelmon, .1);
run;

proc print data=steel4;
   title2 'Daily Averages';
run;

/* p. 131 */
proc expand data=steel1
            out=steel5
            from=month
            method=none;
   convert steelshp=stllag1 / transformout=(lag 1);
   convert steelshp=stllead1 / transformout=(lead 1);
   convert steelshp=stldif2 / transformout=(dif 2);
   convert steelshp=stllog / transformout=(log);
   convert steelshp=stlma3 / transformout=(movave 3);
   id date;
run;

proc print data=steel5;
   title2 'Transformed Series';
run;

/* -------------------------- */
/* EXAMPLE 9                  */
/* -------------------------- */

/* The following program is found on pp. 140-147 of   */
/* Forecasting Examples for Business and              */
/* Economics Using the SAS System                     */

/* p. 140 */
   /* nlambda=9 specifies 9        */
   /* equally spaced lambda values.*/
   /* The default is nlambda=2.    */
%boxcoxar(djm,djiam,dif=(1),nlambda=9)

/* pp. 141-142 */
%dftest(djm,djiam,outstat=dfout)

proc print data=dfout;
run;

%dftest(djm,djiam,dif=(1),outstat=dfout1)

proc print data=dfout1;
run;

/* p. 143 */
%logtest(djm,djiam,dif=(1),print=yes)

/* p. 146 */
%dfpvalue(-.27248,118)

%put Optimal Value of Lambda for Box-Cox Transformation: &boxcoxar;
%put P-value from Dickey-Fuller Test: &dfpvalue;
%put Result of Test for Log Transformation: &logtest;

/* p. 147 */
data _null_;
   file print;
   put // "Optimal Value of Lambda for Box-Cox Transformation: &boxcoxar" /
          "P-value from Dickey-Fuller Test: &dfpvalue" /
          "Result of Test for Log Transformation: &logtest";
run;


/* --------------------------*/
/* EXAMPLE 10                */
/* --------------------------*/

/* The following program is found on p. 150 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */


proc autoreg data=returns;
   model ibm = mkt    
         / normal     
           dw=12      
           dwprob     
           archtest   
           godfrey=12;
   test mkt=1;        
run;

/*  p. 154 */

proc autoreg data=returns noprint;
   model ibm = mkt;
   output out=rt_out   
          predicted=p  
          residual=r   
          lcl=l        
          ucl=u;       
run;

proc print data=rt_out;
   where date > '01sep86'd;
   var date u p ibm l r;
run;

/* pp. 155-156 */

proc sort data=rt_out out=rt_out1;
   by date;
run;

proc gplot data=rt_out1;
   plot ibm*mkt=1
        p  *mkt=2
        l  *mkt=3
        u  *mkt=3 / overlay;
   symbol1 v=star i=none h=1;   
   symbol2 v=plus i=join h=1;   
   symbol3 v=circle i=none h=1; 
   title2 "Risk Premium versus Market";
run;
quit; 

/*--------------------------*/
/* EXAMPLE 11               */
/*--------------------------*/

/* The following program is found on p. 163 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc autoreg data=returns;
   model ibm = mkt / chow=(48)   
                     pchow=(48); 
   title2;                       
run;

/* pp. 164-165 */

data returns0;
   set returns;
   if date > '01DEC81'd then d=1;
   else d=0;
   dummy=d*mkt;
run;

proc autoreg data=returns0;
   model ibm = d mkt dummy; 
   test d,dummy;            
run;

/* --------------------------*/
/* EXAMPLE 12                */
/* --------------------------*/

/* The following program is found on p. 168 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc autoreg data=returns;
   model ibm = mkt;
   intercpt: restrict intercept=0;
   output out=rstrict1 
          alphacli=.1  
          p=p          
          r=r          
          lcl=l        
          ucl=u;       
   model ibm = mkt;
   slope: restrict mkt=.75;

   model ibm = mkt;
   intcp_sl: restrict intercept + mkt=1;
run;

proc print data=rstrict1 noobs;
   where date > '01sep86'd;
   var date u p ibm l r;
   title2 'Restricted Model';
run;

/* --------------------------*/
/* EXAMPLE 13                */
/* --------------------------*/

/* The following program is found on pp. 175-176 of */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc autoreg data=returns;

      /* Fit an AR(3) Model */
   model ibm = mkt 
         / nlag=3  
           dw=1    
           dwprob; 

      /* Forecast the AR(3) Model */
   output out=rt_out2  
          alphacli=.05 
          p=p_ar3      
          r=r_ar3      
          lcl=l_ar3    
          ucl=u_ar3;   

      /* Fit an AR(1,4) Subset Model */
   model ibm = mkt    
         / nlag=(1 4);

      /* Forecast an AR(1,4) Subset Model */
   output out=rt_out3
          alphacli=.05
          p=p_ar14
          r=r_ar14
          lcl=l_ar14
          ucl=u_ar14;

      /* Fit an AR(13) Model */
   model ibm = mkt    
         / nlag=13    
           backstep;  

      /* Forecast an AR(13) Model */
   output out=rt_out4
          alphacli=.05
          p=p_ar13
          r=r_ar13
          lcl=l_ar13
          ucl=u_ar13;
run;

data rt_out5;
   merge rt_out2 rt_out3 rt_out4;
   by date;
run;

proc print data=rt_out5;
   where date > '01sep86'd;
   var date p_ar3 p_ar14 p_ar13;
   title2 'Forecasts from AR Models';
run;

/* --------------------------*/
/* EXAMPLE 14                */
/* --------------------------*/

/* The following program is found on pp. 185-186 of */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc autoreg data=returns;
   model wyr = mkt    
        / dw=12       
          dwprob      
          archtest    
          gf=12;      
   output out=wyr_out1
          p=p_ols     
          r=r_ols;    
run;

proc plot data=wyr_out1 vpct=150;
   plot r_ols * mkt;
   title2 'Weyerhauser CAPM Residuals versus Market';
run;

proc autoreg data=returns;
   model wyr=mkt      
        / itprint;    
                      
   hetero mkt         
        / link=exp    
          std=nonneg  
          test=lm;    

   output out=wyr_out2
          p=p_het     
          r=r_het     
          lcl=l       
          ucl=u;      
   title2;            
run;

proc print data=wyr_out2 noobs;
   where date > '01jul86'd;
   var date u p_het wyr l r_het;
   title2 'Heteroscedastic Model Forecasts';
run;

/* --------------------------*/
/* EXAMPLE 15                */
/* --------------------------*/

/* The following program is found on p. 197 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc autoreg data=returns;
   model wyr = mkt        
        / nlag=1          
          garch=(q=1,p=1);
   output out=wyr_out3    
          p=p_garch       
          ucl=u           
          lcl=l           
          r=r_garch       
          cpev=cpev;      
run;

data wyr_out4; 
   set wyr_out3; 
   u_garch=p_garch+2*sqrt(cpev);  
   l_garch=p_garch-2*sqrt(cpev); 
run; 

proc print data=wyr_out4 noobs;
   where date > '01jul86'd;
   var date u u_garch p_garch wyr l_garch l r_garch;
   title2 'AR(1)-GARCH Model Forecasts';
run;

/* --------------------------*/
/* EXAMPLE 16                */
/* --------------------------*/

/* The following program is found on pp. 208-210 of */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

data returns1;
   input date r_m r_f r_ibm r_wyr;
   format date monyy.;
   informat date monyy.;
   mkt = r_m - r_f;
   ibm_a = r_ibm - r_f;
   wyr_a = r_wyr - r_f;
   label mkt='Risk Premium for Market'
         r_f='Risk-Free Rate of Return'
         ibm_a='Actual Risk Premium for IBM'
         wyr_a='Actual Risk Premium for Weyerhauser';
   title 'Returns1 Data';
datalines;
JAN87  0.148 0.00454  0.073  0.270
FEB87  0.065 0.00437  0.092  0.094
MAR87  0.037 0.00423  0.076  0.089
APR87 -0.025 0.00207  0.067 -0.027
MAY87  0.004 0.00438  0.006 -0.107
JUN87  0.038 0.00402  0.016  0.026
JUL87  0.055 0.00455 -0.009  0.021
AUG87  0.015 0.00460  0.053  0.081
SEP87 -0.015 0.00520 -0.105 -0.054
OCT87 -0.260 0.00358 -0.187 -0.271
NOV87 -0.070 0.00288 -0.087 -0.066
DEC87  0.073 0.00277  0.043  0.103
;

proc autoreg data=returns noprint;

      /* Fit the OLS CAPM Regression Model */
   model wyr = mkt;
   output out=wyr_out1 p=p_ols r=r_ols;

      /* Fit the Heteroscedastic Model     */
   model wyr=mkt;
   hetero mkt / link=exp std=nonneg;
   output out=wyr_out2 p=p_het r=r_het lcl=l ucl=u;

      /* Fit the AR(1)-GARCH(1,1) Model    */
   model wyr = mkt / nlag=1 garch=(q=1,p=1);
   output out=wyr_out3 p=p_gar r=r_gar;
run;

data returns2;
   merge returns1 wyr_out1 wyr_out2 wyr_out3;
   where date > '31dec86'd;
   by date;
run;

data stats;
   set returns2;
   e_ols = wyr_a-p_ols;              /* Forecast Errors OLS Model    */
   e_het = wyr_a-p_het;              /* Forecast Errors HETERO Model */
   e_gar = wyr_a-p_gar;              /* Forecast Errors GARCH Model  */
   ae_ols = abs(e_ols);              /* Absolute Errors OLS Model    */
   ae_het = abs(e_het);              /* Absolute Errors HETERO Model */
   ae_gar = abs(e_gar);              /* Absolute Errors GARCH Model  */
   pe_ols = (e_ols*100)/wyr_a;       /* Percent Error OLS Model      */
   pe_het = (e_het*100)/wyr_a;       /* Percent Error HETERO Model   */
   pe_gar = (e_gar*100)/wyr_a;       /* Percent Error GARCH Model    */
   ape_ols = abs(e_ols/wyr_a)*100;   /* Absolute % Error OLS         */
   ape_het = abs(e_het/wyr_a)*100;   /* Absolute % Error HETERO      */
   ape_gar = abs(e_gar/wyr_a)*100;   /* Absolute % Error GARCH       */
   se_ols = e_ols**2;                /* Square Error OLS Model       */
   se_het = e_het**2;                /* Square Error HETERO Model    */
   se_gar = e_gar**2;                /* Square Error GARCH Model     */
   spe_ols = ((e_ols/wyr_a)**2)*100; /* Square % Error OLS Model     */
   spe_het = ((e_het/wyr_a)**2)*100; /* Square % Error HETERO Model  */
   spe_gar = ((e_gar/wyr_a)**2)*100; /* Square % Error GARCH Model   */
run;

proc summary data=stats mean;
   var e_ols e_het e_gar ae_ols ae_het ae_gar pe_ols pe_het
       pe_gar ape_ols ape_het ape_gar se_ols se_het se_gar
       spe_ols spe_het spe_gar;
   output out=stats1 mean=mad_ols mad_het mad_gar mae_ols
          mae_het mae_gar mpe_ols mpe_het mpe_gar
          mape_ols mape_het mape_gar mse_ols mse_het mse_gar
          mspe_ols mspe_het mspe_gar;
run;

data stats2;
   set stats1;
   rmse_ols = sqrt(mse_ols);   /* Root Mean Sq Error OLS Model      */
   rmse_het = sqrt(mse_het);   /* Root Mean Sq Error HETERO Model   */
   rmse_gar = sqrt(mse_gar);   /* Root Mean Sq Error GARCH Model    */
   rmspe_ol = sqrt(mspe_ols);  /* Root Mean % Sq Error OLS Model    */
   rmspe_ht = sqrt(mspe_het);  /* Root Mean % Sq Error HETERO Model */
   rmspe_gr = sqrt(mspe_gar);  /* Root Mean % Sq Error GARCH Model  */
   title2 'Forecast Goodness-of-Fit Statistics';
run;

proc print data=stats2;
   var mad_ols mad_het mad_gar mae_ols mae_het mae_gar
       mpe_ols mpe_het mpe_gar mape_ols mape_het mape_gar
       mse_ols mse_het mse_gar mspe_ols mspe_het mspe_gar;
run;

proc print data=stats2;
   var rmse_ols rmse_het rmse_gar rmspe_ol rmspe_ht rmspe_gr;
run;

/* --------------------------*/
/* EXAMPLE 17                */
/* --------------------------*/

/* The following program is found on p. 214 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc autoreg data=consume;
   model c = c_1 di / lagdep=c_1;
run;

/*  p. 216 */

proc autoreg data=consume
     outest=con_est; 

   model c = c_1 di  
        / lagdep=c_1 
          nlag=13    
          method=ml  
          backstep   
          dw=1;      

   output out=con_out
          p=p        
          lcl=l      
          ucl=u;     
run;

proc print data=con_out noobs;
   where date > '01jun89'd;
   var date u p c l;
   title2 'Autoregressive Model Forecasts';
run;

/*  p. 219 */

proc simlin data=consume
            est=con_est 
            type=ols    
            interim=3   
            total;      
   endogenous c;        
   exogenous di;        
   lagged c_1 c 1;      
   output out=con_out1 predicted=c_pred;
   title2;              
run;

proc print data=con_est;
run;

proc print data=con_out1 noobs;
   where date > '01jun89'd;
   var date di c c_pred c_1;
run;

/* --------------------------*/
/* EXAMPLE 18                */
/* --------------------------*/

/* The following program is found on pp. 227-228 of */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc model data=consume noprint;
   parms b0 w b1;                
      c = b0 + w*lag(c) + b1*di; 
   fit c                         
         / outest=con_est1;      
   id date di;                   

      /* Static Simulation */
   solve c                     
       / estdata=con_est1      
         static                
         out=con_out2          
         outpredict;           

      /* Static Forecasting */
   solve c                     
       / estdata=con_est1      
         static                
         forecast              
         out=con_out3          
         outpredict;           

      /* NAHEAD=3 Dynamic Simulation */
   solve c
       / estdata=con_est1
         dynamic               
         nahead=3              
         out=con_out4
         outpredict;

      /* Dynamic Forecasting */
   solve c
       / estdata=con_est1
         dynamic               
         forecast              
         out=con_out5
         outpredict;
run;

proc print data=con_out2;
   where date > '01sep89'd;
   title2 'Static Simulation';
run;

proc print data=con_out3;
   where date > '01sep89'd;
   title2 'Static Forecasting';
run;

proc print data=con_out4;
   where date > '01sep89'd;
   title2 'NAHEAD=3 Dynamic Simulation';
run;

proc print data=con_out5;
   where date > '01sep89'd;
   title2 'Dynamic Forecasting';
run;

/* --------------------------*/
/* EXAMPLE 19                */
/* --------------------------*/

/* The following program is found on p. 237 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc pdlreg data=almon;
   model y=q1 q2 q3 x(9,3,2) 
         / dw=4              
           dwprob            
           nlag=2;           
run;

/*  p. 244 */

proc pdlreg data=almon noprint;
   model y=x(8,2)      
         / nlag=2;     
   output out=pdl_out1 
          predicted=p  
          residual=r   
          lcl=l        
          ucl=u;       
run;

proc print data=pdl_out1 noobs;
   where date > '01dec65'd;
   var date u p y l r;
   title2 'PDL Model Forecasts';
run;

/*  p. 245 */

proc model data=almon;
   parms intercpt a1 a2 a3; 
   %pdl (xpdl,9,2)          

     /* Specify the Model to Estimate  */
   y = intercpt + a1*q1 + a2*q2 + a3*q3 + %pdl (xpdl,x);

   fit y;                   
   id date;                 
   solve y                  
       / forecast           
         out=pdl_out2       
         outpredict;        
   title2;                  
run;
quit;

proc print data=pdl_out2 noobs;
   where date > '01dec65'd;
run;

/* --------------------------*/
/* EXAMPLE 20                */
/* --------------------------*/

/* The following program is found on p. 255 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc pdlreg data=almon;

      /* Restrict Covariate Regressor Parameters */
   model y=q1 q2 q3 x(8,2) 
         / nlag=2;         
   restrict q1=q2=q3=0;    
   output out=pdl_out3     
          p=p              
          r=r              
          lcl=l            
          ucl=u;           

      /* Restrict PDL Endpoints */
   model y=x(8,2,2,both)   
         / nlag=2;         
   output out=pdl_out4     
          p=p              
          r=r              
          lcl=l            
          ucl=u;           
run;

proc print data=pdl_out3 noobs;
   where date > '01dec65'd;
   var date u p y l r;
   title2 'Forecasts of PDL Model';
   title3 'Slope Parameter Restrictions';
run;

proc print data=pdl_out4 noobs;
   where date > '01dec65'd;
   var date u p y l r;
   title3 'PDL Endpoint Restrictions';
run;

/* pp. 261-262 */

   /* Restrict Covariate Regressor Parameters */
proc model data=almon noprint;
   parms intercpt a1 a2 a3;  
   %pdl (xpdl,8,2)           

      /* Specify the Model to Estimate  */
   y = intercpt + a1*q1 + a2*q2 + a3*q3 + %pdl (xpdl,x);
   restrict a1,a2,a3=0;      
   fit y;                    
   id date;                  

   solve y                   
         / forecast          
           out=pdl_out5      
           outpredict;       
   title2;                   
   title3;                   
run;
quit;

   /* Restrict PDL Endpoints */
proc model data=almon noprint;
   parms int;                
   %pdl (xpdl,8,2,r=both)    
                             
   y = int + %pdl (xpdl,x);  
   fit y;                    
   id date;                  
   solve y                   
         / forecast          
           out=pdl_out6      
           outpredict;       
run;
quit;

proc print data=pdl_out5 noobs;
   where date > '01dec65'd;
   title2 'Forecasts of PDL Model';
   title3 'Slope Parameter Restrictions';
run;

proc print data=pdl_out6 noobs;
   where date > '01dec65'd;
   title3 'PDL Endpoint Restrictions';
run;

/* --------------------------*/
/* EXAMPLE 21                */
/* --------------------------*/

/* The following program is found on p. 268 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc syslin data=exch1 sur out=sur_pred;

   France:  model rate_fr = im_fr di_fr dr_fr;
            output predicted=pred_fr residual=r_fr;

   Germany: model rate_wg = im_wg di_wg dr_wg;
            output p=pred_wg r=r_wg;

   Italy:   model rate_it = im_it di_it dr_it;
            output p=pred_it r=r_it;
run;

proc print data=sur_pred;
   where year > 1989;
   var year rate_fr pred_fr r_fr rate_wg pred_wg r_wg
            rate_it pred_it r_it;
run;

/*  p. 274 */

proc syslin data=exch1      
            itsur           
            maxiter=150     
            converge=.00025 
            out=itsur_p     
            noprint;        

   France:  model rate_fr = im_fr di_fr dr_fr;
            output p=pred_fr r=r_fr;
   Germany: model rate_wg = im_wg di_wg dr_wg;
            output p=pred_wg r=r_wg;
   Italy:   model rate_it = im_it di_it dr_it;
            output p=pred_it r=r_it;
run;

proc print data=itsur_p;
   where year > 1989;
   var year rate_fr pred_fr r_fr rate_wg pred_wg r_wg
            rate_it pred_it r_it;
   title2 'Estimated by the ITSUR Method';
run;

/* --------------------------*/
/* EXAMPLE 22                */
/* --------------------------*/

/* The following program is found on pp. 278-279 of */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc syslin data=exch1 sur;

   France:  model rate_fr = im_fr di_fr dr_fr;
   France:  test di_fr = dr_fr;

   Germany: model rate_wg = im_wg di_wg dr_wg;
   Germany: test di_wg = dr_wg;

   Italy:   model rate_it = im_it di_it dr_it;
run;

proc syslin data=exch1 sur;
   France:  model rate_fr = im_fr di_fr dr_fr;
   Germany: model rate_wg = im_wg di_wg dr_wg;
   stest France.di_fr = Germany.di_wg;

   Italy:   model rate_it = im_it di_it dr_it;
run;

proc syslin data=exch1 sur;

   France:  model rate_fr = im_fr di_fr dr_fr;
            restrict di_fr = dr_fr;

   Germany: model rate_wg = im_wg di_wg dr_wg;
            restrict di_wg = dr_wg;

   Italy:   model rate_it = im_it di_it dr_it;
run;

proc syslin data=exch1 sur;

   France:  model rate_fr = im_fr di_fr dr_fr;
   Germany: model rate_wg = im_wg di_wg dr_wg;
   srestrict France.di_fr = Germany.di_wg;

   Italy:   model rate_it = im_it di_it dr_it;
   srestrict France.dr_fr = Germany.dr_wg = Italy.dr_it;
run;

/* --------------------------*/
/* EXAMPLE 23                */
/* --------------------------*/

/* The following program is found on pp. 287-288 of */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc syslin data=exch1 
            sur              
            outest=est_xch1  
            noprint;         

   France:  model rate_fr = im_fr di_fr dr_fr;
   Germany: model rate_wg = im_wg di_wg dr_wg;
   Italy:   model rate_it = im_it di_it dr_it;
run;

proc print data=est_xch1;
run;

proc simlin data=exch1 est=est_xch1 type=sur;
   endogenous rate_fr rate_wg rate_it;
   exogenous im_fr di_fr dr_fr im_wg di_wg dr_wg
             im_it di_it dr_it;
   output out=exchout1 predicted = fore_fr1 fore_wg1 fore_it1
                       residual = r_fr1 r_wg1 r_it1;
run;

proc print data=exchout1;
   where year > 1989;
   var year fore_fr1 r_fr1 fore_wg1 r_wg1 fore_it1 r_it1;
   title2 'Estimated by the SUR Method';
run;

/* --------------------------*/
/* EXAMPLE 24                */
/* --------------------------*/

/* The following program is found on p. 294 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc syslin data=exch1 3sls first out=p_3sls;
   endogenous im_fr im_wg im_it;
   instruments year di_fr dr_fr di_wg dr_wg di_it dr_it
               prod_us prod_fr prod_wg prod_it;
   France:  model rate_fr = im_fr di_fr dr_fr;
            output p=p_fr r=r_fr; 
   Germany: model rate_wg = im_wg di_wg dr_wg;
            output p=p_wg r=r_wg; 
   Italy:   model rate_it = im_it di_it dr_it;
            output p=p_it r=r_it; 
run;

proc print data=p_3sls;
   where year > 1989;
   var year rate_fr p_fr r_fr rate_wg p_wg r_wg
            rate_it p_it r_it;
   title2 'Predicted Values from 3SLS Model'; 
run;

/*  p. 303 */

proc syslin data=exch1 it3sls maxiter=300 out=p_it3sls noprint;
   endogenous im_fr im_wg im_it;
   instruments year di_fr dr_fr di_wg dr_wg di_it dr_it
               prod_us prod_fr prod_wg prod_it;
   France:  model rate_fr = im_fr di_fr dr_fr;
            output p=p_fr r=r_fr; 
   Germany: model rate_wg = im_wg di_wg dr_wg;
            output p=p_wg r=r_wg; 
   Italy:   model rate_it = im_it di_it dr_it;
            output p=p_it r=r_it; 
run;

proc print data=p_it3sls;
   where year > 1989;
   var year rate_fr p_fr r_fr rate_wg p_wg r_wg
            rate_it p_it r_it;
   title2 'Predicted Values from IT3SLS Model'; 
run;

/*  p. 305 */

proc syslin data=exch1 3sls;
   endogenous im_fr im_wg im_it;
   instruments year di_fr dr_fr di_wg dr_wg di_it dr_it
               prod_us prod_fr prod_wg prod_it;
   France:  model rate_fr = im_fr di_fr dr_fr / dw;
   Germany: model rate_wg = im_wg di_wg dr_wg / dw;
   Italy:   model rate_it = im_it di_it dr_it / dw;
run;

/*  p. 307 */

proc syslin data=exch1 fiml maxiter=100 out=p_fiml;
   instruments year di_fr dr_fr di_wg dr_wg di_it dr_it
               prod_us prod_fr prod_wg prod_it
               cpi_us cpi_fr cpi_wg cpi_it;
   France:  model rate_fr = im_fr di_fr dr_fr;
            output p=p_fr r=r_fr; 
   Germany: model rate_wg = im_wg di_wg dr_wg;
            output p=p_wg r=r_wg; 
   Italy:   model rate_it = im_it di_it dr_it;
            output p=p_it r=r_it; 
run;

proc print data=p_fiml;
   where year > 1989;
   var year rate_fr p_fr r_fr rate_wg p_wg r_wg
            rate_it p_it r_it;
   title2 'Predicted Values from FIML Model'; 
run;

/* --------------------------*/
/* EXAMPLE 25                */
/* --------------------------*/

/* The following program is found on p. 312 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc model data=exch1 graph;
   parameters a1-a3 b1-b3 c1-c3 d1-d3;
   France:  rate_fr = a1+b1*im_fr+c1*di_fr+d1*dr_fr;
   Germany: rate_wg = a2+b2*im_wg+c2*di_wg+d2*dr_wg;
   Italy:   rate_it = a3+b3*im_it+c3*di_it+d3*dr_it;
   fit rate_fr rate_wg rate_it 
       / sur     
         dw      
         gf=2    
         white   
         breusch=(im_fr di_fr dr_fr)  
         normal; 
run;

/*  p. 319 */

proc model data=exch1 graph outmodel=xchmodel;
   parameters a1-a3 b1-b3 c1-c3 d1-d3;
   France:  rate_fr = a1+b1*im_fr+c1*di_fr+d1*dr_fr;
   Germany: rate_wg = a2+b2*im_wg+c2*di_wg+d2*dr_wg;
   Italy:   rate_it = a3+b3*im_it+c3*di_it+d3*dr_it;
   %ar(ar_fr,2,rate_fr)
   %ar(ar_wg,2,rate_wg)
   %ar(ar_it,2,rate_it)
   fit rate_fr rate_wg rate_it
       start=(ar_fr_l1 -.5 .5 ar_fr_l2 -.5 .5
              ar_wg_l1 -.5 .5 ar_wg_l2 -.5 .5
              ar_it_l1 -.5 .5 ar_it_l2 -.5 .5)
       / sur maxiter=150 converge=1E-7
         outest=est_xch outcov outs=s1 dw;
run;

/* p. 322 */

proc model model=xchmodel noprint;
   solve rate_fr rate_wg rate_it / data=exch1
         estdata=est_xch forecast out=out1exch;
   id year;
   range year=1992 to 1993;
run;

proc print data=out1exch;
   where year > 1991;
   var year _mode_ rate_fr rate_wg rate_it;
run;

/* p. 326 */

proc model data=exch1;
   parameters a1-a3 b1-b3 c1-c3 d1-d3;
   France:  rate_fr = a1+b1*im_fr+c1*di_fr+d1*dr_fr;
   Germany: rate_wg = a2+b2*im_wg+c2*di_wg+d2*dr_wg;
   Italy:   rate_it = a3+b3*im_it+c3*di_it+d3*dr_it;
   %ar(ar_fr,2,rate_fr)
   %ar(ar_wg,2,rate_wg)
   %ar(ar_it,2,rate_it)
   fit rate_fr rate_wg rate_it
       start=(ar_fr_l1 -.5 .5 ar_fr_l2 -.5 .5
              ar_wg_l1 -.5 .5 ar_wg_l2 -.5 .5
              ar_it_l1 -.5 .5 ar_it_l2 -.5 .5)
       / sur maxiter=150 converge=1E-7
         outest=est_xch outcov outs=s1 dw;
   solve rate_fr rate_wg rate_it / data=exch1
         estdata=est_xch forecast out=out2exch;
   id year;
   range year=1992 to 1993;
run;

proc print data=out2exch;
   where year > 1989;
   var year rate_fr rate_wg rate_it;
run;

/* --------------------------*/
/* EXAMPLE 26                */
/* --------------------------*/

/* The following program is found on pp. 330-331 of */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc model data=exch1 outmodel=xchmodel noprint;

      /* Specifies the Model Parameters */ 
   parameters a1-a3 b1-b3 c1-c3 d1-d3;  

      /* Specifies the Model Equations */ 
   France:  rate_fr = a1+b1*im_fr+c1*di_fr+d1*dr_fr;
   Germany: rate_wg = a2+b2*im_wg+c2*di_wg+d2*dr_wg;
   Italy:   rate_it = a3+b3*im_it+c3*di_it+d3*dr_it;

      /* Specifies AR(2) Error Terms */ 
   %ar(ar_fr,2,rate_fr)
   %ar(ar_wg,2,rate_wg)
   %ar(ar_it,2,rate_it)

      /* Fits the Model Equations */ 
   fit rate_fr rate_wg rate_it

      /* Specifies Grid of Starting Values for AR Parameters */ 
       start=(ar_fr_l1 -.5 .5 ar_fr_l2 -.5 .5
              ar_wg_l1 -.5 .5 ar_wg_l2 -.5 .5
              ar_it_l1 -.5 .5 ar_it_l2 -.5 .5)

       / sur            
         maxiter=150    
         converge=1E-7  
         outest=est_xch 
         outcov         
         outs=s1;       
run;

proc model model=xchmodel; 
   solve rate_fr rate_wg rate_it 
       / data=exch1
         estdata=est_xch   
         sdata=s1          
         random=100        
         seed=123          
         forecast           
         out=out3exch;     
   id year;
   range year=1992 to 1993;
run;

proc sort data=out3exch;
   by year;
run;

proc univariate data=out3exch noprint;
   by year;
   var rate_fr rate_wg rate_it;
   output out=out4exch mean=mean_fr mean_wg mean_it
                       p5=p5fr p5wg p5it
                       p95=p95fr p95wg p95it;
run;

proc print data=out4exch;
   var year p5fr mean_fr p95fr
            p5wg mean_wg p95wg
            p5it mean_it p95it;
run;

/* pp. 334-335 */

proc model data=exch1;
   parameters a1-a3 b1-b3 c1-c3 d1-d3;
   France:  rate_fr = a1+b1*im_fr+c1*di_fr+d1*dr_fr;
   Germany: rate_wg = a2+b2*im_wg+c2*di_wg+d2*dr_wg;
   Italy:   rate_it = a3+b3*im_it+c3*di_it+d3*dr_it;
   %ar(ar_fr,2,rate_fr)
   %ar(ar_wg,2,rate_wg)
   %ar(ar_it,2,rate_it)
   fit rate_fr rate_wg rate_it
       start=(ar_fr_l1 -.5 .5 ar_fr_l2 -.5 .5
              ar_wg_l1 -.5 .5 ar_wg_l2 -.5 .5
              ar_it_l1 -.5 .5 ar_it_l2 -.5 .5)
       / sur maxiter=150 converge=1E-7
         outest=est_xch outcov outs=s1 dw;
   solve rate_fr rate_wg rate_it / data=exch1
         estdata=est_xch sdata=s1 random=100 seed=123
         forecast out=out5exch;
   id year;
   range year=1992 to 1993;
   title 'Exchange Rate Model';
run;

proc sort data=out5exch;
   by year;
run;

proc print data=out5exch;
   where _REP_ = 0;
   var year rate_fr rate_wg rate_it;
run;

proc univariate data=out5exch noprint;
   by year;
   var rate_fr rate_wg rate_it;
   output out=out6exch mean=mean_fr mean_wg mean_it
                       p5=p5fr p5wg p5it
                       p95=p95fr p95wg p95it;
run;

proc print data=out6exch;
   var year p5fr mean_fr p95fr
            p5wg mean_wg p95wg
            p5it mean_it p95it;
run;

/* --------------------------*/
/* EXAMPLE 27                */
/* --------------------------*/

/* The following program is found on p. 338 of      */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc g3grid data=ces out=ces_grid;
   grid k*l=q / spline smooth=.025
                axis1=1 to 9 by .5
                axis2=10 to 100 by 10;
run;

goptions cback=white colors=(black) border;

proc g3d data=ces_grid;
   plot k*l=q 
      / rotate=75   
        tilt=80     
        zmin=10     
        zmax=160    
        yticknum=3  
        xticknum=5; 
   title 'Production Function Surface plot';
run;
quit;

/* p. 340 */

proc model data=ces outmodel=cesmodel;
   parms g r v d;
       q = g*(((d*k)**r) + ((1-d)*l)**r)**(v/r);
   fit q start = (g=15 d=.6 r=-.3 v=.5) / converge =.00005
         outest=est_ces outcov outs=s2 outactual out=ces_out;
   predq=pred.q;
   residq=actual.q-pred.q;
   outvars residq predq id;
   title 'CES Production Function';
run;

proc print data=ces_out;
   var q predq k l residq;
run;

/* pp. 343-344 */

data ces_new;
input id k l q @@;
label k ='Capital Input'
      l ='Labor Input'
      q ='Output';
datalines;
26 5 30    .    27 6 35   .     28 7 40    .    29 6 45    .
;

proc model data=ces_new model=cesmodel noprint;
   solve q / out=fore forecast;
run;

proc print data=fore;
   var _mode_ q k l;
run;

proc g3grid data=fore out=fore1;
   grid k*l=predq / spline smooth=.025
                    axis1=1 to 9 by .5
                    axis2=10 to 100 by 10;
run;

goptions cback=white colors=(black) border;

proc gcontour data=fore1;
   plot k*l=predq / legend=legend1;
   title 'CES Production Function Isoquants';
   legend1 label=(j=l 'Predicted' j=l 'Quantity');
run;

/* pp. 345-346 */

proc model data=ces_new model=cesmodel noprint;
   solve q / estdata=est_ces sdata=s2 random=100
             seed=246 jacobi out=montcrlo forecast;
run;

proc sort data=montcrlo;
   by id;
run;

proc univariate data=montcrlo noprint;
   by id;
   var q;
   output out=bounds mean=mean p5=p5 p95=p95;
run;

proc print data=bounds;
   var id p95 mean p5;
run;

proc plot data=bounds vpct=150;
   plot mean * id = 'M'
        p5 * id = 'L'
        p95 * id = 'U' / overlay;
   title "Monte Carlo Generated Confidence Intervals on a Forecast";
run;

/* p. 348 */

proc model data=ces;
   parms g r v d;
       q = g*(((d*k)**r) + ((1-d)*l)**r)**(v/r);
   fit q start = (g=15 d=.6 r=-.3 v=.5) / converge =.00005
         outest=est outcov outs=s3 outactual;
   solve q / data=ces_new estdata=est_ces sdata=s2 random=100
             seed=246 jacobi out=montcrlo forecast;
   id id;
   range id=25;
   title 'CES Production Function';
run;


/* --------------------------*/
/* EXAMPLE 28                */
/* --------------------------*/

/* The following program is found on pp. 350-351 of */
/* Forecasting Examples for Business and            */
/* Economics Using the SAS System                   */

proc model data=ces;
   parms g r v d;
   estimate 'Elas_Sub' 1/(1+r); 
   test     'Unity'    1/(1+r)=1; 
   test     'Dis_parm' v=1, / all; 
       q = g*(((d*k)**r) + ((1-d)*l)**r)**(v/r);
   fit q start = (g=15 d=.6 r=-.3 v=.5) / converge =.00005
         outactual out=ces_out1;
   predq=pred.q;
   residq=actual.q-pred.q;
   outvars residq predq id;
   title2 'Unrestricted Model'; 
run;

proc print data=ces_out1;
   var q predq k l residq;
run;

proc model data=ces;
   parms g r v d;
   bounds g > 0,  
          0 < d < 1; 
   restrict 'Dis_parm' v=1; 
   test     'Unity'    1/(1+r)=1; 
       q = g*(((d*k)**r) + ((1-d)*l)**r)**(v/r);
   fit q start = (g=.5 d=.6 r=-.5) / converge =.000001
         outactual out=ces_out2;
   predq=pred.q;
   residq=actual.q-pred.q;
   outvars residq predq id;
   title2 'Restricted Model'; 
run;

proc print data=ces_out2;
   var q predq k l residq;
run;








