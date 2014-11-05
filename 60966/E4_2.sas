* E4_2.sas
*
* Chapter 4 Exercise 2
*
* Creating panels;

title1 'Quarterly Retail Sales';
title2 'Creating Multiple Panels';
proc report data=sashelp.retail 
            nowd panels=99 box pspace=10;
   column year date sales;
   define year / group;
   define date / display; 
   define sales/ analysis;
   run;
