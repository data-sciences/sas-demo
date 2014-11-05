
/*-------------------------------------------------------------------*/
/*          Statistical Analysis of Medical Data Using SAS           */
/*                by Geoff Der and Brian Everitt                     */
/*       Copyright(c) 2005 by Chapman & Hall/CRC                     */
/*                        ISBN 1-58488-469-X                         */
/*                         www.crcpress.com                          */
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
/* SAS Press                                                         */
/* Attn: Geoff Der and Brian S. Everitt                              */
/* SAS Campus Drive                                                  */
/* Cary, NC   27513                                                  */
/*                                                                   */
/*                                                                   */
/* If you prefer, you can send email to:  saspress@sas.com           */
/* Use this for subject field:                                       */
/*     Comments for Geoff Der and Brian S. Everitt                   */
/*                                                                   */
/*-------------------------------------------------------------------*/
/* Date Last Updated:                                                */
/*-------------------------------------------------------------------*/
/* 
******************** NOTES and WARNINGS ************************
There are some slight differences between the SAS programs below and 
those given in the book. Most of these are consequences of including 
all the programs and data in a single file to simplify downloading. 

DATA FILES
The examples in the book that show the raw data being read from an 
external file have been altered so that the data are instream, ie 
within the program. The original infile statement used will have been
commented out and tabs in the data may have been changed to spaces.

FORMATTING DIFFERENCES
Figures 2.12 to 2.15 in the book should show cross-hatched patterns.
Some spaces have been omitted from the instream data on pages 155, 
163, 216 and 286.

MACROS
The macros mentioned in the book are listed at the end of the file.
They can be selected and submitted from there, or copied to external
files and %include(or %inc) statements used as in the book.

SYSTEM SETTINGS
The graphics and system options used for the book were set as follows:
goptions reset=all;
goptions device=win target=winprtm rotate=landscape ftext=swiss;
options nodate nonumber center;
title;
ods ptitle=on;
The paper size was set as A4.

A simple macro to set these options (setopts) is included below and 
duplicated at the end of the file with the other macros. At the 
beginning of each chapter the macro is called with a %setopts; 
statement so that the output will resemble that given in the book 
as closely as possible. Users who do not want to set these options 
can replace the %setopts; statement with *%setopts; which will change 
it to a comment.

*/

%macro setopts;
goptions reset=all;
goptions device=win target=winprtm rotate=landscape ftext=swiss;
options nodate nonumber center;
title;
ods ptitle=on;
%mend;

/* chapter 1 */

%setopts;
data bodyfat;
 input age pctfat sex $;
cards;
23  9.5 M
23 27.9 F
27  7.8 M
27 17.8 M
39 31.4 F
41 25.9 F
45 27.4 M
49 25.2 F
50 31.1 F
53 34.7 F
53 42.0 F
54 29.1 F
56 32.5 F
57 30.3 F
58 33.0 F
58 33.8 F
60 41.1 F
61 34.5 F
; 
proc print data=bodyfat;
run;
proc corr data=bodyfat;
run;
 
data SlimmingClub;
input idno team $ startweight weightnow;
cards;
1023 red    189 165
1049 yellow 145 124
1219 red    210 192
1246 yellow 194 177
1078 red    127 118
1221 yellow 220   .
1095 blue   135 127
1157 green  155 141
1331 blue   187 172
1067 green  135 122
1251 blue   181 166
1333 green  141 129
1192 yellow 152 139
1352 green  156 137
1262 blue   196 180
1087 red    148 135
1124 green  156 142
1197 red    138 125
1133 blue   180 167
1036 green  135 123
1057 yellow 146 132
1328 red    155 142
1243 blue   134 122
1177 red    141 130
1259 green  189 172
1017 blue   138 127
1099 yellow 148 132
1329 yellow 188 174
run;


data SlimmingClub;
 input name $ 1-18 team $ 20-25 startweight 27-29 weightnow 31-33;
cards;
David Shaw         red    189 165
Amelia Serrano     yellow 145 124
Alan Nance         red    210 192
Ravi Sinha         yellow 194 177
Ashley McKnight    red    127 118
Jim Brown          yellow 220    
Susan Stewart      blue   135 127
Rose Collins       green  155 141
Jason Schock       blue   187 172
Kanoko Nagasaka    green  135 122
Richard Rose       blue   181 166
Li-Hwa Lee         green  141 129
Charlene Armstrong yellow 152 139
Bette Long         green  156 137
Yao Chen           blue   196 180
Kim Blackburn      red    148 135
Adrienne Fink      green  156 142
Lynne Overby       red    138 125
John VanMeter      blue   180 167
Becky Redding      green  135 123
Margie Vanhoy      yellow 146 132
Hisashi Ito        red    155 142
Deanna Hicks       blue   134 122
Holly Choate       red    141 130
Raoul Sanchez      green  189 172
Jennifer Brooks    blue   138 127
Asha Garg          yellow 148 132
Larry Goss         yellow 188 174
;

data SlimmingClub;
 input name $19. team $7. startweight 4. weightnow 3.;
cards;
David Shaw         red    189 165
Amelia Serrano     yellow 145 124
Alan Nance         red    210 192
Ravi Sinha         yellow 194 177
Ashley McKnight    red    127 118
Jim Brown          yellow 220    
Susan Stewart      blue   135 127
Rose Collins       green  155 141
Jason Schock       blue   187 172
Kanoko Nagasaka    green  135 122
Richard Rose       blue   181 166
Li-Hwa Lee         green  141 129
Charlene Armstrong yellow 152 139
Bette Long         green  156 137
Yao Chen           blue   196 180
Kim Blackburn      red    148 135
Adrienne Fink      green  156 142
Lynne Overby       red    138 125
John VanMeter      blue   180 167
Becky Redding      green  135 123
Margie Vanhoy      yellow 146 132
Hisashi Ito        red    155 142
Deanna Hicks       blue   134 122
Holly Choate       red    141 130
Raoul Sanchez      green  189 172
Jennifer Brooks    blue   138 127
Asha Garg          yellow 148 132
Larry Goss         yellow 188 174
;

* SAS dates example;
data days;
input day ddmmyy8.;
cards;
020160
01/02/60
31 12 59
231019
231020
;
run;
proc print data=days;
run;
proc print data=days;
 format day ddmmyy10.;
run;

* comma separators;
data commas;
  input bignum comma6.;
cards;
 1,860
;
proc print;
run;

* implied and actual decimal places ;
data decimals;
 input realnum 5.2;
cards;
1234 
 4567
123.4
  6789
;
proc print;
run;

* substitute appropriate names for filename and sasdataset below;
Proc import datafile='filename' out=sasdataset  dbms=tab replace;
   getnames=yes;
run;

libname db 'c:\sasbook\sasdata';
data db.SlimmingClub;
 set SlimmingClub;
run;

libname db 'c:\sasbook\sasdata';
data SlimmingClub2;
  set db.slimmingclub;
run;

data women;
  set bodyfat;
  if sex='F';
run;

proc gplot data=bodyfat;
  plot pctfat*age;
run;

goptions reset=symbol;
symbol1 v=square;
symbol2 v=triangle;
proc gplot  data=bodyfat;
  plot pctfat*age=sex;
run;

ods rtf;
proc print data=bodyfat;
proc corr data=bodyfat;
run;
ods rtf close;

proc template;
  list styles;
run;

/* Example and data taken from chapter 9 */

data diabetes;
input id age base peptide;
logpeptide=log10(peptide);
cards;
1         5.2   -8.1    4.8
2         8.8   -16.1   4.1
3        10.5   -0.9    5.2
4        10.6   -7.8    5.5
5        10.4   -29.0   5.0
6         1.8   -19.2   3.4
7        12.7   -18.9   3.4
8        15.6   -10.6   4.9
9         5.8    -2.8   5.6
10        1.9   -25.0   3.7
11        2.2   -3.1    3.9
12        4.8   -7.8    4.5
13        7.9   -13.9   4.8
14        5.2   -4.5    4.9
15        0.9   -11.6   3.0
16       11.8   -2.1    4.6
17        7.9   -2.0    4.8
18       11.5   -9.0    5.5
19       10.6   -11.2   4.5
20        8.5   -0.2    5.3
21       11.1   -6.1    4.7
22       12.8   -1.0    6.6
23       11.3   -3.6    5.1
24        1.0   -8.2    3.9
25       14.5   -0.5    5.7
26       11.9   -2.0    5.1
27        8.1   -1.6    5.2
28       13.8   -11.9   3.7
29       15.5   -0.7    4.9
30        9.8   -1.2    4.8
31       11.0   -14.3   4.4
32       12.4   -0.8    5.2
33       11.1   -16.8   5.1
34        5.1   -5.1    4.6
35        4.8   -9.5    3.9
36        4.2   -17.0   5.1
37        6.9   -3.3    5.1
38       13.2   -0.7    6.0
39        9.9   -3.3    4.9
40       12.5   -13.6   4.1
41       13.2   -1.9    4.6
42        8.9   -10.0   4.9
43       10.8   -13.5   5.1
run;

ods html;
ods graphics on;
proc gam data=diabetes plots(clm commonaxes);
  model logpeptide=loess(age) loess(base) / method=gcv;
run;
ods graphics off;
ods html close;

ods html gpath='c:\sasbook\graphs';
ods graphics on / imagefmt=jpeg;
proc gam data=diabetes plots(clm commonaxes);
  model logpeptide=loess(age) loess(base) / method=gcv;
run;
ods graphics off;
ods html close;

%macro plotxy(data=,x=,y=);
proc gplot data=&data;
  plot &y*&x;
run;
%mend plotxy;

options mprint;
%plotxy(data=bodyfat,x=age,y=pctfat);

%macro plotxy(data,x,y);
proc gplot data=&data;
  plot &y*&x;
run;
%mend plotxy;

%plotxy(bodyfat,age,pctfat);



/* Chapter 2 */
%setopts;

data heights;
* infile 'c:\sasbook\data\elderly.dat' expandtabs ;
 input height @@;
cards;
156     163     169     161     154     156     163     164     156     166     177     158
150     164     159     157     166     163     153     161     170     159     170     157
156     156     153     178     161     164     158     158     162     160     150     162
155     161     158     163     158     162     163     152     173     159     154     155
164     163     164     157     152     154     173     154     162     163     163     165
160     162     155     160     151     163     160     165     166     178     153     160
156     151     165     169     157     152     164     166     160     165     163     158
153     162     163     162     164     155     155     161     162     156     169     159
159     159     158     160     165     152     157     149     169     154     146     156
157     163     166     165     155     151     157     156     160     170     158     165
167     162     153     156     163     157     147     163     161     161     153     155
166     159     157     152     159     166     160     157     153     159     156     152
151     171     162     158     152     157     162     168     155     155     155     161
157     158     153     155     161     160     160     170     163     153     159     169
155     161     156     153     156     158     164     160     157     158     157     156
160     161     167     162     158     163     147     153     155     159     156     161
158     164     163     155     155     158     165     176     158     155     150     154
164     145     153     169     160     159     159     163     148     171     158     158
157     158     168     161     165     167     158     158     161     160     163     163
169     163     164     150     154     165     158     161     156     171     163     170
154     158     162     164     158     165     158     156     162     160     164     165
157     167     142     166     163     163     151     163     153     157     159     152
169     154     155     167     164     170     174     155     157     170     159     170
155     168     152     165     158     162     173     154     167     158     159     152
158     167     164     170     164     166     170     160     148     168     151     153
150     165     165     147     162     165     158     145     150     164     161     157
163     166     162     163     160     162     153     168     163     160     165     156
158     155     168     160     153     163     161     145     161     166     154     147
161     155     158     161     163     157     156     152     156     165     159     170
160     152     153                                                                     
;

run;

proc univariate data=heights;
  var height;
  histogram height / normal; 
  probplot height /normal;
run;

data nerves;
* infile 'c:\sasbook\data\nerve.dat' expandtabs ;
 input pulsetime @@;
cards;
0.21    0.03    0.05    0.11    0.59    0.06
0.18    0.55    0.37    0.09    0.14    0.19
0.02    0.14    0.09    0.05    0.15    0.23
0.15    0.08    0.24    0.16    0.06    0.11
0.15    0.09    0.03    0.21    0.02    0.14
0.24    0.29    0.16    0.07    0.07    0.04
0.02    0.15    0.12    0.26    0.15    0.33
0.06    0.51    0.11    0.28    0.36    0.14
0.55    0.28    0.04    0.01    0.94    0.73
0.05    0.07    0.11    0.38    0.21    0.49
0.38    0.38    0.01    0.06    0.13    0.06
0.01    0.16    0.05    0.10    0.16    0.06
0.06    0.06    0.06    0.11    0.44    0.05
0.09    0.04    0.27    0.50    0.25    0.25
0.08    0.01    0.70    0.04    0.08    0.16
0.38    0.08    0.32    0.39    0.58    0.56
0.74    0.15    0.07    0.26    0.25    0.01
0.17    0.64    0.61    0.15    0.26    0.03
0.05    0.34    0.07    0.10    0.09    0.02
0.30    0.07    0.12    0.01    0.16    0.14
0.49    0.07    0.11    0.35    1.21    0.17
0.01    0.35    0.45    0.07    0.93    0.04
0.96    0.14    1.38    0.15    0.01    0.05
0.23    0.31    0.05    0.05    0.29    0.01
0.74    0.30    0.09    0.02    0.19    0.47
0.01    0.51    0.12    0.12    0.43    0.32
0.09    0.20    0.03    0.05    0.13    0.15
0.05    0.08    0.04    0.09    0.10    0.10
0.26    0.07    0.68    0.15    0.01    0.27
0.05    0.03    0.40    0.04    0.21    0.29
0.24    0.08    0.23    0.10    0.19    0.20
0.26    0.06    0.40    0.51    0.15    1.10
0.16    0.78    0.04    0.27    0.35    0.71
0.15    0.29    0.04    0.01    0.28    0.21
0.09    0.17    0.09    0.17    0.15    0.62
0.50    0.07    0.39    0.28    0.20    0.34
0.16    0.65    0.04    0.67    0.10    0.51
0.26    0.07    0.71    0.11    0.47    0.02
0.38    0.04    0.43    0.11    0.23    0.14
0.08    1.12    0.50    0.25    0.18    0.12
0.02    0.15    0.12    0.08    0.38    0.22
0.16    0.04    0.58    0.05    0.07    0.28
0.27    0.24    0.07    0.02    0.27    0.27
0.16    0.05    0.34    0.10    0.02    0.04
0.10    0.22    0.24    0.04    0.28    0.10
0.23    0.03    0.34    0.21    0.41    0.15
0.05    0.17    0.53    0.30    0.15    0.19
0.07    0.83    0.04    0.04    0.14    0.34
0.10    0.15    0.05    0.04    0.05    0.65
0.16    0.32    0.87    0.07    0.17    0.10
0.03    0.17    0.38    0.28    0.14    0.07
0.14    0.03    0.21    0.40    0.04    0.11
0.44    0.90    0.10    0.49    0.09    0.01
0.08    0.06    0.08    0.01    0.15    0.50
0.36    0.08    0.34    0.02    0.21    0.32
0.22    0.51    0.12    0.16    0.52    0.21
0.05    0.46    0.44    0.04    0.05    0.04
0.14    0.08    0.21    0.02    0.63    0.35
0.01    0.38    0.43    0.03    0.39    0.04
0.17    0.23    0.78    0.14    0.08    0.11
0.07    0.45    0.46    0.20    0.19    0.50
0.09    0.22    0.29    0.01    0.19    0.06
0.39    0.08    0.03    0.28    0.09    0.17
0.45    0.40    0.07    0.30    0.16    0.24
0.81    1.35    0.01    0.02    0.03    0.06
0.12    0.31    0.64    0.08    0.15    0.06
0.06    0.15    0.68    0.30    0.02    0.04
0.02    0.81    0.09    0.19    0.14    0.12
0.36    0.02    0.11    0.04    0.08    0.17
0.04    0.05    0.14    0.07    0.39    0.13
0.56    0.12    0.31    0.05    0.10    0.13
0.05    0.01    0.09    0.03    0.27    0.17
0.03    0.05    0.26    0.23    0.20    0.76
0.05    0.02    0.01    0.20    0.21    0.02
0.04    0.16    0.32    0.43    0.20    0.13
0.10    0.20    0.08    0.81    0.11    0.09
0.26    0.15    0.36    0.18    0.10    0.34
0.56    0.09    0.15    0.14    0.15    0.22
0.33    0.04    0.07    0.09    0.18    0.08
0.07    0.07    0.68    0.27    0.21    0.11
0.07    0.44    0.13    0.04    0.39    0.14
0.10    0.08    0.02    0.57    0.35    0.17
0.21    0.14    0.77    0.06    0.34    0.15
0.29    0.08    0.72    0.31    0.20    0.10
0.01    0.24    0.07    0.22    0.49    0.03
0.18    0.47    0.37    0.17    0.42    0.02
0.22    0.12    0.01    0.34    0.41    0.27
0.07    0.30    0.09    0.27    0.28    0.15
0.26    0.01    0.06    0.35    0.03    0.26
0.05    0.18    0.46    0.12    0.23    0.32
0.08    0.26    0.82    0.10    0.69    0.15
0.01    0.39    0.04    0.13    0.34    0.13
0.13    0.30    0.29    0.23    0.01    0.38
0.04    0.08    0.15    0.10    0.62    0.83
0.11    0.71    0.08    0.61    0.18    0.05
0.20    0.12    0.10    0.03    0.11    0.20
0.16    0.10    0.03    0.23    0.12    0.01
0.12    0.17    0.14    0.10    0.02    0.13
0.06    0.21    0.50    0.04    0.42    0.29
0.08    0.01    0.30    0.45    0.06    0.25
0.02    0.06    0.02    0.17    0.10    0.28
0.21    0.28    0.30    0.02    0.02    0.28
0.09    0.71    0.06    0.12    0.29    0.05
0.27    0.25    0.10    0.16    0.08    0.52
0.44    0.19    0.72    0.12    0.30    0.14
0.45    0.42    0.09    0.07    0.62    0.51
0.50    0.47    0.28    0.04    0.66    0.08
0.11    0.03    0.32    0.16    0.11    0.26
0.05    0.07    0.04    0.22    0.08    0.08
0.01    0.06    0.05    0.05    0.16    0.05
0.13    0.42    0.21    0.36    0.05    0.01
0.44    0.14    0.14    0.14    0.08    0.51
0.18    0.02    0.51    0.06    0.22    0.01
0.09    0.22    0.59    0.03    0.71    0.14
0.02    0.51    0.03    0.41    0.17    0.37
0.39    0.82    0.81    0.24    0.52    0.40
0.24    0.06    0.73    0.27    0.18    0.01
0.17    0.02    0.11    0.26    0.13    0.68
0.13    0.08    0.71    0.04    0.11    0.13
0.17    0.34    0.23    0.08    0.26    0.03
0.21    0.45    0.40    0.03    0.16    0.06
0.29    0.43    0.03    0.10    0.10    0.31
0.27    0.27    0.33    0.14    0.09    0.27
0.14    0.09    0.08    0.06    0.16    0.02
0.07    0.19    0.11    0.10    0.17    0.24
0.01    0.13    0.21    0.03    0.39    0.01
0.27    0.19    0.02    0.21    0.04    0.10
0.06    0.48    0.12    0.15    0.12    0.52
0.48    0.29    0.57    0.22    0.01    0.44
0.05    0.49    0.10    0.19    0.44    0.02
0.72    0.09    0.04    0.02    0.02    0.06
0.22    0.53    0.18    0.10    0.10    0.03
0.08    0.15    0.05    0.13    0.02    0.10
0.51                                    
;
run;

