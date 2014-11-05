


%macro front;
data new; 
	do i = 1 to 2500;
		X=RANPOI(0, 100);
		output new;
	end;
run;
data new; set new; if X>70; run;
title h=1.5 "Distribution of X";
FootNote; title;

proc univariate noprint data=NEW;
var X;
histogram X / Normal(MU=est) CBARLINE=red CFILL=wheat
legend=none

;
run;
%mend front;

/*
%let path=c:\AAAA\SAS_Book\Ch_0;
%makedir(&path);
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
%output_html(&path, index, Front);

*/


DATA Temp; Item="Hammer"; Price=9.99; RUN;
PROC PRINT DATA=Temp; RUN;

SYMBOL1 VALUE=value COLOR=color;


