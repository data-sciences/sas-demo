* E6_3.sas
*
* Chapter 6 Exercise 3
*
* Quarterly Sales Totals;
* ;

title1 'Quarterly Sales';
proc report data=sashelp.retail nowd;
   column year date,sales;
   define year   / group;
   define date   / across f=qtr. '- Quarter -';
   define sales  / sum 'Sales';
   run;
