Example 13.1  Sample SAS Report Code

%* Sales Report Example - Display Product by Region;
%macro salesrpt;
%global region;
proc report data=sashelp.shoes nowd;
by region;
%if (&region ne ) %then %do;
where region="&region";
%end;
title "Sales by Product";
footnote "Data are current as of &systime &sysdate9";
column product sales;
define product / group;
define sales / analysis sum;
quit;
%mend salesrpt;

%salesrpt

