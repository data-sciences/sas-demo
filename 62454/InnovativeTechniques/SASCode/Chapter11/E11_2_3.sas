*E11_2_3.sas
*
* Showing Styles in Excel;
title1 '11.2.3 Showing Style in Excel';

%macro showstyles;
%local i stylecnt;
proc sql noprint;
   select scan(style,2,'.')
      into: style1-:style&sysmaxlong
         from sashelp.vstyle;
   %let stylecnt = &sqlobs;
   quit;

%do i = 1 %to &stylecnt; 
   ods markup tagset=excelxp
         path="&path\results"
         file="&&style&i...xml"
         style=&&style&i
         options(sheet_name="&&style&i"
         embedded_titles='yes');
 
      title2 "Using the &&style&i Style";
      proc report data=sashelp.class nowd;
         column name sex age height weight;
         define age    / analysis mean f=4.1;
         define height / analysis mean f=4.1;
         define weight / analysis mean f=5.1;
         rbreak after /summarize;
         run;
   ods markup close;
%end;
%mend showstyles;
ods listing close;

%showstyles

ods listing;
