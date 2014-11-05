

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

proc sgplot data=drinking;
  scatter x=alcohol y=cirrhosis / datalabel=country;
run;

/*
symbol1 pointlabel=('#country');
proc gplot data=drinking;
  plot cirrhosis*alcohol ;
run;
*/

ods graphics on;
proc reg data=drinking;
  model cirrhosis=alcohol;
run;
ods graphics off;

/*
proc sgplot data=drinking;
  scatter x=alcohol y=cirrhosis ;
  reg x=alcohol y=cirrhosis / clm;
run;
*/

proc reg data=drinking;
  model cirrhosis=alcohol;
  where country ne 'France';
run; quit;

proc reg data=drinking;
  model cirrhosis=alcohol;
  output out=regout predicted=pred student=zres h=leverage;
run; quit;

proc print data=regout;
  where abs(zres)>2 or leverage>.3;
run;

data universe;
 input id Galaxy $ Velocity Distance;
datalines; 
1  NGC0300  133  2.00
2  NGC0925  664  9.16
3  NGC1326A  1794  16.14
4  NGC1365  1594  17.95
5  NGC1425  1473  21.88
6  NGC2403  278  3.22
7  NGC2541  714  11.22
8  NGC2090  882  11.75
9  NGC3031  80  3.63
10  NGC3198  772  13.80
11  NGC3351  642  10.00
12  NGC3368  768  10.52
13  NGC3621  609  6.64
14  NGC4321  1433  15.21
15  NGC4414  619  17.70
16  NGC4496A  1424  14.86
17  NGC4548  1384  16.22
18  NGC4535  1444  15.78
19  NGC4536  1423  14.93
20  NGC4639  1403  21.98
21  NGC4725  1103  12.36
22  IC4182  318  4.49
23  NGC5253  232  3.15
24  NGC7331  999  14.72
;

proc sgplot data=universe;
  scatter y=velocity x=Distance;
  yaxis label='velocity (kms)';
  xaxis label='Distance (mega-parsec)'; 
run;

/*
proc gplot data=universe;
  plot velocity*Distance;
  label velocity='velocity (kms)' distance='Distance (mega-parsec)'; 
run;
*/

ods graphics on;
proc reg data=universe;
  model velocity= distance / noint;
run;
ods graphics off;
quit;

proc reg data=universe;
  model velocity= distance / noint;
  output out=regout predicted=pred student=zres h=leverage;
run; quit;

proc print data=regout;
  where leverage>.08;
run;

