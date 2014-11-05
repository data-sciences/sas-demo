





/*=== JES\sample_code\ch_7\vendors_1a.sas ===*/
TITLE1 "Resistance Data by Vendor - 4Q 2008";
TITLE2 LINK="../report.pdf" "Download Report";
PROC PRINT DATA=Results_Tab_2(WHERE=(_TYPE_=1)) NOOBS LABEL;
	VAR Print_Link N M_Res N_Fail P_Fail;
RUN;

