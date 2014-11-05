



PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;
PROC DATASETS LIBRARY=WORK MEMTYPE=DATA GENNUM=ALL KILL; QUIT;
%LET Code_Path=&JES.sample_code/ch_6/;
 	%INCLUDE "&Code_Path.view_save.sas";
	%INCLUDE "&Code_Path.gplot_forms.sas";
	%INCLUDE "&Code_Path.gplot_options.sas";
	%INCLUDE "&Code_Path.colors.sas";
	%INCLUDE "&Code_Path.conlim.sas";
	%INCLUDE "&Code_Path.gchart_examples.sas";
	%INCLUDE "&Code_Path.other_examples.sas";
	%INCLUDE "&Code_Path.exercise_6.sas";




%let path=c:\AAAA\SAS_Book\Ch_6;
%let html_path=&path.\html;
%let pgnam= CH_6;
%makedir(&html_path);
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
ODS LISTING CLOSE;
ods html 
        path="&html_path./" (url=none)
        body="&pgnam._body.html" 
        Contents="&pgnam._toc.html"
        Frame="&pgnam._frame.html" (Title="&pgnam") style=D3D Newfile=None;
	%INCLUDE "&Code_Path.gplot_forms.sas";
	%INCLUDE "&Code_Path.colors.sas";
	%INCLUDE "&Code_Path.conlim.sas";
	%INCLUDE "&Code_Path.conlim_2.sas";
	%INCLUDE "&Code_Path.gchart_examples.sas";
	%INCLUDE "&Code_Path.exercise_6.sas";
ODS HTML CLOSE;
ODS LISTING;


%MACRO Print_Data_Sets;
%let path=c:\AAAA\SAS_Book\Ch_6;
PROC DATASETS MEMTYPE=CAT NOLIST; DELETE GSEG; RUN; QUIT;
OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\sample_data.doc" new; run;
%INCLUDE "&JES.sample_code\ch_6\random_data_6.sas";
TITLE "Results_6"; PROC PRINT DATA=Results_6 NOOBS; RUN;
TITLE "Results_6_Tab"; PROC PRINT DATA=Results_6_Tab NOOBS; RUN;
TITLE;
PROC PRINTTO; run;

PROC PRINTTO file="&path.\gplot_forms.doc" new; run;
%INCLUDE "&JES.sample_code\ch_6\gplot_forms.sas";
PROC PRINTTO; RUN;


PROC PRINTTO file="&path.\colors.doc" new; run;
%INCLUDE "&JES.sample_code\ch_6\colors.sas";
PROC PRINTTO; RUN;


OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\conlim.doc" new; run;
%INCLUDE "&JES.sample_code\ch_6\conlim.sas";
TITLE "Tab"; PROC PRINT DATA=Tab NOOBS; RUN;
TITLE "Tab_1"; PROC PRINT DATA=Tab_1 NOOBS; RUN;
TITLE "Tab_2"; PROC PRINT DATA=Tab_2 NOOBS; RUN;
TITLE "My_Anno"; PROC PRINT DATA=My_Anno NOOBS; RUN;

TITLE "Tab_3"; PROC PRINT DATA=Tab_3 NOOBS; RUN;
TITLE "Tab_4"; PROC PRINT DATA=Tab_4 NOOBS; RUN;
TITLE "My_Anno_2"; PROC PRINT DATA=My_Anno_2 NOOBS; RUN;
TITLE;
PROC PRINTTO; RUN;
OPTIONS CENTER DATE NUMBER;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\gchart_examples.doc" new; run;
%INCLUDE "&JES.sample_code\ch_6\gchart_examples.sas";
TITLE "Defect_Tab"; PROC PRINT DATA=Defect_Tab NOOBS; RUN;
TITLE1 "Tab"; PROC PRINT DATA=Tab NOOBS; RUN;
TITLE1 "Summary"; PROC PRINT DATA=Summary NOOBS; RUN;
PROC PRINTTO; run;
OPTIONS CENTER DATE NUMBER;

OPTIONS NOCENTER NODATE LINESIZE=80 NONUMBER;
PROC PRINTTO file="&path.\other_examples.doc" new; run;
%INCLUDE "&JES.sample_code\ch_6\other_examples.sas";
TITLE1 "WafMap";
PROC PRINT DATA=WafMap NOOBS;
RUN;
TITLE1 "WafData";
PROC PRINT DATA=WafData NOOBS;
RUN;
TITLE1 "Anno";
PROC PRINT DATA=WafData NOOBS;
RUN;

PROC PRINTTO; run;
OPTIONS CENTER DATE NUMBER;
%MEND Print_Data_Sets;


/*
%put &path;
ODS CSVALL FILE="&path.\color_tab.csv";
TITLE "Color_Tab";
PROC PRINT DATA=Color_Tab NOOBS LABEL;
	VAR C1 C2 C3 C4 C5 C6;
RUN;
ODS CSVALL CLOSE;
*/

