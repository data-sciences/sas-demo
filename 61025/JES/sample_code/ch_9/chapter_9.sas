



PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%INCLUDE "&JES.sample_code/ch_9/spc.sas";

%MACRO Print_Data_Sets;
%INCLUDE "&JES.utility_macros\sysop.sas";
%sysop;
%let path=c:\AAAA\SAS_Book\Ch_9; 

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
%include "&JES.sample_code\ch_9\spc.sas";
PROC PRINTTO file="&path.\spc.doc" NEW; RUN;
TITLE1 "Sum_Tab"; PROC PRINT DATA=Sum_Tab LABEL; RUN;
TITLE1 "Second_Tab"; 
	PROC PRINT DATA=Second_Tab; 
		VAR _VAR_ _NOBS_ _MEAN_ _STD_ _MEDIAN_ _CPK_;
	RUN;
TITLE1 "ResLim";
PROC PRINT DATA=ResLim NOOBS;
	VAR _VAR_ _SUBGRP_ _LIMITN_ _LCLX_ _MEAN_ _UCLX_ _STDDEV_;
RUN;

TITLE1 "Fail_Tab";
PROC PRINT DATA=Fail_Tab NOOBS; RUN;
TITLE1 "Defect_Tab";
PROC PRINT DATA=Defect_Tab NOOBS; RUN;



PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

%MEND Print_Data_Sets;

