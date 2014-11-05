/*****************************************************************************
***  Programs for the Book "Data Quality for Analytics Using SAS"
***  Download Version 1.0 - May, 22nd 2012
***  Version 1.1, Oct, 9th, 2012: Model Statement in PROC GLM is MODEL CHOL = .... (Instead of Model &var = )
***  Dr. Gerhard Svolba
***
***  Report any problems and questions for the programs to the author:
***  mail: sastools.by.gerhard@gmx.net
***
******************************************************************************/





*** Run PROC GLM to calculate individual reference values;
proc glm data=labor_chol_data;
 class sex centernr stage age_grp weight_grp ;
 id visitdate;
 model chol = age_grp sex weight_grp centernr  stage;
 output out=pred_chol p=reference r=residual stdi=stdi stdr=stdr stdp=stdp;
run;
quit;

*** Load statistics into macro variables;
proc sql;
 select mean(chol), std(chol) into :mean, :std from labor_chol_data;
quit;
%let k    = 2;

data pred_chol;
 set pred_chol;
 upper = &mean.+&k.*&std.;
 lower = &mean.-&k.*&std.;
 upper_i = reference+&k.*&std.;
 lower_i = reference-&k.*&std.;
 outlier = 1-( lower <= chol <= upper);
 indiv_o = 1-( lower_i <= chol <= upper_i);
 change = 1-(outlier = indiv_o);
 group = outlier*10+indiv_o;
run;

proc means data = pred_chol noprint nway;
 class patnr;
 var outlier indiv_o change;
 output out = pat_mart(where = (change_sum ne 0)) mean = sum = / autoname;
run;

proc sort data= pred_chol;
 by patnr date;
run;

data pred_chol;
 merge pred_chol
       pat_mart(in=in2);
 by patnr;
 Change = in2;
 if in2;
 ID = _N_;
run;



ods html;
proc sgplot data = pred_chol;
 series x=id y=upper;
 series x=id y=lower;
 step x=id y=upper_i/justify=center;
 step x=id y=lower_i/justify=center;
 scatter x=id y=chol / group = group MARKERATTRS=(size=8);
run;
quit;
ods html close;