proc univariate data=nerves;
  var pulsetime;
  histogram pulsetime / normal; 
  probplot pulsetime /normal;
run;

proc univariate data=nerves noprint;
  var pulsetime;
  histogram pulsetime / exponential; 
run;

proc univariate data=heights;
  var height;
  histogram height / kernel; 
  histogram height / kernel(k=n c=1 2 3 l=1 2 3) nobars ;
  histogram height / kernel(k=t c=1 2 3 l=1 2 3) nobars;
  histogram height / kernel(k=q c=1 2 3 l=1 2 3) nobars;
run;

data patient;
  do organ= 1 to 5;
   input days 6. @;
   if days~=. then output;
  end;
cards;
124   81    248   1234  1235
42    461   377   89    24
25    20    189   201   1581
45    450   1843  356   1166
412   246   180   2970  40
51    166   537   456   727
1112  63    519         3808
46    64    455         791
103   155   406         1804
876   859   365         3460
146   151   942         719
340   166   776         
396   37    372         
      223   163         
      138   101         
      72    20          
      245   283         
;

proc format;
  value organ 1='Stomach' 2='Bronchus' 3='Colon' 4='Ovary' 5='Breast';
run;

proc sort data=patient;
  by organ; 
run;

proc boxplot data=patient;
  plot days*organ / boxstyle=schematic;
  format organ organ.;
run;

data patient;
  set patient;
  logdays=log(days);
run;

proc boxplot data=patient;
  plot logdays*organ / boxstyle=schematic;
  format organ organ.;
run;

data toxaemia;
* infile 'c:\sasbook\data\toxaemia.dat' expandtabs ;
 input class  smoking group1-group4;
cards;
1       1       28      82      21      286
1       2       5       24      5       71
1       3       1       3       0       13
2       1       50      266     34      785
2       2       13      92      17      284
2       3       0       15      3       34
3       1       278     1101    164     3160
3       2       120     492     142     2300
3       3       16      92      32      383
4       1       63      213     52      656
4       2       35      129     46      649
4       3       7       40      12      163
5       1       20      78      23      245
5       2       22      74      34      321
5       3       7       14      4       65
;
run;

proc gchart data=toxaemia;
 vbar class /subgroup=smoking freq=group1 discrete;
run;

proc gchart data=toxaemia;
 vbar class /subgroup=smoking freq=group2 discrete;
run;

proc gchart data=toxaemia;
 vbar class /subgroup=smoking freq=group3 discrete;
run;

proc gchart data=toxaemia;
 vbar class /subgroup=smoking freq=group4 discrete;
run;

data cancer;
 infile cards;
 input  smr occupation  :$15.;
cards;
 84   Farmers
116   Miners
123   chemical  
128   Glass 
155   Furnace
101   Electrical
118   Engineering
113   Woodworkers 
104   Leather
 88   Textile
104   Clothing
129   Food
 86   Paper
 96   other  
144   Construction 
139   decorators 
113   crane drivers
146   Labourers
128   Transport
115   Warehousemen
 79   Clerical
 85   Sales
120   Service
 60   Administrators
 51   Professional 
;
run;

pattern1 v=s;
proc gchart data=cancer;
  hbar occupation  /discrete descending type=sum sumvar=smr;
run;

%include 'C:\sasbook\macros\dotplot.sas';
%dotplot(data=cancer,xvar=smr,label=occupation);


/* Chapter 3 */
%setopts;

data diabetes;
 input v1 v2;
 excrete=v1; group='N'; output;
 excrete=v2; group='D'; output;
 drop v1 v2;
cards;
 4.1 11.5
 6.3 12.1
 7.8 16.1
 8.5 17.8
 8.9 24.0
10.4 28.8
11.5 33.9
12.0 40.7
13.8 51.3
17.6 56.2
24.3 61.7
37.2 69.2
;

proc sort data=diabetes; 
  by group;
run;
proc boxplot data=diabetes;
  plot excrete*group /boxstyle=schematic;
run;

proc ttest data=diabetes;
  var excrete;
  class group;
run;

proc npar1way data=diabetes wilcoxon;
  var excrete;
  class group;
run;

data glaucoma;
 input affected unaffected;
 difference=affected-unaffected;
cards;
488 484
478 478
480 492
426 444
440 436
410 398
458 464
460 476
;

proc ttest data=glaucoma;
  paired affected*unaffected;
run;

proc univariate data=glaucoma;
  var difference;
run;

data MIdeaths;
  input group$ outcome$ n;
cards;
Sulp Dead 41
Sulp Alive 692
Placebo Dead 60
Placebo Alive 682
;

proc freq data=MIdeaths order=data;
  tables group*outcome / chisq;
  weight n;
run; 

data Hodgkins;
 input type$ v1-v3;
 response='Positive'; n=v1; output;
 response='Partial';  n=v2; output;
 response='None';     n=v3; output;
 drop v1-v3;
cards;
LP  74  18  12
NS  68  16  12
MC 154  54  58
LD  18  10  44
;

proc freq data=Hodgkins order=data;
  tables type*response /chisq;
  weight n;
run;

proc freq data=Hodgkins order=data;
  tables type*response /expected deviation cellchi2   
                        norow nocol nopercent 
                        out=tabout outexpect;
  weight n;
run;
data resids;
  set tabout;
  residual=(count-expected)/sqrt(expected);
run;
proc tabulate data=resids order=data;
  class type response;
  var residual;
  table   type,
          response*residual*mean='';
run;

data delinquency;
  input specs$ delinquent$ n;
cards;
Y Y 1
Y N 5
N Y 8
N N 2
;

proc freq data=delinquency;
  tables specs*delinquent / chisq;
  weight n;
run;

data lesions;
  length region $8.;
  input site $ 1-16 n1 n2 n3;
  region='Keral';   n=n1;  output;
  region='Gujarat'; n=n2;  output;
  region='Anhara';  n=n3;  output;
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

data pill_use;
  input caseused $ controlused $ n;
cards;
Y Y 10
Y N 57
N Y 13
N N 95
;
run;

proc freq data=pill_use order=data;
 tables caseused*controlused / agree;
 weight n;
run;


/* Chapter 4 */
%setopts;

data drinking;
 input country $ 1-12 alcohol cirrhosis;
cards;
France        24.7  46.1
Italy         15.2  23.6
W.Germany     12.3  23.7
Austria       10.9   7.0
Belgium       10.8  12.3
USA            9.9  14.2
Canada         8.3   7.4
E&W            7.2   3.0
Sweden         6.6   7.2
Japan          5.8  10.6
Netherlands    5.7   3.7
Ireland        5.6   3.4
Norway         4.2   4.3
Finland        3.9   3.6
Israel         3.1   5.4
;
run;

proc corr; run;

symbol1 pointlabel=('#country');
proc gplot data=drinking;
  plot cirrhosis*alcohol ;
run;

data drinking2;
 set drinking;
 if country~='France';
run;

proc corr; run;

proc corr data=drinking spearman nosimple;
proc corr data=drinking2 spearman nosimple;
run;

proc iml;
  use drinking;
  read all var {alcohol cirrhosis} into xy;
  ptr = cvexhull(xy);                
  create hullptr var {ind} ;
  append from ptr;
quit;
data hull inner;
  set hullptr;
  hull=ind>0;
  pointer=abs(ind);
  set drinking point=pointer;
  if hull then output hull;
     else output inner;
run;
data anno;
  retain xsys ysys '2';
  set hull;
  y=cirrhosis;
  x=alcohol;
  function='polycont';
  if _n_=1 then function='poly'; 
run;

symbol1 v=circle i=none pointlabel=none;
proc gplot data=drinking;
 plot cirrhosis*alcohol / annotate=anno;
run;

data USbirth;
  retain obs 0;
  do year=1940 to 1947;
   do month=1 to 12;
   input rate @@;
   obs=obs+1;
   datestr=('15'||put(month,z2.)||put(year,4.));
   obsdate=input(datestr,ddmmyy8.);
   output;
   end;
  end;
cards;
1890   1957   1925   1885   1896   1934   2036   2069   2060
1922   1854   1852   1952   2011   2015   1971   1883   2070
2221   2173   2105   1962   1951   1975   2092   2148   2114
2013   1986   2088   2218   2312   2462   2455   2357   2309
2398   2400   2331   2222   2156   2256   2352   2371   2356
2211   2108   2069   2123   2147   2050   1977   1993   2134
2275   2262   2194   2109   2114   2086   2089   2097   2036
1957   1953   2039   2116   2134   2142   2023   1972   1942
1931   1980   1977   1972   2017   2161   2468   2691   2890
2913   2940   2870   2911   2832   2774   2568   2574   2641
2691   2698   2701   2596   2503   2424
;

proc gplot data=usbirth;
 plot rate*obsdate;
 format obsdate year.;
run;    

axis1 length=10in;
axis2 length=3in;
proc gplot data=usbirth;
 plot rate*obsdate / haxis=axis1 vaxis=axis2;
 format obsdate year.;
run;
        
proc gplot data=usbirth;
 plot rate*obsdate / haxis=axis1 vaxis=axis2;
 format obsdate monyy7.;
 where year<1943;
run;    

symbol1 i=join v=none;
proc gplot data=usbirth;
 plot rate*obsdate / haxis=axis1 vaxis=axis2;
 format obsdate monyy7.;
 where year<1943;
run;    

axis3 length=2in;
symbol1 i=join v=none;
proc gplot data=usbirth;
 plot rate*obsdate / haxis=axis1 vaxis=axis3;
 format obsdate yyq7.;
run;    

data fertility;
  input country$ birth death;
cards;
alg   36.4   14.6
con   37.3   8.0
egy   42.1   15.3
gha   55.8   25.6
ict   56.1   33.1
mag   41.8   15.8
mor   46.1   18.7
tun   41.7   10.1
cam   41.4   19.7
cey   35.8   8.5
chi   34.0   11.0
tai   36.3   6.1
hkg   32.1   5.5
ind   20.9   8.8
ids   27.7   10.2
irq   20.5   3.9
isr   25.0   6.2
jap   17.3   7.0
jor   46.3   6.4
kor   14.8   5.7
mal   33.5   6.4
mog   39.2   11.2
phl   28.4   7.1
syr   26.2   4.3
tha   34.8   7.9
vit   23.4   5.1
can   24.8   7.8
cra   49.9   8.5
dmr   33.0   8.4
gut   47.7   17.3
hon   46.6   9.7
mex   46.1   10.5
nic   42.9   7.1
pan   40.1   8.0
usa   21.7   9.6
arg   21.8   8.1
bol   17.4   5.8
bra   45.0   13.5
chl   33.6   11.8
clo   44.0   11.7
ecu   44.2   13.5
per   27.7   8.2
urg   22.5   7.8
ven   42.8   6.7
aus   18.8   12.8
bel    17.1   12.7
brt    18.2   12.2
bul   16.4   8.2
cze   16.9   9.5
dem   17.6   19.8
fin   18.1   9.2
fra   18.2   11.7
gmy   18.0   12.5
gre   17.4   7.8
hun   13.1   9.9
irl   22.3   11.9
ity   19.0   10.2
net   20.9   8.0
now   17.5   10.0
pol   19.0   7.5
pog   23.5   10.8
rom   15.7   8.3
spa   21.5   9.1
swe   14.8   10.1
swz   18.9   9.6
rus   21.2   7.2
yug   21.4   8.9
ast   21.6   8.7
nzl   25.5   8.8
;

data anno;
  set fertility;
  retain xsys ysys '2' function 'SYMBOL' text 'CIRCLE';
  y=death;
  x=birth;
run;

proc kde data=fertility out=kdeout;
  var birth death;
run;
proc gcontour data=kdeout;
  plot death*birth=density / nlevels=25 nolegend annotate=anno;
run;

proc kde data=fertility out=kdeout2 bwm=.5,.5;
  var birth death;
run;
proc gcontour data=kdeout2;
  plot death*birth=density / nlevels=25 nolegend  annotate=anno;
run;

proc g3d data=kdeout;
 plot death*birth=density /rotate=30 tilt=45;
run;
proc g3d data=kdeout2;
 plot death*birth=density /rotate=30 tilt=45;
run;

data blood;
  input patid viscosity PCV fibrinogen protein;
cards;
 1   3.71   40   344   6.27
 2   3.78   40   330   4.86
 3   3.85   42.5   280   5.09
 4   3.88   42   418   6.79
 5   3.98   45   744   6.40
 6   4.03   42   388   5.48
 7   4.05   42.5   336   6.27
 8   4.14   47   431   6.89
 9   4.14   46.75   276   5.18
10   4.20   48   422   5.73
11   4.20   46   280   5.89
12   4.27   47   460   6.58
13   4.27   43.25   412   5.67
14   4.37   45   320   6.23
15   4.41   50   502   4.99
16   4.64   45   550   6.37
17   4.68   51.25   414   6.40
18   4.73   50.25   304   6.00
19   4.87   49   472   5.94
20   4.94   50   728   5.16
21   4.95   50   716   6.29
22   4.96   49   400   5.96
23   5.02   50.5   576   5.90
24   5.02   51.25   354   5.81
25   5.12   49.5   392   5.49
26   5.15   56   352   5.41
27   5.17   50   572   6.24
28   5.18   47   634   6.50
29   5.38   53.25   458   6.60
30   5.77   57   1070   4.82
31   5.90   54   488   5.70
32   5.90   54   488   5.70
;

goptions reset=symbol;
%inc 'c:\sasbook\macros\plotmat.sas';
%inc 'c:\sasbook\macros\template.sas';

%plotmat(blood,viscosity--protein);

proc corr data=blood;
 var fibrinogen protein;
 with viscosity;
 partial pcv;
run;

goptions reset=symbol;
proc reg data=drinking2;
  model cirrhosis=alcohol ;
  output out=regout p=pr uclm=upper lclm=lower;
  plot cirrhosis*alcohol / conf;
run;

symbol1 v=circle i=none;
symbol2 v=none i=join;
symbol3 v=none i=join l=3 r=2;
proc gplot data=regout;
  plot (cirrhosis pr upper lower)*alcohol / overlay;
run;

proc loess data=drinking2;
  model cirrhosis=alcohol /  smooth=.5; * select=gcv is 2 piece linear;
