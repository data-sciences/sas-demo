/*****************************************************************************
***  Programs for the Book "Data Quality for Analytics Using SAS"
***  Download Version 1.0 - May, 22nd 2012
***  Dr. Gerhard Svolba
***
***  Report any problems and questions for the programs to the author:
***  mail: sastools.by.gerhard@gmx.net
***
******************************************************************************/
 

/**************************************************
*** Prepare Data
***************************************************/

data CreditData;
 format ID 8.;
 set hmeq;
 id = _N_;
 keep id bad job mortdue value;
run;


/**********************************************
*** Section 10.2
***********************************************/

proc means data = hmeq nmiss;
run;


proc means data = hmeq nmiss;
var mortdue value yoj;
run;


%count_mv(data=hmeq, vars= job reason yoj value);


/**********************************************
*** Section 10.3
***********************************************/
ods html;
%MV_PROFILING(data=hmeq,vars = bad delinq derog ninq clage clno job);
ods html close;


/**********************************************
*** Section 10.4
***********************************************/



proc standard data = CreditData out = CreditData_Replaced replace;
 var mortdue value;
run;

proc sort data = CreditData out =CreditData_Sorted;
 by job;
run;

proc standard data = CreditData_Sorted out = CreditData_Replaced_ByJob replace;
 var mortdue value;
 by job;
run;


/**********************************************
*** Section 10.6
***********************************************/


data CreditData;
 format ID 8.;
 set hmeq;
 id = _N_;
 mortdue = mortdue / 1000;
 value   = value   / 1000;
 keep id bad clage mortdue value;
run;


proc mi data = CreditData out = CreditData_MI;
 var clage mortdue value;
run;

proc logistic data = CreditData_MI;
 model bad(event='1') = clage mortdue value / covb ;
 ods output ParameterEstimates = Estimates
            Covb = CovMatrix;
 by _Imputation_;
run;

proc print data = estimates(obs=8) noobs;
run;

proc mianalyze parms=Estimates covb=CovMatrix;
 modeleffects intercept clage mortdue value;
run;

