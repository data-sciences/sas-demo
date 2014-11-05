 

/*==========================================================
This code creates the data sets Unique and Fails
for export to an XML file readable by MS Excel
===========================================================*/
%INCLUDE "&JES.sample_code/ch_2/sort_merge.sas";
DATA Fails; SET JES.Fails(RENAME=(Loc=Position)); RUN;

/*==========================================================
This code creates the Excel spreadsheet Fail_Data_1.xml with
two worksheets containing the contents of Units_U and Fails
respectively
===========================================================*/
ODS TAGSETS.ExcelXP FILE="Fail_Data_1.xml" PATH="&JES.output";
	TITLE "Units Installed"; FOOTNOTE "data collected 08/01/06";
	PROC PRINT DATA=Units_U LABEL NOOBS; RUN; 
	TITLE "Units Failed"; FOOTNOTE "data collected 09/12/06";
	PROC PRINT DATA=Fails NOOBS; RUN;
ODS TAGSETS.ExcelXP CLOSE;

/*==========================================================
This code creates the Excel spreadsheet Fail_Data_2.xml, 
same as above, but  
- Titles and Footnotes are in the body of the spreadsheet
- The Banker style is used
- The format of SN is forced to include the leading zeros
===========================================================*/

ODS TAGSETS.ExcelXP STYLE=Banker FILE="Fail_Data_2.xml" PATH="&JES.output"
	OPTIONS(EMBEDDED_TITLES='YES' EMBEDDED_FOOTNOTES='YES');
	TITLE "Units Installed"; FOOTNOTE "data collected 08/01/06";
	PROC PRINT DATA=Units_U LABEL NOOBS; 
		VAR SN  / STYLE={tagattr="\0000"};
		VAR Install Loc;
	RUN; 
	TITLE "Units Failed"; FOOTNOTE "data collected 09/12/06";
	PROC PRINT DATA=Fails NOOBS; 
		VAR SN  / STYLE={tagattr="\0000"};
		VAR Fail Position;
	RUN;
ODS TAGSETS.ExcelXP CLOSE;

PROC TEMPLATE; LIST STYLES; RUN;


/*==========================================================
This code creates the Excel spreadsheet Fail_Data_3.xml which is
the same as Fail_Data_2.xml, except thatoptions are used to control
the names of the worksheets
===========================================================*/
ODS TAGSETS.ExcelXP FILE="&JES.output/Fail_Data_3.xml";
	ODS TAGSETS.ExcelXP OPTIONS(EMBEDDED_TITLES='NO' EMBEDDED_FOOTNOTES='NO');
	ODS TAGSETS.ExcelXP OPTIONS(SHEET_NAME='Install Data');
	PROC PRINT DATA=Units_U LABEL NOOBS; 
		VAR SN  / STYLE={tagattr="\0000"};
		VAR Install Loc;
	RUN; 
	ODS TAGSETS.ExcelXP OPTIONS(SHEET_NAME='Fail Data');
	PROC PRINT DATA=Fails NOOBS; 
		VAR SN  / STYLE={tagattr="\0000"};
		VAR Fail Position;
	RUN;
ODS TAGSETS.ExcelXP CLOSE;



/*==========================================================
This code reads in each worksheet in the XML FILE
Re_Import.xml to a different SAS data set   
===========================================================*/
%INCLUDE "&JES.utility_macros/xlxp2sas.sas";
%xlxp2sas(excelfile=&JES.output/Re_Import.xml, 
	        mapfile=&JES.utility_macros/excelxp.map);

TITLE "Install_Data"; PROC PRINT DATA=Install_Data; RUN;
TITLE "Fail_Data"; PROC PRINT DATA=Fail_Data; RUN;


