

PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%LET Code_Path=&JES.sample_code/ch_10/;
%INCLUDE "&code_path.reliability.sas";
%INCLUDE "&code_path.lifereg.sas";
%INCLUDE "&code_path.lifetest.sas";
%INCLUDE "&code_path.phreg.sas";
%INCLUDE "&code_path.mcf.sas";
%INCLUDE "&code_path.bayes.sas";



%MACRO Print_Data_Sets;
%INCLUDE "&JES.utility_macros\sysop.sas";
%sysop;
%let path=c:\AAAA\SAS_Book\Ch_10; 
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\reliability.doc" NEW; RUN;
%include "&JES.sample_code\ch_10\reliability.sas";
TITLE "ParmEst_1"; PROC PRINT DATA=ParmEst_1 NOOBS; RUN;
TITLE "PctEst_1";  PROC PRINT DATA=PctEst_1 NOOBS; RUN;
TITLE "ParmEst_2"; PROC PRINT DATA=ParmEst_2 NOOBS; RUN;
TITLE "ParmEst_3"; PROC PRINT DATA=ParmEst_3 NOOBS; RUN;
TITLE "ParmEst_4"; PROC PRINT DATA=ParmEst_4 NOOBS; RUN;
TITLE "ModPrmEst_4";  PROC PRINT DATA=ModPrmEst_4 NOOBS; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;


OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\lifereg.doc" NEW; RUN;
%include "&JES.sample_code\ch_10\lifereg.sas";
TITLE "Estimates_1"; PROC PRINT DATA=Estimates_1 NOOBS; RUN;
TITLE "Fit_1";       PROC PRINT DATA=Fit_1 NOOBS; RUN; TITLE;
TITLE "Estimates_2"; PROC PRINT DATA=Estimates_2 NOOBS; RUN;
TITLE "Fit_2";       PROC PRINT DATA=Fit_2 NOOBS; RUN;
TITLE "Fit_2A";       
PROC PRINT DATA=Fit_2A NOOBS; 
	VAR TestTime Censor Temp_C CDF Cum_Fail P_Fail LSA LSF;
RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;


OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\lifetest.doc" NEW; RUN;
%include "&JES.sample_code\ch_10\lifetest.sas";
TITLE "Life_Table"; PROC PRINT DATA=Life_Table NOOBS; RUN;
TITLE "Tests"; PROC PRINT DATA=Tests NOOBS; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;


OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\phreg.doc" NEW; RUN;
%include "&JES.sample_code\ch_10\phreg.sas";
TITLE "Temp_Values"; PROC PRINT DATA=Temp_Values; RUN;
TITLE "ParmEst"; PROC PRINT DATA=ParmEst NOOBS; RUN;
TITLE "Base"; PROC PRINT DATA=Base NOOBS; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\mcf.doc" NEW; RUN;
%include "&JES.sample_code\ch_10\mcf.sas";
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\bayes.doc" NEW; RUN;
%include "&JES.sample_code\ch_10\bayes.sas";
TITLE "MLE"; PROC PRINT DATA=MLE NOOBS; RUN;
TITLE "Summary"; PROC PRINT DATA=Summary NOOBS; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

%MEND Print_Data_Sets;
