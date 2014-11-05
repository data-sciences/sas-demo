

PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%let path=c:\AAAA\SAS_Book\Ch_3;
/* %makedir(&path);  */
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;

PROC PRINTTO file="&path.\export.doc" new; run;
%include "&JES.sample_code\ch_3\export.sas";
TITLE "Week"; PROC PRINT DATA=Week NOOBS LABEL; RUN;
TITLE;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;


PROC PRINTTO file="&path.\import.doc" new; run;
TITLE "Week_Import"; PROC PRINT DATA=Week_Import NOOBS; RUN;
TITLE "Sample_Import"; PROC PRINT DATA=Sample_Import NOOBS; RUN;
PROC PRINTTO; run;

PROC PRINTTO file="&path.\csv_import.doc" new; run;
%include "&JES.sample_code\ch_3\csv_import.sas";
PROC PRINTTO; run;


PROC PRINTTO file="&path.\more.doc" new; run;
%include "&JES.sample_code\ch_3\more.sas";
PROC PRINTTO; run;
