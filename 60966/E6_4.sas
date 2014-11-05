* E6_4.sas
*
* Chapter 6 Exercise 4
*
* Profit for Product lines and category by year;
* ;

options nobyline;
title1 'Total Profit';
title2 '#byval1';

proc report data=sashelp.orsales nowd split='*';
   by year;
   column product_line product_category profit;
   define product_line 
                 / group 
                   'Product*Groups';
   define product_category
                 / group 
                   'Product*Category';
   define profit / analysis 
                   sum format=dollar15.2
                   'Profit';
   run;
