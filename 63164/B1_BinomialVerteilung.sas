/*****************************************************************************
***  Programs for the Book "Data Quality for Analytics Using SAS"
***  Download Version 1.0 - May, 22nd 2012
***  Dr. Gerhard Svolba
***
***  Report any problems and questions for the programs to the author:
***  mail: sastools.by.gerhard@gmx.net
***
******************************************************************************/


*** 1. Define Parameters;
%let prob_min = 0;     *** Minimum Probability;
%let prob_max = 0.3;   *** Maximum Probability;
%let prob_by  = 0.01;  *** By value for probabilities;
%let nvars = 100;      *** Maximum number of variables;

*** 2. Loop in a dataset over probabilities and number of 
       variables. Use the PROBBNML function to calculate
       probabilities from the binomial distribution.;
data binomial;
 do Prob = &prob_min to &prob_max by &prob_by;
   do nvars = 1 to &nvars;;
 	  PercentNonMissing=probbnml(prob,nvars,0);
	  output;
   end;
 end;
run;

*** 3. Prepare the output table;
proc transpose data = binomial out = binomial_tp prefix=_;
 by  prob;
 var PercentNonMissing;
 id  nvars;
run;
data binomial_tp;
 set binomial_tp(drop = _name_);
 format prob percent8.
        _:   percent8.1;
 if prob=0 then delete;
run;

*** 4. Create output table with prob print and ODS HTML;
ods html;
proc print data = binomial_tp noobs;
 var Prob _1 _2 _3 _4 _5 _10 _15 _20 _25 _30 _40 _50 _60 _70 _80 _90 _100;
 where round(Prob*100) in  (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 20, 25, 30);
run;
ods html close;

