ods graphics on;

data toenail;
  infile 'c:\handbook3\datasets\toenail.dat' expandtabs ;
  input patient outcome treatment month visit;
run;

proc sort data=toenail;
 by treatment visit;
run;

proc means data=toenail;
 var month outcome;
 output out=means mean=mnmonth mnoutcome;
 by treatment visit;
run;

proc sgplot data=means;
  series y=mnoutcome x=mnmonth / group=treatment markers;
  yaxis label='proportion with onycholysis';
run;

/*
axis1 label=(a=90 'proportion with onycholysis') minor=none;
proc gplot data=means;
  plot mnoutcome*mnmonth=treatment / vaxis=axis1;
  symbol1 i=join v=circle;
  symbol2 i=join v=square l=2;
run;
*/

proc logistic data=toenail desc;
   model outcome=treatment month / clodds=wald;
run;

proc logistic data=toenail desc;
   model outcome=month|treatment / clodds=wald;
run;

proc sort data=toenail;
  by patient visit;
run;

proc genmod data=toenail desc;
   class  patient treatment visit;
   model outcome=month|treatment / d=b;
   repeated subject=patient / type=exch within=visit;
run;

proc glimmix data=toenail noclprint;
   class patient;
   model outcome(desc)=month|treatment / d=binary s ddfm=bw;
   random int / subject=patient ;
run;