ods output Outputstatistics=lofit;
run;

data both;
  set regout;
  set lofit;
run;

proc gplot data=both;
  plot (cirrhosis pr pred)*alcohol / overlay;
run;

/* Chapter 5 */
%setopts;

data sickle;
  do type=1 to 3;
  input hglevel 5. @;
  if hglevel~=. then output;
  end;
datalines;
  7.2  8.1 10.7
  7.7  9.2 11.3
  8.0 10.0 11.5
  8.1 10.4 11.6
  8.3 10.6 11.7
  8.4 10.9 11.8
  8.4 11.1 12.0
  8.5 11.9 12.1
  8.6 12.0 12.3
  8.7 12.1 12.6
  9.1      12.6
  9.1      13.3
  9.1      13.3
  9.8      13.8
 10.1      13.9
 10.3      
;                        

proc sort data=sickle;
  by type;
run;

proc boxplot data=sickle;
  plot hglevel*type / boxstyle=schematic;
run;

proc glm data=sickle;
  class type;
  model hglevel=type;
run;
  contrast '3 vs 1 & 2' type -1 -1 2;
  contrast '1 vs 2'     type  1 -1 0;
run;
  means type / scheffe;
run;

data hyper;                            
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
 
proc means data=hyper noprint;
  class cell;
  var bp;
  output out=cellmeans mean= std= var= /autoname;
run;
proc gplot data=cellmeans gout=meangraphs;
  plot (bp_stddev bp_var)*bp_mean;
run;
proc greplay igout=meangraphs nofs;
 tc sashelp.templt;
 template H2;
 treplay 1:1 2:2;
run;

proc sort data=hyper; by drug; run;
proc boxplot data=hyper gout=boxplots;
  plot bp*drug / boxstyle=schematic;
run;
proc sort data=hyper; by diet; run;
proc boxplot data=hyper gout=boxplots;
  plot bp*diet / boxstyle=schematic;
run;
proc sort data=hyper; by biofeed; run;
proc boxplot data=hyper gout=boxplots;
  plot bp*biofeed / boxstyle=schematic;
run;

%inc 'c:\sasbook\macros\template.sas';
proc greplay igout=boxplots nofs;
%template(nrows=1,ncols=3);
treplay 1:1 2:2 3:3;
run;

proc anova data=hyper;
  class diet biofeed drug;
  model bp=diet|drug|biofeed;
run;
  means diet*drug*biofeed;
ods output means=cellmeans2;
run;
ods output close;

proc sort data=cellmeans2; by drug; run;

symbol1 i=join v=none l=1;
symbol2 i=join v=none l=2;
proc gplot data=cellmeans2 gout=cellmeans2;
  plot mean_bp*biofeed=diet;
  by drug;
run;
goptions rotate=portrait;
proc greplay igout=cellmeans2 nofs;
%template(nrows=3,ncols=1);
treplay 1:1 2:2 3:3;
run;


data antipyrine;
input sex$ stage hours;
cards;
M 1 7.4
M 1 5.6
M 1 6.6
M 1 6.0
M 2 3.7
M 2 10.9
M 2 12.2
M 3 11.3
M 3 13.3
M 3 10.0
F 1 9.1
F 1 11.3
F 1 6.3
F 1 9.4
F 2 7.1
F 2 7.9
F 2 11.0
F 3 8.3
F 3 4.3
;

proc glm data=antipyrine;
  class sex stage;
  model hours=sex|stage / ss1 ss2 ss3;
run;
  means sex*stage;
  ods output means=antmns;
run;
  ods output close;

proc gplot data=antmns;
  plot mean_hours*stage=sex;
  symbol1 i=join l=1;
  symbol2 i=join l=2;
run;

data leukaemia;
input group$ ngrs;
cards;
N 3500
N 3500
N 3500
N 4000
N 4000
N 4000
N 4300
N 4500
N 4500
N 4900
N 5200
N 6000
N 6750
N 8000
H 5710
H 6110
H 8060
H 8080
H 11400
C 2390
C 3330
C 3580
C 3880
C 4280
C 5120
M 6320
M 6860
M 11400
M 14000
A 3230
A 3880
A 7640
A 7890
A 8280
A 16200
A 18250
A 29900
;

proc npar1way data=leukaemia wilcoxon;
  class group;
  var ngrs;
run;

data pip;
 input pip1 pip2;
 group='C';
 if _n_>13 then group='O';
cards;
4.3     2.5
3.7     3.2
4.0     3.1
3.6     3.9
4.1     3.4
3.8     3.6
3.8     3.4
4.4     3.8
5.0     3.6
3.7     2.3
3.7     2.2
4.4     4.3
4.7     4.2
4.3     2.5
5.0     4.1
4.6     4.2
4.3     3.1
3.1     1.9
4.8     3.1
3.7     3.6
5.4     3.7
3.0     2.6
4.9     4.1
4.8     3.7
4.4     3.4
4.9     4.1
5.1     4.2
4.8     4.0
4.2     3.1
6.6     3.8
3.6     2.4
4.5     2.3
4.6     3.6
;

symbol1 i=rl v=dot;
symbol2 i=rl v=circle L=2;
proc gplot data=pip;
  plot pip2*pip1=group;
run;

proc glm data=pip;
  class group;
  model pip2=pip1 group pip1*group;
run;


/* Chapter 6 */
%setopts;

data anasthetic;
  input duration trauma dlt;
cards;
4.0     3       36.7
6.0     3       51.3
1.5     2       40.8
4.0     2       58.3
2.5     2       42.2
3.0     2       34.6
3.0     2       77.8
2.5     2       17.2
3.0     3       -38.4
3.0     3       1.0
2.0     3       53.7
8.0     3       14.3
5.0     4       65.0
2.0     2       5.6
2.5     2       4.4
2.0     2       1.6
1.5     2       6.2
1.0     1       12.2
3.0     3       29.9
4.0     3       74.1
3.0     3       11.5
3.0     3       19.8
7.0     4       64.9
6.0     4       47.8
2.0     2       35.0
4.0     2       1.7
2.0     2       51.5
1.0     1       20.2
1.0     1       -9.3
2.0     1       13.9
1.0     1       -19.0
3.0     1       -2.3
4.0     3       41.6
8.0     4       18.4
2.0     2       9.9
;

proc reg data=anasthetic;
  model dlt=duration trauma;
run;

data water;
  input location$ mortality calcium;
  if location='N' then region=1; 
     else region=0;
cards;
S 1247  105
N 1668  17 
S 1466  5  
N 1800  14 
N 1609  18 
N 1558  10 
N 1807  15 
S 1299  78 
N 1637  10 
S 1359  84 
S 1392  73 
S 1755  12 
N 1519  21 
S 1307  78 
S 1254  96 
N 1491  20 
N 1555  39 
N 1428  39 
S 1318  122
S 1260  21 
N 1723  44 
N 1379  94 
N 1742  8  
N 1574  9  
N 1569  91 
S 1096  138
N 1591  16 
S 1402  37 
N 1772  15 
S 1828  8  
S 1704  26 
S 1702  44 
N 1581  14 
N 1309  59 
S 1259  133
S 1427  27 
S 1724  6  
N 1175  107
S 1486  5  
N 1456  90 
N 1696  6  
N 1236  101
N 1711  13 
N 1444  14 
S 1591  49 
S 1987  8  
N 1495  14 
N 1369  68 
N 1257  50 
N 1587  75 
N 1713  71 
S 1557  13 
N 1640  57 
S 1709  71 
S 1625  13 
S 1625  20 
N 1527  60 
N 1627  53 
N 1486  122
S 1485  81 
N 1378  71 
;       

proc reg data=water;
  model mortality= calcium region;
run;
  plot p.*calcium=region;
run; 

data water;
  set water;
  reg_calc=region*calcium;
run;

proc reg data=water;
  model mortality= calcium region reg_calc;
  plot p.*calcium=region;
run; 

data young_man;
  input Mass Forearm Bicep Chest Neck Waist Height;
cards;
77      28.5    33.5    100     38.5    178     37.5    
85.5    29.5    36.5    107     39      187     40      
63      25      31      94      36.5    175     33      
80.5    28.5    34      104     39      183     38      
79.5    28.5    36.5    107     39      174     40      
94      30.5    38      112     39      180     39.5    
66      26.5    29      93      35      177.5   38.5    
69      27      31      95      37      182.5   36      
65      26.5    29      93      35      178.5   34      
58      26.5    31      96      35      168.5   35      
69.5    28.5    37      109.5   39      170     38      
73      27.5    33      102     38.5    180     36      
74      29.5    36      101     38.5    186.5   38      
68      25      30      98.5    37      188     37      
80      29.5    36      103     40      173     37      
66      26.5    32.5    89      35      171     38      
54.5    24      30      92.5    35.5    169     32      
64      25.5    28.5    87.5    35      181     35.5    
84      30      34.5    99      40.5    188     39      
73      28      34.5    97      37      173     38      
89      29      35.5    106     39      179     39.5    
94      31      33.5    106     39      184     42      
;

%inc 'c:\sasbook\macros\plotmat.sas';
%inc 'c:\sasbook\macros\template.sas';

%plotmat(young_man,mass--height);

proc reg data=young_man;
  model mass=forearm--height /vif;
run;

proc reg data=young_man;
  model mass=forearm--height / selection=cp ;
run;
  plot cp.*np. / cmallows=black;
run; 

proc reg data=young_man;
forward:  model mass=forearm--height / selection=f ;
backward:  model mass=forearm--height / selection=b ;
stepwise:  model mass=forearm--height / selection=stepwise ;
run;

proc reg data=young_man gout=regplots;
  model mass=forearm chest waist height;
  plot r.*(forearm chest waist height) / nomodel nostat;
  plot r.*p.;
  plot npp.*r.;
  plot cookd.*obs.;
run;

proc greplay igout=regplots nofs;
%template(nrows=2,ncols=2);
treplay 1:1 2:2 3:3 4:4;
run;

/* Chapter 7 */
%setopts;

data ghq;
  input ghq sex $ cases noncases;
  total=cases+noncases;
  prcase=cases/total;
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
  plot prcase*ghq=sex;
  symbol1 v=dot i=join;
  symbol2 v=circle i=join l=2;
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
  model cases/total=sex ghq sex*ghq / selection=b details; 
run;

data lobwgt;
  input id low age lwt race ftv;
cards;
85      0       19      182     2       0
86      0       33      155     3       3
87      0       20      105     1       1
88      0       21      108     1       2
89      0       18      107     1       0
91      0       21      124     3       0
92      0       22      118     1       1
93      0       17      103     3       1
94      0       29      123     1       1
95      0       26      113     1       0
96      0       19      95      3       0
97      0       19      150     3       1
98      0       22      95      3       0
99      0       30      107     3       2
100     0       18      100     1       0
101     0       18      100     1       0
102     0       15      98      2       0
103     0       25      118     1       3
104     0       20      120     3       0
105     0       28      120     1       1
106     0       32      121     3       2
107     0       31      100     1       3
108     0       36      202     1       1
109     0       28      120     3       0
111     0       25      120     3       2
112     0       28      167     1       0
113     0       17      122     1       0
114     0       29      150     1       2
115     0       26      168     2       0
116     0       17      113     2       1
117     0       17      113     2       1
115     0       24      90      1       1
119     0       35      121     2       1
120     0       25      155     1       1
121     0       25      125     2       0
123     0       29      140     1       2
124     0       19      138     1       2
125     0       27      124     1       0
126     0       31      215     1       2
127     0       33      109     1       1
128     0       21      185     2       2
129     0       19      189     1       2
130     0       23      130     2       1
131     0       21      160     1       0
132     0       18      90      1       0
133     0       18      90      1       0
134     0       32      132     1       4
135     0       19      132     3       0
136     0       24      115     1       2
137     0       22      85      3       0
138     0       22      120     1       1
139     0       23      128     3       0
140     0       22      130     1       0
141     0       30      95      1       2
142     0       19      115     3       0
143     0       16      110     3       0
144     0       21      110     3       0
145     0       30      153     3       0
146     0       20      103     3       0
147     0       17      119     3       0
148     0       17      119     3       0
149     0       23      119     3       2
150     0       24      110     3       0
151     0       28      140     1       0
154     0       26      133     3       0
155     0       20      169     3       1
156     0       24      115     3       2
159     0       28      250     3       6
160     0       20      141     1       1
161     0       22      158     2       2
162     0       22      112     1       0
163     0       31      150     3       2
164     0       23      115     3       1
166     0       16      112     2       0
167     0       16      135     1       0
168     0       18      229     2       0
169     0       25      140     1       1
170     0       32      134     1       4
172     0       20      121     2       0
173     0       23      190     1       0
174     0       22      131     1       1
175     0       32      170     1       0
176     0       30      110     3       0
177     0       20      127     3       0
179     0       23      123     3       0
180     0       17      120     3       0
181     0       19      105     3       0
182     0       23      130     1       0
183     0       36      175     1       0
184     0       22      125     1       1
185     0       24      133     1       0
186     0       21      134     3       2
187     0       19      235     1       0
188     0       25      95      1       0
189     0       16      135     1       0
190     0       29      135     1       1
191     0       29      154     1       1
192     0       19      147     1       0
193     0       19      147     1       0
195     0       30      137     1       1
196     0       24      110     1       1
197     0       19      184     1       0
199     0       24      110     3       0
200     0       23      110     1       1
201     0       20      120     3       0
202     0       25      241     2       0
203     0       30      112     1       1
204     0       22      169     1       0
205     0       18      120     1       2
206     0       16      170     2       4
207     0       32      186     1       2
208     0       18      120     3       1
209     0       29      130     1       2
210     0       33      117     1       1
211     0       20      170     1       0
212     0       28      134     3       1
213     0       14      135     1       0
214     0       28      130     3       0
215     0       25      120     1       2
216     0       16      95      3       1
217     0       20      158     1       1
218     0       26      160     3       0
219     0       21      115     1       1
220     0       22      129     1       0
221     0       25      130     1       2
222     0       31      120     1       2
223     0       35      170     1       1
224     0       19      120     1       0
225     0       24      116     1       1
226     0       45      123     1       1
4       1       28      120     3       0
10      1       29      130     1       2
11      1       34      187     2       0
13      1       25      105     3       0
15      1       25      85      3       0
16      1       27      150     3       0
17      1       23      97      3       1
18      1       24      128     2       1
19      1       24      132     3       0
20      1       21      165     1       1
22      1       32      105     1       0
23      1       19      91      1       0
24      1       25      115     3       0
25      1       16      130     3       1
26      1       25      92      1       0
27      1       20      150     1       2
28      1       21      200     2       2
29      1       24      155     1       0
30      1       21      103     3       0
31      1       20      125     3       0
32      1       25      89      3       1
33      1       19      102     1       2
34      1       19      112     1       0
35      1       26      117     1       0
36      1       24      138     1       0
37      1       17      130     3       0
40      1       20      120     2       3
42      1       22      130     1       1
43      1       27      130     2       0
44      1       20      80      3       0
45      1       17      110     1       0
46      1       25      105     3       1
47      1       20      109     3       0
49      1       18      148     3       0
50      1       18      110     2       0
51      1       20      121     1       0
52      1       21      100     3       4
54      1       26      96      3       0
56      1       31      102     1       1
57      1       15      110     1       0
59      1       23      187     2       1
60      1       20      122     2       0
61      1       24      105     2       0
62      1       15      115     3       0
63      1       23      120     3       0
65      1       30      142     1       0
67      1       22      130     1       1
68      1       17      120     1       3
69      1       23      110     1       0
71      1       17      120     2       2
75      1       26      154     3       1
76      1       20      105     3       3
77      1       26      190     1       0
78      1       14      101     3       0
79      1       28      95      1       2
81      1       14      100     3       2
82      1       23      94      3       0
83      1       17      142     2       0
84      1       21      130     1       3
;

proc logistic data=lobwgt desc;
  class race / param=ref ref=first;
  model low=age lwt race ftv;
run;

proc logistic data=lobwgt desc;
  class race / param=ref ref=first;
  model low=age lwt race ftv / selection=b;
run;

proc logistic data=lobwgt desc;
  class race / param=ref ref=first;
  model low=race lwt;
run;

proc logistic data=lobwgt desc;
  class race / param=ref ref=first;
  model low=race lwt / clodds=wald;
  units lwt=10;
run;

proc logistic data=lobwgt desc;
  class race / param=ref ref=first;
  model low=race age lwt ftv ;
  output out=lout p=pred resdev=dres ;
run;

goptions reset=symbol;
axis1 label=(a=90);
proc gplot data=lout;
  plot dres*(id pred age lwt ftv) /vaxis=axis1;
run;

data endoca1;
  input est num;
  resp=1;
cards;
-1 7
 1 43
 0 133
;

proc logistic data=endoca1;
  model resp=est /noint  ;
  freq num;
run;

/* Chapter 8 */
%setopts;

data young_man;
  input Mass Forearm Bicep Chest Neck Waist Height;
