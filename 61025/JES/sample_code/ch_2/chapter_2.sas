
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%LET Path=&JES.sample_code/ch_2/;

%INCLUDE "&Path.intro.sas";
%INCLUDE "&Path.create_datasets.sas";
%INCLUDE "&Path.autoexec_2.sas";
%INCLUDE "&Path.functions.sas";
%INCLUDE "&Path.numeric.sas";
%INCLUDE "&Path.date_time.sas";
%INCLUDE "&Path.text.sas";
%INCLUDE "&Path.lag_retain.sas";
%INCLUDE "&Path.subsets.sas";
%INCLUDE "&Path.sort_merge.sas";
%INCLUDE "&Path.proc_datasets.sas";
%INCLUDE "&Path.compare.sas";
%INCLUDE "&Path.transpose.sas";
%INCLUDE "&Path.array.sas";

%MACRO Print_Data_Sets;
%let path=c:\AAAA\SAS_Book\Ch_2;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\intro.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\intro.sas";
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;


PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\create.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\create_datasets.sas";
TITLE "Temp"; PROC PRINT DATA=Temp; RUN;
TITLE "Temp2X"; PROC PRINT DATA=Temp2X; RUN;
TITLE "Poisson_Table"; PROC PRINT DATA=Poisson_Table; RUN;
TITLE "More"; PROC PRINT DATA=More; RUN;
TITLE "New"; PROC PRINT DATA=New; RUN;
TITLE "Good"; PROC PRINT DATA=Good; RUN;
TITLE "Better"; PROC PRINT DATA=Better; RUN;
TITLE "Best"; PROC PRINT DATA=Best; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

PROC PRINTTO file="&path.\functions.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\functions.sas";
PROC PRINTTO; RUN;

PROC PRINTTO file="&path.\numeric.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\numeric.sas";
PROC PRINTTO; RUN;

PROC PRINTTO file="&path.\date_time.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\date_time.sas";
PROC PRINTTO; RUN;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\text.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\text.sas";
TITLE "Contacts_1";  PROC PRINT DATA=Contacts_1 NOOBS; RUN;
TITLE "Contacts_2";  PROC PRINT DATA=Contacts_2 NOOBS; RUN;
TITLE "CharNum_1";  PROC PRINT DATA=CharNum_1 NOOBS; RUN;
TITLE "TestDates"; PROC PRINT DATA=TestDates NOOBS; 
	* VAR SN Station M D Y DMY TestDate;
RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

%let path=c:\AAAA\SAS_Book\Ch_2;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\lag.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\lag_retain.sas";
TITLE "Lag_Table"; PROC PRINT DATA=Lag_Table NOOBS; RUN;
TITLE "Retain_Table"; PROC PRINT DATA=Retain_Table NOOBS; RUN;
TITLE "Retain_Table_2"; PROC PRINT DATA=Retain_Table_2 NOOBS; RUN;
TITLE "Retain_Table_3"; PROC PRINT DATA=Retain_Table_3 NOOBS; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;


%let path=c:\AAAA\SAS_Book\Ch_2;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\subsets.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\subsets.sas";
TITLE "Subset_1"; PROC PRINT DATA=Subset_1 NOOBS; RUN;
TITLE "Subset_2"; PROC PRINT DATA=Subset_2 NOOBS; RUN;
TITLE "Subset_3"; PROC PRINT DATA=Subset_3 NOOBS; RUN;
TITLE "Subset_4"; PROC PRINT DATA=Subset_4 NOOBS; RUN;
TITLE "Subset_5"; PROC PRINT DATA=Subset_5 NOOBS; RUN;
TITLE "Temp";    PROC PRINT DATA=Temp NOOBS; RUN;
TITLE "Temp_2";  PROC PRINT DATA=Temp_2 NOOBS; RUN;
TITLE "LowRes";  PROC PRINT DATA=LowRes NOOBS; RUN;
TITLE "HighRes"; PROC PRINT DATA=HighRes NOOBS; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%let path=c:\AAAA\SAS_Book\Ch_2;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\sort.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\sort_merge.sas";
TITLE "Units_Sorted"; PROC PRINT DATA=Units_Sorted; RUN;
TITLE "Units_Sorted_Plus"; PROC PRINT DATA=Units_Sorted_Plus; RUN;
TITLE "Units_U"; PROC PRINT DATA=Units_U; RUN;
TITLE "Units_Dup"; PROC PRINT DATA=Units_Dup; RUN;
TITLE "Units_Fails"; PROC PRINT DATA=Units_Fails; RUN;
TITLE "Units_Fails"_2; PROC PRINT DATA=Units_Fails_2 NOOBS; RUN;
TITLE "Units_Fails_Plus"; PROC PRINT DATA=Units_Fails_Plus; RUN;
TITLE "Units_Fails_OK"; PROC PRINT DATA=Units_Fails_OK NOOBS; RUN;
TITLE "Fails_OK"; PROC PRINT DATA=Fails_OK NOOBS; RUN;
TITLE "Fails_WO_Install"; PROC PRINT DATA=Fails_WO_Install NOOBS; RUN;
TITLE;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

PROC PRINTTO file="&path.\compare.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\compare.sas";
PROC PRINTTO; RUN;

PROC PRINTTO file="&path.\proc_datasets.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\proc_datasets.sas";
PROC PRINTTO; RUN;

%let path=c:\AAAA\SAS_Book\Ch_2;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\transpose.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\transpose.sas";
TITLE "TRates"; PROC PRINT DATA =TRates NOOBS; RUN;
TITLE;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

PROC PRINTTO file="&path.\array.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_2\array.sas";
PROC PRINTTO; RUN;

PROC PRINTTO file="&path.\csv.doc" new; RUN;
%INCLUDE "&JES.sample_code\csv_export.sas";
PROC PRINTTO; RUN;

%MEND Print_Data_Sets;
