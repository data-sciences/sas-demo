

PROC DATASETS MEMTYPE=CAT NOLIST; DELETE HTML; RUN; QUIT; 
OPTIONS NODATE;
GOPTIONS RESET=ALL BORDER FTEXT='Helvetica' FTITLE='Helvetica/Bold';
GOPTIONS GUNIT=PCT HTEXT=4 HTITLE=5 HSIZE=9IN VSIZE=6IN; 

/* Use NO_TOP_MATTER and NO_BOTTOM_MATTER to customize your web pages */

/* Write your own HTML header code */
FILENAME noTopBot "&JES.ods_output/page7/noTopBot.html";
DATA _NULL_;  FILE noTopBot;
	PUT "<HTML><HEAD><TITLE>noTopBot Example</TITLE>";
	PUT '</HEAD><BODY><TABLE BORDER=2 ALIGN=CENTER>';
	PUT '<TR><TD ALIGN=CENTER><H1>2008 Quality Report</H1>';
	PUT '</TD></TR><TR><TD>';
RUN;

/* Let SAS write the intermediate HTML code lines */
FILENAME noTopBot  "&JES.ods_output/page7/noTopBot.html" MOD;
ODS HTML PATH="&JES.ods_output/page7" (URL=NONE)
	BODY=noTopBot(NO_TOP_MATTER NO_BOTTOM_MATTER) STYLE=MINIMAL;
	%INCLUDE "&JES.sample_code/ch_7/vendors_3.sas";
ODS HTML CLOSE;

/* Write your own HTML closing lines  */
FILENAME noTopBot  "&JES.ods_output/page7/noTopBot.html" MOD;
DATA _NULL_;  FILE NoTopBot;
	PUT '</TD></TR><TR><TD>';
	PUT 'For further information contact 
		<a href="mailto:John.Doe@BigCorp.com">
		John.Doe@BigCorp.com</a>';
	PUT '</TD></TABLE></CENTER>';
	PUT '</BODY></HTML>';
RUN;