cards;
77      28.5    33.5    100     38.5    178     37.5    
85.5    29.5    36.5    107     39      187     40      
63      25      31      94      36.5    175     33      
80.5    28.5    34      104     39      183     38      
79.5    28.5    36.5    107     39      174     40      
94      30.5    38      112     39      180     39.5    
66      26.5    29      93      35      177.5   38.5    
69      27      31      95      37      182.5   36      
65      26.5    29      93      35      178.5   34      
58      26.5    31      96      35      168.5   35      
69.5    28.5    37      109.5   39      170     38      
73      27.5    33      102     38.5    180     36      
74      29.5    36      101     38.5    186.5   38      
68      25      30      98.5    37      188     37      
80      29.5    36      103     40      173     37      
66      26.5    32.5    89      35      171     38      
54.5    24      30      92.5    35.5    169     32      
64      25.5    28.5    87.5    35      181     35.5    
84      30      34.5    99      40.5    188     39      
73      28      34.5    97      37      173     38      
89      29      35.5    106     39      179     39.5    
94      31      33.5    106     39      184     42      
;

proc genmod data=young_man;
  model mass=forearm chest waist height / dist=normal link=id;
run;

data lobwgt;
*  infile 'c:\sasbook\data\lbw.dat' expandtabs;
  input id low age lwt race ftv;
cards;
        85      0       19      182     2       0
        86      0       33      155     3       3
        87      0       20      105     1       1
        88      0       21      108     1       2
        89      0       18      107     1       0
        91      0       21      124     3       0
        92      0       22      118     1       1
        93      0       17      103     3       1
        94      0       29      123     1       1
        95      0       26      113     1       0
        96      0       19      95      3       0
        97      0       19      150     3       1
        98      0       22      95      3       0
        99      0       30      107     3       2
        100     0       18      100     1       0
        101     0       18      100     1       0
        102     0       15      98      2       0
        103     0       25      118     1       3
        104     0       20      120     3       0
        105     0       28      120     1       1
        106     0       32      121     3       2
        107     0       31      100     1       3
        108     0       36      202     1       1
        109     0       28      120     3       0
        111     0       25      120     3       2
        112     0       28      167     1       0
        113     0       17      122     1       0
        114     0       29      150     1       2
        115     0       26      168     2       0
        116     0       17      113     2       1
        117     0       17      113     2       1
        115     0       24      90      1       1
        119     0       35      121     2       1
        120     0       25      155     1       1
        121     0       25      125     2       0
        123     0       29      140     1       2
        124     0       19      138     1       2
        125     0       27      124     1       0
        126     0       31      215     1       2
        127     0       33      109     1       1
        128     0       21      185     2       2
        129     0       19      189     1       2
        130     0       23      130     2       1
        131     0       21      160     1       0
        132     0       18      90      1       0
        133     0       18      90      1       0
        134     0       32      132     1       4
        135     0       19      132     3       0
        136     0       24      115     1       2
        137     0       22      85      3       0
        138     0       22      120     1       1
        139     0       23      128     3       0
        140     0       22      130     1       0
        141     0       30      95      1       2
        142     0       19      115     3       0
        143     0       16      110     3       0
        144     0       21      110     3       0
        145     0       30      153     3       0
        146     0       20      103     3       0
        147     0       17      119     3       0
        148     0       17      119     3       0
        149     0       23      119     3       2
        150     0       24      110     3       0
        151     0       28      140     1       0
        154     0       26      133     3       0
        155     0       20      169     3       1
        156     0       24      115     3       2
        159     0       28      250     3       6
        160     0       20      141     1       1
        161     0       22      158     2       2
        162     0       22      112     1       0
        163     0       31      150     3       2
        164     0       23      115     3       1
        166     0       16      112     2       0
        167     0       16      135     1       0
        168     0       18      229     2       0
        169     0       25      140     1       1
        170     0       32      134     1       4
        172     0       20      121     2       0
        173     0       23      190     1       0
        174     0       22      131     1       1
        175     0       32      170     1       0
        176     0       30      110     3       0
        177     0       20      127     3       0
        179     0       23      123     3       0
        180     0       17      120     3       0
        181     0       19      105     3       0
        182     0       23      130     1       0
        183     0       36      175     1       0
        184     0       22      125     1       1
        185     0       24      133     1       0
        186     0       21      134     3       2
        187     0       19      235     1       0
        188     0       25      95      1       0
        189     0       16      135     1       0
        190     0       29      135     1       1
        191     0       29      154     1       1
        192     0       19      147     1       0
        193     0       19      147     1       0
        195     0       30      137     1       1
        196     0       24      110     1       1
        197     0       19      184     1       0
        199     0       24      110     3       0
        200     0       23      110     1       1
        201     0       20      120     3       0
        202     0       25      241     2       0
        203     0       30      112     1       1
        204     0       22      169     1       0
        205     0       18      120     1       2
        206     0       16      170     2       4
        207     0       32      186     1       2
        208     0       18      120     3       1
        209     0       29      130     1       2
        210     0       33      117     1       1
        211     0       20      170     1       0
        212     0       28      134     3       1
        213     0       14      135     1       0
        214     0       28      130     3       0
        215     0       25      120     1       2
        216     0       16      95      3       1
        217     0       20      158     1       1
        218     0       26      160     3       0
        219     0       21      115     1       1
        220     0       22      129     1       0
        221     0       25      130     1       2
        222     0       31      120     1       2
        223     0       35      170     1       1
        224     0       19      120     1       0
        225     0       24      116     1       1
        226     0       45      123     1       1
        4       1       28      120     3       0
        10      1       29      130     1       2
        11      1       34      187     2       0
        13      1       25      105     3       0
        15      1       25      85      3       0
        16      1       27      150     3       0
        17      1       23      97      3       1
        18      1       24      128     2       1
        19      1       24      132     3       0
        20      1       21      165     1       1
        22      1       32      105     1       0
        23      1       19      91      1       0
        24      1       25      115     3       0
        25      1       16      130     3       1
        26      1       25      92      1       0
        27      1       20      150     1       2
        28      1       21      200     2       2
        29      1       24      155     1       0
        30      1       21      103     3       0
        31      1       20      125     3       0
        32      1       25      89      3       1
        33      1       19      102     1       2
        34      1       19      112     1       0
        35      1       26      117     1       0
        36      1       24      138     1       0
        37      1       17      130     3       0
        40      1       20      120     2       3
        42      1       22      130     1       1
        43      1       27      130     2       0
        44      1       20      80      3       0
        45      1       17      110     1       0
        46      1       25      105     3       1
        47      1       20      109     3       0
        49      1       18      148     3       0
        50      1       18      110     2       0
        51      1       20      121     1       0
        52      1       21      100     3       4
        54      1       26      96      3       0
        56      1       31      102     1       1
        57      1       15      110     1       0
        59      1       23      187     2       1
        60      1       20      122     2       0
        61      1       24      105     2       0
        62      1       15      115     3       0
        63      1       23      120     3       0
        65      1       30      142     1       0
        67      1       22      130     1       1
        68      1       17      120     1       3
        69      1       23      110     1       0
        71      1       17      120     2       2
        75      1       26      154     3       1
        76      1       20      105     3       3
        77      1       26      190     1       0
        78      1       14      101     3       0
        79      1       28      95      1       2
        81      1       14      100     3       2
        82      1       23      94      3       0
        83      1       17      142     2       0
        84      1       21      130     1       3
;
run;

proc genmod data=lobwgt desc;
  class race ;
  model low=race age lwt ftv / dist=b link=logit;
run;

data bladder;
  input time x n;
  logtime=log(time);
cards;
2       0       1
3       0       1
6       0       1
8       0       1
9       0       1
10      0       1
11      0       1
13      0       1
14      0       1
16      0       1
21      0       1
22      0       1
24      0       1
26      0       1
27      0       1
7       0       2
13      0       2
15      0       2
18      0       2
23      0       2
20      0       3
24      0       4
1       1       1
5       1       1
17      1       1
18      1       1
25      1       1
18      1       2
25      1       2
4       1       3
19      1       4
;

proc genmod data=bladder;
  model n=x / offset=logtime dist=p;
run;


data fap;
  input male treat base_n age r_n;
cards;
0       1       7       17      6
0       0       77      20      67
1       1       7       16      4
0       0       5       18      5
1       1       23      22      16
0       0       35      13      31
0       1       11      23      6
1       0       12      34      20
1       0       7       50      7
1       0       318     19      347
1       1       160     17      142
0       1       8       23      1
1       0       20      22      16
1       0       11      30      20
1       0       24      27      26
1       1       34      23      27
0       0       54      22      45
1       1       16      13      10
1       0       30      34      30
0       1       10      23      6
0       1       20      22      5
1       1       12      42      8
;

proc genmod data=fap;
  model r_n=male treat base_n age / dist=p;
run;

proc genmod data=fap;
  model r_n=male treat base_n age / dist=g link=log;  
run;

proc genmod data=fap;
  model r_n=male treat base_n age / dist=p;
  output out=pout reschi=rs;
run;
proc univariate data=pout noprint;
  var rs;
  probplot rs / normal;
run;
proc genmod data=fap;
  model r_n=male treat base_n age / dist=g link=log;  
  output out=gout reschi=rs;
run;
proc univariate data=gout noprint;
  var rs;
  probplot rs / normal;
run;

proc genmod data=fap;
  model r_n=male treat base_n age /  dist=p scale=d;
  output out=pout reschi=rs;
run;
proc univariate data=pout noprint;
  var rs;
  probplot rs / normal;
run;

data seizures;
 input id ns x1-x3;
cards;
1       14      0       11      31
2       14      0       11      30
3       11      0       6       25
4       13      0       8       36
5       55      0       66      22
6       22      0       27      29
7       12      0       12      31
8       95      0       52      42
9       22      0       23      37
10      33      0       10      28
11      66      0       52      36
12      30      0       33      24
13      16      0       18      23
14      42      0       42      36
15      59      0       87      26
16      16      0       50      26
17      6       0       18      28
18      123     0       111     31
19      15      0       18      32
20      16      0       20      21
21      14      0       12      29
22      14      0       9       21
23      13      0       17      32
24      30      0       28      25
25      143     0       55      30
26      6       0       9       10
27      10      0       10      19
28      53      0       47      22
29      42      1       74      18
30      28      1       38      32
31      7       1       19      20
32      13      1       10      30
33      19      1       19      18
34      11      1       24      24
35      74      1       31      30
36      20      1       14      35
37      10      1       11      27
38      24      1       67      20
39      29      1       41      22
40      4       1       7       28
41      6       1       22      23
42      12      1       13      40
43      65      1       46      33
44      26      1       36      21
45      39      1       38      35
46      7       1       7       25
47      32      1       36      26
48      3       1       11      25
49      302     1       151     22
50      13      1       22      32
51      26      1       41      25
52      10      1       32      35
53      70      1       56      21
54      13      1       24      41
55      15      1       16      32
56      51      1       22      26
57      6       1       25      21
58      0       1       13      36
59      10      1       12      37
;

proc genmod data=seizures;
  model ns=x1-x3 /dist=p ;
run;

data clots;
input conc time @;
  lot=1;
  output;
  input time;
  lot=2;
  output;
cards;
5  118  69
10  58  35
15  42  26
20  35  21
30  27  18
40  25  16
60  21  13
80  19  12
100  18  12
;

proc genmod data=clots;
  class lot;
  model time=lot conc /dist=gamma ;
  output out=genout resdev=rd;
run;

/* Chapter 9 */
%setopts;

data oxygen;
input id o2uptake expired;
cards;
 1   574     21.9
 2   592     18.6
 3   664     18.6
 4   667     19.1
 5   718     19.2
 6   770     16.9
 7   927     18.3
 8   947     17.2
 9  1020     19.0
10  1096     19.0
11  1277     18.6
12  1323     22.8
13  1330     24.6
14  1599     24.9
15  1639     29.2
16  1787     32.0
17  1790     27.9
18  1794     31.0
19  1874     30.7
20  2049     35.4
21  2132     36.1
22  2160     39.1
23  2292     42.6
24  2312     39.9
25  2475     46.2
26  2489     50.9
27  2490     46.5
28  2577     46.3
29  2766     55.8
30  2812     54.5
31  2893     63.5
32  2957     60.3
33  3052     64.8
34  3151     69.2
35  3161     74.7
36  3266     72.9
37  3386     80.4
38  3452     83.0
39  3521     86.0
40  3543     88.9
41  3676     96.8
42  3741     89.1
43  3844    100.9
44  3878    103.0
45  4002    113.4
46  4114    111.4
47  4152    119.9
48  4252    127.2
49  4290    126.4
50  4331    135.5
51  4332    138.9
52  4390    143.7
53  4393    144.8
;


proc gam data=oxygen;
  model expired=loess(o2uptake) / method=gcv;
  output out=gamout pred ;
run;

proc gplot data=gamout;
  plot (expired p_expired)*o2uptake /overlay;
symbol1 i=none v=dot;
symbol2 i=join v=none;
run;

proc glm data=oxygen;
  model expired=o2uptake|o2uptake|o2uptake|o2uptake;
  output out=glmout p=pred;
run;

proc gplot data=glmout;
 plot (expired expired pred)*o2uptake /overlay;
symbol1 i=rq v=dot;
symbol2 i=rc v=none l=2;
symbol3 i=join v=none l=3;
run;

data respdeaths;
 retain obs 0;
 input year @;
 do month=1 to 12;
 input deaths @;
 output;
 obs=obs+1;
 end;
cards;
1974    3035    2552    2704    2554    2014    1655    1721    1524    1596    2074    2199    2512
1975    2933    2889    2938    2497    1870    1726    1607    1545    1396    1787    2076    2837
1976    2787    3891    3179    2011    1636    1580    1489    1300    1356    1653    2013    2823
1977    2996    2523    2540    2520    1994    1964    1691    1479    1596    1877    2032    2484
1978    2899    2990    2890    2379    1933    1734    1617    1495    1440    1777    1970    2745
1979    2841    3535    3010    2091    1667    1589    1518    1348    1392    1619    1954    2633
run;

proc gam data=respdeaths;
  model deaths=loess(year) loess(month)/ method=gcv;
  id obs;
  output out=respout all;
run;
proc gplot data=respout;
  plot (deaths p_deaths)*obs /overlay;
symbol1 i=none v=dot;
symbol2 i=join v=none;
run;

proc sort data=respout; by month; run;
proc gplot data=respout gout=addfits;
  plot (p_month uclm_month lclm_month)*month /overlay;
symbol1 i=join v=none;
symbol2 i=join l=2 r=2;
run;
proc sort data=respout; by year; run;
proc gplot data=respout gout=addfits;
  plot (p_year uclm_year lclm_year)*year /overlay;
run;

%panelplot(igout=addfits,ncols=2);

goptions reset=symbol;
proc gplot data=respdeaths;
  plot (deaths deaths deaths)*obs /overlay;
symbol1 i=sm20 v=dot l=1;
symbol2 i=sm40 v=none l=2; 
symbol3 i=sm60 v=none l=3;
run;

data diabetes;
input id age base peptide;
logpeptide=log10(peptide);
cards;
1         5.2   -8.1    4.8
2         8.8   -16.1   4.1
3        10.5   -0.9    5.2
4        10.6   -7.8    5.5
5        10.4   -29.0   5.0
6         1.8   -19.2   3.4
7        12.7   -18.9   3.4
8        15.6   -10.6   4.9
9         5.8    -2.8   5.6
10        1.9   -25.0   3.7
11        2.2   -3.1    3.9
12        4.8   -7.8    4.5
13        7.9   -13.9   4.8
14        5.2   -4.5    4.9
15        0.9   -11.6   3.0
16       11.8   -2.1    4.6
17        7.9   -2.0    4.8
18       11.5   -9.0    5.5
19       10.6   -11.2   4.5
20        8.5   -0.2    5.3
21       11.1   -6.1    4.7
22       12.8   -1.0    6.6
23       11.3   -3.6    5.1
24        1.0   -8.2    3.9
25       14.5   -0.5    5.7
26       11.9   -2.0    5.1
27        8.1   -1.6    5.2
28       13.8   -11.9   3.7
29       15.5   -0.7    4.9
30        9.8   -1.2    4.8
31       11.0   -14.3   4.4
32       12.4   -0.8    5.2
33       11.1   -16.8   5.1
34        5.1   -5.1    4.6
35        4.8   -9.5    3.9
36        4.2   -17.0   5.1
37        6.9   -3.3    5.1
38       13.2   -0.7    6.0
39        9.9   -3.3    4.9
40       12.5   -13.6   4.1
41       13.2   -1.9    4.6
42        8.9   -10.0   4.9
43       10.8   -13.5   5.1
run;

proc gplot data=diabetes gout=logpep;
   plot (logpeptide logpeptide)*age /overlay ;
   plot (logpeptide logpeptide)*base /overlay ;
   symbol1 i=rl v=dot;
   symbol2 i=sm50s v=none;
