* E14_1_2.sas
*
* Data processing System Options;
title1 '14.1.2 System Options';

***************************
* MERGENOBY;
options mergenoby=nowarn;
data aemed;
   merge advrpt.ae
         advrpt.conmed;
   run;

***************************
* DATASTMTCHK;
data ae work.set;
   set advrpt.ae;
   run;

***************************
* VALIDVARNAME;
option validvarname=v6;
data a;
   abcdefghig= 5;
   run;

option validvarname=any;
PROC IMPORT OUT= WORK.AeXLS 
            DATAFILE= "&path\data\E14_1_2AE.xls" 
            DBMS=EXCEL REPLACE;
     SHEET="Sheet1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
title2 'Using VALIDVARNAME=ANY';
proc print data=aexls;
run;
data ae;
   set aexls(rename=('ae-date'n=AEDate 'ae#type'n=AEType));
   run;

* Try using this data set without validvarname=any;
options validvarname=v7;
title2 'Using VALIDVARNAME=V7';
proc print data=aexls;
run;

* You can use a named literal without validvarname=any;
* but why would you???;
proc print data=ae;
var 'aedate'n 'aetype'n;
run;
