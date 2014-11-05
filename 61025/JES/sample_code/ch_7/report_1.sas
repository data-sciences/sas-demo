
GOPTIONS RESET=ALL BORDER;
OPTIONS NODATE;
ODS LISTING CLOSE;
ODS RTF FILE="&JES.ods_output/report_1.rtf";
	TITLE1 "Resistance Data by Vendor";
	PROC PRINT DATA=JES.Results_Tab_2(WHERE=(_TYPE_=1)) NOOBS;
	VAR Vendor N M_Res N_Fail P_Fail;
	RUN;
ODS RTF CLOSE;
ODS LISTING;
