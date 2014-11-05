ods graphics on;

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

data slimmingclub;
  infile 'c:\handbook3\datasets\slimmingclub.dat';
  input idno team $ startweight weightnow;
run;

data slimmingclub2;
  infile 'c:\handbook3\datasets\slimmingclub2.dat';
  input name $ 1-18 team $ 20-25 startweight 27-29 weightnow 31-33;
run;

data slimmingclub2;
  infile 'c:\handbook3\datasets\slimmingclub2.dat';
  input name $19. team $7. startweight 4. weightnow 3.;
run;

data days;
input day ddmmyy8.;
cards;
231090
23/10/90
23 10 90
23101990
;
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

data slimmingclub;
  set slimmingClub;
  weightloss=startweight-weightnow;
run;

data women;
  set bodyfat;
  if sex='F';
run;

proc sgplot data=bodyfat;
  scatter y=pctfat x=age;
run;
proc gplot data=bodyfat;
  plot pctfat*age;
run;

proc sgplot data=bodyfat;
  scatter y=pctfat x=age /group=sex;
run;

symbol1 v=circle;
symbol2 v=triangle;
proc gplot data=bodyfat;
  plot pctfat*age=sex;
run;

proc sgplot data=bodyfat;
  reg y=pctfat x=age ;
  loess y=pctfat x=age / nomarkers;
run;

data bodyfat;
  set bodyfat;
  decade=int(age/10);
run;

proc sgplot data=bodyfat;
  vline decade / response=pctfat stat=mean limitstat=stddev;
run;

proc sgplot data=bodyfat;
  vbar decade / response=pctfat stat=mean limitstat=stddev;
run;

proc sgplot data=bodyfat;
  vbox pctfat / category=sex;
run;

ods rtf;
proc print data=bodyfat;
proc corr data=bodyfat;
run;
ods rtf close;

proc template;
  list styles;
run;

data bodyfat;
  set bodyfat;
  label pctfat='Fat as % of body mass';
run;

proc format;
  value $sex 'M'='Male' 'F'='Female';
run;

proc sgplot data=bodyfat;
  scatter y=pctfat x=age /group=sex;
  format sex $sex.;
  label pctfat='Fat as % of body mass';
run;


data bodyfat;
  set bodyfat;
  if upcase(sex)='M' then gender=1;
     else gender=2;
run;

proc format;
  value gender 1='Male' 2='Female';
run;

proc sgplot data=bodyfat;
  scatter y=pctfat x=age /group=gender;
  format gender gender.;
run;

