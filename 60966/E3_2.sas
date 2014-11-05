* E3_2.sas
*
* Chapter 3 Exercise 2
*
* Calculating Statistics;

title1 'Quarterly Retail Sales';
title2 'Quarterly Sales Statistics';
proc report data=sashelp.retail nowd;
   column year sales,(n mean std);
   define year / group width=4;
   define sales/ analysis;
   format sales;
   run;
