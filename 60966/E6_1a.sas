* E6_1a.sas
*
* Chapter 6 Exercise 1
*
* Use aliases for statistics;
* ;

title1 'Yearly Statistics';
title2 'Based on Quarterly Sales';
proc report data=sashelp.retail nowd split='*';
   column year sales sales=s_mean sales=s_n sales=s_se;
   define year   / group;
   define sales  / sum    'Total*Sales';
   define s_mean / mean   'Average*Sales';
   define s_n    / n      'Quarters' f=8.;
   define s_se   / stderr 'Standard*Error'; 
   run;
