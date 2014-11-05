* E9_3_1.sas
*
* Using the SYMBOL statement;

goptions reset=all;

title1 f=arial bold 'Regression of HT and WT';
title2 '9.3.1a No SYMBOL Statement';

proc reg data=advrpt.demog;
model ht = wt;
plot ht*wt/conf; 
run;
quit;

title2 '9.3.1b With SYMBOL Statements';
symbol1 c=blue  v=dot;
symbol2 c=red;
symbol3 c=green r=2;

proc reg data=advrpt.demog;
model ht = wt;
plot ht*wt/conf; 
run;
quit;


title2 '9.3.1c Choose the SYMBOL Definition';
* In GPLOT the symbol definition can be selected.;
proc gplot data=advrpt.demog;
plot ht*wt=2; 
run;
quit;

