* E4_3.sas
*
* Chapter 4 Exercise 3
*
* Other DEFINE statement options;

title1 'Quarterly Retail Sales';
title2 'Creating Multiple Panels';
title3 'Using DEFINE Statement Options';
proc report data=sashelp.retail 
            nowd panels=99 box pspace=10;
   column year date sales;
   define year / group width=4;
   define date / display spacing=7; 
   define sales/ analysis width=8;
   run;
