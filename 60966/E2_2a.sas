* E2_2a.sas
*
* Chapter 2 Exercise 2a
*
* Total profit for each year within Product line;

title1 'Total profit per year';
title2 'Separated by Product Line';
proc report data=sashelp.orsales nowd;
   column year product_line profit;
   define year / group;
   define product_line / group ;
   define profit / analysis sum format=dollar15.2;
   run;
