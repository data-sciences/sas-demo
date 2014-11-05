* E6_2.sas
*
* Chapter 6 Exercise 2
*
* Use aliases for statistics;
* ;

title1 'Quarterly Sales';
proc report data=sashelp.retail nowd;
   column year date,sales;
   define year   / group;
   define date   / across f=qtr.;
   define sales  / sum;
   run;
