* E8_0Basic.sas
*
* Chapter 8 Exercise Basic program
*
* Total profit for each year within Product line.;

title1 'Total profit per year';
title2 'Separated by Product Line';
title3 'Profit Summaries';
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
