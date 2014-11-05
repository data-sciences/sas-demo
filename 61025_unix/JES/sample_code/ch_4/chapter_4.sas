

%let path=c:\AAAA\SAS_Book\Ch_4;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\random.doc" new; RUN;
%include "&JES.sample_code\ch_4\random_data.sas";
TITLE "Units"; PROC PRINT DATA=Units NOOBS; RUN;
TITLE "Modes"; PROC PRINT DATA=Modes NOOBS; RUN;
TITLE "Fails"; PROC PRINT DATA=Fails NOOBS; RUN;
TITLE;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

%let path=c:\AAAA\SAS_Book\Ch_4;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\proc_sql.doc" new; RUN;
%include "&JES.sample_code\ch_4\proc_sql.sas";
TITLE "NY Recent"; PROC PRINT DATA=NY_Recent; RUN;
TITLE "Join"; PROC PRINT DATA=Join; RUN;
TITLE "Join_Left"; PROC PRINT DATA=Join_Left NOOBS; RUN;
TITLE "Join_Right"; PROC PRINT DATA=Join_Right NOOBS; RUN;
TITLE "Join_Full"; PROC PRINT DATA=Join_Full NOOBS; RUN;
TITLE "Join_LEFT_2"; PROC PRINT DATA=Join_LEFT_2 NOOBS; RUN;
TITLE "Join_2"; PROC PRINT DATA=Join_2; RUN;
TITLE;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

PROC PRINTTO file="&path./explor.doc" new; RUN;
%include "&JES.sample_code/ch_4/explore.sas";
PROC PRINTTO; RUN;

%let path=c:\AAAA\SAS_Book\Ch_4;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path./libname.doc" new; RUN;
%include "&JES.sample_code/ch_4/libname.sas";
TITLE "NY Recent_1"; PROC PRINT DATA=NY_Recent_1; RUN;
TITLE "NY Recent_2"; PROC PRINT DATA=NY_Recent_2; RUN;  
TITLE "NY Recent_1"; PROC PRINT DATA=NY_Recent_1; RUN; 
TITLE "Join"; PROC PRINT DATA=Join; RUN;
TITLE "Join_Left"; PROC PRINT DATA=Join_Left NOOBS; RUN;
TITLE "Join_Right"; PROC PRINT DATA=Join_Right NOOBS; RUN;
TITLE "Join_FULL"; PROC PRINT DATA=Join_FULL NOOBS; RUN;
TITLE "Join_Left_2"; PROC PRINT DATA=Join_Left_2 NOOBS; RUN;
TITLE;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

%let path=c:\AAAA\SAS_Book\Ch_4;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path./list_match.doc" new; RUN;
%include "&JES.sample_code/ch_4/list_match.sas";
 TITLE "SN_Match"; PROC PRINT DATA=SN_Match NOOBS; RUN;
 TITLE "SN_Table"; PROC PRINT DATA=SN_Table NOOBS; RUN;
TITLE;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;