run;

%panelplot(igout=logpep,ncols=2);

ods html;
ods graphics on;
proc gam data=diabetes plots(clm commonaxes);
  model logpeptide=loess(age) loess(base) / method=gcv;
run;
ods graphics off;
ods html close;

proc gam data=diabetes;
  model logpeptide= param(base) loess(age)/ method=gcv;
run;

proc gam data=diabetes;
  model logpeptide= param(base age)/ method=gcv;
run;

data usair;
  input city $16. hiso2 temperature factories population windspeed rain rainydays;
cards;
Phoenix          0  70.3   213   582  6.0  7.05   36
Little Rock      0  61.0    91   132  8.2 48.52  100
San Francisco    0  56.7   453   716  8.7 20.66   67
Denver           0  51.9   454   515  9.0 12.95   86
Hartford         1  49.1   412   158  9.0 43.37  127
Wilmington       1  54.0    80    80  9.0 40.25  114
Washington       0  57.3   434   757  9.3 38.89  111
Jacksonville     0  68.4   136   529  8.8 54.47  116
Miami            0  75.5   207   335  9.0 59.80  128
Atlanta          0  61.5   368   497  9.1 48.34  115
Chicago          1  50.6  3344  3369 10.4 34.44  122
Indianapolis     0  52.3   361   746  9.7 38.74  121
Des Moines       0  49.0   104   201 11.2 30.85  103
Wichita          0  56.6   125   277 12.7 30.58   82
Louisville       1  55.6   291   593  8.3 43.11  123
New Orleans      0  68.3   204   361  8.4 56.77  113
Baltimore        1  55.0   625   905  9.6 41.31  111
Detroit          1  49.9  1064  1513 10.1 30.96  129
Minneapolis      0  43.5   699   744 10.6 25.94  137
Kansas City      0  54.5   381   507 10.0 37.00   99
St. Louis        1  55.9   775   622  9.5 35.89  105
Omaha            0  51.5   181   347 10.9 30.18   98
Albuquerque      0  56.8    46   244  8.9  7.77   58
Albany           1  47.6    44   116  8.8 33.36  135
Buffalo          0  47.1   391   463 12.4 36.11  166
Cincinnati       0  54.0   462   453  7.1 39.04  132
Cleveland        1  49.7  1007   751 10.9 34.99  155
Columbus         0  51.5   266   540  8.6 37.01  134
Philadelphia     1  54.6  1692  1950  9.6 39.93  115
Pittsburgh       1  50.4   347   520  9.4 36.22  147
Providence       1  50.0   343   179 10.6 42.75  125
Memphis          0  61.6   337   624  9.2 49.10  105
Nashville        0  59.4   275   448  7.9 46.00  119
Dallas           0  66.2   641   844 10.9 35.94   78
Houston          0  68.9   721  1233 10.8 48.19  103
Salt Lake City   0  51.0   137   176  8.7 15.17   89
Norfolk          1  59.3    96   308 10.6 44.68  116
Richmond         0  57.8   197   299  7.6 42.59  115
Seattle          0  51.1   379   531  9.4 38.79  164
Charleston       1  55.2    35    71  6.5 40.75  148
Milwaukee        0  45.7   569   717 11.8 29.07  123
;

proc logistic data=usair desc;
 model hiso2=temperature factories population windspeed rain rainydays /selection=b;
run;

proc sort data=usair;
  by hiso2;
run;

goption reset=symbol;
proc boxplot data=usair gout=boxplots;
 plot (population rain)*hiso2 /boxstyle=schematicid;
 id city;
run;

%panelplot(igout=boxplots,nrows=2);

data usair;
  set usair;
  if city=:'Chicago' then delete;
run;

symbol1 i=sm70s v='|' f=roman;
proc gplot data=usair gout=smplots;
 plot hiso2*(population rain);
run;

%panelplot(igout=smplots,nrows=2);

ods rtf;
ods graphics on;
proc gam data=usair;
 model hiso2=spline(rain,df=2) /dist=binary ;
 output out=gamout p;
run;
ods graphics off;
ods rtf close;

data gamout;
  set gamout;
  odds=exp(P_hiso2);
  pred=odds/(1+odds);
run;

goptions reset=symbol;
proc gplot data=gamout;
 plot pred*rain;
run;

/* Chapter 10 */
%setopts;

data assay;
 input conc absorb;
 logconc=log(conc);
cards;
10000   0.880
10000   0.784
5000    0.776
5000    0.769
2500    0.622
2500    0.614
1250    0.500
1250    0.488
625     0.347
625     0.356
312     0.263
312     0.260
156     0.192
156     0.173
78      0.125
78      0.138
39      0.070
39      0.064
20      0.050
20      0.044
10      0.029
10      0.029
5       0.018
5       0.018
;

proc gplot data=assay;
  plot absorb*logconc;
run;

data assay;
  set assay;
  logratio=log(absorb/(.9-absorb));
run;

proc gplot data=assay;
  plot logratio*logconc;
  symbol1 i=r v=plus;
run;


proc nlin data=assay;
  parms alpha=0 beta=.9 gamma=1096 delta=.8;
  model absorb=alpha + (beta-alpha)/(1 + (conc/gamma)**-delta);
  output out=nlout p=pr;
run;


proc gplot data=nlout;
  plot (absorb pr)* conc/overlay;
  symbol1 i=none v=plus;
  symbol2 i=join v=none; 
run;

data cortisol;
input dose @;
select(dose);
  when(0) logdose=-3;
  when(9999)logdose=2;
  otherwise logdose=log10(dose);
end;
do i=1 to 4;
 input resp @;
 output;
end;
input;
cards;
0       2868    2785    2849    2805
0       2779    2588    2701    2752
0.02    2615    2651    2506    2498
0.04    2474    2573    2378    2494
0.06    2152    2307    2101    2216
0.08    2114    2052    2016    2030
0.1     1862    1935    1800    1871
0.2     1364    1412    1377    1304
0.4     910     919     855     875
0.6     702     701     689     696
0.8     586     596     561     562
1       501     495     478     493
1.5     392     358     399     394
2       330     351     343     333
4       250     261     244     242
9999    131     135     134     133
;

proc gplot data=cortisol;
  plot resp*logdose;
run;

proc means data=cortisol var n;
  class dose;
  var resp;
  output out=variances var=var_resp;
run;

data cortisol;
  merge cortisol(in=in1) variances;
  by dose;
  if in1;
run;

proc nlin data=cortisol;
  parms theta1=100 theta2=2500 theta3=1 theta4=1 theta5=1;
  model resp=theta1 + (theta2-theta1)
                      /((1+exp(theta3+theta4*logdose))**theta5);
  _weight_=1/var_resp;
  output out=nlout p=pr;
run;

proc gplot data=nlout;
  plot (resp pr)*dose/overlay;
  symbol1 v=plus;
  symbol2 i=join v=none;
  where dose<9999; 
run;

/* Chapter 11 */
%setopts;


data bprs;
  input id x0-x8;
  group=1;
  if _n_>20 then group=2;
  id=100*group+id;
cards;
1       42      36      36      43      41      40      38      47      51
2       58      68      61      55      43      34      28      28      28
3       54      55      41      38      43      28      29      25      24
4       55      77      49      54      56      50      47      42      46
5       72      75      72      65      50      39      32      38      32
6       48      43      41      38      36      29      33      27      25
7       71      61      47      30      27      40      30      31      31
8       30      36      38      38      31      26      26      25      24
9       41      43      39      35      28      22      20      23      21
10      57      51      51      55      53      43      43      39      32
11      30      34      34      41      36      36      38      36      36
12      55      52      49      54      48      43      37      36      31
13      36      32      36      31      25      25      21      19      22
14      38      35      36      34      25      27      25      26      26
15      66      68      65      49      36      32      27      30      37
16      41      35      45      42      31      31      29      26      30
17      45      38      46      38      40      33      27      31      27
18      39      35      27      25      29      28      21      25      20
19      24      28      31      28      29      21      22      23      22
20      38      34      27      25      25      27      21      19      21
1       52      73      42      41      39      38      43      62      50
2       30      23      32      24      20      20      19      18      20
3       65      31      33      28      22      25      24      31      32
4       37      31      27      31      31      26      24      26      23
5       59      67      58      61      49      38      37      36      35
6       30      33      37      33      28      26      27      23      21
7       69      52      41      33      34      37      37      38      35
8       62      54      49      39      55      51      55      59      66
9       38      40      38      27      31      24      22      21      21
10      65      44      31      34      39      34      41      42      39
11      78      95      75      76      66      64      64      60      75
12      38      41      36      27      29      27      21      22      23
13      63      65      60      53      52      32      37      52      28
14      40      37      31      38      35      30      33      30      27
15      40      36      55      55      42      30      26      30      37
16      54      45      35      27      25      22      22      22      22
17      33      41      30      32      46      43      43      43      43
18      28      30      29      33      30      26      36      33      30
19      52      43      26      27      24      32      21      21      21
20      47      36      32      29      25      23      23      23      23
;

data bprsl;
  set bprs;
  array xs {*} x0-x8;
  do week=0 to 8;
    bprs=xs{week+1};
    weekgroup=week+(group/10);
    output;
  end;
  keep id group week weekgroup bprs;
run;

proc gplot data=bprsl;
  plot bprs*week=id /nolegend;
  symbol1 i=join v=none r=20;
  symbol2 i=join v=none l=2 r=20;
run;

proc sort data=bprsl;
 by week;
run;

proc stdize data=bprsl out=bprslz method=std;
  var bprs;
  by week;
run;

proc sort data=bprslz;
 by id week;
run;

proc gplot data=bprslz;
  plot bprs*week=id /nolegend;
run;

goptions reset=symbol;
proc gplot data=bprsl;
  plot bprs*week=group;
  symbol1 i=stdm1j;
  symbol2 i=stdm1j l=2;
run;

goptions reset=symbol;
proc gplot data=bprsl;
  plot bprs*weekgroup=group /nolegend;
  symbol1 i=box v=plus;
  symbol2 i=box v=star;
run;

data bprs;
 set bprs;
 mnbprs=mean(of x1-x8);
run;

proc boxplot data=bprs;
  plot mnbprs*group /boxstyle=schematic;
run;

proc ttest data=bprs;
  class group;
  var mnbprs;
run;

proc glm data=bprs;
  class group;
  model mnbprs=x0 group ;
run;

data labour;
  infile cards missover;
  input id x0-x6;
  group=1;
  if _n_>20 then group=2;
  mnpain=mean(of x0-x6);
cards;
1       0.0     0.0     0.0     0.0                     
2       0.0     0.0     0.0     0.0     2.5     2.3     14.0
3       38.0    5.0     1.0     1.0     0.0     5.0     
4       6.0     48.0    85.0    0.0     0.0             
5       19.0    5.0                                     
6       7.0     0.0     0.0     0.0                     
7       44.0    42.0    42.0    45.0                    
8       1.0     0.0     0.0     0.0     0.0     6.0     24.0
9       24.5    35.0    13.0                            
10      1.0     30.5    81.5    67.5    98.5    97.0    
11      35.5    44.5    55.0    69.0    72.5    39.5    26.0
12      0.0     0.0     0.0     0.0     0.0     0.0     0.0
13      8.0     30.5    26.0    24.0    29.0    45.0    91.0
14      7.0     6.5     7.0     4.0     10.0            
15      6.0     8.5     19.5    16.5    42.5    45.5    48.5
16      32.5    9.5     7.5     5.5     4.5     0.0     7.0
17      10.5    10.0    18.0    32.5    0.0     0.0     0.0
18      11.5    20.5    32.5    37.0    39.0            
19      72.0    91.5    4.5     32.0    10.5    10.5    10.5
20      0.0     0.0     0.0     0.0     13.54   7.0     
1       4.0     9.0     30.0    75.0    49.0    97.0    
2       0.0     0.0     1.0     27.5    95.0    100.0   
3       9.0     6.0     25.0                            
4       52.5    18.0    12.5                            
5       90.5    99.0    100.0   100.0   100.0   100.0   100.0
6       74.0    70.0    81.5    94.5    97.0            
7       0.0     0.0     0.0     1.5     0.0     18.0    71.0
8       0.0     51.5    56.0                            
9       6.5     7.0     7.0     9.0     25.0    36.0    20.0
10      19.0    31.0    41.0    58.0                    
11      6.0     23.0    45.0    67.0    90.5            
12      42.0    64.0    6.0                             
13      86.5    53.0    88.0    100.0   100.0           
14      50.0    100.0   100.0   100.0   100.0           
15      27.5    36.5    74.0    97.0    100.0   100.0   95.0
16      0.0     0.0     6.0     6.0                     
17      62.0    79.0    80.5    85.0    90.0    97.5    97.0
18      17.5    27.5    21.0    60.0    80.0    97.0    
19      6.5     5.5     18.5    20.0    36.5    63.5    81.5
20      8.0     9.0     35.5    39.0    70.0    92.0    98.0
;

proc ttest data=labour;
  class group;
  var mnpain;
run;

data resptrial;
 input id centre treat sex age bl v1-v4;
 ngood=sum(of v1-v4);
 visits=4;
 mnstatus=mean(of v1-v4);
 arcsin=arsin(mnstatus);
 arcroot=arsin(sqrt(mnstatus));
cards;
1       1       1       1       46      0       0       0       0       0
2       1       1       1       28      0       0       0       0       0
3       1       2       1       23      1       1       1       1       1
4       1       1       1       44      1       1       1       1       0
5       1       1       2       13      1       1       1       1       1
6       1       2       1       34      0       0       0       0       0
7       1       1       1       43      0       1       0       1       1
8       1       2       1       28      0       0       0       0       0
9       1       2       1       31      1       1       1       1       1
10      1       1       1       37      1       0       1       1       0
11      1       2       1       30      1       1       1       1       1
12      1       2       1       14      0       1       1       1       0
13      1       1       1       23      1       1       0       0       0
14      1       1       1       30      0       0       0       0       0
15      1       1       1       20      1       1       1       1       1
16      1       2       1       22      0       0       0       0       1
17      1       1       1       25      0       0       0       0       0
18      1       2       2       47      0       0       1       1       1
19      1       1       2       31      0       0       0       0       0
20      1       2       1       20      1       1       0       1       0
21      1       2       1       26      0       1       0       1       0
22      1       2       1       46      1       1       1       1       1
23      1       2       1       32      1       1       1       1       1
24      1       2       1       48      0       1       0       0       0
25      1       1       2       35      0       0       0       0       0
26      1       2       1       26      0       0       0       0       0
27      1       1       1       23      1       1       0       1       1
28      1       1       2       36      0       1       1       0       0
29      1       1       1       19      0       1       1       0       0
30      1       2       1       28      0       0       0       0       0
31      1       1       1       37      0       0       0       0       0
32      1       2       1       23      0       1       1       1       1
33      1       2       1       30      1       1       1       1       0
34      1       1       1       15      0       0       1       1       0
35      1       2       1       26      0       0       0       1       0
36      1       1       2       45      0       0       0       0       0
37      1       2       1       31      0       0       1       0       0
38      1       2       1       50      0       0       0       0       0
39      1       1       1       28      0       0       0       0       0
40      1       1       1       26      0       0       0       0       0
41      1       1       1       14      0       0       0       0       1
42      1       2       1       31      0       0       1       0       0
43      1       1       1       13      1       1       1       1       1
44      1       1       1       27      0       0       0       0       0
45      1       1       1       26      0       1       0       1       1
46      1       1       1       49      0       0       0       0       0
47      1       1       1       63      0       0       0       0       0
48      1       2       1       57      1       1       1       1       1
49      1       1       1       27      1       1       1       1       1
50      1       2       1       22      0       0       1       1       1
51      1       2       1       15      0       0       1       1       1
52      1       1       1       43      0       0       0       1       0
53      1       2       2       32      0       0       0       1       0
54      1       2       1       11      1       1       1       1       0
55      1       1       1       24      1       1       1       1       1
56      1       2       1       25      0       1       1       0       1
57      2       1       2       39      0       0       0       0       0
58      2       2       1       25      0       0       1       1       1
59      2       2       1       58      1       1       1       1       1
60      2       1       2       51      1       1       0       1       1
61      2       1       2       32      1       0       0       1       1
62      2       1       1       45      1       1       0       0       0
63      2       1       2       44      1       1       1       1       1
64      2       1       2       48      0       0       0       0       0
65      2       2       1       26      0       1       1       1       1
66      2       2       1       14      0       1       1       1       1
67      2       1       2       48      0       0       0       0       0
68      2       2       1       13      1       1       1       1       1
69      2       1       1       20      0       1       1       1       1
70      2       2       1       37      1       1       0       0       1
71      2       2       1       25      1       1       1       1       1
72      2       2       1       20      0       0       0       0       0
73      2       1       2       58      0       1       0       0       0
74      2       1       1       38      1       1       0       0       0
75      2       2       1       55      1       1       1       1       1
76      2       2       1       24      1       1       1       1       1
77      2       1       2       36      1       1       0       0       1
78      2       1       1       36      0       1       1       1       1
79      2       2       2       60      1       1       1       1       1
80      2       1       1       15      1       0       0       1       1
81      2       2       1       25      1       1       1       1       0
82      2       2       1       35      1       1       1       1       1
83      2       2       1       19      1       1       0       1       1
84      2       1       2       31      1       1       1       1       1
85      2       2       1       21      1       1       1       1       1
86      2       2       2       37      0       1       1       1       1
87      2       1       1       52      0       1       1       1       1
88      2       2       1       55      0       0       1       1       0
89      2       1       1       19      1       0       0       1       1
90      2       1       1       20      1       0       1       1       1
91      2       1       1       42      1       0       0       0       0
92      2       2       1       41      1       1       1       1       1
93      2       2       1       52      0       0       0       0       0
94      2       1       2       47      0       1       1       0       1
95      2       1       1       11      1       1       1       1       1
96      2       1       1       14      0       0       0       1       0
97      2       1       1       15      1       1       1       1       1
98      2       1       1       66      1       1       1       1       1
99      2       2       1       34      0       1       1       0       1
100     2       1       1       43      0       0       0       0       0
101     2       1       1       33      1       1       1       0       1
102     2       1       1       48      1       1       0       0       0
103     2       2       1       20      0       1       1       1       1
104     2       1       2       39      1       0       1       0       0
105     2       2       1       28      0       1       0       0       0
106     2       1       2       38      0       0       0       0       0
107     2       2       1       43      1       1       1       1       1
108     2       2       2       39      0       1       1       1       1
109     2       2       1       68      0       1       1       1       1
110     2       2       2       63      1       1       1       1       1
111     2       2       1       31      1       1       1       1       1
;

