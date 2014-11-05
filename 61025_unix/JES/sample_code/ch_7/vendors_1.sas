
/*=== JES\sample_code\ch_7\vendors_1.sas ===*/
TITLE1 "Resistance Data by Vendor - 4Q 2008";
PROC PRINT DATA=JES.Results_Tab_2(WHERE=(_TYPE_=1)) NOOBS LABEL;
	VAR Vendor N M_Res N_Fail P_Fail;
RUN;



