ods graphics on;


data pndep(keep=idno group x1-x8) pndep2(keep=idno group time dep);
  infile 'c:\handbook3\datasets\channi.dat';
  input group x1-x8;
  idno=_n_;
  array xarr {8} x1-x8;
  do i=1 to 8;
    if xarr{i}=-9 then xarr{i}=.;
        time=i;
        dep=xarr{i};
        output pndep2;
  end;
  output pndep;
run;

proc print data=pndep;
run;

proc tabulate data=pndep2 f=6.2;
  class group time;
  var dep;
  table time,
         group*dep*(mean var n);
run;

proc sgpanel data=pndep2 noautolegend;
  panelby group / rows=2;
  series y=dep x=time / group=idno break lineattrs=(pattern=solid);
run;

/*
symbol1 i=join v=none l=1 r=27;
symbol2 i=join v=none l=2 r=34;
proc gplot data=pndep2;
   plot dep*time=idno /nolegend skipmiss;
run;
*/

proc sort data=pndep2;
  by group ;
run;
proc sgplot data=pndep2;
  vbox dep /category=time;
  by group;
run;

/*
proc sort data=pndep2;
  by group time;
run;
proc boxplot data=pndep2;
  plot dep*time;
  by group;
run;
*/

proc sgplot data=pndep2;
  vline time / response=dep stat=mean limitstat=stderr group=group;
run;

/*
goptions reset=symbol;
symbol1 i=stdm1j l=1;
symbol2 i=stdm1j l=2;
proc gplot data=pndep2;
  plot dep*time=group;
run;
*/

proc sort data=pndep;
  by group;
run;

proc sgscatter data=pndep;
 matrix x1-x8;
 by group;
run;

data pndep;
  set pndep;
  array xarr {8} x1-x8;
  array locf  {8} locf1-locf8;
  do i=3 to 8;
    locf{i}=xarr{i};
    if xarr{i}=. then locf{i}=locf{i-1};
  end;
  mnbase=mean(x1,x2);
  mnresp=mean(of x3-x8);
  mncomp=(x3+x4+x5+x6+x7+x8)/6; 
  mnlocf=mean(of locf3-locf8);
  chscore=mnbase-mnresp;
run;

proc print;
run;

proc ttest data=pndep;
 class group;
 var mnresp mnlocf mncomp;
run;

proc glm data=pndep;
  class group;
  model chscore=group /solution;
run;

proc glm data=pndep;
  class group;
  model mnresp=mnbase group /solution;
run;



