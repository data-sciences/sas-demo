

%LET path=c:\AAAA\SAS_Book\Ch_5;
PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%LET Code_Path=&JES.sample_code/ch_5/;
%let path=c:\AAAA\SAS_Book\Ch_5;
%let html_path=&path.\html;
%let pgnam= CH_5;
%makedir(&html_path);
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
ODS LISTING CLOSE;
ODS HTML
        path="&html_path./" (url=none)
        body="&pgnam._body.html" 
        Contents="&pgnam._toc.html"
        Frame="&pgnam._frame.html" (Title="&pgnam") style=D3D NewFILE=None;
	%INCLUDE "&Code_Path.means_examples.sas";
	%INCLUDE "&Code_Path.tabulate_examples.sas";
	%INCLUDE "&Code_Path.report_examples.sas";
	%INCLUDE "&Code_Path.boxplot_examples.sas";
	%INCLUDE "&Code_Path.anom_examples.sas";
	%INCLUDE "&Code_Path.univariate_examples.sas";
	%INCLUDE "&Code_Path.freq_examples.sas";
	%INCLUDE "&Code_Path.sql_examples.sas";
ODS HTML CLOSE;
ODS LISTING;




%MACRO Print_Data_Sets;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\means_examples.doc" new; RUN;
TITLE;
%INCLUDE "&JES.sample_code\ch_5\means_examples.sas";
TITLE "Tab_1"; PROC PRINT DATA=Tab_1 NOOBS HEADING=HORIZONTAL; RUN;
TITLE "Tab_2"; PROC PRINT DATA=Tab_2 NOOBS HEADING=HORIZONTAL; RUN;
TITLE "Tab_3"; PROC PRINT DATA=Tab_3 NOOBS HEADING=HORIZONTAL; RUN;
TITLE "Tab_4"; PROC PRINT DATA=Tab_4 NOOBS HEADING=HORIZONTAL; RUN;
TITLE "Tab_5"; PROC PRINT DATA=Tab_5 NOOBS HEADING=HORIZONTAL; RUN;
TITLE "Tab_6"; PROC PRINT DATA=Tab_6 NOOBS HEADING=HORIZONTAL; RUN;
TITLE "Tab_7"; PROC PRINT DATA=Tab_7 NOOBS HEADING=VERTICAL; RUN;
TITLE "Tab_8"; 
PROC PRINT DATA=Tab_8 NOOBS; 
	VAR Vendor Month D_L D_U R_L R_U P_L P_U;
RUN;
TITLE;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;


OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\tabulate_examples.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_5\tabulate_examples.sas";
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\report_examples.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_5\report_examples.sas";
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\anom_examples.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_5\anom_examples.sas";
TITLE "Tab_9"; PROC PRINT DATA=Tab_9 NOOBS; RUN; TITLE;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\univariate_examples.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_5\univariate_examples.sas";
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\freq_examples.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_5\freq_examples.sas";
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

%LET path=c:\AAAA\SAS_Book\Ch_5;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&path.\sql_examples.doc" new; RUN;
%INCLUDE "&JES.sample_code\ch_5\sql_examples.sas";
TITLE "Dset"; PROC PRINT DATA=Dset_ NOOBS ; RUN;
TITLE "Dset2"; PROC PRINT DATA=Dset2_ NOOBS ; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%INCLUDE "&JES.sample_code\ch_1\random_test_results.sas";
%INCLUDE "&JES.sample_code\ch_5\means_examples.sas";
%INCLUDE "&JES.sample_code\ch_5\tabulate_examples.sas";
%INCLUDE "&JES.sample_code\ch_5\report_examples.sas";
%INCLUDE "&JES.sample_code\ch_5\boxplot_examples.sas";
%INCLUDE "&JES.sample_code\ch_5\anom_examples.sas";
%INCLUDE "&JES.sample_code\ch_5\univariate_examples.sas";
%INCLUDE "&JES.sample_code\ch_5\freq_examples.sas";
MEND Print_Data_Sets;


/*
%let path=c:\AAAA\SAS_Book\Ch_5;
%let html_path=&path.\html;
%let pgnam= CH_5;
%makedir(&html_path);
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
ODS LISTING CLOSE;
ODS HTML
        path="&html_path./" (url=none)
        body="&pgnam._body.html" 
        Contents="&pgnam._toc.html"
        Frame="&pgnam._frame.html" (Title="&pgnam") style=D3D NewFILE=None;
	%INCLUDE "&JES.sample_code\ch_5\means_examples.sas";
	%INCLUDE "&JES.sample_code\ch_5\tabulate_examples.sas";
	%INCLUDE "&JES.sample_code\ch_5\report_examples.sas";
	%INCLUDE "&JES.sample_code\ch_5\anom_examples.sas";
	%INCLUDE "&JES.sample_code\ch_5\freq_examples.sas";
	%INCLUDE "&JES.sample_code\ch_5\univariate_examples.sas";
ODS HTML CLOSE;
ODS LISTING;
*/

