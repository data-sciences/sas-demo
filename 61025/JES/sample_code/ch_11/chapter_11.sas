


PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;



/* Delete all data sets in the WORK library  */
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;

DATA MacroVars; SET SASHELP.VMACRO; RUN;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="c:\AAAA\SAS_Book\Ch_11\macrovar.doc" NEW; RUN;
TITLE "MacroVars"; PROC PRINT DATA=MacroVars NOOBS; RUN;
OPTIONS CENTER DATE NUMBER;

%INCLUDE "&JES.utility_macros\sasver_os.sas";
%sasver_os
%let path=c:\AAAA\SAS_Book\Ch_11; 
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\macrovar2.doc" NEW; RUN;
%include "&JES.sample_code\ch_11\macro_var.sas";
TITLE "Tab"; PROC PRINT DATA=Tab NOOBS; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

%let path=c:\AAAA\SAS_Book\Ch_11;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\macrofun.doc" NEW; RUN;
%include "&JES.sample_code\ch_11\macro_functions.sas";
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

%let path=c:\AAAA\SAS_Book\Ch_11;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\micropgm.doc" NEW; RUN;
%include "&JES.sample_code\ch_11\macro_programs.sas";
TITLE "Vendor_List"; PROC PRINT DATA=Vendor_List NOOBS; RUN;
TITLE "Rates_2006"; PROC PRINT DATA=Rates_2006 NOOBS; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;


%let path=c:\AAAA\SAS_Book\Ch_11;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\microstatemnts.doc" NEW; RUN;
%include "&JES.sample_code\ch_11\macro_statements.sas";
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;


%let path=c:\AAAA\SAS_Book\Ch_11;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\dups.doc" NEW; RUN;
DATA Units; SET JES.Units; RUN;
%Dups(Units, SN)
%Dups(Temp, SN)
%PUT Num_Dups=&Num_Dups Num_Unique=&Num_Unique;
TITLE "Units";    PROC PRINT DATA=Units; RUN;
TITLE "Units_DP"; PROC PRINT DATA=Units_DP; RUN;
TITLE "Units_ND"; PROC PRINT DATA=Units_ND; RUN;
TITLE "Units_U";  PROC PRINT DATA=Units_U; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

%let path=c:\AAAA\SAS_Book\Ch_11;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\ds_info.doc" NEW; RUN;
DATA Temp; 
		FORMAT Vendor $9. SN 8.0 Install_Date Date9.;
		DO Install_Date='01JAN2008'd TO '10JAN2008'd;
			VENDOR="ChiTronix";
			SN=1000+MOD(Install_Date,7);
			OUTPUT;
		END;
RUN;
%ds_info(WORK, Temp)
%PUT Var_List=[&Var_List];
TITLE1 "Temp_Vars"; PROC PRINT DATA=Temp_Vars NOOBS; RUN;
TITLE1 "Temp_Attr"; PROC PRINT DATA=Temp_Attr NOOBS;

RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;