proc ttest data=resptrial;
  class treat;
  var mnstatus arcsin arcroot;
run;

proc glm data=resptrial;
  class centre treat sex;
  model arcroot=centre age sex bl treat;
run;
  
proc logistic data=resptrial;
  class centre treat sex /param=ref ref=first;
  model ngood/visits=centre age sex bl treat /scale=d ;
run;

/* Chapter 12 */
%setopts;

data pip;
 input id x1-x8;
 if id>13 then group=2;
 else group=1;
cards;
1       4.3     3.3     3.0     2.6     2.2     2.5     3.4     4.4
2       3.7     2.6     2.6     1.9     2.9     3.2     3.1     3.9
3       4.0     4.1     3.1     2.3     2.9     3.1     3.9     4.0
4       3.6     3.0     2.2     2.8     2.9     3.9     3.8     4.0
5       4.1     3.8     2.1     3.0     3.6     3.4     3.6     3.7
6       3.8     2.2     2.0     2.6     3.8     3.6     3.0     3.5
7       3.8     3.0     2.4     2.5     3.1     3.4     3.5     3.7
8       4.4     3.9     2.8     2.1     3.6     3.8     4.0     3.9
9       5.0     4.0     3.4     3.4     3.3     3.6     4.0     4.3
10      3.7     3.1     2.9     2.2     1.5     2.3     2.7     2.8
11      3.7     2.6     2.6     2.3     2.9     2.2     3.1     3.9
12      4.4     3.7     3.1     3.2     3.7     4.3     3.9     4.8
13      4.7     3.1     3.2     3.3     3.2     4.2     3.7     4.3
14      4.3     3.3     3.0     2.6     2.2     2.5     2.4     3.4
15      5.0     4.9     4.1     3.7     3.7     4.1     4.7     4.9
16      4.6     4.4     3.9     3.9     3.7     4.2     4.8     5.0
17      4.3     3.9     3.1     3.1     3.1     3.1     3.6     4.0
18      3.1     3.1     3.3     2.6     2.6     1.9     2.3     2.7
19      4.8     5.0     2.9     2.8     2.2     3.1     3.5     3.6
20      3.7     3.1     3.3     2.8     2.9     3.6     4.3     4.4
21      5.4     4.7     3.9     4.1     2.8     3.7     3.5     3.7
22      3.0     2.5     2.3     2.2     2.1     2.6     3.2     3.5
23      4.9     5.0     4.1     3.7     3.7     4.1     4.7     4.9
24      4.8     4.3     4.7     4.6     4.7     3.7     3.6     3.9
25      4.4     4.2     4.2     3.4     3.5     3.4     3.8     4.0
26      4.9     4.3     4.0     4.0     3.3     4.1     4.2     4.3
27      5.1     4.1     4.6     4.1     3.4     4.2     4.4     4.9
28      4.8     4.6     4.6     4.4     4.1     4.0     3.8     3.8
29      4.2     3.5     3.8     3.6     3.3     3.1     3.5     3.9
30      6.6     6.1     5.2     4.1     4.3     3.8     4.2     4.8
31      3.6     3.4     3.1     2.8     2.1     2.4     2.5     3.5
32      4.5     4.0     3.7     3.3     2.4     2.3     3.1     3.3
33      4.6     4.4     3.8     3.8     3.8     3.6     3.8     3.8
;

data pipl;
  set pip;
  array xs {*} x1-x8;
  array t{8} t1-t8 (0 .5 1 1.5 2 3 4 5);
  do i=1 to 8;
    time=t{i};
    pip=xs{i};
    output;
  end;
  label time='hours after glucose'; 
run;

proc format;
  value group 1='Control' 2='Obese';
run;

%inc 'c:\sasbook\macros\panelplot.sas';
%inc 'c:\sasbook\macros\template.sas';
%inc 'c:\sasbook\macros\plotmat.sas';

proc sort data=pipl; by group id; run;
proc gplot data=pipl gout=fig12_1 uniform;
 plot pip*time=id /nolegend hminor=0 ;
 by group;
 symbol1 i=join v=none r=50;
 format group group.;
run;

%panelplot(igout=fig12_1,ncols=2);


data group1 group2;
  set pip;
  if group=1 then output group1;
  else output group2; 
run;
goptions reset=symbol;
%plotmat(group1,x1-x8);
%plotmat(group2,x1-x8);

proc sort data=pipl; by id time; run;

proc mixed data=pipl covtest noclprint;
  class group id;
  model pip=group time|time /s ddfm=bw;
  random int time /subject=id type=un;
run;

proc glm data=pipl;
 class group;
 model pip=group time|time /solution;
run;

proc mixed data=pipl covtest noclprint;
  class group id;
  model pip=group time|time /s ddfm=bw outp=mixout;
  random int time /subject=id type=un;
run;

proc sort data=mixout; by group id time; run;

proc gplot data=mixout uniform gout=fig12_4;
 plot pred*time=id /nolegend hminor=0 ;
 by group;
 symbol1 i=join v=none r=50;
 format group group.;
run;

%panelplot(igout=fig12_4,ncols=2);

proc mixed data=pipl covtest noclprint;
  class group id;
  model pip=group time|time group*time/s ddfm=bw outp=mixout;
  random int time /subject=id type=un;
run;

proc gplot data=mixout uniform gout=fig12_5;
 plot pred*time=id /nolegend hminor=0 ;
 by group;
 symbol1 i=join v=none r=50;
 format group group.;
run;

%panelplot(igout=fig12_5,ncols=2);

proc mixed data=pipl covtest noclprint;
  class group id;
  model pip=group time|time group*time/s ddfm=bw outp=mixout;
  random int time /subject=id type=un s;
  ods output solutionr=reffs;
  ods listing exclude solutionr;
run;

proc sort data=reffs; by effect; run;
goptions reset=symbol;
proc univariate data=reffs gout=fig12_6 noprint;
  var estimate;
  probplot estimate /normal;
  by effect;
run;
title h=1 "Residuals";
proc univariate data=mixout gout=fig12_6 noprint;
  var resid;
  probplot resid /normal;
run;
title;

%panelplot(igout=fig12_6,ncols=3);

data btb  (keep=sub--treatment BDIpre--BDI8m)
     btbl (keep=sub--treatment bdi time);
  array bdis {*} BDIpre BDI2m BDI3m BDI5m BDI8m;
  array t {*} t1-t5 (0 2 3 5 8);
  input sub drug$ Duration$ Treatment$ @;
  do i=1 to 5;
    input bdi @;
    bdis{i}=bdi;
    time=t{i};
    output btbl;
  end;
  output btb;
cards;
1       n       >6m     TAU     29      2       2       .       .
2       y       >6m     BtheB   32      16      24      17      20
3       y       <6m     TAU     25      20      .       .       .
4       n       >6m     BtheB   21      17      16      10      9
5       y       >6m     BtheB   26      23      .       .       .
6       y       <6m     BtheB   7       0       0       0       0
7       y       <6m     TAU     17      7       7       3       7
8       n       >6m     TAU     20      20      21      19      13
9       y       <6m     BtheB   18      13      14      20      11
10      y       >6m     BtheB   20      5       5       8       12
11      n       >6m     TAU     30      32      24      12      2
12      y       <6m     BtheB   49      35      .       .       .
13      n       >6m     TAU     26      27      23      .       .
14      y       >6m     TAU     30      26      36      27      22
15      y       >6m     BtheB   23      13      13      12      23
16      n       <6m     TAU     16      13      3       2       0
17      n       >6m     BtheB   30      30      29      .       .
18      n       <6m     BtheB   13      8       8       7       6
19      n       >6m     TAU     37      30      33      31      22
20      y       <6m     BtheB   35      12      10      8       10
21      n       >6m     BtheB   21      6       .       .       .
22      n       <6m     TAU     26      17      17      20      12
23      n       >6m     TAU     29      22      10      .       .
24      n       >6m     TAU     20      21      .       .       .
25      n       >6m     TAU     33      23      .       .       .
26      n       >6m     BtheB   19      12      13      .       .
27      y       <6m     TAU     12      15      .       .       .
28      y       >6m     TAU     47      36      49      34      .
29      y       >6m     BtheB   36      6       0       0       2
30      n       <6m     BtheB   10      8       6       3       3
31      n       <6m     TAU     27      7       15      16      0
32      n       <6m     BtheB   18      10      10      6       8
33      y       <6m     BtheB   11      8       3       2       15
34      y       <6m     BtheB   6       7       .       .       .
35      y       >6m     BtheB   44      24      20      29      14
36      n       <6m     TAU     38      38      .       .       .
37      n       <6m     TAU     21      14      20      1       8
38      y       >6m     TAU     34      17      8       9       13
39      y       <6m     BtheB   9       7       1       .       .
40      y       >6m     TAU     38      27      19      20      30
41      y       <6m     BtheB   46      40      .       .       .
42      n       <6m     TAU     20      19      18      19      18
43      y       >6m     TAU     17      29      2       0       0
44      n       >6m     BtheB   18      20      .       .       .
45      y       >6m     BtheB   42      1       8       10      6
46      n       <6m     BtheB   30      30      .       .       .
47      y       <6m     BtheB   33      27      16      30      15
48      n       <6m     BtheB   12      1       0       0       .
49      y       <6m     BtheB   2       5       .       .       .
50      n       >6m     TAU     36      42      49      47      40
51      n       <6m     TAU     35      30      .       .       .
52      n       <6m     BtheB   23      20      .       .       .
53      n       >6m     TAU     31      48      38      38      37
54      y       <6m     BtheB   8       5       7       .       .
55      y       <6m     TAU     23      21      26      .       .
56      y       <6m     BtheB   7       7       5       4       0
57      n       <6m     TAU     14      13      14      .       .
58      n       <6m     TAU     40      36      33      .       .
59      y       <6m     BtheB   23      30      .       .       .
60      n       >6m     BtheB   14      3       .       .       .
61      n       >6m     TAU     22      20      16      24      16
62      n       >6m     TAU     23      23      15      25      17
63      n       <6m     TAU     15      7       13      13      .
64      n       >6m     TAU     8       12      11      26      .
65      n       >6m     BtheB   12      18      .       .       .
66      n       >6m     TAU     7       6       2       1       .
67      y       <6m     TAU     17      9       3       1       0
68      y       <6m     BtheB   33      18      16      .       .
69      n       <6m     TAU     27      20      .       .       .
70      n       <6m     BtheB   27      30      .       .       .
71      n       <6m     BtheB   9       6       10      1       0
72      n       >6m     BtheB   40      30      12      .       .
73      n       >6m     TAU     11      8       7       .       .
74      n       <6m     TAU     9       8       .       .       .
75      n       >6m     TAU     14      22      21      24      19
76      y       >6m     BtheB   28      9       20      18      13
77      n       >6m     BtheB   15      9       13      14      10
78      y       >6m     BtheB   22      10      5       5       12
79      n       <6m     TAU     23      9       .       .       .
80      n       >6m     TAU     21      22      24      23      22
81      n       >6m     TAU     27      31      28      22      14
82      y       >6m     BtheB   14      15      .       .       .
83      n       >6m     TAU     10      13      12      8       20
84      y       <6m     TAU     21      9       6       7       1
85      y       >6m     BtheB   46      36      53      .       .
86      n       >6m     BtheB   36      14      7       15      15
87      y       >6m     BtheB   23      17      .       .       .
88      y       >6m     TAU     35      0       6       0       1
89      y       <6m     BtheB   33      13      13      10      8
90      n       <6m     BtheB   19      4       27      1       2
91      n       <6m     TAU     16      .       .       .       .
92      y       <6m     BtheB   30      26      28      .       .
93      y       <6m     BtheB   17      8       7       12      .
94      n       >6m     BtheB   19      4       3       3       3
95      n       >6m     BtheB   16      11      4       2       3
96      y       >6m     BtheB   16      16      10      10      8
97      y       <6m     TAU     28      .       .       .       .
98      n       >6m     BtheB   11      22      9       11      11
99      n       <6m     TAU     13      5       5       0       6
100     y       <6m     TAU     43      .       .       .       .
;

proc sort data=btbl;
  by treatment time;
run;

proc boxplot data=btbl gout=fig12_7;
  plot bdi*time / boxstyle=schematic;
  by treatment;
run;

%panelplot(igout=fig12_7,nrows=2);

proc mixed data=btbl covtest noclprint=3;
 class drug duration treatment sub;
 model bdi=drug duration treatment time / s cl ddfm=bw;
 random int time /subject=sub type=un;
run;

proc mixed data=btbl covtest noclprint=3;
 class drug duration treatment sub;
 model bdi=drug duration treatment time / s cl ddfm=bw;
 random int /subject=sub;
run;

/* Chapter 13 */
%setopts;

data respw;
  input id centre treat sex age bl v1-v4;
