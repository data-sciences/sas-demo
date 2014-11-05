ods graphics on;

data universe;
  infile 'c:\handbook3\datasets\universe.dat';
  input id Galaxy $ Velocity Distance;
run;

data tyres;
  infile 'c:\handbook3\datasets\tyres.dat';
  input id loss hard tens;
run;

data usair;
  infile 'c:\handbook3\datasets\usair.dat';
  input city $16. hiso2 temperature factories population windspeed rain rainydays;
run;

proc sgplot data=universe;
  loess y=velocity x=distance / clm ;
run;

proc gam data=universe;
  model velocity=loess(distance) / method=gcv;
run;

proc sgscatter data=tyres;
  compare y=loss x=(hard tens) /loess;
run;

/*
axis1 order=0 to 400 by 100;
proc gplot data=tyres;
  plot loss*(hard tens)/ vaxis=axis1;
run;
*/

proc g3d data=tyres;
  scatter tens*hard=loss /rotate=120;
run;

proc gam data=tyres plots;
  model loss= loess(hard) loess(tens) / method=gcv;
run;

proc logistic data=usair desc;
 model hiso2=temperature factories population windspeed rain rainydays /selection=b;
run;

proc sgplot data=usair;
  vbox population / category=hiso2 datalabel=city;
run;
proc sgplot data=usair;
  vbox rain / category=hiso2 datalabel=city;
run;

/*
proc sort data=usair;
  by hiso2;
run;
proc boxplot data=usair;
 plot (population rain)*hiso2 /boxstyle=schematicid;
 id city;
run;
*/

data usair;
  set usair;
  if city=:'Chicago' then delete;
run;

proc sgplot data=usair;
  pbspline y=hiso2 x=population / clm ;
  yaxis min=0 max=1;
run;
proc sgplot data=usair;
  pbspline y=hiso2 x=rain / clm ;
  yaxis min=0 max=1;
run;

/*
symbol1 i=sm70s v='I' f=swiss;
proc gplot data=usair;
 plot hiso2*(population rain);
run;
*/

proc gam data=usair;
 model hiso2(desc)=spline(rain,df=2) /dist=binary ;
 output out=gamout p;
run;

data gamout;
  set gamout;
  odds=exp(P_hiso2);
  pred=odds/(1+odds);
run;

proc sgplot data=gamout;
  scatter y=pred x=rain;
run;

/*
goptions reset=symbol;
proc gplot data=gamout;
 plot pred*rain;
run;
*/

