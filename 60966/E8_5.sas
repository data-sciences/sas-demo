* E8_5.sas
*
* Chapter 8 Exercise 5
*
* Use TITLE and FOOTNOTE options.;

ods html style=default
         path="&path\results"
         body='E8_5.html';

title1 c=red h=2'Total profit per year';
title2 c=blue j=l 'Separated by' j=r color=green 'Product Line';
title3 f='times new roman' h=2 'Profit' h=4 ' Summaries';

proc report data=sashelp.orsales nowd split='*';
   column year product_line profit;
   define year   / group;
   define product_line 
                 / group 
                   'Product*Groups';
   define profit / analysis 
                   sum format=dollar15.2
                   'Annual*Profit';
   break after year / summarize suppress skip;
   rbreak after / summarize;
   run;
ods _all_ close;
