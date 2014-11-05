
*Exercise 2.1.1;

proc sort data=water;                    
  by location;
run;
proc boxplot data=water;
  plot (mortal hardness)*location;
run;


*Exercise 2.1.4;

proc sort data=water;                   
  by location;
run;
proc kde data=water;
  bivar mortal hardness /plots=surface;
  by location;
run;


*Exercise 2.1.5;

proc sgplot data=water;                   
  reg y=mortal x=hardness /group=location;
run;


*Exercise 3.2.1;

proc freq data=pistons order=data noprint;             
  tables machine*site / out=tabout outexpect outpct;
  weight n;
run;
data resids;
  set tabout;
  r=(count-expected)/sqrt(expected);
  radj=r/sqrt((1-percent/pct_row)*(1-percent/pct_col));
run;
proc tabulate data=resids;
  class machine site;
  var r radj;
  table machine,
        site*r;
  table machine,
        site*radj;
run;


*Exercise 4.3.1;

proc sgplot data=cortisol;
  vbox cortisol /category=group;
run;
data cortisol;
  set cortisol;
  logcortisol=log(cortisol);
run;
proc glm data=cortisol;
  class group;
  model logcortisol=group / solution;
run;


*Exercise 5.2.1;

proc tabulate data=genotypes f=5.1;
  class gl gm;
  var weight;
  table gl,
        gm*weight*(mean std n);
run;


*Exercise 5.2.3;

proc glm data=genotypes;
 class gl gm;
 model weight=gl|gm / ss1;
run;
proc glm data=genotypes;
 class gl gm;
 model weight=gm|gl / ss1;
run;


*Exercise 6.2.2;

data universe;
  set universe;
  distsqd=distance**2;
run;
proc reg data=universe;                             
  model velocity= distance distsqd / noint;
  output out=universe predicted=qpred  ;
run; 
proc sort data=universe;
  by distance;
run;
proc sgplot data=universe noautolegend;
  scatter y=velocity x=distance ;
  series y=lpred x=distance;
  series y=qpred x=distance / lineattrs=(pattern=2);
  xaxis min=0;
  yaxis min=0;
run;


*Exercise 6.4.1;

proc sgplot data=expend;
  scatter y=percent x=expend /datalabel=region;
run;

* or ....;
proc gplot data=expend;
  plot percent*expend;
  symbol1 v=dot pointlabel=('#region' j=r position=middle);
run;


*Exercise 7.2.1;

proc sgplot data=peanuts;                    
  reg y=percent x=level;
run; 


*Exercise 8.1.1;

proc logistic data=ghq;
   class sex;
   model cases/total=ghq sex ghq*sex;
   output out=ghq2 predicted=pr;
run;
proc sgplot data=ghq2;
  series y=pr x=ghq / group=sex;
run;

*Exercise 8.4.1;

data roles;
  infile 'c:\handbook3\datasets\role.dat';
  input Years Agreem Disagreem Agreef Disagreef;
  mprob=agreem/(agreem+disagreem);
  fprob=agreef/(agreef+disagreef);
run;
proc sgplot data=roles;
  scatter y=mprob x=years / markerattrs=(symbol=circle);
  scatter y=fprob x=years;
run;

*Exercise 9.3.1;

data bladder;
  infile 'c:\handbook3\datasets\bladder.dat';
  input id time tum n;
  logtime=log(time);
run;
proc genmod data=bladder;
  model n=tum / dist=p offset=logtime;
run;

*Exercise 12.1.1;

data pndep2;
  set pndep2;
  zdep=dep;
run;
proc sort data=pndep2;
  by time;
run;
proc stdize data=pndep2 out=pndep2;
  var zdep;
  by time;
run;
proc sgpanel data=pndep2 noautolegend;
   panelby group / rows=2;
   series y=zdep x=time /group=idno;
run;
* or ....;
symbol1 i=join v=none l=1 r=27;
symbol2 i=join v=none l=2 r=34;
proc gplot data=pndep2;
   plot zdep*time=idno / skipmiss;
run;

*Exercise 12.2.1;

data pip;
  infile 'c:\handbook3\datasets\phos.dat';
  input id group p0 p05 p1 p15 p2-p5;
run;
data pipl;
  set pip;
  array ps {*} p0--p5;
  array t{8} t1-t8 (0 .5 1 1.5 2 3 4 5);
  do i=1 to 8;
    time=t{i};
    pip=ps{i};
    output;
  end;
run;
proc sgpanel data=pipl noautolegend;
   panelby group / rows=2;
   series y=pip x=time /group=id;
   colaxis type=linear values=(0 to 2 by 0.5 3 to 5 by 1);
run;

* or .... ;

proc sort data=pipl;
 by group id;
run;
proc gplot data=pipl uniform;
 plot pip*time=id /nolegend ;
 by group;
 symbol1 i=join v=none r=50;
run;

*Exercise 13.3.1;

proc mixed data=pndep2 covtest noclprint;
  class group idno;
  model dep=group|time /s ddfm=bw;
  random int time / sub=idno type=un;
run;

*Exercise 14.2.1;

data respw;
  infile 'c:\handbook3\datasets\resp.dat'  ;
  input id centre treat sex age bl v1-v4;
run;
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

*Exercise 15.2.1;

infile 'c:\handbook3\datasets\glioma.dat';
 input id age sex $ group $ event $ time;
 if event='FALSE' then censor=1;
    else censor=0;
run;
proc lifetest data=glioma plots=(s);
   time time*censor(1);
   strata group;
run;

*Exercise 17.2.1;

data pottery;
  infile 'c:\handbook3\datasets\pottery.dat' expandtabs;
  input id Kiln Al2O3 Fe2O3 MgO CaO Na2O K2O TiO2 MnO BaO;
run;
proc cluster data=pottery method=average ccc std outtree=pottree;
  var Al2O3 -- BaO;
  id id;
  copy kiln;
run;
proc tree horizontal vaxis=axis1;
axis1 label=none;
run;

*Exercise 18.2.1;

data sids;
  infile 'c:\handbook3\datasets\sids.dat' expandtabs;
  input Group HR BW Factor68 Gestage;
run;
proc discrim data=sids out=discout canonical;
  class group;
  var bw Factor68;
  ods output LinearDiscFunc=func;
run;
data func;
  set func;
  _3=_1-_2;
run;
proc print; 
var variable _3;
format _3 12.8;
run;
data discout;
  set discout;
  pbw=((factor68*16.07705412)+ 0.50619161)/ 0.00194756;
run;
proc sort data=discout; by factor68; run;
proc sgplot data=discout;
  scatter y=bw x=factor68 / group=_into_;
  series y=pbw x= factor68;
run;

*Exercise 19.3.1;

proc corresp data=colour ;
 var FairHair -- BlackHair;
 id rowid;
run;
