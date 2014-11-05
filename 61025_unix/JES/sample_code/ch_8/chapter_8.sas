


PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%LET Path=&JES.sample_code/ch_8/;
%INCLUDE "&Path.lifetest.sas";
%INCLUDE "&Path.basic.sas";
%INCLUDE "&Path.limits.sas";
%INCLUDE "&Path.bar.sas";

%INCLUDE "&Path.distribution.sas";
%INCLUDE "&Path.fit.sas";
%INCLUDE "&Path.by_group.sas";
%INCLUDE "&Path.overlay.sas";

%INCLUDE "&Path.two_axes.sas";
%INCLUDE "&Path.sgplot_options.sas";
%INCLUDE "&Path.histo_density.sas";
%INCLUDE "&Path.hbox_vbox.sas";

%INCLUDE "&Path.conlim_sg.sas";
%INCLUDE "&Path.hyperlinks.sas";
%INCLUDE "&Path.sgpanel.sas";
%INCLUDE "&Path.sgscatter.sas";
%INCLUDE "&Path.sgrender.sas";

%MACRO Print_Data_Sets;
%INCLUDE "&JES.utility_macros\sasver_os.sas";
%sasver_os;
%let print_path=c:\AAAA\SAS_Book\Ch_8\; 

PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;

/*=== Section 8.3 ===*/
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
%include "&Path.basic.sas";
%include "&Path.distribution.sas";
%include "&Path.bar.sas";
OPTIONS CENTER DATE NUMBER;


OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&print_path.conlim_2_sg.doc" NEW; RUN;
%include "&Path.conlim_2_sg.sas";
TITLE "Tab_1"; PROC PRINT DATA=Tab_1 NOOBS; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&print_path.random_data_8.doc" NEW; RUN;
%include "&Path.random_data_8.sas";
TITLE "TestResults"; PROC PRINT DATA=TestResults NOOBS; RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO FILE="&print_path.hyperlinks.doc" NEW; RUN;
%include "&Path.hyperlinks.sas";
TITLE "Results_Tab"; PROC PRINT DATA=Results_Tab NOOBS; 
	VAR Vendor Mon M_Res Point_Link;
RUN;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

%MEND Print_Data_Sets;
