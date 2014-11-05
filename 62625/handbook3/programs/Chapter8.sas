ods graphics on;

data ghq;
  infile 'c:\handbook3\datasets\ghq.dat' expandtabs;
  input ghq sex $ cases noncases;
  total=cases+noncases;
  prcase=cases/total;
run;

proc sgplot data=ghq;
  scatter y=prcase x=ghq;
run;

/*
proc gplot data=ghq;
  plot prcase*ghq;
run;
*/

proc logistic data=ghq;
   model cases/total=ghq;
   output out=lout p=lpred;
run;

proc sort data=lout;
  by ghq;
run;

proc sgplot data=lout;
 series y=lpred x=ghq / legendlabel='Logistic';
 reg y=prcase x=ghq / legendlabel='Linear' lineattrs=(pattern=dash);
run;

/*
symbol1 i=join v=none l=1;
symbol2 i=rl v=circle l=2;
proc gplot data=lout;
  plot (lpred prcase)*ghq /overlay;
run;
*/

proc logistic data=ghq;
  class sex;
  model cases/total=sex ghq; 
run;

data plasma;
  infile 'c:\handbook3\datasets\plasma.dat';
  input fibrinogen gamma esr;
run;

proc logistic data=plasma desc;
  model esr=fibrinogen gamma fibrinogen*gamma / selection=backward;
run;

proc logistic data=plasma desc plots=effect;
  model esr=fibrinogen;
run;

/* 
*or .....;
proc logistic data=plasma desc;
  model esr=fibrinogen;
  output out=lout p=lpred;
run;

proc sort data=lout;
  by fibrinogen;
run;

proc sgplot data=lout noautolegend;
  series y=lpred x=fibrinogen;
  scatter y=esr x=fibrinogen;
run;
*/

/*
symbol1 i=none v=circle;
symbol2 i=join v=none;
proc gplot data=lout;
  plot (esr lpred)*fibrinogen /overlay ;
run;
*/

data diy;
  infile 'c:\handbook3\datasets\diy.dat' expandtabs;
  input y1-y6 / n1-n6;
  length work $9.;
  work='Skilled';
  if _n_ > 2 then work='Unskilled';
  if _n_ > 4 then work='Office';
  if _n_ in(1,3,5) then tenure='rent';
                   else tenure='own';
  array yall {6} y1-y6;
  array nall {6} n1-n6;
  do i=1 to 6;
    if i>3 then type='house';
	       else type='flat';
    agegrp=1;
	if i in(2,5) then agegrp=2;
	if i in(3,6) then agegrp=3;
    yes=yall{i};
	no=nall{i};
	total=yes+no;
	prdiy=yes/total;
	output;
  end;
  drop i y1--n6;
run;

proc print data=diy;
run;

proc tabulate data=diy order=data f=6.2;
 class work tenure type agegrp;
 var prdiy;
 table work*tenure all,
       (type*agegrp all)*prdiy*mean;
run;

proc logistic data=diy;
  class work tenure type agegrp /param=ref ref=first;
  model yes/total=work tenure type agegrp / selection=backward;
run;

data backpain;
  infile 'C:\handbook3\DATASETS\backpain.dat';
  input pair status$ driver suburb;
run;

proc logistic data=backpain;
  model status=driver suburb ;
  strata pair;
run;

* or using differences method;
proc sort data=backpain;
  by pair status;
run;

data painpairs;
  set backpain;
  ldriver=lag(driver);
  lsuburb=lag(suburb);
  drdiff=ldriver-driver;
  subdiff=lsuburb-suburb;
  outcome=1;
  if status='control' then output;
run;

proc logistic data=painpairs;
  model outcome=drdiff subdiff /noint;
run;