cards;
1       1       1       1       46      0       0       0       0       0
2       1       1       1       28      0       0       0       0       0
3       1       2       1       23      1       1       1       1       1
4       1       1       1       44      1       1       1       1       0
5       1       1       2       13      1       1       1       1       1
6       1       2       1       34      0       0       0       0       0
7       1       1       1       43      0       1       0       1       1
8       1       2       1       28      0       0       0       0       0
9       1       2       1       31      1       1       1       1       1
10      1       1       1       37      1       0       1       1       0
11      1       2       1       30      1       1       1       1       1
12      1       2       1       14      0       1       1       1       0
13      1       1       1       23      1       1       0       0       0
14      1       1       1       30      0       0       0       0       0
15      1       1       1       20      1       1       1       1       1
16      1       2       1       22      0       0       0       0       1
17      1       1       1       25      0       0       0       0       0
18      1       2       2       47      0       0       1       1       1
19      1       1       2       31      0       0       0       0       0
20      1       2       1       20      1       1       0       1       0
21      1       2       1       26      0       1       0       1       0
22      1       2       1       46      1       1       1       1       1
23      1       2       1       32      1       1       1       1       1
24      1       2       1       48      0       1       0       0       0
25      1       1       2       35      0       0       0       0       0
26      1       2       1       26      0       0       0       0       0
27      1       1       1       23      1       1       0       1       1
28      1       1       2       36      0       1       1       0       0
29      1       1       1       19      0       1       1       0       0
30      1       2       1       28      0       0       0       0       0
31      1       1       1       37      0       0       0       0       0
32      1       2       1       23      0       1       1       1       1
33      1       2       1       30      1       1       1       1       0
34      1       1       1       15      0       0       1       1       0
35      1       2       1       26      0       0       0       1       0
36      1       1       2       45      0       0       0       0       0
37      1       2       1       31      0       0       1       0       0
38      1       2       1       50      0       0       0       0       0
39      1       1       1       28      0       0       0       0       0
40      1       1       1       26      0       0       0       0       0
41      1       1       1       14      0       0       0       0       1
42      1       2       1       31      0       0       1       0       0
43      1       1       1       13      1       1       1       1       1
44      1       1       1       27      0       0       0       0       0
45      1       1       1       26      0       1       0       1       1
46      1       1       1       49      0       0       0       0       0
47      1       1       1       63      0       0       0       0       0
48      1       2       1       57      1       1       1       1       1
49      1       1       1       27      1       1       1       1       1
50      1       2       1       22      0       0       1       1       1
51      1       2       1       15      0       0       1       1       1
52      1       1       1       43      0       0       0       1       0
53      1       2       2       32      0       0       0       1       0
54      1       2       1       11      1       1       1       1       0
55      1       1       1       24      1       1       1       1       1
56      1       2       1       25      0       1       1       0       1
57      2       1       2       39      0       0       0       0       0
58      2       2       1       25      0       0       1       1       1
59      2       2       1       58      1       1       1       1       1
60      2       1       2       51      1       1       0       1       1
61      2       1       2       32      1       0       0       1       1
62      2       1       1       45      1       1       0       0       0
63      2       1       2       44      1       1       1       1       1
64      2       1       2       48      0       0       0       0       0
65      2       2       1       26      0       1       1       1       1
66      2       2       1       14      0       1       1       1       1
67      2       1       2       48      0       0       0       0       0
68      2       2       1       13      1       1       1       1       1
69      2       1       1       20      0       1       1       1       1
70      2       2       1       37      1       1       0       0       1
71      2       2       1       25      1       1       1       1       1
72      2       2       1       20      0       0       0       0       0
73      2       1       2       58      0       1       0       0       0
74      2       1       1       38      1       1       0       0       0
75      2       2       1       55      1       1       1       1       1
76      2       2       1       24      1       1       1       1       1
77      2       1       2       36      1       1       0       0       1
78      2       1       1       36      0       1       1       1       1
79      2       2       2       60      1       1       1       1       1
80      2       1       1       15      1       0       0       1       1
81      2       2       1       25      1       1       1       1       0
82      2       2       1       35      1       1       1       1       1
83      2       2       1       19      1       1       0       1       1
84      2       1       2       31      1       1       1       1       1
85      2       2       1       21      1       1       1       1       1
86      2       2       2       37      0       1       1       1       1
87      2       1       1       52      0       1       1       1       1
88      2       2       1       55      0       0       1       1       0
89      2       1       1       19      1       0       0       1       1
90      2       1       1       20      1       0       1       1       1
91      2       1       1       42      1       0       0       0       0
92      2       2       1       41      1       1       1       1       1
93      2       2       1       52      0       0       0       0       0
94      2       1       2       47      0       1       1       0       1
95      2       1       1       11      1       1       1       1       1
96      2       1       1       14      0       0       0       1       0
97      2       1       1       15      1       1       1       1       1
98      2       1       1       66      1       1       1       1       1
99      2       2       1       34      0       1       1       0       1
100     2       1       1       43      0       0       0       0       0
101     2       1       1       33      1       1       1       0       1
102     2       1       1       48      1       1       0       0       0
103     2       2       1       20      0       1       1       1       1
104     2       1       2       39      1       0       1       0       0
105     2       2       1       28      0       1       0       0       0
106     2       1       2       38      0       0       0       0       0
107     2       2       1       43      1       1       1       1       1
108     2       2       2       39      0       1       1       1       1
109     2       2       1       68      0       1       1       1       1
110     2       2       2       63      1       1       1       1       1
111     2       2       1       31      1       1       1       1       1
;


data respl;
  set respw;
  array vs {4} v1-v4;
  do time=1 to 4;
  status=vs{time};
  output;
  end;
run;

proc genmod data=respl desc;
 class centre treat sex id;
 model status=centre treat sex age time bl / d=b;
 repeated subject=id / type=ind;
run;
  
proc genmod data=respl desc;
 class centre treat sex id;
 model status=centre treat sex age time bl / d=b;
 repeated subject=id / type=exch;
run;

proc glimmix data=respl;
 class centre treat sex id;
 model status=centre treat sex age time bl / s ddfm=bw d=b;
 random int / subject=id type=un;
run;

data epiw;
  input id  v1-v4 treat bl age;
cards;
1       5       3       3       3       0       11      31
2       3       5       3       3       0       11      30
3       2       4       0       5       0       6       25
4       4       4       1       4       0       8       36
5       7       18      9       21      0       66      22
6       5       2       8       7       0       27      29
7       6       4       0       2       0       12      31
8       40      20      23      12      0       52      42
9       5       6       6       5       0       23      37
10      14      13      6       0       0       10      28
11      26      12      6       22      0       52      36
12      12      6       8       4       0       33      24
13      4       4       6       2       0       18      23
14      7       9       12      14      0       42      36
15      16      24      10      9       0       87      26
16      11      0       0       5       0       50      26
17      0       0       3       3       0       18      28
18      37      29      28      29      0       111     31
19      3       5       2       5       0       18      32
20      3       0       6       7       0       20      21
21      3       4       3       4       0       12      29
22      3       4       3       4       0       9       21
23      2       3       3       5       0       17      32
24      8       12      2       8       0       28      25
25      18      24      76      25      0       55      30
26      2       1       2       1       0       9       40
27      3       1       4       2       0       10      19
28      13      15      13      12      0       47      22
29      11      14      9       8       1       76      18
30      8       7       9       4       1       38      32
31      0       4       3       0       1       19      20
32      3       6       1       3       1       10      30
33      2       6       7       4       1       19      18
34      4       3       1       3       1       24      24
35      22      17      19      16      1       31      30
36      5       4       7       4       1       14      35
37      2       4       0       4       1       11      27
38      3       7       7       7       1       67      20
39      4       18      2       5       1       41      22
40      2       1       1       0       1       7       28
41      0       2       4       0       1       22      23
42      5       4       0       3       1       13      40
43      11      14      25      15      1       46      33
44      10      5       3       8       1       36      21
45      19      7       6       7       1       38      35
46      1       1       2       3       1       7       25
47      6       10      8       8       1       36      26
48      2       1       0       0       1       11      25
49      102     65      72      63      1       151     22
50      4       3       2       4       1       22      32
51      8       6       5       7       1       41      25
52      1       3       1       5       1       32      35
53      18      11      28      13      1       56      21
54      6       3       4       0       1       24      41
55      3       5       4       3       1       16      32
56      1       23      19      8       1       22      26
57      2       3       0       1       1       25      21
58      0       0       0       0       1       13      36
59      1       4       3       2       1       12      37
;

data epil;
  set epiw;
  array vs {4} v1-v4;
  do time=1 to 4;
  nsz=vs{time};
  output;
  end;
run;

proc sort data=epil; by treat time; run;
proc boxplot data=epil;
  plot nsz*time / boxstyle=schematic;
  by treat;
run;

%inc 'c:\sasbook\macros\panelplot.sas';
%inc 'c:\sasbook\macros\template.sas';
%panelplot(igout=gseg,nrows=2);
  
proc genmod data=epil ;
 class id;
 model nsz= treat age time bl / d=p ;
 repeated subject=id / type=ind;
run;

proc genmod data=epil ;
 class id;
 model nsz= treat age time bl / d=p ;
 repeated subject=id / type=exch;
run;

proc sort data=epil; by id time; run;
proc glimmix data=epil ;
 class id;
 model nsz= treat age time bl /s ddfm=bw d=p ;
 random int/ subject=id type=un;
run;

/* Chapter 14 */
%setopts;

data melanoma;
  input weeks status$;
  censor=status='alive';
cards;
12.8    dead
15.6    dead
24.0    alive
26.4    dead
29.2    dead
30.8    alive
39.2    dead
42.0    dead
58.4    alive
72.0    alive
77.2    dead
82.4    dead
87.2    alive
94.4    alive
97.2    alive
106.0   alive
114.8   alive
117.2   alive
140.0   alive
168.0   alive
;

proc lifetest data=melanoma plots=(s);
  time weeks*censor(0);
run;

data leukemia;
 infile cards dsd missover;
  treatment=_n_;
  do until(days=.);
    input number$ @;
    censor=0;
    if indexc(number,'+') then censor=1;
    number=compress(number,'+');
    days=input(number,3.);
    if days~=. then output;
  end;
cards;
4, 5, 9, 10, 11, 12, 13, 23, 28, 28, 28, 29, 31, 32, 37, 41, 41, 57, 62, 74, 100, 139, 200+, 258+, 269+
8, 10, 10, 12, 14, 20, 48, 70, 75, 99, 103, 162, 169, 195, 220, 161+, 199+, 217+, 245
8, 10, 11, 23, 25, 25, 28, 28, 31, 31, 40, 48, 89, 124, 143, 12+, 159+, 190+, 196+, 197+, 205+, 219+
;

proc lifetest data=leukemia plots=(s);
  time days*censor(1);
  strata treatment / test=(all);
run;

data leukemia2;
 input age p_blasts p_inf p_lab maxtemp months status;
cards;
20      78      39      7       990     18      0
25      64      61      16      1030    31      1
26      61      55      12      982     31      0
26      64      64      16      100     31      0
27      95      95      6       980     36      0
27      80      64      8       1010    1       0
28      88      88      20      986     9       0
28      70      70      14      1010    39      1
31      72      72      5       988     20      1
33      58      58      7       986     4       0
33      92      92      5       980     45      1
33      42      38      12      984     36      0
34      26      26      7       982     12      0
36      55      55      14      986     8       0
37      71      71      15      1020    1       0
40      91      91      9       986     15      0
40      52      49      12      988     24      0
43      74      63      4       986     2       0
45      78      47      14      980     33      0
45      60      36      10      992     29      1
45      82      32      10      1016    7       0
45      79      79      4       1030    0       0
47      56      28      2       990     1       0
48      60      54      10      1002    2       0
50      83      66      19      996     12      0
50      36      32      14      992     9       0
51      88      70      8       982     1       0
52      87      87      7       986     1       0
53      75      68      13      980     9       0
53      65      65      6       982     5       0
56      97      92      10      992     27      1
57      87      83      19      1020    1       0
59      45      45      8       999     13      0
59      36      34      5       1038    1       0
60      39      33      7       988     5       0
60      76      53      12      982     1       0
61      46      37      4       1006    3       0
61      39      8       8       990     4       0
61      90      90      11      990     1       0
62      84      84      19      1020    18      0
63      42      27      5       1014    1       0
65      75      75      10      1004    2       0
71      44      22      6       990     1       0
71      63      63      11      986     8       0
73      33      33      4       1010    3       0
73      93      84      6       1020    4       0
74      58      58      10      1002    14      0
74      32      30      16      988     3       0
75      60      60      17      990     13      0
77      69      69      9       986     13      0
80      73      73      7       986     1       0
;


proc phreg data=leukemia2;
 model months*status(1)=age p_blasts p_inf p_lab maxtemp;
run;

proc phreg data=leukemia2;
 model months*status(1)=age p_blasts p_inf p_lab maxtemp / selection=b ;
run;

ods html;
ods graphics on;
proc phreg data=leukemia2;
 model months*status(1)=age ;
 assess var=(age) ph / resample ;
run;
ods graphics off;
ods html close;

data SHTD;
input ID Start Stop Event Age Year Surgery Transplant;
duration=stop-start;
cards;
1       0.0     50.0    1       -17.155 0.123   0       0
2       0.0     6.0     1       3.836   0.255   0       0
3       0.0     1.0     0       6.297   0.266   0       0
3       1.0     16.0    1       6.297   0.266   0       1
4       0.0     36.0    0       -7.737  0.490   0       0
4       36.0    39.0    1       -7.737  0.490   0       1
5       0.0     18.0    1       -27.214 0.608   0       0
6       0.0     3.0     1       6.5955  0.701   0       0
7       0.0     51.0    0       2.8693  0.780   0       0
7       51.0    675.0   1       2.8693  0.780   0       1
8       0.0     40.0    1       -2.650  0.835   0       0
9       0.0     85.0    1       -0.838  0.857   0       0
10      0.0     12.0    0       -5.498  0.862   0       0
10      12.0    58.0    1       -5.498  0.862   0       1
11      0.0     26.0    0       -0.019  0.873   0       0
11      26.0    153.0   1       -0.019  0.873   0       1
12      0.0     8.0     1       5.194   0.964   0       0
13      0.0     17.0    0       6.574   0.969   0       0
13      17.0    81.0    1       6.574   0.969   0       1
14      0.0     37.0    0       6.012   0.972   0       0
14      37.0    1387.0  1       6.012   0.972   0       1
15      0.0     1.0     1       5.815   0.991   1       0
16      0.0     28.0    0       1.448   1.070   0       0
16      28.0    308.0   1       1.448   1.070   0       1
17      0.0     36.0    1       -27.669 1.076   0       0
18      0.0     20.0    0       8.849   1.087   0       0
18      20.0    43.0    1       8.849   1.087   0       1
19      0.0     37.0    1       11.124  1.133   0       0
20      0.0     18.0    0       7.280   1.331   0       0
20      18.0    28.0    1       7.280   1.331   0       1
21      0.0     8.0     0       -4.657  1.339   0       0
21      8.0     1032.0  1       -4.657  1.339   0       1
22      0.0     12.0    0       -5.216  1.462   0       0
22      12.0    51.0    1       -5.216  1.462   0       1
23      0.0     3.0     0       10.357  1.528   0       0
23      3.0     733.0   1       10.357  1.528   0       1
24      0.0     83.0    0       3.800   1.566   0       0
24      83.0    219.0   1       3.800   1.566   0       1
25      0.0     25.0    0       -14.776 1.574   0       0
25      25.0    1800.0  0       -14.776 1.574   0       1
26      0.0     1401.0  0       -17.465 1.582   0       0
27      0.0     263.0   1       -39.214 1.591   0       0
28      0.0     71.0    0       6.023   1.684   0       0
28      71.0    72.0    1       6.023   1.684   0       1
29      0.0     35.0    1       2.434   1.785   0       0
30      0.0     16.0    0       -3.088  1.884   0       0
30      16.0    852.0   1       -3.088  1.884   0       1
31      0.0     16.0    1       6.886   1.895   0       0
32      0.0     17.0    0       16.408  1.911   0       0
32      17.0    77.0    1       16.408  1.911   0       1
33      0.0     51.0    0       0.903   2.157   0       0
33      51.0    1587.0  0       0.903   2.157   0       1
34      0.0     23.0    0       -7.447  2.198   0       0
34      23.0    1572.0  0       -7.447  2.199   0       1
35      0.0     12.0    1       -4.534  2.308   0       0
36      0.0     46.0    0       0.925   2.508   0       0
36      46.0    100.0   1       0.925   2.508   0       1
37      0.0     19.0    0       13.500  2.565   0       0
37      19.0    66.0    1       13.500  2.565   0       1
38      0.0     4.5     0       -6.530  2.593   0       0
38      4.5     5.0     1       -6.530  2.593   0       1
39      0.0     2.0     0       2.519   2.634   0       0
39      2.0     53.0    1       2.519   2.634   0       1
40      0.0     41.0    0       0.482   2.648   1       0
40      41.0    1408.0  0       0.482   2.648   1       1
41      0.0     58.0    0       -2.697  2.883   1       0
41      58.0    1322.0  0       -2.697  2.883   1       1
42      0.0     3.0     1       -11.559 2.888   0       0
43      0.0     2.0     1       -4.608  3.058   1       0
44      0.0     40.0    1       -5.421  3.165   1       0
45      0.0     1.0     0       -11.817 3.264   0       0
45      1.0     45.0    1       -11.817 3.264   0       1
46      0.0     2.0     0       0.611   3.277   1       0
46      2.0     996.0   1       0.611   3.277   1       1
47      0.0     21.0    0       -0.901  3.340   0       0
47      21.0    72.0    1       -0.901  3.340   0       1
48      0.0     9.0     1       8.036   3.348   0       0
49      0.0     36.0    0       -11.346 3.376   1       0
49      36.0    1142.0  0       -11.346 3.376   1       1
50      0.0     83.0    0       -2.114  3.376   1       0
50      83.0    980.0   1       -2.114  3.376   1       1
51      0.0     32.0    0       0.734   3.477   0       0
51      32.0    285.0   1       0.734   3.477   0       1
52      0.0     102.0   1       -6.752  3.565   0       0
53      0.0     41.0    0       -0.657  3.751   0       0
53      41.0    188.0   1       -0.657  3.751   0       1
54      0.0     3.0     1       -0.208  3.751   0       0
55      0.0     10.0    0       4.454   3.855   0       0
55      10.0    61.0    1       4.454   3.855   0       1
56      0.0     67.0    0       -9.257  3.923   0       0
56      67.0    942.0   0       -9.257  3.923   0       1
57      0.0     149.0   1       -6.735  3.951   0       0
58      0.0     21.0    0       0.016   3.978   1       0
58      21.0    343.0   1       0.016   3.978   1       1
59      0.0     78.0    0       -6.617  3.995   1       0
59      78.0    916.0   0       -6.617  3.995   1       1
60      0.0     3.0     0       1.054   4.131   0       0
60      3.0     68.0    1       1.054   4.131   0       1
61      0.0     2.0     1       4.564   4.175   0       0
62      0.0     69.0    1       -8.646  4.189   0       0
63      0.0     27.0    0       -15.340 4.197   0       0
63      27.0    842.0   0       -15.340 4.197   0       1
64      0.0     33.0    0       0.816   4.337   1       0
64      33.0    584.0   1       0.816   4.337   1       1
65      0.0     12.0    0       3.294   4.430   0       0
65      12.0    78.0    1       3.294   4.430   0       1
66      0.0     32.0    1       5.213   4.468   0       0
67      0.0     57.0    0       -28.449 4.476   0       0
67      57.0    285.0   1       -28.449 4.476   0       1
68      0.0     3.0     0       -2.760  4.517   0       0
68      3.0     68.0    1       -2.760  4.517   0       1
69      0.0     10.0    0       -0.011  4.668   0       0
69      10.0    670.0   0       -0.011  4.668   0       1
70      0.0     5.0     0       5.002   4.712   0       0
70      5.0     30.0    1       5.002   4.712   0       1
71      0.0     31.0    0       -0.591  4.805   0       0
71      31.0    620.0   0       -0.591  4.805   0       1
72      0.0     4.0     0       -21.273 4.871   0       0
72      4.0     596.0   0       -21.273 4.871   0       1
73      0.0     27.0    0       8.331   4.947   0       0
73      27.0    90.0    1       8.331   4.947   0       1
74      0.0     5.0     0       -18.834 4.966   0       0
74      5.0     17.0    1       -18.834 4.966   0       1
75      0.0     2.0     1       4.181   4.997   0       0
76      0.0     46.0    0       4.085   5.010   1       0
76      46.0    545.0   0       4.085   5.010   1       1
77      0.0     21.0    1       -6.888  5.016   0       0
78      0.0     210.0   0       0.704   5.092   0       0
78      210.0   515.0   0       0.704   5.092   0       1
79      0.0     67.0    0       5.782   5.166   0       0
79      67.0    96.0    1       5.782   5.166   0       1
80      0.0     26.0    0       -1.555  5.183   1       0
80      26.0    482.0   0       -1.555  5.183   1       1
81      0.0     6.0     0       4.893   5.284   0       0
81      6.0     445.0   0       4.893   5.284   0       1
82      0.0     428.0   0       -18.798 4.085   0       0
83      0.0     32.0    0       5.309   5.317   0       0
83      32.0    80.0    1       5.309   5.317   0       1
84      0.0     37.0    0       -5.281  5.333   0       0
84      37.0    334.0   1       -5.281  5.333   0       1
85      0.0     5.0     1       -0.019  5.352   0       0
86      0.0     8.0     0       0.920   5.415   0       0
86      8.0     397.0   0       0.920   5.415   0       1
87      0.0     60.0    0       -1.747  5.470   0       0
87      60.0    110.0   1       -1.747  5.470   0       1
88      0.0     31.0    0       6.363   5.489   0       0
88      31.0    370.0   0       6.363   5.489   0       1
89      0.0     139.0   0       3.047   5.511   0       0
89      139.0   207.0   1       3.047   5.511   0       1
90      0.0     160.0   0       4.033   5.514   1       0
90      160.0   186.0   1       4.033   5.514   1       1
91      0.0     340.0   1       -0.405  5.533   0       0
92      0.0     310.0   0       -3.017  5.572   0       0
92      310.0   340.0   0       -3.017  5.572   0       1
93      0.0     28.0    0       -0.249  5.777   0       0
93      28.0    265.0   0       -0.249  5.777   0       1
94      0.0     4.0     0       -4.159  5.955   1       0
94      4.0     165.0   1       -4.158  5.955   1       1
95      0.0     2.0     0       -7.718  5.977   0       0
95      2.0     16.0    1       -7.718  5.977   0       1
96      0.0     13.0    0       -21.350 6.010   0       0
96      13.0    180.0   0       -21.350 6.010   0       1
97      0.0     21.0    0       -24.383 6.144   0       0
97      21.0    131.0   0       -24.383 6.144   0       1
98      0.0     96.0    0       -19.370 6.204   0       0
98      96.0    109.0   0       -19.370 6.204   0       1
99      0.0     21.0    1       1.834   6.234   0       0
100     0.0     38.0    0       -12.939 6.396   1       0
100     38.0    39.0    0       -12.939 6.396   1       1
101     0.0     31.0    0       1.517   6.418   0       0
102     0.0     11.0    0       -7.608  6.472   0       0
103     0.0     6.0     1       -8.684  -0.049  0       0
;

