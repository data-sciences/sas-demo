* E2_3.sas
*
* Chapter 2 Exercise 3
*
* Total profit for each Product line within year;

proc format;
   value $sequip
      'Sports' = 'Sports Equipment';
   run;

title1 'Total profit per year';
title2 'Separated by Product Line';
proc report data=sashelp.orsales nowd split='*';
   column year product_line profit;
   define year   / group;
   define product_line 
                 / group 
                   f=$sequip.
                   'Product*Groups';
   define profit / analysis 
                   sum format=dollar15.2
                   'Annual*Profit';
   compute after year;
      line ' ';
   endcomp;
   compute after;
      line @25 'Profits in US dollars';
   endcomp;
   run;
