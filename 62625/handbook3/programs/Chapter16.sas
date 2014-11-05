ods graphics on;

data decathlon;
  infile 'c:\handbook3\datasets\olympic.dat';
  input name $ 1-13 run100 Ljump shot Hjump run400 hurdle discus polevlt javelin run1500 score;
run;

proc univariate data=decathlon ;
 var score;
 id name;
run;
proc sgplot data=decathlon;
  vbox score / datalabel=name;
run;

data decathlon;
  set decathlon;
  if score > 6000;
  run100=run100*-1;
  run400=run400*-1;
  hurdle=hurdle*-1;
  run1500=run1500*-1;
run;

proc princomp data=decathlon out=pcout;
 var run100--run1500;
run;

proc rank data=pcout out=pcout descending;
 var score;
 ranks posn;
run;

proc sgplot data=pcout;
  scatter y=prin1 x=prin2 / markerchar=posn;
run;

/*
proc gplot data=pcout;
  plot prin1*prin2;
  symbol v=none pointlabel=("#posn");
run;
*/

proc sgscatter data=pcout;
  compare y=score x=(prin1 prin2);
run;

/*
goptions reset=symbol;
proc gplot data=pcout;
  plot score*(prin1 prin2);
run;
*/

proc corr data=pcout;
  var score prin1 prin2;
run;

data pain (type = corr);
infile 'c:\handbook3\datasets\pain.dat' expandtabs missover;
input _type_ $  _name_ $   p1 - p9;
run;

proc factor data=pain method=ml n=3 rotate=varimax plot=scree;
 var p1-p9;
run;