proc phreg data=SHTD;
  model (start,stop)*event(0)=Transplant / rl;
run;

proc phreg data=SHTD;
  model (start,stop)*event(0)=Age Year Surgery Transplant / rl;
run;

proc tphreg data=SHTD;
  model (start,stop)*event(0)=Age Year Surgery Transplant year*transplant / rl;
run;

proc phreg data=SHTD;
  model (start,stop)*event(0)=Age Year Surgery  / rl;
  strata transplant;
  baseline out=phout survival=sfest / method=ch; 
run;

symbol1 v=none i=join;
symbol2 v=none i=join l=2;
proc gplot data=phout;
  plot sfest*stop=transplant;
run;

/* Chapter 15 */
%setopts;

data heads;
  input x1-x4;
cards; 
191     155     179     145
195     149     201     152
181     148     185     149
183     153     188     149
176     144     171     142
208     157     192     152
189     150     190     149
197     159     189     152
188     152     197     159
192     150     187     151
179     158     186     148
183     147     174     147
174     150     185     152
190     159     195     157
188     151     187     158
163     137     161     130
195     155     183     158
186     153     173     148
181     145     182     146
175     140     165     137
192     154     185     152
174     143     178     147
176     139     176     143
197     167     200     158
190     163     187     150
;

proc princomp data=heads;
 var x1 x2;
run;

data lifeexp;
  input country $ 1-21 x1-x8;
cards;
Algeria                 63      51      30      13      67      54      34      15
Cameroon                34      29      13      5       38      32      17      6
Madagascar              38      30      17      7       38      34      20      7
Mauritius               59      42      20      6       64      46      25      8
Reunion                 56      38      18      7       62      46      25      10
Seychelles              62      44      24      7       69      50      28      14
South Africa (C)        50      39      20      7       55      43      23      8
South Africa (W)        65      44      22      7       72      50      27      9
Tunisia                 56      46      24      11      63      54      33      19
Canada                  69      47      24      8       75      53      29      10
Cost Rica               65      48      26      9       68      50      27      10
Dominican Republic      64      50      28      11      66      51      29      11
El Salvador             56      44      25      10      61      48      27      12
Greenland               60      44      22      6       65      45      25      9
Grenada                 61      45      22      8       65      49      27      10
Guatemala               49      40      22      9       51      41      23      8
Honduras                59      42      22      6       61      43      22      7
Jamaica                 63      44      23      8       67      48      26      9
Mexico                  59      44      24      8       63      46      25      8
Nicaragua               65      48      28      14      68      51      29      13
Panama                  65      48      26      9       67      49      27      10
Trinidad (62)           64      63      21      7       68      47      25      9
Trinidad (67)           64      43      21      6       68      47      24      8
United States (66)      67      45      23      8       74      51      28      10
United States (NW66)    61      40      21      10      67      46      25      11
United States (W66)     68      46      23      8       75      52      29      10
United States (67)      67      45      23      8       74      51      28      10
Argentina               65      46      24      9       71      51      28      10
Chile                   59      43      23      10      66      49      27      12
Columbia                58      44      24      9       62      47      25      10
Ecuador                 57      46      28      9       60      49      28      11
;

proc princomp data=lifeexp cov; 
 var x1-x8;
run;

ods rtf style=minimal;
ods graphics on;
proc princomp data=lifeexp;
 var x1-x8;
run;
ods graphics off;
ods rtf close;


proc princomp data=lifeexp noprint out=pcout;
  var x1-x8;
run;

proc gplot data=pcout;
  plot prin2*prin1;
  symbol1 v=dot pointlabel=(j=r position=middle '#country');
run;

data druguse (type=corr);
  infile cards missover;
  input _name_ $ x1-x13;
  _type_='CORR';
cards;
X1      1                                                                                               
X2      0.447   1                                                                                       
X3      0.442   0.619   1                                                                               
X4      0.435   0.604   0.583   1                                                                       
X5      0.114   0.068   0.053   0.115   1                                                               
X6      0.203   0.146   0.139   0.258   0.349   1                                                       
X7      0.091   0.103   0.110   0.122   0.209   0.221   1                                               
X8      0.082   0.063   0.066   0.097   0.321   0.355   0.201   1                                       
X9      0.513   0.445   0.365   0.482   0.186   0.315   0.150   0.154   1                               
X10     0.304   0.318   0.240   0.368   0.303   0.377   0.163   0.219   0.534   1                       
X11     0.245   0.203   0.183   0.255   0.272   0.323   0.310   0.288   0.301   0.302   1               
X12     0.101   0.088   0.074   0.139   0.279   0.367   0.232   0.320   0.204   0.368   0.304   1       
X13     0.245   0.199   0.184   0.293   0.278   0.545   0.232   0.314   0.394   0.467   0.392   0.511   1
;
proc princomp data=druguse; 
run;

data water;                            
    input location $ 1 Town $ 3-19 Mortal Hardness;
cards;
S Bath             1247  105 
N Birkenhead       1668  17  
S Birmingham       1466  5   
N Blackburn        1800  14  
N Blackpool        1609  18  
N Bolton           1558  10  
N Bootle           1807  15  
S Bournemouth      1299  78  
N Bradford         1637  10  
S Brighton         1359  84  
S Bristol          1392  73  
N Burnley          1755  12  
S Cardiff          1519  21  
S Coventry         1307  78  
S Croydon          1254  96  
N Darlington       1491  20  
N Derby            1555  39  
N Doncaster        1428  39  
S East Ham         1318  122 
S Exeter           1260  21  
N Gateshead        1723  44  
N Grimsby          1379  94  
N Halifax          1742  8   
N Huddersfield     1574  9   
N Hull             1569  91  
S Ipswich          1096  138 
N Leeds            1591  16  
S Leicester        1402  37  
N Liverpool        1772  15  
N Manchester       1828  8   
N Middlesbrough    1704  26  
N Newcastle        1702  44  
S Newport          1581  14  
S Northampton      1309  59  
S Norwich          1259  133 
N Nottingham       1427  27  
N Oldham           1724  6   
S Oxford           1175  107 
S Plymouth         1486  5   
S Portsmouth       1456  90  
N Preston          1696  6   
S Reading          1236  101 
N Rochdale         1711  13  
N Rotherham        1444  14  
N St Helens        1591  49  
N Salford          1987  8   
N Sheffield        1495  14  
S Southampton      1369  68  
S Southend         1257  50  
N Southport        1587  75  
N South Shields    1713  71  
N Stockport        1557  13  
N Stoke            1640  57  
N Sunderland       1709  71  
S Swansea          1625  13  
N Wallasey         1625  20  
S Walsall          1527  60  
S West Bromwich    1627  53  
S West Ham         1486  122
S Wolverhampton    1485  81  
N York             1378  71  
;

proc cluster data=water method=single std outtree=single;
 var mortal hardness;
 id town;
 copy location;
run;

axis1 value=(h=.7) label=(a=90) ;
proc tree data=single hor vaxis=axis1;
run;

proc cluster data=water method=complete std outtree=complete;
 var mortal hardness;
 id town;
 copy location;
run;
proc tree data=complete hor vaxis=axis1;
run;

proc cluster data=water method=average std outtree=average;
 var mortal hardness;
 id town;
 copy location;
run;
proc tree data=average hor vaxis=axis1;
run;

proc tree data=complete n=2 noprint out=comp2c;
 copy mortal hardness location town;
run;
proc tree data=average n=2 noprint out=avge2c;
 copy mortal hardness location town;
run;

symbol1 v=none pointlabel=(position=middle '#cluster');
proc gplot data=comp2c;
  plot mortal*hardness;
run;
proc gplot data=avge2c;
  plot mortal*hardness;
run;

symbol1 v='1' pointlabel=(h=.7 '#town');
symbol2 v='2' pointlabel=(h=.7 '#town');
proc gplot data=avge2c;
  plot mortal*hardness=cluster /nolegend;
run;

proc freq data=comp2c;
  tables cluster*location;
run;
proc freq data=avge2c;
  tables cluster*location;
run;

/***********************************************************************
*   macros                                                             *
***********************************************************************/


%macro dotplot(data=_last_,xvar=,label=);
proc sort data=&data out=_temp_; by &xvar; run;
data _temp_;
  set _temp_ nobs=numobs;
  if _n_=1 then call symput('numobs',numobs);
  y=_n_;
run;

data fmtcntl;
  set _temp_;
  start=y;
  fmtname='y_format';
  label=&label;
run;
proc format cntlin=fmtcntl;
run;

symbol1 v=dot i=none;
axis1 order=1 to &numobs by 1 label=none offset=(2,2) pct;
proc gplot data=_temp_;
  plot y*&xvar=1 /vref=1 to &numobs by 1 lv=33 vaxis=axis1;
  format y y_format.;
run;
quit;
%mend dotplot;

%macro plotmat(data,varlist);

data _null_;
  length vlist $300.  varname $32.;
  retain vlist '';
 set &data;;
 array vall {*} &varlist;
 nvars=dim(vall);
 maxlen=0;
 do i=1 to dim(vall);
   call vname(vall{i},varname);
   vlist=trim(vlist)||' '||varname;
   maxlen=max(length(varname),maxlen);
 end;
 texthgt=int(90/maxlen);
 call symput('nvars',nvars);
 call symput('varlist',vlist);
 call symput('texthgt',texthgt);
stop;
run;

proc datasets lib=work mt=cat nolist nowarn;
  delete tempcat;
run;

axis99 label=(a=90);
symbol1 h=&nvars;
goptions nodisplay;
%do row=1 %to &nvars;
%do col=1 %to &nvars;
  %let rvar=%scan(&varlist,&row);
  %let cvar=%scan(&varlist,&col);
  %if &row=&col %then %do;
proc gslide gout=tempcat ;
 note h=&texthgt.pct ls=40pct j=c "&rvar" ;
run;
  %end;
  %else %do;
proc gplot data=&data gout=tempcat;
  plot &rvar*&cvar /vaxis=axis99 hminor=0 vminor=0;
run;
%end;
%end;
%end;

goptions display;
proc greplay igout=tempcat nofs;
%template(nrows=&nvars,ncols=&nvars);
  tplay 
%let nvarssq=%eval(&nvars*&nvars);
%do i=1 %to &nvarssq;
  &i:&i 
%end;
%str(;);
run;
symbol1 h=1;
%mend plotmat;


%macro panelplot(igout=,nrows=1,ncols=1,numbering=across);
goptions display;
proc greplay igout=&igout nofs;
%template(nrows=&nrows,ncols=&ncols,numbering=&numbering);
  tplay 
%let nplots=%eval(&nrows*&ncols);
%do i=1 %to &nplots;
  &i:&i 
%end;
%str(;);
run;
%mend panelplot;

%macro template(nrows=1,ncols=1,numbering=across);
/* Constructs a template nrows by ncols with panels numbered across by default.
   Also incorporates the TC and TEMPLATE statements, so that only the PROC and 
   TREPLAY statements are needed.
   Example use:
proc greplay igout=myfig nofs;
  %template(nrows=2,ncols=3);
  treplay 1:1 2:2 3:3 4:4 5:5 6:6;
run;
Written by Geoff Der September 2003
*/
tc _tmplcat_;
tdef temp 
%let hght=%eval(100/&nrows);
%let wdth=%eval(100/&ncols);
%let panel=1;
%if %upcase(&numbering)=DOWN %then %do;
 %do col=0 %to %eval(&ncols-1);
  %do row=&nrows %to 1 %by -1;
  %let llx=%eval(&col*&wdth);  %let ulx=&llx;
  %let uly=%eval(&row*&hght);  %let ury=&uly;
  %let lly=%eval(&uly-&hght);  %let lry=&lly;
  %let lrx=%eval(&llx+&wdth);  %let urx=&lrx;
 &panel / llx= &llx ulx=&ulx uly=&uly ury=&ury lly=&lly lry=&lry lrx=&lrx urx=&urx 
  %let panel=%eval(&panel+1);
  %end;
 %end;
%end;
  %else %do;
  %do row=&nrows %to 1 %by -1;
  %do col=0 %to %eval(&ncols-1);
  %let llx=%eval(&col*&wdth);  %let ulx=&llx;
  %let uly=%eval(&row*&hght);  %let ury=&uly;
  %let lly=%eval(&uly-&hght);  %let lry=&lly;
  %let lrx=%eval(&llx+&wdth);  %let urx=&lrx;
 &panel / llx= &llx ulx=&ulx uly=&uly ury=&ury lly=&lly lry=&lry lrx=&lrx urx=&urx 
  %let panel=%eval(&panel+1);
  %end;
 %end;
%end;
%str(;);
template temp;
%mend template;

%macro setopts;
goptions reset=all;
goptions device=win target=winprtm rotate=landscape ftext=swiss;
options nodate nonumber center;
title;
ods ptitle=on;
%mend;




