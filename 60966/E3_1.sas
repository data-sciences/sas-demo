* E3_1.sas
*
* Chapter 3 Exercise 1
*
* Total profit for each year within Product line
* Using the BREAK and RBREAK statements.;

ods pdf style=journal
        file="&path\results\e3_1.pdf";

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

   break after year / summarize suppress ol skip;
   rbreak after     / summarize dol skip;

   compute after;
      line @25 'Profits in US dollars';
   endcomp;
   run;
ods pdf close;
