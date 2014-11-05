* E2_2b.sas
*
* Chapter 2 Exercise 2b
*
* Total profit for each year within Product line;

title1 'Total profit per year';
title2 'Separated by Product Line';
proc report data=sashelp.orsales nowd;
   column year product_line,profit;
   define year / group;
   define product_line / across ;
   define profit / analysis sum format=dollar15.2;
   run;
