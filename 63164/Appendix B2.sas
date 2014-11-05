/*****************************************************************************
***  Programs for the Book "Data Quality for Analytics Using SAS"
***  Download Version 1.0 - May, 22nd 2012
***  Dr. Gerhard Svolba
***
***  Report any problems and questions for the programs to the author:
***  mail: sastools.by.gerhard@gmx.net
***
******************************************************************************/

ods html;
proc power;
 logistic
 alpha = 0.05
 vardist('Duration') = normal(4, 1.5)
 testpredictor = 'Duration'
 testoddsratio = 1.7
 responseprob = 0.65
 ntotal = 50 60 70
 power = . ;
run;
ods html close;
