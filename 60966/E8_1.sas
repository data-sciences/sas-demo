* E8_1.sas
*
* Chapter 8 Exercise 1
*
* Total profit for each year within Product line.;

options center;
ods listing close;

ods html style=default
         path="&path\results"
         body='E8_1.html';

title1 'Total profit per year';
title2 'Separated by Product Line';
title3 'Profit Summaries';
proc report data=sashelp.orsales nowd split='*'
      style(header)={background=white}
      style(column)={background=pink};
   column year product_line profit;
   define year   / group 
                   style(header)={background=yellow}
                   style(column)={background=cyan};
   define product_line 
                 / group 
                   'Product*Groups';
   define profit / analysis 
                   sum format=dollar15.2
                   'Annual*Profit';
   break after year / summarize suppress skip
                      style(summary)={background=green};
   rbreak after / summarize
                      style(summary)={background=red};
   run;
ods _all_ close;
