
ods graphics on;

data water;
    infile 'c:\handbook3\datasets\water.dat';
    input flag $ 1 Town $ 2-18 Mortal 19-22 Hardness 25-27;
    if flag='*' then location='north';
        else location='south';
run;

proc univariate data=water normal;
  var mortal hardness;
  histogram mortal hardness /normal;
  probplot mortal hardness;
run; 

proc sgplot data=water;
  scatter y=mortal x=hardness;
run;

/*
proc gplot;
  plot mortal*hardness;
run;
*/

proc corr data=water pearson spearman;
  var mortal hardness;
run;

proc sgplot data=water;
  scatter y=mortal x=hardness / group=location;
run;

/*
symbol1 value=dot;
symbol2 value=circle;
proc gplot;
  plot mortal*hardness=location;
run;
*/

proc sort;
   by location;
run;
proc corr data=water pearson spearman;
  var mortal hardness;
  by location;
run;

proc kde data=water;
  bivar mortal hardness /plots=surface;
run;

/*
proc kde data=water;
  bivar mortal hardness / out=bivest;
run;

proc g3d data=bivest;
  plot value1*value2=density;
  label value1=mortal value2=hardness;
run;
*/

data water;
   set water;
   lhardnes=log(hardness);
run;

proc ttest data=water;
   class location;
   var mortal hardness lhardnes;
run;

proc npar1way data=water wilcoxon;
   class location;
   var hardness;
run;

