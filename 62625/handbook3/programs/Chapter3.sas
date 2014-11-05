
data water;
    infile 'c:\handbook3\datasets\water.dat';
    input flag $ 1 Town $ 2-18 Mortal 19-22 Hardness 25-27;
    if flag='*' then location='north';
        else location='south';
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

