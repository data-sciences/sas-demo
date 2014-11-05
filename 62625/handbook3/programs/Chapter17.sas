ods graphics on;

data usair;
  infile 'c:\handbook3\datasets\usair2.dat' expandtabs;
  input city $16. so2 temperature factories population windspeed rain rainydays;
run;

proc print;
run;

proc univariate data=usair ;
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
run;
goptions htext=.8;
axis1 label=(a=90);
proc tree horizontal vaxis=axis1;
run;

proc cluster data=usair2 method=complete ccc std outtree=complete;
  var temperature--rainydays;
  id city;
  copy so2;
proc tree horizontal vaxis=axis1;
run;

proc cluster data=usair2 method=average ccc std outtree=average;
  var temperature--rainydays;
  id city;
  copy so2;
proc tree horizontal vaxis=axis1;
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

proc sgplot data=pcout;
  scatter y=prin1 x=prin2 / markerchar=cluster;
run;

/*
proc gplot data=pcout;
  symbol1 v=none pointlabel=("#cluster");
  plot prin1*prin2=cluster;
run;
*/

proc sgplot data=clusters;
  vbox so2 / category=cluster;
run;

/*
goptions reset=symbol;
proc boxplot data=clusters;
 plot so2*cluster;
run;
*/

proc glm data=clusters;
  class cluster;
  model so2=cluster ;
run;

