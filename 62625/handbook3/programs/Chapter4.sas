ods graphics on;

data hyper;
  infile 'c:\handbook3\datasets\hypertension.dat';
  input n1-n12;
  if _n_<4 then biofeed='P';
           else biofeed='A';
  if _n_ in(1,4) then drug='X';
  if _n_ in(2,5) then drug='Y';
  if _n_ in(3,6) then drug='Z';
  array nall {12} n1-n12;
  do i=1 to 12;
      if i>6 then diet='Y';
                 else diet='N';
          bp=nall{i};
          cell=drug||biofeed||diet;
          output;
  end;
  drop i n1-n12;
run;

proc print data=hyper;
run;

proc tabulate data=hyper;
  class  drug diet biofeed;
  var bp;
  table drug*diet*biofeed,
        bp*(mean std n);
run;

proc anova data=hyper;
  class cell;
  model bp=cell;
  means cell / hovtest;
  run;

proc anova data=hyper;
  class diet drug biofeed;
  model bp=diet|drug|biofeed;
  means diet*drug*biofeed;
  ods output means=outmeans;
run;

proc print data=outmeans;
run;

proc sgpanel data=outmeans;
  panelby drug /rows=3;
  series y=mean_bp x=biofeed / group=diet;
run;

/*
proc sort data=outmeans;
 by drug;
run;
symbol1 i=join v=none l=2;
symbol2 i=join v=none l=1;
proc gplot data=outmeans;
  plot mean_bp*biofeed=diet ;
  by drug;
run;
*/

data hyper;
  set hyper;
  logbp=log(bp);
run;

proc anova data=hyper;
  class diet drug biofeed;
  model logbp=diet|drug|biofeed;
  run;

proc anova data=hyper;
  class diet drug biofeed;
  model logbp=diet drug biofeed;
  means drug / scheffe;
run;

