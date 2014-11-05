* E6_1b.sas
*
* Chapter 6 Exercise 1
*
* Use aliases for statistics;
* ;

title1 'Yearly Statistics';
title2 'Based on Quarterly Sales';
proc report data=sashelp.retail nowd split='*';
   column year sales,(sum mean n stderr);
   define year   / group;
   define sum    /  'Total*Sales';
   define mean   /  'Average*Sales';
   define n      /  'Quarters' f=8.;
   define stderr /  'Standard*Error'; 
   run;
