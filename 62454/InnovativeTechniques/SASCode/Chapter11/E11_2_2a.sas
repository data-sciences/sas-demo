*E11_2_2.sas
*
* Using the EXCELXP Tagset to create multi-sheets;
title1 '11.2.2a Creating Multiple Sheets';
title2 "Using the ExcelXP Tagset";
ods listing close;
%macro multisheet(dsn=,bylist=);
ods tagsets.excelxp
           style=default
           path="&path\results"
           body="E11_2_2a.xls"
           options(sheet_name='none' 
                   sheet_interval='bygroup'
                   embedded_titles='no');

proc sort data=&dsn out=sorted;
   by &bylist;
proc print data=sorted;
   by &bylist;
   run;
ods tagsets.excelxp close;
%mend multisheet;
%multisheet(dsn=advrpt.demog,bylist=race)
ods listing;
